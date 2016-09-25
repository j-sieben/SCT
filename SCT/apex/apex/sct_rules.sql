declare
  l_foo binary_integer;
begin
  l_foo := sct_admin.map_id;

  -- ACTION TYPES
  sct_admin.merge_action_type(
    p_sat_id => 'CHECK_MANDATORY',
    p_sat_name => 'Pflichtfeld prüfen',
    p_sat_pl_sql => q'~plugin_sct.check_mandatory('#ITEM#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_ITEM',
    p_sat_name => 'Ziel deaktivieren',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();
apex.item('#ITEM#').disable();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'GET_SEQ_VAL',
    p_sat_name => 'Sequenzwert ermitteln',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', #ATTRIBUTE#.nextval);~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'HIDE_ITEM',
    p_sat_name => 'Ziel ausblenden',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_MANDATORY',
    p_sat_name => 'Feld ist Pflichtfeld',
    p_sat_pl_sql => q'~plugin_sct.register_mandatory('#ITEM#', '#ATTRIBUTE#', true);~',
    p_sat_js => q'~de.condes.plugin.sct.setMandatory('#ITEM#', true);~',
    p_sat_is_editable => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_OPTIONAL',
    p_sat_name => 'Feld ist optional',
    p_sat_pl_sql => q'~plugin_sct.register_mandatory('#ITEM#', null, false);~',
    p_sat_js => q'~de.condes.plugin.sct.setMandatory('#ITEM#', false);~',
    p_sat_is_editable => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'JAVA_SCRIPT_CODE',
    p_sat_name => 'JavaScript-Code ausführen',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~#ATTRIBUTE#~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'PLSQL_CODE',
    p_sat_name => 'PL/SQL-Code ausführen',
    p_sat_pl_sql => q'~begin #ATTRIBUTE# end;~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_ITEM',
    p_sat_name => 'Ziel aktualisieren (Refresh)',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~$('##ITEM#').trigger('apexrefresh');
  apex.item('#ITEM#').enable();
  apex.item('#ITEM#').show();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ITEM',
    p_sat_name => 'Feld auf Wert setzen',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '#ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_DISABLE',
    p_sat_name => 'Feld leeren und deaktivieren',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').show;
apex.item('#ITEM#').disable();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_HIDE',
    p_sat_name => 'Feld leeren und ausblenden',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ERROR',
    p_sat_name => 'Fehler anzeigen',
    p_sat_pl_sql => q'~plugin_sct.register_error('#ITEM#', '#ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ITEM',
    p_sat_name => 'Ziel anzeigen',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();
apex.item('#ITEM#').enable();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT',
    p_sat_name => 'Seite absenden',
    p_sat_pl_sql => q'~plugin_sct.submit_page;~',
    p_sat_js => q'~de.condes.plugin.sct.submit('#ATTRIBUTE#')~',
    p_sat_is_editable => 0);

  -- RULE GROUP SCT_ADMIN_EXPORT_RULE (ID 217
  sct_admin.merge_rule_group(
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 106),
    p_sgr_page_id => 8,
    p_sgr_id => sct_admin.map_id(217),
    p_sgr_name => q'~SCT_ADMIN_EXPORT_RULE~',
    p_sgr_description => q'~Regeln zur Dialogseite "Regelgruppe exportieren"~',
    p_sgr_active => 1);

  -- RULES~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(219),
    p_sru_sgr_id => sct_admin.map_id(217),
    p_sru_name => q'~Seite initialisieren~',
    p_sru_condition => q'~initializing = 1~',
    p_sru_sort_seq => 10,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(221),
    p_sru_sgr_id => sct_admin.map_id(217),
    p_sru_name => q'~P8_EXPORT_TYPE ist "Anwendung"~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'APP'~',
    p_sru_sort_seq => 20,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(223),
    p_sru_sgr_id => sct_admin.map_id(217),
    p_sru_name => q'~P8_EXPORT_TYPE ist "Regelgruppe"~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR'~',
    p_sru_sort_seq => 30,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(225),
    p_sru_sgr_id => sct_admin.map_id(217),
    p_sru_name => q'~Anwendung ist nicht leer, Anwendungsexport~',
    p_sru_condition => q'~P8_SGR_APP_ID is not null and P8_EXPORT_TYPE = 'APP'~',
    p_sru_sort_seq => 50,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(227),
    p_sru_sgr_id => sct_admin.map_id(217),
    p_sru_name => q'~Anwendung ist nicht leer, Regelgruppenexport~',
    p_sru_condition => q'~P8_SGR_APP_ID is not null and P8_EXPORT_TYPE = 'SGR'~',
    p_sru_sort_seq => 60,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(229),
    p_sru_sgr_id => sct_admin.map_id(217),
    p_sru_name => q'~Anwendungseite ist nicht leer, Regelgruppenexport~',
    p_sru_condition => q'~P8_SGR_PAGE_ID is not null and P8_EXPORT_TYPE = 'SGR'~',
    p_sru_sort_seq => 70,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(231),
    p_sru_sgr_id => sct_admin.map_id(217),
    p_sru_name => q'~Regelgruppe ist nicht leer~',
    p_sru_condition => q'~P8_SGR_ID is not null~',
    p_sru_sort_seq => 80,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(233),
    p_sru_sgr_id => sct_admin.map_id(217),
    p_sru_name => q'~Seite absenden~',
    p_sru_condition => q'~B8_EXPORT = 1~',
    p_sru_sort_seq => 90,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(235),
    p_sru_sgr_id => sct_admin.map_id(217),
    p_sru_name => q'~Anwendung ist leer~',
    p_sru_condition => q'~P8_SGR_APP_ID is null~',
    p_sru_sort_seq => 40,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(219),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(219),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~APP~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(219),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(221),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(221),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'SET_NULL_HIDE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(221),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(221),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_HIDE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(223),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 50,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(223),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(223),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(223),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(223),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(225),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(227),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(229),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(231),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(233),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'SUBMIT',
    p_sra_attribute => q'~EXPORT~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(235),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(235),
    p_sra_sgr_id => sct_admin.map_id(217),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  -- RULE GROUP SCT_ADMIN_MAIN (ID 1
  sct_admin.merge_rule_group(
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 106),
    p_sgr_page_id => 1,
    p_sgr_id => sct_admin.map_id(1),
    p_sgr_name => q'~SCT_ADMIN_MAIN~',
    p_sgr_description => q'~Hauptseite der SCT-Administration~',
    p_sgr_active => 1);

  -- RULES~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(2),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Keine Regelgruppe gewählt~',
    p_sru_condition => q'~P1_SGR_ID is null~',
    p_sru_sort_seq => 20,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(3),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Regelgruppe gewählt~',
    p_sru_condition => q'~P1_SGR_ID is not null~',
    p_sru_sort_seq => 10,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(4),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Regelgruppe neu nummerieren~',
    p_sru_condition => q'~B1_RESEQUENCE_RULES = 1~',
    p_sru_sort_seq => 30,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B1_CREATE',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B1_RESEQUENCE_RULES',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'RULE',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B1_CREATE',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B1_RESEQUENCE_RULES',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'RULE',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(4),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_attribute => q'~ui_sct_pkg.resequence_rule_group(v('#ITEM#'));~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(4),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'RULE',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  -- RULE GROUP SCT_COPY_RULEGROUP (ID 81
  sct_admin.merge_rule_group(
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 106),
    p_sgr_page_id => 4,
    p_sgr_id => sct_admin.map_id(81),
    p_sgr_name => q'~SCT_COPY_RULEGROUP~',
    p_sgr_description => q'~Regeln zur Dialogseite "Regelgruppe kopieren"~',
    p_sgr_active => 1);

  -- RULES~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(82),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Quellanwendung ist leer~',
    p_sru_condition => q'~P4_SGR_APP_ID is null~',
    p_sru_sort_seq => 10,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(83),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Quellanwending ist nicht leer~',
    p_sru_condition => q'~P4_SGR_APP_ID is not null~',
    p_sru_sort_seq => 20,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(88),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Quellseite ist leer~',
    p_sru_condition => q'~P4_SGR_PAGE_ID is null~',
    p_sru_sort_seq => 30,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(185),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Quellseite ist nicht leer~',
    p_sru_condition => q'~P4_SGR_PAGE_ID is not null~',
    p_sru_sort_seq => 40,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(206),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Regelgruppe ist leer~',
    p_sru_condition => q'~P4_SGR_ID is null~',
    p_sru_sort_seq => 50,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(208),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Regelgruppe ist nicht leer~',
    p_sru_condition => q'~P4_SGR_ID is not null~',
    p_sru_sort_seq => 60,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(210),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Zielanwendung ist leer~',
    p_sru_condition => q'~P4_SGR_APP_TO is null~',
    p_sru_sort_seq => 70,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(212),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Zielanwendung ist nicht leer~',
    p_sru_condition => q'~P4_SGR_APP_TO is not null~',
    p_sru_sort_seq => 80,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(214),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Zielseite ist leer~',
    p_sru_condition => q'~P4_SGR_PAGE_TO is null~',
    p_sru_sort_seq => 90,
    p_sru_active => 1);
~
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(216),
    p_sru_sgr_id => sct_admin.map_id(81),
    p_sru_name => q'~Zielseite ist nicht leer~',
    p_sru_condition => q'~P4_SGR_PAGE_TO is not null~',
    p_sru_sort_seq => 100,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(82),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'P4_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(83),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'P4_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(88),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'P4_SGR_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(185),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'P4_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(206),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'P4_SGR_APP_TO',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(208),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'P4_SGR_APP_TO',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(210),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'P4_SGR_PAGE_TO',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(212),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'P4_SGR_PAGE_TO',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(214),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'B4_COPY',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_ra_sru_id => sct_admin.map_id(216),
    p_sra_sgr_id => sct_admin.map_id(81),
    p_sra_spi_id => 'B4_COPY',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  commit;
end;
/