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
    p_environment in sct_internal.environment_rec)
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
    p_environment in sct_internal.environment_rec)
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
    p_environment in sct_internal.environment_rec)
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
    p_environment in sct_internal.environment_rec)
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
  
    
  procedure validate_page_item(
    p_item in varchar2)
  as
    l_expression1 utl_apex.max_char;
    l_expression2 utl_apex.max_char;
    l_value utl_apex.max_char;
    l_row apex_application_page_val%rowtype;
  
    function get_value(
      p_name in varchar2)
      return varchar2
    is
    begin
      return replace(v(p_name), '%null%');
    end get_value;
    
    procedure put_error_on_stack
    is
      l_associated_item utl_apex.ora_name_type := p_item;
    begin
      if l_row.validation_failure_text is not null then
        if l_associated_item is null and
          (l_row.validation_type_code like 'ITEM\_%' escape '\' or 
           l_row.validation_type_code = 'REGULAR_EXPRESSION')
        then
            l_associated_item := l_expression1;
        end if;
    
        /*sct_internal.register_error (
          p_spi_id => l_associated_item,
          p_error_msg => l_row.validation_failure_text,
          p_internal_error => null);*/
        dbms_output.put_line(l_row.validation_failure_text);
      end if;
    end put_error_on_stack;
    
    procedure assert(
      p_test in boolean)
    as
    begin
      if not(p_test) then
        put_error_on_stack;
      end if;
    end assert;
    
  begin
      with params as(
           select utl_apex.get_application_id application_id,
                  utl_apex.get_page_id page_id
              from dual)
    select /*+ no_merge(p) */ v.*
      into l_row
      from apex_application_page_val v
      join params p
        on v.application_id = p.application_id
       and v.page_id = p.page_id
     where associated_item = p_item;
       
    l_expression1 := wwv_flow.do_substitutions(l_row.validation_expression1);
    l_expression2 := wwv_flow.do_substitutions(l_row.validation_expression2);
  
    case l_row.validation_type_code
    when 'EXISTS' then
      pit.assert_exists(p_stmt => l_expression1);
    when 'NOT_EXISTS' then
      pit.assert_not_exists(p_stmt => l_expression1);
    when 'ITEM_NOT_ZERO' then
      assert(utl_apex.get_number(l_expression1) != 0);
    when 'ITEM_NOT_NULL' then
      assert(get_value(l_expression1) is not null);
    when 'ITEM_NOT_NULL_OR_ZERO' then
      assert(get_value(l_expression1) is not null and utl_apex.get_number(l_expression1) != 0);
    when 'ITEM_IS_ALPHANUMERIC' then
      l_value := get_value(l_expression1);
      for j in 1 .. coalesce(length(l_value),0) loop
        if instr(C_ALPHANUMERIC_CHARS, substr(l_value, j, 1)) = 0 then
          put_error_on_stack;
          exit;
        end if;
      end loop;
    when 'ITEM_IS_NUMERIC' then
      assert(utl_apex.get_number(l_expression1) is not null);
    when 'ITEM_CONTAINS_NO_SPACES' then
      assert(instr(get_value(l_expression1), ' ') = 0);
    when 'ITEM_IS_DATE' then
      assert(utl_apex.get_date(l_expression1) is not null);
    when 'ITEM_IS_TIMESTAMP' then
      assert(utl_apex.get_timestamp(l_expression1) is not null);
    when 'SQL_EXPRESSION' then
      evaluate_sql_expression(p_stmt => l_expression1);
    when 'PLSQL_EXPRESSION' then
      assert(evaluate_plsql_expression(p_plsql_code => l_expression1));
    when 'PLSQL_ERROR' then
      execute_plsql_code(p_plsql_code => l_expression1); 
 /*   when 'FUNC_BODY_RETURNING_ERR_TEXT' then
      put_error_on_stack(execute_function_as_varchar2(p_plsql_code => l_expression1));*/
    when 'FUNC_BODY_RETURNING_BOOLEAN' then
      assert(execute_function_as_boolean(p_plsql_code => l_expression1));
    when 'REGULAR_EXPRESSION' then
      assert(regexp_like(get_value(l_expression1), l_expression2));
    when 'ITEM_IN_VALIDATION_IN_STRING2' then
      assert(instr(l_expression2, get_value(l_expression1)) > 0);
    when 'ITEM_IN_VALIDATION_NOT_IN_STRING2' then
      assert(instr(l_expression2, get_value(l_expression1)) = 0
          or get_value(l_expression1) is null);
    when 'ITEM_IN_VALIDATION_EQ_STRING2' then
      assert(l_expression2 = get_value(l_expression1));
    when 'ITEM_IN_VALIDATION_NOT_EQ_STRING2' then
      assert(l_expression2 != get_value(l_expression1) 
          or get_value(l_expression1) is null);
    when 'ITEM_IN_VALIDATION_CONTAINS_ONLY_CHAR_IN_STRING2' then
      l_value := get_value(l_expression1);
      if l_value is not null then
        for i in 1 .. length(l_value) loop
          if instr(l_expression2, substr(l_value, i, 1)) = 0 then
            put_error_on_stack;
            exit;
          end if;
        end loop;
      end if;
    when 'ITEM_IN_VALIDATION_CONTAINS_AT_LEAST_ONE_CHAR_IN_STRING2' then
      l_value := get_value(l_expression1);
      assert(l_value is not null);
      for i in 1 .. coalesce(length(l_value), 0) loop
        if instr(l_expression2, substr(l_value, i, 1)) > 0 then
          put_error_on_stack;
          exit;
        end if;
      end loop;
    when 'ITEM_IN_VALIDATION_CONTAINS_NO_CHAR_IN_STRING2' then
      l_value := get_value(l_expression1);
      for i in 1 .. coalesce(length(l_value), 0) loop
        if instr(l_expression2, substr(l_value, i, 1)) > 0 then
          put_error_on_stack;
          exit;
        end if;
      end loop;
    else
      raise_application_error(-20000, 'unsupported validation_type ' || l_row.validation_type_code);
    end case;
   
  exception
    when NO_DATA_FOUND then
      -- No validation for item found, ignore
      null;
  end validate_page_item;
  
end sct_validation;
/
