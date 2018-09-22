define core_dir=core/
define seq_dir=&core_dir.sequences/
define table_dir=&core_dir.tables/
define type_dir=&core_dir.types/
define view_dir=&core_dir.views/
define pkg_dir=&core_dir.packages/
define script_dir=&core_dir.scripts/
define msg_dir=&core_dir.messages/&DEFAULT_LANGUAGE./

prompt &h3.Check installation prerequisites
@core/check_prerequisites.sql

prompt &h3.Remove existing installation
@core/clean_up_install.sql

prompt &h3.Create sequences
prompt &s1.Create sequence SCT_SEQ
@&seq_dir.sct_seq.seq

prompt &h3.Create tables
prompt &s1.Create table SCT_RULE_GROUP
@&table_dir.sct_rule_group.tbl

prompt &s1.Create table SCT_ACTION_TYPE
@&table_dir.sct_action_type.tbl

prompt &s1.Create table SCT_APEX_ACTION_TYPE
@&table_dir.sct_apex_action_type.tbl

prompt &s1.Create table SCT_APEX_ACTION
@&table_dir.sct_apex_action.tbl

prompt &s1.Create table SCT_PAGE_ITEM_TYPE
@&table_dir.sct_page_item_type.tbl

prompt &s1.Create table SCT_PAGE_ITEM
@&table_dir.sct_page_item.tbl

prompt &s1.Create table SCT_RULE
@&table_dir.sct_rule.tbl

prompt &s1.Create table SCT_RULE_ACTION
@&table_dir.sct_rule_action.tbl


prompt &h3.Create views
prompt &s1.Create view SCT_BL_RULES
@&view_dir.sct_bl_rules.vw

prompt &s1.Create view SCT_BL_PAGE_TARGETS
@&view_dir.sct_bl_page_targets.vw


prompt &h3.Create SCT messages
@&msg_dir.create_messages.sql


prompt &h3.Create UTL_TEXT templates
@&script_dir.merge_utl_text_templates.sql

prompt &h3.Create packages
prompt &s1.Create package SCT_CONST
@&pkg_dir.sct_const.pks
show errors

prompt &s1.Create package SCT_ADMIN
@&pkg_dir.sct_admin.pks
show errors

prompt &s1.Create package Body SCT_ADMIN
@&pkg_dir.sct_admin.pkb
show errors
show errors

prompt &s1.Create package BL_SCT
@&pkg_dir.bl_sct.pks
show errors

prompt &s1.Create package Body BL_SCT
@&pkg_dir.bl_sct.pkb
show errors

prompt &h3.Merge initial data
prompt &s1.Create internal SCT rule group
@&script_dir.merge_sct_rule_group.sql

prompt &s1.Create SCT page item types
@&script_dir.merge_sct_page_item_type.sql

prompt &s1.Create internal SCT page item 
@&script_dir.merge_sct_page_item.sql

prompt &s1.Create SCT action types
@&script_dir.merge_sct_action_type.sql

prompt &s1.Create APEX action types
@&script_dir.merge_sct_apex_action_type.sql
