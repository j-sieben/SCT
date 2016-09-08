begin

  pit_admin.merge_message(
    p_message_name => 'SCT_VIEW_CREATION',
    p_message_text => q'øException #1# at #2#.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN'
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_VIEW_CREATION',
    p_message_text => q'øFehler #1# bei #2#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_APP_DOES_NOT_EXIST',
    p_message_text => q'øApplication #1# does not exist.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN'
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_APP_DOES_NOT_EXIST',
    p_message_text => q'øAnwendung #1# existiertø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_message_text => q'øPage #1# does not exist in application #2#.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN'
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_message_text => q'øSeite #1# existiert nicht in Anwendung #2#ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_RULE_VALIDATION',
    p_message_text => q'øException when validating rule #1#: #2#.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN'
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_RULE_VALIDATION',
    p_message_text => q'øFehler bei der Validierung der Regel #1#: #2#ø',
    p_message_language => 'GERMAN'
  );

  commit;
  
  pit_admin.create_message_package;
end;
/