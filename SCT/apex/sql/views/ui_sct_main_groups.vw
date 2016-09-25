create or replace force view ui_sct_main_groups as
with params as (
       select v('APP_ID') app_id,
              v('P1_SGR_APPLICATION') sgr_app_id,
              v('P1_SGR_PAGE') sgr_page_id
         from dual
       ),
       rule_details as (
       select sru_sgr_id, count(*) sru_amount
         from sct_rule
        group by sru_sgr_id)
select /*+ NO_MERGE (p) */sgr.sgr_id, sgr.sgr_name, sgr.sgr_description,
       app.application_name || ' (' || app.application_id || ')' application_name,
       pag.page_name || ' (' || pag.page_id || ')' page_name, coalesce(sru.sru_amount, 0) sru_amount,
       case sgr_active when 1 then '<i class="fa fa-check"/>' else '<i class="fa fa-times"/>' end sgr_active
  from sct_rule_group sgr
  left join rule_details sru
    on sgr.sgr_id = sru.sru_sgr_id
  join apex_applications app
    on sgr.sgr_app_id = app.application_id
  join apex_application_pages pag
    on sgr.sgr_app_id = pag.application_id
   and sgr.sgr_page_id = pag.page_id
  join params p
    on (sgr.sgr_app_id = p.sgr_app_id or p.sgr_app_id is null)
   and (sgr.sgr_page_id = p.sgr_page_id or p.sgr_page_id is null)
 where sgr.sgr_app_id != app_id;
