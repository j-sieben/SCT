define base_dir=apex/
define view_dir=&base_dir.views/
define pkg_dir=&base_dir.packages/
define msg_dir=&base_dir.messages/&DEFAULT_LANGUAGE./
define apex_dir=&base_dir.&APEX_PATH./anwendung/
define apex_script_dir=&base_dir.&APEX_PATH./scripts/
define script_dir=&base_dir.scripts/

prompt &h2.Remove existing installation
@&base_dir.clean_up_install.sql

prompt &h2.Create database objects
prompt &h3.CREATE VIEWS

prompt &s1.Create view APEX_UI_LIST_MENU
@&view_dir.apex_ui_list_menu.vw

prompt &s1.Create view SCT_BL_PAGE_ITEMS
@&view_dir.sct_bl_page_items.vw

prompt &s1.Create view SCT_BL_SAT_HELP
@&view_dir.sct_bl_sat_help.vw

prompt &s1.Create view SCT_PARAM_LOV_APEX_ACTION
@&view_dir.sct_param_lov_apex_action.vw

prompt &s1.Create view SCT_PARAM_LOV_PAGE_ITEM
@&view_dir.sct_param_lov_page_item.vw

prompt &s1.Create view SCT_PARAM_LOV_PIT_MESSAGE
@&view_dir.sct_param_lov_pit_message.vw

prompt &s1.Create view SCT_PARAM_LOV_SEQUENCE
@&view_dir.sct_param_lov_sequence.vw

prompt &s1.Create view SCT_UI_ADMIN_SAT
@&view_dir.sct_ui_admin_sat.vw

prompt &s1.Create view SCT_UI_ADMIN_SGR_MAIN
@&view_dir.sct_ui_admin_sgr_main.vw

prompt &s1.Create view SCT_UI_ADMIN_SGR_RULES
@&view_dir.sct_ui_admin_sgr_rules.vw

prompt &s1.Create view SCT_UI_EDIT_SAA
@&view_dir.sct_ui_edit_saa.vw

prompt &s1.Create view SCT_UI_EDIT_SGR
@&view_dir.sct_ui_edit_sgr.vw

prompt &s1.Create view SCT_UI_EDIT_SGR_APEX_ACTION
@&view_dir.sct_ui_edit_sgr_apex_action.vw

prompt &s1.Create view SCT_UI_EDIT_SRA
@&view_dir.sct_ui_edit_sra.vw

prompt &s1.Create view SCT_UI_EDIT_SRU
@&view_dir.sct_ui_edit_sru.vw

prompt &s1.Create view SCT_UI_EDIT_SRU_ACTION
@&view_dir.sct_ui_edit_SRU_action.vw

prompt &s1.Create view SCT_UI_LIST_ACTION_TYPE
@&view_dir.sct_ui_list_action_type.vw

prompt &s1.Create view SCT_UI_LIST_PAGE_ITEMS
@&view_dir.sct_ui_list_page_items.vw

prompt &s1.Create view SCT_UI_LOV_APEX_ACTION_TYPE
@&view_dir.sct_ui_lov_apex_action_type.vw

prompt &s1.Create view SCT_UI_LOV_APEX_ACTION_ITEMS
@&view_dir.sct_ui_lov_apex_action_items.vw

prompt &s1.Create view SCT_UI_LOV_APP_PAGES
@&view_dir.sct_ui_lov_app_pages.vw

prompt &s1.Create view SCT_UI_LOV_APPLICATIONS
@&view_dir.sct_ui_lov_applications.vw

prompt &s1.Create view SCT_UI_LOV_EXPORT_TYPES
@&view_dir.sct_ui_lov_export_types.vw

prompt &s1.Create view SCT_UI_LOV_PAGE_ITEMS
@&view_dir.sct_ui_lov_page_items.vw

prompt &s1.Create view SCT_UI_LOV_SGR_APP_PAGES
@&view_dir.sct_ui_lov_sgr_app_pages.vw

prompt &s1.Create view SCT_UI_LOV_SGR_APPLICATIONS
@&view_dir.sct_ui_lov_sgr_applications.vw

prompt &s1.Create view SCT_UI_LOV_SGR_PAGE_ITEMS
@&view_dir.sct_ui_lov_sgr_page_items.vw

prompt &s1.Create view SCT_UI_LOV_YES_NO
@&view_dir.sct_ui_lov_yes_no.vw

prompt &h2.Merge default data
prompt &h3.Create MESSAGES
@&msg_dir.create_messages.sql

prompt &h3.Create TRANSLATABLE ITEMS
@&msg_dir.create_translatable_items.sql


prompt &h2.Create PL/SQL objects
prompt &h3.Create packages
prompt &s1.Create package SCT_UI_PKG
@&pkg_dir.sct_ui_pkg.pks
show errors

prompt &s1.Create package PLUGIN_GROUP_SELECT_LIST
@&pkg_dir.plugin_group_select_list.pks
show errors

prompt &h3.Create package bodies
prompt &s1.Create package Body SCT_UI_PKG
@&pkg_dir.sct_ui_pkg.pkb
show errors

prompt &s1.Create package Body PLUGIN_GROUP_SELECT_LIST
@&pkg_dir.plugin_group_select_list.pkb
show errors


set serveroutput on
prompt &h2.Install APEX application
prompt &h3.Prepare APEX import
@&base_dir.prepare_app_import.sql

prompt &h3.Install application
@&apex_dir.sct.sql

prompt &h3.Prepare Manual import
--@&base_dir.prepare_manual_import.sql

prompt &h3.Install application manual
--@&apex_dir.sct_manual.sql

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

prompt &h2.Recompiling SCT_ADMIN to prepare SCT rules import
alter package sct_admin compile package;

call dbms_session.reset_package();

prompt &h2.Create SCT rules
prompt &s1.Import SCT_ADMIN_SGR rule
@&apex_script_dir.merge_rule_group_sct_admin_sgr.sql

prompt &s1.Import SCT_COPY_SGR rule
@&apex_script_dir.merge_rule_group_sct_copy_sgr.sql

prompt &s1.Import SCT_EDIT_SAA rule
@&apex_script_dir.merge_rule_group_sct_edit_saa.sql

prompt &s1.Import SCT_EDIT_SGR rule
@&apex_script_dir.merge_rule_group_sct_edit_sgr.sql

prompt &s1.Import SCT_EDIT_SRA rule
@&apex_script_dir.merge_rule_group_sct_edit_sra.sql

prompt &s1.Import SCT_EDIT_SRU rule
@&apex_script_dir.merge_rule_group_sct_edit_sru.sql

prompt &s1.Import SCT_EXPORT_SGR rule
@&apex_script_dir.merge_rule_group_sct_export_sgr.sql
