set define ^

declare
  l_foo number;
begin
  l_foo := sct_admin.map_id;

  -- RULE GROUP SCT_COPY_RULEGROUP (ID 25)
  dbms_output.put_line('.    - Rulegroup SCT_COPY_RULEGROUP');
  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(25),
    p_sgr_name => q'~SCT_COPY_RULEGROUP~',
    p_sgr_description => q'~Regeln zur Dialogseite "Regelgruppe kopieren"~',
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, ^APP_ID.),
    p_sgr_page_id => 4,
    p_sgr_with_recursion => 1,
    p_sgr_active => 1);

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(26),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Quellanwendung ist leer~',
    p_sru_condition => q'~P4_SGR_APP_ID is null~',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(27),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Quellanwending ist nicht leer~',
    p_sru_condition => q'~P4_SGR_APP_ID is not null~',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(28),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Quellseite ist leer~',
    p_sru_condition => q'~P4_SGR_PAGE_ID is null~',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(29),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Quellseite ist nicht leer~',
    p_sru_condition => q'~P4_SGR_PAGE_ID is not null~',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(30),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Regelgruppe ist leer~',
    p_sru_condition => q'~P4_SGR_ID is null~',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(31),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Regelgruppe ist nicht leer~',
    p_sru_condition => q'~P4_SGR_ID is not null~',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(32),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Zielanwendung ist leer~',
    p_sru_condition => q'~P4_SGR_APP_TO is null~',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(33),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Zielanwendung ist nicht leer~',
    p_sru_condition => q'~P4_SGR_APP_TO is not null~',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(34),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Zielseite ist leer~',
    p_sru_condition => q'~P4_SGR_PAGE_TO is null~',
    p_sru_sort_seq => 90,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(35),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Zielseite ist nicht leer~',
    p_sru_condition => q'~P4_SGR_PAGE_TO is not null~',
    p_sru_sort_seq => 100,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(36),
    p_sru_sgr_id => sct_admin.map_id(25),
    p_sru_name => q'~Regelgruppe kopieren~',
    p_sru_condition => q'~B4_COPY = 1~',
    p_sru_sort_seq => 110,
    p_sru_fire_on_page_load => -1,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(26),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'P4_SGR_PAGE_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(27),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'P4_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(28),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'P4_SGR_ID',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(29),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'P4_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(30),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'P4_SGR_APP_TO',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(31),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'P4_SGR_APP_TO',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(32),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'P4_SGR_PAGE_TO',
    p_sra_sat_id => 'SET_NULL_DISABLE',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(33),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'P4_SGR_PAGE_TO',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(34),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'B4_COPY',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(35),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'B4_COPY',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(36),
    p_sra_sgr_id => sct_admin.map_id(25),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'SUBMIT',
    p_sra_attribute => q'~COPY~',
    p_sra_attribute_2 => q'~Bearbeiten Sie alle Pflichtfelder, bevor Sie die Seite absenden.~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  sct_admin.propagate_rule_change(sct_admin.map_id(25));

  commit;
end;
/
set define &