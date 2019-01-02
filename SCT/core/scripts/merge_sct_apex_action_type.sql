begin
  sct_admin.merge_apex_action_type(
    p_sty_id => 'ACTION',
    p_sty_name => 'Befehl/Verweis',
    p_sty_description => 'JavaScript oder PL/SQL-Befehl, alternativ Verweis',
    p_sty_active => sct_util.C_TRUE);
    
  sct_admin.merge_apex_action_type(
    p_sty_id => 'TOGGLE',
    p_sty_name => 'Schalter',
    p_sty_description => 'Wahlschalter (JA|NEIN)',
    p_sty_active => sct_util.C_TRUE);
    
  sct_admin.merge_apex_action_type(
    p_sty_id => 'RADIO_GROUP',
    p_sty_name => 'Optionsgruppe',
    p_sty_description => 'Auswahlliste, Optionsfelder',
    p_sty_active => sct_util.C_TRUE);
    
  commit;
end;
/