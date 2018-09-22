define base_dir=apex/
define view_dir=&base_dir.views/
define pkg_dir=&base_dir.packages/
define msg_dir=&base_dir.messages/&DEFAULT_LANGUAGE./
define apex_dir=&base_dir.apex/

prompt &h3.Remove existing installation
@apex/clean_up_install.sql


prompt &h3.CREATE VIEWS
prompt &s1.Create view APEX_UI_LIST_MENU
@&view_dir.apex_ui_list_menu.vw

prompt &s1.Create view SCT_UI_ACTION_TYPE
@&view_dir.sct_ui_action_type.vw

prompt &s1.Create view SCT_UI_EDIT_GROUP
@&view_dir.sct_ui_edit_group.vw

prompt &s1.Create view SCT_UI_EDIT_GROUP_APEX_ACTION
@&view_dir.sct_ui_edit_group_apex_action.vw

prompt &s1.Create view SCT_UI_EDIT_RULE
@&view_dir.sct_ui_edit_rule.vw

prompt &s1.Create view SCT_UI_EDIT_APEX_ACTION
@&view_dir.sct_ui_edit_apex_action.vw

prompt &s1.Create view SCT_UI_EDIT_RULE_ACTION
@&view_dir.sct_ui_edit_rule_action.vw

prompt &s1.Create view SCT_UI_LIST_ACTION_TYPE
@&view_dir.sct_ui_list_action_type.vw

prompt &s1.Create view SCT_UI_LIST_PAGE_ITEMS
@&view_dir.sct_ui_list_page_items.vw

prompt &s1.Create view SCT_UI_LOV_APEX_ACTION_TYPE
@&view_dir.sct_ui_lov_apex_action_type.vw

prompt &s1.Create view SCT_UI_LOV_APP_PAGES
@&view_dir.sct_ui_lov_app_pages.vw

prompt &s1.Create view SCT_UI_LOV_APPLICATIONS
@&view_dir.sct_ui_lov_applications.vw

prompt &s1.Create view SCT_UI_LOV_PAGE_ITEMS
@&view_dir.sct_ui_lov_page_items.vw

prompt &s1.Create view SCT_UI_LOV_SGR_APP_PAGES
@&view_dir.sct_ui_lov_sgr_app_pages.vw

prompt &s1.Create view SCT_UI_LOV_SGR_APPLICATIONS
@&view_dir.sct_ui_lov_sgr_applications.vw

prompt &s1.Create view SCT_UI_LOV_SGR_PAGE_ITEMS
@&view_dir.sct_ui_lov_sgr_page_items.vw

prompt &s1.Create view SCT_UI_MAIN_GROUPS
@&view_dir.sct_ui_main_groups.vw

prompt &s1.Create view SCT_UI_MAIN_RULES
@&view_dir.sct_ui_main_rules.vw

prompt &s1.Create view SCT_UI_EDIT_SAA
@&view_dir.sct_ui_edit_saa.vw


prompt &h3.Create MESSAGES
@&msg_dir.create_messages.sql


prompt &h3.Create PACKAGES
prompt &s1.Create package SCT_UI_PKG
@&pkg_dir.sct_ui_pkg.pks
show errors

prompt &s1.Create package Body SCT_UI_PKG
@&pkg_dir.sct_ui_pkg.pkb
show errors


set serveroutput on
prompt &h3.Install APEX application
prompt &s1.Prepare APEX import
@&apex_dir.prepare_apex_import.sql

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
@&apex_dir.merge_rule_sct_admin_export_rule.sql
@&apex_dir.merge_rule_sct_admin_main.sql
@&apex_dir.merge_rule_sct_copy_rulegroup.sql