define sql_dir=plugin/sql/
define seq_dir=&sql_dir./sequences/
define table_dir=&sql_dir./tables/
define type_dir=&sql_dir./types/
define view_dir=&sql_dir./views/
define plsql_dir=plugin/plsql/

prompt &h3.Check installation prerequisites
@plugin/check_prerequisites.sql

prompt &h3.Remove existing installation
@plugin/clean_up_install.sql

prompt &h3.Setting compile flags
@plugin/set_compile_flags.sql


prompt &h3.CREATE MESSAGES and PARAMETERS
prompt &s1.Create MESSAGES
@plugin/create_messages.sql

prompt &s1.Create PARAMETERS
@plugin/create_parameters.sql

prompt &h3.CREATE PACKAGES
prompt &s1.Create package PLUGIN_SCT
@&plsql_dir.plugin_sct.pks
show errors

prompt &s1.Create package body PLUGIN_SCT
@&plsql_dir.plugin_sct.pkb
show errors

--prompt &h3.Install plugin SCT
--prompt &s1.Plugin with embedded JS file
--@&sql_dir.dynamic_action_plugin_de_condes_plugin_sct.sql