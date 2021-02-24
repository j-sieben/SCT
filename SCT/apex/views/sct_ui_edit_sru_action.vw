create or replace editionable view sct_ui_edit_sru_action
as 
with params as(
       select v('P5_SRU_ID') sru_id,
              v('P5_SRU_SGR_ID') sru_sgr_id,
              'fa-check' flg_yes,
              'fa-times' flg_no,
              utl_apex.get_true c_true,
              utl_apex.get_false c_false
         from dual)
select /*+ no_merge(p) */
       max(sra_id) over () + 1 seq_id,
       sra_id,
       sra_sgr_id,
       sra_sru_id,
       sra_sat_id,
       sra_spi_id,
       coalesce(item_name, 'Dokument') item_name,
       sat_name,
       sra_sort_seq,
       sra_param_1,
       sra_param_2,
       sra_param_3,
       sra_comment,
       case sra_on_error when p.c_true then flg_yes else flg_no end sra_on_error,
       case sra_raise_recursive when p.c_true then flg_yes else flg_no end sra_raise_recursive,
       case sra_active when p.c_true then flg_yes else flg_no end sra_active,
       -- Change logic to allow for "is_valid" flag
       case sra_has_error when p.c_true then flg_no else flg_yes end sra_has_error
  from sct_ui_edit_sra
  join sct_action_type_v
    on sra_sat_id = sat_id
  join sct_rule_group
    on sra_sgr_id = sgr_id
  left join sct_bl_page_items
    on sgr_app_id = app_id
   and sgr_page_id = page_id
   and sra_spi_id = item_id
  join params p
    on sra_sgr_id = sru_sgr_id
   and (sra_sru_id = sru_id or sra_sru_id is null);
