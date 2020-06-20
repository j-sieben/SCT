--------------------------------------------------------
--  DDL for View SCT_ACTION_ITEM_FOCUS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SCT_ACTION_ITEM_FOCUS_V" ("SIF_ID", "SIF_NAME", "SIF_DESCRIPTION", "SIF_ACTUAL_PAGE_ONLY", "SIF_ITEM_TYPES", "SIF_ACTIVE") AS 
  select sif_id, pti_name sif_name, to_char(pti_description) sif_description, sif_actual_page_only, sif_item_types, sif_active
  from sct_action_item_focus
  join pit_translatable_item_v
    on sif_pti_id = pti_id
   and sif_pmg_name = pti_pmg_name
;
