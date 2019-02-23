create or replace view sct_action_parameter_v as
select sap_sat_id, sap_spt_id, pti_name sap_display_name, to_char(pti_description) sap_description, sap_sort_seq, sap_default, sap_mandatory, sap_active
  from sct_action_parameter
  join pit_translatable_item_v
    on sap_pti_id = pti_id
   and sap_pmg_name = pti_pmg_name;