begin

  pit_admin.merge_message_group(
    p_pmg_name => 'SCT',
    p_pmg_description => 'Meldungen für das SCT Plugin');

  pit_admin.merge_message(
    p_pms_name => 'ALLG_PASS_INFORMATION',
    p_pms_text => q'~#1#~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );
  
  pit_admin.merge_message(
    p_pms_name => 'CONVERSION_IMPOSSIBLE',
    p_pms_text => q'~Eine Umwandlung konnte nicht ausgeführt werden~',
    p_pms_pse_id => 20,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_text => q'~APEX-Anwendung #1# existiert nicht.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_DYNAMIC_JAVASCRIPT',
    p_pms_text => q'~#1#// Dynamisch erzeugtes JavaScript~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT_ACTION',
    p_pms_text => q'~// Keine JavaScript-Aktion~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_OUTPUT_REDUCED',
    p_pms_text => q'~'// Ausgabe wegen Laenge auf Level #1# reduziert'~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_OUTPUT_CLIPPED',
    p_pms_text => q'~'// Weitere JavaScript-Aktion unterdrueckt, weil zu lang~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_text => q'~// Fehler in Rekursion #1#, Regel #2# (#3#), Ausloesendes Element: "#4#" aufgetreten, fuehre Fehlerbehandlung aus~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_text => q'~Erwartetes Format ~#1#~.~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_GENERIC_ERROR',
    p_pms_text => q'~"#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INIT_ORIGIN',
    p_pms_text => q'~// Regel #1# (#2#), ausgeloest beim Seitenladen~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER',
    p_pms_text => q'~Ungültige Zahl. Erwartetes Format ~#1#~.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_DOES_NOT_EXIST',
    p_pms_text => q'~Seitenelement #1# existiert nicht in Anwendung #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_text => q'~Element #1# ist ein Pflichtelement. Bitte tragen Sie einen Wert ein.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE',
    p_pms_text => q'~Fehler beim Mergen von Regel #1#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_ACTION',
    p_pms_text => q'~Fehler beim Mergen von Regelaktion #1#, #2#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_GROUP',
    p_pms_text => q'~Fehler beim Mergen von Regelgruppe #1#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_DATA_FOR_ITEM',
    p_pms_text => q'~Keine Daten fuer #1# gefunden.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_EXPORT_DATA_FOUND',
    p_pms_text => q'~Keine Daten fuer Workspace "#1#" und Alias "#2#" gefunden.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT',
    p_pms_text => q'~#2#// Kein JavaScript-Code fuer Regel "#1#"~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ONE_ITEM_IS_MANDATORY',
    p_pms_text => q'~Genau eines der Felder #1# und #2# ist zwingend vorzugeben.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_text => q'~APEX-Anwendungsseite #1# existiert nicht in Anwendung #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_HAS_ERRORS',
    p_pms_text => q'~Beheben Sie vor dem Versenden alle Fehler der Seite.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_text => q'~Element #1# hat Rekursionstiefe von #2# ueberschritten.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LOOP',
    p_pms_text => q'~Element #1# hat eine rekursive Schleife auf Rekursionstiefe #2# erzeugt und wurde daher ignoriert.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_text => q'~Regel #1# existiert nicht.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_ORIGIN',
    p_pms_text => q'~// Rekursion #1#: #2# (#3#), Ausloesendes Element: "#4#", Dauer: #TIME##NOTIFICATION#~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VALIDATION',
    p_pms_text => q'~Fehler bei der Validierung der Regel #1#: #2#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_text => q'~Regelgruppenview #1# wurde erstellt.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_text => q'~Regelgruppenview #1# wurde gelöscht.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_SESSION_STATE_SET',
    p_pms_text => q'~Element ~#1#~ wurde auf den Wert ~#2#~ gesetzt~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_text => q'~Unerwarteter Elementtyp ~#1#~ mit Formatmaske.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNHANDLED_EXCEPTION',
    p_pms_text => q'~Fehler beim Ausfuehren von "#1#", kann Arbeit nicht fortsetzen.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATED',
    p_pms_text => q'~Regelgruppe #1# erfolgreich erstellt~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_text => q'~Fehler beim Erstellen der Regelgruppenview #1#: #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_WHERE_CLAUSE',
    p_pms_text => q'~Fehler beim Erzeugen der WHERE-Klausel: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  commit;
  pit_admin.create_message_package;
end;
/
