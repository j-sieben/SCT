create or replace editionable view sct_ui_lov_sgr
as 
select sgr_description || ' (' || sgr_name || ')' d, sgr_id r
  from sct_rule_group;
