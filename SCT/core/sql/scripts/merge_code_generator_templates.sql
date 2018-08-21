declare
  c_cgtm_type constant varchar2(10) := 'SCT';
  c_default constant varchar2(10) := 'DEFAULT';
begin
  
  code_generator.merge_template(
    p_cgtm_name => 'RULE_VIEW',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => c_default,
    p_cgtm_text => q'^create or replace force view #PREFIX##SGR_ID# as
  with session_state as(
       select bl_sct.get_firing_item firing_item,
              case bl_sct.get_firing_item when 'DOCUMENT' then 1 else 0 end initializing
              #COLUMN_LIST#
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
 order by sru_fire_on_page_load desc, rang^',
    p_cgtm_log_text => q'^Rule View #PREFIX##SGR_ID# created.^',
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'RULE_VALIDATION',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => c_default,
    p_cgtm_text => q'~  with session_state as(
       select null firing_item,
              null initializing
              #COLUMN_LIST#
         from dual)
select *
  from session_state
 where #CONDITION#~',
    p_cgtm_log_text => q'^Rule View #PREFIX##SGR_ID# validated.^',
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'JOIN_CLAUSE',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => c_default,
    p_cgtm_text => q'^(r.sru_id = #SRU_ID# and ((#SRU_CONDITION#) or sru_fire_on_page_load = initializing))^',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_ITEM',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'ITEM',
    p_cgtm_text => q'~v('#ITEM#') #ITEM#~',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_INIT',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'ITEM',
    p_cgtm_text => q'~itm.#ITEM#~',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_ITEM',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'NUMBER_ITEM',
    p_cgtm_text => q'^to_number(v('#ITEM#'), '#CONVERSION#') #ITEM#^',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_INIT',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'NUMBER_ITEM',
    p_cgtm_text => q'^to_char(itm.#ITEM#, '#CONVERSION#')^',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_ITEM',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'DATE_ITEM',
    p_cgtm_text => q'^to_date(v('#ITEM#'), '#CONVERSION#') #ITEM#^',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_INIT',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'DATE_ITEM',
    p_cgtm_text => q'^to_char(to_date(itm.#ITEM#), '#CONVERSION#')^',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_ITEM',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'APP_ITEM',
    p_cgtm_text => q'~v('#ITEM#') #ITEM#~',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_INIT',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'APP_ITEM',
    p_cgtm_text => q'~itm.#ITEM#~',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_ITEM',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'BUTTON',
    p_cgtm_text => q'~case bl_sct.get_firing_item when '#ITEM#' then 1 else 0 end #ITEM#~', 
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_ITEM',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'REGION',
    p_cgtm_text => q'~null #ITEM#~',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  code_generator.merge_template(
    p_cgtm_name => 'VIEW_ITEM',
    p_cgtm_type => c_cgtm_type,
    p_cgtm_mode => 'DOCUMENT',
    p_cgtm_text => q'~null #ITEM#~',
    p_cgtm_log_text => null,
    p_cgtm_log_severity => 70
  );
  
  commit;
  
end;
/