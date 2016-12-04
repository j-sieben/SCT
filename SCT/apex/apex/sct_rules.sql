call sct_admin.prepare_rule_group_import('&APEX_WS.', '&APEX_ALIAS.');

set define off

declare
  l_foo number;
begin
  l_foo := sct_admin.map_id;
  -- sct_admin.prepare_rule_group_import('DOAG', 'TOOL');

  -- ACTION TYPES
  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_ITEM',
    p_sat_name => 'Ziel deaktivieren',
    p_sat_description => q'~<p>Deaktiviert das referenzierte Seitenelement.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();
apex.item('#ITEM#').disable();~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'EMPTY_FIELD',
    p_sat_name => 'Feld leeren',
    p_sat_description => q'~<p>Setzt den Elementwert eines Feldes auf <span style="font-family:courier new,courier,monospace">NULL</span></p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'GET_SEQ_VAL',
    p_sat_name => 'Sequenzwert ermitteln',
    p_sat_description => q'~<p>Setzt das referenzierte Element auf einen neuen Sequenzwert.</p>

<p><em>Parameter</em>: Name der Sequenz muss &uuml;bergeben werden.</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', #ATTRIBUTE#.nextval);~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'HIDE_ITEM',
    p_sat_name => 'Ziel ausblenden',
    p_sat_description => q'~<p>Blendet das referenzierte Seitenelement aus.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'JAVA_SCRIPT_CODE',
    p_sat_name => 'JavaScript-Code ausführen',
    p_sat_description => q'~<p>F&uuml;hrt den als Parameter &uuml;bergebenen JavaScript-Code aus.</p>

<p><em>Parameter</em>: JavaScript-Anweisung, die ausgef&uuml;hrt werden soll.</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~#ATTRIBUTE#;~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'NOTIFY',
    p_sat_name => 'Benachrichigung zeigen',
    p_sat_description => q'~<p>Zeigt eine Nachricht auf der Anwendungsseite</p>

<p><em>Parameter</em>: Der Meldungstext wird als erster Parameter &uuml;bergeben.</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~de.condes.plugin.sct.notify('#ATTRIBUTE#');~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'PLSQL_CODE',
    p_sat_name => 'PL/SQL-Code ausführen',
    p_sat_description => q'~<p>F&uuml;hrt den als Parameter &uuml;bergebenen PL/SQL-Code aus.</p>

<p><em>Parameter</em>: PL/SQL-Code, der ausgef&uuml;hrt werden soll.</p>
~',
    p_sat_pl_sql => q'~begin #ATTRIBUTE# end;~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_ITEM',
    p_sat_name => 'Ziel aktualisieren (Refresh)',
    p_sat_description => q'~<p>L&ouml;st auf dem referenzierten Seitenelement einen APEX-Refresh aus.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~$('##ITEM#').trigger('apexrefresh');
  apex.item('#ITEM#').enable();
  apex.item('#ITEM#').show();~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ITEM',
    p_sat_name => 'Feld auf Wert setzen',
    p_sat_description => q'~<p>Setzt das referenzierte Seitenelement auf den als Parameter &uuml;bergebenen Wert.</p>

<p><em>Parameter</em>: Wert des Elements oder Funktion, die Wert liefert. Zeichenketten ben&ouml;tigen Hochkommata.</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', #ATTRIBUTE#);~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_DISABLE',
    p_sat_name => 'Feld leeren und deaktivieren',
    p_sat_description => q'~<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und blendet es auf der Seite aus.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').show;
apex.item('#ITEM#').disable();~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_HIDE',
    p_sat_name => 'Feld leeren und ausblenden',
    p_sat_description => q'~<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und deaktiviert es auf der Seite.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ERROR',
    p_sat_name => 'Fehler anzeigen',
    p_sat_description => q'~<p>Zeigt die als Parameter &uuml;bergebene Fehlermeldung auf der Seite.</p>

<p><em>Parameter</em>: Text der Fehlermeldung</p>
~',
    p_sat_pl_sql => q'~plugin_sct.register_error('#ITEM#', '#ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ITEM',
    p_sat_name => 'Ziel anzeigen',
    p_sat_description => q'~<p>Blendet das referenzierte Seitenelement auf der Seite ein.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();
apex.item('#ITEM#').enable();~',
    p_sat_is_editable => 1,
    p_sat_raise_recursive => 1);

  -- RULE GROUP SCT_ADMIN_EXPORT_RULE (ID 1)
  sct_admin.merge_rule_group(
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 110),
    p_sgr_page_id => 8,
    p_sgr_id => sct_admin.map_id(1),
    p_sgr_name => q'~SCT_ADMIN_EXPORT_RULE~',
    p_sgr_description => q'~Regeln zur Dialogseite "Regelgruppe exportieren"~',
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(2),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Seite initialisieren~',
    p_sru_condition => q'~initializing = 1 and P8_SGR_ID is null~',
    p_sru_sort_seq => 10,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(3),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp ist "Regelgruppe", Regelgruppe unbekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_ID is null~',
    p_sru_sort_seq => 70,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(4),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Anwendung ist nicht leer, Anwendungsexport~',
    p_sru_condition => q'~P8_SGR_APP_ID is not null and P8_EXPORT_TYPE = 'APP'~',
    p_sru_sort_seq => 30,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(5),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Anwendung ist nicht leer, Regelgruppenexport~',
    p_sru_condition => q'~P8_SGR_APP_ID is not null and P8_EXPORT_TYPE = 'SGR'~',
    p_sru_sort_seq => 100,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(6),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Anwendungseite ist nicht leer, Regelgruppenexport~',
    p_sru_condition => q'~P8_SGR_PAGE_ID is not null and P8_EXPORT_TYPE = 'SGR'~',
    p_sru_sort_seq => 120,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(7),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Regelgruppe exportieren~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_APP_ID is not null and P8_SGR_PAGE_ID is not null and P8_SGR_ID is not null~',
    p_sru_sort_seq => 40,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(8),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Seite absenden~',
    p_sru_condition => q'~B8_EXPORT = 1~',
    p_sru_sort_seq => 140,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(9),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Anwendung ist leer~',
    p_sru_condition => q'~P8_SGR_APP_ID is null~',
    p_sru_sort_seq => 90,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(10),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Anwendungsseite ist leer~',
    p_sru_condition => q'~P8_SGR_PAGE_ID is null~',
    p_sru_sort_seq => 110,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(11),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Regelgruppe ist leer~',
    p_sru_condition => q'~P8_SGR_ID is null~',
    p_sru_sort_seq => 130,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(12),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Seite initialisieren, Regelgruppe bekannt~',
    p_sru_condition => q'~initializing = 1 and P8_SGR_ID is not null~',
    p_sru_sort_seq => 20,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(13),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp ist "Anwendung", Regelgruppe bekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'APP' and P8_SGR_ID is not null~',
    p_sru_sort_seq => 60,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(14),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp ist "Anwendung", Regeglruppe unbekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'APP' and P8_SGR_ID is null~',
    p_sru_sort_seq => 50,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(15),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp ist "Regelgruppe", Regelgruppe bekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_ID is not null~',
    p_sru_sort_seq => 80,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'SHOW_ERROR',
    p_sra_attribute => q'~Das ist ein Fehler~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~'APP'~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~Wählen Sie eine Anwendung~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 50,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(4),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(5),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(6),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(7),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(8),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_attribute => q'~sct_ui_pkg.validate_rule_group;~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(8),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'SUBMIT',
    p_sra_attribute => q'~EXPORT~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(9),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(9),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'CHECK_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(9),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(10),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'CHECK_MANDATORY',
    p_sra_attribute => q'~Die Anwendungsseite muss angegeben werden~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(11),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'CHECK_MANDATORY',
    p_sra_attribute => q'~Geben Sie eine Regelgruppe an~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(12),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~'SGR'~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(12),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~Wählen Sie eine Anwendung~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(13),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'HIDE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(13),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(13),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(13),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_HIDE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(14),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'HIDE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(14),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(14),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'HIDE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(14),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~Wählen Sie eine Anwendungsseite~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(1));

  -- RULE GROUP SCT_ADMIN_MAIN (ID 16)
  sct_admin.merge_rule_group(
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 110),
    p_sgr_page_id => 1,
    p_sgr_id => sct_admin.map_id(16),
    p_sgr_name => q'~SCT_ADMIN_MAIN~',
    p_sgr_description => q'~Hauptseite der SCT-Administration~',
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(17),
    p_sru_sgr_id => sct_admin.map_id(16),
    p_sru_name => q'~Regelgruppe gewählt~',
    p_sru_condition => q'~P1_SGR_ID is not null~',
    p_sru_sort_seq => 30,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(18),
    p_sru_sgr_id => sct_admin.map_id(16),
    p_sru_name => q'~Regelgruppe neu nummerieren~',
    p_sru_condition => q'~B1_RESEQUENCE_RULE_GROUP = 1~',
    p_sru_sort_seq => 80,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(19),
    p_sru_sgr_id => sct_admin.map_id(16),
    p_sru_name => q'~Anwendungsfilter ist nicht leer~',
    p_sru_condition => q'~P1_SGR_APPLICATION is not null~',
    p_sru_sort_seq => 40,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(20),
    p_sru_sgr_id => sct_admin.map_id(16),
    p_sru_name => q'~Anwendungsfilter ist leer~',
    p_sru_condition => q'~P1_SGR_APPLICATION is null~',
    p_sru_sort_seq => 50,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(21),
    p_sru_sgr_id => sct_admin.map_id(16),
    p_sru_name => q'~Initialisierung~',
    p_sru_condition => q'~initializing = 1~',
    p_sru_sort_seq => 10,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(22),
    p_sru_sgr_id => sct_admin.map_id(16),
    p_sru_name => q'~Regelgruppe ist leer~',
    p_sru_condition => q'~P1_SGR_ID is null~',
    p_sru_sort_seq => 20,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(23),
    p_sru_sgr_id => sct_admin.map_id(16),
    p_sru_name => q'~Anwendungsseite ist nicht leer~',
    p_sru_condition => q'~P1_SGR_PAGE is not null~',
    p_sru_sort_seq => 70,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(24),
    p_sru_sgr_id => sct_admin.map_id(16),
    p_sru_name => q'~Anwendungsseite ist leer~',
    p_sru_condition => q'~P1_SGR_PAGE is null~',
    p_sru_sort_seq => 60,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(17),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'B1_COPY_RULE_GROUP',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(17),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'B1_CREATE',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(17),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'B1_RESEQUENCE_RULE_GROUP',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(17),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_attribute => q'~sct_ui_pkg.validate_rule_group(v('#ITEM#'));~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 70,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(17),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 60,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_attribute => q'~sct_ui_pkg.resequence_rule_group(v('#ITEM#'));~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(19),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(19),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'P1_SGR_PAGE',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(20),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(20),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'P1_SGR_PAGE',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(20),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(21),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'P1_SGR_APPLICATION',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(22),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'B1_COPY_RULE_GROUP',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(22),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'B1_CREATE',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(22),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'B1_RESEQUENCE_RULE_GROUP',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(22),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 60,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(23),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(24),
    p_sra_sgr_id => sct_admin.map_id(16),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(16));

  -- RULE GROUP SCT_COPY_RULEGROUP (ID 26)
  sct_admin.merge_rule_group(
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 110),
    p_sgr_page_id => 4,
    p_sgr_id => sct_admin.map_id(26),
    p_sgr_name => q'~SCT_COPY_RULEGROUP~',
    p_sgr_description => q'~Regeln zur Dialogseite "Regelgruppe kopieren"~',
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(27),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Quellanwendung ist leer~',
    p_sru_condition => q'~P4_SGR_APP_ID is null~',
    p_sru_sort_seq => 10,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(28),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Quellanwending ist nicht leer~',
    p_sru_condition => q'~P4_SGR_APP_ID is not null~',
    p_sru_sort_seq => 20,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(29),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Quellseite ist leer~',
    p_sru_condition => q'~P4_SGR_PAGE_ID is null~',
    p_sru_sort_seq => 30,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(30),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Quellseite ist nicht leer~',
    p_sru_condition => q'~P4_SGR_PAGE_ID is not null~',
    p_sru_sort_seq => 40,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(31),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Regelgruppe ist leer~',
    p_sru_condition => q'~P4_SGR_ID is null~',
    p_sru_sort_seq => 50,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(32),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Regelgruppe ist nicht leer~',
    p_sru_condition => q'~P4_SGR_ID is not null~',
    p_sru_sort_seq => 60,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(33),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Zielanwendung ist leer~',
    p_sru_condition => q'~P4_SGR_APP_TO is null~',
    p_sru_sort_seq => 70,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(34),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Zielanwendung ist nicht leer~',
    p_sru_condition => q'~P4_SGR_APP_TO is not null~',
    p_sru_sort_seq => 80,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(35),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Zielseite ist leer~',
    p_sru_condition => q'~P4_SGR_PAGE_TO is null~',
    p_sru_sort_seq => 90,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(36),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Zielseite ist nicht leer~',
    p_sru_condition => q'~P4_SGR_PAGE_TO is not null~',
    p_sru_sort_seq => 100,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(37),
    p_sru_sgr_id => sct_admin.map_id(26),
    p_sru_name => q'~Regelgruppe kopieren~',
    p_sru_condition => q'~B4_COPY = 1~',
    p_sru_sort_seq => 110,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(27),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'P4_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(28),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'P4_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(29),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'P4_SGR_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'P4_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(31),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'P4_SGR_APP_TO',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(32),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'P4_SGR_APP_TO',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(33),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'P4_SGR_PAGE_TO',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(34),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'P4_SGR_PAGE_TO',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(35),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'B4_COPY',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(36),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'B4_COPY',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(37),
    p_sra_sgr_id => sct_admin.map_id(26),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'SUBMIT',
    p_sra_attribute => q'~COPY~',
    p_sra_attribute_2 => q'~Bearbeiten Sie alle Pflichtfelder, bevor Sie die Seite absenden.~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(26));

  -- RULE GROUP SCT_TEST_CASES (ID 38)
  sct_admin.merge_rule_group(
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 110),
    p_sgr_page_id => 100,
    p_sgr_id => sct_admin.map_id(38),
    p_sgr_name => q'~SCT_TEST_CASES~',
    p_sgr_description => q'~Testfälle für Seite 100~',
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(40),
    p_sru_sgr_id => sct_admin.map_id(38),
    p_sru_name => q'~Initialisierung~',
    p_sru_condition => q'~initializing = 1~',
    p_sru_sort_seq => 10,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(42),
    p_sru_sgr_id => sct_admin.map_id(38),
    p_sru_name => q'~Seite absenden~',
    p_sru_condition => q'~B100_SAVE = 1~',
    p_sru_sort_seq => 20,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(40),
    p_sra_sgr_id => sct_admin.map_id(38),
    p_sra_spi_id => 'P100_MANDATORY_FIELD',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~Bitte geben Sie einen Wert ein.~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(42),
    p_sra_sgr_id => sct_admin.map_id(38),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'SUBMIT',
    p_sra_attribute => q'~SAVE~',
    p_sra_attribute_2 => q'~Bitte bearbeiten Sie vor dem Absenden alle Fehler.~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(38));

  commit;
end;
/

set define on