-- Parameters:
-- 1: Owner of SCT, package into which SCT will be installed
-- 2: APEX workspace name, into which the APEX application will be installed. Needs access to Owner of SCT

-- Update script assumes that INSTALL_USER is existing and has all necessary system privileges

@init.sql &1. &2.

prompt &section.
prompt &h1.ATTENTION! Make sur that all rule groups you want to keep have been exported successfully before running this script!
prompt Hit any key to resume this script. Press CTRL-C to cancel this script if you need to extract business rules first.
pause



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
prompt &h1.Finished PIT-Installation

exit
