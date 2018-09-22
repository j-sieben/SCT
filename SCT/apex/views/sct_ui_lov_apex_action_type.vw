create or replace view sct_ui_lov_apex_action_type as
select sty_display_name d, sty_id r
  from sct_apex_action_type;
