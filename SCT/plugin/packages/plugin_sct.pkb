create or replace package body plugin_sct 
as
  
  /* Package-Konstanten */
  C_PKG constant varchar2(30 byte) := $$PLSQL_UNIT;
  
  C_JS_FUNCTION constant varchar2(50 byte) := 'de_condes_plugin_sct';
  
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
    bl_sct.stop_rule;
  end stop_rule;
  
  
  procedure register_item(
    p_item in varchar2,
    p_allow_recursion in number default sct_admin.C_TRUE)
  as
  begin
    bl_sct.register_item(p_item, p_allow_recursion);
  end register_item;
  
  
  procedure register_error(
    p_spi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null)
  as
    l_error apex_error.t_error;  -- APEX-Fehler-Record
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, instr(sqlerrm, ':', 1) + 2);
  begin
    pit.enter_mandatory('register_error', c_pkg);
    bl_sct.push_firing_item(p_spi_id);
    l_error.message := p_error_msg;
    
    if l_error.message is not null then
      l_error.page_item_name := p_spi_id;
      l_error.additional_info := p_internal_error || replace(dbms_utility.format_error_backtrace, chr(10), '<br/>');
      bl_sct.push_error(l_error);
    end if;
    
    pit.leave_mandatory;
  end register_error;
  
  
  procedure register_error(
    p_spi_id in varchar2,
    p_message_name in varchar2,
    p_arg_list in msg_args default null)
  as
    l_message message_type;
    l_error apex_error.t_error;  -- APEX-Fehler-Record
  begin
    pit.enter_mandatory('register_error', C_PKG);
    
    bl_sct.register_error(p_spi_id, p_message_name, p_arg_list);
    
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
    
    bl_sct.register_notification(p_text);
    
    pit.leave_mandatory;
  end register_notification;
  
  
  procedure register_notification(
    p_message_name in varchar2,
    p_arg_list in msg_args)
  as
  begin
    pit.enter_mandatory('register_notification', C_PKG);
    
    bl_sct.register_notification(p_message_name, p_arg_list);
    
    pit.leave_mandatory;
  end register_notification;
  
  
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null)
  as
  begin
    pit.enter_mandatory('register_mandatory', C_PKG);
    
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
    l_push_item sct_page_item.spi_id%type;
  begin
    pit.enter_mandatory('check_mandatory', C_PKG);
    
    bl_sct.check_mandatory(
      p_firing_item => p_firing_item,
      p_push_item => l_push_item);
    
    bl_sct.push_firing_item(l_push_item);
    
    pit.leave_mandatory;
  end check_mandatory;
  
  
  function get_char(
    p_spi_id in varchar2)
    return varchar2
  as
  begin
    return bl_sct.get_char(p_spi_id);
  end get_char;
  
  
  function get_number(
    p_spi_id in varchar2,
    p_format_mask in varchar2,
    p_throw_error in boolean default false)
    return number
  as
  begin
    return bl_sct.get_number(p_spi_id, p_format_mask, p_throw_error);
  exception
    when others then
      bl_sct.register_error(p_spi_id, sqlerrm, '');
      return null;
  end get_number;
  
  
  procedure check_number(
    p_spi_id in varchar2)
  as
  begin
    bl_sct.check_number(p_spi_id);
  end check_number;
  
  
  function get_date(
    p_spi_id in varchar2,
    p_format_mask in varchar2,
    p_throw_error in boolean default false)
    return date
  as
  begin
    return bl_sct.get_date(p_spi_id, p_format_mask, p_throw_error);
  exception
    when others then
      bl_sct.register_error(p_spi_id, sqlerrm, '');
      return null;
  end get_date;
  
  
  procedure check_date(
    p_spi_id in varchar2)
  as
  begin
    bl_sct.check_date(p_spi_id);
  end check_date;
    
  
  procedure submit_page
  as
  begin
    pit.enter_mandatory('submit_page', C_PKG);
    
    bl_sct.submit_page;
    
    pit.leave_mandatory;
  end submit_page;
  
  
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in number default sct_admin.C_TRUE,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null)
  as
  begin
    pit.enter_mandatory('set_session_state', C_PKG);
    
    bl_sct.set_session_state(p_item, p_value, p_allow_recursion, p_attribute_2);
    
    pit.leave_mandatory;
  end set_session_state;
  
  /* Ueberladungen fuer DATE und NUMBER */
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in date,
    p_allow_recursion in number default sct_admin.C_TRUE,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null)
  as
    l_item_list char_table;
  begin
    set_session_state(p_item, to_char(p_value), p_allow_recursion, p_attribute_2);
  end set_session_state;
  
    
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in number,
    p_allow_recursion in number default sct_admin.C_TRUE,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null)
  as
    l_item_list char_table;
  begin
    set_session_state(p_item, to_char(p_value), p_allow_recursion, p_attribute_2);
  end set_session_state;
  
  
  procedure set_session_state_or_error(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_error in varchar2,
    p_allow_recursion in number default sct_admin.C_TRUE)
  as
  begin
    pit.enter_mandatory('set_session_state_or_error', C_PKG);
    
    if p_error is not null then
      register_error(p_item, p_error, '');
    else
      set_session_state(p_item, p_value, p_allow_recursion, null);
    end if;
    
    pit.leave_mandatory;
  end set_session_state_or_error;


  procedure set_value_from_stmt(
    p_item in sct_page_item.spi_id%type,
    p_stmt in varchar2)
  as
    c_stmt constant varchar2(200) := 'select * from (#STMT#) where rownum = 1';
    l_stmt varchar2(32767);
    l_result varchar2(4000);
    l_cur integer;
    l_cnt integer;
    l_col_cnt integer;
    l_desc_tab DBMS_SQL.DESC_TAB2;
  begin
    pit.enter_mandatory('set_value_from_stmt', C_PKG);
    
    l_stmt := replace(c_stmt, '#STMT#', p_stmt);
    
    if p_item = sct_admin.c_no_firing_item or p_item is null then
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
        dbms_output.put_line('Setze Element ' ||l_desc_tab(i).col_name || ': ' || l_result);
        -- Wert in Sessionstatus kopieren
        set_session_state(l_desc_tab(i).col_name, l_result);
      end loop;
      dbms_sql.close_cursor(l_cur);
    else
      -- Konkretes Element angefordert, laut Konvention ist nur eine Spalte enthalten
      execute immediate l_stmt into l_result;
      set_session_state(p_item, l_result, sct_admin.C_TRUE, null);
    end if;
    
    pit.leave_mandatory;
  exception
    when others then
      register_notification(msg.SCT_NO_DATA_FOR_ITEM, msg_args(p_item));
      set_session_state(p_item, '', sct_admin.C_TRUE, null);
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
    set_session_state(p_item, l_result, sct_admin.C_TRUE, null);
    
    pit.leave_mandatory;
  end set_list_from_stmt;
  
  
  procedure notify(
    p_message in varchar2)
  as
  begin
    bl_sct.notify(p_message);
  end notify;
  
  
  procedure execute_javascript(
    p_plsql in varchar2)
  as
  begin
    bl_sct.execute_javascript(p_plsql);
  end execute_javascript;
  
  
  procedure xor(
    p_item in varchar2,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED,
    p_error_on_null in boolean default false)
  as
  begin
    bl_sct.xor(p_item, p_value_list, p_message, p_error_on_null);
  end xor;
    
    
  function xor(
    p_value_list in varchar2)
    return number
  as
  begin
    return bl_sct.xor(p_value_list);
  end xor;
    
    
  procedure not_null(
    p_item in varchar2,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED)
  as
  begin
    bl_sct.not_null(p_item, p_value_list, p_message);
  end not_null;
    
    
  function not_null(
    p_value_list in varchar2)
    return number
  as
  begin
    return bl_sct.not_null(p_value_list);
  end not_null;
  
  
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result
  as
    l_result apex_plugin.t_dynamic_action_render_result;
    l_hsec binary_integer := dbms_utility.get_time;
    l_js varchar2(32767);
    l_item_list char_table;
  begin
    pit.enter_mandatory('render', C_PKG);
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    -- Initialisieren
    bl_sct.read_settings(
      p_firing_item => apex_application.g_x01,
      p_with_comments => p_plugin.attribute_02,
      p_rule_group_name => p_dynamic_action.attribute_01,
      p_error_dependent_buttons => p_dynamic_action.attribute_02);
    
    l_result.javascript_function := C_JS_FUNCTION;
    l_result.ajax_identifier := apex_plugin.get_ajax_identifier; 
    
    bl_sct.process_initialization_code;
    
    l_js := bl_sct.process_request;
    
    l_result.attribute_01 := bl_sct.get_json_from_bind_items;
    l_result.attribute_02 := bl_sct.join_list(bl_sct.c_page_items);
    l_result.attribute_03 := p_plugin.attribute_01;
    l_result.attribute_04 := utl_raw.cast_to_raw(l_js);
    l_result.attribute_05 := bl_sct.register_observer;
    
    pit.leave_mandatory;
    return l_result;
  end render;
  

  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result
  as
    l_result apex_plugin.t_dynamic_action_ajax_result;
    l_hsec binary_integer := dbms_utility.get_time;
    l_js varchar2(32767);
  begin
    pit.enter_mandatory('ajax', c_pkg);
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    -- Initialisieren
    bl_sct.read_settings(
      p_firing_item => apex_application.g_x01,
      p_with_comments => p_plugin.attribute_02,
      p_rule_group_name => p_dynamic_action.attribute_01,
      p_error_dependent_buttons => p_dynamic_action.attribute_02);
    
    -- Returniere Ergebnis der Regelpruefung
    l_js := bl_sct.process_request;
    
    htp.p(l_js);
    
    pit.leave_mandatory;
    return l_result;
  end ajax;
  
begin
  initialize;
end plugin_sct;
/
