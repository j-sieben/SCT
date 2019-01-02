create or replace view sct_ui_lov_sgr_app_pages as
  with params as(
       select v('APP_ID') app_id,
              sct_util.get_true is_true,
              case when instr(apex_util.get_groups_user_belongs_to(v('APP_USER')), 'SCT_ADMIN') > 0 then sct_util.get_true else sct_util.get_false end is_sct_admin
         from dual)
select /*+ no merge(p) */
       page_name || ' (' || page_id || ')' d, page_id r, sgr.sgr_app_id
  from apex_application_pages app
  join sct_rule_group sgr
    on app.application_id = sgr.sgr_app_id
   and app.page_id = sgr.sgr_page_id
 cross join params p
 where sgr.sgr_app_id != p.app_id
    or p.is_sct_admin = is_true;
