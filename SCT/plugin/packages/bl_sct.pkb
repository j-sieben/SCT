create or replace package body bl_sct 
as

  /* Private constants*/
  C_PKG constant varchar2(30 byte) := $$PLSQL_UNIT;
  C_PARAM_GROUP constant varchar2(30 byte) := 'SCT';
  C_MAX_LENGTH binary_integer := 32000;
  
  C_JS_CODE constant binary_integer := 1;
  C_JS_RULE_ORIGIN constant binary_integer := 2;
  C_JS_DEBUG constant binary_integer := 3;
  C_JS_COMMENT constant binary_integer := 4;
  
  C_NUMBER_ITEM constant sct_page_item_type.sit_id%type := 'NUMBER_ITEM';
  C_DATE_ITEM constant sct_page_item_type.sit_id%type := 'DATE_ITEM';
  C_REGISTER_OBSERVER constant sct_action_type.sat_id%type := 'REGISTER_OBSERVER';
  C_DELIMITER constant char(1 byte) := ',';
  
  C_BIND_JSON_TEMPLATE constant varchar2(100) := '[#JSON#]';
  C_BIND_JSON_ELEMENT constant varchar2(100) := '{"id":"#ID#","event":"#EVENT#"}';
  C_PAGE_JSON_ELEMENT constant varchar2(100) := '{"id":"#ID#","value":"#VALUE#"}';  
  C_JS_NAMESPACE constant varchar2(50 byte) := 'de.condes.plugin.sct';
  C_JS_SCRIPT_START constant varchar2(300) := q'^<script>#CR#  /* Vorbereitung: #DURATION#hsec*/#CR#  #JS_FILE#.setItemValues(#ITEM_JSON#);#CR#  #JS_FILE#.setErrors(#ERROR_JSON#);^';
  C_JS_SCRIPT_END constant varchar2(30) := q'^</script>^';

  /* Private types */
  type item_stack_t is table of number index by varchar2(50);
  
  -- Fehlerstack
  type error_stack_t is table of varchar2(32767) index by binary_integer;
  
  type js_rec is record(
    script varchar2(32767),
    hash raw(2000),
    debug_level binary_integer);
    
  type js_list is table of js_rec index by binary_integer;
  
  -- Rekursionsstack
  -- Der Rekursionsstack speichert die Seitenelemente, die durch die Regeln geaendert wurden,
  -- um anschließend auch fuer diese Elemente die Regelpruefung aufzurufen.
  type recursive_stack_t is table of number index by sct_page_item.spi_id%type;
  
  type level_length_t is table of binary_integer index by binary_integer;
  
  -- Record zur Aufnahme der Plugin-Attribute
  type param_rec is record(
    id number,                              -- Interne ID des Records, falls n Instanzen aufgerufen werden
    sgr_id sct_rule_group.sgr_id%type,      -- ID der Regelgruppe
    firing_item sct_page_item.spi_id%type,  -- Element das die Bearbeitung ausloest (oder DOCUMENT)
    error_dependent_buttons varchar2(2000), -- Liste der Buttons, die im Fehlerfall deaktiviert werden
    bind_items item_stack_t,                -- Liste der Elemente, deren Events gebunden werden
    page_items item_stack_t,                -- Liste der Elemente, deren Wert sich im Session State veraendert hat
    firing_items item_stack_t,              -- Liste der Elemente, die mit FIRING_ITEM durch Regeln verbunden sind
    error_stack error_stack_t,              -- Liste der Fehler, die bislang aufgelaufen sind
    recursive_stack recursive_stack_t,      -- Liste der rekursiven Elemente, die geprueft werden sollen
    js_action_stack js_list,                -- Liste der JavaScript-Aktionen, die durch diesen Regellauf ausgefuehrt werden sollen
    level_length level_length_t,            -- kumulierte Laenge der JS-Aktion auf Level 0 - n
    recursive_level number,                 -- Aktuelle Ebene der Rekursion, die bearbeitet wird
    allow_recursion boolean,                -- Flag, das anzeigt, ob Rekursion fuer diese Regelgruppe erlaubt ist
    notification_stack varchar2(32767),     -- Liste der Benachrichtigungen, die ausgegebenen werden sollen
    stop_flag boolean,                      -- Wenn dieses Flag gesetzt wird, stoppt die Weiterverarbeitung der Regel
    now pls_integer,                        -- Zeitstempel dieser Regelgruppe, wird zum Stoppen der Ausfuehrungsdauer verwendet
    with_comments boolean                   -- 
  );
  
  
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
    sru_on_error sct_rule_action.sra_on_error%type,
    is_first_row number
  );

  /* Privat global variables */
  g_with_comments boolean;
  g_has_errors boolean;
  g_param param_rec;
  
  g_recursion_limit binary_integer;
  g_recursion_loop_is_error boolean;
  
  procedure append(
    p_text in out nocopy varchar2,
    p_what in varchar2)
  as
    c_delimiter constant varchar2(10) := sct_admin.C_CR || '  ';
  begin
    p_text := p_text || c_delimiter || replace(p_what, sct_admin.c_cr, c_delimiter);
  end append;    
  
  
  function get_json_from_items
    return varchar2
  as
    l_json varchar2(32767);
    l_item varchar2(50);
  begin
    
    l_item := g_param.page_items.first;
    while l_item is not null loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(c_page_json_element, char_table(
          '#ID#', l_item,
          '#VALUE#', htf.escape_sc(get_char(l_item)))),
        C_DELIMITER, true);
      l_item := g_param.page_items.next(l_item);
    end loop;
    
    l_json := replace(c_bind_json_template, '#JSON#', l_json);
    
    return l_json;
  end get_json_from_items;
  
  
  function get_json_from_errors
    return varchar2
  as
    l_json varchar2(32767);
    l_count binary_integer;
  begin
    l_count := g_param.error_stack.count;
    for i in 1 .. l_count loop
      if length(g_param.error_stack(i)) + length(l_json) <= C_MAX_LENGTH then
        -- TODO: Refaktorisierung auf CLOB, um Laengenlimit zu umgehen
        utl_text.append(l_json, g_param.error_stack(i), C_DELIMITER, true);
      end if;      
    end loop;
    
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    to_char(l_count) error_count,
                    g_param.error_dependent_buttons dependent_buttons,
                    l_json json_errors
               from utl_text_templates
              where uttm_type = 'SCT'
                and uttm_name = 'JSON_ERRORS'
                and uttm_mode = 'FRAME'))
      into l_json
      from dual;
                
    return l_json;
  end get_json_from_errors;
  
  
  procedure add_java_script(
    p_script in varchar2,
    p_debug_level in binary_integer default C_JS_CODE)
  as
    C_COMMENT_OUT constant varchar2(20) := '// (double) ';
    l_js js_rec;
    l_length binary_integer;
  begin    
    if p_script is not null then
      select p_script, standard_hash(p_script), p_debug_level
        into l_js
        from dual;
        
      -- comment out double JavaScript entries
      for i in 1 .. g_param.js_action_stack.count + 1 loop
        if g_param.js_action_stack.exists(i) then
          if g_param.js_action_stack(i).debug_level = C_JS_CODE and g_param.js_action_stack(i).hash = l_js.hash then
            g_param.js_action_stack(i).script := C_COMMENT_OUT || g_param.js_action_stack(i).script;
            g_param.js_action_stack(i).hash := null;
            g_param.js_action_stack(i).debug_level := C_JS_DEBUG;
          end if;
        end if;
      end loop;
      
      -- persist JavaScript action
      g_param.js_action_stack(g_param.js_action_stack.count + 1) := l_js;
      
      -- Caculate length of comments and scripts
      g_param.level_length(l_js.debug_level) := g_param.level_length(l_js.debug_level) + length(l_js.script);
    end if;
  end add_java_script;
  
  
  function get_java_script
    return varchar2
  as
    l_js varchar2(32767);
    l_with_comments binary_integer;
    l_length binary_integer := 1;
    l_max_level binary_integer := 0;
  begin
    
    l_js := utl_text.bulk_replace(C_JS_SCRIPT_START, char_table(
              '#CR#', sct_admin.C_CR,
              '#ITEM_JSON#', get_json_from_items,
              '#ERROR_JSON#',  get_json_from_errors,
              '#FIRING_ITEMS#', join_list(c_firing_items),
              '#JS_FILE#', C_JS_NAMESPACE,
              '#DURATION#', to_char(dbms_utility.get_time - g_param.now)));
                        
    if g_param.js_action_stack.count > 0 then
      for i in 1 .. g_param.level_length.count loop
        if g_param.level_length.exists(i) then
          l_length := l_length + g_param.level_length(i);
          if l_length > C_MAX_LENGTH then
            append(l_js, pit.get_message_text(msg.SCT_OUTPUT_REDUCED, msg_args(to_char(l_max_level))));
            exit;
          end if;
          l_max_level := i;
        end if;
      end loop;
      
      for i in 1 .. g_param.js_action_stack.count + 1 loop
        if g_param.js_action_stack.exists(i) then
          -- avoid buffer overflow and surpress comments if required
          if length(l_js) + length(g_param.js_action_stack(i).script) <= C_MAX_LENGTH 
             and coalesce(g_param.js_action_stack(i).debug_level, C_JS_CODE) <= l_max_level
          then
            append(l_js, g_param.js_action_stack(i).script);
          else
            append(l_js, pit.get_message_text(msg.SCT_OUTPUT_CLIPPED));
            exit; 
          end if;
        end if;
      end loop;
    end if;
    
    l_js := l_js || sct_admin.c_cr || C_JS_SCRIPT_END;
    dbms_output.put_line(l_js);
    return l_js;
  end get_java_script;

  
  /* Gets message text from PIT to integrate it as a comment in the response
   * %param  p_msg       Message ID
   * %param [p_msg_args] Optional message params
   * %return Message in the respective language
   * %usage  If in debug mode, this method adds descriptive messages to the response
   */
  procedure add_comment(
    p_msg pit_message.pms_name%type,
    p_msg_args msg_args default null)
  as
  begin
    if g_with_comments then
      add_java_script(pit.get_message_text(p_msg, p_msg_args), C_JS_COMMENT);
    end if;
  end add_comment;
  

  /* Helper to analyze an attribute
   * %param  p_param  attribute value to analyze
   * %return result of the analysis, either static or dynamic 
   * %usage  Used to evaluate an attribute. The following syntactical possibilities exist:
   *         - jQuery CSS selector
   *         - jQuery ID selector
   *         - static string, encapsulated in single quotes
   *         - PL/SQL-Block without single quotes, with or without terminating semicolon
   */
  function analyze_parameter(
    p_item in varchar2,
    p_replacement in varchar2,
    p_selector in varchar2,
    p_param in sct_rule_action.sra_attribute_2%type)
    return varchar2
  as
    l_result varchar2(32767) := p_param;
  begin
    if p_item = sct_admin.C_NO_FIRING_ITEM then
      if p_param is not null and instr(p_replacement, p_selector) > 0 then 
        case substr(p_param, 1, 1)
          when '.' then null;
          when '#' then null;
          when '''' then l_result := trim('''' from p_param);
          else execute immediate 'begin :x := ' || trim(';' from p_param) || '; end;' using out l_result;
        end case;
      else
        l_result := p_param;
      end if;
    else
      l_result := p_item;
    end if;
    return l_result;
  end analyze_parameter;
  
  
  /* Hilfsprozedur zum Formatieren von ausloesenden Elementen.
   * %usage Die Methode analysiert, ob das ausloesende Element eine Formatmaske
   *        hinterlegt hat. Falls ja,
   *        - wird das Element testweise konvertiert, um Fehler abzufangen
   *        - wird das konvertierte Element mit der Formatierung in eine Zeichen-
   *          kette konvertiert und im Session State gespeichert, um auf der 
   *          Oberflaeche formatiert angezeigt zu werden.
   */
  procedure format_firing_item
  as
    l_spi_sit_id sct_page_item.spi_sit_id%type;
    l_spi_conversion sct_page_item.spi_conversion%type;
    l_number_val number;
    l_date_val date;
  begin
    
    -- Sollte fuer das ausloesende Element eine Formatierungsvorlage existieren,
    -- wird diese hier angewendet und geprueft
    select spi_sit_id, spi_conversion
      into l_spi_sit_id, l_spi_conversion
      from sct_page_item
     where spi_sgr_id = g_param.sgr_id
       and spi_id = g_param.firing_item
       and spi_conversion is not null;
    
    case l_spi_sit_id
      when C_NUMBER_ITEM then
        -- Konvertiere in Zahl
        l_number_val := get_number(g_param.firing_item, replace(l_spi_conversion, 'G'));
        
        -- Konvertierung erfolgreich, setze formatierten String in Session State
        set_session_state(g_param.firing_item, to_char(l_number_val, l_spi_conversion), sct_admin.C_TRUE, null);
      when C_DATE_ITEM then
        -- Konvertiere in Datum
        l_date_val := get_date(g_param.firing_item, l_spi_conversion);
        -- Konvertierung erfolgreich, setze formatierten String in Session State
        set_session_state(g_param.firing_item, to_char(l_date_val, l_spi_conversion), sct_admin.C_TRUE, null);
      else
        pit.stop(msg.SCT_UNEXPECTED_CONV_TYPE, msg_args(l_spi_sit_id));
    end case;
  exception
    when no_data_found then
      -- Keine Formatmaske gefunden, ignorieren
      null;
  end format_firing_item;


  function check_recursion(
    p_rule in rule_rec)
    return varchar2
  as
  begin
    case when p_rule.item = sct_admin.C_NO_FIRING_ITEM 
          and p_rule.sru_fire_on_page_load = sct_admin.C_TRUE
      then return sct_admin.C_FALSE;
      else return sct_admin.C_TRUE;
    end case;
  end check_recursion;
  

  /* Hilfsmethode zur Verarbeitung des PL/SQL-Codes */
  procedure handle_pl_sql_code(
    p_rule in out nocopy rule_rec)
  as
    C_PLSQL_ITEM_VALUE_TEMPLATE constant varchar2(100 byte) := q'~v('#ITEM#')~';
    l_plsql_code varchar2(32767);
  begin
    -- create PL/QSL code from template
    if p_rule.pl_sql is not null then
      l_plsql_code := utl_text.bulk_replace(trim(';' from p_rule.pl_sql), char_table(
                        '#ATTRIBUTE#', p_rule.sra_attribute,
                        '#ATTRIBUTE_2#', p_rule.sra_attribute_2,
                        '#ALLOW_RECURSION#', check_recursion(p_rule),
                        '#ITEM_VALUE#', C_PLSQL_ITEM_VALUE_TEMPLATE,
                        '#ITEM#', p_rule.item,
                        '#CR#', sct_admin.c_cr));
      l_plsql_code := replace('begin #CODE#; commit; end;', '#CODE#', l_plsql_code);

      -- Execute PL/SQL code. Stop if an error occurs
      begin
        execute immediate l_plsql_code;
      exception
        when others then
          -- Stop further execution for non exception handlers
          p_rule.sru_on_error := sct_admin.C_TRUE;
          -- Display error
          register_error(p_rule.item, msg.SCT_UNHANDLED_EXCEPTION, msg_args(apex_escape.json(l_plsql_code)));
          -- surpress recursion
          stop_rule;
      end;
      l_plsql_code := null;
    end if;
  end handle_pl_sql_code;
  

  /* method to prepare JavaScript contained in rule for execution */
  procedure handle_js_code(
    p_rule in rule_rec)
  as
    C_DELIMITER constant varchar2(10) := sct_admin.C_CR || '  ';
    C_JS_ITEM_VALUE_TEMPLATE constant varchar2(100 byte) := q'~apex.item('#ITEM#').getValue()~';
    l_js_code varchar2(32767);
    l_origin_msg varchar2(1000);
  begin
    -- first line, add message
    if p_rule.is_first_row = sct_admin.C_TRUE then
      if not g_has_errors then
        -- normal execution, add message
        if p_rule.sru_fire_on_page_load = sct_admin.C_TRUE then
          l_origin_msg := msg.SCT_INIT_ORIGIN;
        else
          l_origin_msg := msg.SCT_RULE_ORIGIN;
        end if;
        add_java_script(
          p_script => sct_admin.c_cr || 
                      pit.get_message_text(
                        p_message_name => l_origin_msg, 
                        p_arg_list => msg_args(
                                        to_char(g_param.recursive_level - 1), 
                                        to_char(p_rule.sru_sort_seq), 
                                        p_rule.sru_name, 
                                        g_param.firing_item)),
          p_debug_level => C_JS_RULE_ORIGIN);
      else
        -- exception occurred, pass message
        add_comment(msg.SCT_ERROR_HANDLING, msg_args(to_char(g_param.recursive_level - 1), to_char(p_rule.sru_sort_seq), p_rule.sru_name, g_param.firing_item));
      end if;
    end if;

    if p_rule.js is not null then
      l_js_code := utl_text.bulk_replace(p_rule.js, char_table(
                     '#JS_FILE#', C_JS_NAMESPACE,
                     '#ITEM_VALUE#', C_JS_ITEM_VALUE_TEMPLATE,
                     '#ITEM#', p_rule.item,
                     '#SELECTOR#', analyze_parameter(p_rule.item, l_js_code, '#SELECTOR#', p_rule.sra_attribute_2),
                     '#ATTRIBUTE#', p_rule.sra_attribute,
                     '#ATTRIBUTE_2#', p_rule.sra_attribute_2,
                     '#SRU_SORT_SEQ#', case when p_rule.sru_sort_seq is not null then 'RULE_' || p_rule.sru_sort_seq else 'NO_RULE_FOUND' end,
                     '#SRU_NAME#', p_rule.sru_name,
                     '#FIRING_ITEM#', g_param.firing_item,
                     '#CR#', sct_admin.C_CR));
      add_java_script(l_js_code, C_JS_CODE);
    else
      add_comment(msg.SCT_NO_JAVASCRIPT, msg_args(g_param.firing_item, sct_admin.C_CR));
    end if;
    
  end handle_js_code;
  
  /* Prozedur erzeugt eine Antwort auf eine gegebene Situation im Session State fuer eine Regelgruppe
   * %param p_firing_item Element, das die Auswertung ausgeloest hat
   * %param p_firing_items Ausgabe aller Item-Namen, die durch das feuernde Element
   *        in einer Regel verbunden sind. Wird gebraucht, um selektiv Fehlermeldungen 
   *        zu entfernen
   * %param p_js_action Liste der JavaScript-Aktionen, die auf der APEX-Seite als
   *        Ergebnis der Auswertung ausgefuehrt werden sollen
   * %usage Wird aus dem Plugin SCT aufgerufen, um fuer eine gegebene Seitensituation
   *        (die vorab im Session State hinterlegt wurde) die passende Regel zu
   *        finden und aus dieser Handlungsanweisungen fuer die weitere Bearbeitung
   *        abzuleiten.
   */
  procedure create_action(
    p_is_recursive in number) 
  as
    l_rule rule_rec;
    l_action_cur sys_refcursor;
    l_stmt varchar2(32767);
    l_js_code varchar2(32767);
    l_js_chunk varchar2(32767);
    l_now binary_integer;
  begin
    pit.enter_mandatory('create_action', C_PKG);

    -- Initialization
    g_has_errors := false;
    l_now := dbms_utility.get_time;
    
    -- prepare SQL rule
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    sct_admin.C_VIEW_NAME_PREFIX || g_param.sgr_id rule_view,
                    p_is_recursive is_recursive
               from utl_text_templates
              where uttm_type = 'SCT'
                and uttm_name = 'RULE_STMT'
                and uttm_mode = 'DEFAULT'))
      into l_stmt
      from dual;
      
    pit.verbose(msg.allg_pass_information, msg_args('Rule SQL: ' || l_stmt));

    -- explicit cursor control because of dynamic SQL
    open l_action_cur for l_stmt;
    fetch l_action_cur into l_rule;  -- evaluates rule
    while l_action_cur%FOUND loop
      case when ((l_rule.sru_on_error = sct_admin.C_FALSE or not g_has_errors) 
            and l_rule.sra_on_error = sct_admin.C_FALSE) 
             or (l_rule.sra_on_error = sct_admin.C_TRUE and g_has_errors) then
             -- Normal execution. This is true in three possible cases:
             -- 1: No exception occurred
             -- 2: Rule set to ignore exceptions
             -- 3: Exception occurred and action is an exception handler
        -- calculate and execute PL/SQL code
        handle_pl_sql_code(l_rule);
        -- collect JavaScript code
        handle_js_code(l_rule);
      else
        -- Execution rejected, because an exception occured and action is not an exception handler
        null;
      end case;
      
      -- get next action
      fetch l_action_cur into l_rule;
    end loop;
    close l_action_cur;
    
    for i in 1 .. g_param.js_action_stack.count loop
      if g_param.js_action_stack(i).debug_level = C_JS_RULE_ORIGIN then
        utl_text.bulk_replace(g_param.js_action_stack(i).script, char_table(
          '#NOTIFICATION#', g_param.notification_stack,
          '#TIME#', coalesce(dbms_utility.get_time - l_now, 0) || 'hsec'));
      end if;
    end loop;

    -- Set elements referenced in rule or actual page item and store as firing items 
    g_param.firing_item := coalesce(l_rule.sru_firing_items, g_param.firing_item);
    
    pit.leave_mandatory;
  exception
    when msg.CONVERSION_IMPOSSIBLE_ERR or VALUE_ERROR or INVALID_NUMBER then
      close l_action_cur;
      pit.sql_exception;
    when others then
      close l_action_cur;
      pit.stop(msg.SQL_ERROR, msg_args(sqlerrm));
  end create_action;
  
  
  procedure push_page_item(
    p_item_name in sct_page_item.spi_id%type)
  as
  begin
    if not g_param.page_items.exists(p_item_name) then
      g_param.page_items(p_item_name) := 1;
    end if;
  end push_page_item;
  
  
  procedure push_bind_item(
    p_item_name in sct_page_item.spi_id%type)
  as
  begin
    if not g_param.bind_items.exists(p_item_name) then
      g_param.bind_items(p_item_name) := 1;
    end if;
  end push_bind_item;
  

  procedure push_firing_item(
    p_item_name in varchar2)
  as
    l_item varchar2(1000 char);
  begin
    if p_item_name is not null then
      for i in 1 .. regexp_count(p_item_name, C_DELIMITER) + 1 loop
        l_item := regexp_substr(p_item_name, '[^\' || C_DELIMITER || ']+', 1, i);
        if l_item is not null and not g_param.firing_items.exists(l_item) then
          g_param.firing_items(l_item) := 1;
        end if;
      end loop;
    end if;
  end push_firing_item;
  
  
  procedure push_error(
    p_error in apex_error.t_error)
  as
    l_error apex_error.t_error;
  begin
    l_error := p_error;
    begin
      -- prepare message texts
      if l_error.message like ' Zeile 1%' then
        l_error.message := 'Faulty error message.';
      end if;
      l_error.additional_info := htf.escape_sc(l_error.additional_info);
      l_error.message := htf.escape_sc(l_error.message);
    exception
      when others then
        l_error.message := 'Invalid error message';
    end;
    
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    l_error.page_item_name item,
                    l_error.message message,
                    l_error.additional_info,
                    case l_error.page_item_name when 'DOCUMENT' then '"page"' else '["inline","page"]' end location
               from utl_text_templates
              where uttm_type = 'SCT'
                and uttm_name = 'JSON_ERRORS'
                and uttm_mode = 'ERRORS'))
      into g_param.error_stack(g_param.error_stack.count + 1)
      from dual;
    set_error_flag;
  end push_error;
  

  function join_list(
    p_list in number)
    return varchar2
  as
    l_list item_stack_t;
    l_item varchar2(50);
    l_result varchar2(32767);
  begin
    case p_list
    when C_PAGE_ITEMS then
      l_list := g_param.page_items;
    when C_FIRING_ITEMS then
      l_list := g_param.firing_items;
    else
      null;
    end case;
    l_item := l_list.first;
    while l_item is not null loop
      l_result := l_result || C_DELIMITER || l_item;
      l_item := l_list.next(l_item);
    end loop;
    return trim(C_DELIMITER from l_result);
  end join_list;
  

  procedure read_settings(
    p_firing_item in varchar2,
    p_with_comments in varchar2,
    p_rule_group_name in varchar2,
    p_error_dependent_buttons in varchar2)
  as
    l_stmt varchar2(200 char);
    l_allow_recursion number;
  begin

    g_with_comments := coalesce(p_with_comments = sct_admin.C_YES, true);
    
    -- Daten zur Regelgruppe lesen
    select sgr_id, coalesce(sgr_with_recursion, 1)
      into g_param.sgr_id, l_allow_recursion
      from sct_rule_group
     where sct_rule_group.sgr_name = upper(p_rule_group_name)
       and sgr_app_id = apex_application.g_flow_id;
    
    -- Rekursionsschalter uebernehmen
    g_param.allow_recursion := l_allow_recursion = sct_admin.C_TRUE;
        
    -- Initialisierung der Kollektionen
    g_param.bind_items.delete;
    g_param.page_items.delete;
    g_param.firing_items.delete;
    g_param.error_stack.delete;
    g_param.js_action_stack.delete;
    g_param.level_length(C_JS_CODE) := 0;
    g_param.level_length(C_JS_RULE_ORIGIN) := 0;
    g_param.level_length(C_JS_DEBUG) := 0;
    g_param.level_length(C_JS_COMMENT) := 0;
    g_param.error_dependent_buttons := replace(p_error_dependent_buttons, ' ');
    g_param.firing_item := coalesce(p_firing_item, sct_admin.C_NO_FIRING_ITEM);
    g_param.recursive_level := 1;
    g_param.now := dbms_utility.get_time;
    g_param.stop_flag := false;
    
    -- Pruefe und formatiere das ausloesende Element
    format_firing_item;
    
    -- Registriere FIRING_ELEMENT auf Rekursionebene 1
    g_param.recursive_stack(g_param.firing_item) := g_param.recursive_level;
    
    
  exception
    when msg.CONVERSION_IMPOSSIBLE_ERR then
      -- Umwandlungsfehler, bei Initialisierung ignorieren
      g_param.error_stack.delete;
    when no_data_found then
      register_error('DOCUMENT', msg.SCT_RULE_DOES_NOT_EXIST, msg_args(p_rule_group_name));
  end read_settings;
  
  
  /* HELPER */ 
  
  /* Hilfsfunktion ermittelt den Standard-Meldungstext, wenn ein verpflichtendes Feld
   * nicht ausgefuellt wurde, falls dieser nicht ueberschrieben wurde
   * %param p_spi_id ID des Seitenelements
   * %param p_spi_mandatory_message Optional in der Regel festgelegte Meldung bei
   *        leeren Elementen
   * %return Fehlermeldung fuer verpflichtendes Element
   * %usage Stellt sicher, dass ein Meldungstext fuer ein verpflichtendes Element
   *        ausgegeben wird, wenn dieses leer ist. Ist keine Meldung definiert, wird
   *        eine Standardmeldung fuer dieses Element ausgegeben.
   */
  function get_mandatory_message(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2)
    return varchar2
  as
    l_mandatory_message sct_page_item.spi_mandatory_message%type;
  begin
    if p_spi_mandatory_message is null and p_spi_id != 'DOCUMENT' then
      select pit.get_message_text(msg.SCT_ITEM_IS_MANDATORY, msg_args(label))
        into l_mandatory_message
        from apex_application_page_items aai
        join sct_rule_group sgr
          on aai.application_id = sgr.sgr_app_id 
         and page_id = sgr.sgr_page_id
         and item_name = p_spi_id
       where sgr.sgr_id = g_param.sgr_id;
    else
      l_mandatory_message := p_spi_mandatory_message;
    end if;
    return l_mandatory_message;
  end get_mandatory_message;
  
  
  function pipe_page_values(
    p_filter in varchar2)
    return char_table pipelined
  as
    cursor page_item_cur(p_filter in char_table) is
      select spi_id, v(spi_id) spi_value
        from sct_page_item spi
        join table(p_filter) t
          on t.column_value = spi_id
          or instr(spi_css, '|' || replace(t.column_value, '.') || '|') > 0
       where spi_sgr_id = g_param.sgr_id;
    l_filter varchar2(32767);
    c_tmplt constant varchar2(1000) := q'^begin :x := char_table('#FILTER#'); end;^';
    l_filter_list char_table;
  begin
    l_filter := replace(replace(p_filter, ' '), ',', ''',''');
    execute immediate replace(c_tmplt, '#FILTER#', l_filter) using out l_filter_list;
    for v in page_item_cur(l_filter_list) loop
      pipe row (v.spi_value);
    end loop;
  exception
    when no_data_needed then
      null;
  end pipe_page_values;
  
  
  procedure xor(
    p_item in varchar2,
    p_value_list in varchar2,
    p_message in varchar2,
    p_error_on_null in boolean default false)
  as
    l_result number;
  begin
    l_result := xor(p_value_list);
    if (l_result = 0 or (l_result is null and p_error_on_null)) then
      register_error(p_item, p_message, msg_args(''));
    end if;
  exception
    when others then
      register_error(p_item, sqlerrm, '');
  end xor;
    
    
  function xor(
    p_value_list in varchar2)
    return number
  as
    l_result number := -1;
    cursor val_cur(p_value_list in varchar2) is
      select column_value spi_value
        from table(pipe_page_values(p_value_list));
  begin
    if p_value_list is not null then
      for v in val_cur(p_value_list) loop
        if v.spi_value is not null then
          l_result := l_result + 1;
        end if;
        exit when l_result > 1;
      end loop;
    end if;
    l_result := case l_result
                when -1 then null
                when 0 then 1
                else 0 end;
    return l_result;
  end xor;
    
    
  procedure not_null(
    p_item in varchar2,
    p_value_list in varchar2,
    p_message in varchar2)
  as
    l_result number;
  begin
    l_result := not_null(p_value_list);
    if l_result = 0 then
      register_error(p_item, p_message, msg_args(''));
    end if;
  exception
    when others then
      register_error(p_item, sqlerrm, '');
  end not_null;
    
    
  function not_null(
    p_value_list in varchar2)
    return number
  as
    l_result number := 0;
    cursor val_cur(p_value_list in varchar2) is
      select column_value spi_value
        from table(pipe_page_values(p_value_list));
  begin
    if p_value_list is not null then
      for v in val_cur(p_value_list) loop
        if v.spi_value is not null then
          l_result := 1;
          exit;
        end if;
      end loop;
    end if;
    return l_result;
  end not_null;
  
  
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in number default sct_admin.C_TRUE,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null)
  as
    l_item_list char_table;
  begin
  
    case
    when p_item != sct_admin.C_NO_FIRING_ITEM then
      -- Page item, value can be set
      register_item(p_item, p_allow_recursion);
      apex_util.set_session_state(p_item, p_value);
      register_notification(msg.SCT_SESSION_STATE_SET, msg_args(p_item, p_value));
    when p_item = sct_admin.C_NO_FIRING_ITEM and p_attribute_2 is not null then
      -- P_ATTRUBTE_2 contains a jQuery selector for multiple elements
      l_item_list := get_firing_items(p_item, p_attribute_2);
      if l_item_list.count > 0 then
        for i in l_item_list.first .. l_item_list.last loop
          set_session_state(l_item_list(i), p_value, p_allow_recursion, null);
        end loop;
      end if;
    else
      null;
    end case;
    
  end set_session_state;
  
  
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null)
  as
    l_is_mandatory sct_page_item.spi_is_mandatory%type;
    l_mandatory_message sct_page_item.spi_mandatory_message%type;
    l_label varchar2(100 char);
    l_item_list char_table;
  begin
    pit.enter_mandatory('register_mandatory', C_PKG);
    pit.assert_not_null(g_param.sgr_id);
    
    case
    when p_spi_id != sct_admin.C_NO_FIRING_ITEM then
      if p_is_mandatory then 
        l_is_mandatory := sct_admin.C_TRUE;
        l_mandatory_message := get_mandatory_message(p_spi_id, p_spi_mandatory_message);
      else 
        l_is_mandatory := sct_admin.C_FALSE;
        l_mandatory_message := null;
      end if;
      
      update sct_page_item
         set spi_is_required = greatest(spi_is_required, l_is_mandatory),
             spi_is_mandatory = l_is_mandatory,
             spi_mandatory_message = l_mandatory_message
       where spi_sgr_id = g_param.sgr_id
         and spi_id = p_spi_id;
      if sql%rowcount = 0 then
        raise msg.SCT_ITEM_DOES_NOT_EXIST_ERR;
      end if;
    when p_attribute_2 is not null then
      -- Lese alle Elemente, die durch diese Aktion betroffen sind
      l_item_list := get_firing_items(p_spi_id, p_attribute_2);
      if l_item_list is not null then
        for i in l_item_list.first .. l_item_list.last loop
          register_mandatory(
            p_spi_id => l_item_list(i),
            p_spi_mandatory_message => p_spi_mandatory_message, 
            p_is_mandatory => p_is_mandatory);
        end loop;
      end if;
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end register_mandatory;
  
  
  procedure check_mandatory(
    p_firing_item in sct_page_item.spi_id%type,
    p_push_item out nocopy sct_page_item.spi_id%type)
  as
    l_message sct_page_item.spi_mandatory_message%type;
  begin
    pit.enter_mandatory('check_mandatory', C_PKG);
    
    -- Die Abfrage registriert eine Fehlermeldung, wenn
    -- - Das Element aktuell Pflichtfeld ist
    -- - Das Element keinen Wert im Session State besitzt
    -- - Das Element keinen Defaultwert definiert hat
    select spi_mandatory_message
      into l_message
      from sct_page_item
     where spi_id = p_firing_item
       and spi_sgr_id = g_param.sgr_id
       and spi_is_mandatory = sct_admin.C_TRUE
       and (select coalesce(v(g_param.firing_item), spi_item_default) from dual) is null;
    register_error(g_param.firing_item, l_message, '');
    
    pit.leave_mandatory;
  exception
    when no_data_found then
      -- Pflichtfeld hat einen Wert, registrieren um eventuelle Fehlermeldung zu entfernen
      p_push_item := g_param.firing_item;
      pit.leave_mandatory;
    when too_many_rows then 
      htp.p(sqlerrm);
  end check_mandatory;
  
  
  function get_mandatory_default(
    p_spi_id in sct_page_item.spi_id%type)
    return varchar2
  as
    l_default sct_page_item.spi_item_default%type;
  begin
    select spi_item_default
      into l_default
      from sct_page_item
     where spi_is_mandatory = 1
       and spi_id = p_spi_id
       and spi_sgr_id = g_param.sgr_id;
    return l_default;
  exception
    when no_data_found then
      return null;
  end get_mandatory_default;
  
  
  function get_conversion(
    p_spi_id in sct_page_item.spi_conversion%type)
    return varchar2
  as
    l_conversion sct_page_item.spi_conversion%type;
  begin
    select spi_conversion
      into l_conversion
      from sct_page_item
     where spi_id = p_spi_id
       and spi_sgr_id = g_param.sgr_id;
    return l_conversion;
  exception
    when no_data_found then
      /* TODO: Ueberlegen, ob Warnung ausgegeben werden soll wegen fehlender Formatmaske */
      return null;
  end get_conversion;    
  
  
  function get_char(
    p_spi_id in sct_page_item.spi_id%type)
    return varchar2
  as
  begin
    return coalesce(v(p_spi_id), get_mandatory_default(p_spi_id));
  end get_char;
  
  
  function get_number(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in boolean default false)
    return number
  as
    l_raw_value varchar2(32767);
    l_result number;
  begin
    /* TODO: Umbauen auf VALIDATE_CONVERSION, falls 12.2 vorausgesetzt werden kann */
    l_raw_value := get_char(p_spi_id);
    l_raw_value := rtrim(ltrim(l_raw_value, ', '));
    $IF dbms_db_version.ver_le_11 $THEN
    l_result := to_number(l_raw_value, p_format_mask);
    $ELSIF dbms_db_version.ver_le_12_1 $THEN
    l_result := to_number(l_raw_value, p_format_mask);
    $ELSE
    if validate_conversion(l_raw_value as number, p_format_mask) = 1 then
      l_result := to_number(l_raw_value, p_format_mask);
    else
      pit.error(msg.INVALID_NUMBER_FORMAT, msg_args(l_raw_value, p_format_mask));
    end if;
    $END
    return l_result;
  exception
    when msg.INVALID_NUMBER_FORMAT_ERR then
      pit.error(msg.INVALID_NUMBER_FORMAT, msg_args(l_raw_value, p_format_mask));
      return null;
    when INVALID_NUMBER or VALUE_ERROR then
      pit.error(msg.ALLG_PASS_INFORMATION, msg_args('Ungültige Zahl entfernt: ' || l_raw_value));
      return null;
  end get_number;
  
  
  procedure check_number(
    p_spi_id in sct_page_item.spi_id%type)
  as
    l_foo number;
  begin
    l_foo := get_number(
               p_spi_id => p_spi_id, 
               p_format_mask => get_conversion(p_spi_id), 
               p_throw_error => false);
  end check_number;
    
    
  function get_date(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in boolean default false)
    return date
  as
    l_raw_value varchar2(32767);
    l_result date;
  begin
    /* TODO: Umbauen auf VALIDATE_CONVERSION, falls 12.2 vorausgesetzt werden kann */
    l_raw_value := get_char(p_spi_id);
    $IF dbms_db_version.ver_le_11 $THEN
    l_result := to_date(l_raw_value, p_format_mask);
    $ELSIF dbms_db_version.ver_le_12_1 $THEN
    l_result := to_date(l_raw_value, p_format_mask);
    $ELSE
    if validate_conversion(l_raw_value as date, p_format_mask) = 1 then
      l_result := to_date(l_raw_value, p_format_mask);
    else
      pit.error(msg.INVALID_DATE_FORMAT, msg_args(l_raw_value, p_format_mask));
    end if;
    $END
    return l_result;
  exception
    when msg.INVALID_DATE_ERR then
      pit.error(msg.INVALID_DATE, msg_args(l_raw_value, p_format_mask));
      return null;
    when msg.INVALID_DATE_FORMAT_ERR then
      pit.error(msg.INVALID_DATE_FORMAT, msg_args(l_raw_value, p_format_mask));
      return null;
    when msg.INVALID_YEAR_ERR or msg.INVALID_MONTH_ERR or msg.INVALID_DAY_ERR then
      pit.error(msg.INVALID_YEAR, msg_args(sqlerrm));
      return null;
  end get_date;
  
  
  procedure check_date(
    p_spi_id in sct_page_item.spi_id%type)
  as
    l_foo date;
  begin
    l_foo := get_date(
               p_spi_id => p_spi_id, 
               p_format_mask => get_conversion(p_spi_id), 
               p_throw_error => false);
  end check_date;
  
  
  procedure notify(
    p_message in varchar2)
  as
    c_javascript varchar2(200) := sct_admin.C_CR || q'^de.condes.plugin.sct.notify(#MESSAGE#);^';
  begin
    add_java_script(replace(c_javascript, '#MESSAGE#', apex_escape.js_literal(p_message)), C_JS_CODE);
  end notify;
  
  
  procedure execute_javascript(
    p_plsql in varchar2)
  as
    c_cmd_template varchar2(200) := 'begin :x := #COMMAND#; end;';
    l_result varchar2(32767);
    l_cmd varchar2(32767);
  begin
    l_cmd := replace(c_cmd_template, '#COMMAND#', replace(trim(p_plsql), ';'));
    execute immediate l_cmd using out l_result;
    add_java_script(replace(l_result, 'javascript:'), C_JS_CODE);
  end execute_javascript;
  
  
  function get_json_from_bind_items
    return clob
  as
    -- Liste relevanter Elemente, die einen Event binden sollen
    cursor rule_group_items(p_sgr_id sct_rule_group.sgr_id%type) is
      select spi_id, sit_event, sit_has_value
        from sct_page_item spi
        join sct_page_item_type sit
          on spi.spi_sit_id = sit.sit_id
        join sct_rule_group sgr
          on spi.spi_sgr_id = sgr.sgr_id
       where sit.sit_event is not null
         and spi.spi_is_required = sct_admin.C_TRUE
         and sgr.sgr_active = sct_admin.C_TRUE
         and sgr.sgr_id = p_sgr_id;
    l_json clob;
  begin
    
    for item in rule_group_items(g_param.sgr_id) loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(c_bind_json_element, char_table(
          '#ID#', item.spi_id,
          '#EVENT#', item.sit_event)),
        ',', true);
      -- relevante Elemente mit Session State registrieren, damit beim initialen Aufruf
      -- die aktuellen Seitenwerte dieser Elemente übermittelt werden
      -- (diese Aufgabe uebernimmt anschliessend REGISTER_ITEM)
      if item.sit_has_value = 1 then
        push_page_item(item.spi_id);
      end if;
    end loop;
    
    -- Elemente werden mit '~' als Ersatz fuer '"' erzeugt, da APEX dieses Zeichen
    -- durch eine Escape-Sequenz maskiert. Andernfalls kann in JavaScript daraus 
    -- kein JSON-Objekt mehr erzeugt werden.
    return utl_text.bulk_replace(c_bind_json_template, char_table('#JSON#', l_json, '"', '~'));
  end get_json_from_bind_items;
  
  
  procedure process_initialization_code
  as
    l_initialization_code sct_rule_group.sgr_initialization_code%type;
  begin
    select sgr_initialization_code
      into l_initialization_code
      from sct_rule_group
     where sgr_id = g_param.sgr_id;
  
    if l_initialization_code is not null then
      execute immediate l_initialization_code;
    end if;
  exception
    when no_data_found then
      null;
  end process_initialization_code;
  
    
  /* Funktion wertet die Regel der angeforderten Regelgruppe aus
   * %return HTML-Script mit den Javascript-Anweisungen fuer die clientseitige
   *         Verarbeitung
   * %usage Wird durch das Plugin beim Refresh aufgerufen
   *        - Erstellt einen JavaScript-Skript, der zurueckgeliefert wird
   *        - Analysiert, ob Regel rekursive Ausfuehrung erfordert und ruft
   *          sich selbst mit den rekursiven Regeln auf
   */
  procedure process_rule
  as
    l_firing_items sct_rule.sru_firing_items%type;
    l_js_action_chunk varchar2(32767);
    l_js_action varchar2(32767);
    l_needs_recursive_call boolean := false;
    l_processed_item sct_page_item.spi_id%type;
    
    l_is_recursive number(1,0);
    l_actual_recursive_level binary_integer;
  begin
    pit.enter_optional(c_pkg, 'process_rule');
    
    -- Initialisierung
    l_actual_recursive_level := g_param.recursive_level;
    
    -- Inkrementiert Rekursionslevel, damit zukuenftige Eintraege auf eigenem Level liegen
    -- Wird benoetigt, um »breadth first« zu arbeiten: Alle Rekursionsaufrufe einer Ebene, danach die naechste Ebene etc.
    g_param.recursive_level := l_actual_recursive_level + 1;
    
    -- is_recursive wird verwendet, um Aktionen, die nicht rekursiv ausgefuehrt werden sollen, auszusondern
    l_is_recursive := case l_actual_recursive_level when 1 then sct_admin.C_FALSE else sct_admin.C_TRUE end;
    
    -- Iteriere ueber Rekursionsstack
    g_param.firing_item := g_param.recursive_stack.first;

    while g_param.firing_item is not null loop
      begin
        --  fuehre alle »Events« auf aktuellem Rekursionslevel aus
        if g_param.recursive_stack(g_param.firing_item) = l_actual_recursive_level then
          -- Speichere Name des Elements zum spaeteren Loeschen des Elements aus dem Rekursionsstack
          l_processed_item := g_param.firing_item;
          l_needs_recursive_call := true;
          -- Meldungensstack initialisieren
          g_param.notification_stack := null;
          
          -- Session State auswerten und neue Aktion berechnen,PL/SQL-Code wird durch den Aufruf bereits ausgefuehrt
          create_action(p_is_recursive => l_is_recursive);
          
          -- Ausgabe erstellen und geaenderte Elemente merken
          push_firing_item(l_firing_items);
        end if;
  
        -- Naechstes Element verarbeiten
        g_param.firing_item := g_param.recursive_stack.next(g_param.firing_item);
        
        case when g_param.stop_flag then
          g_param.recursive_stack.delete;
          exit;
        when l_processed_item is not null then
          -- verarbeitetes Element aus Rekursionsstack entfernen
          g_param.recursive_stack.delete(l_processed_item);
        end case;
        
      exception
        when others then
          register_error('DOCUMENT', 'Ein Fehler ist auf der Seite aufgetreten', replace(substr(sqlerrm, 12), chr(10)));
          g_param.recursive_stack.delete;
          exit;
      end;
    end loop;
    
    -- Rekursion, endet, wenn keine weiteren Aktivitaeten registriert wurden
    if l_needs_recursive_call then
      process_rule;
    end if;
    
    pit.leave_optional;
  end process_rule;  
  
    
  procedure stop_rule
  as
  begin
    g_param.stop_flag := true;
  end stop_rule;
  
  /* Hilfsprozedur zum Registrieren von Elemente, die durch das Plugin im Session State
   * geaendert wurden. Diese Elemente werden anschliessend in der Antwort im Browser
   * auf den aktuellen Wert gesetzt.
   * %param p_item Name des Elements, das als geandert registriert werden soll
   * %param p_allow_recursion Flag, das anzeigt, ob die Veraenderung dieses Elements
   *        die Regelberechnung rekursiv ausloesen soll
   * %usage Wird verwendet, um zu registrieren, dass ein Seitenelement durch SCT im
   *        Sessionstatus veraendert wurde. Dadurch wird der aktualisierte Elementwert
   *        in die JSON-Antwort aufgenommen und auf der Oberflaeche aktualisiert
   */
  procedure register_item(
    p_item in varchar2,
    p_allow_recursion in number default sct_admin.C_TRUE)
  as
    l_has_rule number;
  begin
    -- Vermerke, dass p_item an den Browser gesendet werden muss
    push_page_item(p_item);
    
    if p_allow_recursion = sct_admin.C_TRUE then
      -- Ermittle, ob p_item in Regeln referenziert wird. Falls ja, rekursiven Aufruf speichern
      select count(*)
        into l_has_rule
        from dual
       where exists(
             select 1
               from sct_page_item
              where spi_id = p_item     
                -- Element ist relevant  
                and spi_is_required = sct_admin.C_TRUE
                -- und ruft sich nicht selbst auf
                and p_item != coalesce(g_param.firing_item, 'FOO'));
                
      if l_has_rule > 0 then   
        if g_param.recursive_level <= g_recursion_limit then
          if not g_param.recursive_stack.exists(p_item) then
            -- push element on recursive stack to evalualte its rule in the next recursion
            g_param.recursive_stack(p_item) := g_param.recursive_level;
          else
            -- Recursion loop, cancel
            if g_recursion_loop_is_error then
              register_error(p_item, msg.SCT_RECURSION_LOOP, msg_args(p_item, to_char(g_param.recursive_level)));
            else
              register_notification(msg.SCT_RECURSION_LOOP, msg_args(p_item, to_char(g_param.recursive_level)));
            end if;
          end if;
        else
          register_error(p_item, msg.SCT_RECURSION_LIMIT, msg_args(p_item, to_char(g_recursion_limit)));
        end if;
      end if;
    end if;
  end register_item;
  
  
  procedure initialize
  as
  begin
    g_with_comments := true;
    g_recursion_loop_is_error := param.get_boolean('RAISE_RECURSION_LOOP', C_PARAM_GROUP);
    g_recursion_limit := param.get_integer('RECURSION_LIMIT', C_PARAM_GROUP);
  end initialize;


  /* INTERFACE */
  function get_firing_item
    return varchar2
  as
  begin
    return g_param.firing_item;
  end get_firing_item;


  function get_firing_items(
    p_spi_id in sct_page_item.spi_id%type,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type)
    return char_table
  as
    l_item_list char_table;
  begin
    case 
    when p_spi_id = sct_admin.C_NO_FIRING_ITEM and trim(p_attribute_2) like '.%' then
      -- attribute contains jQuery CSS selector, search page items with corresponding CSS
        with params as(
             select apex_application.g_flow_id application_id,
                    apex_application.g_flow_step_id page_id,
                    replace(column_value, '.') css
               from table(utl_text.string_to_table(p_attribute_2, ',')))
      select /*+ NO_MERGE (params) */
             cast(collect(item_name) as char_table)
        into l_item_list
        from apex_application_page_items
     natural join params
       where (html_form_element_css_classes is not null
         and instr(html_form_element_css_classes || ' ', params.css || ' ') > 0)
          or (item_css_classes is not null 
         and instr(item_css_classes || ' ', params.css || ' ') > 0);

    when p_spi_id = sct_admin.C_NO_FIRING_ITEM and trim(p_attribute_2) like '#%' then
      -- attribute is list of jQuery ID selectors. Find actions with matching ID
      select cast(collect(item_name) as char_table)
        into l_item_list
        from apex_application_page_items
       where application_id = apex_application.g_flow_id
         and page_id = apex_application.g_flow_step_id
         and instr(p_attribute_2 || ',', '#' || item_name || ',') > 0;
    else
      l_item_list := null;
    end case;
    return l_item_list;
  end get_firing_items;


  procedure set_error_flag
  as
  begin
    g_has_errors := true;
  end set_error_flag; 


  function get_error_flag
    return boolean
  as
  begin
    return g_has_errors;
  end get_error_flag;
  
  
  procedure register_error(
    p_spi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2)
  as
    l_error apex_error.t_error;  -- APEX-Fehler-Record
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, instr(sqlerrm, ':', 1) + 2);
  begin
    push_firing_item(p_spi_id);
    l_error.message := p_error_msg;
    
    if l_error.message is not null then
      l_error.page_item_name := p_spi_id;
      l_error.additional_info := p_internal_error || replace(dbms_utility.format_error_backtrace, chr(10), '<br/>');
      push_error(l_error);
    end if;
  end register_error;
  
  
  procedure register_error(
    p_spi_id in varchar2,
    p_message_name in varchar2,
    p_arg_list in msg_args default null)
  as
    l_message message_type;
    l_error apex_error.t_error;  -- APEX-Fehler-Record
  begin
    push_firing_item(p_spi_id);
    l_message := message_type(
                   p_message_name => p_message_name,
                   p_message_language => null,
                   p_affected_id => p_spi_id,
                   p_session_id => null,
                   p_user_name => v('APP_USER'),
                   p_arg_list => p_arg_list);
    
    if l_message.message_text is not null then
      l_error.message := l_message.message_text;
      l_error.page_item_name := l_message.affected_id;
      l_error.additional_info := replace(l_message.backtrace, chr(10), '<br/>');
      push_error(l_error);
    end if;
  end register_error;
  
  
  procedure register_notification(
    p_text in varchar2)
  as
    c_comment constant varchar2(10) := sct_admin.C_CR || '// ';
  begin
    if g_with_comments then
      utl_text.append(g_param.notification_stack, C_COMMENT || p_text);
    end if;
  end register_notification;
  
  
  procedure register_notification(
    p_message_name in varchar2,
    p_arg_list in msg_args)
  as
  begin
    register_notification(pit.get_message_text(p_message_name, p_arg_list));
  end register_notification;
  
  
  function register_observer
    return varchar2
  as
    l_observable_objects varchar2(2000);
  begin
    select listagg(
             case when sra_spi_id = 'DOCUMENT'
                  then to_char(sra_attribute_2) 
                  else sra_spi_id end, ',') within group (order by sru_firing_items)
      into l_observable_objects
      from sct_bl_rules
     where sra_sat_id = C_REGISTER_OBSERVER
       and sgr_id = g_param.sgr_id;
    return l_observable_objects;
  exception
    when no_data_found then
      return null;
  end register_observer;
    
  
  procedure submit_page
  as
    cursor mandatory_items(p_sgr_id in sct_rule_group.sgr_id%type) is
      select spi_id, spi_mandatory_message
        from sct_page_item
       where spi_sgr_id = p_sgr_id
         and spi_is_mandatory = sct_admin.C_TRUE;
  begin
    for itm in mandatory_items(g_param.sgr_id) loop
      -- Registriere alle Pflichtfelder, damit eventuelle Fehlermeldungen korrekt entfernt werden
      push_firing_item(itm.spi_id);
      if get_char(itm.spi_id) is null then
        -- Pflichtfeld hat keinen Sessionstatus, Fehler werfen
        register_error(itm.spi_id, itm.spi_mandatory_message, '');
      end if;
    end loop;
  end submit_page;

  
  function process_request
    return clob
  as
    l_js_script varchar2(32767);
  begin      
    pit.enter_optional(c_pkg, 'process_request');
    
      process_rule;
      l_js_script := get_java_script;
      
    pit.leave_optional;
    return l_js_script;
  end process_request;
  
begin
  initialize;
end bl_sct;
/
