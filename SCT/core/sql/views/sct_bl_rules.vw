create or replace force view sct_bl_rules as
select sru.sru_id, sru.sru_sgr_id sgr_id, sru.sru_sort_seq, sru.sru_name,
       ',' || sru.sru_firing_items|| ',DOCUMENT,' sru_firing_items,
       sra.sra_spi_id, sra.sra_sat_id, sra.sra_attribute, sra.sra_attribute_2
  from sct_rule sru
  join sct_rule_action sra
    on sru.sru_id in sra.sra_sru_id
   and sru.sru_sgr_id in sra.sra_sgr_id
 where sru.sru_active = 1
   and sra.sra_active = 1
   and sra_spi_id != 'ALL'
union all
select sru.sru_id, spi.spi_sgr_id, sru.sru_sort_seq, sru.sru_name,
       ',' || spi.spi_id || ',' sru_firing_items,
       spi.spi_id, sra.sra_sat_id, to_clob(spi.spi_mandatory_message), sra.sra_attribute_2
  from sct_rule sru
  join sct_rule_action sra
    on sru.sru_id = sra.sra_sru_id
 cross join sct_page_item spi
 where sru.sru_id = 0
   and spi_is_mandatory = 1;
