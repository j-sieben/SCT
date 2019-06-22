create or replace view sct_ui_edit_sat as
select sat_id, sat_stg_id, sat_sif_id, sat_name, sat_description, sat_pl_sql, sat_js, sat_is_editable, sat_raise_recursive, sat_active,
       sap_spt_id_1, sap_display_name_1, sap_description_1, sap_default_1, sap_mandatory_1, sap_active_1,
       sap_spt_id_2, sap_display_name_2, sap_description_2, sap_default_2, sap_mandatory_2, sap_active_2, 
       sap_spt_id_3, sap_display_name_3, sap_description_3, sap_default_3, sap_mandatory_3, sap_active_3
  from sct_action_type_v
  left join (
        select sap_sat_id,
               max(decode(sap_sort_seq, 1, sap_spt_id)) sap_spt_id_1,
               max(decode(sap_sort_seq, 1, sap_display_name)) sap_display_name_1,
               max(decode(sap_sort_seq, 1, sap_description)) sap_description_1,
               max(decode(sap_sort_seq, 1, sap_default)) sap_default_1,
               max(decode(sap_sort_seq, 1, sap_mandatory)) sap_mandatory_1,
               max(decode(sap_sort_seq, 1, sap_active)) sap_active_1,
               max(decode(sap_sort_seq, 2, sap_spt_id)) sap_spt_id_2,
               max(decode(sap_sort_seq, 2, sap_display_name)) sap_display_name_2,
               max(decode(sap_sort_seq, 2, sap_description)) sap_description_2,
               max(decode(sap_sort_seq, 2, sap_default)) sap_default_2,
               max(decode(sap_sort_seq, 2, sap_mandatory)) sap_mandatory_2,
               max(decode(sap_sort_seq, 2, sap_active)) sap_active_2,
               max(decode(sap_sort_seq, 3, sap_spt_id)) sap_spt_id_3,
               max(decode(sap_sort_seq, 3, sap_display_name)) sap_display_name_3,
               max(decode(sap_sort_seq, 3, sap_description)) sap_description_3,
               max(decode(sap_sort_seq, 3, sap_default)) sap_default_3,
               max(decode(sap_sort_seq, 3, sap_mandatory)) sap_mandatory_3,
               max(decode(sap_sort_seq, 3, sap_active)) sap_active_3
          from sct_action_parameter_v
         group by sap_sat_id)
    on sat_id = sap_sat_id;