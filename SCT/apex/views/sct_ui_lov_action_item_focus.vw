create or replace view sct_ui_lov_action_item_focus as
select sif_name d, sif_id r, sif_active
  from sct_action_item_focus_v;
