create or replace package body sct_admin 
as

  /* KONSTANTEN siehe SCT_CONST */
  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;
  
  /* Globale Variablen */
  g_firing_item varchar2(30 byte);
  type id_map_t is table of binary_integer index by binary_integer;
  g_id_map id_map_t;
  

  /* HILFSFUNKTIONEN */
  /* Hilfsfunktion zum Analysieren der Regeln
   * %param p_sgr_id Statusgruppen-ID
   * %usage Wird aufgerufen, um die Bildung einer Analyse-View vorzubereiten
   *        Zu einer Regel werden alle Bedingungen gegen das aktuelle
   *        APEX-Dictionary geprueft. Elemente, die in den Bedingungen enthalten
   *        sind, werden in Tabelle SCT_PAGE_ITEM eingetragen und dienen als 
   *        Grundlage fuer die Erstellung der Analyse-View.
   *        - Flag IS_REQUIRED zeigt Elemente and, die in den Regeln referenziert werden
   *        - CONVERSION uebertraegt Formatangaben der Anwendung in Konvertierungsfunktion
   */
  procedure harmonize_sct_page_item(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    pit.enter_optional('harmonize_sct_page_item', c_pkg);
    
    -- Required-Flag der Gruppe zuruecksetzen
    update sct_page_item
       set spi_is_required = sct_const.c_false
     where spi_sgr_id = p_sgr_id;
     
    -- Elemente aus APEX lesen und lokal eintragen
    merge into sct_page_item spi
    using (select distinct 
                  spt.target_name spi_id,
                  spt.target_type spi_sit_id,
                  sgr.sgr_id spi_sgr_id,
                  spt.spi_conversion, 
                  case 
                  when sru.sru_id is null then sct_const.c_false 
                  else sct_const.c_true end spi_is_required
             from sct_bl_page_targets spt
             join sct_group sgr
               on spt.application_id = sgr.sgr_app_id
              and spt.page_id = sgr.sgr_page_id
             left join sct_rule sru
               on regexp_instr(upper(sru.sru_condition), replace(sct_const.c_regex_item, '#ITEM#', spt.target_name)) > 0
              and sgr.sgr_id = sru.sru_sgr_id
            where sgr.sgr_id = p_sgr_id) v
       on (spi.spi_id = v.spi_id and spi.spi_sgr_id = v.spi_sgr_id)
     when matched then update set
          spi.spi_sit_id = v.spi_sit_id,
          spi.spi_conversion = v.spi_conversion,
          spi.spi_is_required = v.spi_is_required
     when not matched then insert (spi_id, spi_sit_id, spi_sgr_id, spi_conversion, spi_is_required)
          values (v.spi_id, v.spi_sit_id, v.spi_sgr_id, v.spi_conversion, v.spi_is_required);
          
    -- Ueberzaehlige Elemente entfernen
    delete from sct_page_item
     where spi_id not in (
           select spt.target_name
             from sct_bl_page_targets spt
             join sct_group sgr
               on spt.application_id = sgr.sgr_app_id
              and spt.page_id = sgr.sgr_page_id);
    
    pit.leave_optional;
  end harmonize_sct_page_item;
  
  
  /* Hilfsfunktion zum Aktualisieren der Regelereignisse
   * %param p_sgr_id ID der Regelgruppe
   * %usage Wird aufgerufen, wenn eine Regel veraendert wurde.
   *        Regeln reagieren nur, wenn das triggernde Element in der Liste
   *        der Elemente innerhalb der einzelnen Regel referenziert wird.
   *        Dazu stellt diese Prozedur eine Liste der Elemente dieser Bedingung
   *        zusammen und speichert sie in SCT_RULE.SRU_FIRING_ITEMS
   */
  procedure harmonize_rule_event_filter(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    pit.enter_optional('harmonize_rule_event_filter', c_pkg);
    
    /* TODO: Pruefen, ob eine Tabelle SCT_RULE_FIRING_ITEMS nicht die bessere Loesung waere */
    merge into sct_rule sru
    using (select sru.sru_id, 
                  listagg(spt.target_name, ':') within group (order by spt.target_name) sru_firing_items
             from sct_bl_page_targets spt
             join sct_group sgr
               on spt.application_id = sgr.sgr_app_id
              and spt.page_id = sgr.sgr_page_id
             join sct_rule sru
               on regexp_instr(upper(sru.sru_condition), replace(sct_const.c_regex_item, '#ITEM#', spt.target_name)) > 0
            where sgr.sgr_id = p_sgr_id
            group by sru.sru_id) v
       on (sru.sru_id = v.sru_id)
     when matched then update set
          sru.sru_firing_items = v.sru_firing_items;
    
    pit.leave_optional;
  end harmonize_rule_event_filter;
  
  
  /* Prozedur loescht Regelviews von nicht mehr existierenden Regeln
   * %usage Wird im Rahmen der Aktualisierung von Regeln oder Regelgruppen aufgerufen
   */
  procedure delete_pending_rule_views
  as
    cursor pending_views_cur is
      select view_name
        from user_views
       where view_name like sct_const.c_view_name_prefix || '%'
         and view_name not in (
             select sct_const.c_view_name_prefix || sgr_id
               from sct_group);
  begin
    pit.enter_detailed('delete_pending_rule_views', c_pkg);
    
    for vw in pending_views_cur loop
      execute immediate 'drop view ' || vw.view_name;
    end loop;
    
    pit.leave_detailed;
  end delete_pending_rule_views;
  
  
  /* Funktion erzeugt Spaltenliste fuer eine Regelview
   * %param p_sgr_id ID der Regelgruppe, fuer die die Regelview erstellt werden soll
   * %return Ausriss aus der SELECT-Klausel der Regelview
   * %usage Wird beim Erstellen oder Editieren einer Regel aufgerufen
   */
  function create_column_list(
    p_sgr_id in sct_group.sgr_id%type)
    return varchar2
  as
    cursor column_cur(p_sgr_id in sct_group.sgr_id%type) is
      select spi_id, sit_id, spi_conversion, row_number() over (order by spi_id) sort_seq
        from sct_page_item spi
        join sct_page_item_type sit
          on spi.spi_sit_id = sit.sit_id
       where spi_sgr_id = p_sgr_id
         and spi_is_required = sct_const.c_true
       order by spi_id;
    l_data_cols varchar2(32767);
  begin
    pit.enter_detailed('create_column_list', c_pkg);
    
    for spi in column_cur(p_sgr_id) loop
      if spi.sort_seq > 1 then 
        l_data_cols := l_data_cols || sct_const.c_column_delimiter;
      end if;
      l_data_cols :=
        l_data_cols ||
          utl_text.bulk_replace(
            case spi.sit_id
            when 'BUTTON' then sct_const.c_button_col_template
            else sct_const.c_item_col_template end,
            char_table(
              '#CONVERSION#', spi.spi_conversion,
              '#ITEM#', spi.spi_id));
    end loop;
    
    pit.leave_detailed;
    return l_data_cols;
  end create_column_list;
  
  
  /* Funktion erzeugt die WHERE-Klausel fuer eine Regelview
   * %param p_sgr_id ID der Regelgruppe, fuer die die Regelview erstellt werden soll
   * %return Ausriss aus der WHERE-Klausel der Regelview
   * %usage Wird beim Erstellen oder Editieren einer Regel aufgerufen
   */
  function create_where_clause(
    p_sgr_id in sct_group.sgr_id%type)
    return varchar2
  as
    cursor rule_cur (p_sgr_id in sct_group.sgr_id%type) is
      select sru_id, sru_name, sru_condition, sru_firing_items,
             row_number() over (order by sru_id) sort_seq
        from sct_rule
       where sru_sgr_id = p_sgr_id
       order by sru_id;
    l_where_clause varchar2(32767);
  begin
    pit.enter_detailed('create_where_clause', c_pkg);
    
    for sru in rule_cur(p_sgr_id) loop
      if sru.sort_seq > 1 then 
        l_where_clause := l_where_clause || sct_const.c_join_delimiter;
      end if;
      l_where_clause :=
        l_where_clause ||
          utl_text.bulk_replace(sct_const.c_join_clause_template, char_table(
            '#ID#', sru.sru_id,
            '#CONDITION#', sru.sru_condition));
    end loop;
    
    pit.leave_detailed;
    return l_where_clause;
  end create_where_clause;


  /* Methode zur Erzegung der Regelview fuer eine Regelgruppe
   * %param p_sgr_id ID der Regelgruppe, fuer die eine Regeview angelegt werden soll
   * %usage Wird intern aufgerufen, um die Metadaten einer Regelgruppe zu einer Regelview
   *        zusammenzufassen.
   *        Eine Regelview stellt alle relevanten Seitenelemente einer Regelgruppe
   *        in einer Unterabfrage als Spalten zur Verfuegung. Die in den Einzelregeln
   *        hinterlegten Bedingungen werden, zusammen mit der Regel-ID, als Zweige
   *        der WHERE-Klausel eingefuegt.
   *        Zudem wird ein Filter integriert, der eine Regel nur dann beruecksichtigt,
   *        wenn das feuernde Element in der Regel angesprochen wird.
   */
  procedure create_rule_view(
    p_sgr_id in sct_group.sgr_id%type)
  as    
    l_view_name varchar2(30 byte);
    l_data_cols varchar2(32767);
    l_where_clause varchar2(32767);
    l_stmt varchar2(32767);
  begin
    pit.enter_optional('create_rule_view', c_pkg);
    
    delete_pending_rule_views;
    l_view_name := sct_const.c_view_name_prefix || p_sgr_id;
    l_data_cols := create_column_list(p_sgr_id);
    l_where_clause := create_where_clause(p_sgr_id);
    
    -- Erzeuge die Regelview
    l_stmt := utl_text.bulk_replace(sct_const.c_create_view_template || sct_const.c_rule_view_template, char_table(
                '#NAME#', l_view_name,
                '#DATA_COLS#', l_data_cols,
                '#WHERE_CLAUSE#', l_where_clause,
                '#SGR_ID#', p_sgr_id));
    execute immediate l_stmt;
    
    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.SCT_VIEW_CREATION, msg_args(sqlerrm, l_stmt));
  end create_rule_view;
  

  /* INTERFACE */  
  function get_view_name(
    p_sgr_id sct_group.sgr_id%type)
    return varchar2
  as
  begin
    return sct_const.c_view_name_prefix || p_sgr_id;
  end get_view_name;
  
  
  function get_js_function
    return varchar2
  as
  begin
    return sct_const.c_js_function;
  end get_js_function;
  
  
  function get_js_namespace
    return varchar2
  as
  begin
    return sct_const.c_js_namespace;
  end get_js_namespace;
  
  
  function get_firing_item
    return varchar2
  as
  begin
    return g_firing_item;
  end get_firing_item;
  
  
  procedure create_action(
    p_sgr_id in sct_group.sgr_id%type,
    p_firing_item in varchar2,
    p_plsql_action out nocopy varchar2,
    p_js_action out nocopy varchar2)
  as
    type rule_rec is record(
      sru_id sct_rule.sru_id%type,
      sru_sort_seq sct_rule.sru_sort_seq%type,
      sru_name sct_rule.sru_name%type,
      item sct_page_item.spi_id%type,
      pl_sql sct_action_type.sat_pl_sql%type,
      js sct_action_type.sat_js%type,
      attribute sct_rule_action.sra_attribute%type
    );
    l_rule rule_rec;    
    l_action_cur sys_refcursor;
    
    l_stmt varchar2(32767);
    l_pl_sql_code varchar2(32767);
    l_js_code varchar2(32767);
  begin
    pit.enter_mandatory('create_action', c_pkg);
    g_firing_item := p_firing_item;
    l_stmt := replace(sct_const.c_stmt_template, '#RULE_VIEW#', get_view_name(p_sgr_id));
    
    -- Explizite Cursorkontrolle wegen dynamischen SQLs
    open l_action_cur for l_stmt;
    fetch l_action_cur into l_rule;
    while l_action_cur%FOUND loop
      -- Baue PL/SQL-Code zusammen
      if l_rule.pl_sql is not null then
        l_pl_sql_code := utl_text.bulk_replace(l_pl_sql_code || sct_const.c_plsql_template, char_table(
           '#PLSQL#', l_rule.pl_sql,
           '#ATTRIBUTE#', l_rule.attribute,
           '#ITEM#', l_rule.item));
        utl_text.append(l_pl_sql_code, sct_const.c_cr || '  ', null, sct_const.c_true);
      end if;
      
      -- Baue JavaScript-Code zusammen
      if l_rule.js is not null then
        l_js_code := utl_text.bulk_replace(l_js_code || sct_const.c_js_template, char_table(
          '#SCRIPT#', l_rule.js,
          '#JS_FILE#', sct_const.c_js_namespace,
          '#ITEM#', l_rule.item,
          '#ATTRIBUTE#', apex_escape.js_literal(l_rule.attribute)));
        utl_text.append(l_js_code, sct_const.c_cr || '  ', null, sct_const.c_true);
      end if;
      fetch l_action_cur into l_rule;
    end loop;
    close l_action_cur;
    
    -- Uebernehme Codes in entsprechende Ausgabeparameter
    p_plsql_action := replace(sct_const.c_plsql_action_template, '#CODE#', coalesce(l_pl_sql_code, sct_const.c_null));

    p_js_action := 
      utl_text.bulk_replace(sct_const.c_js_action_template, char_table(
        '#SRU_SORT_SEQ#', l_rule.sru_sort_seq,
        '#SRU_NAME#', l_rule.sru_name,
        '#CODE#', l_js_code,
        '#JS_FILE#', sct_const.c_js_namespace));
    
    pit.leave_mandatory;
  end create_action;
  
    
  procedure merge_rule_group(
    p_sgr_app_id in sct_group.sgr_app_id%type,
    p_sgr_page_id in sct_group.sgr_page_id%type,
    p_sgr_id in sct_group.sgr_id%type default null,
    p_sgr_name in sct_group.sgr_name%type,
    p_sgr_description in sct_group.sgr_description%type)
  as
    l_sgr_id sct_group.sgr_id%type;
  begin
    pit.enter_mandatory('merge_rule_group', c_pkg);
    
    l_sgr_id := coalesce(p_sgr_id, sct_seq.nextval);
    merge into sct_group s
    using (select l_sgr_id sgr_id,
                  p_sgr_name sgr_name,
                  p_sgr_description sgr_description,
                  p_sgr_app_id sgr_app_id,
                  p_sgr_page_id sgr_page_id
             from dual) v
       on (s.sgr_id = v.sgr_id)
     when matched then update set
          sgr_name = v.sgr_name,
          sgr_description = v.sgr_description,
          sgr_page_id = v.sgr_page_id
     when not matched then insert(sgr_id, sgr_name, sgr_description, sgr_app_id, sgr_page_id)
          values(v.sgr_id, v.sgr_name, v.sgr_description, v.sgr_app_id, v.sgr_page_id);
    
    pit.leave_mandatory;
  end merge_rule_group;
    
  
  procedure delete_rule_group(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('delete_rule_group', c_pkg);
    
    delete from sct_group
     where sgr_id = p_sgr_id;
    
    execute immediate 'drop view ' || sct_const.c_view_name_prefix || p_sgr_id;
    
    pit.leave_mandatory;
  end delete_rule_group;
  
  
  procedure resequence_rule_group(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('resequence_rule_group', c_pkg);
    
    merge into sct_rule sru
    using (select sru_id, sru_sgr_id, 
                  row_number() over (partition by sru_sgr_id order by sru_sort_seq) * 10 sru_sort_seq
             from sct_rule
            where sru_sgr_id = p_sgr_id) v
       on (sru.sru_id = v.sru_id and sru.sru_sgr_id = v.sru_sgr_id)
     when matched then update set
          sru_sort_seq = v.sru_sort_seq;
          
    merge into sct_rule_action sra
    using (select rowid row_id, 
                  row_number() over (partition by sra_sru_id order by sra_sort_seq) * 10 sra_sort_seq
             from sct_rule_action
            where sra_sgr_id = p_sgr_id) v
       on (sra.rowid = v.row_id)
     when matched then update set
          sra_sort_seq = v.sra_sort_seq;
    commit;
    
    pit.leave_mandatory;
  end resequence_rule_group;
  
  
  procedure copy_rule_group(
    p_sgr_id in sct_group.sgr_id%type,
    p_sgr_app_id sct_group.sgr_app_id%type,
    p_sgr_page_id sct_group.sgr_page_id%type)
  as
    l_sct_group sct_group%rowtype;
    l_old_page_id number;
    l_app_exists number;
  begin
    pit.enter_mandatory('copy_rule_group', c_pkg);
    
    pit.assert_exists(
      'select 1 from apex_applications where application_id = ' || p_sgr_app_id,
      msg.SCT_APP_DOES_NOT_EXIST, msg_args(to_char(p_sgr_app_id)));
    pit.assert_exists(
      'select 1 from apex_application_pages ' || 
      ' where application_id = ' || p_sgr_app_id ||
      '   and page_id = ' || p_sgr_page_id, 
      msg.SCT_PAGE_DOES_NOT_EXIST, msg_args(to_char(p_sgr_page_id), to_char(p_sgr_app_id)));
      
    select *
      into l_sct_group
      from sct_group
     where sgr_id = p_sgr_id;
    
    l_old_page_id := l_sct_group.sgr_page_id;
    l_sct_group.sgr_app_id := p_sgr_app_id;
    l_sct_group.sgr_page_id := coalesce(p_sgr_page_id, l_sct_group.sgr_page_id);    
    l_sct_group.sgr_id := sct_seq.nextval;
    
    insert into sct_group
    values l_sct_group;
    
    insert into sct_rule(sru_id, sru_sgr_id, sru_name, sru_condition, sru_sort_seq)
    select sct_seq.nextval,
           l_sct_group.sgr_id, 
           sru_name, 
           replace(upper(sru_condition), 'P' || l_old_page_id || '_',  'P' || l_sct_group.sgr_page_id || '_'),
           sru_sort_seq
      from sct_rule;
      
    propagate_rule_change(p_sgr_id);
    
    pit.leave_mandatory;
  end copy_rule_group;
  
  
  procedure export_rule_group(
    p_sgr_id in sct_group.sgr_id%type default null)
  as
    cursor action_type_cur is
      select sat_id, sat_name, sat_pl_sql, sat_js, sat_changes_value
        from sct_action_type;
        
    cursor group_cur(p_sgr_id in sct_group.sgr_id%type) is
      select sgr_id, sgr_name, sgr_description, sgr_app_id, sgr_page_id
        from sct_group sgr
       where sgr_id = p_sgr_id or p_sgr_id is null;
    
    cursor rule_cur(p_sgr_id in sct_group.sgr_id%type) is
      select sru_id, sru_sgr_id, sru_name, sru_condition, sru_sort_seq, sru_firing_items
        from sct_rule sru
       where sru.sru_sgr_id = p_sgr_id;
       
    cursor action_cur(p_sru_id in sct_rule.sru_id%type, p_sgr_id in sct_group.sgr_id%type) is
      select sra_sru_id, sra_sgr_id, sra_spi_id, sra_sat_id, sra_attribute, sra_sort_seq
        from sct_rule_action sra
       where sra.sra_sru_id = p_sru_id
         and sra.sra_sgr_id = p_sgr_id;
    l_stmt clob;
    l_action_type clob;
    l_group clob;
    l_rule clob;
    l_rule_action clob;
    l_file_name varchar2(100);
  begin
    pit.enter_mandatory('export_rule_group', c_pkg);
    
    -- Initialisierung
    dbms_lob.createtemporary(l_stmt, false, dbms_lob.call);
    dbms_lob.createtemporary(l_action_type, false, dbms_lob.call);
    dbms_lob.createtemporary(l_group, false, dbms_lob.call);
    dbms_lob.createtemporary(l_rule, false, dbms_lob.call);
    dbms_lob.createtemporary(l_rule_action, false, dbms_lob.call);
    
    -- Exportiere Aktionstypen
    for sat in action_type_cur loop
      dbms_lob.append(
        l_action_type, 
        utl_text.bulk_replace(sct_const.c_action_type_template, char_table(
          '#SAT_ID#', sat.sat_id,
          '#SAT_NAME#', sat.sat_name, 
          '#SAT_PL_SQL#', sat.sat_pl_sql,
          '#SAT_JS#', sat.sat_js,
          '#SAT_CHANGES_VALUE#', sat.sat_changes_value)));
    end loop;
    
    /* Geschachtelte CURSOR-FOR-LOOPS asntelle Cursor-Ausdruck, weil:
       - einfacherer Code
       - kein Nebenlaeufigkeitsproblem (Stammdaten)
       - kein Performanzproblem
       - deutlich weniger Variablen (%ROWTYPE unetrstuetzt keine CURSOR-Ausdruecke)
     */
    for sgr in group_cur(p_sgr_id) loop
      -- Entweder nur fuer eine oder alle SCT_GROUPs
      dbms_lob.append(
        l_group, 
        utl_text.bulk_replace(sct_const.c_group_template, char_table(
          '#SGR_APP_ID#', to_char(sgr.sgr_app_id),
          '#SGR_PAGE_ID#', to_char(sgr.sgr_page_id),
          '#SGR_ID#', to_char(sgr.sgr_id),
          '#SGR_NAME#', sgr.sgr_name,
          '#SGR_DESCRIPTION#', sgr.sgr_description)));
      for sru in rule_cur(sgr.sgr_id) loop
        dbms_lob.append(
          l_rule, 
          utl_text.bulk_replace(sct_const.c_rule_template, char_table(
            '#SRU_ID#', to_char(sru.sru_id),
            '#SGR_ID#', to_char(sru.sru_sgr_id),
            '#SRU_NAME#', sru.sru_name,
            '#SRU_CONDITION#', sru.sru_condition,
            '#SRU_SORT_SEQ#', to_char(sru.sru_sort_seq))));
        for sra in action_cur(sru.sru_id, sru.sru_sgr_id) loop
          dbms_lob.append(
            l_rule_action, 
            utl_text.bulk_replace(sct_const.c_rule_action_template, char_table(
              '#SRU_ID#', to_char(sra.sra_sru_id),
              '#SGR_ID#', to_char(sra.sra_sgr_id),
              '#SPI_ID#', sra.sra_spi_id,
              '#SAT_ID#', sra.sra_sat_id,
              '#SRA_ATTRIBUTE#', sra.sra_attribute,
              '#SRA_SORT_SEQ#', to_char(sra.sra_sort_seq))));
        end loop;
      end loop;
      -- Bei Ersetzungspatterns keine tatsaechlichen Absatzzeichen einbauen,
      -- da Installationsskripte ansonsten commit, end etc. als Kommando ausfuehren
      dbms_lob.append(l_stmt, replace('declare~  l_foo binary_integer;~begin~  l_foo := sct_admin.map_id;~~  -- ACTION TYPES', '~', sct_const.c_cr));
      dbms_lob.append(l_stmt, l_action_type);
      dbms_lob.append(l_stmt, replace('~  -- RULE GROUPS', '~', sct_const.c_cr));
      dbms_lob.append(l_stmt, l_group);
      dbms_lob.append(l_stmt, replace('~  -- RULES', '~', sct_const.c_cr));
      dbms_lob.append(l_stmt, l_rule);
      dbms_lob.append(l_stmt, replace('~  -- RULE ACTIONS', '~', sct_const.c_cr));
      dbms_lob.append(l_stmt, l_rule_action);
      dbms_lob.append(l_stmt, replace('~  commit;~end;~/', '~', sct_const.c_cr));
      
      -- Dateiname erzeugen und Datei schreiben
      l_file_name := 'SCT_GROUP_' || sgr.sgr_id || '.sql';
      dbms_xslprocessor.clob2file(l_stmt, sct_const.c_directory, l_file_name);
      l_stmt := null;
    end loop;
    
    pit.leave_mandatory;
  end export_rule_group;
  
  
  function map_id(
    p_id in number default null)
    return number
  as
    l_new_id binary_integer;
  begin
    pit.enter_detailed('map_id', c_pkg);
    
    if p_id is null then
      g_id_map.delete;
    else
      if not g_id_map.exists(p_id) then
        g_id_map(p_id) := sct_seq.nextval;
      end if;
      l_new_id := g_id_map(p_id);
    end if;
    
    pit.leave_detailed;
    return l_new_id;
  end map_id;
  
  
  procedure merge_rule(
    p_sru_id in sct_rule.sru_id%type default null,
    p_sru_sgr_id in sct_group.sgr_id%type,
    p_sru_name in sct_rule.sru_name%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_sru_sort_seq in sct_rule.sru_sort_seq%type)
  as
  begin
    pit.enter_mandatory('merge_rule', c_pkg);
    
    merge into sct_rule sru
    using (select p_sru_id sru_id,
                  p_sru_sgr_id sru_sgr_id,
                  p_sru_name sru_name,
                  p_sru_condition sru_condition,
                  p_sru_sort_seq sru_sort_seq
             from dual) v
       on (sru.sru_id = v.sru_id
       and sru.sru_sgr_id = v.sru_sgr_id)
     when matched then update set
          sru_name = v.sru_name,
          sru_condition = v.sru_condition,
          sru_sort_seq = v.sru_sort_seq
     when not matched then insert(sru_id, sru_sgr_id, sru_name, sru_condition, sru_sort_seq)
          values(v.sru_id, v.sru_sgr_id, v.sru_name, v.sru_condition, v.sru_sort_seq);
    
    propagate_rule_change(p_sru_sgr_id);
    
    pit.leave_mandatory;
  end merge_rule;
  
  
  procedure propagate_rule_change(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('propagate_rule_change', c_pkg);
    
    harmonize_sct_page_item(p_sgr_id);
    harmonize_rule_event_filter(p_sgr_id);
    create_rule_view(p_sgr_id);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.stop(msg.SQL_ERROR, msg_args(sqlerrm));
  end propagate_rule_change;
  
  
  procedure validate_rule(
    p_sgr_id in sct_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2)
  as
    cursor item_cur(p_sgr_id in sct_group.sgr_id%type) is
      select spi_id, row_number() over (order by spi_id) row_num, count(*) over () amount
        from sct_page_item
       where spi_sgr_id = p_sgr_id;

    l_data_cols varchar2(32767);
    l_stmt varchar2(32767);
    l_ctx pls_integer;
  begin 
    pit.enter_mandatory('validate_rule', c_pkg);
    
    l_data_cols := create_column_list(p_sgr_id);
    l_stmt := utl_text.bulk_replace(sct_const.c_rule_validation_template, char_table(
      '#DATA_COLS#', l_data_cols,
      '#CONDITION#', p_sru_condition));
    l_ctx := dbms_sql.open_cursor;
    dbms_sql.parse(l_ctx, l_stmt, dbms_sql.native);
    dbms_sql.close_cursor(l_ctx);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.stop(msg.SCT_RULE_VALIDATION, msg_args(p_sru_condition, sqlerrm));
  end validate_rule;
  
  
  procedure merge_rule_action(
    p_sra_sru_id in sct_rule.sru_id%type,
    p_sra_sgr_id in sct_group.sgr_id%type,
    p_sra_spi_id in sct_page_item.spi_id%type,
    p_sra_sat_id in sct_action_type.sat_id%type,
    p_sra_attribute in sct_rule_action.sra_attribute%type,
    p_sra_sort_seq in sct_rule_action.sra_sort_seq%type)
  as
  begin
    pit.enter_mandatory('merge_rule_action', c_pkg);
    
    merge into sct_rule_action sra
    using (select p_sra_sru_id sra_sru_id,
                  p_sra_sgr_id sra_sgr_id,
                  p_sra_spi_id sra_spi_id,
                  p_sra_sat_id sra_sat_id,
                  p_sra_attribute sra_attribute,
                  p_sra_sort_seq sra_sort_seq
             from dual) v
       on (sra.sra_sru_id = v.sra_sru_id
      and sra.sra_sgr_id = v.sra_sgr_id
      and sra.sra_spi_id = v.sra_spi_id
      and sra.sra_sat_id = v.sra_sat_id)
     when matched then update set
          sra_attribute = v.sra_attribute,
          sra_sort_seq = v.sra_sort_seq
     when not matched then insert(sra_sru_id, sra_sgr_id, sra_spi_id, sra_sat_id, sra_attribute, sra_sort_seq)
          values(v.sra_sru_id, v.sra_sgr_id, v.sra_spi_id, v.sra_sat_id, v.sra_attribute, v.sra_sort_seq);
    
    pit.leave_mandatory;
  end merge_rule_action;
  
  
  procedure merge_action_type(
    p_sat_id in sct_action_type.sat_id%type,
    p_sat_name in sct_action_type.sat_name%type,
    p_sat_pl_sql in sct_action_type.sat_pl_sql%type,
    p_sat_js in sct_action_type.sat_js%type,
    p_sat_changes_value in sct_action_type.sat_changes_value%type)
  as
  begin
    pit.enter_mandatory('merge_action_type', c_pkg);
    
    merge into sct_action_type sat
    using (select p_sat_id sat_id,
                  p_sat_name sat_name,
                  p_sat_pl_sql sat_pl_sql,
                  p_sat_js sat_js,
                  p_sat_changes_value sat_changes_value
             from dual) v
       on (sat.sat_id = v.sat_id)
     when matched then update set
          sat_name = v.sat_name,
          sat_pl_sql = v.sat_pl_sql,
          sat_js = v.sat_js,
          sat_changes_value = v.sat_changes_value
     when not matched then insert(sat_id, sat_name, sat_pl_sql, sat_js, sat_changes_value)
          values(v.sat_id, v.sat_name, v.sat_pl_sql, v.sat_js, v.sat_changes_value);
    
    pit.leave_mandatory;
  end merge_action_type;
  
end sct_admin;
/
