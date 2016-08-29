create or replace force view ui_sct_list_page_items as
select spi_id d, spi_id r, spi_sgr_id
  from sct_page_item;
