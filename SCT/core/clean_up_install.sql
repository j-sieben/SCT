declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4043);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2289);
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1434);
  cursor delete_object_cur is
          select object_name name, object_type type
            from all_objects
           where (object_name in (
                 '', -- Typen
                 'SCT_ADMIN', 'SCT_UTIL', -- Packages
                 'SCT_BL_RULES', 'SCT_BL_PAGE_ITEMS', 'SCT_PARAM_LOV_APEX_ACTION', 
                 'SCT_PARAM_LOV_PAGE_ITEM', 'SCT_PARAM_LOV_PIT_MESSAGE', 'SCT_PARAM_LOV_SEQUENCE', -- Views
                 'SCT_ACTION_ITEM_FOCUS_V', 'SCT_ACTION_PARAM_TYPE_V', 'SCT_ACTION_PARAMETER_V', 'SCT_ACTION_TYPE_GROUP_V', 'SCT_ACTION_TYPE_V',
                 'SCT_APEX_ACTION_TYPE_V', -- DL-Views
                 'SCT_ACTION_ITEM_FOCUS', 'SCT_ACTION_PARAM_TYPE', 'SCT_ACTION_PARAMETER', 'SCT_ACTION_TYPE', 'SCT_ACTION_TYPE_GROUP',
                 'SCT_APEX_ACTION', 'SCT_APEX_ACTION_ITEM',  'SCT_APEX_ACTION_TYPE', 'SCT_PAGE_ITEM', 'SCT_PAGE_ITEM_TYPE', 
                 'SCT_RULE', 'SCT_RULE_ACTION', 'SCT_RULE_GROUP', -- Tabellen
                 '',  -- Synonyme
                 'SCT_SEQ' -- Sequenzen
                 )
                 or object_name like 'SCT_RULES_GROUP%')
             and object_type not like '%BODY'
             and owner = upper('&INSTALL_USER.')
           order by object_type, object_name;
           
  cursor sct_rule_cur is
    select view_name
      from all_views
     where owner = upper('&INSTALL_USER.')
       and view_name like 'SCT_RULE_GROUP%';
begin
  for obj in delete_object_cur loop
    begin
      execute immediate 'drop ' || obj.type || ' &INSTALL_USER..' || obj.name ||
                        case obj.type 
                        when 'TYPE' then ' force' 
                        when 'TABLE' then ' cascade constraints' 
                        end;
     dbms_output.put_line('&s1.' || initcap(obj.type) || ' ' || obj.name || ' deleted.');
    
    exception
      when object_does_not_exist or table_does_not_exist or sequence_does_not_exist or synonym_does_not_exist then
        dbms_output.put_line('&s1.' || obj.type || ' ' || obj.name || ' does not exist.');
      when others then
        raise;
    end;
  end loop;
  
  -- drop rule group views
  for vw in sct_rule_cur loop
    execute immediate 'drop view &INSTALL_USER..' || vw.view_name;
  end loop;

  pit_admin.remove_message_group('SCT');
  dbms_session.reset_package;
  pit_admin.create_message_package;
  dbms_output.put_line('&s1.Messages deleted.');
  
  utl_text.remove_templates(p_uttm_type => 'SCT');
  commit;
end;
/
