create or replace package sct_util
  authid definer
as

  /* Types */
  subtype ora_name_type is varchar2(128 byte);
  subtype sql_char is varchar2(4000 byte);
  subtype max_char is varchar2(32767 byte);
  subtype flag_type is &FLAG_TYPE.;

  /* Package constants */
  C_NO_FIRING_ITEM constant varchar2(30 byte) := 'DOCUMENT';
  C_INITIALIZE_EVENT constant varchar2(25) := 'initialize';    
  
  C_TRUE constant flag_type := &C_TRUE.;
  C_FALSE constant flag_type := &C_FALSE.;
  C_CR constant varchar2(2 byte) := chr(10);
  
  /* Methode zur Ermittlung von Wahrheitswerten
   */
  function get_true
    return flag_type;
    
  function get_false
    return flag_type;
  
  /* Helper to map different boolean values to TRUE or FALSE 
   * %param  p_bool  Boolean value that is to be converted
   * %return sct_util.C_TRUE | sct_util.C_TRUE
   * %usage  Is used to map "TRUTHY" values to true and "FALSY" value to false.
   *         Used to stabilize im- and export of meta data between versions of SCT
   */
  function get_boolean(
    p_bool in varchar2)
    return sct_util.flag_type;
  
  /* Helper to create a string sct_util.C_TRUE/FALSE based upon parameter value.
   * %param  p_bool  Flag to indicate which string is required
   * %usage  Is used in export scripts to replace the actual boolean value with a reference to this package
   *         This is required to make the export scripts eligible for any FLAG_TYPE
   */
  function to_bool(
    p_bool in flag_type)
    return varchar2;

end sct_util;
/