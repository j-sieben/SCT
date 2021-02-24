create or replace editionable view sct_ui_edit_sgr_apex_action
as 
select saa_id, saa_sgr_id, saa_name, saa_label, sty_name, saa_shortcut
  from sct_ui_edit_saa saa
  join sct_apex_action_type_v sty
    on saa_sty_id = sty_id;