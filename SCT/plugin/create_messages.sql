begin

  pit_admin.merge_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_text => q'øErwartetes Format »#1#«.ø',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_FORMAT',
    p_pms_text => q'øUngültiges Datum. Erwartetes Format »#1#«.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -1861
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER',
    p_pms_text => q'øUngültige Zahl. Erwartetes Format »#1#«.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_text => q'øUnerwarteter Elementtyp »#1#« mit Formatmaske.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_GENERIC_ERROR',
    p_pms_text => q'ø"#1#".ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LOOP',
    p_pms_text => q'øElement #1# hat rekursive Schleife erzeugt und wurde daher ignoriert.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_text => q'øElement #1# hat Rekursionstiefe von #2# ueberschritten.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_text => q'øRegel #1# existiert nicht.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_text => q'øElement #1# ist ein Pflichtelement. Bitte tragen Sie einen Wert ein.ø',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );  

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_text => q'øRegelgruppenview #1# wurde gelöscht.ø',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_text => q'øRegelgruppenview #1# wurde erstellt.ø',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_text => q'øFehler beim Erstellen der Regelgruppenview #1#: #2#.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );
  

  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_text => q'øAPEX-Anwendung #1# existiert nicht.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_text => q'øAPEX-Anwendungsseite #1# existiert nicht in Anwendung #2#.ø',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  commit;
  
  pit_admin.create_message_package;
end;
/