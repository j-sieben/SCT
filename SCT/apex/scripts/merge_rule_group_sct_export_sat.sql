
set define #

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, #APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_EXPORT_SAT');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 12,
    p_sgr_name => 'SCT_EXPORT_SAT');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(237),
    p_sgr_name => 'SCT_EXPORT_SAT',
    p_sgr_description => q'|Regeln der Dialogseite "Aktionstypen exportieren"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 12,
    p_sgr_with_recursion => sct_util.C_TRUE,
    p_sgr_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(239),
    p_sru_sgr_id => sct_admin.map_id(237),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(243),
    p_sra_sru_id => sct_admin.map_id(239),
    p_sra_sgr_id => sct_admin.map_id(237),
    p_sra_spi_id => 'B12_EXPORT',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(245),
    p_sra_sru_id => sct_admin.map_id(239),
    p_sra_sgr_id => sct_admin.map_id(237),
    p_sra_spi_id => 'P12_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|'SAT_EXPORT_USER'|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(247),
    p_sru_sgr_id => sct_admin.map_id(237),
    p_sru_name => 'Keine Auswahl getroffen',
    p_sru_condition => q'|P12_EXPORT_TYPE is null|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(249),
    p_sra_sru_id => sct_admin.map_id(247),
    p_sra_sgr_id => sct_admin.map_id(237),
    p_sra_spi_id => 'B12_EXPORT',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(251),
    p_sru_sgr_id => sct_admin.map_id(237),
    p_sru_name => 'Auswahl getroffen',
    p_sru_condition => q'|P12_EXPORT_TYPE is not null|',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(253),
    p_sra_sru_id => sct_admin.map_id(251),
    p_sra_sgr_id => sct_admin.map_id(237),
    p_sra_spi_id => 'B12_EXPORT',
    p_sra_sat_id => 'ENABLE_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  
  sct_admin.propagate_rule_change(sct_admin.map_id(237));

  commit;
end;
/

set define on
