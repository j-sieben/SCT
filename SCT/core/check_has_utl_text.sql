column script new_value SCRIPT
select case when count(*) = 0
            then '&1.' 
            else 'null.sql' end script
  from all_objects
 where object_type = 'PACKAGE'
   and object_name = 'UTL_TEXT'
   and owner = '&INSTALL_USER.';
  
@&script.