set define off

create or replace force view sct_ui_main_rules as
with params as (
       select sgr_id, sgr_app_id, sgr_page_id,
              '- ' sgr_page_prefix,
              ',' delimiter,
              '<span class="sct-error" title="Die Regel enth&auml;lt Fehler.">' span_error,
              '<span class="sct-error" title="Element \1 existiert nicht.">\1</span>\2' regex_repl,
              '<span class="sct-disabled">' span_disabled,
              '</span>' close_span,
              '<i class="fa fa-check"/>' fa_check,
              '<i class="fa fa-times"/>' fa_uncheck,
              '<br/>' br,
              '[ ''\(]*(' || coalesce(listagg(spi_id, '|') within group (order by spi_id), 'FOO')|| ')([: ''\)$]*)' regex_err 
         from sct_rule_group sgr
         left join (
              select spi_sgr_id, spi_id
                from sct_page_item spi
               where spi_has_error = 1) spi
           on sgr.sgr_id = spi.spi_sgr_id
        group by sgr_id, sgr_app_id, sgr_page_id),
       actions as(
       select sru.rowid row_id, sru.sru_id, p.sgr_id,
              case
                when sru.sru_has_error = 1 then p.span_error || sru.sru_name || p.close_span
                else sru.sru_name
              end sru_name,
              p.sgr_app_id, 
              p.sgr_page_id,
              replace(
                replace(
                  dbms_lob.substr(sru.sru_condition, 4000, 1), ' and ', p.br || 'and '
                ), ' or ', p.br || 'or '
              ) sru_condition,
              case
                when sru.sru_firing_items is not null then p.sgr_page_prefix
                else '- Alle - '
              end
              ||
              replace(sru.sru_firing_items, p.delimiter, p.br || p.sgr_page_prefix) sru_firing_items,
              sru.sru_sort_seq,
              sra_name,
              case sru.sru_active when 1 then p.fa_check else p.fa_uncheck end sru_active,
              p.regex_repl, p.regex_err
         from params p
         join sct_rule sru
           on p.sgr_id = sru.sru_sgr_id
         left join (
              select sra.sra_sgr_id, sra.sra_sru_id,
                     listagg(
                       case
                         when sra.sra_active = 0 then p.span_disabled || p.sgr_page_prefix || sra_spi_id || ': ' || sat_name || p.close_span
                         else p.sgr_page_prefix || sra_spi_id || ': ' || sat_name
                       end, '<br>') within group (order by sra_sort_seq) sra_name
                from sct_rule_action sra
                join sct_action_type sat
                  on sra.sra_sat_id = sat.sat_id
                join params p
                  on sra.sra_sgr_id = p.sgr_id
               group by sra.sra_sgr_id, sra.sra_sru_id) sra
           on sru_id = sra_sru_id)
select a.row_id,
       app.application_id,
       app.application_name || ' (' || app.application_id || ')' application_name,
       pag.page_id,
       pag.page_name || ' (' || pag.page_id || ')' page_name,
       a.sru_id, a.sgr_id, a.sru_name, a.sru_sort_seq,
       regexp_replace(a.sru_condition, regex_err, regex_repl, 1, 0, 'i') sru_condition, 
       regexp_replace(a.sru_firing_items, regex_err, regex_repl, 1, 0, 'i') sru_firing_items,
       regexp_replace(a.sra_name, regex_err, regex_repl, 1, 0, 'i') sru_action,
       sru_active
  from actions a
  join apex_applications app
    on a.sgr_app_id = app.application_id
  join apex_application_pages pag
    on a.sgr_app_id = pag.application_id
   and a.sgr_page_id = pag.page_id;

set define on