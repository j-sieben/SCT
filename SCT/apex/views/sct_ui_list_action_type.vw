create or replace editionable view sct_ui_list_action_type
as 
select sat_name d, sat_id r, stg_description grp
  from sct_action_type_v
  join sct_action_type_group_v
    on sat_stg_id = stg_id;
