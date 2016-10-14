begin

  pit_admin.merge_message(
    p_message_name => 'SCT_APP_DOES_NOT_EXIST',
    p_message_text => q'øApplication #1# does not exist.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_APP_DOES_NOT_EXIST',
    p_message_text => q'øAnwendung #1# existiert nicht.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_EXPECTED_FORMAT',
    p_message_text => q'øExpected format: "#1#".ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_EXPECTED_FORMAT',
    p_message_text => q'øErwartetes Format »#1#«.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_ITEM_IS_MANDATORY',
    p_message_text => q'ø"#1#" is manatory. Please enter a value.ø',
    p_severity => 40,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_ITEM_IS_MANDATORY',
    p_message_text => q'ø»#1#« ist ein Pflichtfeld. Bitte geben Sie einen Wert ein.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_message_text => q'øPage #1# does not exist in application #2#.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_message_text => q'øSeite #1# existiert nicht in Anwendung #2#.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_message_text => q'øRule group #1# does not exist.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_message_text => q'øRegelgruppe #1# existiert nichtø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_RULE_VALIDATION',
    p_message_text => q'øException when validating rule #1#: #2#.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_RULE_VALIDATION',
    p_message_text => q'øFehler bei der Validierung der Regel #1#: #2#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_RULE_VIEW_DELETED',
    p_message_text => q'øRule group view #1# deleted.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_RULE_VIEW_DELETED',
    p_message_text => q'øRegelgruppen-View #1# gelöschtø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_message_text => q'øUnexpected item type "#1#" with format mask.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_message_text => q'øUnerwarteter Elementtyp »#1#« mit Formatmaske.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_VIEW_CREATED',
    p_message_text => q'øRULE GROUP #1# created succesfully.ø',
    p_severity => 70,
    p_message_language => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_VIEW_CREATED',
    p_message_text => q'øRegelgruppe #1# erfolgreich erstelltø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_VIEW_CREATION',
    p_message_text => q'øException #1# at #2#.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_VIEW_CREATION',
    p_message_text => q'øFehler #1# bei #2#ø',
    p_message_language => 'GERMAN'
  );

  commit;
  
  pit_admin.create_message_package;
end;
/