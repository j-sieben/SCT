create or replace package body sct_test 
as

  c_apex_page constant number := 1;
  c_apex_user constant utl_apex.ora_name_type := $$PLSQL_UNIT_OWNER;
  C_BASE_SGR constant utl_apex.ora_name_type := 'SCT_ADMIN_SGR';
  g_sgr_id sct_rule_group.sgr_id%type;
  g_application_id number := 120;
  
  g_da_type apex_plugin.t_dynamic_action;
  g_plugin_type apex_plugin.t_plugin;
  g_render_result apex_plugin.t_dynamic_action_render_result;
  g_ajax_result apex_plugin.t_dynamic_action_ajax_result;
  g_test_name varchar2(128 byte);
  g_test_run number;
  

  procedure get_session(
    p_page_id in number default c_apex_page)
  as
  begin
    rollback;
    if apex_application.g_instance is null then
      apex_session.create_session(
         p_app_id => g_application_id,
         p_page_id => p_page_id,
         p_username => c_apex_user);
    end if;
    apex_application.g_flow_step_id := p_page_id;
    commit;
  end get_session;


  procedure drop_session
  as
  begin
    rollback;
    if apex_application.g_instance is not null then
      apex_session.delete_session;
    end if;
    commit;
  end drop_session;
  

  /** Method to control the plugin environment of SCT. Sets apex_plugin.t_dynamic_action and apex_plugin.t_plugin instances
   * @param  
   * @usage  Is used to set the call environment for the plugin to enable tests. Is used along with the session state
   */
  procedure set_environment(
    p_rule_group_name in varchar2,
    p_firing_item in varchar2,
    p_event in varchar2,
    p_error_dependent_items in varchar2 default null)
  as
    
  begin
    g_da_type.attribute_01 := p_rule_group_name;
    apex_application.g_x01 := p_firing_item;
    apex_application.g_x02 := p_event;
    g_da_type.attribute_02 := p_error_dependent_items;
  end set_environment;
  
  
  function get_test_run
    return number
  as
  begin
    g_test_run := g_test_run + 100;
    return g_test_run;
  end get_test_run;
  
  procedure initialize
  as
  begin
    select application_id
      into g_application_id
      from apex_applications
     where alias = 'SCT';
     
    select sgr_id
      into g_sgr_id
      from sct_rule_group
     where sgr_name = C_BASE_SGR;
     
  end initialize;


  procedure tear_up
  as
    pragma autonomous_transaction;
  begin
    delete sct_test_outcome;
    commit;
    g_test_run := 0;
    pit.initialize;
    utl_test_apex.init_owa;
    sct.set_test_mode(true);
    pit.set_context(70, 30, true, 'PIT_CONSOLE');
    get_session;
    null;
  end tear_up;
  
  
  procedure persist_outcome
  as
    l_run number := get_test_run;
  begin
    insert into sct_test_outcome(test_name, sort_seq, sru_id, sru_sort_seq, sru_name, sru_firing_items, sru_fire_on_page_load, 
             item, pl_sql, js, sra_sort_seq, sra_param_1, sra_param_2, sra_param_3, sra_on_error, sru_on_error, is_first_row, 
             id, sgr_id, firing_item, firing_event, error_dependent_items, bind_items, page_items, firing_items, error_stack, 
             recursive_stack, js_action_stack, is_recursive, level_length, allow_recursion, notification_stack, stop_flag, now)
          with data as(
           select sct.get_test_result result
             from dual)
    select g_test_name test_name, l_run + rownum sort_seq, 
           sru_id, sru_sort_seq, sru_name, sru_firing_items, sru_fire_on_page_load, item, pl_sql, js, sra_sort_seq, sra_param_1, sra_param_2, sra_param_3,
           sra_on_error, sru_on_error, is_first_row, id, sgr_id, firing_item, firing_event, error_dependent_items, 
           utl_text.table_to_string(bind_items, chr(10)) bind_items, 
           utl_text.table_to_string(page_items, chr(10)) page_items, 
           utl_text.table_to_string(firing_items, chr(10)) firing_items, 
           utl_text.table_to_string(error_stack, chr(10)) error_stack, 
           utl_text.table_to_string(recursive_stack, chr(10)) recursive_stack,
           (select listagg (rtrim(rtrim(script, chr(13)), chr(10)), chr(10)) within group (order by rownum) script
              from table(x.js_action_stack)) js_action_stack,
           is_recursive, 
           utl_text.table_to_string(level_length, ', ') level_length,
           allow_recursion, notification_stack, stop_flag, now
      from data d
     cross join table(d.result.rule_list) x;
    commit;
  end persist_outcome;
  
  
  --
  -- test get_char case 1: Checks whether the initialization of page 1 returns 3 well known firing items
  --
  procedure render_plugin
  as
  begin
    g_test_name := 'render_plugin';
    get_session;
    set_environment(C_BASE_SGR, 'DOCUMENT', 'INITIALIZE');
    
    g_render_result := plugin_sct.render(g_da_type, g_plugin_type);
    
    ut.expect(g_render_result.attribute_02).to_equal('P1_SGR_APP_ID,P1_SGR_ID,P1_SGR_PAGE_ID');
    drop_session;
  end render_plugin;
  
  
  --
  -- test get_char case 1: Checks whether setting P1_SGR_ID to 1 leads to 1 executed rule with 2 actions
  --
  procedure refresh_plugin
  as
    l_action_count binary_integer;
    l_rule_count binary_integer;
    l_result sct_test_result;
  begin
    -- populate actual
    g_test_name := 'refresh_plugin';
    get_session;
    utl_apex.set_value('P1_SGR_ID', g_sgr_id);
    set_environment(C_BASE_SGR, 'P1_SGR_ID', 'change');
    
    g_ajax_result := plugin_sct.ajax(g_da_type, g_plugin_type);
    l_result := sct.get_test_result;
    
    -- populate expected
    select count(*), count(distinct sru_id)
      into l_action_count, l_rule_count
      from table(l_result.rule_list);
      
    -- assert
    ut.expect(l_action_count).to_equal(2);
    ut.expect(l_rule_count).to_equal(1);
    
    drop_session;
  end refresh_plugin;

  --
  -- test get_char case 1: Checks whether a page is able to pass back the string value
  --
  procedure get_char is
  begin
    g_test_name := 'get_char';
    get_session;
    utl_apex.set_value('P1_SGR_ID', g_sgr_id);
    set_environment(C_BASE_SGR, 'P1_SGR_ID', 'change');    
    g_ajax_result := plugin_sct.ajax(g_da_type, g_plugin_type);
    
    ut.expect(sct.get_char('P1_SGR_ID')).to_equal(to_char(g_sgr_id));
    drop_session;
  end get_char;

  --
  -- test get_char case 1: Checks whether a page is able to pass back a default value on NULL
  --
  procedure get_char_default is
  begin
    g_test_name := 'get_char';
    get_session;
    set_environment('SCT_EDIT_SRU', 'DOCUMENT', 'INITIALIZE');    
    g_ajax_result := plugin_sct.ajax(g_da_type, g_plugin_type);
    ut.expect(sct.get_char('P5_SRU_ACTIVE')).to_equal(sct_util.C_TRUE);
    drop_session;
  end get_char_default;

  --
  -- test get_date case 1: ...
  --
  procedure get_date is
  begin
    g_test_name := 'get_date';
    get_session;
    set_environment('SCT_EDIT_SRU', 'DOCUMENT', 'INITIALIZE');    
    g_ajax_result := plugin_sct.ajax(g_da_type, g_plugin_type);
    --ut.expect(sct.get_date('P5_SRU_ACTIVE')).to_equal(sct_util.C_TRUE);
    drop_session;
  end get_date;

  --
  -- test get_event case 1: ...
  --
  procedure get_event is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'get_event';
    -- populate actual
    -- sct.get_event;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_event;

  --
  -- test get_firing_item case 1: ...
  --
  procedure get_firing_item is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'get_firing_item';
    -- populate actual
    -- sct.get_firing_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_firing_item;

  --
  -- test get_number case 1: ...
  --
  procedure get_number is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'get_number';
    -- populate actual
    -- sct.get_number;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end get_number;

  --
  -- test add_javascript case 1: ...
  --
  procedure add_javascript is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'add_javascript';
    -- populate actual
    -- sct.add_javascript;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end add_javascript;

  --
  -- test check_date case 1: ...
  --
  procedure check_date is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'check_date';
    -- populate actual
    -- sct.check_date;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end check_date;

  --
  -- test check_mandatory case 1: ...
  --
  procedure check_mandatory is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'check_mandatory';
    -- populate actual
    -- sct.check_mandatory;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end check_mandatory;

  --
  -- test check_number case 1: ...
  --
  procedure check_number is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'check_number';
    -- populate actual
    -- sct.check_number;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end check_number;

  --
  -- test exclusive_or case 1: ...
  --
  procedure exclusive_or is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'exclusive_or';
    -- populate actual
    -- sct.exclusive_or;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end exclusive_or;

  --
  -- test execute_javascript case 1: ...
  --
  procedure execute_javascript is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'execute_javascript';
    -- populate actual
    -- sct.execute_javascript;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end execute_javascript;

  --
  -- test execute_plsql case 1: ...
  --
  procedure execute_plsql is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'execute_plsql';
    -- populate actual
    -- sct.execute_plsql;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end execute_plsql;

  --
  -- test has_errors case 1: ...
  --
  procedure has_errors is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'has_errors';
    -- populate actual
    -- sct.has_errors;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end has_errors;

  --
  -- test has_no_errors case 1: ...
  --
  procedure has_no_errors is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'has_no_errors';
    -- populate actual
    -- sct.has_no_errors;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end has_no_errors;

  --
  -- test not_null case 1: ...
  --
  procedure not_null is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'not_null';
    -- populate actual
    -- sct.not_null;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end not_null;

  --
  -- test notify case 1: ...
  --
  procedure notify is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'notify';
    -- populate actual
    -- sct.notify;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end notify;

  --
  -- test register_error case 1: ...
  --
  procedure register_error is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'register_error';
    -- populate actual
    -- sct.register_error;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end register_error;

  --
  -- test register_mandatory case 1: ...
  --
  procedure register_mandatory is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'register_mandatory';
    -- populate actual
    -- sct.register_mandatory;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end register_mandatory;

  --
  -- test register_notification case 1: ...
  --
  procedure register_notification is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'register_notification';
    -- populate actual
    -- sct.register_notification;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end register_notification;

  --
  -- test set_list_from_stmt case 1: ...
  --
  procedure set_list_from_stmt is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_list_from_stmt';
    -- populate actual
    -- sct.set_list_from_stmt;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_list_from_stmt;

  --
  -- test set_session_state case 1: ...
  --
  procedure set_session_state is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_session_state';
    -- populate actual
    -- sct.set_session_state;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_session_state;

  --
  -- test set_session_state_or_error case 1: ...
  --
  procedure set_session_state_or_error is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_session_state_or_error';
    -- populate actual
    -- sct.set_session_state_or_error;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_session_state_or_error;

  --
  -- test set_value_from_stmt case 1: ...
  --
  procedure set_value_from_stmt is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_value_from_stmt';
    -- populate actual
    -- sct.set_value_from_stmt;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_value_from_stmt;

  --
  -- test stop_rule case 1: ...
  --
  procedure stop_rule is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'stop_rule';
    -- populate actual
    -- sct.stop_rule;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end stop_rule;

  --
  -- test validate_page case 1: ...
  --
  procedure validate_page is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'validate_page';
    -- populate actual
    -- sct.validate_page;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end validate_page;

  --
  -- test toggle_item_mandatory case 1: ...
  --
  procedure toggle_item_mandatory is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'toggle_item_mandatory';
    -- populate actual
    -- sct.toggle_item_mandatory;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end toggle_item_mandatory;

  --
  -- test toggle_item_status case 1: ...
  --
  procedure toggle_item_status is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'toggle_item_status';
    -- populate actual
    -- sct.toggle_item_status;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end toggle_item_status;

  --
  -- test toggle_item_visibility case 1: ...
  --
  procedure toggle_item_visibility is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'toggle_item_visibility';
    -- populate actual
    -- sct.toggle_item_visibility;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end toggle_item_visibility;

  --
  -- test refresh_item case 1: ...
  --
  procedure refresh_item is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'refresh_item';
    -- populate actual
    -- sct.refresh_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end refresh_item;

  --
  -- test set_item case 1: ...
  --
  procedure set_item is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_item';
    -- populate actual
    -- sct.set_item;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_item;

  --
  -- test set_focus case 1: ...
  --
  procedure set_focus is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'set_focus';
    -- populate actual
    -- sct.set_focus;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end set_focus;

  --
  -- test execute_apex_action case 1: ...
  --
  procedure execute_apex_action is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'execute_apex_action';
    -- populate actual
    -- sct.execute_apex_action;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end execute_apex_action;

  --
  -- test execute_java_script case 1: ...
  --
  procedure execute_java_script is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'execute_java_script';
    -- populate actual
    -- sct.execute_java_script;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end execute_java_script;

  --
  -- test write_to_console case 1: ...
  --
  procedure write_to_console is
    l_actual  integer := 0;
    l_expected integer := 1;
  begin
    g_test_name := 'write_to_console';
    -- populate actual
    -- sct.write_to_console;

    -- populate expected
    -- ...

    -- assert
    ut.expect(l_actual).to_equal(l_expected);
  end write_to_console;


  procedure tear_down
  as
  begin
    sct.set_test_mode(false);
    pit.reset_context;
    drop_session;
  end tear_down;

begin
  initialize;
end sct_test;
/
