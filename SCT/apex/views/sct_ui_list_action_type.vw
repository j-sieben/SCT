create or replace force view sct_ui_list_action_type as
select sat_name d, sat_id r, stg_description grp
  from sct_action_type
  join sct_action_type_group
    on sat_stg_id = stg_id;
