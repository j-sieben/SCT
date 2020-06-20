create or replace editionable view SCT_UI_LOV_ACTION_PARAM_TYPE
as 
select SPT_NAME d, SPT_ID r, SPT_ACTIVE
  from SCT_ACTION_PARAM_TYPE_V;
