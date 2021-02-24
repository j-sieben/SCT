--------------------------------------------------------
--  DDL for View SCT_PARAM_LOV_PIT_MESSAGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SCT_PARAM_LOV_PIT_MESSAGE" ("D", "R", "SGR_ID") AS 
  select pms_name d, 'msg.' || pms_name r, null sgr_id
  from pit_message
  join pit_message_language_v
    on pms_pml_name = pml_name
 where pml_default_order = 10
;
