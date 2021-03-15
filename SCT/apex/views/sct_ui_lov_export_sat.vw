create or replace editionable view sct_ui_lov_export_sat
as
select pti_name d, pti_id r
  from pit_translatable_item_v
 where pti_pmg_name = 'SCT'
   and pti_id like 'SAT_EXPORT%';
