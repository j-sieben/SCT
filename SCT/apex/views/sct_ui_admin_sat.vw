create or replace force view sct_ui_admin_sat as
  with params as (
       select case when instr(apex_util.get_groups_user_belongs_to(v('APP_USER')), 'SCT_ADMIN') > 0 then 1 else 0 end is_sct_admin
         from dual)
select /*+ NO_MERGE (p) */
       g.stg_name,
       a.sat_id,
       a.sat_name,
       a.sat_is_editable,
       replace(a.sat_pl_sql, chr(13), '<br>') sat_pl_sql,
       replace(a.sat_js, chr(13), '<br>') sat_js,
       a.sat_description
  from sct_action_type_v a
  join sct_action_type_group_v g
    on a.sat_stg_id = g.stg_id
 cross join params p;
