define apex_dir=apex/
define apex_version_dir=&apex_dir.&APEX_PATH./
define seq_dir=&apex_dir.sequences/
define table_dir=&apex_dir.tables/
define type_dir=&apex_dir.types/
define view_dir=&apex_dir.views/
define pkg_dir=&apex_dir.packages/
define script_dir=&apex_dir.scripts/
define msg_dir=&apex_dir.messages/&DEFAULT_LANGUAGE./

prompt &h2.Remove existing installation
@&apex_dir.clean_up_install.sql

prompt &h2.Create database objects
prompt &h3.Create views

prompt &s1.Create view SCT_UI_LOV_ACTION_ITEM_FOCUS
@&view_dir.sct_ui_lov_action_item_focus.vw

prompt &s1.Create view SCT_UI_LOV_ACTION_PARAM_TYPE
@&view_dir.sct_ui_lov_action_param_type.vw

prompt &s1.Create view SCT_UI_LOV_ACTION_TYPE_GROUP
@&view_dir.sct_ui_lov_action_type_group.vw

prompt &s1.Create view SCT_UI_LOV_APEX_ACTION_ITEMS
@&view_dir.sct_ui_lov_apex_action_items.vw

prompt &s1.Create view SCT_UI_LOV_APEX_ACTION_TYPE
@&view_dir.sct_ui_lov_apex_action_type.vw

prompt &s1.Create view SCT_UI_LOV_APPLICATIONS
@&view_dir.sct_ui_lov_applications.vw

prompt &s1.Create view SCT_UI_LOV_APP_PAGES
@&view_dir.sct_ui_lov_app_pages.vw

prompt &s1.Create view SCT_UI_LOV_EXPORT_TYPES
@&view_dir.sct_ui_lov_export_types.vw

prompt &s1.Create view SCT_UI_LOV_EXPORT_SAT
@&view_dir.sct_ui_lov_export_sat.vw

prompt &s1.Create view SCT_UI_LOV_PAGE_ITEM_TYPE
@&view_dir.sct_ui_lov_page_item_type.vw

prompt &s1.Create view SCT_UI_LOV_PAGE_ITEMS
@&view_dir.sct_ui_lov_page_items.vw

prompt &s1.Create view SCT_UI_LOV_SGR_APPLICATIONS
@&view_dir.sct_ui_lov_sgr_applications.vw

prompt &s1.Create view SCT_UI_LOV_SGR_APP_PAGES
@&view_dir.sct_ui_lov_sgr_app_pages.vw

prompt &s1.Create view SCT_UI_LOV_SGR_PAGE_ITEMS
@&view_dir.sct_ui_lov_sgr_page_items.vw

prompt &s1.Create view SCT_UI_LOV_YES_NO
@&view_dir.sct_ui_lov_yes_no.vw


prompt &s1.Create view SCT_UI_ADMIN_SAT
@&view_dir.sct_ui_admin_sat.vw

prompt &s1.Create view SCT_UI_ADMIN_SGR_MAIN
@&view_dir.sct_ui_admin_sgr_main.vw

prompt &s1.Create view SCT_UI_ADMIN_SIF
@&view_dir.sct_ui_admin_sif.vw

prompt &s1.Create view SCT_UI_ADMIN_SGR_RULES
@&view_dir.sct_ui_admin_sgr_rules.vw

prompt &s1.Create view SCT_UI_EDIT_GROUP_APEX_ACTION
@&view_dir.sct_ui_edit_group_apex_action.vw

prompt &s1.Create view SCT_UI_EDIT_RULE
@&view_dir.sct_ui_edit_rule.vw

prompt &s1.Create view SCT_UI_EDIT_RULE_ACTION
@&view_dir.sct_ui_edit_rule_action.vw

prompt &s1.Create view SCT_UI_EDIT_SAA
@&view_dir.sct_ui_edit_saa.vw

prompt &s1.Create view SCT_UI_EDIT_SAT
@&view_dir.sct_ui_edit_sat.vw

prompt &s1.Create view SCT_UI_EDIT_SGR
@&view_dir.sct_ui_edit_sgr.vw

prompt &s1.Create view SCT_UI_EDIT_SGR_APEX_ACTION
@&view_dir.sct_ui_edit_sgr_apex_action.vw

prompt &s1.Create view SCT_UI_EDIT_SRA
@&view_dir.sct_ui_edit_sra.vw

prompt &s1.Create view SCT_UI_EDIT_SRU
@&view_dir.sct_ui_edit_sru.vw

prompt &s1.Create view SCT_UI_EDIT_SRU_ACTION
@&view_dir.sct_ui_edit_sru_action.vw

prompt &s1.Create view SCT_UI_EDIT_SIF
@&view_dir.sct_ui_edit_sif.vw

prompt &s1.Create view SCT_UI_EDIT_STG
@&view_dir.sct_ui_edit_stg.vw

prompt &s1.Create view SCT_UI_LIST_ACTION_TYPE
@&view_dir.sct_ui_list_action_type.vw

prompt &s1.Create view SCT_UI_LIST_PAGE_ITEMS
@&view_dir.sct_ui_list_page_items.vw

prompt &h2.Create Translatable items
@&msg_dir.TranslatableItemGroup_SCT.sql


prompt &h2.Create PL/SQL objects
prompt &h3.Create packages

prompt &s1.Create package SCT_UI
@&pkg_dir.sct_ui.pks
show errors

prompt &s1.Create package Body SCT_UI
@&pkg_dir.sct_ui.pkb
show errors

prompt &h2.Version specific installation
@&apex_version_dir.install.sql

-- Re-Init after APEX install
@tools/re_init_apex.sql

prompt &h3.Install SCT rules
prompt &s1.Create action types
@&script_dir.action_types_system.sql

prompt &s1.Create page rules
@&script_dir.merge_rule_group_sct_admin_sgr.sql
@&script_dir.merge_rule_group_sct_edit_saa.sql
@&script_dir.merge_rule_group_sct_edit_sgr.sql
@&script_dir.merge_rule_group_sct_edit_sra.sql
@&script_dir.merge_rule_group_sct_edit_sru.sql
@&script_dir.merge_rule_group_sct_export_sat.sql
@&script_dir.merge_rule_group_sct_export_sgr.sql

