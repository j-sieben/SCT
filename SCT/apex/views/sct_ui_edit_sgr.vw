create or replace editionable view sct_ui_edit_sgr
as 
select sgr_id, sgr_name, sgr_description, sgr_app_id, sgr_page_id, sgr_active, sgr_initialization_code, sgr_with_recursion
  from sct_rule_group;
