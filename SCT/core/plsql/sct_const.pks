create or replace package sct_const as

  c_cr constant varchar2(2 byte) := chr(10);
  c_true constant char(1 byte) := 'Y';
  c_false constant char(1 byte) := 'N';
  c_view_name_prefix constant varchar2(25) := 'SCT_RULES_GROUP_';
  c_js_function constant varchar2(50) := 'de_condes_plugin_sct';
  c_js_namespace constant varchar2(50) := 'de.condes.plugin.sct';
  c_regex_item constant varchar2(50) := q'±(^|[ '\(])#ITEM#([ '=<!>\)]|$)±';
  c_null constant varchar2(10) := 'null;';
  
  -- CREATE_COLUMN_LIST
  c_item_col_template constant varchar2(100 char) := q'±#CONVERSION# #ITEM#±';
  c_button_col_template constant varchar2(100 char) := q'±case sct_admin.get_firing_item when '#ITEM#' then 'Y' else 'N' end #ITEM#±';
  c_column_delimiter constant varchar2(20 char) := ',' || c_cr || '              ';
  
  -- CREATE_WHERE_CLAUSE
  c_join_clause_template constant varchar2(100 char) := q'±(r.sru_id = #ID# and (#CONDITION#))±';  
  $IF dbms_db_version.ver_le_11 $THEN
  c_join_delimiter constant varchar2(20 char) := c_cr || '           or ';
  $ELSE
  c_join_delimiter constant varchar2(20 char) := c_cr || '    or ';
  $END
  
  -- CREATE_RULE_VIEW  
  c_create_view_template constant varchar2(100) := 'create or replace force view #NAME# as' || c_cr;
  $IF dbms_db_version.ver_le_11 $THEN
  c_rule_view_template constant varchar2(1000) := 
q'±  with session_state as(
     select ':' || sct_admin.get_firing_item || ':' firing_item,
            #DATA_COLS#
       from dual),
     data as(
     select /*+ NO_MERGE(s) */ 
            r.sru_id, r.sru_name, r.sru_firing_items,
            r.sra_spi_id, r.sra_sat_id, r.sra_attribute,
            rank() over (order by r.sru_sort_seq) rang
       from sct_bl_rules r
       join join session_state s
         on instr(r.sru_firing_items, s.firing_item) > 0
      where r.sgr_id = #SGR_ID#
        and (#WHERE_CLAUSE#))
select sru_id, sru_name, sra_spi_id, sra_sat_id, sra_attribute
from data
where rang = 1±';
  $ELSE
  c_rule_view_template constant varchar2(1000) := 
q'±  with session_state as(
     select ':' || sct_admin.get_firing_item || ':' firing_item,
            #DATA_COLS#
       from dual)
select /*+ NO_MERGE(s) */ 
     r.sru_id, r.sru_name, r.sru_firing_items,
     r.sra_spi_id, r.sra_sat_id, r.sra_attribute
from sct_bl_rules r
join session_state s
  on instr(r.sru_firing_items, s.firing_item) > 0
where r.sgr_id = #SGR_ID#
 and (#WHERE_CLAUSE#)
order by r.sru_sort_seq
fetch first 1 row with ties
±';
  $END
  
  -- CREATE_ACTION
  c_plsql_action_template constant varchar2(200) :=
q'±begin
  #CODE#
end;±';

  c_stmt_template constant varchar2(32767) := 
q'±select sru.sru_id, sru.sru_sort_seq, sru.sru_name, sra_spi_id item,
       sat_pl_sql pl_sql,
       sat_js js,
       sra_attribute attribute
  from #RULE_VIEW# srg
  join sct_rule sru
    on srg.sru_id = sru.sru_id
  join sct_action_type sat
    on srg.sra_sat_id = sat.sat_id±';
    
  c_plsql_template constant varchar2(200) := 
q'±#PLSQL#±';
    
  c_js_template constant varchar2(200) := 
q'±#SCRIPT#±';

  c_js_action_template constant varchar2(300) :=
q'±<script id="RULE_#SRU_SORT_SEQ#">
  #JS_FILE#.setRuleName('#SRU_NAME#')
  #JS_FILE#.setItemValues(#ITEM_JSON#)
  #JS_FILE#.setErrors(#ERROR_JSON#)
  #CODE#
</script>±';

  -- EXPORT_RULE_GROUP  
  c_action_type_template constant varchar2(32767) :=
q'±
  sct_admin.merge_action_type(
    p_sat_id => '#SAT_ID#',
    p_sat_name => '#SAT_NAME#',
    p_sat_pl_sql => q'~#SAT_PL_SQL#~',
    p_sat_js => q'~#SAT_JS#~',
    p_sat_changes_value => '#SAT_CHANGES_VALUE#');
±';

  c_group_template constant varchar2(32767) :=
q'±
  sct_admin.merge_rule_group(
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, #SGR_APP_ID#),
    p_sgr_page_id => #SGR_PAGE_ID#,
    p_sgr_id => sct_admin.map_id(#SGR_ID#),
    p_sgr_name => q'~#SGR_NAME#~',
    p_sgr_description => q'~#SGR_DESCRIPTION#~');
±';

  c_rule_template constant varchar2(32767) :=
q'±
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(#SRU_ID#),
    p_sru_sgr_id => sct_admin.map_id(#SGR_ID#),
    p_sru_name => q'~#SRU_NAME#~',
    p_sru_condition => q'~#SRU_CONDITION#~',
    p_sru_sort_seq => '#SRU_SORT_SEQ#');
±';

  c_rule_action_template constant varchar2(32767) :=
q'±
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(#SRU_ID#),
    p_sra_sgr_id => sct_admin.map_id(#SGR_ID#),
    p_sra_spi_id => '#SPI_ID#',
    p_sra_sat_id => '#SAT_ID#',
    p_sra_attribute => q'~#SRA_ATTRIBUTE#~',
    p_sra_sort_seq => '#SRA_SORT_SEQ#');
±';

  c_directory constant varchar2(30 byte) := 'SCT_DIR';
  
  -- VALIDATE_RULE
  c_rule_validation_template constant varchar2(2000) :=
q'±  with session_state as(
       select null firing_item, 
              #DATA_COLS#
         from dual)
  select *
    from session_state
   where #CONDITION#±';
   
end sct_const;
/
