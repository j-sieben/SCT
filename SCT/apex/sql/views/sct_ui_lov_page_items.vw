create or replace force view sct_ui_lov_page_items as
select 'Element ' || item_name d, item_name r,
       application_id app_id, page_id
  from apex_application_page_items
union all
select 'Seitenelement ' || item_name d, item_name r,
       application_id app_id, 0
  from apex_application_items
union all
select 'Schaltfläche ' || button_static_id d, button_static_id r,
       application_id, page_id
  from apex_application_page_buttons
 where button_static_id is not null
union all
select 'Region ' || static_id d, static_id r,
       application_id, page_id
  from apex_application_page_regions
 where static_id is not null;
