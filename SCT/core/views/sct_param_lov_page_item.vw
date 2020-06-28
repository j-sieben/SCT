create or replace view sct_param_lov_page_item
as 
select case spi_id when 'ALL' then ' Document' else spi_id end d, spi_id r, spi_sgr_id sgr_id
  from sct_page_item
 where spi_sit_id in ('DATE_ITEM', 'ITEM', 'NUMBER_ITEM');
