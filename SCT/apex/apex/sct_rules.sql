declare
  l_foo binary_integer;
begin
  l_foo := sct_admin.map_id;

  -- ACTION TYPES
  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_ITEM',
    p_sat_name => 'Ziel deaktivieren',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();
apex.item('#ITEM#').disable();~',
    p_sat_changes_value => 'N');

  sct_admin.merge_action_type(
    p_sat_id => 'HIDE_ITEM',
    p_sat_name => 'Ziel ausblenden',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_changes_value => 'N');

  sct_admin.merge_action_type(
    p_sat_id => 'JAVA_SCRIPT_CODE',
    p_sat_name => 'JavaScript-Code ausführen',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~#ATTRIBUTE#~',
    p_sat_changes_value => 'N');

  sct_admin.merge_action_type(
    p_sat_id => 'PLSQL_CODE',
    p_sat_name => 'PL/SQL-Code ausführen',
    p_sat_pl_sql => q'~begin #ATTRIBUTE# end;~',
    p_sat_js => q'~~',
    p_sat_changes_value => 'Y');

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_ITEM',
    p_sat_name => 'Ziel aktualisieren (Refresh)',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~$('##ITEM#').trigger('apexrefresh');~',
    p_sat_changes_value => 'N');

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ITEM',
    p_sat_name => 'Feld auf Wert setzen',
    p_sat_pl_sql => q'~apex_util.set_session_state('#ITEM#', 'ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_changes_value => 'Y');

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_DISABLE',
    p_sat_name => 'Feld leeren und deaktivieren',
    p_sat_pl_sql => q'~apex_util.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').show;
apex.item('#ITEM#').disable();~',
    p_sat_changes_value => 'N');

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_HIDE',
    p_sat_name => 'Feld leeren und ausblenden',
    p_sat_pl_sql => q'~apex_util.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_changes_value => 'Y');

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ERROR',
    p_sat_name => 'Fehler anzeigen',
    p_sat_pl_sql => q'~plugin_sct.register_error('#ITEM#', '#ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_changes_value => 'N');

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ITEM',
    p_sat_name => 'Ziel anzeigen',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();
apex.item('#ITEM#').enable();~',
    p_sat_changes_value => 'N');

  -- RULE GROUPS
  sct_admin.merge_rule_group(
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, 131),
    p_sgr_page_id => 1,
    p_sgr_id => sct_admin.map_id(1),
    p_sgr_name => q'~SCT_ADMIN_MAIN~',
    p_sgr_description => q'~Hauptseite der SCT-Administration~');

  -- RULES
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(2),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Keine Regelgruppe gewählt~',
    p_sru_condition => q'~P1_SGR_ID is null~',
    p_sru_sort_seq => '20');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(3),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Regelgruppe gewählt~',
    p_sru_condition => q'~P1_SGR_ID is not null~',
    p_sru_sort_seq => '10');

  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(4),
    p_sru_sgr_id => sct_admin.map_id(1),
    p_sru_name => q'~Regelgruppe neu nummerieren~',
    p_sru_condition => q'~B1_RESEQUENCE_RULES = 'Y'~',
    p_sru_sort_seq => '30');

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B1_CREATE',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_sort_seq => '10');

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B1_RESEQUENCE_RULES',
    p_sra_sat_id => 'DISABLE_ITEM',
    p_sra_attribute => q'~~',
    p_sra_sort_seq => '20');

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(2),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'RULE',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_sort_seq => '30');

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B1_CREATE',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_sort_seq => '10');

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'B1_RESEQUENCE_RULES',
    p_sra_sat_id => 'SHOW_ITEM',
    p_sra_attribute => q'~~',
    p_sra_sort_seq => '20');

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(3),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'RULE',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_sort_seq => '30');

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(4),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'P1_SGR_ID',
    p_sra_sat_id => 'PLSQL_CODE',
    p_sra_attribute => q'~ui_sct_pkg.resequence_rule_group(v('#ITEM#'));~',
    p_sra_sort_seq => '10');

  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(4),
    p_sra_sgr_id => sct_admin.map_id(1),
    p_sra_spi_id => 'RULE',
    p_sra_sat_id => 'REFRESH_ITEM',
    p_sra_attribute => q'~~',
    p_sra_sort_seq => '20');

  commit;
end;
/