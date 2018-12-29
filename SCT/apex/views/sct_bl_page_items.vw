create or replace view sct_bl_page_items as
select 'Element ' || item_name item_name, item_name item_id,
       application_id app_id
       , page_id
  from apex_application_page_items
union all
select 'Seitenelement ' || item_name, item_name,
       application_id, 0
  from apex_application_items
union all
select 'Schaltfläche ' || button_static_id, button_static_id,
       application_id, page_id
  from apex_application_page_buttons
 where button_static_id is not null
union all
select 'Region ' || static_id, static_id,
       application_id, page_id
  from apex_application_page_regions
 where static_id is not null;