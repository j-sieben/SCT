create or replace package body sct_validation 
as

  /* Private constants*/
  C_ALPHANUMERIC_CHARS constant varchar2(100) := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_';
  /* Private types */

  /* Private global variables */  
  
  procedure parse(
    p_stmt in varchar2)
  as
    l_cur binary_integer;
  begin
    l_cur := dbms_sql.open_cursor(p_stmt);
    dbms_sql.parse(l_cur, p_stmt, dbms_sql.NATIVE);
    dbms_sql.close_cursor(l_cur);
  exception
    when others then
      dbms_sql.close_cursor(l_cur);
      raise;
  end parse;
  
  
  procedure parse_sql(
    p_stmt in varchar2)
  as
    l_stmt utl_apex.max_char;
    C_STMT_TMPL constant varchar2(200) := 'select * from (#STMT#)';
  begin
    l_stmt := utl_text.bulk_replace(C_STMT_TMPL, char_table(
                'STMT', p_stmt,
                'ITEM', null,
                'PARAM_1', null,
                'PARAM_2', null,
                'PARAM_3', null));
    parse(l_stmt);
  end parse_sql;
  
  
  procedure parse_string(
    p_value in out nocopy varchar2)
  as
    l_stmt utl_apex.max_char;
    l_cur binary_integer;
    C_STMT_TMPL constant varchar2(200) := q'~declare 
  l_string utl_apex.max_char;
begin
  select #VALUE#
    into l_string
    from dual;
end;~';
  begin
    l_stmt := replace(C_STMT_TMPL, '#VALUE#', p_value);
    execute immediate l_stmt;
  end parse_string;
  
  
  procedure parse_function(
    p_value in out nocopy varchar2,
    p_function in boolean default true)
  as
    C_FUNCTION_STMT constant varchar2(200) := q'^declare l_foo utl_apex.max_char; begin l_foo := #STMT#; end;^';
    C_PROCEDURE_STMT constant varchar2(200) := q'^declare l_foo utl_apex.max_char; begin #STMT#; end;^';
    l_cur binary_integer;
    l_stmt varchar2(2000);
  begin
    p_value := rtrim(p_value, ';');
    if p_function then
      l_stmt := C_FUNCTION_STMT;
    else
      l_stmt := C_PROCEDURE_STMT;
    end if;
    l_stmt := replace(l_stmt, 'STMT', p_value);
    l_cur := dbms_sql.open_cursor(l_stmt);
    dbms_sql.parse(l_cur, l_stmt, dbms_sql.NATIVE);
    dbms_sql.close_cursor(l_cur);
  exception
    when others then
      dbms_sql.close_cursor(l_cur);
      raise;
  end parse_function;
  
  
  /* Private validators */
  procedure validate_is_apex_action(
    p_value in out nocopy varchar2,
    p_environment in sct_util.environment_rec)
  as
    l_exists binary_integer;
  begin
    select count(*)
      into l_exists
      from dual
     where exists(
           select null
             from sct_apex_action
            where saa_sgr_id = p_environment.sgr_id
              and saa_name = p_value);
    if l_exists = 0 then
      sct_internal.register_error(
        p_spi_id => p_value, 
        p_error_msg => substr(sqlerrm, 12), 
        p_internal_error => '');
    end if;
  exception
    when others then
      sct_internal.register_error(
        p_spi_id => p_value, 
        p_error_msg => substr(sqlerrm, 12), 
        p_internal_error => '');
  end validate_is_apex_action;
  
  
  procedure validate_is_string(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    parse_string(p_value);
  exception
    when others then
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
  end validate_is_string;
  
  
  procedure validate_is_function(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    parse_function(p_value);
  exception
    when others then
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
  end validate_is_function;
  
  
  procedure validate_is_procedure(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    parse_function(p_value, false);
  exception
    when others then
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
  end validate_is_procedure;
  
  
  procedure validate_is_pit_message(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    select pms_name
      into p_value
      from pit_message
     where pms_name = upper(p_value);
  exception
    when NO_DATA_FOUND then
      -- TODO: refactor to MSG
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => 'Invalid PIT message name', 
        p_internal_error => '');
  end validate_is_pit_message;
  
  
  procedure validate_is_string_or_function(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    p_value := trim(p_value);
    if substr(trim(p_value), 1, 1) =  '''' then
      parse_string(p_value);
    else
      parse_function(p_value);
    end if;
  exception
    when others then
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
  end validate_is_string_or_function;
  
  
  procedure validate_is_string_or_message(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    p_value := trim(p_value);
    if substr(trim(p_value), 1, 1) =  '''' then
      parse_string(p_value);
    else
      validate_is_pit_message(p_value, p_target);
    end if;
  exception
    when others then
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
  end validate_is_string_or_message;
  
  
  procedure validate_is_sql_statement(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
    C_STMT constant varchar2(100) := 'select * from (#STMT#)';
    l_stmt utl_apex.max_char;
    l_cur binary_integer;
  begin
    l_stmt := replace(C_STMT, '#STMT#', p_value);
    l_cur := dbms_sql.open_cursor;
    dbms_sql.parse(l_cur, l_stmt, dbms_sql.NATIVE);
  exception
    when others then
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => substr(sqlerrm, 12),
        p_internal_error => null);
  end validate_is_sql_statement;
  
  
  procedure validate_is_selector(
    p_value in out nocopy varchar2,
    p_target in varchar2,
    p_environment in sct_util.environment_rec)
  as
  begin
    p_value := trim(p_value);
    -- If selector starts with # or ., take it as is, otherwise try to find item and prefix it with #
    if not substr(p_value, 1, 1) in ('#', '.') then
      select '#' || spi_id
        into p_value
        from sct_page_item
       where spi_sgr_id = p_environment.sgr_id
         and spi_id = upper(p_value);
    end if;
  exception
    when NO_DATA_FOUND then
      -- TODO: refactor to MSG
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => 'Invalid jQuery-Selektor', 
        p_internal_error => null);
  end validate_is_selector;
  
  
  procedure validate_is_page_item(
    p_value in out nocopy varchar2,
    p_target in varchar2,
    p_environment in sct_util.environment_rec)
  as
  begin
    select spi_id
      into p_value
      from sct_page_item
     where spi_sgr_id = p_environment.sgr_id
       and spi_id = upper(p_value);
  exception
    when NO_DATA_FOUND then
      -- TODO: refactor to MSG
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => 'Invalid Page Item name', 
        p_internal_error => null);
  end validate_is_page_item;
  
  
  procedure validate_is_sequence(
    p_value in out nocopy varchar2,
    p_target in varchar2)
  as
  begin
    select sequence_name
      into p_value
      from user_sequences
     where sequence_name = upper(p_value);
    
  exception
    when NO_DATA_FOUND then
      -- TODO: refactor to MSG
      sct_internal.register_error(
        p_spi_id => p_target, 
        p_error_msg => 'Invalid Sequence name', 
        p_internal_error => '');
  end validate_is_sequence;
  
  
  procedure execute_plsql_code(
    p_plsql_code in varchar2)
  as
    C_STMT constant varchar2(100) := 'begin #EXPRESSION#; end;';
    l_stmt utl_apex.max_char;
    l_result boolean;
  begin
    l_stmt := replace(C_STMT, '#EXPRESSION#', rtrim(p_plsql_code, ';'));
    parse(l_stmt);
    execute immediate l_stmt;
  end execute_plsql_code;
  
  
  function execute_function_as_varchar2(
    p_plsql_code in varchar2)
    return varchar2
  as
    C_STMT constant varchar2(100) := 'begin :x := #EXPRESSION#; end;';
    l_stmt utl_apex.max_char;
    l_result utl_apex.max_char;
  begin
    l_stmt := replace(C_STMT, '#EXPRESSION#', rtrim(p_plsql_code, ';'));
    parse(l_stmt);
    execute immediate l_stmt using out l_result;
    return l_result;
  end execute_function_as_varchar2;
  
  
  function execute_function_as_boolean(
    p_plsql_code in varchar2)
    return boolean
  as
    C_STMT constant varchar2(100) := q'^declare function bool return boolean as begin #EXPRESSION#; end; begin :x := bool; end;^';
    l_stmt utl_apex.max_char;
    l_result boolean;
  begin
    l_stmt := replace(C_STMT, '#EXPRESSION#', rtrim(p_plsql_code, ';'));
    parse(l_stmt);
    execute immediate l_stmt using out l_result;
    return l_result;
  end execute_function_as_boolean;
  
  
  function evaluate_plsql_expression(
    p_plsql_code in varchar2)
    return boolean
  as
    C_STMT constant varchar2(100) := 'begin :x := #EXPRESSION#; end;';
    l_stmt utl_apex.max_char;
    l_result boolean;
  begin
    l_stmt := replace(C_STMT, '#EXPRESSION#', rtrim(p_plsql_code, ';'));
    parse(l_stmt);
    execute immediate l_stmt using out l_result;
    return l_result;
  end evaluate_plsql_expression;
  
  
  procedure evaluate_sql_expression(
    p_stmt in varchar2)
  as
    C_STMT constant varchar2(100) := 'select count(*) from dual where #EXPRESSION#';
    l_stmt utl_apex.max_char;
  begin
    l_stmt := replace(C_STMT, '#EXPRESSION#', p_stmt);
    pit.assert_exists(p_stmt);
  end evaluate_sql_expression;
  
  
  /* INTERFACE */
  procedure validate_param_lov(
    p_spt_id in sct_action_param_type.spt_id%type,
    p_spt_item_type in sct_action_param_type.spt_item_type%type)
  as
    C_SELECT_LIST constant utl_apex.ora_name_type := 'SELECT_LIST';
    C_VIEW_PATTERN constant utl_apex.ora_name_type := 'SCT_PARAM_LOV_';
    C_COLUMN_LIST constant char_table := char_table('D', 'R', 'SGR_ID');
    
    l_view_exists number;
    l_column_count number;
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_spt_id', p_spt_id),
                    msg_param('p_sp_spt_item_typept_id', p_spt_item_type)));
                    
    if p_spt_item_type = C_SELECT_LIST then
      select count(distinct table_name) view_exists, count(*) column_count
        into l_view_exists, l_column_count
        from user_tab_columns
       where table_name = C_VIEW_PATTERN || p_spt_id
         and column_name member of C_COLUMN_LIST;
         
      pit.assert(l_view_exists = 1, msg.SCT_PARAM_LOV_MISSING);
      pit.assert(l_column_count = 3, msg.SCT_PARAM_LOV_INCORRECT);
    end if;
    
    pit.leave_optional;
  end validate_param_lov;
  
  
  function get_lov_sql(
    p_spt_id in sct_action_param_type.spt_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    C_STMT constant varchar2(200) := q'^select d, r
  from sct_param_lov_#SPT_ID#
 where sgr_id = #SGR_ID#
    or sgr_id is null^';
    l_stmt varchar2(1000);
  begin
    if p_spt_id is not null then
      l_stmt := utl_text.bulk_replace(C_STMT, char_table(
                  'SPT_ID', lower(p_spt_id),
                  'SGR_ID', p_sgr_id));
    else
      l_stmt := 'select null d, null r from dual';
    end if;
    return l_stmt;
  end get_lov_sql;
  
  
  procedure validate_parameter(
    p_value in out nocopy sct_rule_action.sra_param_1%type,
    p_spt_id in sct_action_param_type.spt_id%type,
    p_spi_id in sct_page_item.spi_id%type,
    p_environment in sct_util.environment_rec)
  as
  begin
    case p_spt_id
    when 'APEX_ACTION' then
      validate_is_apex_action(p_value, p_environment);
    when 'FUNCTION' then
      validate_is_function(p_value, p_spi_id);
    when 'JAVA_SCRIPT' then
      null;
    when 'JAVA_SCRIPT_FUNCTION' then
      null;
    when 'JQUERY_SELECTOR' then
      validate_is_selector(p_value, p_spi_id, p_environment);
    when 'PAGE_ITEM' then
      validate_is_page_item(p_value, p_spi_id, p_environment);
    when 'PIT_MESSAGE' then
      validate_is_pit_message(p_value, p_spi_id);
    when 'PROCEDURE' then
      validate_is_procedure(p_value, p_spi_id);
    when 'SEQUENCE' then
      validate_is_sequence(p_value, p_spi_id);
    when 'SQL_STATEMENT' then
      validate_is_sql_statement(p_value, p_spi_id);
    when 'STRING' then
      validate_is_string(p_value, p_spi_id);
    when 'STRING_OR_FUNCTION' then
      validate_is_string_or_function(p_value, p_spi_id);
    when 'STRING_OR_JAVASCRIPT' then
      null;
    when 'STRING_OR_PIT_MESSAGE' then
      validate_is_string_or_message(p_value, p_spi_id);
    else
      pit.error(msg.SCT_UNKNOWN_SPT, msg_args(p_spt_id));
    end case;
  end validate_parameter;
  
end sct_validation;
/
