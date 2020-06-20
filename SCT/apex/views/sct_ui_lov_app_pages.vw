create or replace editionable view sct_ui_lov_app_pages
as 
select page_name || ' (' || page_id || ')' d,
       page_id r,
       application_id
  from apex_application_pages;
