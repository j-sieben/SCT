create or replace force view sct_bl_rules as
select sru.sru_id, sru.sru_sort_seq, sru.sru_name,
       ':' || sru.sru_firing_items || ':DOCUMENT:' sru_firing_items,
       sra.sra_spi_id, sra.sra_sat_id, sra.sra_attribute
  from sct_rule sru
  join sct_rule_action sra
    on sru.sru_id = sra.sra_sru_id
   and sru.sru_sgr_id = sra.sra_sgr_id;
