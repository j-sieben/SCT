--------------------------------------------------------
--  DDL for View SCT_ACTION_PARAM_TYPE_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SCT_ACTION_PARAM_TYPE_V" ("SPT_ID", "SPT_NAME", "SPT_DISPLAY_NAME", "SPT_DESCRIPTION", "SPT_ITEM_TYPE", "SPT_ACTIVE") AS 
  select spt_id, pti_name spt_name, pti_display_name spt_display_name, to_char(pti_description) spt_description, spt_item_type, spt_active
  from sct_action_param_type
  join pit_translatable_item_v
    on spt_pti_id = pti_id
   and spt_pmg_name = pti_pmg_name
;
