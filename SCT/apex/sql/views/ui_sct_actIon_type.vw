create or replace force view ui_sct_action_type as
select rowid row_id, sat_id, sat_name,
       replace(sat_pl_sql, chr(13), '<br>') sat_pl_sql,
       replace(sat_js, chr(13), '<br>') sat_js
  from sct_action_type;
