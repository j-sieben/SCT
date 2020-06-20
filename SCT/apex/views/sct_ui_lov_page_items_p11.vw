create or replace editionable view sct_ui_lov_page_items_p11
as
with params as (
       select v('P11_SRA_SGR_ID') p_sgr_id,
              v('P11_SRA_SAT_ID') p_sat_id
         from dual)
select item_name d, item_id r
  from sct_bl_page_items
  join sct_rule_group
    on app_id = sgr_app_id
   and page_id = sgr_page_id
  join sct_action_item_focus
    on instr(':' || sif_item_types || ':', ':' || item_type || ':') > 0
  join sct_action_type
    on sif_id = sat_sif_id
  join params p
    on sgr_id = p_sgr_id
   and sat_id = p_sat_id;