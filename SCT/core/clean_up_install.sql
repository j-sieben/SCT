set serveroutput on

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
                 'SCT_RULE_GROUP_STATUS', 'SCT_BL_PAGE_ITEMS', 'SCT_BL_PAGE_TARGETS', 'SCT_BL_RULES', 'SCT_BL_SAT_HELP', 
                 'SCT_ACTION_ITEM_FOCUS_V', 'SCT_ACTION_PARAM_TYPE_V', 'SCT_ACTION_PARAMETER_V', 'SCT_ACTION_TYPE_GROUP_V', 
                 'SCT_APEX_ACTION_TYPE_V', 'SCT_PAGE_ITEM_TYPE_V', 
                 'SCT_PARAM_LOV_APEX_ACTION', 'SCT_PARAM_LOV_PAGE_ITEM', 'SCT_PARAM_LOV_PIT_MESSAGE', 'SCT_PARAM_LOV_SEQUENCE', -- Views
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
  param_admin.delete_parameter_group('SCT', true);  
  utl_text.remove_templates('SCT');
  
end;
/
