define plsql_dir=apex/plsql/

prompt &s1.Create package UTL_APEX
@&plsql_dir.utl_apex.pks
show errors

prompt &s1.Create package Body UTL_APEX
@&plsql_dir.utl_apex.pkb
show errors
