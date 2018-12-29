set define ^

declare
  l_foo number;
begin
  l_foo := sct_admin.map_id;
  
  dbms_output.put_line('&s1.Rulegroup SCT_EXPORT_SGR');
  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(2),
    p_sgr_name => 'SCT_EXPORT_SGR',
    p_sgr_description => q'|Regeln zur Dialogseite "Regelgruppe exportieren"|',
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, ^APP_ID.),
    p_sgr_page_id => 8,
    p_sgr_with_recursion => 1,
    p_sgr_active => 1);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(4),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Seite initialisieren, Regelgruppe unbekannt',
    p_sru_condition => q'|initializing = 1 and P8_SGR_ID is null|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(34),
    p_sra_sru_id => sct_admin.map_id(4),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'|'APP'|',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(6),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Exporttyp ist "Regelgruppe", Anwendungsseite unbekannt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'SGR' and P8_SGR_PAGE_ID is null|',
    p_sru_sort_seq => 90,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(36),
    p_sra_sru_id => sct_admin.map_id(6),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(38),
    p_sra_sru_id => sct_admin.map_id(6),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(8),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Exportschaltfläche verwalten, Anwendungsexport',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'APP' and P8_SGR_APP_ID is not null|',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(40),
    p_sra_sru_id => sct_admin.map_id(8),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(10),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Anwendung ist nicht leer',
    p_sru_condition => q'|P8_SGR_APP_ID is not null|',
    p_sru_sort_seq => 120,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(42),
    p_sra_sru_id => sct_admin.map_id(10),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(12),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Anwendungseite ist nicht leer',
    p_sru_condition => q'|P8_SGR_PAGE_ID is not null|',
    p_sru_sort_seq => 140,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(44),
    p_sra_sru_id => sct_admin.map_id(12),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(14),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Exportschaltfläche verwalten, Regelgruppenexport',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'SGR' and P8_SGR_APP_ID is not null and P8_SGR_PAGE_ID is not null and P8_SGR_ID is not null|',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(46),
    p_sra_sru_id => sct_admin.map_id(14),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(16),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Seite absenden',
    p_sru_condition => q'|B8_EXPORT = 1|',
    p_sru_sort_seq => 150,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(48),
    p_sra_sru_id => sct_admin.map_id(16),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'SUBMIT',
    p_sra_attribute => q'|EXPORT|',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(18),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Anwendung ist leer',
    p_sru_condition => q'|P8_SGR_APP_ID is null|',
    p_sru_sort_seq => 110,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(50),
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(52),
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(20),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Anwendungsseite ist leer',
    p_sru_condition => q'|P8_SGR_PAGE_ID is null|',
    p_sru_sort_seq => 130,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(54),
    p_sra_sru_id => sct_admin.map_id(20),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(56),
    p_sra_sru_id => sct_admin.map_id(20),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'CHECK_MANDATORY',
    p_sra_attribute => q'|Die Anwendungsseite muss angegeben werden|',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(22),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Seite initialisieren, Regelgruppe bekannt',
    p_sru_condition => q'|initializing = 1 and P8_SGR_ID is not null|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(58),
    p_sra_sru_id => sct_admin.map_id(22),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'STOP_RULE',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(60),
    p_sra_sru_id => sct_admin.map_id(22),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_attribute => q'|'SGR'|',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(24),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Exporttyp ist "Regelgruppe", Anwendungsseite bekannt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'SGR' and P8_SGR_PAGE_ID is not null|',
    p_sru_sort_seq => 100,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(62),
    p_sra_sru_id => sct_admin.map_id(24),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(26),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Exporttyp ist "Regelgruppe", Anwendung unbekannt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'SGR' and P8_SGR_APP_ID is null|',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(64),
    p_sra_sru_id => sct_admin.map_id(26),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(66),
    p_sra_sru_id => sct_admin.map_id(26),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(28),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Exporttyp ist "Regelgruppe", Anwendung bekannt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'SGR' and P8_SGR_APP_ID is not null|',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(68),
    p_sra_sru_id => sct_admin.map_id(28),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(30),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Exporttyp auf "Anwendung" umgestellt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'APP'|',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(70),
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 70,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(72),
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'STOP_RULE',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 80,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(74),
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(76),
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(78),
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 40,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(80),
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'SET_NULL_HIDE',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 50,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(82),
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'IS_OPTIONAL',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 60,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(84),
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_HIDE',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(32),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Exporttyp auf "Regelgruppe" umgestellt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'SGR'|',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(86),
    p_sra_sru_id => sct_admin.map_id(32),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(88),
    p_sra_sru_id => sct_admin.map_id(32),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P8_SGR_APP_ID',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_attribute => q'||',
    p_sra_attribute_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 0,
    p_sra_raise_recursive => 1,
    p_sra_active => 1);
  
  commit;
end;
/

set define &