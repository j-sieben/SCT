
set define #

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, #APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_EDIT_SAA');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 9,
    p_sgr_name => 'SCT_EDIT_SAA');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(94),
    p_sgr_name => 'SCT_EDIT_SAA',
    p_sgr_description => q'|Regeln zur Dialogseite "APEX-Aktionen editieren"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 9,
    p_sgr_with_recursion => sct_util.C_FALSE,
    p_sgr_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(96),
    p_sru_sgr_id => sct_admin.map_id(94),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(98),
    p_sra_sru_id => sct_admin.map_id(96),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'P9_SAA_STY_ID',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|'ACTION'|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(100),
    p_sra_sru_id => sct_admin.map_id(96),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'P9_SAA_STY_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(102),
    p_sru_sgr_id => sct_admin.map_id(94),
    p_sru_name => 'Aktionstyp ACTION gewählt',
    p_sru_condition => q'|P9_SAA_STY_ID = 'ACTION'|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(104),
    p_sra_sru_id => sct_admin.map_id(102),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'IS_MANDATORY',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'|.sct-ui-action-mandatory|',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(106),
    p_sra_sru_id => sct_admin.map_id(102),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'TOGGLE_ITEMS',
    p_sra_param_1 => q'|.sct-ui-action|',
    p_sra_param_2 => q'|.sct-ui-hide|',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(108),
    p_sra_sru_id => sct_admin.map_id(102),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'P9_SAA_SAI_LIST',
    p_sra_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(110),
    p_sru_sgr_id => sct_admin.map_id(94),
    p_sru_name => 'Aktionstyp TOGGLE gewählt',
    p_sru_condition => q'|P9_SAA_STY_ID = 'TOGGLE'|',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(112),
    p_sra_sru_id => sct_admin.map_id(110),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'TOGGLE_ITEMS',
    p_sra_param_1 => q'|.sct-ui-toggle|',
    p_sra_param_2 => q'|.sct-ui-hide|',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(114),
    p_sra_sru_id => sct_admin.map_id(110),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'P9_SAA_SAI_LIST',
    p_sra_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(116),
    p_sru_sgr_id => sct_admin.map_id(94),
    p_sru_name => 'Aktionstyp RADIO_GROUP gewählt',
    p_sru_condition => q'|P9_SAA_STY_ID = 'RADIO_GROUP'|',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(118),
    p_sra_sru_id => sct_admin.map_id(116),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'TOGGLE_ITEMS',
    p_sra_param_1 => q'|.sct-ui-list|',
    p_sra_param_2 => q'|.sct-ui-hide|',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(120),
    p_sra_sru_id => sct_admin.map_id(116),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'P9_SAA_SAI_LIST',
    p_sra_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  
  sct_admin.propagate_rule_change(sct_admin.map_id(94));

  commit;
end;
/

set define on
