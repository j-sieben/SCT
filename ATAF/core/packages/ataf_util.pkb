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

end sct_util;
/