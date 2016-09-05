-- Parameters:
-- 1: Owner of SCT, package into which SCT will be installed
-- 2: APEX workspace name, into which the APEX application will be installed. Needs access to Owner of SCT

@init.sql &1. &2.

alter session set current_schema=sys;
prompt
prompt &section.
prompt &h1.Checking whether required users exist
@check_users_exist.sql

prompt &h2.grant user rights
@set_grants.sql

alter session set current_schema=&INSTALL_USER.;
@set_compiler_flags.sql

prompt
prompt &section.
prompt &h1.State Chart Toolkit (SCT)) Installation at user &INSTALL_USER.
@core/install.sql


prompt
prompt &section.
prompt &h1.PLUGIN SCT
@plugin/install.sql


prompt
prompt &section.
prompt &h1.APEX application SCT
@apex/install.sql


prompt
prompt &section.
prompt &h1.Finalize installation
prompt &h2.Revoke user rights
@revoke_grants.sql

prompt &h1.Finished PIT-Installation

exit
