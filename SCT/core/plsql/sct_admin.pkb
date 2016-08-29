create or replace package body sct_admin 
as

  /* KONSTANTEN */
  c_cr constant varchar2(2 byte) := chr(10);
  c_true constant char(1 byte) := 'Y';
  c_false constant char(1 byte) := 'N';
  c_view_name_prefix constant varchar2(25) := 'SCT_RULES_GROUP_';
  c_js_function constant varchar2(50) := 'de_condes_plugin_sct';
  c_js_namespace constant varchar2(50) := 'de.condes.plugin.sct';

  c_data_col_template constant varchar2(100 char) := q'±#CONVERSION# #ITEM#±';
  c_data_delimiter constant varchar2(20 char) := ',' || c_cr || '              ';
  c_join_clause_template constant varchar2(100 char) := q'±(r.sru_id = #ID# and (#CONDITION#))±';
  c_firing_item_template constant varchar2(100 char) := q'± and instr(r.sru_firing_items, s.firing_item) > 0±';
  
  c_regex_item constant varchar2(50) := '(^|[ \(])#ITEM#([ =<!>\)]|$)';
  
  $IF dbms_db_version.ver_le_11 $THEN
  c_join_delimiter constant varchar2(20 char) := c_cr || '           or ';
  c_rule_view_template constant varchar2(1000) := 
q'±create or replace view #NAME# as
  with session_state as(
       select ':' || sct_admin.get_firing_item || ':' firing_item,
              #DATA_COLS#
         from dual),
       data as(
       select /*+ NO_MERGE(s) */ 
              r.sru_id, r.sru_name, r.sru_firing_items,
              r.sra_spi_id, r.sra_sat_id, r.sra_attribute, 
              rank() over (order by r.sru_sort_seq) rang
         from sct_bl_rules r
         join join session_state s
           on instr(r.sru_firing_items, s.firing_item) > 0
        where #WHERE_CLAUSE#)
select sru_id, sru_name, sra_spi_id, sra_sat_id, sra_attribute
  from data
 where rang = 1±';
  $ELSE
  c_join_delimiter constant varchar2(20 char) := c_cr || '    or ';
  c_rule_view_template constant varchar2(1000) := 
q'±create or replace view #NAME# as
  with session_state as(
       select ':' || sct_admin.get_firing_item || ':' firing_item,
              #DATA_COLS#
         from dual)
select /*+ NO_MERGE(s) */ 
       r.sru_id, r.sru_name, r.sru_firing_items,
       r.sra_spi_id, r.sra_sat_id, r.sra_attribute
  from sct_bl_rules r
  join session_state s
    on instr(r.sru_firing_items, s.firing_item) > 0
 where #WHERE_CLAUSE#
 order by r.sru_sort_seq
 fetch first 1 row with ties
±';
  $END
       
  c_rule_test_template constant varchar2(2000) :=
q'±  with params as(
       select #DATA_COLS#
         from dual)
  select *
    from params
   where #CONDITION#±';
   
    c_stmt_template constant varchar2(32767) := 
q'±select sru.sru_id, sru.sru_sort_seq, sru.sru_name, sra_spi_id item,
       sat_pl_sql pl_sql,
       sat_js js,
       sra_attribute attribute
  from #RULE_VIEW# srg
  join sct_rule sru
    on srg.sru_id = sru.sru_id
  join sct_group sgr
    on sru.sru_sgr_id = sgr.sgr_id
  join sct_action_type sat
    on srg.sra_sat_id = sat.sat_id±';
    
    c_plsql_template constant varchar2(200) := 
q'±#PLSQL#±';

    c_plsql_action_template constant varchar2(200) :=
q'±begin
  #CODE#
end;±';
    
    c_js_template constant varchar2(200) := 
q'±#SCRIPT#±';

    c_js_action_template constant varchar2(300) :=
q'±<script id="RULE_#SRU_SORT_SEQ#">
  #JS_FILE#.setRuleName('#SRU_NAME#')
  #JS_FILE#.setItemValues(#ITEM_JSON#)
  #JS_FILE#.setErrors(#ERROR_JSON#)
  #CODE#
</script>±';

  c_null constant varchar2(10) := 'null;';
  
  /* Globale Variablen */
  g_firing_item varchar2(30 byte);
   
  /* HILFSFUNKTIONEN */
  /* Hilfsfunktion zum Analysieren der Regeln
   * %param p_sgr_id Statusgruppen-ID
   * %param p_sru_id Regel-ID
   * %usage Wird aufgerufen, um die Bildung einer Analyse-View vorzubereiten
   *        Zu einer Regel werden alle Bedingungen gegen das aktuelle
   *        APEX-Dictionary geprueft. Elemente, die in den Bedingungen enthalten
   *        sind, werden in Tabelle SCT_PAGE_ITEM eingetragen und dienen als 
   *        Grundlage fuer die Erstellung der Analyse-View.
   */
  procedure harmonize_sct_page_item(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    -- Required-Flag der Gruppe zuruecksetzen
    update sct_page_item
       set spi_is_required = c_false
     where spi_sgr_id = p_sgr_id;
     
    -- Elemente aus APEX lesen und lokal eintragen, Flag IS_REQUIRED aktualisieren
    -- um anzuzeigen, dass dieses Element in den Regeln referenziert wird
    merge into sct_page_item spi
    using (select distinct 
                  api.item_name spi_id,
                  sgr.sgr_id spi_sgr_id,
                  api.spi_conversion, 
                  case when sru.sru_id is null then c_false else c_true end spi_is_required
             from (select application_id, page_id, item_name, 
                          case 
                          when regexp_like(format_mask, '(^|(FM))[09DGL]+$') then replace(q'±to_number(v('#ITEM#'), '#MASK#')±', '#MASK#', format_mask)
                          when format_mask is not null then replace(q'±to_date(v('#ITEM#'), '#MASK#')±', '#MASK#', format_mask)
                          else q'±v('#ITEM#')±' end spi_conversion
                     from apex_application_page_items) api
             join sct_group sgr
               on api.application_id = sgr.sgr_app_id
              and api.page_id = sgr.sgr_page_id
             left join sct_rule sru
               on regexp_instr(upper(sru.sru_condition), replace(c_regex_item, '#ITEM#', api.item_name)) > 0
              and sgr.sgr_id = sru.sru_sgr_id
            where sgr.sgr_id = p_sgr_id) v
       on (spi.spi_id = v.spi_id and spi.spi_sgr_id = v.spi_sgr_id)
     when matched then update set
          spi.spi_conversion = v.spi_conversion,
          spi.spi_is_required = v.spi_is_required
     when not matched then insert (spi_id, spi_sgr_id, spi_conversion, spi_is_required)
          values (v.spi_id, v.spi_sgr_id, v.spi_conversion, v.spi_is_required);
          
    -- Ueberzaehlige Elemente entfernen
    delete from sct_page_item
     where spi_id not in (
           select api.item_name
             from apex_application_page_items api
             join sct_group sgr
               on api.application_id = sgr.sgr_app_id
              and api.page_id = sgr.sgr_page_id);
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
    /* TODO: Pruefen, ob eine Tabelle SCT_RULE_FIRING_ITEMS nicht die bessere Loesung waere */
    merge into sct_rule sru
    using (select sru.sru_id, 
                  listagg(api.item_name, ':') within group (order by api.item_name) sru_firing_items
             from (select distinct application_id, page_id, item_name
                     from apex_application_page_items) api
             join sct_group sgr
               on api.application_id = sgr.sgr_app_id
              and api.page_id = sgr.sgr_page_id
             join sct_rule sru
               on regexp_instr(upper(sru.sru_condition), replace(c_regex_item, '#ITEM#', api.item_name)) > 0
            where sgr.sgr_id = p_sgr_id
            group by sru.sru_id) v
       on (sru.sru_id = v.sru_id)
     when matched then update set
          sru.sru_firing_items = v.sru_firing_items;
  end harmonize_rule_event_filter;
  

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
    cursor item_cur(p_sgr_id in sct_group.sgr_id%type) is
      select spi_id, spi_conversion, row_number() over (order by spi_id) sort_seq
        from sct_page_item
       where spi_sgr_id = p_sgr_id
         and spi_is_required = c_true
       order by spi_id;
         
    cursor rule_cur (p_sgr_id in sct_group.sgr_id%type) is
      select sru_id, sru_name, sru_condition, sru_firing_items,
             row_number() over (order by sru_id) sort_seq
        from sct_rule
       where sru_sgr_id = p_sgr_id
       order by sru_id;
    
    l_view_name varchar2(30 byte);
    l_data_cols varchar2(32767);
    l_where_clause varchar2(32767);
    l_stmt varchar2(32767);
  begin
    l_view_name := c_view_name_prefix || p_sgr_id;
    for spi in item_cur(p_sgr_id) loop
      if spi.sort_seq > 1 then 
        l_data_cols := l_data_cols || c_data_delimiter;
      end if;
      l_data_cols :=
        l_data_cols ||
          utl_text.bulk_replace(c_data_col_template, char_table(
            '#CONVERSION#', spi.spi_conversion,
            '#ITEM#', spi.spi_id));
    end loop;
    
    for sru in rule_cur(p_sgr_id) loop
      if sru.sort_seq > 1 then 
        l_where_clause := l_where_clause || c_join_delimiter;
      end if;
      l_where_clause :=
        l_where_clause ||
          utl_text.bulk_replace(c_join_clause_template, char_table(
            '#ID#', sru.sru_id,
            '#CONDITION#', sru.sru_condition));
    end loop;
    
    l_stmt := utl_text.bulk_replace(c_rule_view_template, char_table(
      '#NAME#', l_view_name,
      '#DATA_COLS#', l_data_cols,
      '#WHERE_CLAUSE#', l_where_clause));
      
    execute immediate l_stmt;
  exception
    when others then
      dbms_output.put_line(l_stmt);
      apex_error.add_error('Fehler ' || sqlerrm || ' bei: ' || chr(10) || l_stmt, null, apex_error.c_inline_in_notification);
      raise;
  end create_rule_view;
  
  
  /* Initialisierungsprozedur */
  procedure initialize
  as
  begin
    /* Todo: Nach Auslagerung der Konstanten in Parameter lokale Variablen belegen */
    null;
  end;
  

  /* INTERFACE */  
  function get_view_name(
    p_sgr_id sct_group.sgr_id%type)
    return varchar2
  as
  begin
    return c_view_name_prefix || p_sgr_id;
  end get_view_name;
  
  
  function get_js_function
    return varchar2
  as
  begin
    return c_js_function;
  end get_js_function;
  
  
  function get_js_namespace
    return varchar2
  as
  begin
    return c_js_namespace;
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
    g_firing_item := p_firing_item;
    l_stmt := replace(c_stmt_template, '#RULE_VIEW#', get_view_name(p_sgr_id));
    
    -- Explizite Cursorkontrolle wegen dynamischen SQL
    open l_action_cur for l_stmt;
    fetch l_action_cur into l_rule;
    
    while l_action_cur%FOUND loop
      -- Baue PL/SQL-Code zusammen
      if l_rule.pl_sql is not null then
        l_rule.pl_sql := replace(c_plsql_template, '#PLSQL#', l_rule.pl_sql);
        l_pl_sql_code := l_pl_sql_code || utl_text.bulk_replace(l_rule.pl_sql, char_table(
           '#ITEM#', l_rule.item,
           '#ATTRIBUTE#', l_rule.attribute));
        utl_text.append(l_pl_sql_code, c_cr || '  ', null, c_true);
      end if;
      
      -- Baue JavaScript-Code zusammen
      if l_rule.js is not null then
        l_rule.js := replace(c_js_template, '#SCRIPT#', l_rule.js);
        l_js_code := l_js_code || utl_text.bulk_replace(l_rule.js, char_table(
          '#JS_FILE#', c_js_namespace,
          '#ITEM#', l_rule.item,
          '#ATTRIBUTE#', apex_escape.js_literal(l_rule.attribute)));
        utl_text.append(l_js_code, c_cr || '  ', null, c_true);
      end if;
      fetch l_action_cur into l_rule;
    end loop;
    
    close l_action_cur;
    
    -- Uebernehme Codes in entsprechende Templates
    p_plsql_action := utl_text.bulk_replace(c_plsql_action_template, char_table(
                        '#CODE#', coalesce(l_pl_sql_code, c_null)));
    --if l_js_code is not null then
      -- Aktion nur belegen, falls JavaScript-Code gefunden werden konnte
      p_js_action := utl_text.bulk_replace(c_js_action_template, char_table(
                       '#SRU_SORT_SEQ#', l_rule.sru_sort_seq,
                       '#SRU_NAME#', l_rule.sru_name,
                       '#CODE#', l_js_code,
                       '#JS_FILE#', c_js_namespace));
    --end if;
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
    l_sgr_id := coalesce(p_sgr_id, sct_seq.nextval);
    merge into sct_group s
    using (select l_sgr_id sgr_id,
                  p_sgr_name sgr_name,
                  p_sgr_description sgr_description,
                  p_sgr_page_id sgr_page_id
             from dual) v
       on (s.sgr_id = v.sgr_id)
     when matched then update set
          sgr_name = v.sgr_name,
          sgr_description = v.sgr_description,
          sgr_page_id = v.sgr_page_id
     when not matched then insert(sgr_id, sgr_name, sgr_description, sgr_page_id)
          values(v.sgr_id, v.sgr_name, v.sgr_description, v.sgr_page_id);
  end merge_rule_group;
    
  
  procedure delete_rule_group(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    delete from sct_group
     where sgr_id = p_sgr_id;
    
    execute immediate 'drop view ' || c_view_name_prefix || p_sgr_id;
  end delete_rule_group;
  
  
  procedure resequence_rule_group(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
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
          
  end resequence_rule_group;
  
  
  procedure copy_rule_group(
    p_sgr_id in sct_group.sgr_id%type,
    p_sgr_app_id sct_group.sgr_app_id%type,
    p_sgr_page_id sct_group.sgr_page_id%type)
  as
    l_sct_group sct_group%rowtype;
    l_old_page_id number;
    l_app_exists number;
    /* TODO: Auf Error-Package refaktorisieren */
    e_page_does_not_exist exception;
  begin
    select *
      into l_sct_group
      from sct_group
     where sgr_id = p_sgr_id;
     
    select count(*)
      into l_app_exists
      from apex_application_pages
     where application_id = p_sgr_app_id;
     
    if l_app_exists = 0 then
      raise e_page_does_not_exist;
    end if;
    
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
  exception
    /* TODO: Auf Error-Package refaktorisieren */
    when e_page_does_not_exist then
      raise_application_error(-20000, 'Anwendung oder Anwendungsseite existiert nicht.');
  end copy_rule_group;
  
  
  procedure propagate_rule_change(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    harmonize_sct_page_item(p_sgr_id);
    harmonize_rule_event_filter(p_sgr_id);
    create_rule_view(p_sgr_id);
  end propagate_rule_change;
  
  
  procedure validate_rule(
    p_sgr_id in sct_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2)
  as
    cursor item_cur(p_sgr_id in sct_group.sgr_id%type) is
      select spi_id,
             min(spi_id) over (order by spi_id) min_spi,
             max(spi_id) over (order by spi_id) max_spi
        from sct_page_item
       where spi_sgr_id = p_sgr_id;

    l_data_cols varchar2(32767);
    l_stmt varchar2(32767);
    l_ctx pls_integer;
  begin 
    for spi in item_cur(p_sgr_id) loop
      if spi.min_spi < spi.max_spi then 
        l_data_cols := l_data_cols || c_data_delimiter;
      end if;
      l_data_cols :=
        l_data_cols || 
        utl_text.bulk_replace(c_data_col_template, char_table(
          '#CONVERSION#', 'v(''' || spi.spi_id || ''')',
          '#ITEM#', spi.spi_id));
    end loop;
    l_stmt := utl_text.bulk_replace(c_rule_test_template, char_table(
      '#DATA_COLS#', l_data_cols,
      '#CONDITION#', p_sru_condition));
    l_ctx := dbms_sql.open_cursor;
    dbms_sql.parse(l_ctx, l_stmt, dbms_sql.native);
    dbms_sql.close_cursor(l_ctx);
  exception
    when others then
      p_error := 'Fehler beim Validieren der Regel: <br>' || sqlerrm;
  end validate_rule;
  
begin
  initialize;
end sct_admin;
/