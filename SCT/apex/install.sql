define sql_dir=apex/sql/
define seq_dir=$sql_dir./sequences
define table_dir=$sql_dir./tables
define type_dir=$sql_dir./types
define view_dir=$sql_dir./views
define plsql_dir=apex/plsql/
define apex_dir=apex/apex/


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


prompt &s1.Install APEX application
@&apex_dir.sct.sql