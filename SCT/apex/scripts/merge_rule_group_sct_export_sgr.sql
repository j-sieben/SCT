
set define #

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, #APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_EXPORT_SGR');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 8,
    p_sgr_name => 'SCT_EXPORT_SGR');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(180),
    p_sgr_name => 'SCT_EXPORT_SGR',
    p_sgr_description => q'|Regeln zur Dialogseite "Regelgruppe exportieren"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 8,
    p_sgr_with_recursion => sct_util.C_TRUE,
    p_sgr_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(182),
    p_sru_sgr_id => sct_admin.map_id(180),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(184),
    p_sra_sru_id => sct_admin.map_id(182),
    p_sra_sgr_id => sct_admin.map_id(180),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|sct_ui.get_export_type|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(186),
    p_sru_sgr_id => sct_admin.map_id(180),
    p_sru_name => 'Anwendung geändert',
    p_sru_condition => q'|firing_item in ('P8_EXPORT_TYPE', 'P8_SGR_APP_ID', 'P8_SGR_PAGE_ID', 'P8_SGR_ID')|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(188),
    p_sra_sru_id => sct_admin.map_id(186),
    p_sra_sgr_id => sct_admin.map_id(180),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  
  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(190),
    p_saa_sgr_id => sct_admin.map_id(180),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'export-rulegroup',
    p_saa_label => 'Regelgruppe(n) exportieren',
    p_saa_context_label => '',
    p_saa_icon => '',
    p_saa_icon_type => '',
    p_saa_title => 'Exportiert die gewählten Regelgruppen',
    p_saa_shortcut => 'Alt+E',
    p_saa_initially_disabled => sct_util.C_TRUE,
    p_saa_initially_hidden => sct_util.C_FALSE,
    p_saa_href => '',
    p_saa_action => '');
  
  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(190),
    p_sai_spi_sgr_id => sct_admin.map_id(180),
    p_sai_spi_id => 'B8_EXPORT',
    p_sai_active => sct_util.C_TRUE);


  sct_admin.propagate_rule_change(sct_admin.map_id(180));

  commit;
end;
/

set define on
