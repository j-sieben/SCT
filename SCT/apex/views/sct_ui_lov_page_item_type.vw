create or replace editionable view sct_ui_lov_page_item_type
as 
select sit_name d, sit_id r, sit_include_in_view is_event
  from sct_page_item_type_v;

comment on table sct_ui_lov_page_item_type is 'LOV view for all page item types.';