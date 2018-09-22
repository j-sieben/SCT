create or replace view sct_ui_lov_sgr_app_pages as
  with params as(
       select v('APP_ID') app_id,
              case when instr(apex_util.get_groups_user_belongs_to(v('APP_USER')), 'SCT_ADMIN') > 0 then 1 else 0 end is_sct_admin
         from dual)
select page_name || ' (' || page_id || ')' d, page_id r, sgr.sgr_app_id
  from apex_application_pages app
  join sct_rule_group sgr
    on app.application_id = sgr.sgr_app_id
   and app.page_id = sgr.sgr_page_id
 cross join params p
 where sgr.sgr_app_id != p.app_id
    or p.is_sct_admin = 1;
