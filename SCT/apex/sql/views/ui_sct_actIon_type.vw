create or replace force view ui_sct_action_type as
select rowid row_id, sat_id, sat_name, sat_pl_sql, sat_js,
       case sat_changes_value when 'Y' then '<i class="fa fa-check"/>' else '<i>-</i>' end sat_changes_value
  from sct_action_type;
