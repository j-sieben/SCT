create or replace editionable view SCT_UI_LOV_ACTION_TYPE_GROUP
as 
select STG_NAME d, STG_ID r, STG_ACTIVE
  from SCT_ACTION_TYPE_GROUP_V;
