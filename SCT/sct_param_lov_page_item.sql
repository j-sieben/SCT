--------------------------------------------------------
--  DDL for View SCT_PARAM_LOV_PAGE_ITEM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SCT_PARAM_LOV_PAGE_ITEM" ("D", "R", "SGR_ID") AS 
  select case spi_id when 'ALL' then ' Document' else spi_id end d, spi_id r, spi_sgr_id sgr_id
  from sct_page_item
;
