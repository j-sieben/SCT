
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_EXPORT_SGR');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 8,
    p_sgr_name => 'SCT_EXPORT_SGR');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(144),
    p_sgr_name => 'SCT_EXPORT_SGR',
    p_sgr_description => q'|Regeln zur Dialogseite "Regelgruppe exportieren"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 8,
    p_sgr_with_recursion => sct_util.C_TRUE,
    p_sgr_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(146),
    p_sru_sgr_id => sct_admin.map_id(144),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(148),
    p_sra_sru_id => sct_admin.map_id(146),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|sct_ui_pkg.get_export_type|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(150),
    p_sru_sgr_id => sct_admin.map_id(144),
    p_sru_name => '"Alle Regelgruppen exportieren" gewaehlt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'ALL_SGR'|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(152),
    p_sra_sru_id => sct_admin.map_id(150),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'TOGGLE_ITEMS',
    p_sra_param_1 => q'|.sct-ui-export-all|',
    p_sra_param_2 => q'|.sct-ui-hide|',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(154),
    p_sra_sru_id => sct_admin.map_id(150),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(156),
    p_sru_sgr_id => sct_admin.map_id(144),
    p_sru_name => '"Regelgruppen einer Anwendung exportieren" gewählt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'APP'|',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(158),
    p_sra_sru_id => sct_admin.map_id(156),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(160),
    p_sra_sru_id => sct_admin.map_id(156),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'TOGGLE_ITEMS',
    p_sra_param_1 => q'|.sct-ui-export-app|',
    p_sra_param_2 => q'|.sct-ui-hide|',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(162),
    p_sru_sgr_id => sct_admin.map_id(144),
    p_sru_name => '"Eine Regelgruppe exportieren" gewählt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'SGR'|',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(164),
    p_sra_sru_id => sct_admin.map_id(162),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 40,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(166),
    p_sra_sru_id => sct_admin.map_id(162),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'TOGGLE_ITEMS',
    p_sra_param_1 => q'|.sct-ui-export-sgr|',
    p_sra_param_2 => q'|.sct-ui-hide|',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(168),
    p_sra_sru_id => sct_admin.map_id(162),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(170),
    p_sra_sru_id => sct_admin.map_id(162),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(172),
    p_sru_sgr_id => sct_admin.map_id(144),
    p_sru_name => 'Anwendung geändert bei Export einer Einzelgruppe',
    p_sru_condition => q'|firing_item = 'P8_SGR_APP_ID' and P8_EXPORT_TYPE = 'SGR'|',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(174),
    p_sra_sru_id => sct_admin.map_id(172),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(176),
    p_sra_sru_id => sct_admin.map_id(172),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(178),
    p_sru_sgr_id => sct_admin.map_id(144),
    p_sru_name => 'Anwendungsseite geändert',
    p_sru_condition => q'|firing_item = 'P8_SGR_PAGE_ID'|',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(180),
    p_sra_sru_id => sct_admin.map_id(178),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(182),
    p_sru_sgr_id => sct_admin.map_id(144),
    p_sru_name => 'Regelgruppe gewählt',
    p_sru_condition => q'|firing_item = 'P8_SGR_ID'|',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(184),
    p_sra_sru_id => sct_admin.map_id(182),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(186),
    p_sru_sgr_id => sct_admin.map_id(144),
    p_sru_name => 'Anwendung geändert bei Export aller Gruppen einer Anwendung',
    p_sru_condition => q'|firing_item = 'P8_SGR_APP_ID' and P8_EXPORT_TYPE = 'APP'|',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(188),
    p_sra_sru_id => sct_admin.map_id(186),
    p_sra_sgr_id => sct_admin.map_id(144),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  
  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(190),
    p_saa_sgr_id => sct_admin.map_id(144),
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
    p_sai_spi_sgr_id => sct_admin.map_id(144),
    p_sai_spi_id => 'B8_EXPORT',
    p_sai_active => sct_util.C_TRUE);


  sct_admin.propagate_rule_change(sct_admin.map_id(144));

  commit;
end;
/

set define on
