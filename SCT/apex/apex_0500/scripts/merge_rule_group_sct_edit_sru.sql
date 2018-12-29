
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_EDIT_SRU');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 5,
    p_sgr_name => 'SCT_EDIT_SRU');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(94),
    p_sgr_name => 'SCT_EDIT_SRU',
    p_sgr_description => q'|Regeln zur Dialogseite "Regel bearbeiten"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 5,
    p_sgr_with_recursion => 'Y',
    p_sgr_active => 'Y');
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(96),
    p_sru_sgr_id => sct_admin.map_id(94),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(98),
    p_sra_sru_id => sct_admin.map_id(96),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'R5_ACTION',
    p_sra_sat_id => 'DIALOG_CLOSED',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(100),
    p_sru_sgr_id => sct_admin.map_id(94),
    p_sru_name => 'Aktion editiert',
    p_sru_condition => q'|dialog_closed = 'R5_ACTION'|',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(102),
    p_sra_sru_id => sct_admin.map_id(100),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'R5_ACTION',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(104),
    p_sru_sgr_id => sct_admin.map_id(94),
    p_sru_name => 'Inititialisierung, neue Regel',
    p_sru_condition => q'|P5_SRU_ID is null and initializing = 1|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => 'Y',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(106),
    p_sra_sru_id => sct_admin.map_id(104),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'P5_SRU_SORT_SEQ',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|sct_ui_pkg.get_sru_sort_seq|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(108),
    p_sra_sru_id => sct_admin.map_id(104),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'P5_SRU_ACTIVE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|'Y'|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(527),
    p_sru_sgr_id => sct_admin.map_id(94),
    p_sru_name => 'Regelbedingung geändert',
    p_sru_condition => q'|P5_SRU_CONDITION is not null|',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(526),
    p_sra_sru_id => sct_admin.map_id(527),
    p_sra_sgr_id => sct_admin.map_id(94),
    p_sra_spi_id => 'P5_SRU_CONDITION',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.validate_rule;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');
  
  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(252),
    p_saa_sgr_id => sct_admin.map_id(94),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'create-apex-action',
    p_saa_label => 'APEX-Aktion erstellen',
    p_saa_context_label => '',
    p_saa_icon => '',
    p_saa_icon_type => '',
    p_saa_title => '',
    p_saa_shortcut => '',
    p_saa_initially_disabled => 'N',
    p_saa_initially_hidden => 'N',
    p_saa_href => '#',
    p_saa_action => '');
  
  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(252),
    p_sai_spi_sgr_id => sct_admin.map_id(94),
    p_sai_spi_id => 'B5_CREATE_ACTION',
    p_sai_active => 'Y');


  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(252),
    p_sai_spi_sgr_id => sct_admin.map_id(94),
    p_sai_spi_id => 'B5_CREATE_ACTION_1',
    p_sai_active => 'Y');


  sct_admin.propagate_rule_change(sct_admin.map_id(94));

  commit;
end;
/

set define on
