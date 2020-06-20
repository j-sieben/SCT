--------------------------------------------------------
--  DDL for View SCT_APEX_ACTION_TYPE_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SCT_APEX_ACTION_TYPE_V" ("STY_ID", "STY_NAME", "STY_DESCRIPTION", "STY_ACTIVE") AS 
  select sty_id, pti_name sty_name, to_char(pti_description) sty_description, sty_active
  from sct_apex_action_type
  join pit_translatable_item_v
    on sty_pti_id = pti_id
   and sty_pmg_name = pti_pmg_name
;
