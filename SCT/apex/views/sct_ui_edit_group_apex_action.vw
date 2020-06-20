create or replace editionable view sct_ui_edit_group_apex_action
as 
select saa.rowid row_id, saa_sgr_id, saa_label, sty_name
  from sct_apex_action saa
  join sct_apex_action_type_v sty
    on saa_sty_id = sty_id;
