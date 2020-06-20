create or replace editionable view sct_ui_edit_sru
as 
select sru.sru_id, sru.sru_sgr_id, sru.sru_name, sru.sru_condition,
       sru.sru_sort_seq, sru.sru_active, sru.sru_fire_on_page_load
  from sct_rule sru
  join sct_rule_group sgr
    on sru.sru_sgr_id = sgr.sgr_id;
