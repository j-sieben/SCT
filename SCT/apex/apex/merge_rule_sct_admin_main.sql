set define ^

declare
  l_foo number;
begin
  l_foo := sct_admin.map_id;

  -- RULE GROUP SCT_ADMIN_MAIN (ID 17)
  dbms_output.put_line('.    - Rulegroup SCT_ADMIN_MAIN');
  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(17),
    p_sgr_name => q'~SCT_ADMIN_MAIN~',
    p_sgr_description => q'~Hauptseite der SCT-Administration~',
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, ^APP_ID.),
    p_sgr_page_id => 1,
    p_sgr_with_recursion => 1,
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(18),
    p_sru_sgr_id => sct_admin.map_id(17),
    p_sru_name => q'~Regelgruppe bekannt~',
    p_sru_condition => q'~P1_SGR_ID is not null~',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(19),
    p_sru_sgr_id => sct_admin.map_id(17),
    p_sru_name => q'~Anwendungsfilter ist nicht leer~',
    p_sru_condition => q'~P1_SGR_APP_ID is not null~',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(20),
    p_sru_sgr_id => sct_admin.map_id(17),
    p_sru_name => q'~Anwendungsfilter ist leer~',
    p_sru_condition => q'~P1_SGR_APP_ID is null~',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(21),
    p_sru_sgr_id => sct_admin.map_id(17),
    p_sru_name => q'~Initialisierung~',
    p_sru_condition => q'~initializing = 1~',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(22),
    p_sru_sgr_id => sct_admin.map_id(17),
    p_sru_name => q'~Regelgruppe unbekannt~',
    p_sru_condition => q'~P1_SGR_ID is null~',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(23),
    p_sru_sgr_id => sct_admin.map_id(17),
    p_sru_name => q'~Seitenfilter ist nicht leer~',
    p_sru_condition => q'~P1_SGR_PAGE_ID is not null~',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(24),
    p_sru_sgr_id => sct_admin.map_id(17),
    p_sru_name => q'~Seitenfilter ist leer~',
    p_sru_condition => q'~P1_SGR_PAGE_ID is null~',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'B1_COPY_RULE_GROUP',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(19),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(19),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'P1_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(20),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 30,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(20),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'P1_SGR_PAGE_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(20),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'P1_SGR_PAGE_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(20),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 40,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(21),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~''~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(22),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'B1_COPY_RULE_GROUP',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(22),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 20,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(23),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(24),
    p_sra_sgr_id => sct_admin.map_id(17),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(17));

  commit;
end;
/
set define &