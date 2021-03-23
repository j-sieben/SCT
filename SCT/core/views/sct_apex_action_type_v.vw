create or replace view sct_apex_action_type_v as
select sty_id, pti_name sty_name, to_char(pti_description) sty_description, sty_active
  from sct_apex_action_type
  join pit_translatable_item_v
    on sty_pti_id = pti_id
   and sty_pmg_name = pti_pmg_name;
