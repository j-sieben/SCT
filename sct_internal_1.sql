--------------------------------------------------------
--  DDL for Package Body SCT_INTERNAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCT_INTERNAL" 
as

  /** Private constants*/
  C_PARAM_GROUP constant sct_util.ora_name_type := 'SCT';
  C_MAX_LENGTH binary_integer := 32000;
  C_MODE_FRAME constant sct_util.ora_name_type := 'FRAME';
  C_MODE_DEFAULT constant sct_util.ora_name_type := 'DEFAULT';

  C_PAGE_ITEMS constant binary_integer := 1;
  C_FIRING_ITEMS constant binary_integer := 2;
  
  C_JS_CODE constant binary_integer := 1;
  C_JS_RULE_ORIGIN constant binary_integer := 2;
  C_JS_DEBUG constant binary_integer := 3;
  C_JS_COMMENT constant binary_integer := 4;
  
  C_NUMBER_ITEM constant sct_page_item_type.sit_id%type := 'NUMBER_ITEM';
  C_DATE_ITEM constant sct_page_item_type.sit_id%type := 'DATE_ITEM';
  C_REGISTER_OBSERVER constant sct_action_type.sat_id%type := 'REGISTER_OBSERVER';
  C_DELIMITER constant varchar2(1 byte) := ',';
  C_EVENT_INITIALIZE constant sct_util.ora_name_type := 'initialize';
  
  C_BIND_JSON_TEMPLATE constant sct_util.sql_char := '[#JSON#]';
  C_BIND_JSON_ELEMENT constant sct_util.sql_char := '{"id":"#ID#","event":"#EVENT#","action":"#STATIC_ACTION#"}';
  C_PAGE_JSON_ELEMENT constant sct_util.sql_char := '{"id":"#ID#","value":"#VALUE#"}';  
  C_JS_NAMESPACE constant sct_util.ora_name_type := 'de.condes.plugin.sct';
  C_JS_SCRIPT_FRAME constant sct_util.sql_char := q'^<script>#CR#  /** Init: #DURATION#hsec*/#CR#  #JS_FILE#.setItemValues(#ITEM_JSON#);#CR#  #JS_FILE#.setErrors(#ERROR_JSON#);#CR##SCRIPT##CR#</script>^';

  /** Private types */
  type item_stack_t is table of number index by varchar2(50);
  
  -- Fehlerstack
  type error_stack_t is table of sct_util.max_char index by binary_integer;
  
  type js_rec is record(
    script sct_util.max_char,
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
    id number,                                       -- internal ID of the record
    sgr_id sct_rule_group.sgr_id%type,               -- actual SGR_ID
    firing_item sct_page_item.spi_id%type,           -- actual firing item (or sct_util.C_NO_FIRING_ITEM)
    firing_event sct_page_item_type.sit_event%type,  -- actual firing event (normally change or click, but can be any event)
    error_dependent_items varchar2(2000),            -- List of items to deactivate if the page contains errors
    bind_items item_stack_t,                         -- List of items for which SCT binds event handlers
    page_items item_stack_t,                         -- List of items that changed their value in the session state
    firing_items item_stack_t,                       -- List of items which are connected with firing item within their rules
    error_stack error_stack_t,                       -- List errors that occurred
    recursive_stack recursive_stack_t,               -- List of items which were marked to recursively check rules for
    is_recursive sct_util.flag_type,                 -- Flag to indicate whether we're in a recursive rule run
    js_action_stack js_list,                         -- JavaScript action stack, rule outcome of the rules executed so far
    level_length level_length_t,                     -- cumulated length of the strings on the respective severity levels
    recursive_level binary_integer,                  -- actual recursive level
    allow_recursion boolean,                         -- Flag to indicate whether recursive calls are allowed for the active rule
    notification_stack sct_util.max_char,            -- List of notifications to be shown in the browser console
    stop_flag boolean,                               -- Flag to indicate that all rule execution has to be stopped
    now binary_integer                               -- timestamp, used to calculate the execution duration
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
    sra_sort_seq sct_rule_action.sra_sort_seq%type,
    sra_param_1 sct_rule_action.sra_param_1%type,
    sra_param_2 sct_rule_action.sra_param_2%type,
    sra_param_3 sct_rule_action.sra_param_3%type,
    sra_on_error sct_rule_action.sra_on_error%type,
    sru_on_error sct_rule_action.sra_on_error%type,
    is_first_row sct_util.flag_type
  );

  /** Privat global variables */
  g_has_errors boolean;
  g_param param_rec;
  g_recursion_limit binary_integer;
  g_recursion_loop_is_error boolean;  
  
  $IF sct_util.C_WITH_UNIT_TESTS $THEN
  /*============ UNIT TEST ============*/ 
  g_test_mode boolean := false;
  g_test_result sct_test_result;
  
  procedure set_test_mode(
    p_mode in boolean default false)
  as
  begin
    g_test_mode := p_mode;
  end set_test_mode;
  
  function get_test_mode
    return boolean
  as
  begin
    return g_test_mode;
  end get_test_mode;
  
  
  function get_test_result
    return sct_test_result
  as
  begin
    return g_test_result;
  end get_test_result;
  
  
  function to_char_table(
    p_list item_stack_t)
    return char_table
  as
    l_table char_table := char_table();
    l_key varchar2(50);
  begin
    if p_list.count > 0 then
      l_key := p_list.first;
      while l_key is not null loop
        l_table.extend;
        l_table(l_table.count) := l_key;
        l_key := p_list.next(l_key);
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_char_table(
    p_list recursive_stack_t)
    return char_table
  as
    l_table char_table := char_table();
    l_key varchar2(50);
  begin
    if p_list.count > 0 then
      l_key := p_list.first;
      while l_key is not null loop
        l_table.extend;
        l_table(l_table.count) := l_key;
        l_key := p_list.next(l_key);
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_char_table(
    p_list error_stack_t)
    return char_table
  as
    l_table char_table := char_table();
  begin
    if p_list.count > 0 then
      for i in 1 .. p_list.count loop
        l_table.extend;
        l_table(l_table.count) := p_list(i);
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_char_table(
    p_list level_length_t)
    return char_table
  as
    l_table char_table := char_table();
  begin
    if p_list.count > 0 then
      for i in 1 .. p_list.count loop
        l_table.extend;
        l_table(l_table.count) := to_char(p_list(i));
      end loop;
    end if;
    
    return l_table;
  end to_char_table;
  
  
  function to_sct_test_js_list(
    p_js_list js_list)
    return sct_test_js_list
  as
    l_test_js_list sct_test_js_list := sct_test_js_list();
    l_js_rec js_rec;
    l_test_js_rec sct_test_js_rec;
  begin
    for i in 1 .. p_js_list.count loop
      l_js_rec := p_js_list(i);
      l_test_js_rec := sct_test_js_rec(substr(l_js_rec.script, 1, 4000), l_js_rec.hash, l_js_rec.debug_level);
      l_test_js_list.extend;
      l_test_js_list(l_test_js_list.count) := l_test_js_rec;
    end loop;
    return l_test_js_list;
  end to_sct_test_js_list;
  
  
  function to_sct_test_row(
    p_rule_rec rule_rec)
    return sct_test_row
  as
    l_test_row sct_test_row;
  begin
    l_test_row := sct_test_row(
                    -- Rule
                    p_rule_rec.sru_id, p_rule_rec.sru_sort_seq, p_rule_rec.sru_name, p_rule_rec.sru_firing_items,
                    p_rule_rec.sru_fire_on_page_load, p_rule_rec.item, p_rule_rec.pl_sql, p_rule_rec.js, 
                    p_rule_rec.sra_sort_seq, p_rule_rec.sra_param_1, p_rule_rec.sra_param_2, p_rule_rec.sra_param_3, 
                    p_rule_rec.sra_on_error, p_rule_rec.sru_on_error, p_rule_rec.is_first_row,
                    -- Parameters
                    g_param.id, g_param.sgr_id, g_param.firing_item, g_param.firing_event, g_param.error_dependent_items,
                    to_char_table(g_param.bind_items), to_char_table(g_param.page_items), to_char_table(g_param.firing_items),
                    to_char_table(g_param.error_stack),  to_char_table(g_param.recursive_stack), g_param.is_recursive, 
                    to_sct_test_js_list(g_param.js_action_stack), to_char_table(g_param.level_length),
                    g_param.recursive_level, sct_util.bool_to_flag(g_param.allow_recursion), g_param.notification_stack, 
                    sct_util.bool_to_flag(g_param.stop_flag), g_param.now);
    return l_test_row;
  end to_sct_test_row;
  $END
  
  
  procedure initialize_test
  as
  begin
    null;
    $IF sct_util.C_WITH_UNIT_TESTS $THEN
    if g_test_mode then
      g_test_result := sct_test_result();
    end if;
    $END
  end initialize_test;
  
  
  procedure append_test_result(
    p_rule in rule_rec default null)
  as
    $IF sct_util.C_WITH_UNIT_TESTS $THEN
    l_test_row sct_test_row;
    $END
  begin
    null;
    $IF sct_util.C_WITH_UNIT_TESTS $THEN
    if g_test_mode then      
      if p_rule.sru_id is not null then
        l_test_row := to_sct_test_row(p_rule);
        g_test_result.rule_list.extend;
        g_test_result.rule_list(g_test_result.rule_list.count) := l_test_row;
      end if;
    end if;
    $END
  end append_test_result;
  
  /*============ HELPER ============*/ 
  
  /* Method to incorporate a JavaScript chiunk into the response
   * @param  p_script       JavaScript chunk to add
   * @param [p_debug_level] Optional level indicator to control the output
   * @usage  Is used to add a JavaScript chunk to an internal JavaScript collection.
   *         Any chunk is assigned to a debug level, allowing to control the amount of code SCT will produce as an answer.
   *         As for now, the answer is limited to 32KByte. To achieve that, SSCT will reduce the level of the output if
   *         required to keep the answer below 32KByte.
   *         The method also looks for duplicate JavaScript and comments out earlier chunks with the same JavaScript. This#
   *         can happen based on the flow of rules. Removing duplicates reduces the amount of code the browser has to execute,
   *         especially useful if a region is refreshed.
   */
  procedure add_java_script(
    p_java_script in varchar2,
    p_debug_level in binary_integer default C_JS_CODE)
  as
    C_COMMENT_OUT constant varchar2(20) := '// (double) ';
    l_next_entry binary_integer;
    l_js js_rec;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_java_script', p_java_script),
                    msg_param('p_debug_level', to_char(p_debug_level))));
                    
    if p_java_script is not null then
      l_next_entry := g_param.js_action_stack.count + 1;
      
      select p_java_script, standard_hash(p_java_script), p_debug_level
        into l_js
        from dual;
        
      -- comment out double JavaScript entries
      for i in 1 .. g_param.js_action_stack.count loop
        if g_param.js_action_stack.exists(i) then
          if g_param.js_action_stack(i).debug_level = C_JS_CODE and g_param.js_action_stack(i).hash = l_js.hash then
            g_param.js_action_stack(i).script := C_COMMENT_OUT || g_param.js_action_stack(i).script;
            g_param.js_action_stack(i).hash := null;
            g_param.js_action_stack(i).debug_level := C_JS_DEBUG;
          end if;
        end if;
      end loop;
      
      -- persist JavaScript action
      g_param.js_action_stack(l_next_entry) := l_js;
      
      -- Caculate length of comments and scripts
      g_param.level_length(l_js.debug_level) := g_param.level_length(l_js.debug_level) + length(l_js.script);
    end if;
  
    pit.leave_optional;
  end add_java_script;

  
  /** Gets message text from PIT to integrate it as a comment into the response
   * @param  p_message_name  Message ID
   * @param [p_arg_list]     Optional message params
   * @return Message in the respective language
   * @usage  If in debug mode, this method adds descriptive messages to the response
   */
  procedure add_comment(
    p_message_name varchar2,
    p_arg_list msg_args default null)
  as
  begin
    pit.enter_detailed;
    
    add_java_script(pit.get_message_text(p_message_name, p_arg_list), C_JS_COMMENT);
    
    pit.leave_detailed;
  end add_comment;
  
  
  /** Method to append text to a given string, separated by C_DELIMITER
   * @param  p_text  Text to append P_WHAT to
   * @param  p_what  Text to append
   * @return Text with the appendix, delimited by C_DELIMITER
   * @usage  Is used to concatenate strings and to add line feed and indent
   */
  procedure append(
    p_text in out nocopy varchar2,
    p_what in varchar2)
  as
    c_delimiter constant varchar2(10) := sct_util.C_CR || '  ';
  begin
    pit.enter_detailed;
    
    p_text := p_text || c_delimiter || replace(p_what, sct_util.C_CR, c_delimiter);
    
    pit.leave_detailed;
  end append;    
  
  
  /** Helper to limit a string to a predefined length
   * @param  p_text    Text to limit
   * @param [p_length] Maximum length
   * @return P_TEXT, limited to P_LENGTH byte
   * @usage  Limits text to P_LENGTH to avoid overflow of variables by reducing the max length
   */
  function limit_string(
    p_text in varchar2,
    p_length in binary_integer default 4000)
    return varchar2
  as
  begin
    return substr(p_text, 1, p_length);
  end limit_string;
  
  
  /** Method to concatenate one of the package internal lists into a C_DELIMITER delimited string
   * @param  p_list  One of the constants C_PAGE_ITEMS|C_FIRING_ITEMS to identify the list to concatenate
   * @return C_DELIMITER separated string of the list content
   * @usage  Is used as a helper to join a list for JSON instances
   */
  function join_list(
    p_list in number)
    return varchar2
  as
    l_list item_stack_t;
    l_item varchar2(50);
    l_result sct_util.max_char;
  begin 
    -- get list
    case p_list
    when C_PAGE_ITEMS then
      l_list := g_param.page_items;
    when C_FIRING_ITEMS then
      l_list := g_param.firing_items;
    else
      null;
    end case;
    
    -- concatenate list
    l_item := l_list.first;
    while l_item is not null loop
      l_result := l_result || C_DELIMITER || l_item;
      l_item := l_list.next(l_item);
    end loop;
    
    return trim(C_DELIMITER from l_result);
  end join_list;
  
  
  /**  Method returns all apex actions defined for the rule group as a JavaScript install script
   * @return JavaScript script that installs the apex actions on the page
   * @usage  Is used to register apex actions defined for the rule group on the page. Called during initialization.
   */
  function get_apex_actions
    return varchar2
  as
    l_actions_js sct_util.max_char;
    l_has_actions binary_integer;
  begin
    pit.enter_optional;
    
    -- excute only on initialization
    pit.assert(g_param.firing_event = C_EVENT_INITIALIZE);
    
    -- Check whether APEX actions exist
    select count(*)
      into l_has_actions
      from dual
     where exists(
           select null
             from sct_apex_action_item
            where sai_spi_sgr_id = g_param.sgr_id);
            
    if l_has_actions = 1 then
      -- Generate initalization JavaScript for APEX actions based on UTL_TEXT templates of name APEX_ACTION
      with templates as (
           select uttm_name, uttm_mode, uttm_text, g_param.sgr_id sgr_id
             from utl_text_templates
            where uttm_type = C_PARAM_GROUP
              and uttm_name = 'APEX_ACTION')
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    utl_text.generate_text(cursor(
                      select uttm_text template,
                             spi_id, saa_name
                        from sct_apex_action_item
                        join sct_apex_action 
                          on sai_saa_id = saa_id
                        join sct_page_item
                          on sai_spi_sgr_id = spi_sgr_id
                         and sai_spi_id = spi_id
                        join sct_page_item_type
                          on spi_sit_id = sit_id
                        join templates
                          on sit_id = uttm_mode
                         and sai_spi_sgr_id = sgr_id),
                      p_delimiter => chr(10)
                    ) bind_action_items,
                    utl_text.generate_text(cursor(
                      select uttm_text template, chr(10) || '    ' cr,
                             saa_sgr_id, saa_sty_id, saa_name, 
                             case when aat.translatable_message is null then apex_escape.json(saa_label) end saa_label,
                             case when aat.translatable_message is not null then apex_escape.json(saa_label) end saa_label_key, 
                             apex_escape.json(saa_context_label) saa_context_label, 
                             saa_icon, saa_icon_type,
                             case when aat.translatable_message is null then apex_escape.json(coalesce(saa_title, saa_label)) end saa_title,
                             case when aat.translatable_message is not null then apex_escape.json(coalesce(saa_title, saa_label)) end saa_title_key,
                             saa_shortcut,
                             case saa_initially_disabled when sct_util.c_true then 'true' else 'false' end saa_initially_disabled,
                             case saa_initially_hidden when sct_util.c_true then 'true' else 'false' end saa_initially_hidden,
                             saa_href, saa_action
                        from sct_apex_action saa
                        join sct_rule_group sgr
                          on saa.saa_sgr_id = sgr.sgr_id
                        join templates t
                          on t.sgr_id = sgr.sgr_id
                         and uttm_mode = saa_sty_id
                        left join apex_application_translations aat
                          on saa.saa_label = aat.translatable_message
                         and sgr.sgr_app_id = aat.application_id),
                      p_delimiter => ',' || chr(10) || '   '
                    ) action_list
               from templates
              where uttm_mode = C_MODE_FRAME)
           ) resultat
      into l_actions_js
      from dual;
    end if; 

    pit.leave_optional(msg_params(msg_param('APEX_ACTIONS', limit_string(l_actions_js))));
    return l_actions_js;
  exception
    when msg.ASSERT_TRUE_ERR then
      return null;
  end get_apex_actions;
  
  
  /* Method retrieves conversion format mask for a given page item
   * @param  p_spi_id ID of the page item
   * @return Conversion mask for the given item
   * @usage  If a page item is of type DATE or NUMBER, a format mask is required to convert it. As APEX allows to define
   *         format mask at several locations, this method retrieves the best matching format mask for that page item
   */
  function get_conversion(
    p_spi_id in sct_page_item.spi_conversion%type)
    return varchar2
  as
    l_conversion sct_page_item.spi_conversion%type;
  begin
    -- Tracing done in PLUGIN_SCT
    select spi_conversion
      into l_conversion
      from sct_page_item
     where spi_id = p_spi_id
       and spi_sgr_id = g_param.sgr_id;
    return l_conversion;
  exception
    when no_data_found then
      /** TODO: Raise warning if format mask is missing? */
      return null;
  end get_conversion;
  
   
  /** Method calculates all errors registered during rule evaluation and collects them as JSON
   * @return JSON instance for all page items referenced by the rule executed.
   * @usage  Is used to convert the list of error to a JSON structure with the following structure:
   *          {"type":"error","item":"#PAGE_ITEM#","message":"#MESSAGE#","location":#LOCATION#,"additionalInfo":"#ADDITIONAL_INFO#","unsafe":"false"}
   */
  function get_errors_as_json
    return varchar2
  as
    l_json sct_util.max_char;
    l_count binary_integer;
  begin
    pit.enter_optional;
    
    l_count := g_param.error_stack.count;
    
    for i in 1 .. l_count loop
      utl_text.append(l_json, g_param.error_stack(i), C_DELIMITER, true);
    end loop;
    
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    to_char(l_count) error_count,
                    g_param.error_dependent_items dependent_items,
                    l_json json_errors
               from utl_text_templates
              where uttm_type = C_PARAM_GROUP
                and uttm_name = 'JSON_ERRORS'
                and uttm_mode = C_MODE_FRAME))
      into l_json
      from dual;
                
    pit.leave_optional(msg_params(msg_param('JSON', l_json)));
    return l_json;
  end get_errors_as_json;
  

  /** Method to retrieve a list of elements identified by the jQuery expression passed in
   * @param  p_spi_id   Item ID or DOCUMENT.
   * @param  p_param_2  jQuery expression that gets evaluated if P_SPI_ID is DOCUMENT
   * @return CHAR_TABLE instance with all item namens that match the jQuery expression
   * @usage  Analyses the jQuery expression and returns all items that match
   *         Possible expressions:
   *         - CSS class comma separated list of CSS classes, including .-sign
   *           Identifies page items with matching CSS elements
   *         - comma separated list of ID selectors, including #-sign
   */
  function get_firing_items(
    p_spi_id in sct_page_item.spi_id%type,
    p_param_2 in sct_rule_action.sra_param_2%type)
    return char_table
  as
    l_item_list char_table;
  begin
    case 
    when p_spi_id = sct_util.C_NO_FIRING_ITEM and trim(p_param_2) like '.%' then
      -- attribute contains jQuery CSS selector, search page items with corresponding CSS
        with params as(
             select apex_application.g_flow_id application_id,
                    apex_application.g_flow_step_id page_id,
                    replace(column_value, '.') css
               from table(utl_text.string_to_table(p_param_2, ',')))
      select /*+ NO_MERGE (params) */
             cast(collect(item_name) as char_table)
        into l_item_list
        from apex_application_page_items
     natural join params
       where (html_form_element_css_classes is not null
         and instr(html_form_element_css_classes || ' ', params.css || ' ') > 0)
          or (item_css_classes is not null 
         and instr(item_css_classes || ' ', params.css || ' ') > 0);

    when p_spi_id = sct_util.C_NO_FIRING_ITEM and trim(p_param_2) like '#%' then
      -- attribute is list of jQuery ID selectors. Find actions with matching ID
      select cast(collect(item_name) as char_table)
        into l_item_list
        from apex_application_page_items
       where application_id = apex_application.g_flow_id
         and page_id = apex_application.g_flow_step_id
         and instr(p_param_2 || ',', '#' || item_name || ',') > 0;
    else
      l_item_list := null;
    end case;
    return l_item_list;
  end get_firing_items;
  

  /** Method calculates all items which are referenced by the rules executed and collects them as JSON
   * @return JSON instance for all page items referenced by the rule executed.
   *         Structure: [{"id":"#ID#","value":"#VALUE#"}, ...]
   */
  function get_items_as_json
    return varchar2
  as
    l_json sct_util.max_char;
    l_item varchar2(50);
  begin
    pit.enter_optional;
    
    l_item := g_param.page_items.first;
    while l_item is not null loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(c_page_json_element, char_table(
          'ID', l_item,
          'VALUE', htf.escape_sc(get_char(l_item)))),
        C_DELIMITER, true);
      l_item := g_param.page_items.next(l_item);
    end loop;
    
    l_json := replace(C_BIND_JSON_TEMPLATE, '#JSON#', l_json);
    
    pit.leave_optional(msg_params(msg_param('JSON', l_json)));
    return l_json;
  end get_items_as_json;
  
  
  /** Helper method to retrieve a list of session state values for a comma delimited item list
   * @param  p_spi_list    comma-separated list of page item names for which the session state values have to be returned
   * @param  p_value_list  CHAR_TABLE instance with the session state values of the page items passed in via P_SPI_LIST
   * @usage  This method is used as a helper to get the session state values of a comma separated list of page item names.
   *         It is called by EXCLUSIVE_OR and NOT_NULL to check whether the respective rules are obeyed.
   */
  procedure get_item_values_as_char_table(
    p_spi_list in varchar2,
    p_value_list out nocopy char_table)
  as
    l_filter sct_util.max_char;
    C_TMPLT constant varchar2(1000) := q'^begin :x := char_table('#FILTER#'); end;^';
    l_filter_list char_table;
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_spi_list', p_spi_list)));
    
    -- convert comma separated list to CHAR_TABLE instance
    l_filter := replace(replace(p_spi_list, ' '), ',', ''',''');
    execute immediate replace(C_TMPLT, '#FILTER#', l_filter) using out l_filter_list;
    
    -- Get the session state values as CHAR_TABLE
    select cast(
             multiset(
               select v(spi_id)
                 from sct_page_item spi
                 join table(l_filter_list) t
                   on t.column_value = spi_id
                   or instr(spi_css, '|' || replace(t.column_value, '.') || '|') > 0
                where spi_sgr_id = g_param.sgr_id
             ) as char_table
           ) spi_value
      into p_value_list
      from dual;
      
    pit.leave_optional;
  end get_item_values_as_char_table;
  
  
  /* Merthod to compose the JavaScript result of the rule evaluation
   * @return JavaScript response to be executed on the page as the response of the rule evaluation
   * @usage  Is used to compose the answer of SCT as a JavaScript to be executed by the browser.
   *         Depending on parameterization and length of the response, the response will contain more or lesse code.
   *         As the maximum response size is limited zto 32KByte, the method may decide to skip comments in order to respect
   *         the size limit.
   */
  function get_java_script
    return varchar2
  as
    l_js sct_util.max_char;
    l_length binary_integer := 1;
    l_max_level binary_integer := 0;
  begin
    pit.enter_optional;
                  
    -- add APEX actions, if existing
    append(l_js, get_apex_actions);
                        
    -- process rule javascript from stack
    if g_param.js_action_stack.count > 0 then
      -- Mesaure total char length of every level on stack and limit length to 32K max by emitting levels top down
      -- until length is below that barrier
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
      
      -- collect all javascript chunks
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
    
    -- wrap JavaScript in <script> tag and add item value and error scripts
    l_js := utl_text.bulk_replace(C_JS_SCRIPT_FRAME, char_table(
              'SCRIPT', l_js,
              'CR', sct_util.C_CR,
              'ITEM_JSON', get_items_as_json,
              'ERROR_JSON',  get_errors_as_json,
              'FIRING_ITEMS', join_list(C_FIRING_ITEMS),
              'JS_FILE', C_JS_NAMESPACE,
              'DURATION', to_char(dbms_utility.get_time - g_param.now)));
    
    pit.leave_optional(msg_params(msg_param('JavaScript', substr(l_js, 1, 3000))));
    return l_js;
  end get_java_script;
  
  
  /* Helper method to create comments in JavaScript to indicate the rule details the script originates from
   * and other useful information such as the recursive depth an exception handler and so forth.
   * @param  p_rule  Rule record of the active rule
   */
  procedure get_java_script_comments(
    p_rule in rule_rec)
  as
    l_origin_msg varchar2(1000);
    l_actual_recursive_level binary_integer;
  begin
    pit.enter_optional;
    
    -- first line, add origin message
    if p_rule.is_first_row = sct_util.C_TRUE then
      l_actual_recursive_level := g_param.recursive_level - 1;
      
      if not g_has_errors then
        -- normal execution, add message
        if p_rule.sru_fire_on_page_load = sct_util.C_TRUE then
          l_origin_msg := msg.SCT_INIT_ORIGIN;
        else
          l_origin_msg := msg.SCT_RULE_ORIGIN;
        end if;
        add_java_script(
          p_java_script => sct_util.C_CR || 
                           pit.get_message_text(
                             p_message_name => l_origin_msg, 
                             p_arg_list => msg_args(
                                             to_char(l_actual_recursive_level), 
                                             to_char(p_rule.sru_sort_seq), 
                                             p_rule.sru_name, 
                                             g_param.firing_item)),
          p_debug_level => C_JS_RULE_ORIGIN);
      else
        -- exception occurred, pass message
        add_comment(
          p_message_name => msg.SCT_ERROR_HANDLING, 
          p_arg_list => msg_args(
                          to_char(l_actual_recursive_level), 
                          to_char(p_rule.sru_sort_seq), 
                          p_rule.sru_name, 
                          g_param.firing_item));
      end if;
    end if;

    pit.leave_optional;
  end get_java_script_comments;
  
  
  /* Method to retrieve a default value for a mandatory page item
   * @param  p_spi_id  ID of the page item
   * @return Default value for that page item
   * @usage  Is used to retrieve the default value if a mandatory item is NULL and  a default value was defined.
   */
  function get_mandatory_default_value(
    p_spi_id in sct_page_item.spi_id%type)
    return varchar2
  as
    l_default sct_page_item.spi_item_default%type;
  begin
    -- Tracing done in PLUGIN_SCT
    select spi_item_default
      into l_default
      from sct_page_item
     where spi_is_mandatory = sct_util.c_true
       and spi_id = p_spi_id
       and spi_sgr_id = g_param.sgr_id;
    return l_default;
  exception
    when no_data_found then
      return null;
  end get_mandatory_default_value;
  
  
  /** Persists the explicitly assigned mandatory message for a page item
   * @param  p_spi_id                 ID of the mandatory page item
   * @param  p_spi_mandatory_message  Optional explicit error message
   * @return Error message for missing value
   * @usage  If a mandatory item is NULL, a message has to be generated which may have been excplicitly given or not.
   *         This method creates this message and returns a standard message if no explicit message is available.
   */
  function get_mandatory_message(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2)
    return varchar2
  as
    l_mandatory_message sct_page_item.spi_mandatory_message%type;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_spi_mandatory_message', limit_string(p_spi_mandatory_message))));
                    
    if p_spi_mandatory_message is null and p_spi_id != sct_util.C_NO_FIRING_ITEM then
      select pit.get_message_text(msg.SCT_ITEM_IS_MANDATORY, msg_args(spi_label))
        into l_mandatory_message
        from sct_page_item
       where spi_id = p_spi_id
         and spi_sgr_id = g_param.sgr_id;
    else
      l_mandatory_message := p_spi_mandatory_message;
    end if;
    
    pit.leave_optional;
    return l_mandatory_message;
  end get_mandatory_message;
  

  /** Helper to analyze an attribute
   * @param  p_spi_id  Name of the referenced item or sct_uit.C_NO_FIRING_ITEM
   * @param  p_param   Attribute value to analyze
   * @return result of the analysis, either static or dynamic 
   * @usage  Used to evaluate an attribute. The following syntactical possibilities exist:
   *         - jQuery CSS selector
   *         - jQuery ID selector
   *         - static string, encapsulated in single quotes
   *         - PL/SQL-Block without single quotes, with or without terminating semicolon
   */
  function analyze_parameter(
    p_spi_id in varchar2,
    p_replacement in varchar2,
    p_selector in varchar2,
    p_param in sct_rule_action.sra_param_2%type)
    return varchar2
  as
    C_CMD constant varchar2(100) := 'begin :x := #CMD#; end;';
    l_result sct_util.max_char := p_param;
  begin
    pit.enter_detailed(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_replacement', p_replacement),
                    msg_param('p_selector', p_selector),
                    msg_param('p_param', p_param)));
                    
    if p_spi_id = sct_util.C_NO_FIRING_ITEM then
      if p_param is not null and instr(p_replacement, p_selector) > 0 then 
        case substr(p_param, 1, 1)
          when '.' then null;
          when '#' then null;
          when '''' then l_result := trim('''' from p_param);
          else execute immediate replace(C_CMD, '#CMD#', trim(';' from p_param)) using out l_result;
        end case;
      else
        l_result := p_param;
      end if;
    else
      l_result := p_spi_id;
    end if;
    
    pit.leave_detailed(msg_params(msg_param('Parameter', l_result)));
    return l_result;
  end analyze_parameter;
  
  
  /** Method to format a firing item
   * @usage  Analyzes, whether the firing item has got a conversion mask. If so, ...
   *        - it tries to convert it and catches any conversion errors
   *        - it converts the item value and stores a formatted version in the session state
   */
  procedure format_firing_item
  as
    l_spi_sit_id sct_page_item.spi_sit_id%type;
    l_spi_conversion sct_page_item.spi_conversion%type;
    l_number_val number;
    l_date_val date;
  begin
    pit.enter_detailed;
    
    -- get the format mask for the firing item
    select spi_sit_id, spi_conversion
      into l_spi_sit_id, l_spi_conversion
      from sct_page_item
     where spi_sgr_id = g_param.sgr_id
       and spi_id = g_param.firing_item
       and spi_conversion is not null;
    
    case l_spi_sit_id
      when C_NUMBER_ITEM then
        -- convert to number
        l_number_val := get_number(g_param.firing_item, l_spi_conversion);        
        -- conversion successful, set formatted string in session state
        set_session_state(g_param.firing_item, to_char(l_number_val, l_spi_conversion), sct_util.C_TRUE, null);
      when C_DATE_ITEM then
        -- convert to date
        l_date_val := get_date(g_param.firing_item, l_spi_conversion);
        -- conversion successful, set formatted string in session state
        set_session_state(g_param.firing_item, to_char(l_date_val, l_spi_conversion), sct_util.C_TRUE, null);
      else
        pit.stop(msg.SCT_UNEXPECTED_CONV_TYPE, msg_args(l_spi_sit_id));
    end case;
    
    pit.leave_detailed;
  exception
    when no_data_found then
      -- no format mask detected, ignore.
      pit.leave_detailed;
  end format_firing_item;


  /** Method to determine whether rule execution has to be checked for recursive allowance. 
   * This is not checked during initialization for rules that are set to FIRE_ON_PAGE_LOAD.
   * @param  p_rule  RULE_REC instance of the actually selected rule
   * @return Flag to indicate whether a recursion has to be checked or not
   * @usage  Normally, any rule is checked whether it is allowed to execute it recursively. A rule that is set to 
   *         FIRE_ON_PAGE_LOAD is an exception in this regard, if the page is in initialization process.
   *         Whether this is true for the actual rule is checked within this method.
   */
  function check_recursion(
    p_rule in rule_rec)
    return sct_util.flag_type
  as
    sResult sct_util.flag_type;
  begin
    pit.enter_detailed(
      p_params => msg_params(
                    msg_param('p_rule.item', p_rule.item),
                    msg_param('p_rule.sru_fire_on_page_load', to_char(p_rule.sru_fire_on_page_load))));
    
    case when p_rule.item = sct_util.C_NO_FIRING_ITEM and p_rule.sru_fire_on_page_load = sct_util.C_TRUE
      then sResult := sct_util.C_FALSE;
      else sResult := sct_util.C_TRUE;
    end case;
    
    pit.leave_detailed(msg_params(msg_param('Result', to_char(sResult))));
    return sResult;
  end check_recursion;
  

  /** Method to prepare JavaScript contained in rule for execution
   * @param  p_rule  RULE_REC instance of the actually selected rule
   * @usage  Is used to collect JavaScript code that is included in the rule actions.
   *         Before the JavaScript code can be collected, all arguments need to be replaced. This is done in this method.
   */
  procedure handle_js_code(
    p_rule in rule_rec)
  as
    C_JS_ITEM_VALUE_TEMPLATE constant varchar2(100 byte) := q'~apex.item('#ITEM#').getValue()~';
    l_js_code sct_util.max_char;

  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_rule.js', p_rule.js),
                    msg_param('p_rule.sra_param_1', p_rule.sra_param_1),
                    msg_param('p_rule.sra_param_2', p_rule.sra_param_2),
                    msg_param('p_rule.sra_param_3', p_rule.sra_param_3),
                    msg_param('p_rule.item', p_rule.item)));
    
    get_java_script_comments(p_rule);

    -- Extract JavaScript chunk, replace parameters and register with response
    if p_rule.js is not null then
      l_js_code := utl_text.bulk_replace(p_rule.js, char_table(
                     'JS_FILE', C_JS_NAMESPACE,
                     'ITEM_VALUE', C_JS_ITEM_VALUE_TEMPLATE,
                     'ITEM', p_rule.item,
                     'SELECTOR', analyze_parameter(p_rule.item, l_js_code, '#SELECTOR#', p_rule.sra_param_2),
                     'PARAM_1', p_rule.sra_param_1,
                     'PARAM_2', p_rule.sra_param_2,
                     'PARAM_3', p_rule.sra_param_3,
                     'SRU_SORT_SEQ', case when p_rule.sru_sort_seq is not null then 'RULE_' || p_rule.sru_sort_seq else 'NO_RULE_FOUND' end,
                     'SRU_NAME', p_rule.sru_name,
                     'FIRING_ITEM', g_param.firing_item,
                     'CR', sct_util.C_CR));
      add_java_script(l_js_code, C_JS_CODE);
    end if;
    
    pit.leave_optional;
  end handle_js_code;
  

  /** Helper to execute PL/SQL code
   * @param  p_rule  RULE_REC instance of the actually selected rule
   * @usage  Is used to immediately execute PL/SQL code that is included in the rule actions.
   *         The method prepares the PL/SQL code by replacing the parameter anchors and executes it. If an error occurs,
   *         this is registered with SCT and the execution is stopped.
   */
  procedure handle_plsql_code(
    p_rule in out nocopy rule_rec)
  as
    C_PLSQL_ITEM_VALUE_TEMPLATE constant varchar2(100 byte) := q'~v('#ITEM#')~';
    l_plsql_code sct_util.max_char;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_rule.pl_sql', p_rule.pl_sql),
                    msg_param('p_rule.sra_param_1', p_rule.sra_param_1),
                    msg_param('p_rule.sra_param_2', p_rule.sra_param_2),
                    msg_param('p_rule.sra_param_3', p_rule.sra_param_3),
                    msg_param('p_rule.item', p_rule.item)));
                    
    -- create PL/QSL code from template
    if p_rule.pl_sql is not null then
      l_plsql_code := utl_text.bulk_replace(trim(';' from p_rule.pl_sql), char_table(
                        'PARAM_1', p_rule.sra_param_1,
                        'PARAM_2', p_rule.sra_param_2,
                        'PARAM_3', p_rule.sra_param_3,
                        'ALLOW_RECURSION', check_recursion(p_rule),
                        'ITEM_VALUE', C_PLSQL_ITEM_VALUE_TEMPLATE,
                        'ITEM', p_rule.item,
                        'CR', sct_util.C_CR));
                        
      -- Don't remove COMMIT from the code template. As this code is called using AJAX, no transaction control
      -- from APEX exists, so we need to control it ourselves.
      l_plsql_code := replace('begin #CODE#; commit; end;', '#CODE#', l_plsql_code);
      
      pit.verbose(msg.PIT_PASS_MESSAGE, msg_args('PL/SQL-Code: ' || l_plsql_code));

      -- Execute PL/SQL code. Stop if an error occurs
      begin
        execute immediate l_plsql_code;
      exception
        when others then
          -- Stop further execution for non exception handlers
          p_rule.sru_on_error := sct_util.C_TRUE;
          -- Display error
          pit.sql_exception(msg.SCT_UNHANDLED_EXCEPTION, msg_args(l_plsql_code));
          register_error(p_rule.item, msg.SCT_UNHANDLED_EXCEPTION, msg_args(apex_escape.json(l_plsql_code)));
          -- surpress recursion
          stop_rule;
      end;
      l_plsql_code := null;
    end if;
    
    pit.leave_optional;
  end handle_plsql_code;
  
  
  /** Method calculates the answer for a given situation in the session state based on the SCT rules for the active page.
   * @usage  Is called from PROCESS_RULE. This method selects the applicable rule for the actual situation and executes it
   */
  procedure create_action
  as
    l_rule rule_rec;
    l_rule_name sct_rule.sru_name%type;
    l_action_cur sys_refcursor;
    l_stmt sct_util.max_char;
    l_now binary_integer;
    l_has_js boolean default false;
  begin
    pit.enter_mandatory;

    -- Initialization
    g_has_errors := false;
    l_now := dbms_utility.get_time;
    
    -- Prepare SQL rule
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    sct_admin.C_VIEW_NAME_PREFIX || g_param.sgr_id rule_view,
                    g_param.is_recursive is_recursive
               from utl_text_templates
              where uttm_type = C_PARAM_GROUP
                and uttm_name = 'RULE_STMT'
                and uttm_mode = C_MODE_DEFAULT))
      into l_stmt
      from dual;
    pit.verbose(msg.SCT_DEBUG_RULE_STMT, msg_args(l_stmt));
    
    -- Calculate the rule actions. Explicit cursor control because of dynamic SQL
    open l_action_cur for l_stmt;
    fetch l_action_cur into l_rule;  -- Evaluates rule
    pit.verbose(msg.SCT_PROCESSING_RULE, msg_args(to_char(l_rule.sru_sort_seq), l_rule.sru_name));
    while l_action_cur%FOUND loop
      l_rule_name := l_rule.sru_name;
      append_test_result(l_rule);
      case when ((l_rule.sru_on_error = sct_util.C_FALSE or not g_has_errors) 
            and l_rule.sra_on_error = sct_util.C_FALSE) 
             or (l_rule.sra_on_error = sct_util.C_TRUE and g_has_errors) then
             -- Normal execution. This is true in three possible cases:
             -- 1: No exception occurred
             -- 2: Rule is set to ignore exceptions
             -- 3: Exception occurred and action is an exception handler
        -- calculate and execute PL/SQL code
        handle_plsql_code(l_rule);
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
    
    -- Add time measurement and collected notification messages to origin comments
    for i in 1 .. g_param.js_action_stack.count loop
      case when g_param.js_action_stack(i).debug_level = C_JS_RULE_ORIGIN then
        utl_text.bulk_replace(g_param.js_action_stack(i).script, char_table(
          'NOTIFICATION', g_param.notification_stack,
          'TIME', coalesce(dbms_utility.get_time - l_now, 0) || 'hsec'));
      when g_param.js_action_stack(i).debug_level = C_JS_CODE then
        l_has_js := true;
      else
        null;
      end case;
    end loop;
    
    if not l_has_js then
      -- No JavaScript found, notify if set to verbose
      add_comment(
        p_message_name => msg.SCT_NO_JAVASCRIPT, 
        p_arg_list => msg_args(l_rule_name, sct_util.C_CR));
    end if;
    
    pit.leave_mandatory;
  exception
    when msg.CONVERSION_IMPOSSIBLE_ERR or VALUE_ERROR or INVALID_NUMBER then
      close l_action_cur;
      pit.sql_exception;
    when others then
      close l_action_cur;
      pit.sql_exception(msg.SQL_ERROR, msg_args(l_stmt));
  end create_action;
  
    
  /** Method analyzes the requested rule of the rule group
   * @return HTML script element with a JavaScript code containing the answer of the rule
   * @usage  is called if a rule has to be executed
   *         - Create a JavaScript script to execute on the page
   *         - analyzes whether changes the rule initiates causes other rules to be recursively called
   */
  procedure process_rule
  as
    l_has_recursive_request boolean := false;
    l_processed_item sct_page_item.spi_id%type;
    l_actual_recursive_level binary_integer;
  begin
    pit.enter_optional;
    
    -- Initialization
    l_actual_recursive_level := g_param.recursive_level;
    
    -- increments recursion level for »breadth first« execution: First execute all rules on active level before dealing with
    -- recursively called rules
    g_param.recursive_level := l_actual_recursive_level + 1;
    
    -- is_recursive flag indicates whether actually we're in a recursive run or not. Used to exclude rules or actions 
    -- which are not eligible for recursive execution
    g_param.is_recursive := case l_actual_recursive_level when 1 then sct_util.C_FALSE else sct_util.C_TRUE end;
    
    -- iterate over recursion stack
    g_param.firing_item := g_param.recursive_stack.first;

    while g_param.firing_item is not null loop
      begin
        --  raise all »events« on active recursion level
        if g_param.recursive_stack(g_param.firing_item) = l_actual_recursive_level then
          -- save item to pop it from the recursion stack later
          l_processed_item := g_param.firing_item;
          l_has_recursive_request := true;
          g_param.notification_stack := null;
          
          -- calculate action based on selected rule. Will immediately execute PL/SQL code and collect JavaScript as a response
          create_action;
          
          -- save processed item to firing item stack. Is used to harmonize its value with the page
          push_firing_item(l_processed_item);
        end if;
        
        -- process next element
        g_param.firing_item := g_param.recursive_stack.next(g_param.firing_item);
        
        -- Administer recursive stack
        case when g_param.stop_flag then
          g_param.recursive_stack.delete;
          exit;
        when l_processed_item is not null then
          -- pop processed element from recursion stack
          g_param.recursive_stack.delete(l_processed_item);
        else
          null;
        end case;
      exception
        when others then
          register_error(l_processed_item, msg.SCT_INTERNAL_ERROR);
          g_param.recursive_stack.delete;
          pit.sql_exception(msg.SCT_INTERNAL_ERROR, msg_args(sqlerrm));
          exit;
      end;
    end loop;
    
    -- Recursively process all entries on call stack
    if l_has_recursive_request then
      process_rule;
    end if;
    
    pit.leave_optional;
  end process_rule;  
  
  
  /** Method pushes a page item onto the bind item stack.
   * @param  p_spi_id  Name of the page item to push onto the stack
   * @usage  Is used to collect all items that SCT needs to observe. During installation, these items get an event handler
   *         that calls SCT if the respective event is raised
   */
  procedure push_bind_item(
    p_spi_id in sct_page_item.spi_id%type)
  as
  begin
    pit.enter_detailed(p_params => msg_params(msg_param('p_spi_id', p_spi_id)));
    
    if not g_param.bind_items.exists(p_spi_id) then
      g_param.bind_items(p_spi_id) := 1;
    end if;
    
    pit.leave_detailed;
  end push_bind_item;
  
  
  /** Method pushes a page item onto the page item stack.
   * @param  p_spi_id  Name of the page item to push onto the stack
   * @usage  SCT maintains a list of page item it has worked on during the active rule evaluation. This is required to
   *         pass all possibly changed item values back to the browser
   */
  procedure push_page_item(
    p_spi_id in sct_page_item.spi_id%type)
  as
  begin
    pit.enter_detailed(p_params => msg_params(msg_param('p_spi_id', p_spi_id)));
    
    if not g_param.page_items.exists(p_spi_id) then
      g_param.page_items(p_spi_id) := 1;
    end if;
    
    pit.leave_detailed;
  end push_page_item;
  
  
  /** Method to register items which have changed their value in the session state. If recursion is set to true, those elements
   *  will cause SCT to evaluate rules for that element by imitating that an event has thrown on that element.
   * @param  p_spi_id             ID of the page item to register
   * @param [p_allow_recursion] Flag to indicate whether this element is allowed to cause a recursive SCT rule call
   * @usage  Is used to register page items that changed their value because of code executed in SCT. Two things have to happen:
   *         - Return the changed value to the browser to harmonize the UI with the session state
   *         - Have SCT evaluate any rules that fire based on the new value. This is true only if P_ALLOW_RECURSION is true.
   */
  procedure register_item(
    p_spi_id in varchar2,
    p_allow_recursion in sct_util.flag_type default sct_util.C_TRUE)
  as
    l_has_rule number;
  begin
    pit.enter_detailed(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id), 
                    msg_param('p_allow_recursion', to_char(p_allow_recursion))));
                    
    -- Register item to assure that the changed value is return to the browser
    push_page_item(p_spi_id);
    
    if p_allow_recursion = sct_util.C_TRUE then
      -- If page item that is worked upon is referenced in rules, register recursive call for this page item
      select count(*)
        into l_has_rule
        from dual
       where exists(
             select 1
               from sct_page_item
              where spi_id = p_spi_id     
                -- Element ist relevant  
                and spi_is_required = sct_util.C_TRUE
                -- und ruft sich nicht selbst auf
                and p_spi_id != coalesce(g_param.firing_item, 'FOO'));
                
      if l_has_rule > 0 then   
        if g_param.recursive_level <= g_recursion_limit then
          if not g_param.recursive_stack.exists(p_spi_id) then
            -- push element on recursive stack to evalualte its rule in the next recursion
            g_param.recursive_stack(p_spi_id) := g_param.recursive_level;
          else
            -- Recursion loop occurred, cancel or notify
            if g_recursion_loop_is_error then
              register_error(p_spi_id, msg.SCT_RECURSION_LOOP, msg_args(p_spi_id, to_char(g_param.recursive_level)));
            else
              register_notification(msg.SCT_RECURSION_LOOP, msg_args(p_spi_id, to_char(g_param.recursive_level)));
            end if;
          end if;
        else
          -- max recursion level exceeded, cancel and throw error
          register_error(p_spi_id, msg.SCT_RECURSION_LIMIT, msg_args(p_spi_id, to_char(g_recursion_limit)));
        end if;
      end if;
    end if;
    pit.leave_detailed;
  end register_item;
  
  
  procedure initialize
  as
  begin
    g_recursion_loop_is_error := param.get_boolean('RAISE_RECURSION_LOOP', C_PARAM_GROUP);
    g_recursion_limit := param.get_integer('RECURSION_LIMIT', C_PARAM_GROUP);
  end initialize;


  /*============ INTERFACE ============*/  
  /* PLUGIN FUNCTIONALITY */
  function get_bind_items_as_json
    return clob
  as
    -- List of item which need to bind an event
    cursor rule_group_spi_ids(p_sgr_id sct_rule_group.sgr_id%type) is
      select spi_id, sit_event, sit_has_value, null static_action
        from sct_page_item spi
        join sct_page_item_type sit
          on spi.spi_sit_id = sit.sit_id
        join sct_rule_group sgr
          on spi.spi_sgr_id = sgr.sgr_id
       where sit.sit_event is not null
         and spi.spi_is_required = sct_util.C_TRUE
         and sgr.sgr_active = sct_util.C_TRUE
         and sgr.sgr_id = p_sgr_id
     union all
     -- List of items which are bound by other events already
     select coalesce(to_char(sra_param_2), sra_spi_id), sit_event, sit_has_value, sra_param_1
       from sct_page_item_type
       join sct_rule_action
         on sit_id = sra_sat_id
      where sra_sgr_id = p_sgr_id;
    l_json clob;
  begin
    -- Tracing done in PLUGIN_SCT
    for item in rule_group_spi_ids(g_param.sgr_id) loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(C_BIND_JSON_ELEMENT, char_table(
          'ID', item.spi_id,
          'EVENT', item.sit_event,
          'STATIC_ACTION', item.static_action)),
        ',', true);
      -- register relevant items with session state to make sure that their actual value is harmonized with the page
      -- (this task is served by REGISTER_ITEM after initialization)
      if item.sit_has_value = sct_util.c_true then
        push_page_item(item.spi_id);
      end if;
    end loop;
    
    -- Create items with '~' as a replacement for '"' to prevent APEX from escaping it with an escape sequence.
    -- This assures that the browser is able to create a JavaScript object from it
    return replace(replace(C_BIND_JSON_TEMPLATE, '#JSON#', l_json), '"', '~');
  end get_bind_items_as_json; 
  
  
  function get_char(
    p_spi_id in sct_page_item.spi_id%type)
    return varchar2
  as
    l_char varchar2(32767);
  begin
    pit.enter_detailed(p_params => msg_params(msg_param('p_spi_id', p_spi_id)));
    
    l_char := coalesce(v(p_spi_id), get_mandatory_default_value(p_spi_id));
    
    pit.leave_detailed(p_params => msg_params(msg_param('Result', l_char)));
    return l_char;
  end get_char;
    
    
  function get_date(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in sct_util.flag_type default sct_util.C_TRUE)
    return date
  as
    l_raw_value sct_util.max_char;
    l_date date;
  begin
    pit.enter_detailed(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_format_mask', p_format_mask),
                    msg_param('p_throw_error', to_char(p_throw_error))));
  
    /** TODO: Umbauen auf VALIDATE_CONVERSION, falls 12.2 vorausgesetzt werden kann und die Bugs hierzu behoben sind */
    l_raw_value := get_char(p_spi_id);
    l_date := to_date(l_raw_value, p_format_mask);
    
    pit.leave_detailed(p_params => msg_params(msg_param('Result', to_char(l_date, 'yyyy-mm-dd'))));
    return l_date;
  exception
    when msg.INVALID_DATE_ERR then
      register_error(p_spi_id, msg.INVALID_DATE, msg_args(l_raw_value, p_format_mask));
      if p_throw_error = sct_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', to_char(l_date, 'yyyy-mm-dd'))));
      return null;
    when msg.INVALID_DATE_FORMAT_ERR then
      register_error(p_spi_id, msg.INVALID_DATE_FORMAT, msg_args(l_raw_value, p_format_mask));
      if p_throw_error = sct_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', to_char(l_date, 'yyyy-mm-dd'))));
      return null;
    when msg.INVALID_YEAR_ERR or msg.INVALID_MONTH_ERR or msg.INVALID_DAY_ERR then
      register_error(p_spi_id, msg.INVALID_YEAR, msg_args(sqlerrm));
      if p_throw_error = sct_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', to_char(l_date, 'yyyy-mm-dd'))));
      return null;
  end get_date;


  function get_error_flag
    return boolean
  as
  begin
    -- Tracing done in PLUGIN_SCT
    return g_has_errors;
  end get_error_flag;
  
    
  function get_event
    return varchar2
  as
  begin
    -- Tracing done in PLUGIN_SCT
    return g_param.firing_event;
  end get_event;
  
  
  function get_firing_item
    return varchar2
  as
  begin
    -- Tracing done in PLUGIN_SCT
    return g_param.firing_item;
  end get_firing_item;
  
  
  function get_number(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in sct_util.flag_type default sct_util.c_false)
    return number
  as
    l_raw_value sct_util.max_char;
    l_result number;
  begin
    pit.enter_detailed(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_format_mask', p_format_mask),
                    msg_param('p_throw_error', to_char(p_throw_error))));
    
    l_raw_value := get_char(p_spi_id);
    l_raw_value := rtrim(ltrim(l_raw_value, ', '));
    l_result := to_number(l_raw_value, p_format_mask);
    
    pit.leave_detailed(p_params => msg_params(msg_param('Result', to_char(l_result))));
    return l_result;
  exception
    when msg.INVALID_NUMBER_FORMAT_ERR then
      register_error(p_spi_id, msg.INVALID_NUMBER_FORMAT, msg_args(l_raw_value, p_format_mask));
      if p_throw_error = sct_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', to_char(l_result))));
      return null;
    when INVALID_NUMBER or VALUE_ERROR then
      register_error(p_spi_id, msg.SCT_INVALID_NUMBER_REMOVED, msg_args(l_raw_value));
      if p_throw_error = sct_util.C_TRUE then
        raise;
      end if;
      pit.leave_detailed(p_params => msg_params(msg_param('Result', to_char(l_result))));
      return null;
  end get_number;


  function get_page_items
    return varchar2
  as
  begin
    -- Tracing done in PLUGIN_SCT
    return join_list(C_PAGE_ITEMS);
  end get_page_items;
  
  
  procedure process_initialization_code
  as
    l_initialization_code sct_rule_group.sgr_initialization_code%type;
  begin
    -- Tracing done in PLUGIN_SCT
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

  
  function process_request
    return clob
  as
    l_js_script sct_util.max_char;
  begin      
    pit.enter_optional;
    
      process_rule;
      l_js_script := get_java_script;
      
    pit.leave_optional;
    return l_js_script;
  end process_request;
  
  
  procedure push_error(
    p_error in apex_error.t_error)
  as
    l_error apex_error.t_error;
    l_error_json sct_util.max_char;
  begin
    pit.enter_optional;
  
    l_error := p_error;
    begin
      -- prepare message texts
      if l_error.message like ' Zeile 1%' then
        l_error.message := pit.get_trans_item_name(C_PARAM_GROUP, 'FAULTY_ERROR_MESSAGE');
      end if;
      l_error.additional_info := apex_escape.js_literal(l_error.additional_info);
      l_error.message := apex_escape.js_literal(l_error.message);
    exception
      when others then
        l_error.message := pit.get_trans_item_name(C_PARAM_GROUP, 'INVALID_ERROR_MESSAGE');
    end;
    
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    l_error.page_item_name page_item,
                    l_error.message message,
                    l_error.additional_info additional_info,
                    case l_error.page_item_name when sct_util.C_NO_FIRING_ITEM  then '"page"' else '["inline","page"]' end location
               from utl_text_templates
              where uttm_type = C_PARAM_GROUP
                and uttm_name = 'JSON_ERRORS'
                and uttm_mode = 'ERROR'))
      into l_error_json
      from dual;
      
    g_param.error_stack(g_param.error_stack.count + 1) := l_error_json;
    g_has_errors := true;
    
    pit.leave_optional;
  end push_error;
  
  
  procedure push_firing_item(
    p_spi_id in varchar2)
  as
    l_item varchar2(1000 char);
  begin
    pit.enter_detailed(p_params => msg_params(msg_param('p_spi_id', p_spi_id)));
    
    if p_spi_id is not null then
      for i in 1 .. regexp_count(p_spi_id, C_DELIMITER) + 1 loop
        l_item := regexp_substr(p_spi_id, '[^\' || C_DELIMITER || ']+', 1, i);
        if l_item is not null and not g_param.firing_items.exists(l_item) then
          g_param.firing_items(l_item) := 1;
        end if;
      end loop;
    end if;
    
    pit.leave_detailed;
  end push_firing_item;
  

  procedure read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_rule_group_name in varchar2,
    p_error_dependent_items in varchar2)
  as
    l_allow_recursion sct_util.flag_type;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_firing_item', p_firing_item),
                    msg_param('p_event', p_event),
                    msg_param('p_rule_group_name', p_rule_group_name),
                    msg_param('p_error_dependent_items', p_error_dependent_items)));
                    
    -- Read rule group
    select sgr_id, coalesce(sgr_with_recursion, sct_util.C_TRUE)
      into g_param.sgr_id, l_allow_recursion
      from sct_rule_group
     where sct_rule_group.sgr_name = upper(p_rule_group_name)
       and sgr_app_id = apex_application.g_flow_id;
    
    -- set recursion flag
    g_param.allow_recursion := l_allow_recursion = sct_util.C_TRUE;
        
    -- Initialize collections
    g_param.bind_items.delete;
    g_param.page_items.delete;
    g_param.firing_items.delete;
    g_param.error_stack.delete;
    g_param.js_action_stack.delete;
    g_param.level_length(C_JS_CODE) := 0;
    g_param.level_length(C_JS_RULE_ORIGIN) := 0;
    g_param.level_length(C_JS_DEBUG) := 0;
    g_param.level_length(C_JS_COMMENT) := 0;
    g_param.error_dependent_items := replace(p_error_dependent_items, ' ');
    g_param.firing_item := coalesce(p_firing_item, sct_util.C_NO_FIRING_ITEM);
    g_param.firing_event := coalesce(p_event, sct_util.C_INITIALIZE_EVENT);
    g_param.recursive_level := 1;
    g_param.now := dbms_utility.get_time;
    g_param.stop_flag := false;
    
    format_firing_item;
    
    -- Register FIRING_ELEMENT on recursion level 1
    g_param.recursive_stack(g_param.firing_item) := g_param.recursive_level;
    
    pit.leave_optional;
  exception
    when msg.CONVERSION_IMPOSSIBLE_ERR then
      -- If conversion is impossible, this is not an issue during installation.
      g_param.error_stack.delete;
      pit.leave_optional;
    when no_data_found then
      register_error(sct_util.C_NO_FIRING_ITEM, msg.SCT_RULE_DOES_NOT_EXIST, msg_args(p_rule_group_name));
      pit.sql_exception(msg.SCT_RULE_DOES_NOT_EXIST, msg_args(p_rule_group_name));
  end read_settings;
    
    
  /*============ SCT FUNCTIONALITY ============*/
  procedure add_javascript(
    p_javascript in varchar2)
  as
  begin
    -- Tracing done in PLUGIN_SCT
    add_java_script(p_javascript);
  end add_javascript;
  
  
  procedure check_date(
    p_spi_id in sct_page_item.spi_id%type)
  as
    l_foo date;
  begin
    -- Tracing done in PLUGIN_SCT
    l_foo := get_date(
               p_spi_id => p_spi_id, 
               p_format_mask => get_conversion(p_spi_id), 
               p_throw_error => sct_util.C_FALSE);
  end check_date;
  
  
  procedure check_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_push_item out nocopy sct_page_item.spi_id%type)
  as
    l_message sct_page_item.spi_mandatory_message%type;
  begin
    -- Tracing done in PLUGIN_SCT
    -- Die Abfrage registriert eine Fehlermeldung, wenn
    -- - Das Element aktuell Pflichtfeld ist
    -- - Das Element keinen Wert im Session State besitzt
    -- - Das Element keinen Defaultwert definiert hat
    select spi_mandatory_message
      into l_message
      from sct_page_item
     where spi_id = p_spi_id
       and spi_sgr_id = g_param.sgr_id
       and spi_is_mandatory = sct_util.C_TRUE
       and (select coalesce(v(g_param.firing_item), spi_item_default) from dual) is null;
    register_error(g_param.firing_item, l_message, '');
  exception
    when no_data_found then
      -- Pflichtfeld hat einen Wert, registrieren um eventuelle Fehlermeldung zu entfernen
      p_push_item := g_param.firing_item;
    when too_many_rows then 
      htp.p(sqlerrm);
  end check_mandatory;
  
  
  procedure check_number(
    p_spi_id in sct_page_item.spi_id%type)
  as
    l_foo number;
  begin
    -- Tracing done in PLUGIN_SCT
    l_foo := get_number(
               p_spi_id => p_spi_id, 
               p_format_mask => get_conversion(p_spi_id), 
               p_throw_error => sct_util.C_FALSE);
  end check_number;


  procedure execute_action(
    p_sat_id in sct_action_type.sat_id%type,
    p_spi_id in sct_page_item.spi_id%type default null,
    p_param_1 in sct_rule_action.sra_param_1%type default null,
    p_param_2 in sct_rule_action.sra_param_2%type default null,
    p_param_3 in sct_rule_action.sra_param_3%type default null)
  as
    l_row sct_action_type%rowtype;
  begin
    -- Tracing done in SCT
    select *
      into l_row
      from sct_action_type
     where sat_id = p_sat_id;

    if l_row.sat_pl_sql is not null then
      l_row.sat_pl_sql := utl_text.bulk_replace('begin #CODE#; end;', char_table(
                            'CODE', rtrim(l_row.sat_pl_sql, ';'),
                            'ITEM', p_spi_id,
                            'PARAM_1', p_param_1,
                            'PARAM_2', p_param_2,
                            'PARAM_3', p_param_3));
      execute immediate l_row.sat_pl_sql;
    end if;

    if l_row.sat_js is not null then
      utl_text.bulk_replace(l_row.sat_js, char_table(
        'ITEM', p_spi_id,
        'SELECTOR', analyze_parameter(p_spi_id, l_row.sat_js, '#SELECTOR#', p_param_2),
        'PARAM_1', p_param_1,
        'PARAM_2', p_param_2,
        'PARAM_3', p_param_3));
      add_java_script(l_row.sat_js);
    end if;
  exception
    when NO_DATA_FOUND then
      register_error('DOCUMENT', msg.SCT_ACTION_DOES_NOT_EXIST, msg_args(p_sat_id));
    when others then
      pit.sql_exception(msg.SQL_ERROR, msg_args(sqlerrm));
  end execute_action;
  
  
  procedure execute_javascript(
    p_plsql in varchar2)
  as
    c_cmd_template varchar2(200) := 'begin :x := #COMMAND#; end;';
    l_result sct_util.max_char;
    l_cmd sct_util.max_char;
  begin
    -- Tracing done in PLUGIN_SCT
    l_cmd := replace(c_cmd_template, '#COMMAND#', replace(trim(p_plsql), ';'));
    execute immediate l_cmd using out l_result;
    add_java_script(replace(l_result, 'javascript:'), C_JS_CODE);
  end execute_javascript;
  
  
  procedure exclusive_or(
    p_spi_id in sct_page_item.spi_id%type,
    p_value_list in varchar2,
    p_message in varchar2,
    p_error_on_null in boolean default false)
  as
    l_result number;
  begin
    -- Tracing done in PLUGIN_SCT
    l_result := exclusive_or(p_value_list);
    if (l_result = 0 or (l_result is null and p_error_on_null)) then
      register_error(p_spi_id, p_message, msg_args(''));
    end if;
  exception
    when others then
      register_error(p_spi_id, sqlerrm, '');
  end exclusive_or;
  
  
  function exclusive_or(
    p_value_list in varchar2)
    return number
  as
    l_result number := -1;
    l_page_values char_table;
    cursor val_cur(p_value_list in char_table) is
      select column_value spi_value
        from table(p_value_list);
  begin
    -- Tracing done in PLUGIN_SCT    
    get_item_values_as_char_table(p_value_list, l_page_values);
    if p_value_list is not null then
      for v in val_cur(l_page_values) loop
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
  end exclusive_or;
  
  
  procedure notify(
    p_message in varchar2)
  as
    c_javascript constant varchar2(200) := sct_util.C_CR || q'^de.condes.plugin.sct.notify(#MESSAGE#);^';
  begin
    -- Tracing done in PLUGIN_SCT
    add_java_script(replace(c_javascript, '#MESSAGE#', apex_escape.js_literal(p_message)), C_JS_CODE);
  end notify;
    
    
  procedure not_null(
    p_spi_id in sct_page_item.spi_id%type,
    p_value_list in varchar2,
    p_message in varchar2)
  as
    l_result number;
  begin
    -- Tracing done in PLUGIN_SCT
    l_result := not_null(p_value_list);
    if l_result = 0 then
      register_error(p_spi_id, p_message, msg_args(''));
    end if;
  exception
    when others then
      pit.leave_optional;
      register_error(p_spi_id, sqlerrm, '');
  end not_null;
    
    
  function not_null(
    p_value_list in varchar2)
    return number
  as
    l_result number := 0;
    l_value_list char_table;
    cursor val_cur(p_value_list in char_table) is
      select column_value spi_value
        from table(p_value_list);
  begin
    -- Tracing done in PLUGIN_SCT
    get_item_values_as_char_table(p_value_list, l_value_list);
    if p_value_list is not null then
      for v in val_cur(l_value_list) loop
        if v.spi_value is not null then
          l_result := 1;
          exit;
        end if;
      end loop;
    end if;
    
    return l_result;
  end not_null;
  
  
  procedure register_error(
    p_spi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2)
  as
    l_error apex_error.t_error;
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, 12);
  begin
    -- Tracing done in PLUGIN_SCT
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
    -- Tracing done in PLUGIN_SCT
    -- Register item to enable the browser to rmove old errors for that item
    push_firing_item(p_spi_id);
    
    -- Create the message
    l_message := message_type(
                   p_message_name => p_message_name,
                   p_message_language => null,
                   p_affected_id => p_spi_id,
                   p_error_code => null,
                   p_session_id => null,
                   p_user_name => v('APP_USER'),
                   p_arg_list => p_arg_list);
    
    -- And convert to APEX error type
    if l_message.message_text is not null then
      l_error.message := l_message.message_text;
      l_error.page_item_name := l_message.affected_id;
      l_error.additional_info := apex_escape.json(pit_util.get_call_stack);
      push_error(l_error);
    end if;
  end register_error;
  
  
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean,
    p_param_2 in sct_rule_action.sra_param_2%type default null)
  as
    l_is_mandatory sct_page_item.spi_is_mandatory%type;
    l_mandatory_message sct_page_item.spi_mandatory_message%type;
    l_label varchar2(100 char);
    l_item_list char_table;
  begin
    -- Tracing done in PLUGIN_SCT
    pit.assert_not_null(g_param.sgr_id);
    
    case
    when p_spi_id != sct_util.C_NO_FIRING_ITEM then
      if p_is_mandatory then 
        l_is_mandatory := sct_util.C_TRUE;
        l_mandatory_message := get_mandatory_message(p_spi_id, p_spi_mandatory_message);
      else 
        l_is_mandatory := sct_util.C_FALSE;
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
    when p_param_2 is not null then
      -- Lese alle Elemente, die durch diese Aktion betroffen sind
      l_item_list := get_firing_items(p_spi_id, p_param_2);
      for i in 1 .. l_item_list.count loop
        register_mandatory(
          p_spi_id => l_item_list(i),
          p_spi_mandatory_message => p_spi_mandatory_message, 
          p_is_mandatory => p_is_mandatory);
      end loop;
    else
      null;
    end case;
  end register_mandatory;
  
  
  procedure register_notification(
    p_text in varchar2)
  as
    c_comment constant varchar2(10) := sct_util.C_CR || '// ';
  begin
    -- Tracing done in PLUGIN_SCT
    utl_text.append(g_param.notification_stack, C_COMMENT || p_text);
  end register_notification;
  
  
  procedure register_notification(
    p_message_name in varchar2,
    p_arg_list in msg_args)
  as
  begin
    -- Tracing done in PLUGIN_SCT
    register_notification(pit.get_message_text(p_message_name, p_arg_list));
  end register_notification;
  
  
  function register_observer
    return varchar2
  as
    l_observable_objects varchar2(2000);
  begin
    pit.enter_optional;
    
    select listagg(
             case when sra_spi_id = sct_util.C_NO_FIRING_ITEM
                  then to_char(sra_param_2) 
                  else sra_spi_id end, ',') within group (order by sru_firing_items)
      into l_observable_objects
      from sct_bl_rules
     where sra_sat_id = C_REGISTER_OBSERVER
       and sgr_id = g_param.sgr_id;
       
    pit.leave_optional(p_params => msg_params(msg_param('Observable objects', l_observable_objects)));
    return l_observable_objects;
  exception
    when no_data_found then
      pit.leave_optional(p_params => msg_params(msg_param('Observable objects', 'None')));
      return null;
  end register_observer;
    
    
  procedure set_list_from_stmt(
    p_spi_id in sct_page_item.spi_id%type,
    p_stmt in varchar2)
  as
    c_stmt constant varchar2(200) := q'~select listagg(value, ':') within group (order by value) from (#STMT#)~';
    l_stmt utl_apex.max_char;
    l_result varchar2(4000);
  begin
    -- Tracing done in PLUGIN_SCT
    l_stmt := replace(c_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_result;
    set_session_state(p_spi_id, l_result, utl_apex.C_TRUE, null);
  end set_list_from_stmt;
  
  
  procedure set_session_state(
    p_spi_id in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in sct_util.flag_type default sct_util.C_TRUE,
    p_param_2 in sct_rule_action.sra_param_2%type default null)
  as
    l_item_list char_table;
  begin
    -- Tracing done in PLUGIN_SCT
    case
    when p_spi_id != sct_util.C_NO_FIRING_ITEM then
      -- Page item, value can be set
      register_item(p_spi_id, p_allow_recursion);
      apex_util.set_session_state(p_spi_id, rtrim(p_value, ';'));
      register_notification(msg.SCT_SESSION_STATE_SET, msg_args(p_spi_id, p_value));
    when p_spi_id = sct_util.C_NO_FIRING_ITEM and p_param_2 is not null then
      -- P_ATTRUBTE_2 contains a jQuery selector for multiple elements
      l_item_list := get_firing_items(p_spi_id, p_param_2);
      if l_item_list.count > 0 then
        for i in l_item_list.first .. l_item_list.last loop
          set_session_state(l_item_list(i), p_value, p_allow_recursion, null);
        end loop;
      end if;
    else
      null;
    end case;
  end set_session_state;


  procedure set_value_from_stmt(
    p_spi_id in sct_page_item.spi_id%type,
    p_stmt in varchar2)
  as
    c_stmt constant varchar2(200) := 'select * from (#STMT#) where rownum = 1';
    l_stmt utl_apex.max_char;
    l_result varchar2(4000);
    l_cur integer;
    l_cnt integer;
    l_col_cnt integer;
    l_desc_tab DBMS_SQL.DESC_TAB2;
  begin
    -- Tracing done in PLUGIN_SCT
    l_stmt := replace(c_stmt, '#STMT#', p_stmt);
    
    if p_spi_id = sct_util.c_no_firing_item or p_spi_id is null then
      -- Wird kein Element angegeben, werden die Elemente gemaess des Spaltennamens gesetzt
      l_cur := dbms_sql.open_cursor;
      -- SQL parsen, um Spaltenbezeichner zu ermitteln
      dbms_sql.parse(l_cur, l_stmt, dbms_sql.native);
      dbms_sql.describe_columns2(l_cur, l_col_cnt, l_desc_tab);
      for i in 1 .. l_col_cnt loop
        dbms_sql.define_column(l_cur, i, l_result, 4000);
      end loop;
      
      -- SQL ausfuehren und erste Zeile laden
      l_cnt := dbms_sql.execute_and_fetch(l_cur);
      -- Alle Spaltenwerte in Seitenelemente mit entsprechendem Spaltennamen kopieren
      for i in 1 .. l_col_cnt loop
        dbms_sql.column_value(l_cur, i, l_result);
        -- Wert in Sessionstatus kopieren
        set_session_state(l_desc_tab(i).col_name, l_result);
      end loop;
      dbms_sql.close_cursor(l_cur);
    else
      -- Konkretes Element angefordert, laut Konvention ist nur eine Spalte enthalten
      execute immediate l_stmt into l_result;
      set_session_state(p_spi_id, l_result, utl_apex.C_TRUE, null);
    end if;
  exception
    when others then
      register_notification(msg.SCT_NO_DATA_FOR_ITEM, msg_args(p_spi_id));
      set_session_state(p_spi_id, '', utl_apex.C_TRUE, null);
  end set_value_from_stmt;
  
  
  procedure stop_rule
  as
  begin
    -- Tracing done in PLUGIN_SCT
    g_param.stop_flag := true;
  end stop_rule;
    
  
  procedure validate_page
  as
    cursor mandatory_items(p_sgr_id in sct_rule_group.sgr_id%type) is
      select spi_id, spi_mandatory_message
        from sct_page_item
       where spi_sgr_id = p_sgr_id
         and spi_is_mandatory = sct_util.C_TRUE;
  begin
    -- Tracing done in PLUGIN_SCT
    for itm in mandatory_items(g_param.sgr_id) loop
      -- Registriere alle Pflichtfelder, damit eventuelle Fehlermeldungen korrekt entfernt werden
      push_firing_item(itm.spi_id);
      if get_char(itm.spi_id) is null then
        -- Pflichtfeld hat keinen Sessionstatus, Fehler werfen
        register_error(itm.spi_id, itm.spi_mandatory_message, '');
      end if;
    end loop;
  end validate_page;
  
begin
  initialize;
end sct_internal;

/
