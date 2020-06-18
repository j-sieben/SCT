define core_dir=core/
define seq_dir=&core_dir.sequences/
define table_dir=&core_dir.tables/
define type_dir=&core_dir.types/
define view_dir=&core_dir.views/
define pkg_dir=&core_dir.packages/
define script_dir=&core_dir.scripts/
define msg_dir=&core_dir.messages/&DEFAULT_LANGUAGE./

prompt &h2.Check installation prerequisites
@core/check_prerequisites.sql

prompt &h2.Remove existing installation
@core/clean_up_install.sql

prompt &h2.Checking whether utPLSQL is installed in usable version
@check_unit_test_exists.sql "null.sql" "preparation"

prompt &h2.Create database objects
prompt &h3.Create sequences
prompt &s1.Create sequence SCT_SEQ
@&seq_dir.sct_seq.seq

prompt &h2.Predefine package SCT_UTIL for reference from views
prompt &s1.Create package SCT_UTIL
@&pkg_dir.sct_util.pks
show errors

prompt &h3.Create tables
prompt &s1.Create table SCT_RULE_GROUP
@&table_dir.sct_rule_group.tbl

prompt &s1.Create table SCT_ACTION_TYPE_GROUP
@&table_dir.sct_action_type_group.tbl

prompt &s1.Create table SCT_ACTION_ITEM_FOCUS
@&table_dir.sct_action_item_focus.tbl

prompt &s1.Create table SCT_ACTION_TYPE
@&table_dir.sct_action_type.tbl

prompt &s1.Create table SCT_ACTION_PARAM_TYPE
@&table_dir.sct_action_param_type.tbl

prompt &s1.Create table SCT_APEX_ACTION_TYPE
@&table_dir.sct_apex_action_type.tbl

prompt &s1.Create table SCT_PAGE_ITEM_TYPE
@&table_dir.sct_page_item_type.tbl

prompt &s1.Create table SCT_ACTION_PARAMETER
@&table_dir.sct_action_parameter.tbl

prompt &s1.Create table SCT_PAGE_ITEM
@&table_dir.sct_page_item.tbl

prompt &s1.Create table SCT_APEX_ACTION
@&table_dir.sct_apex_action.tbl

prompt &s1.Create table SCT_APEX_ACTION_ITEM
@&table_dir.sct_apex_action_item.tbl

prompt &s1.Create table SCT_RULE
@&table_dir.sct_rule.tbl

prompt &s1.Create table SCT_RULE_ACTION
@&table_dir.sct_rule_action.tbl


prompt &h3.Create views
prompt &s1.Create view SCT_BL_RULES
@&view_dir.sct_bl_rules.vw

prompt &s1.Create view SCT_BL_PAGE_TARGETS
@&view_dir.sct_bl_page_targets.vw

prompt &s1.Create view SCT_ACTION_ITEM_FOCUS_V
@&view_dir.sct_action_item_focus_v.vw

prompt &s1.Create view SCT_ACTION_PARAM_TYPE_V
@&view_dir.sct_action_param_type_v.vw

prompt &s1.Create view SCT_ACTION_PARAMETER_V
@&view_dir.sct_action_parameter_v.vw

prompt &s1.Create view SCT_ACTION_TYPE_V
@&view_dir.sct_action_type_v.vw

prompt &s1.Create view SCT_ACTION_TYPE_GROUP_V
@&view_dir.sct_action_type_group_v.vw

prompt &s1.Create view SCT_APEX_ACTION_TYPE_V
@&view_dir.sct_apex_action_type_v.vw


prompt &h2.Merge default data
prompt &h3.Create SCT messages
@&msg_dir.create_messages.sql

prompt &h3.Create UTL_TEXT templates
@&script_dir.merge_utl_text_templates.sql


prompt &h2.Create PL/SQL objects
prompt &h3.Create packages

prompt &s1.Create package SCT_ADMIN
@&pkg_dir.sct_admin.pks
show errors

prompt &s1.Create package Body SCT_UTIL
@&pkg_dir.sct_util.pkb
show errors

prompt &s1.Create package Body SCT_ADMIN
@&pkg_dir.sct_admin.pkb
show errors

prompt &s1.Create package SCT_INTERNAL
@&pkg_dir.packages/sct_internal.pks
show errors

prompt &s1.Create package SCT
@&pkg_dir.packages/sct.pks
show errors

prompt &s1.Create package SCT_VALIDATION
@&pkg_dir.packages/sct_validation.pks
show errors

prompt &s1.Create package UTL_APEX_ACTION
@&pkg_dir.packages/utl_apex_action.pks
show errors

prompt &h3.Create package bodies
prompt &s1.Create package Body SCT_INTERNAL
@&pkg_dir.packages/sct_internal.pkb
show errors

prompt &s1.Create package Body SCT
@&pkg_dir.packages/sct.pkb
show errors

prompt &s1.Create package Body SCT_VALIDATION
@&pkg_dir.packages/sct_validation.pkb
show errors

prompt &s1.Create package Body UTL_APEX_ACTION
@&pkg_dir.packages/utl_apex_action.pkb
show errors

prompt &h2.Merge initial data
prompt &s1.Create SCT page item types
@&script_dir.merge_sct_page_item_type.sql

prompt &s1.Create internal SCT page item 
--@&script_dir.merge_sct_page_item.sql

prompt &s1.Create Action Parameter types 
@&script_dir.merge_sct_action_param_type.sql

prompt &s1.Create Action Item Focus
@&script_dir.merge_sct_action_item_focus.sql

prompt &s1.Create SCT action types
@&script_dir.merge_sct_action_type.sql

prompt &s1.Create APEX action types
@&script_dir.merge_sct_apex_action_type.sql
