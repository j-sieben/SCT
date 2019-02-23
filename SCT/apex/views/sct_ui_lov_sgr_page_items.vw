create or replace view sct_ui_lov_sgr_page_items as
select lpi.item_name d, lpi.item_id r, sgr.sgr_id
  from sct_bl_page_items lpi
  join sct_rule_group sgr
    on lpi.app_id = sgr.sgr_app_id
   and lpi.page_id = sgr.sgr_page_id;
