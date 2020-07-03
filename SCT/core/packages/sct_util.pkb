create or replace package body sct_util
as

  function get_true
    return flag_type
  as
  begin
    return C_TRUE;
  end get_true;


  function get_false
    return flag_type
  as
  begin
    return C_FALSE;
  end get_false;


  function get_boolean(
    p_bool in varchar2)
    return sct_util.flag_type
  as
  begin
    if p_bool in ('J', 'Y', '1') then
      return sct_util.C_TRUE;
    else
      return sct_util.C_FALSE;
    end if;
  end get_boolean;


  function to_bool(
    p_bool in flag_type)
    return varchar2
  as
  begin
    return case p_bool when C_TRUE then 'sct_util.C_TRUE' else 'sct_util.C_FALSE' end;
  end to_bool;



  function bool_to_flag(
    p_bool in boolean)
    return sct_util.flag_type
  as
  begin
    if p_bool then
      return C_TRUE;
    else
      return C_FALSE;
    end if;
  end bool_to_flag;


  function to_number(
    p_number in varchar2,
    p_conversion in varchar2)
    return number
  as
  begin
    return to_number(p_number, replace(p_conversion, 'G'));
  end to_number;


  function clean_sct_name(
    p_name in varchar2)
    return varchar2
  as
    l_name sct_rule_group.sgr_name%type;
  begin
    l_name := replace(replace(p_name, '"'), ' ', '_');
    l_name := upper(substr(l_name, 1, 50));
    return l_name;
  end clean_sct_name;
  
  
  function get_trans_item_name(
    p_item in varchar2,
    p_msg_args in msg_args default null)
    return varchar2
  as
  begin
    return pit.get_trans_item_name(C_SCT, p_item, p_msg_args);
  end get_trans_item_name;

end sct_util;
/