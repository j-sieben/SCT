set define ^

declare
  l_foo number;
begin
  l_foo := sct_admin.map_id;

  -- ACTION TYPES
  sct_admin.merge_action_type(
    p_sat_id => 'CHECK_MANDATORY',
    p_sat_name => 'Pflichtfeld prüfen',
    p_sat_description => q'~<p>Pr&uuml;ft, ob alle Pflichtfelder einen Wert enthalten.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.check_mandatory('#ITEM#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_ITEM',
    p_sat_name => 'Ziel deaktivieren',
    p_sat_description => q'~<p>Deaktiviert das referenzierte Seitenelement.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();
apex.item('#ITEM#').disable();~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'EMPTY_FIELD',
    p_sat_name => 'Feld leeren',
    p_sat_description => q'~<p>Setzt den Elementwert eines Feldes auf <span style="font-family:courier new,courier,monospace">NULL</span></p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '', #ALLOW_RECURSION#);~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'GET_SEQ_VAL',
    p_sat_name => 'Sequenzwert ermitteln',
    p_sat_description => q'~<p>Setzt das referenzierte Element auf einen neuen Sequenzwert.</p>

<p><em>Parameter</em>: Name der Sequenz muss &uuml;bergeben werden.</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', #ATTRIBUTE#.nextval, #ALLOW_RECURSION#);~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'HIDE_ITEM',
    p_sat_name => 'Ziel ausblenden',
    p_sat_description => q'~<p>Blendet das referenzierte Seitenelement aus.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_MANDATORY',
    p_sat_name => 'Feld ist Pflichtfeld',
    p_sat_description => q'~<p>Macht ein Seitenelement zu einem Pflichtfeld inkl. Validierung.</p>

<p><em>Parameter</em>: Fehlermeldung kann optional &uuml;bergeben werden, ansonsten wird eine Standardmeldung verwendet..</p>
~',
    p_sat_pl_sql => q'~plugin_sct.register_mandatory('#ITEM#', '#ATTRIBUTE#', true);~',
    p_sat_js => q'~de.condes.plugin.sct.setMandatory('#ITEM#', true);~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_OPTIONAL',
    p_sat_name => 'Feld ist optional',
    p_sat_description => q'~<p>Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.</p>

<p><em>Parameter</em>: Keine.</p>
~',
    p_sat_pl_sql => q'~plugin_sct.register_mandatory('#ITEM#', '#ATTRIBUTE#', false);~',
    p_sat_js => q'~de.condes.plugin.sct.setMandatory('#ITEM#', false);~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'ITEM_NULL_SHOW',
    p_sat_name => 'Feld leeren und aktivieren',
    p_sat_description => q'~<p>Setzt das referenzierte Seitenelement auf NULL und aktiviert es auf der Seite aus.</p>

<p>Parameter: <em>Keine</em></p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '', #ALLOW_RECURSION#);~',
    p_sat_js => q'~de.condes.plugin.sct.enable('#ITEM#');~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'JAVA_SCRIPT_CODE',
    p_sat_name => 'JavaScript-Code ausführen',
    p_sat_description => q'~<p>F&uuml;hrt den als Parameter &uuml;bergebenen JavaScript-Code aus.</p>

<p><em>Parameter</em>: JavaScript-Anweisung, die ausgef&uuml;hrt werden soll. (ohne Semikolon)</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~#ATTRIBUTE#;~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'NOTIFY',
    p_sat_name => 'Benachrichtigung zeigen',
    p_sat_description => q'~<p>Zeigt eine Nachricht auf der Anwendungsseite</p>

<p><em>Parameter</em>: Der Meldungstext wird als erster Parameter &uuml;bergeben. Statische Texte ben&ouml;tigen Hochkommata</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~de.condes.plugin.sct.notify(#ATTRIBUTE#);~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'PLSQL_CODE',
    p_sat_name => 'PL/SQL-Code ausführen',
    p_sat_description => q'~<p>F&uuml;hrt den als Parameter &uuml;bergebenen PL/SQL-Code aus.</p>

<p><em>Parameter</em>: PL/SQL-Code, der ausgef&uuml;hrt werden soll. (mit Semikolon)</p>
~',
    p_sat_pl_sql => q'~begin #ATTRIBUTE# end;~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sat_name => 'Feld aktualisieren und Wert setzen',
    p_sat_description => q'~<p>Aktualisiert ein Seitenelement und setzt das Feld auf den Sessionstatus</p>

<p><em>Parameter</em>: Parameter 1 kann folgende Werte enthalten</p>

<ul>
<li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li>
<li>Ein JavaScript-Ausdruck, der zur Laufzeit berechnet wird</li>
<li>Leere Zeichenkette (&#39;&#39;). In diesem Fall wird der Wert des Sessionstatus verwendet (dieser kann vorab berechnet werden)</li>
</ul>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~de.condes.plugin.sct.refreshAndSetValue('#ITEM#', #ATTRIBUTE#);~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_ITEM',
    p_sat_name => 'Ziel aktualisieren (Refresh)',
    p_sat_description => q'~<p>L&ouml;st auf dem referenzierten Seitenelement einen APEX-Refresh aus.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~de.condes.plugin.sct.refresh('#ITEM#');~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_CONSOLE',
    p_sat_name => 'Nachricht auf Konsole ausgeben',
    p_sat_description => q'~<p>In die Console der Developer-Tools wird eine Nachricht geschrieben.</p>

<p><em>Parameter:</em> Nachricht (Eingabe mit Hochkomma erforderlich)</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~console.log(#ATTRIBUTE#);~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_FOCUS',
    p_sat_name => 'Focus in Feld setzen',
    p_sat_description => q'~<p>Fokus in Element setzen</p>

<p><em>Parameter</em><span style="font-family:helvetica neue,segoe ui,helvetica,arial,sans-serif; font-size:15.36px">: keine.</span></p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~$('##ITEM#').focus();~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ITEM',
    p_sat_name => 'Feld auf Wert setzen',
    p_sat_description => q'~<p>Setzt das referenzierte Seitenelement auf den als Parameter &uuml;bergebenen Wert.</p>

<p><em>Parameter</em>: Wert des Elements oder Funktion, die Wert liefert. Zeichenketten ben&ouml;tigen Hochkommata.</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', #ATTRIBUTE#, #ALLOW_RECURSION#);~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_DISABLE',
    p_sat_name => 'Feld leeren und deaktivieren',
    p_sat_description => q'~<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und deaktiviert es auf der Seite aus.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '', #ALLOW_RECURSION#);~',
    p_sat_js => q'~de.condes.plugin.sct.disable('#ITEM#');~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_HIDE',
    p_sat_name => 'Feld leeren und ausblenden',
    p_sat_description => q'~<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und blendet es auf der Seite.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '', #ALLOW_RECURSION#);~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_SESSION_STATE',
    p_sat_name => 'Wert des Feldes in SessionState schreiben',
    p_sat_description => q'~<p>Wert des Elementes in den Session State eintragen</p>

<p><em>Parameter</em><span style="font-family:helvetica neue,segoe ui,helvetica,arial,sans-serif; font-size:15.36px">: keine.</span></p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.server.process ( "SAVE_HIDDEN_VALUE_IN_SESSION_STATE", { x01: "set_session_state", pageItems: '#' + '#ITEM#'}, {dataType: 'text'});~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_VALUE_ONLY',
    p_sat_name => 'Feld auf Wert setzen, keine Rekursion auslösen',
    p_sat_description => q'~<p>Setzt das referenzierte Seitenelement auf den &uuml;bergebenen Wert, ohne weitere Rekursionen auszul&ouml;sen</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '#ATTRIBUTE#', #ALLOW_RECURSION#);~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ERROR',
    p_sat_name => 'Fehler anzeigen',
    p_sat_description => q'~<p>Zeigt die als Parameter Übergebene Fehlermeldung auf der Seite.</p>

<p><em>Parameter</em>: Text der Fehlermeldung</p>
~',
    p_sat_pl_sql => q'~plugin_sct.register_error('#ITEM#', '#ATTRIBUTE#', '');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ITEM',
    p_sat_name => 'Ziel anzeigen',
    p_sat_description => q'~<p>Blendet das referenzierte Seitenelement auf der Seite ein.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~de.condes.plugin.sct.enable('#ITEM#');~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'STOP_RULE',
    p_sat_name => 'Regel stoppen',
    p_sat_description => q'~<p>Beendet die aktuell laufende Regel und erlaubt keine rekursive Ausf&uuml;hrung weiterer Regeln.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.stop_rule;~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT',
    p_sat_name => 'Seite absenden',
    p_sat_description => q'~<p>Pr&uuml;ft alle Pflichtfelder und l&ouml;st SUBMIT der Seite aus.</p>
<p><em>Parameter</em>:</p>
<ul>
	<li><span style="font-family:courier new,courier,monospace">REQUEST </span>kann optional &uuml;bergeben werden, ansonsten wird <span style="font-family:courier new,courier,monospace">SUBMIT </span>verwendet.</li>
	<li><span style="font-family:courier new,courier,monospace">MESSAGE </span>wird verwendet, um die Nachricht auf der Seite zu definieren.</li>
</ul>~',
    p_sat_pl_sql => q'~plugin_sct.submit_page;~',
    p_sat_js => q'~de.condes.plugin.sct.submit('#ATTRIBUTE#', '#ATTRIBUTE_2#');~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);
    
  sct_admin.merge_action_type(
    p_sat_id => 'DYNAMIC_JAVASCRIPT',
    p_sat_name => 'Dynamisches JavaScript ausführen',
    p_sat_description => q'~<p>Führt das übergebene JavaScript auf der Seite aus</p>
<p><em>Parameter</em>: PL/SQL-Funktion, die eine JavaScript-Anweisung ausgibt. Ohne javascript: verwenden, nur den JavaScript-Code ausgeben</p>~',
    p_sat_pl_sql => q'~plugin_sct.execute_javascript('#ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);


  commit;
end;
/
set define &
