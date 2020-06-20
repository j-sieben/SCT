create or replace package sct_util
  authid definer
as

  /* Types */
  subtype ora_name_type is varchar2(128 byte);
  subtype sql_char is varchar2(4000 byte);
  subtype max_char is varchar2(32767 byte);
  subtype flag_type is &FLAG_TYPE.;
  
  C_WITH_UNIT_TESTS constant boolean := &WITH_UT.;

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
    
  
  function bool_to_flag(
    p_bool in boolean)
    return sct_util.flag_type;
    
  
  /* Wrapper around TO_NUMBER that extracts a GROUP selector from the conversion map
   * @param  p_number      Number string to convert
   * @param  p_conversion  Conversion mask, possibly containing a group selector
   * @return Converted number
   * @usage  Is used to extract a group selector from the conversion mask to avoid errors
   */
  function to_number(
    p_number in varchar2,
    p_conversion in varchar2)
    return number;
  
  /* Helper to create a string sct_util.C_TRUE/FALSE based upon parameter value.
   * %param  p_bool  Flag to indicate which string is required
   * %usage  Is used in export scripts to replace the actual boolean value with a reference to this package
   *         This is required to make the export scripts eligible for any FLAG_TYPE
   */
  function to_bool(
    p_bool in flag_type)
    return varchar2;


  /** Helper to sanitize any SCT name to comply with internal naming rules
   * @param  p_name  Name to sanitize
   * @return Name that adheres to the following naming conventions:
   *         - no quotes
   *         - no blanks (replaced by underscores)
   *         - all uppercase
   *         - legnth limit 50
   */
  function clean_sct_name(
    p_name in varchar2)
    return varchar2;

end sct_util;
/