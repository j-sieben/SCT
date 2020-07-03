create or replace package body utl_sct 
as

  /* Helper methods */
  /** Method to retrieve a message text from a pit-method, if it is contained in P_MSG, and P_MSG otherwise
  */
  function get_msg(
    p_msg in varchar2)
  return varchar2
  as
    c_cmd_template varchar2(200) := 'begin :x := #COMMAND#; end;';
    s_cmd varchar2(32767);
    s_msg varchar2(32767);
  begin
    s_msg := p_msg;
    
    if instr(p_msg, 'pit.') <> 0 then
      s_cmd := replace(c_cmd_template, '#COMMAND#', replace(trim(p_msg), ';'));
      execute immediate s_cmd using out s_msg;
    end if;
    
    return s_msg;
  end get_msg;
  
  
  procedure clear_tip
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action('CLEAR_TIP');
    pit.leave_optional;
  end clear_tip;
  
  
  procedure close_modal_dialog(
    p_action in varchar2 default null,
    p_key in varchar2 default 'message',
    p_message in varchar2 default null)
  as
    C_JSON_PATTERN VARCHAR2(100) := q'^{"#KEY#":"#MESSAGE#"}^';
    l_action utl_apex.max_char;
  begin
    pit.enter_optional;
    case when p_action is not null then
      l_action := p_action;
    when p_message is not null then
      l_action := utl_text.bulk_replace(c_json_pattern, char_table(
                    '#KEY#', p_key,
                    '#MESSAGE#', p_message));
    else
      null;
    end case;
    sct_internal.execute_action(
      p_sat_id => 'CLOSE_MODAL_DIALOG', 
      p_param_1 => l_action);
    pit.leave_optional;
  end close_modal_dialog;
  
  
  procedure confirm_command(
    p_spi_id in varchar2,
    p_message in varchar2,
    p_command in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'CONFIRM_COMMAND',
      p_spi_id => p_spi_id,
      p_param_1 => p_message,
      p_param_2 => p_command);
    pit.leave_optional;
  end confirm_command;
  
  
  procedure disable_button(
    p_spi_id in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'DISABLE_BUTTON',
      p_spi_id => p_spi_id);
    pit.leave_optional;
  end disable_button;
  
  
  procedure disable_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'DISABLE_ITEM',
      p_spi_id => p_spi_id,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end disable_item;
  
  
  procedure dynamic_javascript(
    p_plsql_function in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'DYNAMIC_JAVASCRIPT',
      p_spi_id => C_DOCUMENT,
      p_param_1 => apex_escape.js_literal(p_plsql_function));
    pit.leave_optional;
  end dynamic_javascript;
  
  
  procedure empty_field(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'EMPTY_FIELD',
      p_spi_id => p_spi_id,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end empty_field;
  
  
  procedure enable_button(
    p_spi_id in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'ENABLE_BUTTON',
      p_spi_id => p_spi_id);
    pit.leave_optional;
  end enable_button;
  
  
  procedure enable_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'ENABLE_ITEM',
      p_spi_id => p_spi_id,
      p_param_1 => p_whole_row,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end enable_item;
  
  
  procedure hide_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'HIDE_ITEM',
      p_spi_id => p_spi_id,
      p_param_1 => p_whole_row,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end hide_item;
  
  
  procedure is_mandatory(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_msg_text in varchar2 default null,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'IS_MANDATORY',
      p_spi_id => p_spi_id,
      p_param_1 => p_msg_text,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end is_mandatory;
  
  
  procedure is_optional(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'IS_OPTIONAL',
      p_spi_id => p_spi_id,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end is_optional;
  
  
  procedure item_null_show(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'ITEM_NULL_SHOW',
      p_spi_id => p_spi_id,
      p_param_1 => p_whole_row,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end item_null_show;
  
  
  procedure java_script_code(
    p_js_code in varchar2)
  as
  begin
    pit.enter_optional;
    sct.add_javascript(p_js_code);
    pit.leave_optional;
  end java_script_code;
  
  
  procedure refresh_and_set_value(
    p_spi_id in varchar2,
    p_item_val in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'REFRESH_AND_SET_VALUE',
      p_spi_id => p_spi_id,
      p_param_1 => p_item_val);
    pit.leave_optional;
  end refresh_and_set_value;
  
  
  procedure refresh_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'REFRESH_ITEM',
      p_spi_id => p_spi_id,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end refresh_item;
  
  
  procedure log_console(
    p_log_msg in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SET_CONSOLE',
      p_spi_id => C_DOCUMENT,
      p_param_1 => p_log_msg);
    pit.leave_optional;
  end log_console;
  
  
  procedure set_focus(
    p_spi_id in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SET_FOCUS',
      p_spi_id => p_spi_id);
    pit.leave_optional;
  end set_focus;
  
  
  procedure set_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_item_value in varchar2,
    p_jquery_sel in varchar2 default null,
    p_raise_event in boolean default true)
  as
    C_APOS constant varchar2(1 byte) := '''';
    l_action sct_action_type.sat_id%TYPE;
    l_item_value utl_apex.max_char;
  begin
    pit.enter_optional;
    
    l_item_value := apex_escape.js_literal(p_item_value);
    if p_raise_event then
      l_action := 'SET_ITEM';
    else
      l_action := 'SET_VALUE_ONLY';
      l_item_value := trim(c_apos from l_item_value);
    end if;
    
    sct_internal.execute_action(
      p_sat_id => l_action,
      p_spi_id => p_spi_id,
      p_param_1 => p_item_value,
      p_param_2 => p_jquery_sel);
      
    pit.leave_optional;
  end set_item;
  
  
  procedure set_item_label(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_item_label in varchar2,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SET_ITEM_LABEL',
      p_spi_id => p_spi_id,
      p_param_1 => trim('''' from apex_escape.js_literal(p_item_label)),
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end set_item_label;
  
  
  procedure set_modal_dialog_title(
    p_title in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SET_MODAL_DIALOG_TITLE',
      p_spi_id => C_DOCUMENT,
      p_param_1 => p_title);
    pit.leave_optional;
  end set_modal_dialog_title;
  
  
  procedure set_null_disable(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SET_NULL_DISABLE',
      p_spi_id => p_spi_id,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end set_null_disable;
  
  
  procedure set_null_hide(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SET_NULL_HIDE',
      p_spi_id => p_spi_id,
      p_param_1 => p_whole_row,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end set_null_hide;
  
  
  procedure show_alert(
    p_spi_id_focus in varchar2,
    p_msg_text in varchar2,
    p_msg_type in varchar2 default C_NOTE)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SHOW_ALERT',
      p_spi_id => p_spi_id_focus,
      p_param_1 => p_msg_text,
      p_param_2 => p_msg_type);
    pit.leave_optional;
  end show_alert;
  
  
  procedure show_error(
    p_spi_id in varchar2,
    p_msg_text in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SHOW_ERROR',
      p_spi_id => p_spi_id,
      p_param_1 => p_msg_text);
    pit.leave_optional;
  end show_error;
  
  
  procedure show_hide_item(
    p_jquery_sel_show in varchar2,
    p_jquery_sel_hide in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'TOGGLE_ITEMS',
      p_spi_id => C_DOCUMENT,
      p_param_1 => p_jquery_sel_show,
      p_param_2 => p_jquery_sel_hide);
    pit.leave_optional;
  end show_hide_item;
  
  
  procedure show_hint(
    p_msg_text in varchar2,
    p_msg_type in varchar2 default C_NOTE)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SHOW_HINT',
      p_spi_id => C_DOCUMENT,
      p_param_1 => p_msg_text,
      p_param_2 => p_msg_type);
    pit.leave_optional;
  end show_hint;
  
  
  procedure show_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SHOW_ITEM',
      p_spi_id => p_spi_id,
      p_param_1 => p_whole_row,
      p_param_2 => p_jquery_sel);
    pit.leave_optional;
  end show_item;
  
  
  procedure show_message(
    p_spi_id_focus in varchar2,
    p_msg_text in varchar2,
    p_msg_type in varchar2 default C_NOTE)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'SHOW_MESSAGE',
      p_spi_id => p_spi_id_focus,
      p_param_1 => p_msg_text,
      p_param_2 => p_msg_type);
    pit.leave_optional;
  end show_message;
  
  
  procedure wait_for_refresh(
    p_region_sel in varchar2)
  as
  begin
    pit.enter_optional;
    sct_internal.execute_action(
      p_sat_id => 'WAIT_FOR_REFRESH',
      p_spi_id => p_region_sel);
    pit.leave_optional;
  end wait_for_refresh;
  

  procedure handle_bulk_errors(
    p_mapping in char_table default null) 
  as
    type error_code_map_t is table of utl_apex.ora_name_type index by utl_apex.ora_name_type;
    l_error_code_map error_code_map_t;
    l_message_list pit_message_table;
    l_message message_type;
    l_item utl_apex.item_rec;
  begin
    pit.enter_optional;
    l_message_list := pit.get_message_collection;
    
    if l_message_list.count > 0 then
      -- copy p_mapping to pl/sql table to allow for easy access using EXISTS method
      if p_mapping is not null then
        for i in 1 .. p_mapping.count loop
          if mod(i, 2) = 1 then
            l_error_code_map(p_mapping(i)) := p_mapping(i+1);
          end if;
        end loop;
      end if;
      
      for i in 1 .. l_message_list.count loop
        l_message := l_message_list(i);
        if l_message.severity in (pit.level_fatal, pit.level_error) then
          if l_error_code_map.exists(l_message.error_code) then
            utl_apex.get_page_element(l_error_code_map(l_message.error_code), l_item);
          end if;
          sct.register_error(
            p_spi_id => coalesce(l_item.item_name, sct_util.C_NO_FIRING_ITEM),
            p_error_msg => replace(l_message.message_text, '#LABEL#', l_item.item_label),
            p_internal_error => l_message.message_description);
        end if;
      end loop;
    end if;
    
    pit.leave_optional;
  end handle_bulk_errors;

end utl_sct;
/