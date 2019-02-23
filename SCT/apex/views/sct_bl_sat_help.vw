create or replace view sct_bl_sat_help as
  with params as(
       select uttm_mode, uttm_text template
         from utl_text_templates
        where uttm_type = 'SCT'
          and uttm_name = 'ACTION_TYPE_HELP')
select sat_id, 
       utl_text.generate_text(cursor(
         select template,
                sat_name, sat_description, 
                utl_text.generate_text(cursor(
                  select template,
                         sap_sort_seq, coalesce(sap_display_name, spt_name) spt_name, sap_description, spt_description
                    from sct_action_parameter_v p
                    join sct_action_param_type_v
                      on sap_spt_id = spt_id
                   cross join params
                   where p.sap_sat_id = s.sat_id
                     and uttm_mode = 'PARAMETERS'
                   order by sat_id, sap_sort_seq)) parameters
           from sct_action_type_v s
          cross join params
          where s.sat_id = sat.sat_id
            and uttm_mode = 'FRAME')) help_text
  from sct_action_type_v sat;