begin
  sct_admin.merge_apex_action_type(
    p_sty_id => 'ACTION',
    p_sty_display_name => 'Befehl/Verweis',
    p_sty_description => 'JavaScript oder PL/SQL-Befehl, alternativ Verweis');
    
  sct_admin.merge_apex_action_type(
    p_sty_id => 'TOGGLE',
    p_sty_display_name => 'Schalter',
    p_sty_description => 'Wahlschalter (JA|NEIN)');
    
  sct_admin.merge_apex_action_type(
    p_sty_id => 'RADIO_GROUP',
    p_sty_display_name => 'Optionsgruppe',
    p_sty_description => 'Auswahlliste, Optionsfelder');
    
  commit;
end;
/