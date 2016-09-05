create or replace force view ui_sct_main_rules as
with params as (
       select sgr_id, sgr_app_id, sgr_page_id,
              '- ' sgr_page_prefix
         from sct_group),
       actions as(
       select sru.rowid row_id, sru.sru_id, p.sgr_id, sru.sru_name, p.sgr_app_id, p.sgr_page_id,
              replace(replace(lower(dbms_lob.substr(sru.sru_condition, 4000, 1)), ' and ', '<br>and '), ' or ', '<br>or ') sru_condition,
              case when sru.sru_firing_items is not null then p.sgr_page_prefix else '- Alle - ' end || replace(sru.sru_firing_items, ':', '<br>' || p.sgr_page_prefix) sru_firing_items,
              sru.sru_sort_seq, sra.sra_sort_seq, p.sgr_page_prefix || sra_spi_id || ': ' || sat_name sra_name
         from params p
         join sct_rule sru on p.sgr_id = sru.sru_sgr_id
         left join sct_rule_action sra on sru_id = sra_sru_id
         left join sct_action_type sat on sra_sat_id = sat_id)
select a.row_id,
       app.application_id,
       app.application_name || ' (' || app.application_id || ')' application_name,
       pag.page_id,
       pag.page_name || ' (' || pag.page_id || ')' page_name,
       a.sru_id, a.sgr_id, a.sru_name, a.sru_condition, a.sru_firing_items, a.sru_sort_seq,
       listagg(a.sra_name, '<br>') within group (order by sra_sort_seq) sru_action
  from actions a
  join apex_applications app on a.sgr_app_id = app.application_id
  join apex_application_pages pag
    on a.sgr_app_id = pag.application_id
   and a.sgr_page_id = pag.page_id
 group by a.row_id, app.application_id, app.application_name || ' (' || app.application_id || ')',
       pag.page_id, pag.page_name || ' (' || pag.page_id || ')',
       a.sru_id, a.sgr_id, a.sru_name, a.sru_condition, a.sru_firing_items, a.sru_sort_seq;