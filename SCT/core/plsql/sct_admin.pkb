create or replace package body sct_admin
as

  /* Weitere Konstanten siehe SCT_CONST */
  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;
  c_cr constant char(1 byte) := chr(10);
  c_delimiter constant char(1 byte) := '|';
  c_yes constant char(1 byte) := 'Y';

  /* Globale Variablen */
  g_firing_item varchar2(30 byte);
  -- PL/SQL-Tabelle zum Mappen alter IDs auf neue. Wird beim Kopieren von Regelgruppen verwendet
  type id_map_t is table of binary_integer index by binary_integer;
  g_id_map id_map_t;


  /* Hilfsfunktionen */
  
  
  /* Methode zur Erzeugung des Initialisierungscodes aus einem Fetch Row-Prozess
   * %param p_sgr_id ID der Regelgruppe
   * %usage Wird verwendet, um fuer eine Regelgruppe Initialisierungscode zu erzeugen
   *        Der Code wird zur Laufzeit ausgefuehrt und initialisiert den Sessionstatus
   *        der Seite.
   */
  function create_initialization_code(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    cursor fetch_row_cur (p_sgr_id in sct_rule_group.sgr_id%type) is
      select attribute_02, attribute_03, attribute_04
        from apex_application_page_proc api
        join sct_rule_group sgr
          on api.application_id = sgr.sgr_app_id
         and api.page_id = sgr.sgr_page_id
       where sgr.sgr_id = p_sgr_id
         and api.process_type_code = 'DML_FETCH_ROW';
    cursor item_cur(p_sgr_id in sct_rule_group.sgr_id%type) is
      select item_name, item_source
        from apex_application_page_items api
        join sct_rule_group sgr
          on api.application_id = sgr.sgr_app_id
         and api.page_id = sgr.sgr_page_id
        join sct_page_item spi
          on sgr.sgr_id = spi.spi_sgr_id
         and api.item_name = spi.spi_id
       where api.item_source_type = 'Database Column'
         and sgr.sgr_id = p_sgr_id
         and spi.spi_is_required = 1;
    l_sql_stmt varchar2(1000);
    l_item_stmt varchar2(32767);
    l_initialization_code varchar2(32767);
  begin
    -- 1. Schritt: Fetch Row-Anweisung generieren
    for src in fetch_row_cur(p_sgr_id) loop
      l_sql_stmt := utl_text.bulk_replace(
                      case src.attribute_04
                      when 'ROWID' then sct_const.c_col_sql_rowid_stmt
                      else sct_const.c_col_sql_stmt end,
                      char_table(
                        '#ATTRIBUTE_02#', src.attribute_02,
                        '#ATTRIBUTE_03#', src.attribute_03,
                        '#ATTRIBUTE_04#', src.attribute_04
                      ));
    end loop;
    if l_sql_stmt is not null then
      -- 2. Schritt: Anweisungsliste fuer Sessionstatus erzeugen
      for itm in item_cur(p_sgr_id) loop
        l_item_stmt := l_item_stmt 
                    || utl_text.bulk_replace(sct_const.c_col_val_template, char_table(
                         '#ITEM#', itm.item_name,
                         '#COLUMN#', itm.item_source,
                         '#CR#', c_cr
                       ));
      end loop;
      -- 3. Schritt: Template mit Anweisungen anreichern und returnieren
      l_initialization_code := utl_text.bulk_replace(sct_const.c_initialize_code, char_table(
                                 '#SQL_STMT#', l_sql_stmt,
                                 '#ITEM_STMT#', l_item_stmt,
                                 '#CR#', c_cr
                               ));
    end if;
    return l_initialization_code;
  end create_initialization_code;
  
  
  /* Methode zur Aktualisierung der Tabelle SCT_PAGE_ITEM mit dem APEX-Data Dictionary
   * %param p_sgr_id ID der Regelgruppe
   * %usage Wird verwendet, um bei einer Regelaenderung die Seitenelemente der
   *        referenzierten APEX-Anwendung zu lesen. Die Tabelle dient als Grundlage
   *        fuer die Einzelregeln.
   *        Entfernt Seitenelemente, die nicht mehr auf der Seite existieren, und
   *        damit auch Aktionen, die sich auf diese Seitenelemente beziehen!
   */
  procedure harmonize_sct_page_item(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
    l_initialization_code varchar2(32767);
  begin
    pit.enter_optional('harmonize_sct_page_item', c_pkg);
    
      -- Schritt 1: REQUIRED-Flags entfernen
      update sct_page_item
         set spi_is_required = 0,
              -- Alle zunaechst fehlerhaft markieren, wird spaeter bereinigt
             spi_has_error = sct_const.c_true
       where spi_sgr_id = p_sgr_id;
      
      -- Schritt 2: APEX-Seitenelemente in SCT_PAGE_ITEMS mergen
      merge into sct_page_item spi
      using (select sgr_id spi_sgr_id,
                    target_type spi_sit_id,
                    target_name spi_id,
                    spi_conversion,
                    sct_const.c_false spi_has_error
               from sct_bl_page_targets
              where sgr_id = p_sgr_id) v
         on (spi.spi_id = v.spi_id and spi.spi_sgr_id = v.spi_sgr_id)
       when matched then update set
            spi.spi_sit_id = v.spi_sit_id,
            spi.spi_conversion = v.spi_conversion,
            spi.spi_has_error = v.spi_has_error
       when not matched then insert(spi_id, spi_sit_id, spi_sgr_id, spi_conversion)
            values(v.spi_id, v.spi_sit_id, v.spi_sgr_id, v.spi_conversion);
      
      -- Schritt 3: Seitenelemente, die in Einzelregel referenziert werden, als relevant markieren
      merge into sct_page_item spi
      using (select distinct sgr.sgr_id spi_sgr_id, i.column_value spi_id
               from sct_rule sru
               join sct_rule_group sgr
                 on sru.sru_sgr_id = sgr.sgr_id
              cross join table(utl_text.string_to_table(sru.sru_firing_items, ',')) i
              where sgr_id = p_sgr_id) v
         on (spi.spi_id = v.spi_id and spi.spi_sgr_id = v.spi_sgr_id)
       when matched then update set
            spi.spi_is_required = sct_const.c_true;
      
      -- Schritt 4: Elemente entfernen, die
      -- - nicht relevant sind und
      -- - fehlerhaft sind (z.B. weil sie nicht mehr existieren)
      -- - nicht als Aktionsitems verwendet werden und
      delete from sct_page_item spi
       where spi_sgr_id = p_sgr_id
         and spi_is_required = sct_const.c_false
         and spi_has_error = sct_const.c_true
         and spi_id not in (
             select sra_spi_id
               from sct_rule_action
              where sra_sgr_id = p_sgr_id);
              
      -- Fehler in SCT_RULE und SCT_RULE_ACTION vermerken
      update sct_rule
         set sru_has_error = sct_const.c_false
       where sru_sgr_id = p_sgr_id;
      
       merge into sct_rule sru
       using (select distinct sru.sru_id
                from sct_page_item spi
                join sct_rule sru
                  on utl_text.contains(sru_firing_items, spi_id) > 0
               where spi_sgr_id = p_sgr_id
                 and spi_has_error = sct_const.c_true) v
          on (sru.sru_id = v.sru_id)
        when matched then update set
             sru_has_error = sct_const.c_true;
      
      update sct_rule_action
         set sra_has_error = sct_const.c_false
       where sra_sgr_id  = p_sgr_id;
      
       merge into sct_rule_action sra
       using (select spi_sgr_id sra_sgr_id, spi_id sra_spi_id
                from sct_page_item
               where spi_sgr_id = p_sgr_id
                 and spi_has_error = sct_const.c_true) v
          on (sra.sra_sgr_id = v.sra_sgr_id and sra.sra_spi_id = v.sra_spi_id)
        when matched then update set
             sra_has_error = sct_const.c_true;
             
      l_initialization_code := create_initialization_code(p_sgr_id);
      update sct_rule_group
         set sgr_initialization_code = l_initialization_code
       where sgr_id = p_sgr_id;
    pit.leave_optional;
  end harmonize_sct_page_item;
  

  /* Hilfsmethode zur Aktualisierung der Liste der Elemente, die durch eine Regel
   * angesprochen werden, in der Tabelle SCT_RULE
   * %param p_sgr_id ID der Regelgruppe
   * %usage Wird verwendet, um aus der Regelbedingung mit Hilfe eines regulaeren
   *        Ausdrucks (SCT_CONST.C_REGEX_ITEM) die Elementnamen zu extrahieren.
   *        Dient der Validierung der Regel und weiterer Anwendungslogik der Regel
   */
  procedure harmonize_firing_items(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_detailed('harmonize_firing_items', c_pkg);
    merge into sct_rule sru
    using (select sru.sru_id,
                  listagg(spt.target_name, sct_const.c_delimiter) within group (order by spt.target_name) sru_firing_items
             from sct_bl_page_targets spt
             join sct_rule sru
               on spt.sgr_id = sru.sru_sgr_id
              and regexp_instr(upper(sru.sru_condition), replace(sct_const.c_regex_item, '#ITEM#', spt.target_name)) > 0
            where spt.sgr_id = p_sgr_id
              and sru.sru_active = sct_const.c_true
            group by sru.sru_id) v
       on (sru.sru_id = v.sru_id)
     when matched then update set
          sru.sru_firing_items = v.sru_firing_items;
    pit.leave_detailed;
  end harmonize_firing_items;


  /* Hilfsmethode loescht Regelviews, die nach dem Loeschen einer Regelgruppe
   * Im Datenmodell verblieben sind
   * %usage Wird bei Aenderung einer Regel stets mit aufgerufen, um verwaiste
   *        Regelviews zu minimieren.
   */
  procedure delete_pending_rule_views
  as
    cursor pending_view_cur is
      select view_name
        from user_views
       where view_name like sct_const.c_view_name_prefix || '%'
         and view_name not in (
             select sct_const.c_view_name_prefix || sgr_id
               from sct_rule_group);
  begin
    pit.enter_detailed('delete_pending_rule_views', c_pkg);
    for vw in pending_view_cur loop
      execute immediate 'drop view ' || vw.view_name;
      pit.verbose(msg.SCT_RULE_VIEW_DELETED, msg_args(vw.view_name));
    end loop;
    pit.leave_detailed;
  end delete_pending_rule_views;


  /* Prozedur zur Erzeugung einer Zeichenkette, die als Teil der Regelview verwendet wird
   * %param p_sgr_id ID der Regelgruppe
   * %param p_validation Flag, das anzeigt, ob die Spaltenliste fuer Regelpruefungen
   *        benoetigt wird.
   * %usage Erzeugt die Spaltenliste fuer eine Regelview. Die Liste umfasst alle
   *        relevanten Seitenelemente einer Regelgruppe.
   *        Wird die Prozedur zur Validierung aufgerufen, umfasst die Spaltenliste
   *        alle Elemente der Seite, um keine falsch negative Validierung einer
   *        Regelbedingung zu erhalten.
   */
  function create_column_list(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_validation in number default sct_const.c_false)
    return varchar2
  as
    cursor column_cur(p_sgr_id in sct_rule_group.sgr_id%type, p_validation in number) is
      select replace(
               case sit.sit_id
                 when 'BUTTON' then sct_const.c_button_col_template
                 when 'REGION' then sct_const.c_region_col_template
                 when 'DOCUMENT' then sct_const.c_region_col_template
                 when 'ITEM' then sct_const.c_item_col_template
                 when 'NUMBER_ITEM' then replace(sct_const.c_number_item_col_template, '#CONVERSION#', spi_conversion)
                 when 'DATE_ITEM' then replace(sct_const.c_date_item_col_template, '#CONVERSION#', spi_conversion)
               else null end,
              '#ITEM#',
              spi_id) column_name
        from sct_page_item spi
        join sct_page_item_type sit
          on spi.spi_sit_id = sit.sit_id
       where spi_sgr_id = p_sgr_id
         and ((spi_is_required = sct_const.c_true
          or p_validation = sct_const.c_true)
          or (spi_id = 'DOCUMENT'))
       order by spi_id;
    l_data_cols varchar2(32767);
  begin
    pit.enter_detailed('create_column_list', c_pkg);
    -- Record loop statt LISTAGG wegen Limitierung auf 4000 Byte
    for spi in column_cur(p_sgr_id, p_validation) loop
      l_data_cols := l_data_cols || spi.column_name;
    end loop;
    pit.leave_detailed;
    return l_data_cols;
  end create_column_list;


  /* Methode zur Erzeugung einer WHERE-Klausel fuer die Regelview
   * %param p_sgr_id ID der Regelgruppe
   * %usage Wird verwendet, um die WHERE-Klausel der Regelview zu erzeugen.
   *        Die Klausel besteht aus der Relgel-ID und der Regelbedingung
   */
  function create_where_clause(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    cursor rule_cur(p_sgr_id in sct_rule_group.sgr_id%type) is
      select sru_id, sru_name, sru_condition, sru_firing_items,
             row_number() over (order by sru_id) sort_seq
        from sct_rule
       where sru_sgr_id in (0, p_sgr_id)
         and sru_active = sct_const.c_true
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
  exception
    when others then
      pit.sql_exception(msg.SQL_ERROR);
      raise;
  end create_where_clause;


  /* Methode zur Erzeugung einer Regelview
   * %param p_sgr_id ID der Regelgruppe
   * %usage Wird verwendet, um fuer eine Regelgruppe eine Regelview zu erzeugen.
   *        Die Spaltenliste und die WHERE-Klausel werden durch Hilfsmethoden
   *        zugeliefert.
   */
  procedure create_rule_view(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
    l_view_name varchar2(30 byte);
    l_stmt varchar2(32767);
  begin
    pit.enter_optional('create_rule_view', c_pkg);
    delete_pending_rule_views;

    l_view_name := sct_const.c_view_name_prefix || p_sgr_id;

    -- Erzeuge die Regelview
    l_stmt := utl_text.bulk_replace(sct_const.c_rule_view_template, char_table(
                '#NAME#', l_view_name,
                '#DATA_COLS#', create_column_list(p_sgr_id),
                '#WHERE_CLAUSE#', create_where_clause(p_sgr_id),
                '#SGR_ID#', p_sgr_id));
    execute immediate l_stmt;

    pit.verbose(msg.SCT_VIEW_CREATED, msg_args(l_view_name));
    pit.leave_optional;
  exception
    when others then
      pit.sql_exception(msg.SCT_VIEW_CREATION, msg_args(sqlerrm, l_stmt));
  end create_rule_view;


  /* Prozeduren fuer den DDL-Export */
  /* Methode zur Erzeugung eines Skripts zum Exportieren der Aktionstypen
   * %return CLOB-Instanz mit dem Exportskript
   * %usage Wird verwendet, um einen CLOB zu erzeugen, der alle Aktionstypen
   *        erzeugen kann
   */
  function read_action_type
    return clob
  as
    cursor action_type_cur is
      select *
        from sct_action_type
       where sat_is_editable = 1;
    l_action_type clob;
  begin
    pit.enter_optional('read_action_type', c_pkg);
    dbms_lob.createtemporary(l_action_type, false, dbms_lob.call);

    dbms_lob.append(l_action_type, sct_const.c_cr || '  -- ACTION TYPES');

    -- Exportiere Aktionstypen
    for sat in action_type_cur loop
      dbms_lob.append(
        l_action_type,
        utl_text.bulk_replace(sct_const.c_action_type_template, char_table(
          '#SAT_ID#', sat.sat_id,
          '#SAT_NAME#', sat.sat_name,
          '#SAT_DESCRIPTION#', sat.sat_description,
          '#SAT_PL_SQL#', sat.sat_pl_sql,
          '#SAT_JS#', sat.sat_js,
          '#SAT_IS_EDITABLE#', sat.sat_is_editable,
          '#SAT_RAISE_RECURSIVE#', sat.sat_raise_recursive)));
    end loop;

    pit.leave_optional;
    return l_action_type;
  end read_action_type;


  /* Methode zur Erzeugung eines Skripts zum Exportieren der Einzelregeln und Aktionen
   * einer Regelgruppe
   * %param p_sgr_id ID der Regelgruppe
   * %return CLOB-Instanz mit dem Exportskript
   * %usage Wird verwendet, um eine Regelgruppe komplett zu exportieren.
   */
  function read_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return clob
  as
    cursor rule_group_cur(p_sgr_id in sct_rule_group.sgr_id%type) is
      select *
        from sct_rule_group sgr
       where sgr_id = p_sgr_id;

    cursor rule_cur(p_sgr_id in sct_rule_group.sgr_id%type) is
      select *
        from sct_rule sru
       where sru.sru_sgr_id = p_sgr_id;

    cursor action_cur(p_sru_id in sct_rule.sru_id%type, p_sgr_id in sct_rule_group.sgr_id%type) is
      select *
        from sct_rule_action sra
       where sra.sra_sru_id = p_sru_id
         and sra.sra_sgr_id = p_sgr_id;

    l_stmt clob;
    l_sgr clob;
    l_rule clob;
    l_rule_action clob;
    l_rule_group_name varchar2(200 byte);
  begin
    pit.enter_optional('read_rule_group', c_pkg);
    -- Initialisierung
    dbms_lob.createtemporary(l_stmt, false, dbms_lob.call);
    dbms_lob.createtemporary(l_sgr, false, dbms_lob.call);
    dbms_lob.createtemporary(l_rule, false, dbms_lob.call);
    dbms_lob.createtemporary(l_rule_action, false, dbms_lob.call);

    /* Geschachtelte CURSOR-FOR-LOOPS anstelle Cursor-Ausdruck, weil:
       - einfacherer Code
       - kein Nebenlaeufigkeitsproblem (Stammdaten)
       - kein Performanzproblem
       - deutlich weniger Variablen (%ROWTYPE unterstuetzt keine Cursor-Ausdruecke
     */
    for sgr in rule_group_cur(p_sgr_id) loop
      l_rule_group_name := sgr.sgr_name || ' (ID ' || sgr.sgr_id || ')';
      dbms_lob.append(
        l_sgr,
        utl_text.bulk_replace(sct_const.c_rule_group_template, char_table(
          '#SGR_APP_ID#', to_char(sgr.sgr_app_id),
          '#SGR_PAGE_ID#', to_char(sgr.sgr_page_id),
          '#SGR_ID#', to_char(sgr.sgr_id),
          '#SGR_NAME#', sgr.sgr_name,
          '#SGR_DESCRIPTION#', sgr.sgr_description,
          '#SGR_ACTIVE#', to_char(sgr.sgr_active))));
      for sru in rule_cur(sgr.sgr_id) loop
        dbms_lob.append(
          l_rule,
          utl_text.bulk_replace(sct_const.c_rule_template, char_table(
            '#SRU_ID#', to_char(sru.sru_id),
            '#SGR_ID#', to_char(sru.sru_sgr_id),
            '#SRU_NAME#', sru.sru_name,
            '#SRU_CONDITION#', sru.sru_condition,
            '#SRU_SORT_SEQ#', to_char(sru.sru_sort_seq),
            '#SRU_ACTIVE#', to_char(sru.sru_active))));
        for sra in action_cur(sru.sru_id, sru.sru_sgr_id) loop
          dbms_lob.append(
            l_rule_action,
            utl_text.bulk_replace(sct_const.c_rule_action_template, char_table(
              '#SRU_ID#', to_char(sra.sra_sru_id),
              '#SGR_ID#', to_char(sra.sra_sgr_id),
              '#SPI_ID#', sra.sra_spi_id,
              '#SAT_ID#', sra.sra_sat_id,
              '#SRA_ATTRIBUTE#', sra.sra_attribute,
              '#SRA_ATTRIBUTE_2#', sra.sra_attribute_2,
              '#SRA_SORT_SEQ#', to_char(sra.sra_sort_seq),
              '#SRA_ACTIVE#', to_char(sra.sra_active))));
        end loop;
      end loop;
      -- Bei Ersetzungspatterns keine tatsaechlichen Absatzzeichen einbauen,
      -- da Installationsskripte ansonsten COMMIT, END etc. als Kommando ausfuehren
      dbms_lob.append(l_stmt, replace('~  -- RULE GROUP ' || l_rule_group_name, '~', sct_const.c_cr));
      dbms_lob.append(l_stmt, l_sgr);
      dbms_lob.append(l_stmt, replace('~  -- RULES', '~', sct_const.c_cr));
      dbms_lob.append(l_stmt, l_rule);
      dbms_lob.append(l_stmt, replace('~  -- RULE ACTIONS', '~', sct_const.c_cr));
      dbms_lob.append(l_stmt, l_rule_action);
    end loop;

    dbms_lob.append(l_stmt, replace(sct_const.c_rule_group_validation, '#SGR_ID#', p_sgr_id));

    pit.leave_optional;
    return l_stmt;
  end read_rule_group;


  /* INTERFACE */
  function get_firing_item
    return varchar2
  as
  begin
    pit.enter_mandatory('get_firing_item', c_pkg);
    return g_firing_item;
    pit.leave_mandatory;
  end get_firing_item;


  function get_firing_items(
    p_firing_item in varchar2)
    return varchar2
  as
    l_firing_items varchar2(32767);
  begin
    pit.enter_mandatory('get_firing_item', c_pkg);
    select listagg(coalesce(spi_id, p_firing_item), sct_const.c_delimiter) within group (order by spi_id)
      into l_firing_items
      from (select distinct spi_id
              from sct_rule sru
              join sct_page_item spi
                on instr(sct_const.c_delimiter || sru.sru_firing_items || sct_const.c_delimiter, sct_const.c_delimiter || spi.spi_id || sct_const.c_delimiter) > 0
             where instr(sct_const.c_delimiter || sru.sru_firing_items || sct_const.c_delimiter, sct_const.c_delimiter || p_firing_item || sct_const.c_delimiter) > 0);
    pit.leave_mandatory;
    return l_firing_items;
  exception
    when no_data_found then
      pit.leave_mandatory;
      return p_firing_item;
  end get_firing_items;


  procedure create_action(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_firing_item in sct_page_item.spi_id%type,
    p_is_recursive in number,
    p_firing_items out nocopy varchar2,
    p_plsql_action out nocopy varchar2,
    p_js_action out nocopy varchar2)
  as
    type rule_rec is record(
      sru_id sct_rule.sru_id%type,
      sru_sort_seq sct_rule.sru_sort_seq%type,
      sru_name sct_rule.sru_name%type,
      sru_firing_items sct_rule.sru_firing_items%type,
      item sct_page_item.spi_id%type,
      pl_sql sct_action_type.sat_pl_sql%type,
      js sct_action_type.sat_js%type,
      attribute sct_rule_action.sra_attribute%type,
      attribute_2 sct_rule_action.sra_attribute_2%type
    );
    l_rule rule_rec;
    l_action_cur sys_refcursor;

    l_stmt varchar2(32767);
    l_pl_sql_code varchar2(32767);
    l_js_code varchar2(32767);
  begin
    pit.enter_mandatory('create_action', c_pkg);
    -- Stelle ausloesendes Element fuer SQL ueber Get-Methode zur Verfuegung
    g_firing_item := p_firing_item;

    l_stmt := utl_text.bulk_replace(sct_const.c_stmt_template, char_table(
                '#RULE_VIEW#', sct_const.c_view_name_prefix || p_sgr_id,
                '#IS_RECURSIVE#', p_is_recursive));

    -- Explizite Cursorkontrolle wegen dynamischen SQLs
    open l_action_cur for l_stmt;
    fetch l_action_cur into l_rule;  -- Hier wird die Regel evaluiert

    while l_action_cur%FOUND loop
      -- Baue PL/SQL-Code zusammen
      if l_rule.pl_sql is not null then
        l_pl_sql_code := utl_text.bulk_replace(l_pl_sql_code || sct_const.c_plsql_template, char_table(
          '#PLSQL#', l_rule.pl_sql,
          '#ATTRIBUTE#', l_rule.attribute,
          '#ATTRIBUTE_2#', l_rule.attribute_2,
          '#ITEM#', l_rule.item));
        utl_text.append(l_pl_sql_code, sct_const.c_cr || '  ', null, sct_const.c_true);
      end if;

      -- Baue JavaScript-Code zusammen
      if l_rule.js is not null then
        l_js_code := utl_text.bulk_replace(l_js_code || sct_const.c_js_template, char_table(
          '#SCRIPT#', replace(l_rule.js, c_cr, c_cr || '  '),
          '#JS_FILE#', sct_const.c_js_namespace,
          '#ITEM#', l_rule.item,
          '#ATTRIBUTE#', l_rule.attribute,
          '#ATTRIBUTE_2#', l_rule.attribute_2));
        utl_text.append(l_js_code, sct_const.c_cr || '  ', null, sct_const.c_true);
      end if;
      fetch l_action_cur into l_rule;
    end loop;

    close l_action_cur;

    -- Uebernehme PL/SQL bzw. JS-Codes in entsprechende Ausgabeparameter
    p_plsql_action := replace(sct_const.c_plsql_action_template, '#CODE#', coalesce(l_pl_sql_code, sct_const.c_null));

    p_js_action :=
      utl_text.bulk_replace(sct_const.c_js_code_template, char_table(
        '#SRU_SORT_SEQ#', case when l_rule.sru_sort_seq is not null then 'RULE_' || l_rule.sru_sort_seq else 'NO_RULE_FOUND' end,
        '#SRU_NAME#', l_rule.sru_name,
        '#CODE#', rtrim(l_js_code, sct_const.c_cr || '  '),
        '#FIRING_ITEM#', p_firing_item));

    -- Ermittle durch die Regel betroffene Seitenelemente als FIRING_ITEMS
    p_firing_items := get_firing_items(p_firing_item);
    pit.leave_mandatory;
  end create_action;


  /* Oeffentliche DDL-Methoden */
  procedure merge_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_sgr_description in sct_rule_group.sgr_description%type,
    p_sgr_active in sct_rule_group.sgr_active%type default sct_const.c_true)
  as
    l_sgr_id sct_rule_group.sgr_id%type;
  begin
    pit.enter_mandatory('merge_rule_group', c_pkg);
    l_sgr_id := coalesce(p_sgr_id, sct_seq.nextval);
    
    -- Falls vorhanden, existierende Regelgruppe loeschen
    delete from sct_rule_group
     where sgr_page_id = p_sgr_page_id
       and sgr_name = p_sgr_name;
       
    merge into sct_rule_group s
    using (select l_sgr_id sgr_id,
                  p_sgr_name sgr_name,
                  p_sgr_description sgr_description,
                  p_sgr_app_id sgr_app_id,
                  p_sgr_page_id sgr_page_id,
                  p_sgr_active sgr_active
             from dual) v
       on (s.sgr_id = v.sgr_id and s.sgr_app_id = v.sgr_app_id)
     when matched then update set
          sgr_name = v.sgr_name,
          sgr_description = v.sgr_description,
          sgr_page_id = v.sgr_page_id,
          sgr_active = v.sgr_active
     when not matched then insert(sgr_id, sgr_name, sgr_description, sgr_app_id, sgr_page_id, sgr_active)
          values(v.sgr_id, v.sgr_name, v.sgr_description, v.sgr_app_id, v.sgr_page_id, v.sgr_active);

    harmonize_sct_page_item(l_sgr_id);
    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SQL_ERROR, msg_args('Bei Regelgruppe ' || p_sgr_name || ': ' || sqlerrm));
  end merge_rule_group;


  procedure delete_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('delete_rule_group', c_pkg);
    execute immediate 'drop view ' || sct_const.c_view_name_prefix || p_sgr_id;
    delete from sct_rule_group
     where sgr_id = p_sgr_id;
    pit.leave_mandatory;
  end delete_rule_group;


  procedure resequence_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('resequence_rule_group', c_pkg);
    -- Regel neu nummerieren
    merge into sct_rule sru
    using (select sru_id, sru_sgr_id,
                  row_number() over (partition by sru_sgr_id order by sru_sort_seq) * 10 sru_sort_seq
             from sct_rule
            where sru_sgr_id = p_sgr_id) v
       on (sru.sru_id = v.sru_id and sru.sru_sgr_id = v.sru_sgr_id)
     when matched then update set
          sru_sort_seq = v.sru_sort_seq;

    -- Aktionen neu nummerieren
    merge into sct_rule_action sra
    using (select rowid row_id,
                  row_number() over (partition by sra_sru_id order by sra_sort_seq) * 10 sra_sort_seq
             from sct_rule_action
            where sra_sgr_id = p_sgr_id) v
       on (sra.rowid = v.row_id)
     when matched then update set
          sra_sort_seq = v.sra_sort_seq;

    -- Wird aus AJAX aufgerufen, daher hier Aenderungen festschreiben
    commit;
    pit.leave_mandatory;
  end resequence_rule_group;


  procedure copy_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_app_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_app_to in sct_rule_group.sgr_app_id%type,
    p_sgr_page_to in sct_rule_group.sgr_page_id%type)
  as
    l_foo number;
    l_sgr_id sct_rule_group.sgr_id%type;
  begin
    -- Pruefe, ob Quellseite existiert
    pit.assert_exists(
      'select 1 ' ||
      '  from apex_applications ' ||
      ' where application_id = ' || p_sgr_app_id,
      msg.SCT_APP_DOES_NOT_EXIST,
      msg_args(to_char(p_sgr_app_id)));

    -- Pruefe, ob Zielseite existiert
    pit.assert_exists(
      'select 1 ' ||
      '  from apex_application_pages ' ||
      ' where application_id = ' || p_sgr_app_id ||
      '   and page_id = ' || p_sgr_page_id,
      msg.SCT_PAGE_DOES_NOT_EXIST,
      msg_args(to_char(p_sgr_app_id)));

    -- Initialisierung
    l_foo := map_id(null);
    begin
      select sgr_id
        into l_sgr_id
        from sct_rule_group
       where sgr_app_id = p_sgr_app_id
         and sgr_page_id = p_sgr_page_id
         and sgr_id = p_sgr_id;
    exception
      when no_data_found then
        pit.stop(msg.SCT_RULE_DOES_NOT_EXIST, msg_args(to_char(p_sgr_id)));
    end;

    -- Schliesse aus, dass Regel ueber sich selbst kopiert wird (hat zur Folge, dass die Regelgruppe geloescht wuerde)
    if (p_sgr_app_id != p_sgr_app_to or p_sgr_page_id != p_sgr_page_to) then
      -- Loesche existierende Regelgruppe in Zielanwendung
      delete from sct_rule_group
       where sgr_app_id = p_sgr_app_to
         and sgr_page_id = p_sgr_page_to
         and sgr_name = (select sgr_name
                           from sct_rule_group
                          where sgr_id = p_sgr_id);

      -- Lese Regelgruppendetails
      insert into sct_rule_group(sgr_id, sgr_name, sgr_description, sgr_app_id, sgr_page_id)
      select map_id(sgr_id), sgr_name, sgr_description, p_sgr_app_to, p_sgr_page_to
        from sct_rule_group
       where sgr_id = l_sgr_id;

      insert into sct_rule(sru_id, sru_sgr_id, sru_name, sru_condition, sru_firing_items, sru_sort_seq)
      select map_id(sru_id), map_id(sru_sgr_id), sru_name,
             replace(upper(sru_condition), 'P' || p_sgr_page_id || '_',  'P' || p_sgr_page_to || '_'),
             sru_firing_items,
             sru_sort_seq
        from sct_rule
       where sru_sgr_id = l_sgr_id;

      propagate_rule_change(map_id(l_sgr_id));

     insert into sct_rule_action(sra_sgr_id, sra_sru_id, sra_spi_id, sra_sat_id, sra_attribute, sra_attribute_2, sra_sort_seq, sra_active)
      select map_id(sra_sgr_id), map_id(sra_sru_id), sra_spi_id, sra_sat_id,
             replace(upper(sra_attribute), 'P' || p_sgr_page_id || '_',  'P' || p_sgr_page_to || '_'),
             replace(upper(sra_attribute_2), 'P' || p_sgr_page_id || '_',  'P' || p_sgr_page_to || '_'),
             sra_sort_seq, sra_active
        from sct_rule_action
       where sra_sgr_id = l_sgr_id;
    end if;
    pit.leave_mandatory;
  end copy_rule_group;


  function export_rule_groups(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type)
    return clob
  as
    cursor rule_group_cur(p_sgr_app_id in sct_rule_group.sgr_app_id%type) is
      select sgr_id
        from sct_rule_group
       where sgr_app_id = p_sgr_app_id;
    l_stmt clob;
    l_app_alias apex_applications.alias%type;
  begin
    pit.enter_mandatory('export_rule_groups', c_pkg);
    dbms_lob.createtemporary(l_stmt, false, dbms_lob.call);

    -- Import-Rahmenbedingungen fuer APEX schaffen
    select alias
      into l_app_alias
      from apex_applications
     where application_id = p_sgr_app_id;
    dbms_lob.append(
      l_stmt, replace(sct_const.c_export_start_template, '#ALIAS#', coalesce(l_app_alias, to_char(p_sgr_app_id))));

    -- Aktionstypen berechnen
    dbms_lob.append(l_stmt, read_action_type);

    -- Einzelne Regelgruppen berechnen
    for sgr in rule_group_cur(p_sgr_app_id) loop
      dbms_lob.append(l_stmt, read_rule_group(sgr.sgr_id));
    end loop;

    dbms_lob.append(l_stmt, sct_const.c_export_end_template);
    pit.leave_mandatory;

    return l_stmt;
  end export_rule_groups;


  function export_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return clob
  as
    l_stmt clob;
    l_app_id sct_rule_group.sgr_app_id%type;
  begin
    pit.enter_mandatory('export_rule_group', c_pkg);
    -- Initialisierung
    dbms_lob.createtemporary(l_stmt, false, dbms_lob.call);

    -- Import-Rahmenbedingungen fuer APEX schaffen
    select sgr_app_id
      into l_app_id
      from sct_rule_group
     where sgr_id = p_sgr_id;
    dbms_lob.append(
      l_stmt, replace(sct_const.c_export_start_template, '#ALIAS#', l_app_id));

    -- Einzelne Teilbereiche berechnen
    dbms_lob.append(l_stmt, read_action_type);
    dbms_lob.append(l_stmt, read_rule_group(p_sgr_id));
    dbms_lob.append(l_stmt, sct_const.c_export_end_template);

    pit.leave_mandatory;
    return l_stmt;
  end export_rule_group;


  function validate_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    cursor missing_element_cur(p_sgr_id in sct_rule_group.sgr_id%type) is
      select sgr.sgr_name, sgr.sgr_app_id, spi.spi_id, sit.sit_name
        from sct_page_item spi
        join sct_page_item_type sit
          on spi.spi_sit_id = sit.sit_id
        join sct_rule_group sgr
          on spi.spi_sgr_id = sgr.sgr_id
       where sgr.sgr_id = p_sgr_id
         and spi.spi_has_error = sct_const.c_true;
    l_error_list varchar2(32767);
    l_sgr_name sct_rule_group.sgr_name%type;
  begin
    pit.enter_mandatory('validate_rule_group', c_pkg);
    harmonize_sct_page_item(p_sgr_id);
    
    for spi in missing_element_cur(p_sgr_id) loop
      l_sgr_name := spi.sgr_name;
      utl_text.append(
        l_error_list,
        utl_text.bulk_replace(sct_const.c_page_item_error, char_table(
          '#SIT_NAME#', spi.sit_name,
          '#SPI_ID#', spi.spi_id,
          '#SGR_APP_ID#', spi.sgr_app_id)),
        c_cr, c_yes);
    end loop;
    if l_error_list is not null then
      l_error_list := utl_text.bulk_replace(sct_const.c_rule_group_error, char_table(
                        '#SGR_NAME#', l_sgr_name,
                        '#ERROR_LIST#', l_error_list));
    end if;

    pit.leave_mandatory;
    return l_error_list;
  end validate_rule_group;


  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2)
  as
    l_ws_id number;
    l_app_id number;
  begin
    pit.enter_mandatory('prepare_rule_group_import', c_pkg);
    select workspace_id, application_id
      into l_ws_id, l_app_id
      from apex_applications
     where alias = p_app_alias
       and workspace = p_workspace;

    apex_application_install.set_workspace_id(l_ws_id);
    apex_application_install.set_application_id(l_app_id);
    pit.leave_mandatory;
  exception
    when no_data_found then
      dbms_output.put_line('Keine Daten gefunden fuer Workspace ' || p_workspace || ' und Alias ' || p_app_alias); 
  end prepare_rule_group_import;


  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in sct_rule_group.sgr_app_id%type)
  as
    l_ws_id number;
  begin
    pit.enter_mandatory('prepare_rule_group_import', c_pkg);
    select workspace_id
      into l_ws_id
      from apex_applications
     where application_id = p_app_id
       and workspace = p_workspace;

    apex_application_install.set_workspace_id(l_ws_id);
    apex_application_install.set_application_id(p_app_id);

    pit.leave_mandatory;
  end prepare_rule_group_import;


  function map_id(
    p_id in number)
    return number
  as
    l_new_id binary_integer;
  begin
    pit.enter_mandatory('map_id', c_pkg);
    if p_id is null then
      init_map;
    else
      if not g_id_map.exists(p_id) then
        g_id_map(p_id) := sct_seq.nextval;
      end if;
      l_new_id := g_id_map(p_id);
    end if;
    pit.leave_mandatory;
    return l_new_id;
  end map_id;


  procedure init_map
  as
  begin
    pit.enter_mandatory('init_map', c_pkg);
    g_id_map.delete;
    pit.leave_mandatory;
  end init_map;


  procedure merge_rule(
    p_sru_id in sct_rule.sru_id%type default null,
    p_sru_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_name in sct_rule.sru_name%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_sru_sort_seq in sct_rule.sru_sort_seq%type,
    p_sru_active in sct_rule.sru_active%type default sct_const.c_true)
  as
  begin
    pit.enter_mandatory('merge_rule', c_pkg);
    merge into sct_rule sru
    using (select p_sru_id sru_id,
                  p_sru_sgr_id sru_sgr_id,
                  p_sru_name sru_name,
                  p_sru_condition sru_condition,
                  p_sru_sort_seq sru_sort_seq,
                  p_sru_active sru_active
             from dual) v
       on (sru.sru_id = v.sru_id
       and sru.sru_sgr_id = v.sru_sgr_id)
     when matched then update set
          sru_name = v.sru_name,
          sru_condition = v.sru_condition,
          sru_sort_seq = v.sru_sort_seq,
          sru_active = v.sru_active
     when not matched then insert(sru_id, sru_sgr_id, sru_name, sru_condition, sru_sort_seq, sru_active)
          values (v.sru_id, v.sru_sgr_id, v.sru_name, v.sru_condition, v.sru_sort_seq, v.sru_active);
    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SQL_ERROR, msg_args('Bei Regel ' || p_sru_name || ': ' || sqlerrm));
  end merge_rule;


  procedure propagate_rule_change(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('propagate_rule_change', c_pkg);
    harmonize_firing_items(p_sgr_id);
    harmonize_sct_page_item(p_sgr_id);
    create_rule_view(p_sgr_id);
    pit.leave_mandatory;
  end propagate_rule_change;


  procedure validate_rule(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2)
  as
    l_data_cols varchar2(32767);
    l_stmt varchar2(32767);
    l_ctx pls_integer;
  begin
    pit.enter_mandatory('validate_rule', c_pkg);
    harmonize_sct_page_item(p_sgr_id);
    l_data_cols := create_column_list(p_sgr_id, sct_const.c_true);
    l_stmt := utl_text.bulk_replace(sct_const.c_rule_validation_template, char_table(
                '#DATA_COLS#', l_data_cols,
                '#CONDITION#', p_sru_condition));
    l_ctx := dbms_sql.open_cursor;
    dbms_sql.parse(l_ctx, l_stmt, dbms_sql.native);
    dbms_sql.close_cursor(l_ctx);
    pit.leave_mandatory;
  exception
    when others then
      p_error := sqlerrm;
  end validate_rule;


  procedure merge_rule_action(
    p_sra_sru_id in sct_rule.sru_id%type,
    p_sra_sgr_id in sct_rule_group.sgr_id%type,
    p_sra_spi_id in sct_page_item.spi_id%type,
    p_sra_sat_id in sct_action_type.sat_id%type,
    p_sra_attribute in sct_rule_action.sra_attribute%type,
    p_sra_attribute_2 in sct_rule_action.sra_attribute_2%type,
    p_sra_sort_seq in sct_rule_action.sra_sort_seq%type,
    p_sra_active in sct_rule_action.sra_active%type default sct_const.c_true)
  as
  begin
    pit.enter_mandatory('merge_rule_action', c_pkg);
    merge into sct_rule_action sra
    using (select p_sra_sru_id sra_sru_id,
                  p_sra_sgr_id sra_sgr_id,
                  p_sra_spi_id sra_spi_id,
                  p_sra_sat_id sra_sat_id,
                  p_sra_attribute sra_attribute,
                  p_sra_attribute_2 sra_attribute_2,
                  p_sra_sort_seq sra_sort_seq,
                  p_sra_active sra_active
             from dual) v
       on (sra.sra_sru_id = v.sra_sru_id
      and sra.sra_sgr_id = v.sra_sgr_id
      and sra.sra_spi_id = v.sra_spi_id
      and sra.sra_sat_id = v.sra_sat_id)
     when matched then update set
          sra_attribute = v.sra_attribute,
          sra_attribute_2 = v.sra_attribute_2,
          sra_sort_seq = v.sra_sort_seq,
          sra_active = v.sra_active
     when not matched then insert (sra_sru_id, sra_sgr_id, sra_spi_id, sra_sat_id, sra_attribute, sra_attribute_2, sra_sort_seq, sra_active)
          values(v.sra_sru_id, v.sra_sgr_id, v.sra_spi_id, v.sra_sat_id, v.sra_attribute, v.sra_attribute_2, v.sra_sort_seq, v.sra_active);
    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SQL_ERROR, msg_args('Bei Aktion ' || p_sra_sru_id || ', ' || p_sra_spi_id || ': ' || sqlerrm));
  end merge_rule_action;


  procedure merge_action_type(
    p_sat_id in sct_action_type.sat_id%type,
    p_sat_name in sct_action_type.sat_name%type,
    p_sat_description in sct_action_type.sat_description%type default null,
    p_sat_pl_sql in sct_action_type.sat_pl_sql%type,
    p_sat_js in sct_action_type.sat_js%type,
    p_sat_default_attribute_1 sct_action_type.sat_default_attribute_1%type default null,
    p_sat_check_attribute_1 sct_action_type.sat_check_attribute_1%type default null,
    p_sat_default_attribute_2 sct_action_type.sat_default_attribute_2%type default null,
    p_sat_check_attribute_2 sct_action_type.sat_check_attribute_2%type default null,
    p_sat_is_editable in sct_action_type.sat_is_editable%type default sct_const.c_true,
    p_sat_raise_recursive in sct_action_type.sat_raise_recursive%type default sct_const.c_true)
  as
  begin
    pit.enter_mandatory('merge_action_type', c_pkg);
    merge into sct_action_type sat
    using (select p_sat_id sat_id,
                  p_sat_name sat_name,
                  p_sat_description sat_description,
                  p_sat_pl_sql sat_pl_sql,
                  p_sat_js sat_js,
                  p_sat_default_attribute_1 sat_default_attribute_1,
                  p_sat_check_attribute_1 sat_check_attribute_1,
                  p_sat_default_attribute_2 sat_default_attribute_2,
                  p_sat_check_attribute_2 sat_check_attribute_2,
                  p_sat_is_editable sat_is_editable,
                  p_sat_raise_recursive sat_raise_recursive
             from dual) v
       on (sat.sat_id = v.sat_id)
     when matched then update set
          sat_name = v.sat_name,
          sat_description = v.sat_description,
          sat_pl_sql = v.sat_pl_sql,
          sat_js = v.sat_js,
          sat_default_attribute_1 = v.sat_default_attribute_1,
          sat_check_attribute_1 = v.sat_check_attribute_1,
          sat_default_attribute_2 = v.sat_default_attribute_2,
          sat_check_attribute_2 = v.sat_check_attribute_2,
          sat_is_editable = v.sat_is_editable,
          sat_raise_recursive = v.sat_raise_recursive
     when not matched then insert(
            sat_id, sat_name, sat_description, sat_pl_sql, sat_js, 
            sat_default_attribute_1, sat_check_attribute_1, sat_default_attribute_2, sat_check_attribute_2,
            sat_is_editable, sat_raise_recursive)
          values (
            v.sat_id, v.sat_name, v.sat_description, v.sat_pl_sql, v.sat_js, 
            v.sat_default_attribute_1, v.sat_check_attribute_1, v.sat_default_attribute_2, v.sat_check_attribute_2,
            v.sat_is_editable, v.sat_raise_recursive);
    pit.leave_mandatory;
  end merge_action_type;

end sct_admin;
/