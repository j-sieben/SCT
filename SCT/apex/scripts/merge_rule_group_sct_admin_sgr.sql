
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_ADMIN_SGR');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 1,
    p_sgr_name => 'SCT_ADMIN_SGR');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(1),
    p_sgr_name => 'SCT_ADMIN_SGR',
    p_sgr_description => q'|Hauptseite der SCT-Administration|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 1,
    p_sgr_with_recursion => sct_util.C_TRUE,
    p_sgr_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(9),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => 'Anwendungsfilter ist nicht leer',
    p_sru_condition => q'|P1_SGR_APP_ID is not null|',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(11),
    p_sra_sru_id => sct_admin.map_id(9),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(13),
    p_sra_sru_id => sct_admin.map_id(9),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P1_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(15),
    p_sra_sru_id => sct_admin.map_id(9),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(17),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => 'Anwendungsfilter ist leer',
    p_sru_condition => q'|P1_SGR_APP_ID is null|',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(19),
    p_sra_sru_id => sct_admin.map_id(17),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(21),
    p_sra_sru_id => sct_admin.map_id(17),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P1_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(23),
    p_sra_sru_id => sct_admin.map_id(17),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(25),
    p_sra_sru_id => sct_admin.map_id(17),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P1_SGR_PAGE_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 40,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(27),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(445),
    p_sra_sru_id => sct_admin.map_id(27),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'SET_IG_SELECTION',
    p_sra_param_1 => q'|P1_SGR_ID|',
    p_sra_param_2 => q'|1|',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(557),
    p_sra_sru_id => sct_admin.map_id(27),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui.set_action_admin_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 60,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(31),
    p_sra_sru_id => sct_admin.map_id(27),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'HIDE_IR_IG_FILTER',
    p_sra_param_1 => q'|de.condes.plugin.sct.hideFilterPanel('R1_RULE_GROUP');|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(35),
    p_sra_sru_id => sct_admin.map_id(27),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'DIALOG_CLOSED',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 40,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(37),
    p_sra_sru_id => sct_admin.map_id(27),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'DIALOG_CLOSED',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(341),
    p_sra_sru_id => sct_admin.map_id(27),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'HIDE_IR_IG_FILTER',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 50,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(39),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => 'Regelgruppe gewählt',
    p_sru_condition => q'|firing_item = 'P1_SGR_ID'|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(43),
    p_sra_sru_id => sct_admin.map_id(39),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'DOCUMENT',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui.set_action_admin_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(45),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => 'Seitenfilter ist nicht leer',
    p_sru_condition => q'|P1_SGR_PAGE_ID is not null|',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(47),
    p_sra_sru_id => sct_admin.map_id(45),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(49),
    p_sra_sru_id => sct_admin.map_id(45),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(51),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => 'Seitenfilter ist leer',
    p_sru_condition => q'|P1_SGR_PAGE_ID is null|',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(53),
    p_sra_sru_id => sct_admin.map_id(51),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(55),
    p_sra_sru_id => sct_admin.map_id(51),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(57),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => 'Regeln aktualisiert',
    p_sru_condition => q'|dialog_closed ='R1_RULE_OVERVIEW'|',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(59),
    p_sra_sru_id => sct_admin.map_id(57),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(61),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => 'Regelgruppe aktualisiert',
    p_sru_condition => q'|dialog_closed = 'R1_RULE_GROUP'|',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => sct_util.C_FALSE,
    p_sru_active => sct_util.C_TRUE);
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(63),
    p_sra_sru_id => sct_admin.map_id(61),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_param_3 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => sct_util.C_FALSE,
    p_sra_raise_recursive => sct_util.C_TRUE,
    p_sra_active => sct_util.C_TRUE);
  
  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(67),
    p_saa_sgr_id => sct_admin.map_id(1),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'export-rulegroup',
    p_saa_label => 'SCT-Regel(n) exportieren',
    p_saa_context_label => 'Öffnet Anwendungsseite EXPORT_SGR',
    p_saa_icon => '',
    p_saa_icon_type => 'fa',
    p_saa_title => '',
    p_saa_shortcut => 'Alt+E',
    p_saa_initially_disabled => sct_util.C_FALSE,
    p_saa_initially_hidden => sct_util.C_FALSE,
    p_saa_href => '',
    p_saa_action => '');
  
  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(67),
    p_sai_spi_sgr_id => sct_admin.map_id(1),
    p_sai_spi_id => 'B1_EXPORT_SGR',
    p_sai_active => sct_util.C_TRUE);


  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(69),
    p_saa_sgr_id => sct_admin.map_id(1),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'create-rule',
    p_saa_label => 'Regel erzeugen',
    p_saa_context_label => 'Ruft Seite EDIT_SRU auf',
    p_saa_icon => '',
    p_saa_icon_type => '',
    p_saa_title => '',
    p_saa_shortcut => 'Alt+R',
    p_saa_initially_disabled => sct_util.C_TRUE,
    p_saa_initially_hidden => sct_util.C_FALSE,
    p_saa_href => 'foo',
    p_saa_action => '');
  
  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(69),
    p_sai_spi_sgr_id => sct_admin.map_id(1),
    p_sai_spi_id => 'B1_CREATE_SRU',
    p_sai_active => sct_util.C_TRUE);

  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(69),
    p_sai_spi_sgr_id => sct_admin.map_id(1),
    p_sai_spi_id => 'B1_CREATE_SRU_1',
    p_sai_active => sct_util.C_TRUE);


  sct_admin.propagate_rule_change(sct_admin.map_id(1));

  commit;
end;
/

set define on
