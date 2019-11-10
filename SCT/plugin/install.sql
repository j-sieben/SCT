define plugin_dir=plugin/
define msg_dir=&plugin_dir.messages/&DEFAULT_LANGUAGE./

prompt &h2.Check installation prerequisites
@&plugin_dir.check_prerequisites.sql

prompt &h2.Remove existing installation
@&plugin_dir.clean_up_install.sql

prompt &h2.Merge default data
prompt &h3.Create SCT parameters
@&plugin_dir.scripts/create_parameters.sql

prompt &h3.Create SCT messages
@&msg_dir.create_messages.sql

prompt &h2.Create PL/SQL objects
prompt &h3.Create packages

prompt &s1.Create package SCT_INTERNAL
@&plugin_dir.packages/sct_internal.pks
show errors

prompt &s1.Create package PLUGIN_SCT
@&plugin_dir.packages/plugin_sct.pks
show errors

prompt &s1.Create package SCT
@&plugin_dir.packages/sct.pks
show errors

prompt &s1.Create package SCT_VALIDATION
@&plugin_dir.packages/sct_validation.pks
show errors

prompt &s1.Create package UTL_APEX_ACTION
@&plugin_dir.packages/utl_apex_action.pks
show errors

prompt &h3.Create package bodies
prompt &s1.Create package Body SCT_INTERNAL
@&plugin_dir.packages/sct_internal.pkb
show errors

prompt &s1.Create package Body PLUGIN_SCT
@&plugin_dir.packages/plugin_sct.pkb
show 


prompt &s1.Create package Body SCT
@&plugin_dir.packages/sct.pkb
show errors

prompt &s1.Create package Body SCT_VALIDATION
@&plugin_dir.packages/sct_validation.pkb
show errors

prompt &s1.Create package Body UTL_APEX_ACTION
@&plugin_dir.packages/utl_apex_action.pkb
show errors