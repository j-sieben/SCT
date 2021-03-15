create or replace editionable view sct_ui_admin_sif
as 
select sif_id, sif_name, sif_description, a.d sif_actual_page_only, b.d sif_active
  from sct_action_item_focus_v
  join sct_ui_lov_yes_no a
    on sif_actual_page_only = a.r
  join sct_ui_lov_yes_no b
    on sif_active = b.r;

comment on table sct_ui_admin_sif is 'View for APEX report page ADMIN_SIF';