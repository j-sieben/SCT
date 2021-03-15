create or replace editionable view sct_ui_admin_sgr_rules
as
with params as (
       select sgr_id, sgr_app_id, sgr_page_id, sgr_name,
              '- ' sgr_page_prefix,
              ',' delimiter,
              '<span class="sct-error" title="Element existiert nicht.">' span_error,
              '<span class="sct-on-error">' span_on_error,
              '<span class="sct-disabled">' span_disabled,
              '</span>' close_span,
              '<br/>' br,
              sct_util.c_true c_true,
              sct_util.c_false c_false
         from sct_rule_group
        where sgr_id = (select utl_apex.get_number('SGR_ID') from dual)),
       actions as(
       select /*+ no_merge (p) */ 
              p.sgr_app_id, p.sgr_page_id, p.sgr_name,
              sru.sru_id, sru.sru_sgr_id, sra.sra_id, sru.sru_sort_seq, sra.sra_sort_seq, sru.sru_fire_on_page_load, sru.sru_active,
              case
                when spi.spi_id is not null then p.span_error || sru.sru_name || p.close_span
                else sru.sru_name
              end sru_name,
              replace(replace(dbms_lob.substr(sru.sru_condition, 4000, 1), ' and ', p.br || 'and '), ' or ', p.br || 'or ') sru_condition,
              case
                when sru.sru_firing_items is not null then p.sgr_page_prefix
                else '- Alle - '
              end
              ||
              replace(
              case
                when spi.spi_id is not null then
                  replace(p.delimiter || sru.sru_firing_items || p.delimiter, p.delimiter || spi_id || p.delimiter, p.span_error || spi_id || p.close_span)
                else sru.sru_firing_items
              end, p.delimiter, p.br || p.sgr_page_prefix) sru_firing_items,
              case
                when sra.spi_has_error = p.c_true then p.span_error || p.sgr_page_prefix || sra_spi_id || ': ' || sat_name || p.close_span
                when sra.sra_on_error = p.c_true then p.span_on_error || p.sgr_page_prefix || sra_spi_id || ': ' || sat_name || p.close_span
                when sra.sra_active = p.c_false then p.span_disabled || p.sgr_page_prefix || sra_spi_id || ': ' || sat_name || p.close_span
                else p.sgr_page_prefix || sra_spi_id || ': ' || sat_name
              end sra_name
         from params p
         join sct_rule sru
           on p.sgr_id = sru.sru_sgr_id
         left join sct_page_item spi
           on sru.sru_sgr_id = spi.spi_sgr_id
          and instr(p.delimiter || sru_firing_items || p.delimiter, p.delimiter || spi.spi_id || p.delimiter) > 0
          and spi.spi_has_error = p.c_true
         left join (
              select sra.sra_id, sra.sra_sgr_id,
                     case when sra.sra_spi_id = 'DOCUMENT' and to_char(sra.sra_param_2) is not null then '[' || to_char(sra.sra_param_2) || ']' else sra.sra_spi_id end sra_spi_id,
                     sra.sra_sru_id, sra.sra_sat_id, sra.sra_sort_seq, sra.sra_active, spi.spi_has_error, sra.sra_on_error
                from sct_rule_action sra
                join sct_page_item spi
                  on sra.sra_sgr_id = spi.spi_sgr_id
                 and sra.sra_spi_id = spi.spi_id) sra
           on sru_id = sra_sru_id
         left join sct_action_type_v sat
           on sra_sat_id = sat_id)
select app.application_name || ' (' || app.application_id || ')' application_name,
       pag.page_name || ' (' || pag.page_id || ')' page_name,
       sgr_name, 
       sru_id, sru_sgr_id, sru_name, sru_condition, sru_firing_items, sru_sort_seq, sru_fire_on_page_load, sru_active,
       listagg(sra_name, '<br>')
         within group (order by sra_sort_seq) sru_action
  from actions a
  join apex_applications app
    on sgr_app_id = app.application_id
  join apex_application_pages pag
    on sgr_app_id = pag.application_id
   and sgr_page_id = pag.page_id
 group by sgr_app_id, app.application_name || ' (' || app.application_id || ')',
       pag.page_id, pag.page_name || ' (' || pag.page_id || ')',
       sru_id, sru_sgr_id, sgr_name, sru_name, sru_condition, sru_firing_items, sru_sort_seq, sru_fire_on_page_load, sru_active;
