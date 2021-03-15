create or replace editionable view sct_rule_group_status
as 
select collection_name,
       seq_id srs_id,
       c001 srs_spi_id,
       c002 srs_spi_label,
       c003 srs_spi_mandatory_message
  from apex_collections;
  
comment on table sct_rule_group_status is 'Wrapper view around the apex collection containing the list of mandatory items';