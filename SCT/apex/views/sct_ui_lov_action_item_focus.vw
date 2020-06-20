create or replace editionable view SCT_UI_LOV_ACTION_ITEM_FOCUS
as 
select SIF_NAME d, SIF_ID r, SIF_ACTIVE
  from SCT_ACTION_ITEM_FOCUS_V;
