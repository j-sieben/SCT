--------------------------------------------------------
--  DDL for View SCT_ACTION_TYPE_GROUP_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SCT_ACTION_TYPE_GROUP_V" ("STG_ID", "STG_NAME", "STG_DESCRIPTION", "STG_ACTIVE") AS 
  select stg_id, pti_name stg_name, to_char(pti_description) stg_description, stg_active
  from sct_action_type_group
  join pit_translatable_item_v
    on stg_pti_id = pti_id
   and stg_pmg_name = pti_pmg_name
;
