create or replace force view ui_sct_edit_rule as
select sru.rowid row_id, sru.sru_id, sru.sru_sgr_id, sru.sru_name, sru.sru_condition, sru.sru_firing_items,
       sru.sru_sort_seq, sgr.sgr_app_id, sgr.sgr_page_id, sru.sru_active
  from sct_rule sru
  join sct_rule_group sgr
    on sru.sru_sgr_id = sgr.sgr_id;
