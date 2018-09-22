create or replace view sct_ui_lov_sgr_applications as
  with params as(
       select v('APP_ID') app_id,
              case when instr(apex_util.get_groups_user_belongs_to(v('APP_USER')), 'SCT_ADMIN') > 0 then 1 else 0 end is_sct_admin
         from dual)
select /*+ NO_MERGE (p) */
       distinct application_name || ' (' || application_id || ')' d, application_id r
  from apex_applications app
  join sct_rule_group sgr
    on app.application_id = sgr.sgr_app_id
 cross join params p
 where (sgr.sgr_app_id != p.app_id or p.is_sct_admin = 1)
 union all
select 'Alle Anwendungen', 0
  from dual;