begin

  pit_admin.merge_message_group(
    p_pmg_name => 'SCT',
    p_pmg_description => 'Meldungen für das SCT Plugin');
    
  pit_admin.merge_message_group(
    p_pmg_name => 'ALLG',
    p_pmg_description => 'Allgemeine Meldungen');

  pit_admin.merge_message(
    p_pms_name => 'ALLG_PASS_INFORMATION',
    p_pms_pmg_name => 'ALLG',
    p_pms_text => q'~Ungültiges Datum: #1#~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );


  pit_admin.merge_message(
    p_pms_name => 'INVALID_DATE',
    p_pms_pmg_name => 'ALLG',
    p_pms_text => q'~Ungültiges Datum: #1#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -1858
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DATE_FORMAT',
    p_pms_pmg_name => 'ALLG',
    p_pms_text => q'~Ungültiges Datumsformat: #1#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -1861
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_DAY',
    p_pms_pmg_name => 'ALLG',
    p_pms_text => q'~#1#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -1847
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_MONTH',
    p_pms_pmg_name => 'ALLG',
    p_pms_text => q'~#1#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -1843
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_NUMBER_FORMAT',
    p_pms_pmg_name => 'ALLG',
    p_pms_text => q'~Ungültiges Zahlformat: #1#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -1481
  );

  pit_admin.merge_message(
    p_pms_name => 'INVALID_YEAR',
    p_pms_pmg_name => 'ALLG',
    p_pms_text => q'~#1#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -1841
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~APEX-Anwendung #1# existiert nicht.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Erwartetes Format "#1#".~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_GENERIC_ERROR',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~"#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_CLOB_JS_SCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => '#1#',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Seitenelement "#1#" existiert nicht in Anwendung #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Element "#1#" ist ein Pflichtelement. Bitte tragen Sie einen Wert ein.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~APEX-Anwendungsseite #1# existiert nicht in Anwendung #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_HAS_ERRORS',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Beheben Sie vor dem Versenden alle Fehler der Seite.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Element "#1#" hat Rekursionstiefe #2# ueberschritten.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LOOP',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Element "#1#" hat eine rekursive Schleife auf Rekursionstiefe #2# erzeugt und wurde daher ignoriert.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Regel #1# existiert nicht.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VALIDATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Fehler bei der Validierung der Regel #1#: #2#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Regelgruppenview "#1#" wurde erstellt.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Regelgruppenview "#1#" wurde geloescht.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_SESSION_STATE_SET',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Element "#1#" wurde auf den Wert "#2#" gesetzt~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Unerwarteter Elementtyp "#1#" mit Formatmaske.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Regelgruppenview "#1#" erfolgreich erstellt~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Fehler beim Erstellen der Regelgruppenview "#1#": #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_DATA_FOR_ITEM',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Keine Daten fuer "#1#" gefunden.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_WHERE_CLAUSE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Fehler beim Erzeugen der WHERE-Klausel: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_GROUP',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Fehler beim Mergen von Regelgruppe #1#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Fehler beim Mergen von Regel #1#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_ACTION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Fehler beim Mergen von Regelaktion #1#, #2#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_EXPORT_DATA_FOUND',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Keine Daten fuer Workspace "#1#" und Alias "#2#" gefunden.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Kein JavaScript-Code fuer Regel "#1#"^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_DYNAMIC_JAVASCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Dynamisch erzeugtes JavaScript^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_INIT_ORIGIN',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Regel #1# (#2#), ausgeloest beim Seitenladen~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_ORIGIN',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Rekursion #1#: #2# (#3#), Ausloesendes Element: "#4#"~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Fehler bei #1#: #2# (#3#), Ausloesendes Element: "#4#", Führe Fehleraktionen aus~',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_STANDARD_JS',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Standard-SCT JavaScript~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_INITIALZE_SGR_FAILED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Fehler bei der Initialisierung der Regelgruppe #1#: #2#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_INITIALZE_SRU_FAILED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Fehler bei der Initialisierung der Einzelregel #1#: #2#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_RULE_GROUP_FOUND',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Keine Daten für Workspace #1# und Anwendung #2# gefunden~',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN'
  );
    
  commit;
  pit_admin.create_message_package;
end;
/
