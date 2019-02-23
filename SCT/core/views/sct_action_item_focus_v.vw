create or replace view sct_action_item_focus_v as
select sif_id, pti_name sif_name, to_char(pti_description) sif_description, sif_actual_page_only, sif_item_types, sif_active
  from sct_action_item_focus
  join pit_translatable_item_v
    on sif_pti_id = pti_id
   and sif_pmg_name = pti_pmg_name;