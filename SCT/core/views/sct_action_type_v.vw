--------------------------------------------------------
--  DDL for View SCT_ACTION_TYPE_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SCT_ACTION_TYPE_V" ("SAT_ID", "SAT_STG_ID", "SAT_SIF_ID", "SAT_NAME", "SAT_DESCRIPTION", "SAT_PL_SQL", "SAT_JS", "SAT_IS_EDITABLE", "SAT_RAISE_RECURSIVE", "SAT_ACTIVE") AS 
  select sat_id, sat_stg_id, sat_sif_id, pti_name sat_name, to_char(pti_description) sat_description, sat_pl_sql, sat_js, sat_is_editable, sat_raise_recursive, sat_active
  from sct_action_type
  join pit_translatable_item_v
    on sat_pti_id = pti_id
   and sat_pmg_name = pti_pmg_name
;
