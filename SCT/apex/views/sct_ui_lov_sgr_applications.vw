create or replace view sct_ui_lov_sgr_applications as
  with params as(
       select v('APP_ID') app_id,
              sct_util.get_true is_true,
              case when instr(apex_util.get_groups_user_belongs_to(v('APP_USER')), 'SCT_ADMIN') > 0 then sct_util.get_true else sct_util.get_false end is_sct_admin
         from dual)
select /*+ NO_MERGE (p) */
       distinct application_name || ' (' || application_id || ')' d, application_id r
  from apex_applications app
  join sct_rule_group sgr
    on app.application_id = sgr.sgr_app_id
  join params p
    on (sgr.sgr_app_id != p.app_id or p.is_sct_admin = p.is_true);