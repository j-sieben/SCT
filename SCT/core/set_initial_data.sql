begin
  -- ACTION TYPES

  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_ITEM',
    p_sat_name => 'Feld deaktivieren',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').disable();~',
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
    p_sat_name => 'Feld aktualisieren (Refresh)',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~$('##ITEM#').trigger('apexrefresh');~',
    p_sat_changes_value => 'N');


  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_DISABLE',
    p_sat_name => 'Feld leeren und deaktivieren',
    p_sat_pl_sql => q'~apex_util.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').disable();~',
    p_sat_changes_value => 'Y');


  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_HIDE',
    p_sat_name => 'Feld leeren und ausblenden',
    p_sat_pl_sql => q'~apex_util.set_session_state('#ITEM#', '');~',
    p_sat_js => q'~apex.item('#ITEM#').hide();~',
    p_sat_changes_value => 'Y');


  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ITEM',
    p_sat_name => 'Feld anzeigen',
    p_sat_pl_sql => q'~~',
    p_sat_js => q'~apex.item('#ITEM#').show();~',
    p_sat_changes_value => 'N');

  commit;
end;
/
