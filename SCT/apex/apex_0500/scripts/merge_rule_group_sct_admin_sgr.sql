
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
    p_sgr_id => sct_admin.map_id(2),
    p_sgr_name => 'SCT_ADMIN_SGR',
    p_sgr_description => q'|Hauptseite der SCT-Administration|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 1,
    p_sgr_with_recursion => 'Y',
    p_sgr_active => 'Y');
  
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(4),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Regelgruppe bekannt',
    p_sru_condition => q'|P1_SGR_ID is not null|',
    p_sru_sort_seq => 30,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(6),
    p_sra_sru_id => sct_admin.map_id(4),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(8),
    p_sra_sru_id => sct_admin.map_id(4),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'B1_CREATE_SRU',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_admin_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(10),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Anwendungsfilter ist nicht leer',
    p_sru_condition => q'|P1_SGR_APP_ID is not null|',
    p_sru_sort_seq => 50,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(12),
    p_sra_sru_id => sct_admin.map_id(10),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(14),
    p_sra_sru_id => sct_admin.map_id(10),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P1_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(16),
    p_sra_sru_id => sct_admin.map_id(10),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(18),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Anwendungsfilter ist leer',
    p_sru_condition => q'|P1_SGR_APP_ID is null|',
    p_sru_sort_seq => 40,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(20),
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(22),
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P1_SGR_PAGE_ID',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(24),
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(26),
    p_sra_sru_id => sct_admin.map_id(18),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P1_SGR_PAGE_ID',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 40,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(28),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Initialisierung',
    p_sru_condition => q'|initializing = 1|',
    p_sru_sort_seq => 10,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(659),
    p_sra_sru_id => sct_admin.map_id(28),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P1_SGR_APP_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(32),
    p_sra_sru_id => sct_admin.map_id(28),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'DIALOG_CLOSED',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(34),
    p_sra_sru_id => sct_admin.map_id(28),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'DIALOG_CLOSED',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 30,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(36),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Regelgruppe unbekannt',
    p_sru_condition => q'|P1_SGR_ID is null|',
    p_sru_sort_seq => 20,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(38),
    p_sra_sru_id => sct_admin.map_id(36),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(40),
    p_sra_sru_id => sct_admin.map_id(36),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'B1_CREATE_SRU',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_param_1 => q'|sct_ui_pkg.set_action_admin_sgr;|',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(42),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Seitenfilter ist nicht leer',
    p_sru_condition => q'|P1_SGR_PAGE_ID is not null|',
    p_sru_sort_seq => 70,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(44),
    p_sra_sru_id => sct_admin.map_id(42),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(46),
    p_sra_sru_id => sct_admin.map_id(42),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(48),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Seitenfilter ist leer',
    p_sru_condition => q'|P1_SGR_PAGE_ID is null|',
    p_sru_sort_seq => 60,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(50),
    p_sra_sru_id => sct_admin.map_id(48),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 20,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(52),
    p_sra_sru_id => sct_admin.map_id(48),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'EMPTY_FIELD',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(54),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Regeln aktualisiert',
    p_sru_condition => q'|dialog_closed ='R1_RULE_OVERVIEW'|',
    p_sru_sort_seq => 80,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(56),
    p_sra_sru_id => sct_admin.map_id(54),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_OVERVIEW',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(58),
    p_sru_sgr_id => sct_admin.map_id(2),
    p_sru_name => 'Regelgruppe aktualisiert',
    p_sru_condition => q'|dialog_closed = 'R1_RULE_GROUP'|',
    p_sru_sort_seq => 90,
    p_sru_fire_on_page_load => 'N',
    p_sru_active => 'Y');
  
  sct_admin.merge_rule_action(
    p_sra_id => sct_admin.map_id(60),
    p_sra_sru_id => sct_admin.map_id(58),
    p_sra_sgr_id => sct_admin.map_id(2),
    p_sra_spi_id => 'R1_RULE_GROUP',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_param_1 => q'||',
    p_sra_param_2 => q'||',
    p_sra_sort_seq => 10,
    p_sra_on_error => 'N',
    p_sra_raise_recursive => 'Y',
    p_sra_active => 'Y');
  
  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(62),
    p_saa_sgr_id => sct_admin.map_id(2),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'copy-rulegroup',
    p_saa_label => 'Regelgruppe kopieren',
    p_saa_context_label => '',
    p_saa_icon => '',
    p_saa_icon_type => 'fa',
    p_saa_title => '',
    p_saa_shortcut => 'Alt+C',
    p_saa_initially_disabled => 'Y',
    p_saa_initially_hidden => 'N',
    p_saa_href => 'Foo',
    p_saa_action => '');
  
  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(62),
    p_sai_spi_sgr_id => sct_admin.map_id(2),
    p_sai_spi_id => 'B1_COPY_SGR',
    p_sai_active => 'Y');



  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(64),
    p_saa_sgr_id => sct_admin.map_id(2),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'export-rulegroup',
    p_saa_label => 'Regelgruppe exportieren',
    p_saa_context_label => 'Öffnet Anwendungsseite EXPORT_SGR',
    p_saa_icon => '',
    p_saa_icon_type => 'fa',
    p_saa_title => '',
    p_saa_shortcut => 'Alt+E',
    p_saa_initially_disabled => 'N',
    p_saa_initially_hidden => 'N',
    p_saa_href => '',
    p_saa_action => '');
  
  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(64),
    p_sai_spi_sgr_id => sct_admin.map_id(2),
    p_sai_spi_id => 'B1_EXPORT_SGR',
    p_sai_active => 'Y');



  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(66),
    p_saa_sgr_id => sct_admin.map_id(2),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'create-rule',
    p_saa_label => 'Regel erzeugen',
    p_saa_context_label => 'Ruft Seite EDIT_SRU auf',
    p_saa_icon => '',
    p_saa_icon_type => '',
    p_saa_title => '',
    p_saa_shortcut => 'Alt+R',
    p_saa_initially_disabled => 'Y',
    p_saa_initially_hidden => 'N',
    p_saa_href => 'foo',
    p_saa_action => '');
  
  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(66),
    p_sai_spi_sgr_id => sct_admin.map_id(2),
    p_sai_spi_id => 'B1_CREATE_SRU',
    p_sai_active => 'Y');


  sct_admin.merge_apex_action_item(
    p_sai_saa_id => sct_admin.map_id(66),
    p_sai_spi_sgr_id => sct_admin.map_id(2),
    p_sai_spi_id => 'B1_CREATE_SRU_1',
    p_sai_active => 'Y');


  sct_admin.propagate_rule_change(sct_admin.map_id(2));

  commit;
end;
/

set define on
