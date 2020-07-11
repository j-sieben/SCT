create or replace package body sct
as

  C_BUTTON constant sct_page_item_type.sit_id%type := 'BUTTON';
  
  /* Helper */
  /** Method to check whether a selector is a page item ID or a jQuery expression
   * %param  p_selector  Selector to check
   * %usage  Is used to distinguish a jQuery selector from an SPI_ID.
   */
  function get_item_type(
    p_selector in varchar2)
    return sct_page_item_type.sit_id%type
  as
    l_item_type sct_page_item_type.sit_id%type;
  begin
      with params as(
           select apex_application.g_flow_id app_id,
                  apex_application.g_flow_step_id page_id
             from dual)
    select /*+ no_merge (p) */ max(spi_sit_id)
      into l_item_type
      from sct_page_item
      join sct_rule_group
        on spi_sgr_id = sgr_id
      join params p
        on sgr_app_id = app_id
       and sgr_page_id = page_id
     where spi_id = p_selector;
    return l_item_type;
  end get_item_type;
  
    
  /** Method to directly execute a SCT action from PL/SQL
   * @param  p_sat_id   Reference to SCT_ACTION_TYPE, action to execute
   * @param [p_spi_id]  Page item or DOCUMENT, references the page item the action shall work with.
   *                    Defaults to SCT_UTIL:C_NO_FIRING_ITEM
   * @param [p_param_1] Optional first parameter
   * @param [p_param_2] Optional second parameter
   * @param [p_param_3] Optional third parameter
   * @usage  Is used to directly execute an SCT action in case logic needs to perfrom a wider variety of
   *         steps, fi when configuring a page. Executing the SCT actions directly helps reduce the need 
   *         to create many rules with rather similar conditions
   */
  procedure execute_action(
    p_sat_id in sct_action_type.sat_id%type,
    p_spi_id in sct_page_item.spi_id%type default sct_util.C_NO_FIRING_ITEM,
    p_param_1 in sct_rule_action.sra_param_1%type default null,
    p_param_2 in sct_rule_action.sra_param_2%type default null,
    p_param_3 in sct_rule_action.sra_param_3%type default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_sat_id', p_sat_id),
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_param_1', substr(p_param_1, 1, 4000)),
                    msg_param('p_param_2', substr(p_param_2, 1, 4000)),
                    msg_param('p_param_3', substr(p_param_3, 1, 4000))));
                    
    sct_internal.execute_action(
      p_sat_id => p_sat_id,
      p_spi_id => p_spi_id,
      p_param_1 => p_param_1,
      p_param_2 => p_param_2,
      p_param_3 => p_param_3);
      
    pit.leave_mandatory;
  end execute_action;
  
  $IF sct_util.C_WITH_UNIT_TESTS $THEN
  procedure set_test_mode(
    p_mode in boolean default false)
  as
  begin
    sct_internal.set_test_mode(p_mode);
  end set_test_mode;
  
  function get_test_mode
    return boolean
  as
  begin
    return sct_internal.get_test_mode;
  end get_test_mode;
  
  
  function get_test_result
    return ut_sct_result
  as
  begin
    return sct_internal.get_test_result;
  end get_test_result;
  $END
  
  
  /* CORE FUNCTIONALITY wrapper around SCT_INTERNAL */
  function get_pk
    return number
  as
  begin
    return sct_seq.nextval;
  end get_pk;
  
  
  function get_char(
    p_spi_id in sct_page_item.spi_id%type)
    return varchar2
  as
  begin
    return sct_internal.get_char(
             p_spi_id => p_spi_id);
  end get_char;


  function get_date(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in sct_util.flag_type default sct_util.C_TRUE)
    return date
  as
  begin
    return sct_internal.get_date(
             p_spi_id => p_spi_id,
             p_format_mask => p_format_mask,
             p_throw_error => p_throw_error);
  end get_date;
    
    
  function get_event
    return varchar2
  as
  begin
    return sct_internal.get_event;
  end get_event;


  function get_firing_item
    return varchar2
  as
  begin
    return sct_internal.get_firing_item;
  end get_firing_item;


  function get_number(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in sct_util.flag_type default sct_util.c_false)
    return number
  as
  begin
    return sct_internal.get_number(
             p_spi_id => p_spi_id,
             p_format_mask => p_format_mask,
             p_throw_error => p_throw_error);
  end get_number;
  
  
  /* ADDITIONAL SCT FUNCTIONALITY */
  procedure add_javascript(
    p_javascript in varchar2)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_javascript', substr(p_javascript, 1, 4000))));

    sct_internal.add_javascript(p_javascript);

    pit.leave_mandatory;
  end add_javascript;


  procedure check_date(
    p_spi_id in sct_page_item.spi_id%type)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_spi_id', p_spi_id)));

    sct_internal.check_date(p_spi_id);

    pit.leave_mandatory;
  end check_date;


  procedure check_mandatory(
    p_spi_id in sct_page_item.spi_id%type)
  as
    l_push_item sct_page_item.spi_id%type;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_spi_id', p_spi_id)));

    sct_internal.check_mandatory(
      p_spi_id => p_spi_id,
      p_push_item => l_push_item);

    sct_internal.push_firing_item(l_push_item);

    pit.leave_mandatory;
  end check_mandatory;


  procedure check_number(
    p_spi_id in sct_page_item.spi_id%type)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_spi_id', p_spi_id)));

    sct_internal.check_number(p_spi_id);

    pit.leave_mandatory;
  end check_number;


  procedure exclusive_or(
    p_spi_id in sct_page_item.spi_id%type,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED,
    p_error_on_null in boolean default false)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_value_list', p_value_list),
                    msg_param('p_message', p_message)));

    sct_internal.exclusive_or(p_spi_id, p_value_list, p_message, p_error_on_null);

    pit.leave_mandatory;
  end exclusive_or;


  function exclusive_or(
    p_value_list in varchar2)
    return number
  as
    l_result binary_integer;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_value_list', p_value_list)));

    l_result :=  sct_internal.exclusive_or(p_value_list);

    pit.leave_mandatory(p_params => msg_params(msg_param('Result', to_char(l_result))));
    return l_result;
  end exclusive_or;
  

  procedure execute_javascript(
    p_plsql in varchar2)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_plsql', substr(p_plsql, 1, 4000))));

    sct_internal.execute_javascript(p_plsql);

    pit.leave_mandatory;
  end execute_javascript;


  procedure execute_plsql(
    p_plsql in varchar2)
  as
    C_CMD_TEMPLATE constant varchar2(100) := 'begin #CMD# end;';
    l_plsql varchar2(32767);
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_cmd', substr(p_plsql, 1, 4000))));

    l_plsql := rtrim(p_plsql, ';') || ';';
    execute immediate replace(C_CMD_TEMPLATE, '#CMD#', l_plsql);

    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SCT_UNHANDLED_EXCEPTION, msg_args(l_plsql));
      sct_internal.register_error(sct_util.C_NO_FIRING_ITEM, msg.SCT_UNHANDLED_EXCEPTION, msg_args(apex_escape.json(l_plsql)));
      -- surpress recursion
      sct_internal.stop_rule;
  end execute_plsql;


  function has_errors
    return boolean
  as
    l_bool boolean;
  begin
    pit.enter_mandatory;

    l_bool := sct_internal.get_error_flag;

    pit.leave_mandatory(p_params => msg_params(msg_param('Result', sct_util.bool_to_flag(l_bool))));
    return l_bool;
  end has_errors;


  function has_no_errors
    return boolean
  as
  begin
    return not has_errors;
  end has_no_errors;


  procedure not_null(
    p_spi_id in sct_page_item.spi_id%type,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_value_list', p_value_list),
                    msg_param('p_message', p_message)));

    sct_internal.not_null(p_spi_id, p_value_list, p_message);

    pit.leave_mandatory;
  end not_null;


  function not_null(
    p_value_list in varchar2)
    return number
  as
    l_result binary_integer;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_value_list', p_value_list)));

    l_result :=  sct_internal.not_null(p_value_list);

    pit.leave_mandatory(p_params => msg_params(msg_param('Result', to_char(l_result))));
    return l_result;
  end not_null;


  procedure notify(
    p_message in varchar2)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_message', substr(p_message, 1, 4000))));

    sct_internal.notify(p_message);

    pit.leave_mandatory;
  end notify;


  procedure register_error(
    p_spi_id in sct_page_item.spi_id%type,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null)
  as
    l_error apex_error.t_error;
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_error_msg', substr(p_error_msg, 1, 4000)),
                    msg_param('p_internal_error', substr(p_internal_error, 1, 4000))));

    sct_internal.push_firing_item(p_spi_id);
    l_error.message := p_error_msg;

    if l_error.message is not null then
      l_error.page_item_name := p_spi_id;
      l_error.additional_info := apex_escape.json(p_internal_error || pit_util.get_call_stack);
      sct_internal.push_error(l_error);
    end if;

    pit.leave_mandatory;
  end register_error;


  procedure register_error(
    p_spi_id in sct_page_item.spi_id%type,
    p_message_name in varchar2,
    p_arg_list in msg_args default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_message_name', p_message_name)));

    sct_internal.register_error(p_spi_id, p_message_name, p_arg_list);

    pit.leave_mandatory;
  end register_error;


  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in sct_page_item.spi_mandatory_message%type,
    p_is_mandatory in boolean,
    p_param_2 in sct_rule_action.sra_param_2%type default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_spi_mandatory_message', substr(p_spi_mandatory_message, 1, 4000)),
                    msg_param('p_is_mandatory', sct_util.bool_to_flag(p_is_mandatory)),
                    msg_param('p_param_2', substr(p_param_2, 1, 4000))));

    sct_internal.register_mandatory(
      p_spi_id => p_spi_id,
      p_spi_mandatory_message => p_spi_mandatory_message,
      p_is_mandatory => p_is_mandatory,
      p_param_2 => p_param_2);

    pit.leave_mandatory;
  end register_mandatory;


  procedure register_notification(
    p_text in varchar2)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_text', substr(p_text, 1, 4000))));

    sct_internal.register_notification(p_text);

    pit.leave_mandatory;
  end register_notification;


  procedure register_notification(
    p_message_name in varchar2,
    p_arg_list in msg_args)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_message_name', p_message_name)));

    sct_internal.register_notification(p_message_name, p_arg_list);

    pit.leave_mandatory;
  end register_notification;


  procedure set_list_from_stmt(
    p_spi_id in sct_page_item.spi_id%type,
    p_stmt in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_stmt', substr(p_stmt, 1, 4000))));

    sct_internal.set_list_from_stmt(
      p_spi_id => p_spi_id,
      p_stmt => p_stmt);

    pit.leave_mandatory;
  end set_list_from_stmt;


  procedure set_session_state(
    p_spi_id in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in sct_util.flag_type default sct_util.C_TRUE,
    p_selector in sct_rule_action.sra_param_1%type default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_value', substr(p_value, 1, 4000)),
                    msg_param('p_param_2', substr(p_selector, 1, 4000)),
                    msg_param('p_allow_recursion', to_char(p_allow_recursion))));

    sct_internal.set_session_state(p_spi_id, p_value, p_allow_recursion, p_selector);

    pit.leave_mandatory;
  end set_session_state;


  procedure set_session_state_or_error(
    p_spi_id in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_error in varchar2,
    p_allow_recursion in sct_util.flag_type default sct_util.C_TRUE)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_value', substr(p_value, 1, 4000)),
                    msg_param('p_error', substr(p_error, 1, 4000)),
                    msg_param('p_allow_recursion', to_char(p_allow_recursion))));

    if p_error is not null then
      register_error(p_spi_id, p_error, '');
    else
      set_session_state(p_spi_id, p_value, p_allow_recursion, null);
    end if;

    pit.leave_mandatory;
  end set_session_state_or_error;


  procedure set_value_from_stmt(
    p_spi_id in sct_page_item.spi_id%type,
    p_stmt in varchar2)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_stmt', substr(p_stmt, 1, 4000))));

    sct_internal.set_value_from_stmt(
      p_spi_id => p_spi_id,
      p_stmt => p_stmt);

    pit.leave_mandatory;
  end set_value_from_stmt;


  procedure stop_rule
  as
  begin
    pit.enter_mandatory;

    sct_internal.stop_rule;

    pit.leave_mandatory;
  end stop_rule;


  procedure validate_page
  as
  begin
    pit.enter_mandatory;

    sct_internal.validate_page;

    pit.leave_mandatory;
  end validate_page;
  

  /* Convenience wrapper around SCT_INTERNAL */
  procedure toggle_item_mandatory(
    p_selector in varchar2,
    p_mandatory in boolean default true)
  as
    l_spi_id sct_page_item.spi_id%type;
    l_selector sct_util.max_char;
  begin
    if get_item_type(p_selector) is not null then
      l_spi_id := p_selector;
    else
      l_spi_id := sct_util.C_NO_FIRING_ITEM;
      l_selector := p_selector;
    end if;
    
    if p_mandatory then
      sct.execute_action(
        p_sat_id => 'IS_MANDATORY', 
        p_spi_id => l_spi_id, 
        p_param_2 => l_selector);
    else
      sct.execute_action(
        p_sat_id => 'IS_OPTIONAL', 
        p_spi_id => l_spi_id, 
        p_param_2 => l_selector);
    end if;
    
  end toggle_item_mandatory;
  
  
  procedure toggle_item_status(
    p_selector in varchar2,
    p_enabled in boolean default true,
    p_set_null in boolean default false)
  as
    l_spi_id sct_page_item.spi_id%type;
    l_selector sct_util.max_char;
    l_item_type sct_page_item_type.sit_id%type;
    l_is_button boolean;
  begin
    l_item_type := get_item_type(p_selector);
    if l_item_type is not null then
      l_spi_id := p_selector;
      l_is_button := l_item_type = C_BUTTON;
    else
      l_spi_id := sct_util.C_NO_FIRING_ITEM;
      l_selector := p_selector;
    end if;
    
    case
    when p_enabled then
      -- Only one common method to show items
      sct.execute_action(
        p_sat_id => 'ENABLE_ITEM', 
        p_spi_id => l_spi_id, 
        p_param_2 => l_selector);
    when l_is_button then
      -- disable button
      sct.execute_action(
        p_sat_id => 'DISABLE_BUTTON', 
        p_spi_id => l_spi_id);
    when p_set_null then
      -- disable and set null
      sct.execute_action(
        p_sat_id => 'SET_NULL_DISABLE', 
        p_spi_id => l_spi_id, 
        p_param_2 => l_selector);
    else
      -- simply disable a page item
      sct.execute_action(
        p_sat_id => 'DISABLE_ITEM', 
        p_spi_id => l_spi_id, 
        p_param_2 => l_selector);
    end case;
  end toggle_item_status;
    
    
  procedure toggle_item_visibility(
    p_selector in varchar2,
    p_visible in boolean default true,
    p_set_null in boolean default false)
  as
    l_spi_id sct_page_item.spi_id%type;
    l_selector sct_util.max_char;
  begin
    if get_item_type(p_selector) is not null then
      l_spi_id := p_selector;
    else
      l_spi_id := sct_util.C_NO_FIRING_ITEM;
      l_selector := p_selector;
    end if;
    
    case
    when p_visible then
      -- Only one common method to show items
      execute_action(
        p_sat_id => 'SHOW_ITEM', 
        p_spi_id => l_spi_id,
        p_param_2 => l_selector);
    when p_set_null then
      -- hide and set null
      execute_action(
        p_sat_id => 'SET_NULL_HIDE', 
        p_spi_id => l_spi_id, 
        p_param_2 => l_selector);
    else
      -- simply hide a page item
      execute_action(
        p_sat_id => 'HIDE_ITEM', 
        p_spi_id => l_spi_id, 
        p_param_2 => l_selector);
    end case;
  end toggle_item_visibility;
  
  
  procedure toggle_item_visibility(
    p_selector in varchar2,
    p_items_to_show in varchar2)
  as
  begin
    execute_action(
      p_sat_id => 'TOGGLE_ITEMS', 
      p_param_1 => p_items_to_show, 
      p_param_2 => p_selector);
  end toggle_item_visibility;
  
    
  procedure refresh_item(
    p_spi_id in sct_page_item.spi_id%type,
    p_set_value in varchar2 default null)
  as
  begin
    if p_set_value is not null then
      execute_action(
        p_sat_id => 'REFRESH_AND_SET_VALUE', 
        p_spi_id => p_spi_id,
        p_param_1 => p_set_value);
    else
      execute_action(
        p_sat_id => 'REFRESH_ITEM', 
        p_spi_id => p_spi_id);
    end if;
  end refresh_item;
  
    
  procedure set_item(
    p_spi_id in sct_page_item.spi_id%type,
    p_value in varchar2 default null)
  as
  begin
    execute_action(
      p_sat_id => 'SET_ITEM', 
      p_spi_id => p_spi_id, 
      p_param_1 => p_value);
  end set_item;
  
    
  procedure set_focus(
    p_spi_id in sct_page_item.spi_id%type)
  as
  begin
    execute_action(
      p_sat_id => 'SET_FOCUS', 
      p_spi_id => p_spi_id);
  end set_focus;
  
    
  procedure execute_apex_action(
    p_action_name in sct_apex_action.saa_id%type)
  as
  begin
    execute_action(
      p_sat_id => 'EXECUTE_APEX_ACTION', 
      p_param_1 => p_action_name);
  end execute_apex_action;
    
    
  procedure execute_java_script(
    p_java_script in varchar2)
  as
  begin
    execute_action(
      p_sat_id => 'JAVA_SCRIPT_CODE', 
      p_param_1 => rtrim(p_java_script, ';'));
  end execute_java_script;
  
    
  procedure write_to_console(
    p_what in varchar2)
  as
  begin
    execute_action(
      p_sat_id => 'SET_CONSOLE', 
      p_param_1 => p_what);
  end write_to_console;
  
end sct;
/