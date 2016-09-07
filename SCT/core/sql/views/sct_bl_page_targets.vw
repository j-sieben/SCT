create or replace view sct_bl_page_targets as
select application_id, page_id, 'ITEM' target_type, item_name target_name, 
       case 
       when regexp_like(format_mask, '(^|(FM))[09DGL]+$', 'i') then replace(q'±to_number(v('#ITEM#'), '#MASK#')±', '#MASK#', format_mask)
       when format_mask is not null then replace(q'±to_date(v('#ITEM#'), '#MASK#')±', '#MASK#', format_mask)
       else q'±v('#ITEM#')±' end spi_conversion
  from apex_application_page_items
 union all
select application_id, page_id, 'BUTTON', button_static_id, null
  from apex_application_page_buttons
 where button_static_id is not null
 union all 
select application_id, page_id, 'REGION',  static_id, null
  from apex_application_page_regions
 where static_id is not null;
