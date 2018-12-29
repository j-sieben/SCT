create or replace package body sct_validation 
as

  /* Private constants*/
  C_FUNCTION_TEST constant varchar2(1000) := q'^
select #VALUE#
  from dual;^';

  /* Private types */

  /* Private global variables */
  procedure parse_sql(
    p_stmt in varchar2)
  as
    l_stmt varchar2(32767);
    l_cur binary_integer;
    c_stmt_tmpl constant varchar2(200) := 'select * from (#STMT#)';
  begin
    l_stmt := utl_text.bulk_replace(c_stmt_tmpl, char_table(
                'STMT', p_stmt,
                'ITEM', null,
                'PARAM_1', null,
                'PARAM_2', null,
                'PARAM_3', null));
    l_cur := dbms_sql.open_cursor(l_stmt);
    dbms_sql.parse(l_cur, l_stmt, dbms_sql.NATIVE);
    dbms_sql.close_cursor(l_cur);
  exception
    when others then
      dbms_sql.close_cursor(l_cur);
      raise;
  end parse_sql;
  
  
  procedure parse_string(
    p_value in varchar2)
  as
    l_stmt varchar2(32767);
    l_cur binary_integer;
    c_stmt_tmpl constant varchar2(200) := q'~declare 
  l_string varchar2(32767);
begin
  select #VALUE#
    into l_string
    from dual;
end;~';
  begin
    l_stmt := replace(c_stmt_tmpl, '#VALUE#', p_value);
    execute immediate l_stmt;
  end parse_string;
  
  
  procedure parse_function(
    p_value in varchar2,
    p_target in varchar2)
  as
    c_stmt constant varchar2(200) := q'^declare l_foo varchar2(32767); begin l_foo := #STMT#; end;^';
    l_cur binary_integer;
    l_stmt varchar2(2000);
  begin
    l_stmt := utl_text.bulk_replace(c_stmt, char_table('STMT', rtrim(p_value, ';')));
    l_cur := dbms_sql.open_cursor(l_stmt);
    dbms_sql.parse(l_cur, l_stmt, dbms_sql.NATIVE);
    dbms_sql.close_cursor(l_cur);
  exception
    when others then
      dbms_sql.close_cursor(l_cur);
      plugin_sct.register_error(p_target, substr(sqlerrm, 12), '');
  end parse_function;
  
  
  /* Private validators */
  procedure validate_is_apex_action(
    p_value in varchar2,
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
      plugin_sct.register_error(p_value, substr(sqlerrm, 12), '');
    end if;
  end validate_is_apex_action;
  
  
  procedure validate_is_string_or_function(
    p_value in varchar2,
    p_target in varchar2)
  as
  begin
    if trim(p_value) like '''%' then
      parse_string(p_value);
    else
      parse_function(p_value, p_target);
    end if;
  exception
    when others then
      plugin_sct.register_error(p_target, substr(sqlerrm, 12), '');
  end validate_is_string_or_function;
  
  
  /* INTERFACE */
  function get_lov_sql(
    p_spt_id in sct_action_param_type.spt_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    c_stmt constant varchar2(200) := q'^select d, r
  from sct_param_lov_#SPT_ID#
 where sgr_id = #SGR_ID#
    or sgr_id is null^';
    l_stmt varchar2(1000);
  begin
    if p_spt_id is not null then
      l_stmt := utl_text.bulk_replace(c_stmt, char_table(
               'SPT_ID', lower(p_spt_id),
               'SGR_ID', p_sgr_id));
    else
      l_stmt := 'select null d, null r from dual';
    end if;
    return l_stmt;
  end get_lov_sql;
  
  
  procedure validate_parameter(
    p_value in sct_rule_action.sra_param_1%type,
    p_spt_id in sct_action_param_type.spt_id%type,
    p_spi_id in sct_page_item.spi_id%type,
    p_environment in sct_internal.environment_rec)
  as
  begin
    case p_spt_id
    when 'APEX_ACTION' then
      validate_is_apex_action(p_value, p_environment);
    when 'FUNCTION' then
      parse_function(p_value, p_spi_id);
    when 'JAVA_SCRIPT' then
      null;
    when 'JAVA_SCRIPT_FUNCTION' then
      null;
    when 'JQUERY_SELECTOR' then
      null;
    when 'PAGE_ITEM' then
      null;
    when 'PIT_MESSAGE' then
      null;
    when 'PROCEDURE' then
      parse_function(p_value, p_spi_id);
    when 'SEQUENCE' then
      null;
    when 'SQL_STATEMENT' then
      null;
    when 'STRING' then
      null;
    when 'STRING_OR_FUNCTION' then
      validate_is_string_or_function(p_value, p_spi_id);
    when 'STRING_OR_JAVASCRIPT' then
      null;
    when 'STRING_OR_PIT_MESSAGE' then
      null;
    else
      null;
    end case;
  end validate_parameter;
  
end sct_validation;
/
