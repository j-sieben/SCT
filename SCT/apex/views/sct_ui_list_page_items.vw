create or replace editionable view SCT_UI_LIST_PAGE_ITEMS
as 
select SPI_ID d, SPI_ID r, SPI_SGR_ID
  from SCT_PAGE_ITEM
 where SPI_ID != 'DOCUMENT';
