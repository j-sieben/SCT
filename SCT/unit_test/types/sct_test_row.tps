create or replace type sct_test_row as object(
  sru_id number,
  sru_sort_seq number,
  sru_name varchar2(50),
  sru_firing_items varchar2(200),
  sru_fire_on_page_load &FLAG_TYPE.,
  item varchar2(128 byte),
  pl_sql varchar2(4000 byte),
  js varchar2(4000 byte),
  sra_sort_seq number,
  sra_param_1 varchar2(4000 byte),
  sra_param_2 varchar2(4000 byte),
  sra_param_3 varchar2(4000 byte),
  sra_on_error &FLAG_TYPE.,
  sru_on_error &FLAG_TYPE.,
  is_first_row &FLAG_TYPE.,
  id number,                               -- internal ID of the record
  sgr_id number,                           -- actual SGR_ID
  firing_item varchar2(128 byte),          -- actual firing item (or sct_util.C_NO_FIRING_ITEM)
  firing_event varchar2(128 byte),         -- actual firing event (normally change or click, but can be any event)
  error_dependent_items varchar2(2000),    -- List of items to deactivate if the page contains errors
  bind_items char_table,                   -- List of items for which SCT binds event handlers
  page_items char_table,                   -- List of items that changed their value in the session state
  firing_items char_table,                 -- List of items which are connected with firing item within their rules
  error_stack char_table,                  -- List errors that occurred
  recursive_stack char_table,              -- List of items which were marked to recursively check rules for
  is_recursive varchar2(128 byte),         -- Flag to indicate whether we're in a recursive rule run
  js_action_stack sct_test_js_list,        -- JavaScript action stack, rule outcome of the rules executed so far
  level_length char_table,                 -- cumulated length of the strings on the respective severity levels
  recursive_level number,                  -- actual recursive level
  allow_recursion &FLAG_TYPE.,             -- Flag to indicate whether recursive calls are allowed for the active rule
  notification_stack varchar2(4000 byte),  -- List of notifications to be shown in the browser console
  stop_flag &FLAG_TYPE.,                   -- Flag to indicate that all rule execution has to be stopped
  now number                               -- Time in hsec
);
/

