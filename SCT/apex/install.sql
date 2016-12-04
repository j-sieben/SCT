define sql_dir=apex/sql/
define seq_dir=&sql_dir./sequences/
define table_dir=&sql_dir./tables/
define type_dir=&sql_dir./types/
define view_dir=&sql_dir./views/
define plsql_dir=apex/plsql/
define apex_dir=apex/apex/


prompt &h3.Check installation prerquisites
@apex/check_prerequisites.sql

prompt &h3.Remove existing installation
@apex/clean_up_install.sql

prompt &h3.Setting compile flags
@apex/set_compile_flags.sql


prompt &h3.CREATE SEQUENCES


prompt &h3.CREATE TABLES


prompt &h3.CREATE VIEWS
prompt &s1.Create view SCT_UI_ACTION_TYPE
@&view_dir.sct_ui_action_type.vw

prompt &s1.Create view SCT_UI_EDIT_RULE
@&view_dir.sct_ui_edit_rule.vw

prompt &s1.Create view SCT_UI_LIST_ACTION_TYPE
@&view_dir.sct_ui_list_action_type.vw

prompt &s1.Create view SCT_UI_LIST_PAGE_ITEMS
@&view_dir.sct_ui_list_page_items.vw

prompt &s1.Create view SCT_UI_LOV_APP_PAGES
@&view_dir.sct_ui_lov_app_pages.vw

prompt &s1.Create view SCT_UI_LOV_APPLICATIONS
@&view_dir.sct_ui_lov_applications.vw

prompt &s1.Create view SCT_UI_LOV_PAGE_ITEMS
@&view_dir.sct_ui_lov_page_items.vw

prompt &s1.Create view SCT_UI_LOV_SGR_APP_PAGES
@&view_dir.sct_ui_lov_app_sgr_pages.vw

prompt &s1.Create view SCT_UI_LOV_SGR_APPLICATIONS
@&view_dir.sct_ui_lov_sgr_applications.vw

prompt &s1.Create view SCT_UI_LOV_SGR_PAGE_ITEMS
@&view_dir.sct_ui_lov_sgr_page_items.vw

prompt &s1.Create view SCT_UI_MAIN_GROUPS
@&view_dir.sct_ui_main_groups.vw

prompt &s1.Create view SCT_UI_MAIN_RULES
@&view_dir.sct_ui_main_rules.vw


prompt &h3.Create packages
prompt &s1.Checking UTL_APEX exists
@check_has_package.sql UTL_APEX apex/utl_apex.sql

prompt &s1.Create package SCT_UI_PKG
@&plsql_dir.sct_ui_pkg.pks
show errors

prompt &s1.Create package Body SCT_UI_PKG
@&plsql_dir.sct_ui_pkg.pkb
show errors


prompt &h3.Install APEX application
prompt &s1.Prepare APEX import
--@&apex_dir.prepare_apex_import.sql

prompt &s1.Install application
@&apex_dir.sct.sql

-- After APEX installation, reset output settings
set define on
set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
alter session set current_schema=&INSTALL_USER.;

prompt &h3.Recompiling SCT_ADMIN to prepare SCT rules import
alter package sct_admin compile package;

prompt &s1.Import SCT rules
@&apex_dir.sct_rules.sql