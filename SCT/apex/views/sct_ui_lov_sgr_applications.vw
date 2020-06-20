create or replace editionable view sct_ui_lov_sgr_applications
as 
  with params as(
       select utl_apex.get_application_id app_id,
              sct_util.get_true is_true,
              utl_apex.current_user_in_group('SCT_ADMIN') is_sct_admin
         from dual)
select /*+ NO_MERGE (p) */
       distinct application_name || ' (' || application_id || ')' d, application_id r
  from apex_applications app
  join sct_rule_group sgr
    on app.application_id = sgr.sgr_app_id
  join params p
    on (sgr.sgr_app_id != p.app_id or p.is_sct_admin = p.is_true);
