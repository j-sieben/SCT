create or replace editionable view sct_ui_admin_sat
as 
with params as (
       select utl_apex.current_user_in_group('SCT_ADMIN') is_sct_admin,
              sct_util.c_false c_false,
              'EDIT_SAT' target_page,
              'P3_SAT_ID' target_item
         from dual)
select /*+ NO_MERGE (p) */
       g.stg_name,
       a.sat_id,
       a.sat_name || case a.sat_active when sct_util.C_FALSE then ' (deprecated)' end sat_name,
       a.sat_is_editable,
       replace(a.sat_pl_sql, chr(13), '<br>') sat_pl_sql,
       replace(a.sat_js, chr(13), '<br>') sat_js,
       a.sat_description,
       case 
         when is_sct_admin = c_false and a.sat_is_editable = c_false then 'fa-lock'
         else 'fa-pencil'
       end link_icon,
       case 
         when is_sct_admin = c_false and a.sat_is_editable = c_false then '#'
         else apex_page.get_url(
                p_page => target_page,
                p_items => target_item,
                p_values => a.sat_id)
       end link_target
  from sct_action_type_v a
  join sct_action_type_group_v g
    on a.sat_stg_id = g.stg_id
 cross join params p;


comment on table sct_ui_admin_sat is 'View for page ADMIN_SAT';