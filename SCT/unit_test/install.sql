define UT_DIR=unit_test/
define pkg_dir=&UT_DIR.packages/
define script_dir=&UT_DIR.scripts/
define type_dir=&UT_DIR.types/
define view_dir=&UT_DIR.views/
define table_dir=&UT_DIR.tables/
define msg_dir=&UT_DIR.messages/&DEFAULT_LANGUAGE./
define apex_dir=&UT_DIR.apex/

prompt
prompt &section.
prompt &h1.Install SCT unit tests

prompt
prompt &section.
prompt &h2.Types

prompt &s1.Type SCT_TEST_JS_REC
@&TYPE_DIR.sct_test_js_rec.tps

prompt &s1.Type SCT_TEST_JS_LIST
@&TYPE_DIR.sct_test_js_list.tps

prompt &s1.Type SCT_TEST_ROW
@&TYPE_DIR.sct_test_row.tps

prompt &s1.Type SCT_TEST_LIST
@&TYPE_DIR.sct_test_list.tps

prompt &s1.Type SCT_TEST_RESULT
@&TYPE_DIR.sct_test_result.tps

prompt &s1.Type Body SCT_TEST_RESULT
@&TYPE_DIR.sct_test_result.tpb

prompt
prompt &section.
prompt &h2.Tables
prompt &s1.Table SCT_TEST_OUTCOME
@&TABLE_DIR.sct_test_outcome.tbl

prompt
prompt &section.
prompt &h2.Packages
prompt &s1.Package SCT_TEST
@&PKG_DIR.sct_test.pks


prompt &s1.Package Body SCT_APEX
@&PKG_DIR.sct_test.pkb

--prompt
--prompt &section.
--prompt &h2.APEX application
--prompt &h3.Prepare APEX import
--@&UT_DIR.prepare_app_import.sql

--prompt &h3.Install application
--@&APEX_DIR.utl_apex.sql

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

prompt
prompt &section.
prompt &h1.Installation of UTL_APEX unit tests complete