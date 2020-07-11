
set define ^

declare
  l_foo number;
  l_app_id number;
begin
  l_foo := sct_admin.map_id;
  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);

  dbms_output.put_line('#s1.Rulegroup SCT_COPY_SGR');

  sct_admin.prepare_rule_group_import(
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 4,
    p_sgr_name => 'SCT_COPY_SGR');

  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(71),
    p_sgr_name => 'SCT_COPY_SGR',
    p_sgr_description => q'|Regeln zur Dialogseite "Regelgruppe kopieren"|',
    p_sgr_app_id => l_app_id,
    p_sgr_page_id => 4,
    p_sgr_with_recursion => sct_util.C_TRUE,
    p_sgr_active => sct_util.C_TRUE);
  
  
  sct_admin.propagate_rule_change(sct_admin.map_id(71));

  commit;
end;
/

set define on
