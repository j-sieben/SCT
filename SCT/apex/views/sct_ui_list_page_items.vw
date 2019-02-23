create or replace force view sct_ui_list_page_items as
select spi_id d, spi_id r, spi_sgr_id
  from sct_page_item
 where spi_id != 'DOCUMENT';
