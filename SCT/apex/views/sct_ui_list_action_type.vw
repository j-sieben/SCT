create or replace force view sct_ui_list_action_type as
select sat_name d, sat_id r
  from sct_action_type;
