create or replace  view sct_page_item_type_v
as 
select sit_id, pti_name sit_name, sit_has_value, sit_include_in_view, sit_event, sit_col_template, sit_init_template
  from sct_page_item_type
  join pit_translatable_item_v
    on sit_pti_id = pti_id
   and sit_pmg_name = pti_pmg_name;
