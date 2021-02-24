declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4043);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2282);
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1434);
  cursor delete_object_cur is
          select object_name name, object_type type
            from all_objects
           where object_name in (
                 '', -- Typen
                 'SCT_UI', 'PLUGIN_GROUP_SELECT_LIST', -- Packages
                 'SCT_UI_ADMIN_SAT', 'SCT_UI_ADMIN_SGR_MAIN', 'SCT_UI_ADMIN_SGR_RULES', 'SCT_UI_EDIT_GROUP_APEX_ACTION', 
                 'SCT_UI_EDIT_RULE', 'SCT_UI_EDIT_RULE_ACTION', 'SCT_UI_EDIT_SAA', 'SCT_UI_EDIT_SAT', 'SCT_UI_EDIT_SGR', 
                 'SCT_UI_EDIT_SGR_APEX_ACTION', 'SCT_UI_EDIT_SRA', 'SCT_UI_EDIT_SRU', 'SCT_UI_EDIT_SRU_ACTION', 
                 'SCT_UI_LIST_ACTION_TYPE', 'SCT_UI_LIST_PAGE_ITEMS', 'SCT_UI_LOV_ACTION_ITEM_FOCUS', 
                 'SCT_UI_LOV_ACTION_PARAM_TYPE', 'SCT_UI_LOV_ACTION_TYPE_GROUP', 'SCT_UI_LOV_APEX_ACTION_ITEMS', 
                 'SCT_UI_LOV_APEX_ACTION_TYPE', 'SCT_UI_LOV_APPLICATIONS', 'SCT_UI_LOV_APP_PAGES', 'SCT_UI_LOV_EXPORT_TYPES', 
                 'SCT_UI_LOV_PAGE_ITEMS', 'SCT_UI_LOV_PAGE_ITEMS_P11', 'SCT_UI_LOV_SGR_APPLICATIONS', 
                 'SCT_UI_LOV_SGR_APP_PAGES', 'SCT_UI_LOV_SGR_PAGE_ITEMS', 'SCT_UI_LOV_YES_NO', -- Views
                 '',   -- Tabellen
                 '',  -- Synonyme
                 '' -- Sequenzen
                 )
             and object_type not like '%BODY'
             and owner = upper('&INSTALL_USER.')
           order by object_type, object_name;
begin
  for obj in delete_object_cur loop
    begin
      execute immediate 'drop ' || obj.type || ' ' || obj.name ||
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
  
end;
/


prompt &h3.Removing SCT groups
declare
  cursor sct_cur is
    select sgr_id
      from sct_rule_group
     where sgr_name like 'SCT%';
begin
  for r in sct_cur loop
    sct_admin.delete_rule_group(r.sgr_id);
  end loop;
end;
/

prompt &h3.Checking whether app exists.

declare
  l_app_id number;
  l_ws number;
  c_app_alias constant varchar2(30 byte) := '&APEX_ALIAS.';  
begin
  select application_id, workspace_id
    into l_app_id, l_ws
    from apex_applications
   where alias = c_app_alias
     and owner = '&INSTALL_USER.';
   
  dbms_output.put_line('&s1.Remove application ' || c_app_alias);
  wwv_flow_api.set_security_group_id(l_ws);
  wwv_flow_api.remove_flow(l_app_id);
exception
  when others then
    dbms_output.put_line('&s1.Application ' || c_app_alias || ' does not exist');
end;
 /