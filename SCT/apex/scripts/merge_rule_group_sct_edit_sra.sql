
set define #

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, #APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_EDIT_SRA');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 11,
    p_sgr_name => 'SCT_EDIT_SRA');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(191),
    p_sgr_name => 'SCT_EDIT_SRA',
    p_sgr_description => q'|Regeln der Dialogseite "Regelaktionen bearbeiten"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 11,
    p_sgr_with_recursion => sct_util.C_TRUE,
    p_sgr_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(193),
    p_sru_sgr_id => sct_admin.map_id(191),
    p_sru_name => 'Initialisierung bei Neuanlage',
    p_sru_condition => q'|initializing = 1 and P11_SRA_ID is null|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(195),
    p_sra_sru_id => sct_admin.map_id(193),
    p_sra_sgr_id => sct_admin.map_id(191),
    p_sra_spi_id => 'P11_SRA_SORT_SEQ',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|sct_ui.get_sra_sort_seq|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(197),
    p_sra_sru_id => sct_admin.map_id(193),
    p_sra_sgr_id => sct_admin.map_id(191),
    p_sra_spi_id => 'P11_SRA_ACTIVE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|sct_ui.C_TRUE|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(199),
    p_sra_sru_id => sct_admin.map_id(193),
    p_sra_sgr_id => sct_admin.map_id(191),
    p_sra_spi_id => 'P11_SRA_RAISE_RECURSIVE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|sct_ui.C_TRUE|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(335),
    p_sra_sru_id => sct_admin.map_id(193),
    p_sra_sgr_id => sct_admin.map_id(191),
    p_sra_spi_id => 'P11_SRA_SAT_ID',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui.configure_edit_sra;|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 40,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(205),
    p_sru_sgr_id => sct_admin.map_id(191),
    p_sru_name => 'Aktionstyp geändert',
    p_sru_condition => q'|P11_SRA_SAT_ID is not null|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => sct_util.C_TRUE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(207),
    p_sra_sru_id => sct_admin.map_id(205),
    p_sra_sgr_id => sct_admin.map_id(191),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui.configure_edit_sra;|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  
  sct_admin.propagate_rule_change(sct_admin.map_id(191));

  commit;
end;
/

set define on
