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

end sct_util;
/