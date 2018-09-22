create or replace package body bl_sct 
as

  /* Private constants*/
  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;


  /* Private types */
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
  g_firing_item varchar2(30 byte);
  g_with_comments boolean;
  g_has_errors boolean;


  /* HELPER */
  /* Gets message text from PIT to integrate it as a comment in the response
   * %param  p_msg       Message ID
   * %param [p_msg_args] Optional message params
   * %return Message in the respective language
   * %usage  If in debug mode, this method adds descriptive messages to the response
   */
  function get_comment(
    p_msg pit_message.pms_name%type,
    p_msg_args msg_args default null)
    return varchar2
  as
  begin
    if get_with_comments then
      return pit.get_message_text(p_msg, p_msg_args);
    else
      return null;
    end if;
  end get_comment;


  function check_recursion(
    p_rule in rule_rec)
    return varchar2
  as
  begin
    case when p_rule.item = sct_const.c_no_firing_item 
          and p_rule.sru_fire_on_page_load = sct_const.c_true
      then return sct_const.c_false;
      else return sct_const.c_true;
    end case;
  end check_recursion;


  procedure handle_pl_sql_code(
    p_rule in out nocopy rule_rec)
  as
    l_plsql_code varchar2(32767);
  begin
    -- create PL/QSL code from template
    if p_rule.pl_sql is not null then
      l_plsql_code := utl_text.bulk_replace(sct_const.c_plsql_template, char_table(
        '#PLSQL#', p_rule.pl_sql,
        '#ATTRIBUTE#', p_rule.sra_attribute,
        '#ATTRIBUTE_2#', p_rule.sra_attribute_2,
        '#ALLOW_RECURSION#', check_recursion(p_rule),
        '#ITEM_VALUE#', sct_const.c_plsql_item_value_template,
        '#ITEM#', p_rule.item,
        '#CR#', sct_const.c_cr));
      l_plsql_code := replace(replace(sct_const.c_plsql_action_template, 
                        '#CODE#', coalesce(l_plsql_code, sct_const.C_NULL)), 
                        '#CR#', sct_const.c_cr);

      -- Execute PL/SQL code. Stop if an error occurs
      begin
        execute immediate l_plsql_code;
      exception
        when others then
          -- Stop further execution for non exception handlers
          p_rule.sru_on_error := sct_const.c_true;
          -- Display error
          plugin_sct.register_error(p_rule.item, msg.SCT_UNHANDLED_EXCEPTION, msg_args(apex_escape.json(l_plsql_code)));
          -- surpress recursion
          plugin_sct.stop_rule;
      end;
      l_plsql_code := null;
    end if;
  end handle_pl_sql_code;


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
    p_replacement in varchar2,
    p_selector in varchar2,
    p_param in sct_rule_action.sra_attribute_2%type)
    return varchar2
  as
    l_result varchar2(32767) := p_param;
  begin
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
    return l_result;
  end analyze_parameter;


  /* method to prepare JavaScript contained in rule for execution */
  procedure prepare_js_code(
    p_code in out nocopy varchar2,
    p_rule in rule_rec)
  as
    c_delimiter constant varchar2(10) := sct_const.c_cr || '  ';
    l_js_code varchar2(32767);
    l_origin_msg varchar2(1000);
  begin
    -- first line, add message
    if p_rule.is_first_row = sct_const.c_true then
      if not g_has_errors then
        -- normal execution, add message
        if p_rule.sru_fire_on_page_load = sct_const.c_true then
          l_origin_msg := msg.SCT_INIT_ORIGIN;
        else
          l_origin_msg := msg.SCT_RULE_ORIGIN;
        end if;
        p_code := p_code 
               || c_delimiter 
               || pit.get_message_text(l_origin_msg, msg_args('#RECURSION#', to_char(p_rule.sru_sort_seq), p_rule.sru_name, g_firing_item));
      else
        -- exception occurred, pass message
        p_code := p_code 
               || c_delimiter
               || get_comment(msg.SCT_ERROR_HANDLING, msg_args('#RECURSION#', to_char(p_rule.sru_sort_seq), p_rule.sru_name, g_firing_item));
      end if;
    end if;

    if p_rule.js is not null then
      l_js_code := replace(p_rule.js, sct_const.c_cr, c_delimiter);
      -- Nicht in BULK_REPLACE integrieren wg. Limit 4000 Byte
      if instr(p_code, l_js_code) = 0 then
        p_code := p_code || replace(sct_const.c_js_template, '#CODE#', c_delimiter || l_js_code);
      else
        p_code := p_code || replace(sct_const.c_js_template, '#CODE#', c_delimiter || '// ' || l_js_code || ' (doppelt)');
      end if;
      utl_text.bulk_replace(p_code, char_table(
        '#JS_FILE#', sct_const.c_js_namespace,
        '#ITEM_VALUE#', sct_const.c_js_item_value_template,
        '#ITEM#', p_rule.item,
        '#SELECTOR#', case p_rule.item when sct_const.c_no_firing_item then analyze_parameter(p_code, '#SELECTOR#', p_rule.sra_attribute_2) else p_rule.item end,
        '#ATTRIBUTE#', p_rule.sra_attribute,
        '#ATTRIBUTE_2#', p_rule.sra_attribute_2));
    end if;
  end prepare_js_code;


  procedure initialize
  as
  begin
    g_with_comments := true;
  end initialize;


  /* INTERFACE */
  function get_firing_item
    return varchar2
  as
  begin
    return g_firing_item;
  end get_firing_item;


  function get_firing_items(
    p_spi_id in sct_page_item.spi_id%type,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type)
    return char_table
  as
    l_item_list char_table;
  begin
    case 
    when p_spi_id = sct_const.c_no_firing_item and trim(p_attribute_2) like '.%' then
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

    when p_spi_id = sct_const.c_no_firing_item and trim(p_attribute_2) like '#%' then
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


  function get_with_comments
    return boolean
  as
  begin
    return g_with_comments or wwv_flow.g_debug;
  end get_with_comments;


  procedure set_with_comments(
    p_with_comment in boolean)
  as
  begin
    g_with_comments := p_with_comment;
  end set_with_comments;  


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


  /* CREATE ACTION is called for every rule. Iterates over ACTION_CUR and calculate per rule action:
     - PL/SQL code to be executed immediately
     - JavaScript code to collect and send to page after processing
   */
  procedure create_action(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_firing_item in sct_page_item.spi_id%type,
    p_is_recursive in number,    
    p_firing_items out nocopy varchar2,
    p_js_action out nocopy varchar2) 
  as
    l_rule rule_rec;
    l_action_cur sys_refcursor;
    l_stmt varchar2(32767);
    l_js_code varchar2(32767);
    l_js_chunk varchar2(32767);
  begin
    pit.enter_mandatory(
      p_action => 'create_action',
      p_module => c_pkg,
      p_params => msg_params(
                    msg_param('p_sgr_id', to_char(p_sgr_id)),
                    msg_param('p_firing_item', p_firing_item)));

    -- Initialization
    g_firing_item := p_firing_item; -- make firing element accessible to SQL via getter method
    g_has_errors := false;

    -- prepare SQL rule
    l_stmt := utl_text.bulk_replace(sct_const.c_stmt_template, char_table(
                '#RULE_VIEW#', sct_const.c_view_name_prefix || p_sgr_id,
                '#IS_RECURSIVE#', p_is_recursive));
    pit.verbose(msg.allg_pass_information, msg_args('Rule SQL: ' || l_stmt));

    -- explicit cursor control because of dynamic SQL
    open l_action_cur for l_stmt;
    fetch l_action_cur into l_rule;  -- evaluates rule

    while l_action_cur%FOUND loop
      case when ((l_rule.sru_on_error = sct_const.c_false or not g_has_errors) 
            and l_rule.sra_on_error = sct_const.c_false) 
             or (l_rule.sra_on_error = sct_const.c_true and g_has_errors) then
             -- Normal execution. This is true in three possible cases:
             -- 1: No exception occurred
             -- 2: Rule set to ignore exceptions
             -- 3: Exception occurred and action is an exception handler
        -- calculate and execute PL/SQL code
        handle_pl_sql_code(l_rule);

        -- collect JavaScript code
        prepare_js_code(l_js_chunk, l_rule);
      else
        -- Execution rejected, because an exception occured and action is not an exception handler
        null;
      end case;
      
      -- get next action
      fetch l_action_cur into l_rule;
    end loop;

    close l_action_cur;

    -- Nicht in BULK_REPLACE integrieren wg. Limit 4000 Byte
    l_js_code := l_js_code || coalesce(l_js_chunk, get_comment(msg.SCT_NO_JAVASCRIPT, msg_args(p_firing_item, sct_const.c_cr)), '// ...');
    p_js_action := replace(sct_const.c_js_template, '#CODE#', l_js_code);

    utl_text.bulk_replace(p_js_action, char_table(
      '#SRU_SORT_SEQ#', case when l_rule.sru_sort_seq is not null then 'RULE_' || l_rule.sru_sort_seq else 'NO_RULE_FOUND' end,
      '#SRU_NAME#', l_rule.sru_name,
      '#FIRING_ITEM#', p_firing_item));

    -- Ermittle durch die Regel betroffene Seitenelemente als FIRING_ITEMS, falls keine Regel gilt, aktuelles Element waehlen
    p_firing_items := coalesce(l_rule.sru_firing_items, p_firing_item);
    pit.leave_mandatory;
  exception
    when msg.CONVERSION_IMPOSSIBLE_ERR or VALUE_ERROR or INVALID_NUMBER then
      close l_action_cur;
      pit.sql_exception;
    when others then
      close l_action_cur;
      pit.stop(msg.SQL_ERROR, msg_args(sqlerrm));
  end create_action;

begin
  initialize;
end bl_sct;
/
