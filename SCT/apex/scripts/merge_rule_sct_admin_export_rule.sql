set define ^

declare
  l_foo number;
begin
  l_foo := sct_admin.map_id;

  -- RULE GROUP SCT_ADMIN_EXPORT_RULE (ID 1)
  dbms_output.put_line('.    - Rulegroup SCT_ADMIN_EXPORT_RULE');
  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(1),
    p_sgr_name => q'~SCT_ADMIN_EXPORT_RULE~',
    p_sgr_description => q'~Regeln zur Dialogseite "Regelgruppe exportieren"~',
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, ^APP_ID.),
    p_sgr_page_id => 8,
    p_sgr_with_recursion => 1,
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(2),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Seite initialisieren, Regelgruppe unbekannt~',
    p_sru_condition => q'~initializing = 1 and P8_SGR_ID is null~',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(3),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp ist "Regelgruppe", Anwendungsseite unbekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_PAGE_ID is null~',
    p_sru_sort_seq => 90,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(4),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exportschaltfläche verwalten, Anwendungsexport~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'APP' and P8_SGR_APP_ID is not null~',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(5),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Anwendung ist nicht leer~',
    p_sru_condition => q'~P8_SGR_APP_ID is not null~',
    p_sru_sort_seq => 120,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(6),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Anwendungseite ist nicht leer~',
    p_sru_condition => q'~P8_SGR_PAGE_ID is not null~',
    p_sru_sort_seq => 140,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(7),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exportschaltfläche verwalten, Regelgruppenexport~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_APP_ID is not null and P8_SGR_PAGE_ID is not null and P8_SGR_ID is not null~',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(8),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Seite absenden~',
    p_sru_condition => q'~B8_EXPORT = 1~',
    p_sru_sort_seq => 150,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(9),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Anwendung ist leer~',
    p_sru_condition => q'~P8_SGR_APP_ID is null~',
    p_sru_sort_seq => 110,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(10),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Anwendungsseite ist leer~',
    p_sru_condition => q'~P8_SGR_PAGE_ID is null~',
    p_sru_sort_seq => 130,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(11),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Seite initialisieren, Regelgruppe bekannt~',
    p_sru_condition => q'~initializing = 1 and P8_SGR_ID is not null~',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(12),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp ist "Regelgruppe", Anwendungsseite bekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_PAGE_ID is not null~',
    p_sru_sort_seq => 100,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(13),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp ist "Regelgruppe", Anwendung unbekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_APP_ID is null~',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(14),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp ist "Regelgruppe", Anwendung bekannt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR' and P8_SGR_APP_ID is not null~',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(15),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp auf "Anwendung" umgestellt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'APP'~',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(16),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Exporttyp auf "Regelgruppe" umgestellt~',
    p_sru_condition => q'~P8_EXPORT_TYPE = 'SGR'~',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  -- RULE ACTIONS
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
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
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
    p_sra_sat_id => 'SUBMIT',
    p_sra_attribute => q'~EXPORT~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
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
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(10),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
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
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'STOP_RULE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(11),
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
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(13),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(13),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(14),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 70,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'STOP_RULE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 80,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'SET_NULL_HIDE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 50,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 60,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(15),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_HIDE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(16),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(16),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(1));

  commit;
end;
/
set define &