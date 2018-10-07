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
prompt &s1.Create package PLUGIN_SCT
@&plugin_dir.packages/plugin_sct.pks
show errors

prompt &s1.Create package BL_SCT
@&plugin_dir.packages/bl_sct.pks
show errors

prompt &h3.Create package bodies
prompt &s1.Create package Body PLUGIN_SCT
@&plugin_dir.packages/plugin_sct.pkb
show errors

prompt &s1.Create package Body BL_SCT
@&plugin_dir.packages/bl_sct.pkb
show errors