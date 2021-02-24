set define off
set sqlblanklines on

begin
  
    sct_admin.merge_action_type(
    p_sat_id => 'AFTER_REFRESH',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'REFRESHABLE',
    p_sat_name => 'Ereignis "After Refresh" überwachen',
    p_sat_description => q'{<p>Registiert einen APEXAfterRefresh-Eventhandler. Wird das Ereignis ausgelöst, wird dies an SCT gemeldet und kann mit einer Regel AFTER_REFRESH = 1 gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'AFTER_REFRESH',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird SCT aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'CHECK_MANDATORY',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Pflichtfelder prüfen',
    p_sat_description => q'{<p>Pr&uuml;ft, ob alle Pflichtfelder einen Wert enthalten.</p>}',
    p_sat_pl_sql => q'{sct.check_mandatory('#ITEM#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'CHECK_MANDATORY',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Titel des Dialogfelds</p>}',
    p_sap_display_name => 'Dialogtitel',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'CHECK_MANDATORY',
    p_sap_spt_id => 'STRING_OR_PIT_MESSAGE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Meldung, die in der Bestätigungsmeldung angezeigt wird</p>}',
    p_sap_display_name => 'Meldung',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'CONFIRM_CLICK',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE_BUTTON',
    p_sat_name => 'Schaltfläche an Bestätigungsfrage binden',
    p_sat_description => q'{<p>Sorgt dafür, dass bei einem Klick auf eine Schaltfläche eine Bestätigungsmeldung gezeigt wird.<br>Nur, wenn diese Nachfrage best&auml;tigt wird, wird das Ereignis an SCT gemeldet.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.bindConfirmation('#ITEM#','#PARAM_1#', '#PARAM_2#');}',
    p_sat_is_editable => sct_util.C_TRUE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'DIALOG_CLOSED',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ereignis "Dialog Close" überwachen',
    p_sat_description => q'{<p>Registiert einen APEXAfterDialogClose-Eventhandler.<br>Wird das Ereignis ausgel&ouml;st, wird dies an SCT gemeldet und kann mit einer Regel DIALOG_CLOSED = 1 gefangen werden.</br>Ausl&ouml;sendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DIALOG_CLOSED',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird SCT aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_BUTTON',
    p_sat_stg_id => 'BUTTON',
    p_sat_sif_id => 'PAGE_BUTTON',
    p_sat_name => 'Schaltfläche deaktivieren',
    p_sat_description => q'{<p>Deaktiviert eine Schaltfl&auml;che. <br>Zum Deaktivieren eines Seitenelements verwenden Sie bitte <span style="font-family:courier new,courier,monospace">Feld deaktivieren</span>.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{apex.item('#ITEM#').disable();$('##ITEM#').removeClass('in_progress');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ziel deaktivieren',
    p_sat_description => q'{<p>Deaktiviert das referenzierte Seitenelement.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.disable('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DISABLE_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'DOUBLE_CLICK',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ereignis "Doppelklick" überwachen',
    p_sat_description => q'{<p>Registiert einen DoubleClick-Eventhandler.<br>Wird das Ereignis ausgel&ouml;st, wird dies an SCT gemeldet und kann mit einer Regel DOUBLE_CLICK = 1 gefangen werden. <br>Ausl&ouml;sendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DOUBLE_CLICK',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird SCT aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'DYNAMIC_JAVASCRIPT',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Dynamisches JavaScript ausführen',
    p_sat_description => q'{<p>Führt das übergebene JavaScript auf der Seite aus</p>}',
    p_sat_pl_sql => q'{sct.execute_javascript(q'##PARAM_1##');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DYNAMIC_JAVASCRIPT',
    p_sap_spt_id => 'FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>PL/SQL-Funktion, die eine JavaScript-Anweisung ausgibt.<br>Ohne "javascript:" verwenden, nur den JavaScript-Code ausgeben</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'EMPTY_FIELD',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM_OR_JQUERY',
    p_sat_name => 'Feld leeren',
    p_sat_description => q'{<p>Setzt den Elementwert eines Feldes auf <span style="font-family:courier new,courier,monospace">NULL</span></p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'EMPTY_FIELD',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'ENABLE_BUTTON',
    p_sat_stg_id => 'BUTTON',
    p_sat_sif_id => 'PAGE_BUTTON',
    p_sat_name => 'Schaltfläche aktivieren',
    p_sat_description => q'{<p>Aktiviert eine Schaltfl&auml;che. Zum Aktivieren eines Seitenelements verwenden Sie bitte <span style="font-family:courier new,courier,monospace">Feld anzeigen</span>.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{apex.item('#ITEM#').enable();}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'ENABLE_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'ITEM_OR_JQUERY',
    p_sat_name => 'Ziel aktivieren',
    p_sat_description => q'{<p>Deaktiviert das referenzierte Seitenelement.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.enable('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'ENABLE_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'ENTER_KEY',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Ereignis "Enter-Taste" überwachen',
    p_sat_description => q'{<p>Registiert einen Enter-Taste-Eventhandler.<br>Wird das Ereignis ausgelöst, wird dies an SCT gemeldet und kann mit einer RegelENTER_KEY = 1 gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'ENTER_KEY',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird SCT aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'EXECUTE_APEX_ACTION',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Befehl ausführen',
    p_sat_description => q'{<p>Führt einen Befehl aus, der vorab als APEX-Aktion angelegt worden sein muss.</p>}',
    p_sat_pl_sql => q'{sct.execute_apex_action('#PARAM_1#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'EXECUTE_APEX_ACTION',
    p_sap_spt_id => 'APEX_ACTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'GET_SEQ_VAL',
    p_sat_stg_id => 'PL_SQL',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Sequenzwert ermitteln',
    p_sat_description => q'{<p>Setzt das referenzierte Element auf einen neuen Sequenzwert.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#',#PARAM_1#.nextval, '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'GET_SEQ_VAL',
    p_sap_spt_id => 'SEQUENCE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Name der Sequenz</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'HIDE_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ziel ausblenden',
    p_sat_description => q'{<p>Blendet das referenzierte Seitenelement aus.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.hide('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'HIDE_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_DATE',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld enthält Datum',
    p_sat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld ein Datum enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>}',
    p_sat_pl_sql => q'{sct.check_date('#ITEM#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'IS_MANDATORY',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld ist Pflichtfeld',
    p_sat_description => q'{<p>Macht ein Seitenelement zu einem Pflichtfeld inkl. Validierung.</p>}',
    p_sat_pl_sql => q'{sct.register_mandatory('#ITEM#','#PARAM_1#', true, '#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.setMandatory('#SELECTOR#', true);\CR\}' || 
q'{  de.condes.plugin.sct.show('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'IS_MANDATORY',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'IS_MANDATORY',
    p_sap_spt_id => 'STRING_OR_PIT_MESSAGE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{Fehlermeldung kann optional &uuml;bergeben werden, ansonsten wird eine Standardmeldung verwendet.}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_NUMERIC',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld enthält Zahl',
    p_sat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld einen numerischen Wert enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>}',
    p_sat_pl_sql => q'{sct.check_number('#ITEM#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'IS_OPTIONAL',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld ist optional',
    p_sat_description => q'{<p>Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.</p>}',
    p_sat_pl_sql => q'{sct.register_mandatory('#ITEM#', null, false,'#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.setMandatory('#SELECTOR#',false);}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'IS_OPTIONAL',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'ITEM_NULL_SHOW',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld leeren und aktivieren',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf NULL und zeigt es auf der Seite an.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.enable('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'ITEM_NULL_SHOW',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'JAVA_SCRIPT_CODE',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'JavaScript-Code ausführen',
    p_sat_description => q'{<p>F&uuml;hrt den als Parameter &uuml;bergebenen JavaScript-Code aus.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{#PARAM_1#;}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'JAVA_SCRIPT_CODE',
    p_sap_spt_id => 'JAVA_SCRIPT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>JavaScript-Anweisung, die ausgef&uuml;hrt werden soll. (ohne Semikolon)</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'NOTIFY',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Benachrichtigung zeigen',
    p_sat_description => q'{<p>Zeigt eine Nachricht auf der Anwendungsseite</p>}',
    p_sat_pl_sql => q'{sct.notify(#PARAM_1#);}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'NOTIFY',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Meldungstext</p>}',
    p_sap_display_name => 'Meldung',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'NOT_NULL',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Mindestens einen Wert wählen',
    p_sat_description => q'{<p>Stellt sicher, dass mindestens eines der Elemente aus Attribut 1 einen Wert enthält.</p>}',
    p_sat_pl_sql => q'{sct.not_null('#ITEM#', '#PARAM_1#',#PARAM_2);}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'NOT_NULL',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'NOT_NULL',
    p_sap_spt_id => 'PIT_MESSAGE',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung misslingt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'PLSQL_CODE',
    p_sat_stg_id => 'PL_SQL',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'PL/SQL-Code ausführen',
    p_sat_description => q'{<p>F&uuml;hrt den als Parameter &uuml;bergebenen PL/SQL-Code aus.</p>}',
    p_sat_pl_sql => q'{sct.execute_plsql('#PARAM_1#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'PLSQL_CODE',
    p_sap_spt_id => 'PROCEDURE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>PL/SQL-Code, der ausgef&uuml;hrt werden soll.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld aktualisieren und Wert setzen',
    p_sat_description => q'{<p>Aktualisiert ein Seitenelement und setzt das Feld auf den Sessionstatus</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.refreshAndSetValue('#ITEM#', #PARAM_1#);}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sap_spt_id => 'STRING_OR_JAVASCRIPT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{''}',
    p_sap_description => q'{<p>Wert, der gesetzt werden soll.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ziel aktualisieren (Refresh)',
    p_sat_description => q'{<p>Löst auf dem referenzierten Seitenelement einen APEX-Refresh aus.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.refresh('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'REGISTER_ITEM',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld-Event auslösen',
    p_sat_description => q'{<p>Löst einen CHANGE-Event auf das angegebene Feld aus und sorgt für die Abarbeitung der zugehörigen Regeln</p>}',
    p_sat_pl_sql => q'{sct.register_item('#ITEM#', '#ALLOW_RECURSION#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'REGISTER_OBSERVER',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld beobachten',
    p_sat_description => q'{<p>Aktion beobachtet ein Feld oder eine Klasse und registriert die Elemente so, dass die entsprechenden Elementwerte bei jedem Ereignis auf der Seite in den Sessionstatus kopiert werden.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'REGISTER_OBSERVER',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_CONSOLE',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Nachricht auf Console ausgeben',
    p_sat_description => q'{<p>In die Console der Developer-Tools wird eine Nachricht geschrieben.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{console.log(#PARAM_1#);}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_CONSOLE',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Meldungstext</p>}',
    p_sap_display_name => 'Nachricht',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ELEMENT_FROM_STMT',
    p_sat_stg_id => 'PL_SQL',
    p_sat_sif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_sat_name => 'Elementwert mit SQL-Anweisung setzen',
    p_sat_description => q'{<p>Setzt einen Elementwert basierend auf einer SQL-Anweisung, die einen einzelnen Wert zurückgibt.</p>}',
    p_sat_pl_sql => q'{sct.set_value_from_stmt('#ITEM#',q'##PARAM_1##');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_ELEMENT_FROM_STMT',
    p_sap_spt_id => 'SQL_STATEMENT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>SQL-Anweisung, die einen oder mehrere Werte zurückgibt</br>Die Spaltenbezeichner m&uuml;ssen Elementnamen entsprechen, die Abfrageergebnisse werden in den zugehoerigen Seitenelementen gesetzt</dd>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_FOCUS',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Focus in Feld setzen',
    p_sat_description => q'{<p>Fokus in Eingabefeld der Seite setzen</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{$('##SELECTOR#').focus();}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'SET_ITEM',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld auf Wert setzen',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf den als Parameter übergebenen Wert.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', #PARAM_1#, '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_ITEM',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Elementwert.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_DISABLE',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld leeren und deaktivieren',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und deaktiviert es auf der Seite.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.disable('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_NULL_DISABLE',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_HIDE',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld leeren und ausblenden',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und blendet es auf der Seite aus.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.hide('#SELECTOR#');de.condes.plugin.sct.setMandatory('#SELECTOR#', false);}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_NULL_HIDE',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_VALUE_ONLY',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld auf Wert setzen, keine Rekursion auslösen',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf den &uuml;bergebenen Wert, ohne weitere Rekursionen auszul&ouml;sen</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#','#PARAM_1#', 0, '#PARAM_2#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_VALUE_ONLY',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_VALUE_ONLY',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Elementwert</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ERROR',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_sat_name => 'Fehler anzeigen',
    p_sat_description => q'{<p>Zeigt die als Parameter übergebene Fehlermeldung auf der Seite.</p>}',
    p_sat_pl_sql => q'{sct.register_error('#ITEM#', '#PARAM_1#','');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SHOW_ERROR',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Elementwert</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ziel anzeigen',
    p_sat_description => q'{<p>Blendet das referenzierte Seitenelement auf der Seite ein.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.show('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SHOW_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_TIP',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Hinweis anzeigen',
    p_sat_description => q'{<p>In der Meldungsregion einen Hinweis anzeigen</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{drv.ek.sct.setNotification('#PARAM_1#');}',
    p_sat_is_editable => sct_util.C_TRUE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SHOW_TIP',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Elementwert</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'STOP_RULE',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Regel stoppen',
    p_sat_description => q'{<p>Beendet die aktuell laufende Regel und erlaubt keine rekursive Ausführung weiterer Regeln.</p>}',
    p_sat_pl_sql => q'{sct.stop_rule;}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Seite absenden',
    p_sat_description => q'{<p>Prüft alle Pflichtfelder und löst die Weiterlietung der Seite aus.</p>}',
    p_sat_pl_sql => q'{sct.submit_page;}',
    p_sat_js => q'{de.condes.plugin.sct.submit('#PARAM_1#','#PARAM_2#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT',
    p_sap_spt_id => 'PIT_MESSAGE',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung der Seite  misslingt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>REQUEST-Wert, kann optional &uuml;bergeben werden, ansonsten wird SUBMIT verwendet.</p>}',
    p_sap_display_name => 'Request',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT_WO_VALIDATION',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Seite absenden, keine Validierung',
    p_sat_description => q'{<p>L&ouml;st die Weiterleitung der Seite ohne vorherige Validierung aus.</p>}',
    p_sat_pl_sql => q'{sct.submit_page(false);}',
    p_sat_js => q'{de.condes.plugin.sct.submit('#PARAM_1#','#PARAM_2#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT_WO_VALIDATION',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'TOGGLE_ITEMS',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Ziele ein- und ausblenden',
    p_sat_description => q'{<p>Kontrolliert die Anzeige mehrerer Seitenelemente, indem die Seitzenelemente, die durch den ersten Parameter identifiziert werden, ein- und die Seitenelemente, die durch den zweiten Parameter identifiziert werden, ausgeblendet werden</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.hide('#PARAM_2#');\CR\}' || 
q'{  de.condes.plugin.sct.show('#PARAM_1#');}',
    p_sat_is_editable => sct_util.C_TRUE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'TOGGLE_ITEMS',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>jQuery-Selektor, der die Seitenelemente identifiziert, die eingeblendet werden sollen.</p>}',
    p_sap_display_name => 'Einzublendende Seitenelemente',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'TOGGLE_ITEMS',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>jQuery-Selektor, der die Seitenelemente identifiziert, die ausgeblendet werden sollen.</p>}',
    p_sap_display_name => 'Auszublendende Seitenelemente',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'VALIDATE',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Seite validieren',
    p_sat_description => q'{<p>Prüft alle Pflichtfelder, löst aber keine Weiterleitung der Seite aus.</p>}',
    p_sat_pl_sql => q'{sct.submit_page;}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'WAIT_FOR_REFRESH',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'REFRESHABLE',
    p_sat_name => 'Eieruhr zeigen, bis APEX-Refresh erfolgreich',
    p_sat_description => q'{<p>Sorgt dafür, dass auf der Seite eine Eieruhr eingeblendet wird, bis eine APEX-Refresh-Aktion erfolgreich abgeschlossen wurde.<br>Als Seitenelement muss die Region/das Element angegeben werden, auf dessen Aktuialisierung gewartet wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{drv.ek.waitUntilRefresh('#ITEM#');}',
    p_sat_is_editable => sct_util.C_TRUE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'XOR',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Genau einen Wert wählen',
    p_sat_description => q'{<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält.</p> <dl><dt>Parameter 1</dt><dd>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Pr&uuml;fen der Werte entweder genau ein Feld einen NOT NULL-Wert besitzen, oder alle Werte m&uuml;ssen leer sein</dd> <dt>Parameter 2</dt><dd>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</dd></dl> }',
    p_sat_pl_sql => q'{sct.xor('#ITEM#', '#PARAM_1#', #PARAM_2#, false);}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'XOR_NN',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Genau einen Wert wählen, NOT_NULL',
    p_sat_description => q'{<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält. NULL wird nicht zugelassen</p> </p><dl><dt>Parameter 1</dt><dd>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Pr&uuml;fen der Werte genau ein Feld einen NOT NULL-Wert besitzen.<br>Sind alle Elemente NULL oder sind mehr al ein Element NOT NULL, wird ein Fehler geworfen</dd> <dt>Parameter 2</dt><dd>Medlungsname, der ausgegeben werden soll, falls die Pr&uuml;fung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</dd></dl> }',
    p_sat_pl_sql => q'{sct.xor('#ITEM#', '#PARAM_1#', #PARAM_2#, true);}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR_NN',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  commit;
end;
/

set define on
set sqlblanklines off