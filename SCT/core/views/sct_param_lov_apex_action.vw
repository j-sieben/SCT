create or replace view sct_param_lov_apex_action
as 
select saa_name d, saa_id r, saa_sgr_id sgr_id
  from sct_apex_action;
