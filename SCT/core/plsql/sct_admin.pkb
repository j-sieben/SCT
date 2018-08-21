create or replace package body sct_admin
as

  /* Weitere Konstanten siehe SCT_CONST */
  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;
  c_cr constant char(1 byte) := chr(10);
  c_yes constant char(1 byte) := 'Y';
  c_cgtm_type constant varchar2(10) := 'SCT';
  c_default constant varchar2(10) := 'DEFAULT';

  /* Globale Variablen */
  g_offset binary_integer;
  
  -- PL/SQL-Tabelle zum Mappen alter IDs auf neue. Wird beim Kopieren von Regelgruppen verwendet
  type id_map_t is table of binary_integer index by binary_integer;
  g_id_map id_map_t;


  /* Hilfsfunktionen */
  type rule_rec is record(
    sru_id sct_rule.sru_id%type,
    sru_sort_seq sct_rule.sru_sort_seq%type,
    sru_name sct_rule.sru_name%type,
    sru_firing_items sct_rule.sru_firing_items%type,
    sru_fire_on_page_load sct_rule.sru_fire_on_page_load%type,
    item sct_page_item.spi_id%type,
    pl_sql sct_action_type.sat_pl_sql%type,
    js sct_action_type.sat_js%type,
    sra_attribute sct_rule_action.sra_attribute%type,
    sra_attribute_2 sct_rule_action.sra_attribute_2%type,
    sra_on_error sct_rule_action.sra_on_error%type,
    is_first_row number
  );
  
  
  /* Methode zur Erzeugung des Initialisierungscodes aus einem Fetch Row-Prozess
   * %param p_sgr_id ID der Regelgruppe
   * %return SQL-Anweisung, die die Standardelementwerte der Anwendungsseite berechnet
   * %usage Wird verwendet, um fuer eine Regelgruppe Initialisierungscode zu erzeugen
   *        Der Code wird zur Laufzeit ausgefuehrt und initialisiert den Sessionstatus
   *        der Seite.
   */
  function create_initialization_code(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    l_stmt clob;
  begin
      with params as(
           select p_sgr_id sgr_id, c_cgtm_type cgtm_type, 'INITIALIZE_CODE' cgtm_name, chr(10) cr
             from dual)
    select code_generator.generate_text(cursor(
             select cgtm_text template, cgtm_log_text log_template, p.sgr_id,
                    code_generator.generate_text(cursor(
                      select cgtm_text, attribute_02, attribute_03, attribute_04
                        from apex_application_page_proc api
                        join sct_rule_group sgr
                          on api.application_id = sgr.sgr_app_id
                         and api.page_id = sgr.sgr_page_id
                        join code_generator_templates
                          on cgtm_mode = case attribute_04 when 'ROWID' then attribute_04 else c_default end
                       where sgr.sgr_id = 1
                         and api.process_type_code = 'DML_FETCH_ROW'
                         and cgtm_type = p.cgtm_type
                         and cgtm_name = p.cgtm_name
                    ), p.cr, 4) sql_stmt,
                    code_generator.generate_text(cursor(
                      select (select cgtm_text
                                from code_generator_templates
                               where cgtm_type = p.cgtm_type
                                 and cgtm_name = p.cgtm_name
                                 and cgtm_mode = 'VALUE') template, 
                             item_name item, 
                             code_generator.bulk_replace(cgtm_text, char_table(
                               '#CONVERSION#', spi_conversion,
                               '#ITEM#', item_source)) item_source
                        from apex_application_page_items api
                        join sct_rule_group sgr
                          on api.application_id = sgr.sgr_app_id
                         and api.page_id = sgr.sgr_page_id
                        join sct_page_item spi
                          on sgr.sgr_id = spi.spi_sgr_id
                         and api.item_name = spi.spi_id
                        join sct_page_item_type sit
                          on spi.spi_sit_id = sit.sit_id
                        join code_generator_templates
                          on cgtm_mode = sit.sit_id
                       where api.item_source_type = 'Database Column'
                         and sgr.sgr_id = 1
                         and spi.spi_is_required = 1
                         and cgtm_name = 'VIEW_INIT'
                         and cgtm_type = p.cgtm_type
                    ), p.cr, 4) item_stmt
               from code_generator_templates
              where cgtm_type = p.cgtm_type
                and cgtm_name = p.cgtm_name
                and cgtm_mode = 'FRAME'
           )) resultat
      into l_stmt
      from params p;
      
    return l_stmt;
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
    l_initialization_code sct_rule_group.sgr_initialization_code%type;
  begin
    pit.enter_optional('harmonize_sct_page_item', c_pkg);
    
      -- Schritt 1: REQUIRED-Flags entfernen, Mandatory zurueckstellen
      update sct_page_item
         set spi_is_required = 0,
             spi_is_mandatory = 0,
             spi_mandatory_message = null,
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

  /* Methode zur Erzeugung einer Regelview
   * %param p_sgr_id ID der Regelgruppe
   * %usage Wird verwendet, um fuer eine Regelgruppe eine Regelview zu erzeugen.
   *        Die Spaltenliste und die WHERE-Klausel werden durch Hilfsmethoden
   *        zugeliefert.
   * TODO: Refaktorisieren auf CODE_GENERATOR?
   */
  procedure create_rule_view(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
    l_stmt clob;
  begin
    pit.enter_optional('create_rule_view', c_pkg);
    delete_pending_rule_views;

        with params as(
             select p_sgr_id sgr_id,
                    chr(10) cr
               from dual)
      select code_generator.generate_text(cursor(
           select cgtm_text template,
                  cgtm_log_text log_template,
                  sct_const.c_view_name_prefix prefix,
                  p.sgr_id,
                  code_generator.generate_text(cursor(
                    select cgtm_text template,
                           replace(spi_conversion, 'G') conversion, 
                           spi_id item
                      from sct_page_item spi
                      join sct_page_item_type sit
                        on spi.spi_sit_id = sit.sit_id
                      join code_generator_templates cgtm
                        on sit.sit_id = cgtm.cgtm_mode
                     where spi_sgr_id = sgr_id
                       and cgtm_name = 'VIEW_ITEM'
                       and cgtm_type = c_cgtm_type
                       and (spi_is_required = sct_const.c_true
                        or sit.sit_id = 'DOCUMENT')
                     order by spi_id
                  ), ',' || p.cr, 14) column_list,
                  code_generator.generate_text(cursor(
                    select cgtm_text template,
                           sru_id, sru_name, sru_condition, sru_firing_items,
                           row_number() over (order by sru_id) sort_seq
                      from sct_rule
                     cross join code_generator_templates
                     where cgtm_name = 'JOIN_CLAUSE'
                       and cgtm_type = c_cgtm_type
                       and cgtm_mode = c_default
                       and sru_sgr_id in (0, p.sgr_id)
                       and sru_active = sct_const.c_true
                     order by sru_id
                  ), p.cr || '           or ') where_clause
             from code_generator_templates
            where cgtm_type = c_cgtm_type
              and cgtm_name = 'RULE_VIEW'
              and cgtm_mode = c_default
         )) resultat
    into l_stmt
    from params p;
    
    execute immediate l_stmt;

    pit.leave_optional;
  exception
    when others then
      pit.sql_exception(msg.SCT_VIEW_CREATION, msg_args(sqlerrm, l_stmt));
  end create_rule_view;


  /* Prozeduren fuer den DDL-Export */  
  /* Hilfsmethode zur Renummerierung der Regeln und Aktionen
   * %param p_sgr_id Regelgruppen-ID
   * %usage Die Methode wird bei jeder Aenderung der Regelgruppe oder Einzelregel
   *        aufgerufen, um die Nummerierung automatisiert in 10er-Schritten zu bereinigen
   */
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
            where sru_sgr_id = p_sgr_id
              and sru_sgr_id > 0) v
       on (sru.sru_id = v.sru_id and sru.sru_sgr_id = v.sru_sgr_id)
     when matched then update set
          sru_sort_seq = v.sru_sort_seq;

    -- Aktionen neu nummerieren
    merge into sct_rule_action sra
    using (select rowid row_id,
                  row_number() over (partition by sra_sru_id order by sra_on_error, sra_sort_seq) * 10 sra_sort_seq
             from sct_rule_action
            where sra_sgr_id = p_sgr_id) v
       on (sra.rowid = v.row_id)
     when matched then update set
          sra_sort_seq = v.sra_sort_seq;

    -- Wird aus AJAX aufgerufen, daher hier Aenderungen festschreiben
    commit;
    pit.leave_mandatory;
  end resequence_rule_group;


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
    l_stmt clob;
  begin
    pit.enter_optional('read_rule_group', c_pkg);
    
      with params as(
           select p_sgr_id sgr_id,
                  'EXPORT_RULE_GROUP' cgtm_name,
                  c_cgtm_type cgtm_type
             from dual)
    select code_generator.generate_text(cursor(
             -- Skriptrahmen und Anlage der Regelgruppe
             select cgtm_text template, cgtm_log_text log_template,
                    sgr.*,
                    -- Einzelregeln
                    code_generator.generate_text(cursor(
                      select cgtm_text template,
                             sru.*,
                             -- Regelaktionen der Einzelregeln
                             code_generator.generate_text(cursor(
                               select cgtm_text template,
                                      sra.*
                                 from sct_rule_action sra
                                cross join code_generator_templates
                                where cgtm_name = p.cgtm_name
                                  and cgtm_type = p.cgtm_type
                                  and cgtm_mode = 'RULE_ACTION'
                                  and sra.sra_sgr_id = p.sgr_id
                                  and sra.sra_sru_id = sru.sru_id
                             )) rule_actions
                        from sct_rule sru
                       cross join code_generator_templates
                       where cgtm_name = p.cgtm_name
                         and cgtm_type = p.cgtm_type
                         and cgtm_mode = 'RULE'
                         and sru.sru_sgr_id = p.sgr_id
                    )) rules,
                    -- APEX-Actions
                    code_generator.generate_text(cursor(
                      select cgtm_text template,
                             saa.*
                        from sct_apex_action saa
                        join code_generator_templates
                          on cgtm_mode = 'APEX_ACTION_' || saa.saa_type
                       where cgtm_name = p.cgtm_name
                         and cgtm_type = p.cgtm_type
                         and saa.saa_sgr_id = p.sgr_id
                    )) apex_actions
               from code_generator_templates
              cross join sct_rule_group sgr
              where cgtm_name = p.cgtm_name
                and cgtm_type = p.cgtm_type
                and cgtm_mode = c_default
                and sgr.sgr_id = p.sgr_id
           )) resultat
      into l_stmt
      from params p;

    pit.leave_optional;
    return l_stmt;
  end read_rule_group;
  
  
  /* Initialisierungsmethode */
  procedure initialize
  as
  begin
    g_offset := 0;
  end;


  /* INTERFACE */
  procedure set_app_offset(
    p_offset in binary_integer)
  as
  begin
    g_offset := p_offset;
  end set_app_offset;


  /* Oeffentliche DDL-Methoden */
  procedure merge_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_sgr_description in sct_rule_group.sgr_description%type,
    p_sgr_with_recursion in sct_rule_group.sgr_with_recursion%type,
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
                  upper(p_sgr_name) sgr_name,
                  p_sgr_description sgr_description,
                  p_sgr_app_id + g_offset sgr_app_id,
                  p_sgr_page_id sgr_page_id,
                  p_sgr_with_recursion sgr_with_recursion,
                  p_sgr_active sgr_active
             from dual) v
       on (s.sgr_id = v.sgr_id and s.sgr_app_id = v.sgr_app_id)
     when matched then update set
          sgr_name = v.sgr_name,
          sgr_description = v.sgr_description,
          sgr_page_id = v.sgr_page_id,
          sgr_with_recursion = v.sgr_with_recursion,
          sgr_active = v.sgr_active
     when not matched then insert(sgr_id, sgr_name, sgr_description, sgr_app_id, sgr_page_id, sgr_with_recursion, sgr_active)
          values(v.sgr_id, v.sgr_name, v.sgr_description, v.sgr_app_id, v.sgr_page_id, v.sgr_with_recursion, v.sgr_active);

    harmonize_sct_page_item(l_sgr_id);
    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SCT_MERGE_RULE_GROUP, msg_args(to_char(l_sgr_id)));
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

     insert into sct_rule_action(sra_sgr_id, sra_sru_id, sra_spi_id, sra_sat_id, sra_on_error, sra_raise_recursive, sra_attribute, sra_attribute_2, sra_sort_seq, sra_active, sra_comment)
      select map_id(sra_sgr_id), map_id(sra_sru_id), sra_spi_id, sra_sat_id, sra_on_error, sra_raise_recursive,
             replace(upper(sra_attribute), 'P' || p_sgr_page_id || '_',  'P' || p_sgr_page_to || '_'),
             replace(upper(sra_attribute_2), 'P' || p_sgr_page_id || '_',  'P' || p_sgr_page_to || '_'),
             sra_sort_seq, sra_active, sra_comment
        from sct_rule_action
       where sra_sgr_id = l_sgr_id;
    end if;
    pit.leave_mandatory;
  end copy_rule_group;
  
  
  function get_app_alias(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    l_app_alias varchar2(10 char);
  begin
    return null;
  end get_app_alias;
  
  
  function export_all_rule_groups
    return clob
  as
    cursor rule_group_cur is
      select sgr_id
        from sct_rule_group;
    l_stmt clob;
    c_sgr_delimiter constant varchar2(20) := c_cr || c_cr || c_cr;
  begin
    dbms_lob.createTemporary(l_stmt, false, dbms_lob.call);
    
    -- Exportheader starten
    dbms_lob.append(l_stmt, replace(sct_const.c_export_start_template, '#CR#', sct_const.c_cr));

    -- Einzelne Regelgruppen berechnen
    for sgr in rule_group_cur loop
      dbms_lob.append(l_stmt, read_rule_group(sgr.sgr_id));
    end loop;

    -- Export beenden
    dbms_lob.append(l_stmt, replace(sct_const.c_export_end_template, '#CR#', sct_const.c_cr));
    
    return l_stmt;
  end export_all_rule_groups;


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
    dbms_lob.append(l_stmt, replace(sct_const.c_export_start_template, '#CR#', sct_const.c_cr));

    -- Einzelne Regelgruppen berechnen
    for sgr in rule_group_cur(p_sgr_app_id) loop
      dbms_lob.append(l_stmt, read_rule_group(sgr.sgr_id));
    end loop;

    dbms_lob.append(l_stmt, replace(sct_const.c_export_end_template, '#CR#', sct_const.c_cr));
    pit.leave_mandatory;

    return l_stmt;
  end export_rule_groups;


  function export_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return clob
  as
    l_stmt clob;
  begin
    pit.enter_mandatory('export_rule_group', c_pkg);
    
    l_stmt := read_rule_group(p_sgr_id);
    
    pit.leave_mandatory;
    return l_stmt;
  end export_rule_group;
  
  
  function export_action_types(
    p_core_flag in boolean default false)
    return clob
  as
    l_stmt clob;
    l_sat_is_editable sct_action_type.sat_is_editable%type := 1;
  begin
    pit.enter_mandatory('export_action_types', c_pkg);
    
    if p_core_flag then
      l_sat_is_editable := 0;
    end if;
    
    pit.enter_optional('read_action_type', c_pkg);
      with params as(
           select cgtm_text template, cgtm_type, cgtm_name, l_sat_is_editable is_editable
             from code_generator_templates
            where cgtm_type = c_cgtm_type
              and cgtm_name = 'ACTION_TYPE'
              and cgtm_mode = 'FRAME')
    select code_generator.generate_text(cursor(
             select p.template,
                    code_generator.generate_text(cursor(
                      select cgtm_text template, sat.*
                        from sct_action_type sat
                       cross join code_generator_templates t
                       where sat_is_editable = p.is_editable
                         and t.cgtm_type = p.cgtm_type
                         and t.cgtm_name = p.cgtm_name
                         and t.cgtm_mode = c_default)) action_types
               from dual
           )) resultat
      into l_stmt
      from params p;

    pit.leave_optional;
    return l_stmt;
  end export_action_types;


  function validate_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    l_stmt clob;
    l_has_errors binary_integer;
  begin
    pit.enter_mandatory('validate_rule_group', c_pkg);
    harmonize_sct_page_item(p_sgr_id);
    
    select count(*)
      into l_has_errors
      from sct_page_item
     where spi_sgr_id = p_sgr_id
       and spi_has_error = 1;
       
    if l_has_errors = 1 then
        with params as(
             select cgtm_text template, cgtm_type, cgtm_name, p_sgr_id sgr_id
               from code_generator_templates
              where cgtm_type = c_cgtm_type
                and cgtm_name = 'PAGE_ITEM_ERROR'
                and cgtm_mode = 'FRAME')
      select code_generator.generate_text(cursor(
               select p.template, g.sgr_name,
                      code_generator.generate_text(cursor(
                        select cgtm_text template, sgr.sgr_name, sgr.sgr_app_id, spi.spi_id, sit.sit_name
                          from sct_page_item spi
                          join sct_page_item_type sit
                            on spi.spi_sit_id = sit.sit_id
                          join sct_rule_group sgr
                            on spi.spi_sgr_id = sgr.sgr_id
                         cross join code_generator_templates t
                         where sgr.sgr_id = p.sgr_id
                           and spi.spi_has_error = 1 --sct_const.c_true
                           and t.cgtm_type = p.cgtm_type
                           and t.cgtm_name = p.cgtm_name
                           and t.cgtm_mode = c_default)) error_list
                 from sct_rule_group g
                where g.sgr_id = p.sgr_id
             )) resultat
        into l_stmt
        from params p;
    end if;
    
    pit.leave_mandatory;
    return l_stmt;
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
    apex_application_install.set_application_id(l_app_id + g_offset);
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
    apex_application_install.set_application_id(p_app_id + g_offset);

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
    p_sru_fire_on_page_load in sct_rule.sru_fire_on_page_load%type,
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
                  p_sru_fire_on_page_load sru_fire_on_page_load,
                  p_sru_sort_seq sru_sort_seq,
                  p_sru_active sru_active
             from dual) v
       on (sru.sru_id = v.sru_id
       and sru.sru_sgr_id = v.sru_sgr_id)
     when matched then update set
          sru_name = v.sru_name,
          sru_condition = v.sru_condition,
          sru_fire_on_page_load = v.sru_fire_on_page_load,
          sru_sort_seq = v.sru_sort_seq,
          sru_active = v.sru_active
     when not matched then insert(sru_id, sru_sgr_id, sru_name, sru_condition, sru_fire_on_page_load, sru_sort_seq, sru_active)
          values (v.sru_id, v.sru_sgr_id, v.sru_name, v.sru_condition, v.sru_fire_on_page_load, v.sru_sort_seq, v.sru_active);
    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SCT_MERGE_RULE, msg_args(p_sru_name));
  end merge_rule;


  procedure propagate_rule_change(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('propagate_rule_change', c_pkg);
    harmonize_firing_items(p_sgr_id);
    harmonize_sct_page_item(p_sgr_id);
    create_rule_view(p_sgr_id);
    resequence_rule_group(p_sgr_id);
    pit.leave_mandatory;
  end propagate_rule_change;


  procedure validate_rule(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2)
  as
    l_stmt clob;
    l_ctx pls_integer;
  begin
    pit.enter_mandatory('validate_rule', c_pkg);
    harmonize_sct_page_item(p_sgr_id);
      with params as(
            select 1 sgr_id,
                  'P8_EXPORT_TYPE = ''APP''' condition,
                  chr(10) cr
             from dual)
    select code_generator.generate_text(cursor(
             select cgtm_text template,
                    cgtm_log_text log_template,
                    sct_const.c_view_name_prefix prefix,
                    p.sgr_id,
                    p.condition,
                    code_generator.generate_text(cursor(
                      select cgtm_text template,
                             replace(spi_conversion, 'G') conversion, 
                             spi_id item
                        from sct_page_item spi
                        join sct_page_item_type sit
                          on spi.spi_sit_id = sit.sit_id
                        join code_generator_templates cgtm
                          on sit.sit_id = cgtm.cgtm_mode
                       where spi_sgr_id = sgr_id
                         and cgtm_name = 'VIEW_ITEM'
                         and cgtm_type = c_cgtm_type
                         and (spi_is_required = sct_const.c_true 
                          or sit.sit_id = 'DOCUMENT')
                       order by spi_id
                    ), ',' || p.cr, 14) column_list
               from code_generator_templates
              where cgtm_type = c_cgtm_type
                and cgtm_name = 'RULE_VALIDATION'
                and cgtm_mode = c_default
           )) resultat
      into l_stmt
      from params p;
      
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
    p_sra_on_error in sct_rule_action.sra_on_error%type default sct_const.c_false,
    p_sra_raise_recursive in sct_rule_action.sra_raise_recursive%type default sct_const.c_true,
    p_sra_active in sct_rule_action.sra_active%type default sct_const.c_true,
    p_sra_comment in sct_rule_action.sra_comment%type default null)
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
                  p_sra_on_error sra_on_error,
                  p_sra_raise_recursive sra_raise_recursive,
                  p_sra_active sra_active,
                  p_sra_comment sra_comment
             from dual) v
       on (sra.sra_sru_id = v.sra_sru_id
      and sra.sra_sgr_id = v.sra_sgr_id
      and sra.sra_spi_id = v.sra_spi_id
      and sra.sra_sat_id = v.sra_sat_id
      and sra.sra_on_error = v.sra_on_error)
     when matched then update set
          sra_attribute = v.sra_attribute,
          sra_attribute_2 = v.sra_attribute_2,
          sra_sort_seq = v.sra_sort_seq,
          sra_raise_recursive = v.sra_raise_recursive,
          sra_active = v.sra_active,
          sra_comment = v.sra_comment
     when not matched then insert (sra_sru_id, sra_sgr_id, sra_spi_id, sra_sat_id, sra_attribute, sra_attribute_2, sra_sort_seq, sra_on_error, sra_raise_recursive, sra_active, sra_comment)
          values(v.sra_sru_id, v.sra_sgr_id, v.sra_spi_id, v.sra_sat_id, v.sra_attribute, v.sra_attribute_2, v.sra_sort_seq, v.sra_on_error, v.sra_raise_recursive, v.sra_active, v.sra_comment);
    pit.leave_mandatory;
  exception
    when others then
      pit.stop(msg.SCT_MERGE_RULE_ACTION, msg_args(to_char(p_sra_sru_id), to_char( p_sra_spi_id)));
  end merge_rule_action;
  

  procedure delete_apex_action(    
    p_row sct_apex_action%rowtype)  
  as  
  begin    
    delete from sct_apex_action     
     where saa_sgr_id = p_row.saa_sgr_id
       and saa_name = p_row.saa_name;  
  end delete_apex_action;  
  
  
  procedure merge_apex_action(   
    p_row sct_apex_action%rowtype)  
  as  
  begin    
    merge into sct_apex_action t    
    using (select p_row.saa_sgr_id saa_sgr_id,
                  p_row.saa_name saa_name,
                  p_row.saa_type saa_type,
                  p_row.saa_label saa_label,
                  p_row.saa_on_label saa_on_label,
                  p_row.saa_off_label saa_off_label,
                  p_row.saa_context_label saa_context_label,
                  p_row.saa_icon saa_icon,
                  p_row.saa_icon_type saa_icon_type,
                  p_row.saa_title saa_title,
                  p_row.saa_shortcut saa_shortcut,
                  p_row.saa_href saa_href,
                  p_row.saa_action saa_action,
                  p_row.saa_get saa_get,
                  p_row.saa_set saa_set,
                  p_row.saa_choices saa_choices,
                  p_row.saa_label_classes saa_label_classes,
                  p_row.saa_label_start_classes saa_label_start_classes,
                  p_row.saa_label_end_classes saa_label_end_classes,
                  p_row.saa_item_wrap_class saa_item_wrap_class
             from dual) s       
       on (t.saa_sgr_id = s.saa_sgr_id
      and t.saa_name = s.saa_name)    
     when matched then update set               
            t.saa_type = s.saa_type,  
            t.saa_label = s.saa_label,
            t.saa_on_label = s.saa_on_label,
            t.saa_off_label = s.saa_off_label,
            t.saa_context_label = s.saa_context_label,
            t.saa_icon = s.saa_icon,
            t.saa_icon_type = s.saa_icon_type,
            t.saa_title = s.saa_title,
            t.saa_shortcut = s.saa_shortcut,
            t.saa_href = s.saa_href,
            t.saa_action = s.saa_action,
            t.saa_get = s.saa_get,
            t.saa_set = s.saa_set,
            t.saa_choices = s.saa_choices,
            t.saa_label_classes = s.saa_label_classes,
            t.saa_label_start_classes = s.saa_label_start_classes,
            t.saa_label_end_classes = s.saa_label_end_classes,
            t.saa_item_wrap_class = s.saa_item_wrap_class 
     when not matched then insert(            
            t.saa_sgr_id, t.saa_name, t.saa_type, t.saa_label, t.saa_on_label, t.saa_off_label, t.saa_context_label, t.saa_icon, 
            t.saa_icon_type, t.saa_title, t.saa_shortcut, t.saa_href, t.saa_action, t.saa_get, t.saa_set, t.saa_choices, 
            t.saa_label_classes, t.saa_label_start_classes, t.saa_label_end_classes, t.saa_item_wrap_class)          
          values(            
            s.saa_sgr_id, s.saa_name, s.saa_type, s.saa_label, s.saa_on_label, s.saa_off_label, s.saa_context_label, s.saa_icon, 
            s.saa_icon_type, s.saa_title, s.saa_shortcut, s.saa_href, s.saa_action, s.saa_get, s.saa_set, s.saa_choices, 
            s.saa_label_classes, s.saa_label_start_classes, s.saa_label_end_classes, s.saa_item_wrap_class);  
  end merge_apex_action;
  
  
  procedure merge_apex_action(    
    p_saa_sgr_id in sct_apex_action.saa_sgr_id%type,
    p_saa_name in sct_apex_action.saa_name%type,
    p_saa_type in sct_apex_action.saa_type%type,
    p_saa_label in sct_apex_action.saa_label%type,
    p_saa_on_label in sct_apex_action.saa_on_label%type,
    p_saa_off_label in sct_apex_action.saa_off_label%type,
    p_saa_context_label in sct_apex_action.saa_context_label%type,
    p_saa_icon in sct_apex_action.saa_icon%type,
    p_saa_icon_type in sct_apex_action.saa_icon_type%type,
    p_saa_title in sct_apex_action.saa_title%type,
    p_saa_shortcut in sct_apex_action.saa_shortcut%type,
    p_saa_href in sct_apex_action.saa_href%type,
    p_saa_action in sct_apex_action.saa_action%type,
    p_saa_get in sct_apex_action.saa_get%type,
    p_saa_set in sct_apex_action.saa_set%type,
    p_saa_choices in sct_apex_action.saa_choices%type,
    p_saa_label_classes in sct_apex_action.saa_label_classes%type,
    p_saa_label_start_classes in sct_apex_action.saa_label_start_classes%type,
    p_saa_label_end_classes in sct_apex_action.saa_label_end_classes%type,
    p_saa_item_wrap_class in sct_apex_action.saa_item_wrap_class%type)   
  as    
    l_row sct_apex_action%rowtype;  
  begin    
    l_row.saa_sgr_id := p_saa_sgr_id;
    l_row.saa_name := p_saa_name;
    l_row.saa_type := p_saa_type;
    l_row.saa_label := p_saa_label;
    l_row.saa_on_label := p_saa_on_label;
    l_row.saa_off_label := p_saa_off_label;
    l_row.saa_context_label := p_saa_context_label;
    l_row.saa_icon := p_saa_icon;
    l_row.saa_icon_type := p_saa_icon_type;
    l_row.saa_title := p_saa_title;
    l_row.saa_shortcut := p_saa_shortcut;
    l_row.saa_href := p_saa_href;
    l_row.saa_action := p_saa_action;
    l_row.saa_get := p_saa_get;
    l_row.saa_set := p_saa_set;
    l_row.saa_choices := p_saa_choices;
    l_row.saa_label_classes := p_saa_label_classes;
    l_row.saa_label_start_classes := p_saa_label_start_classes;
    l_row.saa_label_end_classes := p_saa_label_end_classes;
    l_row.saa_item_wrap_class := p_saa_item_wrap_class;    
    
    merge_apex_action(l_row);  
  end merge_apex_action;
  
  
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
  
begin
  initialize;
end sct_admin;
/
