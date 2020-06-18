create or replace package utl_sct 
  authid definer
as

  /** Package to wrap SCT functionality in methods to allow to control SCT remotely from PL/SQL
   *  This enables a developer to call SCT actions from within PL/SQL logic to reduce complexity of SCT rules
   */
   
  
  /** Method to encapsulate PIT collection mode error treatment
   * @param [p_mapping] CHAR_TABLE instance with error code - page item names couples, according to DECODE function
   * @usage  Is used to retrieve the collection of messages collected during validation of a use case in PIT collect mode.
   *         The method retrieves the messages and maps the error codes to page items passed in via P_MAPPING.
   *         If found, it shows the exception inline with field and notification to those items, otherwise it shows the
   *         message without item reference in the notification area only.
   *         Supports #LABEL# replacement, page item name may be passed in with or without page prefix.
   *         Similar to UTL_APEX.HANDLE_BULK_ERRORS, but uses SCT to show the messages dynamically as opposed to UTL_APEX
   *         that encapsulates the messages in the validation life cycle step of APEX.
   */
  procedure handle_bulk_errors(
    p_mapping in char_table default null);
  
end utl_sct;
/