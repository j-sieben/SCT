create or replace force view sct_bl_page_targets as
select sgr_id, application_id,page_id,target_type,target_name,spi_conversion
  from (select sgr_id, application_id, page_id,
               case when regexp_like(format_mask, '(^|(FM))[09DGL\.\,]+$', 'i') then 'NUMBER_ITEM'
               when format_mask is not null then 'DATE_ITEM'
               else 'ITEM' end target_type,
               item_name target_name,
               format_mask spi_conversion
          from apex_application_page_items aai
          join sct_rule_group sgr
            on application_id = sgr.sgr_app_id
           and page_id = sgr.sgr_page_id
         union all
        select sgr_id, application_id, 0, 'APP_ITEM', item_name, null
          from apex_application_items
          join sct_rule_group sgr
            on application_id = sgr.sgr_app_id
         union all
        select sgr_id, application_id, page_id, 'BUTTON', button_static_id, null
          from apex_application_page_buttons
          join sct_rule_group sgr
            on application_id = sgr.sgr_app_id
           and page_id = sgr.sgr_page_id
         where button_static_id is not null
         union all
        select sgr_id, application_id, page_id, 'REGION', static_id, null
          from apex_application_page_regions
          join sct_rule_group sgr
            on application_id = sgr.sgr_app_id
           and page_id = sgr.sgr_page_id
         where static_id is not null
         union all
        select sgr_id, sgr_app_id, sgr_page_id, 'DOCUMENT', 'DOCUMENT', null
          from sct_rule_group)
 where application_id not between 3000 and 9000;
