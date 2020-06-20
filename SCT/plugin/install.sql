define plugin_dir=plugin/

prompt &h2.Remove existing installation
@&plugin_dir.clean_up_install.sql

prompt &h2.Create PL/SQL objects
prompt &h3.Create packages

prompt &s1.Create package PLUGIN_SCT
@&plugin_dir.packages/plugin_sct.pks
show errors

prompt &s1.Create package Body PLUGIN_SCT
@&plugin_dir.packages/plugin_sct.pkb
show 