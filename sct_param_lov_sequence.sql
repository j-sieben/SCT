--------------------------------------------------------
--  DDL for View SCT_PARAM_LOV_SEQUENCE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "SCT_PARAM_LOV_SEQUENCE" ("D", "R", "SGR_ID") AS 
  select sequence_name d, sequence_name r, null sgr_id
  from user_sequences
;
