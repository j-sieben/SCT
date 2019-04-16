create or replace view sct_ui_lov_action_param_type as
select spt_name d, spt_id r, spt_active
  from sct_action_param_type_v;
