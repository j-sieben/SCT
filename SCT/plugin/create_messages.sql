begin

  /*pit_admin.merge_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_text => q'~#4#  // Fehler in  #RECURSION#: #1# (#2#), Ausloesendes Element: "#3#" aufgetreten, fuehre Fehlerbehandlung aus~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');
    
  pit_admin.translate_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_text => q'~#4#  // exception occured in #RECURSION#: #1# (#2#), Firing Item: "#3#", proceeding with exception handling~',
    p_pms_pml_name => 'AMERICAN');*/
    
  commit;
  --pit_admin.create_message_package;
end;
/
