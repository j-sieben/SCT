declare
  l_is_installed pls_integer;
begin
  select count(*)
    into l_is_installed
	  from all_objects
   where owner = '&INSTALL_USER.'
     and object_type in ('PACKAGE')
     and object_name in ('UTL_APEX');
  if l_is_installed < 1 then
    raise_application_error(-20000, 'Installation of UTL_APEX is required to install SCT. Please install this package or its client install.');
  else
    dbms_output.put_line('&s1.Installation prerequisites checked succesfully.');
  end if;
end;
/
