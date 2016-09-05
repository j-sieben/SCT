set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
clear screen

col install_user new_val INSTALL_USER format a30
col apex_ws new_val APEX_WS format a30

select upper('&1.') install_user, upper('&2.') apex_ws
  from dual;

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
