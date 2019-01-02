create or replace view sct_action_type_v as
select sat_id, sat_stg_id, sat_sif_id, pti_name sat_name, pti_description sat_description, sat_pl_sql, sat_js, sat_is_editable, sat_raise_recursive, sat_active
  from sct_action_type
  join pit_translatable_item_v
    on sat_pti_id = pti_id
   and sat_pmg_name = pti_pmg_name;