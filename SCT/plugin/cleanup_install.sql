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
                 'SCT_ADMIN', -- Packages
                 'SCT_BL_RULES', -- Views
                 'SCT_RULE_ACTION', 'SCT_RULE', 'SCT_PAGE_ITEM', 'SCT_ACTION_TYPE', 'SCT_GROUP',   -- Tabellen
                 '',  -- Synonyme
                 'SCT_SEQ' -- Sequenzen
                 )
             and object_type not like '%BODY'
             and owner = upper('&INSTALL_USER.')
           order by object_type, object_name;
  cursor context_cur is
    select namespace
      from dba_context
     where schema = upper('&INSTALL_USER.')
       and namespace in ('PIT_CTX');
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
  for ctx in context_cur loop
    execute immediate 'drop context ' || ctx.namespace;
    dbms_output.put_line('&s1.Context ' || ctx.namespace || ' deleted.');
  end loop;
end;
/