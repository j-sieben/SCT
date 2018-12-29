
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
    p_sgr_id => sct_admin.map_id(110),
    p_sgr_name => 'SCT_EXPORT_SGR',
    p_sgr_description => q'|Regeln zur Dialogseite "Regelgruppe exportieren"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 8,
    p_sgr_with_recursion => 'Y',
    p_sgr_active => 'Y');
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(312),
    p_sru_sgr_id => sct_admin.map_id(110),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(417),
    p_sra_sru_id => sct_admin.map_id(312),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'P8_EXPORT_TYPE',
    p_sra_sat_id => 'SET_ITEM',
    p_sra_param_1 => q'|sct_ui_pkg.get_export_type|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(327),
    p_sru_sgr_id => sct_admin.map_id(110),
    p_sru_name => '"Alle Regelgruppen exportieren" gewaehlt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'ALL_SGR'|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(326),
    p_sra_sru_id => sct_admin.map_id(327),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'TOGGLE_ITEMS',
    p_sra_param_1 => q'|.sct-ui-export-all|',
    p_sra_param_2 => q'|.sct-ui-hide|',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(366),
    p_sra_sru_id => sct_admin.map_id(327),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(331),
    p_sru_sgr_id => sct_admin.map_id(110),
    p_sru_name => '"Regelgruppen einer Anwendung exportieren" gewählt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'APP'|',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(380),
    p_sra_sru_id => sct_admin.map_id(331),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(330),
    p_sra_sru_id => sct_admin.map_id(331),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'TOGGLE_ITEMS',
    p_sra_param_1 => q'|.sct-ui-export-app|',
    p_sra_param_2 => q'|.sct-ui-hide|',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(337),
    p_sru_sgr_id => sct_admin.map_id(110),
    p_sru_name => '"Eine Regelgruppe exportieren" gewählt',
    p_sru_condition => q'|P8_EXPORT_TYPE = 'SGR'|',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(442),
    p_sra_sru_id => sct_admin.map_id(337),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 40,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(334),
    p_sra_sru_id => sct_admin.map_id(337),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'TOGGLE_ITEMS',
    p_sra_param_1 => q'|.sct-ui-export-sgr|',
    p_sra_param_2 => q'|.sct-ui-hide|',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(335),
    p_sra_sru_id => sct_admin.map_id(337),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(336),
    p_sra_sru_id => sct_admin.map_id(337),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(357),
    p_sru_sgr_id => sct_admin.map_id(110),
    p_sru_name => 'Anwendung geändert bei Export einer Einzelgruppe',
    p_sru_condition => q'|firing_item = 'P8_SGR_APP_ID' and P8_EXPORT_TYPE = 'SGR'|',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(604),
    p_sra_sru_id => sct_admin.map_id(357),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(356),
    p_sra_sru_id => sct_admin.map_id(357),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'P8_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(363),
    p_sru_sgr_id => sct_admin.map_id(110),
    p_sru_name => 'Anwendungsseite geändert',
    p_sru_condition => q'|firing_item = 'P8_SGR_PAGE_ID'|',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(362),
    p_sra_sru_id => sct_admin.map_id(363),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'P8_SGR_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(375),
    p_sru_sgr_id => sct_admin.map_id(110),
    p_sru_name => 'Regelgruppe gewählt',
    p_sru_condition => q'|firing_item = 'P8_SGR_ID'|',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(374),
    p_sra_sru_id => sct_admin.map_id(375),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(388),
    p_sru_sgr_id => sct_admin.map_id(110),
    p_sru_name => 'Anwendung geändert bei Export aller Gruppen einer Anwendung',
    p_sru_condition => q'|firing_item = 'P8_SGR_APP_ID' and P8_EXPORT_TYPE = 'APP'|',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(387),
    p_sra_sru_id => sct_admin.map_id(388),
    p_sra_sgr_id => sct_admin.map_id(110),
    p_sra_spi_id => 'B8_EXPORT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_export_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');
  
  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(281),
    p_saa_sgr_id => sct_admin.map_id(110),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'export-rulegroup',
    p_saa_label => 'Regelgruppe(n) exportieren',
    p_saa_context_label => '',
    p_saa_icon => '',
    p_saa_icon_type => '',
    p_saa_title => 'Exportiert die gewählten Regelgruppen',
    p_saa_shortcut => 'Alt+E',
    p_saa_initially_disabled => 'Y',
    p_saa_initially_hidden => 'N',
    p_saa_href => '',
    p_saa_action => '');
  
  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(281),
    p_sai_spi_sgr_id => sct_admin.map_id(110),
    p_sai_spi_id => 'B8_EXPORT',
    p_sai_active => 'Y');


  sct_admin.propagate_rule_change(sct_admin.map_id(110));

  commit;
end;
/

set define on
