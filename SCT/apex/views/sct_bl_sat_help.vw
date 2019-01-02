create or replace view sct_bl_sat_help as
select sat_id, 
       utl_text.generate_text(cursor(
         select '<h2>#SAT_NAME#</h2><div>#SAT_DESCRIPTION#</div>#PARAMETERS|<h3>Parameter:</h3><div><dl>|</dl></div>#' template,
                sat_name, sat_description, 
                utl_text.generate_text(cursor(
                  select '<dt>#SPT_NAME#</dt><dd>#SAP_DESCRIPTION##SPT_DESCRIPTION#</dd>' template,
                         sap_sort_seq, coalesce(sap_display_name, spt_name) spt_name, sap_description, spt_description
                    from sct_action_parameter_v p
                    join sct_action_param_type_v
                      on sap_spt_id = spt_id
                   where p.sap_sat_id = s.sat_id
                   order by sat_id, sap_sort_seq)) parameters
           from sct_action_type_v s
          where s.sat_id = sat.sat_id)) help_text
  from sct_action_type_v sat;