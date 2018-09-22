
merge into sct_page_item spi
using (select 0 spi_sgr_id,
              'ALL' spi_id,
              'ITEM' spi_sit_id,
              q'~v(('#ITEM#')~' spi_conversion
         from dual) v
   on (spi.spi_sgr_id = v.spi_sgr_id and spi.spi_id = v.spi_id)
 when not matched then insert (spi_sgr_id, spi_id, spi_sit_id, spi_conversion)
      values (v.spi_sgr_id, v.spi_id, v.spi_sit_id, v.spi_conversion);
      
commit;
