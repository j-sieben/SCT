begin

  pit_admin.merge_message(
    p_message_name => 'SCT_INVALID_FORMAT',
    p_message_text => q'øInvalid date. Expected format: "#1#".ø',
    p_severity => 30,
    p_message_language => 'AMERICAN',
    p_error_number => -1861
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_INVALID_FORMAT',
    p_message_text => q'øUngültiges Datum. Erwartetes Format »#1#«.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_INVALID_NUMBER',
    p_message_text => q'øInvalid Number. Expected format: "#1#".ø',
    p_severity => 30,
    p_message_language => 'AMERICAN'
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_INVALID_NUMBER',
    p_message_text => q'øUngültige Zahl. Erwartetes Format »#1#«.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_message_text => q'øUnexpected item type "#1#" with format mask.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN'
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_message_text => q'øUnerwarteter Elementtyp »#1#« mit Formatmaske.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_GENERIC_ERROR',
    p_message_text => q'ø"#1#".ø',
    p_severity => 30,
    p_message_language => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_RECURSION_LOOP',
    p_message_text => q'øElement #1# has created recursion loop and was ignored.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN'
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_RECURSION_LOOP',
    p_message_text => q'øElement #1# hat rekursive Schleife erzeugt und wurde daher ignoriert.ø',
    p_message_language => 'GERMAN'
  );

  pit_admin.merge_message(
    p_message_name => 'SCT_RECURSION_LIMIT',
    p_message_text => q'øElement #1# has exceeded recursion limit of #2#.ø',
    p_severity => 30,
    p_message_language => 'AMERICAN'
  );

  pit_admin.translate_message(
    p_message_name => 'SCT_RECURSION_LIMIT',
    p_message_text => q'øElement #1# hat Rekursionstiefe von #2# ueberschritten..ø',
    p_message_language => 'GERMAN'
  );

  commit;
  
  pit_admin.create_message_package;
end;
/