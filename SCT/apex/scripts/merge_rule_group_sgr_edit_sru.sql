
set define #

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, #APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_EDIT_SRU');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 5,
    p_sgr_name => 'SCT_EDIT_SRU');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(213),
    p_sgr_name => 'SCT_EDIT_SRU',
    p_sgr_description => q'|Regeln zur Dialogseite "Regel bearbeiten"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 5,
    p_sgr_with_recursion => sct_util.C_TRUE,
    p_sgr_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(215),
    p_sru_sgr_id => sct_admin.map_id(213),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(217),
    p_sra_sru_id => sct_admin.map_id(215),
    p_sra_sgr_id => sct_admin.map_id(213),
    p_sra_spi_id => 'R5_ACTION',
    p_sra_sat_id => 'HIDE_IR_IG_FILTER',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(219),
    p_sra_sru_id => sct_admin.map_id(215),
    p_sra_sgr_id => sct_admin.map_id(213),
    p_sra_spi_id => 'R5_ACTION',
    p_sra_sat_id => 'DIALOG_CLOSED',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_FALSE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(223),
    p_sru_sgr_id => sct_admin.map_id(213),
    p_sru_name => 'Aktion editiert',
    p_sru_condition => q'|dialog_closed = 'R5_ACTION'|',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(225),
    p_sra_sru_id => sct_admin.map_id(223),
    p_sra_sgr_id => sct_admin.map_id(213),
    p_sra_spi_id => 'R5_ACTION',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(227),
    p_sru_sgr_id => sct_admin.map_id(213),
    p_sru_name => 'Inititialisierung, neue Regel',
    p_sru_condition => q'|P5_SRU_ID is null and initializing = 1|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => sct_util.C_TRUE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(229),
    p_sra_sru_id => sct_admin.map_id(227),
    p_sra_sgr_id => sct_admin.map_id(213),
    p_sra_spi_id => 'P5_SRU_SORT_SEQ',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|sct_ui.get_sru_sort_seq|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(231),
    p_sra_sru_id => sct_admin.map_id(227),
    p_sra_sgr_id => sct_admin.map_id(213),
    p_sra_spi_id => 'P5_SRU_ACTIVE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|sct_ui.c_true|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(233),
    p_sru_sgr_id => sct_admin.map_id(213),
    p_sru_name => 'Regelbedingung geändert',
    p_sru_condition => q'|P5_SRU_CONDITION is not null|',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(235),
    p_sra_sru_id => sct_admin.map_id(233),
    p_sra_sgr_id => sct_admin.map_id(213),
    p_sra_spi_id => 'P5_SRU_CONDITION',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui.validate_rule_condition;|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  
  sct_admin.propagate_rule_change(sct_admin.map_id(213));

  commit;
end;
/

set define on
