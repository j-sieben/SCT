create or replace editionable view sct_ui_lov_apex_action_type
as 
select sty_name d, sty_id r
  from sct_apex_action_type_v;
