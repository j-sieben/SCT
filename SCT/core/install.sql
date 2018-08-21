define sql_dir=core/sql/
define seq_dir=&sql_dir.sequences/
define table_dir=&sql_dir.tables/
define type_dir=&sql_dir.types/
define view_dir=&sql_dir.views/
define script_dir=&sql_dir.scripts/
define message_dir=&sql_dir.messages/&DEFAULT_LANGUAGE./
define plsql_dir=core/plsql/

prompt &h3.Check installation prerequisites
@core/check_prerequisites.sql

prompt &h3.Remove existing installation
@core/clean_up_install.sql

prompt &h3.Setting compile flags
@core/set_compile_flags.sql


prompt &h3.Create sequences
prompt &s1.Create sequence SCT_SEQ
@&seq_dir.sct_seq.seq

prompt &h3.Create tables and initial data
prompt &s1.Create table SCT_RULE_GROUP
@&table_dir.sct_rule_group.tbl

prompt &s1.Create table SCT_ACTION_TYPE
@&table_dir.sct_action_type.tbl

prompt &s1.Create table SCT_PAGE_ITEM_TYPE
@&table_dir.sct_page_item_type.tbl

prompt &s1.Create table SCT_PAGE_ITEM
@&table_dir.sct_page_item.tbl

prompt &s1.Create table SCT_RULE
@&table_dir.sct_rule.tbl

prompt &s1.Create table SCT_RULE_ACTION
@&table_dir.sct_rule_action.tbl


prompt &s1.Create view SCT_BL_RULES
@&view_dir.sct_bl_rules.vw

prompt &s1.Create view SCT_BL_PAGE_TARGETS
@&view_dir.sct_bl_page_targets.vw


prompt &h3.Create SCT messages
@&message_dir.create_messages.sql

prompt &h3.Create CodeGenerator templates
@&script_dir.merge_code_generator_templates.sql

prompt &h3.Create packages
prompt &s1.Checking UTL_TEXT exists
@core/check_has_utl_text.sql core/utl_text.sql

prompt &s1.Create package SCT_CONST
@&plsql_dir.sct_const.pks
show errors

prompt &s1.Create package SCT_ADMIN
@&plsql_dir.sct_admin.pks
show errors

prompt &s1.Create package Body SCT_ADMIN
@&plsql_dir.sct_admin.pkb
show errors
show errors

prompt &s1.Create package BL_SCT
@&plsql_dir.bl_sct.pks
show errors

prompt &s1.Create package Body BL_SCT
@&plsql_dir.bl_sct.pkb
show errors

prompt &h3.Create base action types
@core/merge_base_action_types.sql
