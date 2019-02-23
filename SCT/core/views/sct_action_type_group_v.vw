create or replace view sct_action_type_group_v as
select stg_id, pti_name stg_name, to_char(pti_description) stg_description, stg_active
  from sct_action_type_group
  join pit_translatable_item_v
    on stg_pti_id = pti_id
   and stg_pmg_name = pti_pmg_name;