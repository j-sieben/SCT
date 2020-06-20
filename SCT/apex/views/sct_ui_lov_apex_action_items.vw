create or replace editionable view sct_ui_lov_apex_action_items
as 
select sit_name || ' »' || spi_label || '«' d, spi_id r, sgr_id, spi_sty_id
  from sct_page_item spi
  join sct_rule_group sgr
    on spi_sgr_id = sgr_id
  join sct_page_item_type sit
    on spi_sit_id = sit_id
  join sct_apex_action_type
    on spi_sty_id = sty_id;
