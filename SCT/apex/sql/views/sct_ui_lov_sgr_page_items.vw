create or replace view sct_ui_lov_sgr_page_items as
select lpi.d, lpi.r, sgr.sgr_id
  from sct_ui_lov_page_items lpi
  join sct_rule_group sgr
    on lpi.app_id = sgr.sgr_app_id;
