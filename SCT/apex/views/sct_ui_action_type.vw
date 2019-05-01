create or replace force view SCT_UI_ACTION_TYPE
as
  with params as (
       select case when instr(apex_util.get_groups_user_belongs_to(v('APP_USER')), 'SCT_ADMIN') > 0 then 1 else 0 end is_sct_admin
         from dual)
select /*+ NO_MERGE (p) */
       case
         when a.sat_is_editable = 1 or p.is_sct_admin = 1 then
           '<a href="' || apex_util.prepare_url( p_url => 'f?p=' || v('APP_ALIAS') || ':EDIT_ACTION_TYPE:' || v('SESSION') || '::NO::P3_ROWID:' || a.rowid, p_checksum_type => 'SESSION') || '"><i class="fa fa-pencil"></i></a>'/*<img src="/i/menu/pencil2_16x16.gif"></a>'*/
         else ''
       end edit_link,
       a.rowid row_id,
       a.sat_id,
       a.sat_name,
       a.sat_is_editable,
       replace(a.sat_pl_sql, chr(13), '<br>') sat_pl_sql,
       replace(a.sat_js, chr(13), '<br>') sat_js,
       a.sat_description
  from sct_action_type_v a
 cross join params p;
