create or replace force view ui_sct_lov_page_items as
select item_name d, item_name r,
       application_id app_id, page_id
  from apex_application_page_items
union all
select 'Schaltfläche ' || button_static_id d, button_static_id r,
       application_id, page_id
  from apex_application_page_buttons
 where button_static_id is not null;
