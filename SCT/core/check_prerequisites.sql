
declare
  l_is_installed pls_integer;
begin
  select count(*)
    into l_is_installed
	from dba_objects
   where owner = '&INSTALL_USER.'
     and object_type in ('PACKAGE', 'SYNONYM')
	 and object_name in ('UTL_TEXT', 'PIT');
  if l_is_installed < 2 then
    raise_application_error(-20000, 'Installation of UTL_TEXT and PIT is required to install SCT. An installation script is provided at the install directory., PIT is available at GitHub');
  else
    dbms_output.put_line('&s1.Installation prerequisites checked succesfully.');
  end if;
end;
/
