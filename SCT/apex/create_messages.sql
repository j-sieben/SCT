begin

  pit_admin.merge_message_group(
    p_pmg_name => 'SCT',
    p_pmg_description => 'Meldungen für das SCT Plugin');
    
  pit_admin.merge_message_group(
    p_pmg_name => 'APEX',
    p_pmg_description => 'Allgemeine APEX-Meldungen');

  pit_admin.merge_message(
    p_pms_name => 'SCT_SGR_MUS_BE_UNIQUE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Der Name der Regelgruppe muss für diese Anwendung eindeutig sein.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_SGR_MUS_BE_UNIQUE',
    p_pms_text => q'~SCT rule group name must be unique for this application.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'APEX_UNHANDLED_REQUEST',
    p_pms_pmg_name => 'APEX',
    p_pms_text => q'~Request #1# wurde nicht erwartet.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'APEX_UNHANDLED_REQUEST',
    p_pms_text => q'~Request #1# is unexpected.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'APEX_LOG_MESSAGE',
    p_pms_pmg_name => 'APEX',
    p_pms_text => q'~#1#~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );
    
  commit;
  pit_admin.create_message_package;
end;
/