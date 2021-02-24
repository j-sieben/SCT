create or replace editionable view sct_ui_edit_sra
as 
select seq_id,
       n001 sra_id,
       n002 sra_sgr_id,
       n003 sra_sru_id,
       c001 sra_spi_id,
       c002 sra_sat_id,
       c003 sra_param_1,
       c003 sra_param_lov_1,
       c003 sra_param_area_1,
       c004 sra_param_2,
       c004 sra_param_lov_2,
       c004 sra_param_area_2,
       c005 sra_param_3,
       c005 sra_param_lov_3,
       c005 sra_param_area_3,
       c006 sra_comment,
       c007 sra_on_error,
       c008 sra_raise_recursive,
       n004 sra_sort_seq,
       c009 sra_active,
       c010 sra_has_error
  from apex_collections
 where collection_name = 'SCT_UI_EDIT_SRA';
 
comment on table sct_ui_edit_sra is 'Collection View auf SCT_RULE_ACTION, nicht refaktorisieren, um zeitgleiche Erstellung von Regel und Aktionen zu ermoeglichen.';