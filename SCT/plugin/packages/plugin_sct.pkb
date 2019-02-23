create or replace package body plugin_sct 
as
  
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
  
  
  procedure execute_action(
    p_sat_id in sct_action_type.sat_id%type,
    p_spi_id in sct_page_item.spi_id%type,
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
  
    
  function get_event
    return varchar2
  as
    l_event varchar2(100);
  begin
    pit.enter_mandatory;
    
    l_event := sct_internal.get_event;
    
    pit.leave_mandatory(p_params => msg_params(msg_param('Result', l_event)));
    return l_event;
  end get_event;
  
  
  function get_firing_item
    return varchar2
  as
    l_firing_item sct_page_item.spi_id%type;
  begin
    pit.enter_mandatory;
    
    l_firing_item := sct_internal.get_firing_item;
    
    pit.leave_mandatory(p_params => msg_params(msg_param('Result', l_firing_item)));
    return l_firing_item;
  end get_firing_item;
  
  
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
    p_param_2 in sct_rule_action.sra_param_2%type default null)
  as
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_spi_id', p_spi_id),
                    msg_param('p_value', substr(p_value, 1, 4000)),
                    msg_param('p_param_2', substr(p_param_2, 1, 4000)),
                    msg_param('p_allow_recursion', to_char(p_allow_recursion))));
    
    sct_internal.set_session_state(p_spi_id, p_value, p_allow_recursion, p_param_2);
    
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
  
  
  procedure submit_page
  as
  begin
    pit.enter_mandatory;
    
    sct_internal.submit_page;
    
    pit.leave_mandatory;
  end submit_page;
  
  
  /* DEFAULT PLUGIN FUNCTIONALITY */
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result
  as
    C_JS_FUNCTION constant varchar2(50 byte) := 'de_condes_plugin_sct';
    l_result apex_plugin.t_dynamic_action_render_result;
    l_java_script sct_util.max_char;
  begin
    pit.enter_mandatory;
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    -- Initialize
    sct_internal.read_settings(
      p_firing_item => apex_application.g_x01,
      p_event => apex_application.g_x02,
      p_rule_group_name => p_dynamic_action.attribute_01,
      p_error_dependent_items => p_dynamic_action.attribute_02);
    
    -- Initialize session status with page item default values
    sct_internal.process_initialization_code;
    
    -- Process initialization rules of SCT for that page. Response is a JavaScript that is executed on the page
    l_java_script := sct_internal.process_request;
    
    -- Compose response
    l_result.javascript_function := C_JS_FUNCTION;
    l_result.ajax_identifier := apex_plugin.get_ajax_identifier; 
    l_result.attribute_01 := sct_internal.get_bind_items_as_json;
    l_result.attribute_02 := sct_internal.get_page_items;
    l_result.attribute_03 := p_plugin.attribute_01;
    l_result.attribute_04 := utl_raw.cast_to_raw(l_java_script);
    l_result.attribute_05 := sct_internal.register_observer;
    
    pit.leave_mandatory;
    return l_result;
  end render;
  

  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result
  as
    l_result apex_plugin.t_dynamic_action_ajax_result;
    l_java_script sct_util.max_char;
  begin
    pit.enter_mandatory;
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    -- Initialize
    sct_internal.read_settings(
      p_firing_item => apex_application.g_x01,
      p_event => apex_application.g_x02,
      p_rule_group_name => p_dynamic_action.attribute_01,
      p_error_dependent_items => p_dynamic_action.attribute_02);
    
    -- Process best matching rule of SCT for the actual page state. Response is a JavaScript that is executed on the page
    l_java_script := sct_internal.process_request;
    
    -- Return response
    htp.p(l_java_script);
    
    pit.leave_mandatory;
    return l_result;
  end ajax;
  
end plugin_sct;
/
