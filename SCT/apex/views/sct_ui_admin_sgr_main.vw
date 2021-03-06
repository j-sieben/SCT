create or replace view sct_ui_admin_sgr_main
as 
with params as (
       select utl_apex.get_application_id app_id,
              utl_apex.get_number('P1_SGR_APP_ID') sgr_app_id,
              utl_apex.get_number('P1_SGR_PAGE_ID') sgr_page_id,
              sct_util.c_true is_true,
              utl_apex.current_user_in_group('SCT_ADMIN') is_sct_admin
         from dual
       ),
       rule_details as (
       select sru_sgr_id, count(*) sru_amount
         from sct_rule
        group by sru_sgr_id),
       apex_action_details as(
       select saa_sgr_id, count(*) saa_amount
         from sct_apex_action
        group by saa_sgr_id)
select /*+ NO_MERGE (p) */
       sgr.sgr_app_id, sgr.sgr_page_id,
       sgr.sgr_id, sgr.sgr_name, sgr.sgr_description,
       app.application_name || ' (' || app.application_id || ')' application_name,
       pag.page_name || ' (Seite ' || pag.page_id || ')' page_name,
       coalesce(sru.sru_amount, 0) sru_amount, coalesce(saa.saa_amount, 0) saa_amount,
       sgr_with_recursion,
       /*case sgr_active when is_true then 'fa-check' else 'fa-times' end*/ sgr_active
  from sct_rule_group sgr
  left join rule_details sru
    on sgr.sgr_id = sru.sru_sgr_id
  left join apex_action_details saa
    on sgr.sgr_id = saa.saa_sgr_id
  join apex_applications app
    on sgr.sgr_app_id = app.application_id
  join apex_application_pages pag
    on sgr.sgr_app_id = pag.application_id
   and sgr.sgr_page_id = pag.page_id
  join params p
    on sgr.sgr_app_id = p.sgr_app_id
   and (sgr.sgr_page_id = p.sgr_page_id or p.sgr_page_id is null)
 where sgr.sgr_app_id != app_id
    or p.is_sct_admin = is_true;
