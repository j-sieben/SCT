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
prompt &s1.Create view UI_SCT_ACTION_TYPE
@&view_dir.ui_sct_action_type.vw

prompt &s1.Create view UI_SCT_EDIT_RULE
@&view_dir.ui_sct_edit_rule.vw

prompt &s1.Create view UI_SCT_LIST_ACTION_TYPE
@&view_dir.ui_sct_list_action_type.vw

prompt &s1.Create view UI_SCT_LIST_PAGE_ITEMS
@&view_dir.ui_sct_list_page_items.vw

prompt &s1.Create view UI_SCT_LOV_PAGE_ITEMS
@&view_dir.ui_sct_lov_page_items.vw

prompt &s1.Create view UI_SCT_MAIN_GROUPS
@&view_dir.ui_sct_main_groups.vw

prompt &s1.Create view UI_SCT_MAIN_RULES
@&view_dir.ui_sct_main_rules.vw


prompt &h3.Create packages
prompt &s1.Create package UI_SCT_PKG
@&plsql_dir.ui_sct_pkg.pks
show errors

prompt &s1.Create package Body UI_SCT_PKG
@&plsql_dir.ui_sct_pkg.pkb
show errors


prompt &h3.Install APEX application
prompt &s1.Prepare APEX import
@&apex_dir.prepare_apex_import.sql

prompt &s1.Install application
@&apex_dir.sct.sql

-- After APEX installation, reset output settings
alter session set current_schema=&INSTALL_USER.;
set define &
set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit

prompt &s1.Recompiling schema to prepare SCT rules import
begin
  dbms_utility.compile_schema('&INSTALL_USER.');
end;
/

prompt &s1.Import SCT rules
@&apex_dir.sct_rules.sql