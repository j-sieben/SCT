create or replace package body plugin_sct 
as
  
  /* Package-Konstanten */
  C_PKG constant varchar2(30 byte) := $$PLSQL_UNIT;
  C_PARAM_GROUP constant varchar2(30 byte) := 'SCT';

  type param_rec is record(
    sgr_name sct_rule_group.sgr_name%type,
    error_dependent_items varchar2(32767)
  );
  
  g_param param_rec;
    
  
  /* Hilfsprozedur zum Umkopieren der Attribute auf einen globalen Record
   * %param p_dynamic_action Uebergebene Attribute des Plugins
   * %usage Wird vor dem Rendern und Refresh aufgerufen, um an zentraler Stelle
   *        die APEX-Parameter auf lokale Variablen zu kopieren
   */
  procedure read_settings(
    p_dynamic_action in apex_plugin.t_dynamic_action)
  as
  begin
    g_param.sgr_name := upper(p_dynamic_action.attribute_01);
    g_param.error_dependent_items := upper(p_dynamic_action.attribute_02);
    bl_sct.set_comment_level(to_number(p_dynamic_action.attribute_03));
  end read_settings;
  
  
  /* Initialisierungscode */
  procedure initialize
  as
  begin
    null;
  end initialize;
  
  
  /* INTERFACE */
  procedure stop_rule
  as
  begin
    pit.enter_mandatory('stop_rule', C_PKG);
    bl_sct.set_stop_flag;
    pit.leave_mandatory;
  end stop_rule;
  
  
  procedure register_error(
    p_spi_id in varchar2,
    p_error_msg in varchar2)
  as
    l_error apex_error.t_error;  -- APEX-Fehler-Record
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, instr(sqlerrm, ':', 1) + 2);
  begin
    pit.enter_mandatory('register_error', C_PKG);

    l_error.message := p_error_msg;
    
    if l_error.message is not null then
      l_error.page_item_name := p_spi_id;
      l_error.additional_info := replace(dbms_utility.format_error_backtrace, chr(10), '<br/>');
    end if;
    bl_sct.register_error(l_error);
    
    pit.leave_mandatory;
  end register_error;
  
  
  procedure register_error(
    p_spi_id in varchar2,
    p_message in varchar2,
    p_msg_args in msg_args)
  as
    l_message message_type;
    l_error apex_error.t_error;  -- APEX-Fehler-Record
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, instr(sqlerrm, ':', 1) + 2);
  begin
    pit.enter_mandatory('register_error', c_pkg);
    l_message := message_type(
                   p_message_name => p_message,
                   p_message_language => null,
                   p_affected_id => p_spi_id,
                   p_session_id => v('SESSION'),
                   p_user_name => v('APP_USER'),
                   p_arg_list => p_msg_args);
    
    register_error(p_spi_id, l_message.message_text);
    pit.leave_mandatory;
  end register_error;
  
  
  function has_errors
    return boolean
  as
  begin
    return bl_sct.get_error_flag;
  end has_errors;
  
    
  function has_no_errors
    return boolean
  as
  begin
    return not bl_sct.get_error_flag;
  end has_no_errors;
  
  
  procedure register_notification(
    p_text in varchar2)
  as
  begin
    pit.enter_mandatory('register_notification', C_PKG);
    bl_sct.notify(p_text);
    pit.leave_mandatory;
  end register_notification;
  
  
  procedure register_notification(
    p_message in varchar2,
    p_msg_args in msg_args)
  as
  begin
    pit.enter_mandatory('register_notification', C_PKG);
    bl_sct.notify(p_message, p_msg_args);
    pit.leave_mandatory;
  end register_notification;
  
  
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null)
  as
  begin
    pit.enter_mandatory('register_mandatory', c_pkg);
    bl_sct.register_mandatory(
      p_spi_id => p_spi_id,
      p_spi_mandatory_message => p_spi_mandatory_message,
      p_is_mandatory => p_is_mandatory,
      p_attribute_2 => p_attribute_2);
    pit.leave_mandatory;
  end register_mandatory;


  procedure check_mandatory(
    p_firing_item in sct_page_item.spi_id%type)
  as
    l_message sct_page_item.spi_mandatory_message%type;
  begin
    pit.enter_mandatory('check_mandatory', C_PKG);
    bl_sct.check_mandatory(p_firing_item);
    pit.leave_mandatory;
  end check_mandatory;
  
  
  procedure submit_page
  as
  begin
    pit.enter_mandatory('submit_page', C_PKG);
    bl_sct.check_mandatory;
    pit.leave_mandatory;
  end submit_page;
  
  
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in number default sct_const.c_true,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null)
  as
    l_item_list char_table;
  begin
    pit.enter_mandatory('set_session_state', C_PKG);
    bl_sct.set_session_state(p_item, p_value, p_allow_recursion, p_attribute_2);
    pit.leave_mandatory;
  end set_session_state;
  
  
  procedure set_session_state_or_error(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_error in varchar2,
    p_allow_recursion in number default sct_const.c_true)
  as
  begin
    pit.enter_mandatory('set_session_state_or_error', C_PKG);
    
    if p_error is not null then
      register_error(p_item, p_error);
    else
      set_session_state(p_item, p_value, p_allow_recursion, null);
    end if;
    
    pit.leave_mandatory;
  end set_session_state_or_error;


  procedure set_value_from_stmt(
    p_item in sct_page_item.spi_id%type,
    p_stmt in varchar2)
  as
    c_stmt constant varchar2(200) := 'select to_char(value) from (#STMT#)';
    l_stmt varchar2(32767);
    l_result varchar2(4000);
  begin
    pit.enter_mandatory('set_value_from_stmt', C_PKG);
    
    l_stmt := replace(c_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_result;
    set_session_state(p_item, l_result, sct_const.c_true, null);
    
    pit.leave_mandatory;
  exception
    when others then
      register_notification(msg.SCT_NO_DATA_FOR_ITEM, msg_args(p_item));
      set_session_state(p_item, '', sct_const.c_true, null);
      pit.leave_mandatory;
  end set_value_from_stmt;
    
    
  procedure set_list_from_stmt(
    p_item in sct_page_item.spi_id%type,
    p_stmt in varchar2)
  as
    c_stmt constant varchar2(200) := q'~select listagg(value, ':') within group (order by value) from (#STMT#)~';
    l_stmt varchar2(32767);
    l_result varchar2(4000);
  begin
    pit.enter_mandatory('set_list_from_stmt', C_PKG);
    
    l_stmt := replace(c_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_result;
    set_session_state(p_item, l_result, sct_const.c_true, null);
    
    pit.leave_mandatory;
  end set_list_from_stmt;
  
  
  procedure execute_javascript(
    p_plsql in varchar2)
  as
    l_result varchar2(32767);
  begin
    bl_sct.execute_javascript(p_plsql);
  end execute_javascript;
  
  
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result
  as
    l_result apex_plugin.t_dynamic_action_render_result;
  begin
    pit.enter_mandatory('render', C_PKG);
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    -- Initialisierung
    read_settings(p_dynamic_action);
    
    -- Setze Umgebung fuer neuen SCT-Call
    bl_sct.initialize_call(
      p_sgr_name => g_param.sgr_name,
      p_firing_item => sct_const.c_no_firing_item,
      p_error_dependent_items => g_param.error_dependent_items);
    
    -- Ermittle Standardwerte fuer Seitenelemente
    bl_sct.process_initialization_code;
    
    -- Berechne Initialisierungscode
    l_result.javascript_function := sct_const.c_js_function;
    l_result.ajax_identifier := apex_plugin.get_ajax_identifier; 
    l_result.attribute_01 := bl_sct.get_bind_items;
    l_result.attribute_02 := bl_sct.get_page_items;
    l_result.attribute_03 := p_plugin.attribute_01;  -- JavaScript-UI-Library aus Komponentensettings
    l_result.attribute_04 := rawtohex(utl_raw.cast_to_raw(bl_sct.process_request));
    
    -- Aufraeumen
    bl_sct.terminate_call;
    
    pit.leave_mandatory;
    return l_result;
  end render;
  

  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result
  as
    l_result apex_plugin.t_dynamic_action_ajax_result;
  begin
    pit.enter_mandatory('ajax', C_PKG);
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    read_settings(p_dynamic_action);
    
    bl_sct.initialize_call(
      p_sgr_name => g_param.sgr_name,
      p_firing_item => apex_application.g_x01,
      p_error_dependent_items => g_param.error_dependent_items);
      
    -- Returniere Ergebnis der Regelpruefung
    pit.print(msg.SCT_CLOB_JS_SCRIPT, msg_args(bl_sct.process_request));
    
    bl_sct.terminate_call;
    
    pit.leave_mandatory;
    return l_result;
  end ajax;
  
begin
  initialize;
end plugin_sct;
/
