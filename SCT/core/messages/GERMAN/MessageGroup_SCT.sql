begin

  pit_admin.merge_message_group(
    p_pmg_name => 'SCT',
    p_pmg_description => q'^Meldungen für das SCT Plugin^');

  pit_admin.merge_message(
    p_pms_name => 'ALLG_PASS_INFORMATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ACTION_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^SCT-Aktion #1# existiert nicht.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^APEX-Anwendung #1# existiert nicht.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_CLOB_JS_SCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_DEBUG_RULE_STMT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Regel-SQL: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_DYNAMIC_JAVASCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^#1#// Dynamisch erzeugtes JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Fehler in Rekursion #1#, Regel #2# (#3#), Ausloesendes Element: "#4#" aufgetreten, fuehre Fehlerbehandlung aus^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Erwartetes Format ~#1#~.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_GENERIC_ERROR',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^"#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INITIALZE_SGR_FAILED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Fehler bei der Initialisierung der Regelgruppe #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INITIALZE_SRU_FAILED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Fehler bei der Initialisierung der Einzelregel #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INIT_ORIGIN',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Regel #1# (#2#), ausgeloest beim Seitenladen^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INTERNAL_ERROR',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Ein Fehler ist auf der Seite aufgetreten: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Ungültige Zahl. Erwartetes Format ~#1#~.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER_REMOVED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Ungültige Zahl entfernt: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Seitenelement #1# existiert nicht in Anwendung #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Element #LABEL# ist ein Pflichtelement. Bitte tragen Sie einen Wert ein.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Fehler beim Mergen von Regel #1#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_ACTION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Fehler beim Mergen von Regelaktion #1#, #2#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_GROUP',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Fehler beim Mergen von Regelgruppe #1#: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_DATA_FOR_ITEM',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Keine Daten fuer #1# gefunden.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_EXPORT_DATA_FOUND',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Keine Daten fuer Workspace "#1#" und Alias "#2#" gefunden.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^#2#// Kein JavaScript-Code fuer Regel "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT_ACTION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Keine JavaScript-Aktion^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_RULE_GROUP_FOUND',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Keine Daten für Workspace #1# und Anwendung #2# gefunden^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ONE_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Genau eines der Felder #1# und #2# ist zwingend vorzugeben.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_OUTPUT_CLIPPED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^'// Weitere JavaScript-Aktion unterdrueckt, weil zu lang^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_OUTPUT_REDUCED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^'// Ausgabe wegen Laenge auf Level #1# reduziert'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^APEX-Anwendungsseite #1# existiert nicht in Anwendung #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_HAS_ERRORS',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Beheben Sie vor dem Versenden alle Fehler der Seite.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_PARAM_LOV_INCORRECT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Die LOV-View #1# hat nicht die vorgegebenen Spalten D, R und SGR_ID.^',
    p_pms_description => q'^Damit eine LOV-View genutzt werden kann, muss sie über genau 3 Spalten mit den Bezeichnern D, R und SGR_ID verfügen.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_PARAM_LOV_MISSING',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Der Parametertyp #1# erfordert eine LOV-View des Namens #2#. Diese fehlt.^',
    p_pms_description => q'^Ein Parametertyp, der eine LOV-Liste benötigt, erfordert eine entsprechende LOV-View, damit die erforderlichen Daten ermittelt werden können.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_PARAM_MISSING',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Feld #LABEL# ist ein Pflichtfeld.^',
    p_pms_description => q'^Das Eingaefeld ist ein Pflichtparameter und muss daher belegt werden.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_PROCESSING_RULE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Erzeuge Aktion für Regel #1# (#2#)^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Element #1# hat Rekursionstiefe von #2# ueberschritten.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LOOP',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Element #1# hat eine rekursive Schleife auf Rekursionstiefe #2# erzeugt und wurde daher ignoriert.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Regel #1# existiert nicht.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_ORIGIN',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Rekursion #1#: #2# (#3#), Ausloesendes Element: "#4#", Dauer: #TIME##NOTIFICATION#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VALIDATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Fehler bei der Validierung der Regel #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Regelgruppenview #1# wurde erstellt.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Regelgruppenview #1# wurde gelöscht.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_SESSION_STATE_SET',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Element ~#1#~ wurde auf den Wert ~#2#~ gesetzt^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_SGR_MUS_BE_UNIQUE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Der Name der Regelgruppe muss für diese Anwendung eindeutig sein.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_SGR_MUST_BE_UNIQUE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Die Regelgruppe existiert bereits. Wählen Sie einen eindeutigen Namen.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_STANDARD_JS',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Standard-SCT JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_TARGET_EQUALS_SOURCE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Regelgruppe #1# ist bereits auf Anwendung #2#, Seite #3# und kann nicht über sich selbst kopiert werden.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Unerwarteter Elementtyp ~#1#~ mit Formatmaske.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNHANDLED_EXCEPTION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Fehler beim Ausfuehren von "#1#", kann Arbeit nicht fortsetzen.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNKNOWN_EXPORT_MODE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Der Exporttyp #1# ist unbekannt.^',
    p_pms_description => q'^Es wurde ein nicht unterstützter Exporttyp angefordert. Verwenden Sie nur die Konstanten C_%_GROUP(S).^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNKNOWN_SPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Unbekannter Parametertyp: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Regelgruppe #1# erfolgreich erstellt^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Fehler beim Erstellen der Regelgruppenview #1#: #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_WHERE_CLAUSE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Fehler beim Erzeugen der WHERE-Klausel: #SQLERRM#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/