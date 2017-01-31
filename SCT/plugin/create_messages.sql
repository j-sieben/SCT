begin

  pit_admin.merge_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_text => q'^Erwartetes Format ~#1#~.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_FORMAT',
    p_pms_text => q'^Ungültiges Datum. Erwartetes Format ~#1#~.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -1861
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER',
    p_pms_text => q'^Ungültige Zahl. Erwartetes Format ~#1#~.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_text => q'^Unerwarteter Elementtyp ~#1#~ mit Formatmaske.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_GENERIC_ERROR',
    p_pms_text => q'^"#1#".^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LOOP',
    p_pms_text => q'^Element #1# hat eine rekursive Schleife auf Rekursionstiefe #2# erzeugt und wurde daher ignoriert.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_text => q'^Element #1# hat Rekursionstiefe von #2# ueberschritten.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_text => q'^Regel #1# existiert nicht.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_text => q'^Element #1# ist ein Pflichtelement. Bitte tragen Sie einen Wert ein.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );  

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_text => q'^Regelgruppenview #1# wurde gelöscht.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_text => q'^Regelgruppenview #1# wurde erstellt.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_text => q'^Fehler beim Erstellen der Regelgruppenview #1#: #2#.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );  

  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_text => q'^APEX-Anwendung #1# existiert nicht.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_text => q'^APEX-Anwendungsseite #1# existiert nicht in Anwendung #2#.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_DOES_NOT_EXIST',
    p_pms_text => q'^Seitenelement #1# existiert nicht in Anwendung #2#.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_SESSION_STATE_SET',
    p_pms_text => q'^Element ~#1#~ wurde auf den Wert ~#2#~ gesetzt^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );

  commit;
  
  pit_admin.create_message_package;
end;
/