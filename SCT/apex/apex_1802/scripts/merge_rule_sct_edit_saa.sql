
set define ^

declare
  l_foo number;
begin
 l_foo := sct_admin.map_id;
  dbms_output.put_line('#s1.Rulegroup SCT_EDIT_SAA');
  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(201),
    p_sgr_name => 'SCT_EDIT_SAA',
    p_sgr_description => q'|Regeln zur Dialogseite "APEX-Aktionen editieren"|',
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, ^APP_ID.),
    p_sgr_page_id => 9,
    p_sgr_with_recursion => 0,
    p_sgr_active => 1);
  
  
  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(196),
    p_saa_sgr_id => sct_admin.map_id(201),
    p_saa_name => 'copy-rulegroup',
    p_saa_sty_id => 'ACTION',
    p_saa_label => 'Regelgruppe kopieren',
    p_saa_context_label => '',
    p_saa_icon => '',
    p_saa_icon_type => 'fa',
    p_saa_title => '',
    p_saa_shortcut => 'Alt+C',
    p_saa_initially_disabled => '1',
    p_saa_initially_hidden => '0',
    p_saa_href => '',
    p_saa_action => '');


  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(216),
    p_saa_sgr_id => sct_admin.map_id(201),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'export-rulegroup',
    p_saa_label => 'Regelgruppe(n) exportieren',
    p_saa_context_label => '',
    p_saa_icon => '',
    p_saa_icon_type => 'fa',
    p_saa_title => '',
    p_saa_shortcut => 'Alt+E',
    p_saa_initially_disabled => '0',
    p_saa_initially_hidden => '0',
    p_saa_href => '',
    p_saa_action => '');


  sct_admin.merge_apex_action(    
    p_saa_id => sct_admin.map_id(218),
    p_saa_sgr_id => sct_admin.map_id(201),
    p_saa_sty_id => 'ACTION',
    p_saa_name => 'create-rule',
    p_saa_label => 'Regel erzeugen',
    p_saa_context_label => '',
    p_saa_icon => '',
    p_saa_icon_type => 'fa',
    p_saa_title => '',
    p_saa_shortcut => 'Alt+R',
    p_saa_initially_disabled => '0',
    p_saa_initially_hidden => '0',
    p_saa_href => '',
    p_saa_action => '');
    
  sct_admin.propagate_rule_change(201);

  commit;
end;
/

set define on