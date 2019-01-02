create or replace force view sct_bl_rules as
  with params as(
       select sct_util.get_true is_true
         from dual)
select /*+ nno_merge(p) */
       sru.sru_id, sru.sru_sgr_id sgr_id, sru.sru_sort_seq, sru.sru_name,
       ',' || sru.sru_firing_items|| ',DOCUMENT,' sru_firing_items, sru_fire_on_page_load, sra.sra_raise_recursive,
       sra.sra_spi_id, spi.spi_css item_css, sra.sra_sat_id, sra.sra_param_1, sra.sra_param_2, sra.sra_param_3, sra.sra_on_error, sra.sra_sort_seq
  from sct_rule_group sgr
  join sct_rule sru
    on sgr.sgr_id = sru.sru_sgr_id
  join sct_rule_action sra
    on sru.sru_id in sra.sra_sru_id
   and sru.sru_sgr_id in sra.sra_sgr_id
  join sct_page_item spi
    on sgr.sgr_id = spi.spi_sgr_id
   and sra.sra_spi_id = spi.spi_id
 cross join params p
 where sgr.sgr_active = is_true
   and sru.sru_active = is_true
   and sra.sra_active = is_true
   and sra_spi_id != 'ALL'
union all
select /*+ no_merge (p)*/
       sru.sru_id, spi.spi_sgr_id, sru.sru_sort_seq, sru.sru_name,
       ',' || spi.spi_id || ',' sru_firing_items, sru_fire_on_page_load, sra.sra_raise_recursive,
       spi.spi_id, spi.spi_css, sra.sra_sat_id, spi.spi_mandatory_message, sra.sra_param_2, sra.sra_param_3, sra.sra_on_error, sra.sra_sort_seq
  from sct_rule sru
  join sct_rule_action sra
    on sru.sru_id = sra.sra_sru_id
 cross join sct_page_item spi
 cross join params p
 where sru.sru_id = 0
   and spi_is_mandatory = is_true;
