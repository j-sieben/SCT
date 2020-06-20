create or replace editionable view sct_ui_edit_rule_action
as 
select sra_id,
       sra_sgr_id,
       sra_sru_id,
       sra_spi_id,
       sra_sat_id,
       sra_sort_seq,
       sra_param_1,
       sra_param_2,
       sra_param_3,
       sra_comment,
       sra_on_error,
       sra_raise_recursive,
       sra_active,
       sra_has_error
  from sct_rule_action;
