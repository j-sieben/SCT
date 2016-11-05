begin
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_text => q'øAnwendung #1# existiert nicht.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_text => q'øSeite #1# existiert nicht in Anwendung #2#.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_text => q'øRegelgruppe #1# existiert nichtø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATED',
    p_pms_text => q'øRegelgruppe #1# erfolgreich erstelltø',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_text => q'øRegelgruppen-View #1# gelöschtø',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_text => q'øFehler #1# bei #2#ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  commit;
  
  pit_admin.create_message_package;
end;
/