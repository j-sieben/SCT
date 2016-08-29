create or replace force view ui_sct_main_groups as
with rule_details as (
       select sru_sgr_id, count(*) sru_amount
         from sct_rule
        group by sru_sgr_id)
select sgr.sgr_id, sgr.sgr_name, sgr.sgr_description, 
       app.application_name || ' (' || app.application_id || ')' application_name, 
       pag.page_name || ' (' || pag.page_id || ')' page_name, sru.sru_amount
  from sct_group sgr
  left join rule_details sru on sgr.sgr_id = sru.sru_sgr_id
  join apex_applications app on sgr.sgr_app_id = app.application_id
  join apex_application_pages pag 
    on sgr.sgr_app_id = pag.application_id
   and sgr.sgr_page_id = pag.page_id;
