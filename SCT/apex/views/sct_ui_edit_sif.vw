create or replace editionable view sct_ui_edit_sif
as 
select sif_id, sif_name, sif_description, sif_actual_page_only, sif_item_types, sif_active,
       case
         (select count(*)
            from dual
           where exists (
                 select null
                   from sct_action_type
                  where sat_sif_id = sif_id))
         when 1 then 'U'
         else 'UD'
       end allowed_operations
  from sct_action_item_focus_v;

comment on table sct_ui_edit_sif is 'View for APEX page EDIT_SIF';