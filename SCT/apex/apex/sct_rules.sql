call sct_admin.prepare_rule_group_import('&APEX_WS.', '&APEX_ALIAS.');

set define off

declare
  l_foo number;
begin
  l_foo := sct_admin.map_id;
  -- RULE GROUP SCT_ADMIN_MAIN (ID 676)
  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(676),
    p_sgr_name => q'~SCT_ADMIN_MAIN~',
    p_sgr_description => q'~Hauptseite der SCT-Administration~',
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 506),
    p_sgr_page_id => 1,
    p_sgr_with_recursion => 1,
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(677),
    p_sru_sgr_id => sct_admin.map_id(676),
    p_sru_name => q'~Regelgruppe gewählt~',
    p_sru_condition => q'~P1_SGR_ID is not null~',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(678),
    p_sru_sgr_id => sct_admin.map_id(676),
    p_sru_name => q'~Regelgruppe neu nummerieren~',
    p_sru_condition => q'~B1_RESEQUENCE_RULE_GROUP = 1~',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(679),
    p_sru_sgr_id => sct_admin.map_id(676),
    p_sru_name => q'~Anwendungsfilter ist nicht leer~',
    p_sru_condition => q'~P1_SGR_APPLICATION is not null~',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(680),
    p_sru_sgr_id => sct_admin.map_id(676),
    p_sru_name => q'~Anwendungsfilter ist leer~',
    p_sru_condition => q'~P1_SGR_APPLICATION is null~',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(681),
    p_sru_sgr_id => sct_admin.map_id(676),
    p_sru_name => q'~Initialisierung~',
    p_sru_condition => q'~initializing = 1~',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(682),
    p_sru_sgr_id => sct_admin.map_id(676),
    p_sru_name => q'~Regelgruppe ist leer~',
    p_sru_condition => q'~P1_SGR_ID is null~',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(683),
    p_sru_sgr_id => sct_admin.map_id(676),
    p_sru_name => q'~Anwendungsseite ist nicht leer~',
    p_sru_condition => q'~P1_SGR_PAGE is not null~',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(684),
    p_sru_sgr_id => sct_admin.map_id(676),
    p_sru_name => q'~Anwendungsseite ist leer~',
    p_sru_condition => q'~P1_SGR_PAGE is null~',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(685),
    p_sru_sgr_id => sct_admin.map_id(676),
    p_sru_name => q'~Regelgruppe validieren~',
    p_sru_condition => q'~B1_VALIDATE_RULE_GROUP = 1~',
    p_sru_sort_seq => 90,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(677),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'B1_COPY_RULE_GROUP',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(677),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'B1_RESEQUENCE_RULE_GROUP',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(677),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'B1_VALIDATE_RULE_GROUP',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(677),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(678),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_attribute => q'~sct_ui_pkg.resequence_rule_group(v('#ITEM#'));~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(678),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(679),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(679),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'P1_SGR_PAGE',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(680),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(680),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'P1_SGR_PAGE',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(680),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(681),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'P1_SGR_APPLICATION',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(682),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'B1_COPY_RULE_GROUP',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(682),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'B1_RESEQUENCE_RULE_GROUP',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(682),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'B1_VALIDATE_RULE_GROUP',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(682),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(683),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(684),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(685),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_attribute => q'~sct_ui_pkg.validate_rule_group(v('#ITEM#'));~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(685),
    p_sra_sgr_id => sct_admin.map_id(676),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(676));

  commit;
  
  -- RULE GROUP SCT_ADMIN_EXPORT_RULE (ID 661)
  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(661),
    p_sgr_name => q'~SCT_ADMIN_EXPORT_RULE~',
    p_sgr_description => q'~Regeln zur Dialogseite "Regelgruppe exportieren"~',
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 506),
    p_sgr_page_id => 8,
    p_sgr_with_recursion => 1,
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(662),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Seite initialisieren~',
    p_sru_condition => q'~initializing = 1 and P8_SGR_ID is null~',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(663),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Exporttyp ist "Regelgruppe", Regelgruppe unbekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_ID is null~',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(664),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Anwendung ist nicht leer, Anwendungsexport~',
    p_sru_condition => q'~P8_SGR_APP_ID is not null and P8_EXPORT_TYPE = 'APP'~',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(665),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Anwendung ist nicht leer, Regelgruppenexport~',
    p_sru_condition => q'~P8_SGR_APP_ID is not null and P8_EXPORT_TYPE = 'SGR'~',
    p_sru_sort_seq => 100,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(666),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Anwendungseite ist nicht leer, Regelgruppenexport~',
    p_sru_condition => q'~P8_SGR_PAGE_ID is not null and P8_EXPORT_TYPE = 'SGR'~',
    p_sru_sort_seq => 120,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(667),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Regelgruppe exportieren~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_APP_ID is not null and P8_SGR_PAGE_ID is not null and P8_SGR_ID is not null~',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(668),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Seite absenden~',
    p_sru_condition => q'~B8_EXPORT = 1~',
    p_sru_sort_seq => 140,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(669),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Anwendung ist leer~',
    p_sru_condition => q'~P8_SGR_APP_ID is null~',
    p_sru_sort_seq => 90,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(670),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Anwendungsseite ist leer~',
    p_sru_condition => q'~P8_SGR_PAGE_ID is null~',
    p_sru_sort_seq => 110,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(671),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Regelgruppe ist leer~',
    p_sru_condition => q'~P8_SGR_ID is null~',
    p_sru_sort_seq => 130,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(672),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Seite initialisieren, Regelgruppe bekannt~',
    p_sru_condition => q'~initializing = 1 and P8_SGR_ID is not null~',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(673),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Exporttyp ist "Anwendung", Regelgruppe bekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'APP' and P8_SGR_ID is not null~',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(674),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Exporttyp ist "Anwendung", Regeglruppe unbekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'APP' and P8_SGR_ID is null~',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(675),
    p_sru_sgr_id => sct_admin.map_id(661),
    p_sru_name => q'~Exporttyp ist "Regelgruppe", Regelgruppe bekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_ID is not null~',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(662),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~'APP'~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(662),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(662),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~Wählen Sie eine Anwendung~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(663),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 50,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(663),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(663),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(663),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(663),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(664),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(665),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(666),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(667),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(668),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_attribute => q'~sct_ui_pkg.validate_rule_group;~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(668),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'SUBMIT',
    p_sra_attribute => q'~EXPORT~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(669),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(669),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'CHECK_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(669),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(670),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'CHECK_MANDATORY',
    p_sra_attribute => q'~Die Anwendungsseite muss angegeben werden~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(671),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'CHECK_MANDATORY',
    p_sra_attribute => q'~Geben Sie eine Regelgruppe an~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(672),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'~'SGR'~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(672),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~Wählen Sie eine Anwendung~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(673),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'HIDE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(673),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(673),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(673),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_HIDE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(674),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'HIDE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(674),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(674),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'HIDE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(674),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(675),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(675),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(675),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~Wählen Sie eine Anwendungsseite~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(675),
    p_sra_sgr_id => sct_admin.map_id(661),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(661));

  commit;

 
  -- RULE GROUP SCT_COPY_RULEGROUP (ID 686)
  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(686),
    p_sgr_name => q'~SCT_COPY_RULEGROUP~',
    p_sgr_description => q'~Regeln zur Dialogseite "Regelgruppe kopieren"~',
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 506),
    p_sgr_page_id => 4,
    p_sgr_with_recursion => 1,
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(687),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Quellanwendung ist leer~',
    p_sru_condition => q'~P4_SGR_APP_ID is null~',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(688),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Quellanwending ist nicht leer~',
    p_sru_condition => q'~P4_SGR_APP_ID is not null~',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(689),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Quellseite ist leer~',
    p_sru_condition => q'~P4_SGR_PAGE_ID is null~',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(690),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Quellseite ist nicht leer~',
    p_sru_condition => q'~P4_SGR_PAGE_ID is not null~',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(691),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Regelgruppe ist leer~',
    p_sru_condition => q'~P4_SGR_ID is null~',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(692),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Regelgruppe ist nicht leer~',
    p_sru_condition => q'~P4_SGR_ID is not null~',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(693),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Zielanwendung ist leer~',
    p_sru_condition => q'~P4_SGR_APP_TO is null~',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(694),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Zielanwendung ist nicht leer~',
    p_sru_condition => q'~P4_SGR_APP_TO is not null~',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(695),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Zielseite ist leer~',
    p_sru_condition => q'~P4_SGR_PAGE_TO is null~',
    p_sru_sort_seq => 90,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(696),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Zielseite ist nicht leer~',
    p_sru_condition => q'~P4_SGR_PAGE_TO is not null~',
    p_sru_sort_seq => 100,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(697),
    p_sru_sgr_id => sct_admin.map_id(686),
    p_sru_name => q'~Regelgruppe kopieren~',
    p_sru_condition => q'~B4_COPY = 1~',
    p_sru_sort_seq => 110,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(687),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'P4_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(688),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'P4_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(689),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'P4_SGR_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(690),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'P4_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(691),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'P4_SGR_APP_TO',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(692),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'P4_SGR_APP_TO',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(693),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'P4_SGR_PAGE_TO',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(694),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'P4_SGR_PAGE_TO',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(695),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'B4_COPY',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(696),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'B4_COPY',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(697),
    p_sra_sgr_id => sct_admin.map_id(686),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'SUBMIT',
    p_sra_attribute => q'~COPY~',
    p_sra_attribute_2 => q'~Bearbeiten Sie alle Pflichtfelder, bevor Sie die Seite absenden.~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(686));

  commit;
end;
/

set define on