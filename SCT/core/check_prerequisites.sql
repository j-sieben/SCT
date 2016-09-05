
declare
  l_is_installed pls_integer;
begin
  select count(*)
    into l_is_installed
	from dba_objects
   where owner = '&INSTALL_USER.'
     and object_type = 'PACKAGE'
	 and object_name in ('UTL_TEXT');
  if l_is_installed = 0 then
    raise_application_error(-20000, 'Installation of UTL_TEXT is required to install SCT. An installation script is provided at the install directory.');
  else
    dbms_output.put_line('&s1.Installation prerequisites checked succesfully.');
  end if;
end;
/
