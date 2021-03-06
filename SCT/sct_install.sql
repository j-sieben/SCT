-- Parameters:
-- 1: Owner of SCT, schema into which SCT will be installed
-- 5: Default language of the messages
define tool_dir=tools/

@&tool_dir.init.sql &1. &2.

alter session set current_schema=sys;
prompt
prompt &section.
prompt &h1.Checking whether required users exist
@&tool_dir.check_users_exist.sql

prompt &h2.grant user rights
@set_grants.sql

alter session set current_schema=&INSTALL_USER.;
@&tool_dir.set_compiler_flags.sql

@&tool_dir.check_unit_test_exists.sql "unit_test/uninstall.sql" "clean up"
@&tool_dir.check_unit_test_exists.sql "unit_test/install.sql" "installation"

prompt
prompt &section.
prompt &h1.State Chart Toolkit (SCT)) Installation at user &INSTALL_USER.
@&core_dir.install.sql


prompt
prompt &section.
prompt &h1.PLUGIN SCT
@&plugin_dir.install.sql

prompt
prompt &section.
prompt &h1.Finalize installation
prompt &h2.Revoke user rights
@revoke_grants.sql

prompt &h1.Finished SCT-Installation

exit
