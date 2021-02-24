
set define #

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, #APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_EDIT_SGR');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 6,
    p_sgr_name => 'SCT_EDIT_SGR');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(122),
    p_sgr_name => 'SCT_EDIT_SGR',
    p_sgr_description => q'|Regeln zur Dialogseite "Regelgruppe bearbeiten"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 6,
    p_sgr_with_recursion => sct_util.C_TRUE,
    p_sgr_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(124),
    p_sru_sgr_id => sct_admin.map_id(122),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(126),
    p_sra_sru_id => sct_admin.map_id(124),
    p_sra_sgr_id => sct_admin.map_id(122),
    p_sra_spi_id => 'R6_APEX_ACTION',
    p_sra_sat_id => 'DIALOG_CLOSED',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(128),
    p_sra_sru_id => sct_admin.map_id(124),
    p_sra_sgr_id => sct_admin.map_id(122),
    p_sra_spi_id => 'P6_SGR_ACTIVE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|'Y'|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(130),
    p_sra_sru_id => sct_admin.map_id(124),
    p_sra_sgr_id => sct_admin.map_id(122),
    p_sra_spi_id => 'P6_SGR_WITH_RECURSION',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|'Y'|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(132),
    p_sru_sgr_id => sct_admin.map_id(122),
    p_sru_name => 'APEX-Aktion editiert',
    p_sru_condition => q'|dialog_closed = 'R6_APEX_ACTION'|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(134),
    p_sra_sru_id => sct_admin.map_id(132),
    p_sra_sgr_id => sct_admin.map_id(122),
    p_sra_spi_id => 'R6_APEX_ACTION',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  
  sct_admin.propagate_rule_change(sct_admin.map_id(122));

  commit;
end;
/

set define on
