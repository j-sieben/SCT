define sql_dir=apex/sql/
define seq_dir=$sql_dir./sequences
define table_dir=$sql_dir./tables
define type_dir=$sql_dir./types
define view_dir=$sql_dir./views
define plsql_dir=apex/plsql/

prompt &h3.Check installation prerquisites
@apex/check_prerequisites.sql

prompt &h3.Remove existing installation
@apex/clean_up_install.sql

prompt &h3.Setting compile flags
@apex/set_compile_flags.sql


prompt &h3.Create SEQUENCES


prompt &h3.Create TABLES


prompt &h3.Create VIEWS
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


prompt &h3.Create PACKAGES
prompt &s1.Create package UI_SCT
@&plsql_dir.ui_sct.pks
show errors

prompt &s1.Create package body UI_SCT
@&plsql_dir.UI_SCT.pkb
show errors
