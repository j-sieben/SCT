create or replace force view sct_ui_lov_page_items as
select item_name d, item_id r, app_id, page_id
  from sct_bl_page_items;
