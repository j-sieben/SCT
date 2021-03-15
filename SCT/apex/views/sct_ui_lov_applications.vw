create or replace editionable view sct_ui_lov_applications
as 
with params as(
       select utl_apex.get_application_id app_id,
              utl_apex.current_user_in_group('SCT_ADMIN') is_sct_admin,
              utl_apex.c_true c_true
         from dual)
select /*+ NO_MERGE (p) */
       a.application_name || ' (' || a.application_id || ')' d,
       a.application_id r
  from apex_applications a
 cross join params p
 where (application_id != p.app_id or p.is_sct_admin = p.c_true)
   and application_id not between 3000 and 9000;

comment on table sct_ui_lov_applications is 'LOV view that displays all user defined APEX applications. Application SCT is excluded, unless the user is Administrator';