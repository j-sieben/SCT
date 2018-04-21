begin

  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_text => q'~APEX-Anwendung #1# existiert nicht.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_text => q'~APEX application #1# does not exist.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_text => q'~Erwartetes Format "#1#".~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_text => q'~Expected format "#1#",~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_GENERIC_ERROR',
    p_pms_text => q'~"#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_CLOB_JS_SCRIPT',
    p_pms_text => '#1#',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_FORMAT',
    p_pms_text => q'~Ungueltiges Datum. Erwartetes Format: "#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -1861
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_INVALID_FORMAT',
    p_pms_text => q'~Invalid date. Expected format: "#1#",~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER',
    p_pms_text => q'~Ungueltige Zahl. Erwartetes Format: "#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_INVALID_NUMBER',
    p_pms_text => q'~Invalid number. Expected format: "#1#",~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_DOES_NOT_EXIST',
    p_pms_text => q'~Seitenelement "#1#" existiert nicht in Anwendung #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_ITEM_DOES_NOT_EXIST',
    p_pms_text => q'~Page item "#1#" does not exist in application #2#.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_text => q'~Element "#1#" ist ein Pflichtelement. Bitte tragen Sie einen Wert ein.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_text => q'~Page item "#1#" is mandatory. Please provide a valid value.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_text => q'~APEX-Anwendungsseite #1# existiert nicht in Anwendung #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_text => q'~APEX page #1# does not exist in application #2#.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_HAS_ERRORS',
    p_pms_text => q'~Beheben Sie vor dem Versenden alle Fehler der Seite.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_PAGE_HAS_ERRORS',
    p_pms_text => q'~Page contains errors. Please solve open errors before submit.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_text => q'~Element "#1#" hat Rekursionstiefe #2# ueberschritten.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_text => q'~Page item "#1#" has exceeded recursion depth #2#.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LOOP',
    p_pms_text => q'~Element "#1#" hat eine rekursive Schleife auf Rekursionstiefe #2# erzeugt und wurde daher ignoriert.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_text => q'~Page item "#1#" has created a recursion loop at depth #2# and was ignored.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_text => q'~Regel #1# existiert nicht.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_text => q'~Rule #1# does not exist.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VALIDATION',
    p_pms_text => q'~Fehler bei der Validierung der Regel #1#: #2#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_RULE_VALIDATION',
    p_pms_text => q'~Exception when validating rule #1#: #2#.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_text => q'~Regelgruppenview "#1#" wurde erstellt.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_text => q'~Rule view "#1#" created.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_text => q'~Regelgruppenview "#1#" wurde geloescht.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_text => q'~Rule view "#1#" deleted.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_SESSION_STATE_SET',
    p_pms_text => q'~// Element "#1#" wurde auf den Wert "#2#" gesetzt~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_SESSION_STATE_SET',
    p_pms_text => q'~// Page item "#1#" set to "#2#".~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_text => q'~Unerwarteter Elementtyp "#1#" mit Formatmaske.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_text => q'~Unexpected item type "#1#" with format mask.~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATED',
    p_pms_text => q'~Regelgruppenview "#1#" erfolgreich erstellt~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_VIEW_CREATED',
    p_pms_text => q'~Rule group view "#1#" created succesfully.~',
    p_pms_pml_name => 'AMERICAN'
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_text => q'~Fehler beim Erstellen der Regelgruppenview "#1#": #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_text => q'~Exception when creating rule group "#1#": #2#.~',
    p_pms_pml_name => 'AMERICAN'
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_DATA_FOR_ITEM',
    p_pms_text => q'~Keine Daten fuer "#1#" gefunden.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_NO_DATA_FOR_ITEM',
    p_pms_text => q'~No data found for "#1#".~',
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_WHERE_CLAUSE',
    p_pms_text => q'~Fehler beim Erzeugen der WHERE-Klausel: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_WHERE_CLAUSE',
    p_pms_text => q'~Exception when creating WHERE-clause: #SQLERRM#.~',
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_GROUP',
    p_pms_text => q'~Fehler beim Mergen von Regelgruppe #1#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_MERGE_RULE_GROUP',
    p_pms_text => q'~Exception when merging rule group #1#: #SQLERRM#.~',
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE',
    p_pms_text => q'~Fehler beim Mergen von Regel #1#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_MERGE_RULE',
    p_pms_text => q'~Exception when merging rule #1#: #SQLERRM#.~',
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_ACTION',
    p_pms_text => q'~Fehler beim Mergen von Regelaktion #1#, #2#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_MERGE_RULE_ACTION',
    p_pms_text => q'~Exception when merging rule action #1#: #SQLERRM#.~',
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_EXPORT_DATA_FOUND',
    p_pms_text => q'~Keine Daten fuer Workspace "#1#" und Alias "#2#" gefunden.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN');
  
  pit_admin.translate_message(
    p_pms_name => 'SCT_NO_EXPORT_DATA_FOUND',
    p_pms_text => q'~No data found for workspace "#1#" and alias "#2#".~',
    p_pms_pml_name => 'AMERICAN'
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT',
    p_pms_text => q'^// Kein JavaScript-Code fuer Regel "#1#"^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');
    
  pit_admin.translate_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT',
    p_pms_text => q'^// No JavaScript code for rule "#1#"^',
    p_pms_pml_name => 'AMERICAN');
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_DYNAMIC_JAVASCRIPT',
    p_pms_text => q'^// Dynamisch erzeugtes JavaScript^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');
    
  pit_admin.translate_message(
    p_pms_name => 'SCT_DYNAMIC_JAVASCRIPT',
    p_pms_text => q'^// Dynamically created JavaScript^',
    p_pms_pml_name => 'AMERICAN');
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_INIT_ORIGIN',
    p_pms_text => q'~// Regel #1# (#2#), ausgeloest beim Seitenladen~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');
    
  pit_admin.translate_message(
    p_pms_name => 'SCT_INIT_ORIGIN',
    p_pms_text => q'~// Rule #1# (#2#), fired on page load~',
    p_pms_pml_name => 'AMERICAN');
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_ORIGIN',
    p_pms_text => q'~// Rekursion #1#: #2# (#3#), Ausloesendes Element: "#4#"~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');
    
  pit_admin.translate_message(
    p_pms_name => 'SCT_RULE_ORIGIN',
    p_pms_text => q'~// Recursion #1#: #2# (#3#), Firing Item: "#4#"~',
    p_pms_pml_name => 'AMERICAN');
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_text => q'~// Fehler bei #1#: #2# (#3#), Ausloesendes Element: "#4#", Führe Fehleraktionen aus~',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN');
    
  pit_admin.translate_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_text => q'~// Error at #1#: #2# (#3#), Firing Item: "#4#", proceed with error actions~',
    p_pms_pml_name => 'AMERICAN');
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_STANDARD_JS',
    p_pms_text => q'~// Standard-SCT JavaScript~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');
    
  pit_admin.translate_message(
    p_pms_name => 'SCT_STANDARD_JS',
    p_pms_text => q'~// Standard SCT JavaScript~',
    p_pms_pml_name => 'AMERICAN');
    
  commit;
  pit_admin.create_message_package;
end;
/