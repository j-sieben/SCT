
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  dbms_output.put_line('^s1.Rulegroup SCT_ADMIN_SAT');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 2,
    p_sgr_name => 'SCT_ADMIN_SAT');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(242),
    p_sgr_name => 'SCT_ADMIN_SAT',
    p_sgr_description => q'|Regeln zur Dialogseite "Aktionstypen"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 2,
    p_sgr_with_recursion => sct_util.C_FALSE,
    p_sgr_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(486),
    p_sru_sgr_id => sct_admin.map_id(242),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(513),
    p_sra_sru_id => sct_admin.map_id(486),
    p_sra_sgr_id => sct_admin.map_id(242),
    p_sra_spi_id => 'R2_ACTION_TYPE',
    p_sra_sat_id => 'SET_IG_SELECTION',
    p_sra_param_1 => q'|P2_SAT_ID|',
    p_sra_param_2 => q'|1|',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
    
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(485),
    p_sra_sru_id => sct_admin.map_id(486),
    p_sra_sgr_id => sct_admin.map_id(242),
    p_sra_spi_id => 'R2_ACTION_TYPE',
    p_sra_sat_id => 'HIDE_IR_IG_FILTER',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  
  sct_admin.propagate_rule_change(sct_admin.map_id(242));

  commit;
end;
/

set define on
