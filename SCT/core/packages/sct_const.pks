create or replace package sct_const
  authid definer
as 

  /* Das Package sammelt Konstanten, die zur Generierung von DDL-Anweisungen
   * und JavaScript-Bloecken verwendet werden. Entzerrt den Code in SCT_ADMIN
   */
  c_cr constant varchar2(2 byte) := chr(13) || chr(10);
  c_true constant number(1,0) := 1;
  c_false constant number(1,0) := 0;
  c_delimiter constant char(1 byte) := ',';
  c_yes constant char(1 byte) := 'Y';
  c_view_name_prefix constant varchar2(25) := 'SCT_RULES_GROUP_';
  c_js_function constant varchar2(50 byte) := 'de_condes_plugin_sct';
  c_js_namespace constant varchar2(50 byte) := 'de.condes.plugin.sct';
  c_regex_item constant varchar2(50 byte) := q'~(^|[ '\(])#ITEM#([ ',=<^>\)]|$)~';
  c_regex_css constant varchar2(50 byte) := q'~'.+'~';
  c_null constant varchar2(10 byte) := 'null;';
  c_no_firing_item constant varchar2(30 byte) := 'DOCUMENT';
  c_directory constant varchar2(30 byte) := 'SCT_DIR';
  
  -- Ersatzseitennummer fuer Anwendungselemente
  c_app_item_page constant number(1,0) := 0;
  
  -- Templates zur Erzeugung der Regelview
  c_column_delimiter constant varchar2(100 byte) := ',' || c_cr || '              ';
  c_join_delimiter constant varchar2(100 byte) := c_cr || '           or ';
  c_join_clause_template constant varchar2(100 byte) := q'~(r.sru_id = #ID# and ((#CONDITION#) or sru_fire_on_page_load = initializing))~';
  c_rule_view_template constant varchar2(2000 byte) := 
q'~create or replace force view #NAME# as
  with session_state as(
       select bl_sct.get_firing_item firing_item,
              case bl_sct.get_firing_item when 'DOCUMENT' then 1 else 0 end initializing#DATA_COLS#
         from dual),
       data as (
       select /*+ NO_MERGE(s) */
              r.sru_id, r.sru_name, r.sru_firing_items, r.sru_fire_on_page_load,
              r.sra_spi_id, r.sra_sat_id, r.sra_attribute, r.sra_attribute_2, r.sra_on_error, r.sra_raise_recursive, r.sra_sort_seq,
              rank() over (order by r.sru_sort_seq) rang, s.initializing
         from sct_bl_rules r
         join session_state s
           on (instr(r.sru_firing_items, ',' || s.firing_item || ',') > 0 or sru_fire_on_page_load = 1)
        where r.sgr_id = #SGR_ID#
          and (#WHERE_CLAUSE#))
select sru_id, sru_name, sra_spi_id, sra_sat_id, sra_attribute, sra_attribute_2, sra_on_error, sra_raise_recursive, sra_sort_seq
  from data
 where rang = 1 or sru_fire_on_page_load = initializing
 order by sru_fire_on_page_load desc, rang~';
  
  -- Templates zur Erzeugung der Seiten-Aktion
  c_plsql_action_template constant varchar2(200 byte) := 'begin#CR#  #CODE##CR#  commit;#CR#end;';
  c_plsql_item_value_template constant varchar2(100 byte) := q'~v('#ITEM#')~';
  c_plsql_template constant varchar2(100 byte) := '#PLSQL#';

  c_js_item_value_template constant varchar2(100 byte) := q'~apex.item('#ITEM#').getValue()~';
  c_js_template constant varchar2(100 byte) := '#CODE#';
  c_dynamic_js_code_template constant varchar2(100 byte) := '#CODE#';
  
  c_stmt_template constant varchar2(32767) :=
q'~select sru.sru_id, sru.sru_sort_seq, sru.sru_name, sru.sru_firing_items, sru_fire_on_page_load,
       sra_spi_id item, sat_pl_sql pl_sql, sat_js js, sra_attribute attribute, sra_attribute_2 attribute_2, sra_on_error,
       max(sra_on_error) over (partition by sru_sort_seq) sru_on_error,
       case row_number() over (partition by sru_sort_seq, sra_on_error order by srg.sra_sort_seq) when 1 then 1 else 0 end is_first_row
  from #RULE_VIEW# srg
  join sct_rule sru
    on srg.sru_id = sru.sru_id
  join sct_action_type sat
    on srg.sra_sat_id = sat.sat_id
 where sat.sat_raise_recursive >= #IS_RECURSIVE#
   and srg.sra_raise_recursive >= #IS_RECURSIVE#
 order by sru.sru_sort_seq desc, srg.sra_sort_seq~';  
  
  -- Template zur Generierung des Initialisierungscodes
  c_col_val_template constant varchar2(100) := q'~    apex_util.set_session_state('#ITEM#', #COLUMN#);#CR#~';
  c_col_sql_stmt varchar2(200) := 
q'~select * 
        from #ATTRIBUTE_02# 
       where #ATTRIBUTE_04# = (select v('#ATTRIBUTE_03#') from dual)~';
  c_col_sql_rowid_stmt varchar2(200) := 
q'~select rowid, v.* 
        from #ATTRIBUTE_02# v
       where #ATTRIBUTE_04# = (select v('#ATTRIBUTE_03#') from dual)~';
  c_initialize_code constant varchar2(200) := 
q'~declare#CR#    cursor item_cur is#CR#      #SQL_STMT#;#CR#begin#CR#  for itm in item_cur loop#CR##ITEM_STMT#  end loop;#CR#end;~';
  
  -- Templates zum Export von Regelgruppen
  c_export_start_template constant varchar2(200) :=
     'set define ^#CR##CR#declare#CR#  l_foo number;#CR#begin#CR#  l_foo := sct_admin.map_id;#CR#';
  c_export_end_template constant varchar2(200) := '#CR#  commit;#CR#end;#CR#/#CR#set define &';
  c_action_type_template constant varchar2(32767) :=
q'^
  sct_admin.merge_action_type(
    p_sat_id => '#SAT_ID#',
    p_sat_name => '#SAT_NAME#',
    p_sat_description => q'~#SAT_DESCRIPTION#~',
    p_sat_pl_sql => q'~#SAT_PL_SQL#~',
    p_sat_js => q'~#SAT_JS#~',
    p_sat_is_editable => #SAT_IS_EDITABLE#,
    p_sat_raise_recursive => #SAT_RAISE_RECURSIVE#);
^';

  c_rule_group_template constant varchar2(32767) :=
q'^
  dbms_output.put_line('.    - Rulegroup #SGR_NAME#');
  sct_admin.merge_rule_group(
    p_sgr_id => sct_admin.map_id(#SGR_ID#),
    p_sgr_name => q'~#SGR_NAME#~',
    p_sgr_description => q'~#SGR_DESCRIPTION#~',
    p_sgr_app_id => coalesce(apex_application_install.get_application_id, ^APP_ID.),
    p_sgr_page_id => #SGR_PAGE_ID#,
    p_sgr_with_recursion => #SGR_WITH_RECURSION#,
    p_sgr_active => #SGR_ACTIVE#);
^';

  c_rule_template constant varchar2(32767) := 
q'^
  sct_admin.merge_rule(
    p_sru_id => sct_admin.map_id(#SRU_ID#),
    p_sru_sgr_id => sct_admin.map_id(#SGR_ID#),
    p_sru_name => q'~#SRU_NAME#~',
    p_sru_condition => q'~#SRU_CONDITION#~',
    p_sru_sort_seq => #SRU_SORT_SEQ#,
    p_sru_fire_on_page_load => #SRU_FIRE_ON_PAGE_LOAD#,
    p_sru_active => #SRU_ACTIVE#);
^';

  c_rule_action_template constant varchar2(32767) := 
q'^
  sct_admin.merge_rule_action(
    p_sra_sru_id => sct_admin.map_id(#SRU_ID#),
    p_sra_sgr_id => sct_admin.map_id(#SGR_ID#),
    p_sra_spi_id => '#SPI_ID#',
    p_sra_sat_id => '#SAT_ID#',
    p_sra_attribute => q'~#SRA_ATTRIBUTE#~',
    p_sra_attribute_2 => q'~#SRA_ATTRIBUTE_2#~',
    p_sra_sort_seq => #SRA_SORT_SEQ#,
    p_sra_on_error => #SRA_ON_ERROR#,
    p_sra_raise_recursive => #SRA_RAISE_RECURSIVE#,
    p_sra_active => #SRA_ACTIVE#);
^';

  c_rule_group_validation constant varchar2(200) := 
q'~
  sct_admin.propagate_rule_change(sct_admin.map_id(#SGR_ID#));
~';

  -- Templates zur Validierung von Regelgruppen
  c_rule_validation_template constant varchar2(2000 byte) := 
q'~  with session_state as(
       select null firing_item, null item_css,
              null initializing#DATA_COLS#
         from dual)
select *
  from session_state
 where #CONDITION#~';
 
  c_rule_group_error constant varchar2(200 char) := q'~<p>Regelgruppe "#SGR_NAME#" kann nicht exportiert werden:</p><ul>#ERROR_LIST#</ul>~';
  c_page_item_error constant varchar2(200 char) := q'~<li>#SIT_NAME# "#SPI_ID#" existiert in Anwendung #SGR_APP_ID# nicht</li>~';
  
  c_action_type_help_template constant varchar2(200 char) := q'~<h2>Hilfe zu Aktionstypen</h2><dl>#HELP_LIST#</dl>~';

  c_action_type_help_entry constant varchar2(200 char) := q'~<dt class="sct-dt">#SAT_NAME# #SAT_IS_EDITABLE#</dt><dd>#SAT_DESCRIPTION#</dd>~';
 
end sct_const;
/
