
begin

  -- ACTION TYPES
  sct_admin.merge_action_type(
    p_sat_id => 'CHECK_MANDATORY',
    p_sat_name => 'Pflichtfeld prüfen',
    p_sat_pl_sql => q'~plugin_sct.check_mandatory('#ITEM#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_ITEM',
    p_sat_name => 'Ziel deaktivieren',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();
apex.item('#ITEM#').disable();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'GET_SEQ_VAL',
    p_sat_name => 'Sequenzwert ermitteln',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', #ATTRIBUTE#.nextval);~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'HIDE_ITEM',
    p_sat_name => 'Ziel ausblenden',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_MANDATORY',
    p_sat_name => 'Feld ist Pflichtfeld',
    p_sat_pl_sql => q'~plugin_sct.register_mandatory('#ITEM#', '#ATTRIBUTE#', true);~',
    p_sat_js => q'~de.condes.plugin.sct.setMandatory('#ITEM#', true);~',
    p_sat_is_editable => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_OPTIONAL',
    p_sat_name => 'Feld ist optional',
    p_sat_pl_sql => q'~plugin_sct.register_mandatory('#ITEM#', null, false);~',
    p_sat_js => q'~de.condes.plugin.sct.setMandatory('#ITEM#', false);~',
    p_sat_is_editable => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'JAVA_SCRIPT_CODE',
    p_sat_name => 'JavaScript-Code ausführen',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~#ATTRIBUTE#~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'PLSQL_CODE',
    p_sat_name => 'PL/SQL-Code ausführen',
    p_sat_pl_sql => q'~begin #ATTRIBUTE# end;~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_ITEM',
    p_sat_name => 'Ziel aktualisieren (Refresh)',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~$('##ITEM#').trigger('apexrefresh');
  apex.item('#ITEM#').enable();
  apex.item('#ITEM#').show();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ITEM',
    p_sat_name => 'Feld auf Wert setzen',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '#ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_DISABLE',
    p_sat_name => 'Feld leeren und deaktivieren',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').show;
apex.item('#ITEM#').disable();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_HIDE',
    p_sat_name => 'Feld leeren und ausblenden',
    p_sat_pl_sql => q'~plugin_sct.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ERROR',
    p_sat_name => 'Fehler anzeigen',
    p_sat_pl_sql => q'~plugin_sct.register_error('#ITEM#', '#ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ITEM',
    p_sat_name => 'Ziel anzeigen',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();
apex.item('#ITEM#').enable();~',
    p_sat_is_editable => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT',
    p_sat_name => 'Seite absenden',
    p_sat_pl_sql => q'~plugin_sct.submit_page;~',
    p_sat_js => q'~de.condes.plugin.sct.submit('#ATTRIBUTE#')~',
    p_sat_is_editable => 0);

  -- RULE GROUP SCT_GLOBAL (ID 0
  sct_admin.merge_rule_group(
    p_sgr_app_id => null,
    p_sgr_page_id => null,
    p_sgr_id => 0,
    p_sgr_name => q'~SCT_GLOBAL~',
    p_sgr_description => q'~Globale Regeln, werden immer angewendet~',
    p_sgr_active => 1);
    
  merge into sct_page_item spi
  using (select 0 spi_sgr_id,
                'ALL' spi_id,
                'ITEM' spi_sit_id,
                q'~v(('#ITEM#')~' spi_conversion
           from dual) v
     on (spi.spi_sgr_id = v.spi_sgr_id and spi.spi_id = v.spi_id)
   when not matched then insert (spi_sgr_id, spi_id, spi_sit_id, spi_conversion)
        values (v.spi_sgr_id, v.spi_id, v.spi_sit_id, v.spi_conversion);

  -- RULES~
  sct_admin.merge_rule(
    p_sru_id => 0,
    p_sru_sgr_id => 0,
    p_sru_name => q'~Pflichtfeld~',
    p_sru_condition => q'~firing_item = sra_spi_id~',
    p_sru_sort_seq => 9999,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => 0,
    p_sra_sgr_id => 0,
    p_sra_spi_id => 'ALL',
    p_sra_sat_id => 'CHECK_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  commit;
end;
/