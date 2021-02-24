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
                 'SCT_ADMIN', 'SCT_INTERNAL', 'SCT_UTIL', 'SCT_VALIDATION', 'SCT', 'UTL_SCT', 'UTL_APEX_ACTION', -- Packages
                 'SCT_UI_ADMIN_SAT', 'SCT_UI_ADMIN_SGR_MAIN', 'SCT_UI_ADMIN_SGR_RULES', 'SCT_UI_EDIT_GROUP_APEX_ACTION', 
                 'SCT_UI_EDIT_RULE', 'SCT_UI_EDIT_RULE_ACTION', 'SCT_UI_EDIT_SAA', 'SCT_UI_EDIT_SAT', 'SCT_UI_EDIT_SGR', 
                 'SCT_UI_EDIT_SGR_APEX_ACTION', 'SCT_UI_EDIT_SRA', 'SCT_UI_EDIT_SRU', 'SCT_UI_EDIT_SRU_ACTION', 
                 'SCT_UI_LIST_ACTION_TYPE', 'SCT_UI_LIST_PAGE_ITEMS', 'SCT_UI_LOV_ACTION_ITEM_FOCUS', 
                 'SCT_UI_LOV_ACTION_PARAM_TYPE', 'SCT_UI_LOV_ACTION_TYPE_GROUP', 'SCT_UI_LOV_APEX_ACTION_ITEMS', 
                 'SCT_UI_LOV_APEX_ACTION_TYPE', 'SCT_UI_LOV_APPLICATIONS', 'SCT_UI_LOV_APP_PAGES', 'SCT_UI_LOV_EXPORT_TYPES', 
                 'SCT_UI_LOV_PAGE_ITEMS', 'SCT_UI_LOV_PAGE_ITEMS_P11', 'SCT_UI_LOV_SGR_APPLICATIONS', 
                 'SCT_UI_LOV_SGR_APP_PAGES', 'SCT_UI_LOV_SGR_PAGE_ITEMS', 'SCT_UI_LOV_YES_NO', -- Views
                 'SCT_ACTION_ITEM_FOCUS', 'SCT_ACTION_PARAMETER', 'SCT_ACTION_PARAM_TYPE', 'SCT_ACTION_TYPE', 
                 'SCT_ACTION_TYPE_GROUP', 'SCT_APEX_ACTION', 'SCT_APEX_ACTION_ITEM', 'SCT_APEX_ACTION_TYPE', 'SCT_PAGE_ITEM', 
                 'SCT_PAGE_ITEM_TYPE', 'SCT_RULE', 'SCT_RULE_ACTION', 'SCT_RULE_GROUP',   -- Tabellen
                 '',  -- Synonyme
                 'SCT_SEQ' -- Sequenzen
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
  
  pit_admin.delete_message_group('SCT', true);
  
  utl_text.remove_templates('SCT');
  
end;
/
