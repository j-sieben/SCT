create or replace view sct_ui_lov_action_type_group as
select stg_name d, stg_id r, stg_active
  from sct_action_type_group_v;
