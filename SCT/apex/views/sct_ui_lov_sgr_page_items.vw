create or replace editionable view sct_ui_lov_sgr_page_items
as
select distinct lpi.item_name d, lpi.item_id r, sgr.sgr_id, sat_id, sit_name grp
  from sct_bl_page_items lpi
  join sct_bl_page_targets lpt
    on lpi.item_id = lpt.spi_id
  join sct_rule_group sgr
    on lpi.app_id = sgr.sgr_app_id
   and lpi.page_id = sgr.sgr_page_id
  join sct_action_item_focus
    on instr(sif_item_types, spi_sit_id) > 0
  join sct_action_type
    on sif_id = sat_sif_id
  join sct_page_item_type_v
    on spi_sit_id = sit_id;