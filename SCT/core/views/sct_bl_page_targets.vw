create or replace editionable view sct_bl_page_targets
as 
select sgr_id spi_sgr_id,
       item_name spi_id,
       case when regexp_like(format_mask, '(^|(FM))[09DGL\.\,]+$', 'i') then 'NUMBER_ITEM'
       when format_mask is not null then 'DATE_ITEM'
       else 'ITEM' end spi_sit_id,
       case replace(display_as_code, 'NATIVE_')
         when 'SELECT_LIST' then 'RADIO_GROUP'
         when 'RADIO_GROUP' then 'RADIO_GROUP'
         when 'YES_NO' then 'TOGGLE'
         when 'CHECKBOX' then 'TOGGLE'
         else null end spi_sty_id,
       label spi_label,
       format_mask spi_conversion,
       item_default spi_item_default,
       '|' || replace(trim(item_css_classes), ' ', '|') || '|' || replace(trim(html_form_element_css_classes), ' ', '|') || '|' spi_css,
       -- Default mandatory items
       case when instr(upper(item_label_template), 'REQUIRED') > 0 then sct_util.C_TRUE else sct_util.C_FALSE end spi_is_mandatory,
       -- default required items
       case
         when format_mask is not null or instr(upper(item_label_template), 'REQUIRED') > 0 then sct_util.C_TRUE 
         else sct_util.C_FALSE end  spi_is_required
  from apex_application_page_items aai
  join sct_rule_group sgr
    on application_id = sgr.sgr_app_id
   and page_id = sgr.sgr_page_id
 union all
select sgr_id, item_name, 'APP_ITEM', null, null, null, null, null, sct_util.C_FALSE, sct_util.C_FALSE
  from apex_application_items
  join sct_rule_group sgr
    on application_id = sgr.sgr_app_id
 union all
select sgr_id, button_static_id, 'BUTTON', 'ACTION', label, null, null, null, sct_util.C_FALSE, sct_util.C_FALSE
  from apex_application_page_buttons
  join sct_rule_group sgr
    on application_id = sgr.sgr_app_id
   and page_id = sgr.sgr_page_id
 union all
select sgr_id, static_id, 'REGION', null, region_name, null, null, null, sct_util.C_FALSE, sct_util.C_FALSE
  from apex_application_page_regions
  join sct_rule_group sgr
    on application_id = sgr.sgr_app_id
   and page_id = sgr.sgr_page_id
 where static_id is not null
 union all
select sgr_id, 'DOCUMENT', 'DOCUMENT', null, null, null, null, null, sct_util.C_FALSE, sct_util.C_FALSE
  from sct_rule_group
 union all
select sgr_id, 'ALL', 'ALL', null, null, null, null, null, sct_util.C_FALSE, sct_util.C_FALSE
  from sct_rule_group;
