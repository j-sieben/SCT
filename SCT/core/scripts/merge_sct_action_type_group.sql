set define off
set sqlblanklines on

begin
  sct_admin.merge_action_type_group(
    p_spt_id => 'APEX_ACTION',
    p_spt_name => 'APEX-Aktion',
    p_spt_description => q'{Existierende APEX-Aktion der Regelgruppe}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'FUNCTION',
    p_spt_name => 'PL/SQL-Funktion',
    p_spt_description => q'{Eine bestehende PL/SQL-Funktion}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'JAVA_SCRIPT',
    p_spt_name => 'JavaScript-Ausdruck',
    p_spt_description => q'{Ausführbarer JavaScript-Ausdruck}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_spt_name => 'JavaScript-Funktion',
    p_spt_description => q'{Name einer JavaScript-Funktion oder anonyme Funktionsdefinition}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'JQUERY_SELECTOR',
    p_spt_name => 'jQuery-Selektor',
    p_spt_description => q'{jQuery-Selektor, Setzt voraus, dass als Anwendungselement DOCUMENTgewählt wurde.}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'PAGE_ITEM',
    p_spt_name => 'Seitenelement',
    p_spt_description => q'{Seitenelement oder Region der aktuellen Seite}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'PIT_MESSAGE',
    p_spt_name => 'Name der Meldung',
    p_spt_description => q'{Bezeichner einer PIT-Meldung in der Form msg.NAMEoder 'NAME', muss eine existierende Meldung sein.}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'PROCEDURE',
    p_spt_name => 'PL/SQL-Prozedur',
    p_spt_description => q'{Eine bestehende PL/SQL-Prozedur}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'SEQUENCE',
    p_spt_name => 'Sequenz',
    p_spt_description => q'{Name einer existierenden Sequenz}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'SQL_STATEMENT',
    p_spt_name => 'SQL-Anweisung',
    p_spt_description => q'{Ausführbare SQL-Anweisung}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING',
    p_spt_name => 'Zeichenkette',
    p_spt_description => q'{Einfache Zeichenkette, wird mit Hochkommata umgeben, daher ist die Eingabe dieser Zeichen nicht erforderlich}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING_OR_FUNCTION',
    p_spt_name => 'Zeichenkette oder PL/SQL-Funktion',
    p_spt_description => q'{Falls nicht mit Hochkommata eingeschlossen, eine bestehende PL/SQL-Funktion}',
    p_spt_active => sct_rule.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING_OR_JAVASCRIPT',
    p_spt_name => 'Zeichenkette oder JS-Ausdruck',
    p_spt_description => q'{Falls nicht mit Hochkommata eingeschlossen, ein JavaScript-Ausdruck}',
    p_spt_active => sct_rule.C_TRUE);

    sct_admin.merge_action_type_group(
    p_stg_id => 'BUTTON',
    p_stg_name => 'Schaltlfäche',
    p_stg_description => q'{Aktionen für Schaltflächen}',
    p_stg_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'ITEM',
    p_stg_name => 'Seitenelemente',
    p_stg_description => q'{Aktionen für Eingabefelder}',
    p_stg_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'JAVA_SCRIPT',
    p_stg_name => 'JavaScript',
    p_stg_description => q'{JavaScript-Funkionen und Events}',
    p_stg_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'PAGE_ITEM',
    p_stg_name => 'Seitenelement',
    p_stg_description => q'{Aktionen für allgemeine Seitenelemente}',
    p_stg_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'PL_SQL',
    p_stg_name => 'PL/SQL',
    p_stg_description => q'{PL/SQ-Funktionen}',
    p_stg_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'SCT',
    p_stg_name => 'Framework',
    p_stg_description => q'{Allgemeine Aktionen}',
    p_stg_active => sct_rule.C_TRUE);

    sct_admin.merge_action_type(
    p_sat_id => 'SET_CONSOLE',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Nachricht auf Console ausgeben',
    p_sat_description => q'{<p>In die Console der Developer-Tools wird eine\CR\}' || 
q'{Nachricht geschrieben.</p>\CR\}' || 
q'{<p><em>Parameter:</em> Nachricht (Eingabe mit Hochkomma erforderlich)</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{console.log(#PARAM_1#);}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_CONSOLE',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ELEMENT_FROM_STMT',
    p_sat_stg_id => 'PL_SQL',
    p_sat_name => 'Elementwert mit SQL-Anweisung setzen',
    p_sat_description => q'{<p>Setzt einen Elementwert basierend auf einer\CR\}' || 
q'{SQL-Anweisung, die einen einzelnen Wert zurückgibt.</p>\CR\}' || 
q'{<p><em>Parameter</em>: SQL-Anweisung, die einen einzelnen Wert in einer\CR\}' || 
q'{Spalte namens VALUE zurückgibt</p>\CR\}' || 
q'{<p>Zwei Anwendungsmodi:</p>\CR\}' || 
q'{<dl><dt> P_ITEM ist auf Elementnamen gesetzt (Ersetzungsanker #ITEM#,\CR\}' || 
q'{entspricht SEITENELEMENT in Aktion)</dt>\CR\}' || 
q'{<dd> In diesem Modus darf die Anweisung nur eine Spalte zurueckliefern, der\CR\}' || 
q'{Wert wird in das uebergebene Element gesetzt</dd>\CR\}' || 
q'{<dt>P_ITEM ist DOCUMENT oder NULL</dt>\CR\}' || 
q'{<dd>In diesem Modus darf die Anweisung mehrere Spalten liefern. Die\CR\}' || 
q'{Spaltenbezeichner muessen Elementnamen entsprechen, die Abfrageergebnisse\CR\}' || 
q'{werden in den zugehoerigen Seitenelementen gesetzt</dd>\CR\}' || 
q'{<p>Format:</p><p>Die SQL-Anweisung wird so &uuml;bergeben, wie sie im\CR\}' || 
q'{SQL-Developer geschrieben würde. Kein abschließendes Semikolon\CR\}' || 
q'{erforderlich.</p>}',
    p_sat_pl_sql => q'{plugin_sct.set_value_from_stmt('#ITEM#',q'##PARAM_1##');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_ELEMENT_FROM_STMT',
    p_sap_spt_id => 'SQL_STATEMENT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_FOCUS',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Focus in Feld setzen',
    p_sat_description => q'{<p>Fokus in Element setzen</p>\CR\}' || 
q'{<p><em>Parameter</em><span style="font-family:helvetica neue,segoe\CR\}' || 
q'{ui,helvetica,arial,sans-serif; font-size:15.36px">: keine.</span></p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{$('##SELECTOR#').focus();}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'SET_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld auf Wert setzen',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf\CR\}' || 
q'{den als Parameter übergebenen Wert.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Wert des Elements oder Funktion, die Wert liefert.\CR\}' || 
q'{Zeichenketten benötigen Hochkommata.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.set_session_state('#ITEM#', #PARAM_1#, '#ALLOW_RECURSION#', '#PARAM_2');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_ITEM',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_LIST_FROM_STMT',
    p_sat_stg_id => 'PL_SQL',
    p_sat_name => 'Liste von Werten mit SQL-Anweisung setzen',
    p_sat_description => q'{<p>Setzt einen Elementwert auf eine Liste von\CR\}' || 
q'{Werten, basierend auf einer SQL-Anweisung.</p>\CR\}' || 
q'{<p><em>Parameter</em>:  SQL-Anweisung, die eine Werteliste in einer Spalte\CR\}' || 
q'{namens VALUE zurückgibt</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.set_list_from_stmt('#ITEM#','#PARAM_1#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_LIST_FROM_STMT',
    p_sap_spt_id => 'SQL_STATEMENT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_DISABLE',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld leeren und deaktivieren',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf\CR\}' || 
q'{<span style="font-family:courier new,courier,monospace">NULL </span>und\CR\}' || 
q'{deaktiviert es auf der Seite aus.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Zweiter Parameter kann jQuery-Ausdruck enthalten, um\CR\}' || 
q'{mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als\CR\}' || 
q'{ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2');}',
    p_sat_js => q'{de.condes.plugin.sct.disable('#SELECTOR#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_NULL_DISABLE',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_HIDE',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld leeren und ausblenden',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf\CR\}' || 
q'{<span style="font-family:courier new,courier,monospace">NULL </span>und\CR\}' || 
q'{blendet es auf der Seite.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Zweiter Parameter kann jQuery-Ausdruck enthalten, um\CR\}' || 
q'{mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als\CR\}' || 
q'{ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2');}',
    p_sat_js => q'{de.condes.plugin.sct.hide('#SELECTOR#');de.condes.plugin.sct.setMandatory('#SELECTOR#', false);}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_NULL_HIDE',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_SESSION_STATE',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Wert des Feldes in SessionState schreiben',
    p_sat_description => q'{<p>Wert des Elementes in den Session State\CR\}' || 
q'{eintragen</p>\CR\}' || 
q'{<p><em>Parameter</em><span style="font-family:helvetica neue,segoe\CR\}' || 
q'{ui,helvetica,arial,sans-serif; font-size:15.36px">: Wert, der gesetzt werden soll. Konstante oder PL/SQL-Funktion.</span></p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{apex.server.process( "SAVE_HIDDEN_VALUE_IN_SESSION_STATE", { x01: "set_session_state",pageItems: '#' + '#ITEM#'}, {dataType: 'text'});}',
    p_sat_is_editable => sct_rule.C_TRUE,
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_SESSION_STATE',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_VALUE_ONLY',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld auf Wert setzen, keine Rekursion auslösen',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf\CR\}' || 
q'{den übergebenen Wert, ohne weitere Rekursionen auszulösen</p>\CR\}' || 
q'{<p><em>Parameter</em>: Keine</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.set_session_state('#ITEM#','#PARAM_1#', 0, '#PARAM_2');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_VALUE_ONLY',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_VALUE_ONLY',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ERROR',
    p_sat_stg_id => 'SCT',
    p_sat_name => 'Fehler anzeigen',
    p_sat_description => q'{<p>Zeigt die als Parameter übergebene\CR\}' || 
q'{Fehlermeldung auf der Seite.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Text der Fehlermeldung</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.register_error('#ITEM#', '#PARAM_1#','');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SHOW_ERROR',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ITEM',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_name => 'Ziel anzeigen',
    p_sat_description => q'{<p>Blendet das referenzierte Seitenelement auf\CR\}' || 
q'{der Seite ein.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Zweiter Parameter kann jQuery-Ausdruck enthalten, um\CR\}' || 
q'{mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als\CR\}' || 
q'{ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.show('#SELECTOR#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SHOW_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_TIP',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Hinweis anzeigen',
    p_sat_description => q'{<p>In der Meldungsregion einen Hinweis\CR\}' || 
q'{anzeigen</p>\CR\}' || 
q'{<p><em>Parameter:</em> Hinweistext</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{drv.ek.sct.setNotification('#PARAM_1#');}',
    p_sat_is_editable => sct_rule.C_TRUE,
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SHOW_TIP',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'STOP_RULE',
    p_sat_stg_id => 'SCT',
    p_sat_name => 'Regel stoppen',
    p_sat_description => q'{<p>Beendet die aktuell laufende Regel und\CR\}' || 
q'{erlaubt keine rekursive Ausführung weiterer Regeln.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Keine</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.stop_rule;}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT',
    p_sat_stg_id => 'SCT',
    p_sat_name => 'Seite absenden',
    p_sat_description => q'{<p>Prüft alle Pflichtfelder und löst SUBMIT der\CR\}' || 
q'{Seite aus.</p>\CR\}' || 
q'{<p><em>Parameter</em>:</p>\CR\}' || 
q'{<ul>\CR\}' || 
q'{<li><span style="font-family:courier new,courier,monospace">REQUEST\CR\}' || 
q'{</span>kann optional übergeben werden, ansonsten wird <span\CR\}' || 
q'{style="font-family:courier new,courier,monospace">SUBMIT\CR\}' || 
q'{</span>verwendet.</li>\CR\}' || 
q'{<li><span style="font-family:courier new,courier,monospace">MESSAGE\CR\}' || 
q'{</span>wird verwendet, um die Nachricht auf der Seite zu definieren.</li>\CR\}' || 
q'{</ul>}',
    p_sat_pl_sql => q'{plugin_sct.submit_page;}',
    p_sat_js => q'{de.condes.plugin.sct.submit('#PARAM_1#','#PARAM_2#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT',
    p_sap_spt_id => 'PIT_MESSAGE',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT_WO_VALIDATION',
    p_sat_stg_id => 'SCT',
    p_sat_name => 'Seite absenden, keine Validierung',
    p_sat_description => q'{<p>Prüft alle Pflichtfelder und löst SUBMIT der\CR\}' || 
q'{Seite aus.</p>\CR\}' || 
q'{<p><em>Parameter</em>:</p>\CR\}' || 
q'{<ul>\CR\}' || 
q'{<li><span style="font-family:courier new,courier,monospace">REQUEST\CR\}' || 
q'{</span>kann optional übergeben werden, ansonsten wird <span\CR\}' || 
q'{style="font-family:courier new,courier,monospace">SUBMIT\CR\}' || 
q'{</span>verwendet.</li>\CR\}' || 
q'{<li><span style="font-family:courier new,courier,monospace">MESSAGE\CR\}' || 
q'{</span>wird verwendet, um die Nachricht auf der Seite zu definieren.</li>\CR\}' || 
q'{</ul>}',
    p_sat_pl_sql => q'{plugin_sct.submit_page(false);}',
    p_sat_js => q'{de.condes.plugin.sct.submit('#PARAM_1#','#PARAM_2#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT_WO_VALIDATION',
    p_sap_spt_id => 'PIT_MESSAGE',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT_WO_VALIDATION',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'TOGGLE_ITEMS',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_name => 'Sichtbarkeit kontrollieren',
    p_sat_description => q'{<p>Kontrolliert die Anzeige mehrerer Seitenelemente.</p>\CR\}' || 
q'{\CR\}' || 
q'{<p><em>Parameter</em><span style="font-family:helvetica neue,segoe ui,helvetica,arial,sans-serif; font-size:15.36px">: Beide Parameter m&uuml;ssen mit einem jQuery-Selektor ausgestattet werden, der erste Parameter identifiziert die Elemente, die angezeigt, der zweite Parameter die Elemente, die ausgeblendet werden sollen.</span></p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.hide('#PARAM_2#');\CR\}' || 
q'{de.condes.plugin.sct.show('#PARAM_1#');}',
    p_sat_is_editable => sct_rule.C_TRUE,
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'TOGGLE_ITEMS',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'TOGGLE_ITEMS',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'VALIDATE',
    p_sat_stg_id => 'SCT',
    p_sat_name => 'Seite validieren',
    p_sat_description => q'{<p>Prüft alle Pflichtfelder, löst aber kein\CR\}' || 
q'{SUBMIT der Seite aus.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Keine</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.submit_page;}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'WAIT_FOR_REFRESH',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Eieruhr zeigen, bis APEX-Refresh erfolgreich',
    p_sat_description => q'{<p>Sorgt dafür, dass auf der Seite eine Eieruhr\CR\}' || 
q'{eingeblendet wird, bis eine APEX-Refresh-Aktion erfolgreich abgeschlossen\CR\}' || 
q'{wurde.<br>Als Seitenelement muss die Region/das Element angegeben werden,\CR\}' || 
q'{auf dessen Aktuialisierung gewartet wird.</p>\CR\}' || 
q'{</p><dl><dt>Parameter</dt><dd>Keine</dd></dl>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{drv.ek.waitUntilRefresh('#ITEM#');}',
    p_sat_is_editable => sct_rule.C_TRUE,
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'WAIT_FOR_REFRESH',
    p_sap_spt_id => 'PAGE_ITEM',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'XOR',
    p_sat_stg_id => 'SCT',
    p_sat_name => 'Genau einen Wert wählen',
    p_sat_description => q'{<p>Stellt sicher, dass genau eines der Elemente\CR\}' || 
q'{aus Attribut 1 einen Wert enthält.</p>\CR\}' || 
q'{<dl><dt>Parameter 1</dt><dd>Komma-separierte Liste von Elementnamen oder\CR\}' || 
q'{CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe\CR\}' || 
q'{zusammengefasst werden. Innerhalb dieser Gruppe muss beim Pr&uuml;fen der\CR\}' || 
q'{Werte entweder genau ein Feld einen NOT NULL-Wert besitzen, oder alle Werte\CR\}' || 
q'{m&uuml;ssen leer sein</dd>\CR\}' || 
q'{<dt>Parameter 2</dt><dd>Meldungsname, der ausgegeben werden soll, falls die\CR\}' || 
q'{Pr&uuml;fung misslingt. Muss ein PIT-Meldungsname sein, in der Form\CR\}' || 
q'{MSG.&lt;Meldungsname&gt;</dd></dl>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.xor('#ITEM#', '#PARAM_1#',#PARAM_2, false);}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'XOR_NN',
    p_sat_stg_id => 'SCT',
    p_sat_name => 'Genau einen Wert wählen, NOT_NULL',
    p_sat_description => q'{<p>Stellt sicher, dass genau eines der Elemente\CR\}' || 
q'{aus Attribut 1 einen Wert enthält. NULL wird nicht zugelassen</p>\CR\}' || 
q'{</p><dl><dt>Parameter 1</dt><dd>Komma-separierte Liste von Elementnamen\CR\}' || 
q'{oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe\CR\}' || 
q'{zusammengefasst werden. Innerhalb dieser Gruppe muss beim Pr&uuml;fen der\CR\}' || 
q'{Werte genau ein Feld einen NOT NULL-Wert besitzen.<br>Sind alle Elemente\CR\}' || 
q'{NULL oder sind mehr al ein Element NOT NULL, wird ein Fehler geworfen</dd>\CR\}' || 
q'{<dt>Parameter 2</dt><dd>Medlungsname, der ausgegeben werden soll, falls die\CR\}' || 
q'{Pr&uuml;fung misslingt. Muss ein PIT-Meldungsname sein, in der Form\CR\}' || 
q'{MSG.&lt;Meldungsname&gt;</dd></dl>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.xor('#ITEM#', '#PARAM_1#',#PARAM_2, true);}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR_NN',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'AFTER_REFRESH',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Ereignis "After Refresh" überwachen',
    p_sat_description => q'{<p>Registiert einen\CR\}' || 
q'{APEXAfterRefresh-Eventhandler. Wird das Ereignis ausgelöst, wird dies an\CR\}' || 
q'{SCT gemeldet und kann mit einer Regel AFTER_REFRESH = 1 gefangen werden.\CR\}' || 
q'{Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM\CR\}' || 
q'{registriert wird.</p>\CR\}' || 
q'{<p>ITEM muss ein Element sein, auf das dieses Ereignis ausgelöst werden\CR\}' || 
q'{kann.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Im ersten Parameter kann optional eine statische\CR\}' || 
q'{Aktion mitgegeben werden. Dieser Parameter muss eine\CR\}' || 
q'{JavaScript-Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>\CR\}' || 
q'{Wird kein Parameter definiert,  wird SCT aufgerufen und entsprechende\CR\}' || 
q'{Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion\CR\}' || 
q'{ausgeführt.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'AFTER_REFRESH',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'CHECK_MANDATORY',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Pflichtfeld prüfen',
    p_sat_description => q'{<p>Pr&uuml;ft, ob alle Pflichtfelder einen Wert\CR\}' || 
q'{enthalten.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Keine</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.check_mandatory('#ITEM#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'CONFIRM_CLICK',
    p_sat_stg_id => 'BUTTON',
    p_sat_name => 'Schaltfläche an Bestätigungsfrage binden',
    p_sat_description => q'{<p>Sorgt dafür, dass bei einem Klick auf eine\CR\}' || 
q'{Schaltfläche eine Bestätigungsmeldung gezeigt wird.<br>Nur, wenn die\CR\}' || 
q'{Schaltfläche OK geklickt wird, wird das Ereignis an SCT gemeldet.</p>\CR\}' || 
q'{</p><dl><dt>Parameter 1</dt><dd>Meldung, die in der Bestätigungsmeldung\CR\}' || 
q'{angezeigt wird</dd><dt>Parameter 2</dt><dd>Titel des Dialogfelds</dd></dl>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.bindConfirmation('#ITEM#','#PARAM_1#', '#PARAM_2#');}',
    p_sat_is_editable => sct_rule.C_TRUE,
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'DIALOG_CLOSED',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Ereignis "Dialog Close" überwachen',
    p_sat_description => q'{<p>Registiert einen\CR\}' || 
q'{APEXAfterDialogClose-Eventhandler. Wird das Ereignis ausgelöst, wird dies\CR\}' || 
q'{an SCT gemeldet und kann mit einer Regel DIALOG_CLOSED = 1 gefangen werden.\CR\}' || 
q'{Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM\CR\}' || 
q'{registriert wird.</p>\CR\}' || 
q'{<p>ITEM muss ein Element sein, auf das dieses Ereignis ausgelöst werden\CR\}' || 
q'{kann.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Im ersten Parameter kann optional eine statische\CR\}' || 
q'{Aktion mitgegeben werden. Dieser Parameter muss eine\CR\}' || 
q'{JavaScript-Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>\CR\}' || 
q'{Wird kein Parameter definiert,  wird SCT aufgerufen und entsprechende\CR\}' || 
q'{Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion\CR\}' || 
q'{ausgeführt.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DIALOG_CLOSED',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_BUTTON',
    p_sat_stg_id => 'BUTTON',
    p_sat_name => 'Schaltfläche deaktivieren',
    p_sat_description => q'{<p>Deaktiviert eine Schaltfl&auml;che. Zum\CR\}' || 
q'{Deaktivieren eines Seitenelements verwenden Sie bitte <span\CR\}' || 
q'{style="font-family:courier new,courier,monospace">Feld\CR\}' || 
q'{deaktivieren</span>.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Keine</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{apex.item('#ITEM#').disable();$('##ITEM#').removeClass('in_progress');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Ziel deaktivieren',
    p_sat_description => q'{<p>Deaktiviert das referenzierte\CR\}' || 
q'{Seitenelement.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Zweiter Parameter kann jQuery-Ausdruck enthalten, um\CR\}' || 
q'{mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als\CR\}' || 
q'{ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.disable('#SELECTOR#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DISABLE_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'DOUBLE_CLICK',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Ereignis "Doppelklick" überwachen',
    p_sat_description => q'{<p>Registiert einen DoubleClick-Eventhandler.\CR\}' || 
q'{Wird das Ereignis ausgelöst, wird dies an SCT gemeldet und kann mit einer\CR\}' || 
q'{Regel DOUBLE_CLICK = 1 gefangen werden. Auslösendes Element ist das\CR\}' || 
q'{Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>\CR\}' || 
q'{<p>ITEM muss ein Element sein, auf das dieses Ereignis ausgelöst werden\CR\}' || 
q'{kann.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Im ersten Parameter kann optional eine statische\CR\}' || 
q'{Aktion mitgegeben werden. Dieser Parameter muss eine\CR\}' || 
q'{JavaScript-Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>\CR\}' || 
q'{Wird kein Parameter definiert,  wird SCT aufgerufen und entsprechende\CR\}' || 
q'{Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion\CR\}' || 
q'{ausgeführt.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DOUBLE_CLICK',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'DYNAMIC_JAVASCRIPT',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Dynamisches JavaScript ausführen',
    p_sat_description => q'{<p>Führt das übergebene JavaScript auf der\CR\}' || 
q'{Seite aus</p>\CR\}' || 
q'{<p><em>Parameter</em>: PL/SQL-Funktion, die eine JavaScript-Anweisung\CR\}' || 
q'{ausgibt. Ohne "javascript:" verwenden, nur den JavaScript-Code ausgeben</p>\CR\}' || 
q'{<p><em>Format</em>: PL/SQL-Funktion wird so &uuml;bergeben, wie sie im\CR\}' || 
q'{SQL-Developer geschrieben w&uuml;rde, keine doppelten\CR\}' || 
q'{Anf&uuml;hrungsstriche, Semikolon kann gesetzt werden, muss aber\CR\}' || 
q'{nicht.</p>}',
    p_sat_pl_sql => q'{plugin_sct.execute_javascript(q'##PARAM_1##');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DYNAMIC_JAVASCRIPT',
    p_sap_spt_id => 'FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'EMPTY_FIELD',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld leeren',
    p_sat_description => q'{<p>Setzt den Elementwert eines Feldes auf <span\CR\}' || 
q'{style="font-family:courier new,courier,monospace">NULL</span></p>\CR\}' || 
q'{<p><em>Parameter</em>: Keine</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'EMPTY_FIELD',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'ENABLE_BUTTON',
    p_sat_stg_id => 'BUTTON',
    p_sat_name => 'Schaltfläche aktivieren',
    p_sat_description => q'{<p>Aktiviert eine Schaltfl&auml;che. Zum\CR\}' || 
q'{Aktivieren eines Seitenelements verwenden Sie bitte <span\CR\}' || 
q'{style="font-family:courier new,courier,monospace">Feld anzeigen</span>.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Keine.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{apex.item('#ITEM#').enable();}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'ENABLE_ITEM',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_name => 'Ziel aktivieren',
    p_sat_description => q'{<p>Deaktiviert das referenzierte\CR\}' || 
q'{Seitenelement.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Zweiter Parameter kann jQuery-Ausdruck enthalten, um\CR\}' || 
q'{mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als\CR\}' || 
q'{ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.enable('#SELECTOR#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'ENABLE_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'ENTER_KEY',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Ereignis "Enter-Taste" überwachen',
    p_sat_description => q'{<p>Registiert einen Enter-Taste-Eventhandler.\CR\}' || 
q'{Wird das Ereignis ausgelöst, wird dies an SCT gemeldet und kann mit einer\CR\}' || 
q'{RegelENTER_KEY = 1 gefangen werden. Auslösendes Element ist das Element,\CR\}' || 
q'{dass in dieser Aktion als FIRING_ITEM registriert wird.</p>\CR\}' || 
q'{<p>ITEM muss ein Element sein, auf das dieses Ereignis ausgelöst werden\CR\}' || 
q'{kann.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Im ersten Parameter kann optional eine statische\CR\}' || 
q'{Aktion mitgegeben werden. Dieser Parameter muss eine\CR\}' || 
q'{JavaScript-Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>\CR\}' || 
q'{Wird kein Parameter definiert,  wird SCT aufgerufen und entsprechende\CR\}' || 
q'{Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion\CR\}' || 
q'{ausgeführt.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'ENTER_KEY',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'EXECUTE_APEX_ACTION',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Befehl ausführen',
    p_sat_description => q'{<p>Führt einen Befehl aus, der vorab als\CR\}' || 
q'{APEX-Aktion angelegt worden sein muss.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Im ersten Parameter wird der Name der APEX-Aktion\CR\}' || 
q'{eingetragen.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.execute_apex_action('#PARAM_1#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'EXECUTE_APEX_ACTION',
    p_sap_spt_id => 'APEX_ACTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'GET_SEQ_VAL',
    p_sat_stg_id => 'PL_SQL',
    p_sat_name => 'Sequenzwert ermitteln',
    p_sat_description => q'{<p>Setzt das referenzierte Element auf einen\CR\}' || 
q'{neuen Sequenzwert.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Name der Sequenz muss übergeben werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.set_session_state('#ITEM#',#PARAM_1#.nextval, '#ALLOW_RECURSION#', '#PARAM_2');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'GET_SEQ_VAL',
    p_sap_spt_id => 'SEQUENCE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'HIDE_ITEM',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_name => 'Ziel ausblenden',
    p_sat_description => q'{<p>Blendet das referenzierte Seitenelement\CR\}' || 
q'{aus.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Zweiter Parameter kann jQuery-Ausdruck enthalten, um\CR\}' || 
q'{mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als\CR\}' || 
q'{ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.hide('#SELECTOR#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'HIDE_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_DATE',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld enthält Datum',
    p_sat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld ein Datum\CR\}' || 
q'{enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die\CR\}' || 
q'{f&uuml;r dieses Feld in APEX hinterlegt ist.</p>\CR\}' || 
q'{<p><em>Parameter:</em> Keine</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.check_date('#ITEM#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'IS_MANDATORY',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld ist Pflichtfeld',
    p_sat_description => q'{<p>Macht ein Seitenelement zu einem Pflichtfeld\CR\}' || 
q'{inkl. Validierung.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Fehlermeldung kann optional &uuml;bergeben werden,\CR\}' || 
q'{ansonsten wird eine Standardmeldung verwendet.<br>: Zweiter Parameter kann\CR\}' || 
q'{jQuery-Ausdruck enthalten, um mehrere Elemente zu bearbeiten. Wird dieser\CR\}' || 
q'{Parameter verwendet, muss als ausl&ouml;sendes Element\CR\}' || 
q'{<code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.register_mandatory('#ITEM#','#PARAM_1#', true, '#PARAM_2');}',
    p_sat_js => q'{de.condes.plugin.sct.setMandatory('#SELECTOR#', true);\CR\}' || 
q'{de.condes.plugin.sct.show('#SELECTOR#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'IS_MANDATORY',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_NUMERIC',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld enthält Zahl',
    p_sat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld einen\CR\}' || 
q'{numerischen Wert enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die\CR\}' || 
q'{Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>\CR\}' || 
q'{<p><em>Parameter:</em> Keine</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.check_number('#ITEM#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'IS_OPTIONAL',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld ist optional',
    p_sat_description => q'{<p>Macht ein Seitenelement zu einem optionalen\CR\}' || 
q'{Element und setzt Pflichtfeld-Validierung aus.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Zweiter Parameter kann jQuery-Ausdruck enthalten, um\CR\}' || 
q'{mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als\CR\}' || 
q'{ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.register_mandatory('#ITEM#', null, false,'#PARAM_2');}',
    p_sat_js => q'{de.condes.plugin.sct.setMandatory('#SELECTOR#',false);}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'IS_OPTIONAL',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'ITEM_NULL_SHOW',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld leeren und aktivieren',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf\CR\}' || 
q'{NULL und aktiviert es auf der Seite aus.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Zweiter Parameter kann jQuery-Ausdruck enthalten, um\CR\}' || 
q'{mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als\CR\}' || 
q'{ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2');}',
    p_sat_js => q'{de.condes.plugin.sct.enable('#SELECTOR#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'ITEM_NULL_SHOW',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'JAVA_SCRIPT_CODE',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'JavaScript-Code ausführen',
    p_sat_description => q'{<p>F&uuml;hrt den als Parameter\CR\}' || 
q'{&uuml;bergebenen JavaScript-Code aus.</p>\CR\}' || 
q'{<p><em>Parameter</em>: JavaScript-Anweisung, die ausgef&uuml;hrt werden\CR\}' || 
q'{soll. (ohne Semikolon)</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{#PARAM_1#;}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'JAVA_SCRIPT_CODE',
    p_sap_spt_id => 'JAVA_SCRIPT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'NOTIFY',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_name => 'Benachrichtigung zeigen',
    p_sat_description => q'{<p>Zeigt eine Nachricht auf der\CR\}' || 
q'{Anwendungsseite</p>\CR\}' || 
q'{<p><em>Parameter</em>: Der Meldungstext wird als erster Parameter\CR\}' || 
q'{übergeben.<br>Wird die Meldung mit einfachen Hochkommata &uuml;bergeben,\CR\}' || 
q'{wird sie als konstanter Text ausgegeben.<br>Wird der Parameter ohne\CR\}' || 
q'{Hochkommata übergeben, wird er als PL/SQL-Funktkion interpretiert, die\CR\}' || 
q'{einen Meldungstext liefert.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.notify(#PARAM_1#);}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'NOTIFY',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'NOT_NULL',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_name => 'Mindestens einen Wert wählen',
    p_sat_description => q'{<p>Stellt sicher, dass mindestens eines der\CR\}' || 
q'{Elemente aus Attribut 1 einen Wert enthält.</p>\CR\}' || 
q'{<dl><dt>Parameter 1</dt><dd>Komma-separierte Liste von Elementnamen oder\CR\}' || 
q'{CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe\CR\}' || 
q'{zusammengefasst werden. Innerhalb dieser Gruppe muss beim Pr&uuml;fen der\CR\}' || 
q'{Werte mindestens ein Feld einen NOT NULL-Wert besitzen</dd>\CR\}' || 
q'{<dt>Parameter 2</dt><dd>Meldungsname, der ausgegeben werden soll, falls die\CR\}' || 
q'{Pr&uuml;fung misslingt. Muss ein PIT-Meldungsname sein, in der Form\CR\}' || 
q'{MSG.&lt;Meldungsname&gt;</dd></dl>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.not_null('#ITEM#', '#PARAM_1#',#PARAM_2);}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'NOT_NULL',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'NOT_NULL',
    p_sap_spt_id => 'PIT_MESSAGE',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'PLSQL_CODE',
    p_sat_stg_id => 'PL_SQL',
    p_sat_name => 'PL/SQL-Code ausführen',
    p_sat_description => q'{<p>F&uuml;hrt den als Parameter &uuml;bergebenen PL/SQL-Code aus.</p>\CR\}' || 
q'{\CR\}' || 
q'{<p><em>Parameter</em>: PL/SQL-Code, der ausgef&uuml;hrt werden soll. (mit Semikolon)</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{plugin_sct.do_cmd('#PARAM_1#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'PLSQL_CODE',
    p_sap_spt_id => 'PROCEDURE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld aktualisieren und Wert setzen',
    p_sat_description => q'{<p>Aktualisiert ein Seitenelement und setzt das Feld auf den Sessionstatus</p>\CR\}' || 
q'{\CR\}' || 
q'{<p><em>Parameter</em>: Parameter 1 kann folgende Werte enthalten</p>\CR\}' || 
q'{\CR\}' || 
q'{<ul>\CR\}' || 
q'{	<li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li>\CR\}' || 
q'{	<li>Ein JavaScript-Ausdruck, der zur Laufzeit berechnet wird</li>\CR\}' || 
q'{	<li>Leere Zeichenkette (&#39;&#39;). In diesem Fall wird der Wert des Sessionstatus verwendet (dieser kann vorab berechnet werden)</li>\CR\}' || 
q'{</ul>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.refreshAndSetValue('#ITEM#', #PARAM_1#);}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sap_spt_id => 'STRING_OR_JAVASCRIPT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{''}',
    p_sap_description => q'{}',
    p_sap_mandatory => sct_rule.C_TRUE,
    p_sap_active => sct_rule.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_ITEM',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_name => 'Ziel aktualisieren (Refresh)',
    p_sat_description => q'{<p>Löst auf dem referenzierten Seitenelement\CR\}' || 
q'{einen APEX-Refresh aus.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Keine</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.refresh('#SELECTOR#');}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'REGISTER_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld-Event auslösen',
    p_sat_description => q'{<p>Löst einen CHANGE-Event auf das angegebene Feld aus und sorgt für die Abarbeitung der zugehörigen Regeln</p>}',
    p_sat_pl_sql => q'{plugin_sct.register_item('#ITEM#', '#ALLOW_RECURSION#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

  
  sct_admin.merge_action_type(
    p_sat_id => 'REGISTER_OBSERVER',
    p_sat_stg_id => 'ITEM',
    p_sat_name => 'Feld beobachten',
    p_sat_description => q'{<p>Aktion beobachtet ein Feld oder eine Klasse\CR\}' || 
q'{und registriert die Elemente so, dass die entsprechenden Elementwerte bei\CR\}' || 
q'{jedem Ereignis auf der Seite in den Sessionstatus kopiert werden.</p>\CR\}' || 
q'{<p><em>Parameter</em>: Zweiter Parameter kann jQuery-Ausdruck enthalten, um\CR\}' || 
q'{mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als\CR\}' || 
q'{ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => 'N',
    p_sat_raise_recursive => sct_rule.C_TRUE);

    sct_admin.merge_action_parameter(
    p_sap_sat_id => 'REGISTER_OBSERVER',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_mandatory => 'N',
    p_sap_active => sct_rule.C_TRUE);

  commit;
end;
/

set define on
set sqlblanklines off