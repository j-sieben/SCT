create or replace package utl_apex
as
  /* Methode zum Testen, ob ein Autorisierungsschema aktuell erfuellt ist oder nicht.
   * %param p_authorization_scheme Name des Autorisierungsschemas
   * %return Flag, das anzeigt, ob das Autorisierungsschema erfuellt ist (1) oder nicht (0)
   * %usage Wrapper um APEX_UTIL.PUBLIC_CHECK_AUTHORIZATION, die allerdings
   *        Boolean liefert und daher nicht in SQL verwendet werden kann.
   */
  function get_authorization_status_for(
    p_authorization_scheme in varchar2)
    return number;
    
  /* Methode zum Laden einer CLOB-Spalte als Datei ueber APEX
   * %param p_clob CLOB-Instanz, die geladen werden soll
   * %param p_file_name Name der Datei des Downloads
   * %usage Wird verwendet, um CLOB-Instanzen ueber eine APEX-Oberflaeche
   *        als Datei zu laden.
   */
  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2);
    
end utl_apex;
/

create or replace package body utl_apex
as
  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;
  
  function get_authorization_status_for(
    p_authorization_scheme in varchar2)
    return number
  as
  begin
    pit.enter_optional('get_authorization_status_for', c_pkg);
    if apex_util.public_check_authorization(p_authorization_scheme) then
      pit.leave_optional;
      return 1;
    else
      pit.leave_optional;
      return 0;
    end if;
  end get_authorization_status_for;
  
  
  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2)
  as
    l_blob blob;
    l_lang_context  integer := DBMS_LOB.DEFAULT_LANG_CTX;
    l_warning       integer := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;
    l_dest_offset   integer := 1;
    l_source_offset integer := 1;
  begin
    pit.enter_optional('download_clob', c_pkg);
    dbms_lob.createtemporary(l_blob, true, dbms_lob.call);  
    dbms_lob.converttoblob (
      dest_lob => l_blob,
      src_clob => p_clob,
      amount => DBMS_LOB.LOBMAXSIZE,
      dest_offset => l_dest_offset,
      src_offset => l_source_offset,
      blob_csid => DBMS_LOB.DEFAULT_CSID,
      lang_context => l_lang_context,
      warning => l_warning
    );
  
    htp.init;
    owa_util.mime_header('application/octet-stream', FALSE, 'UTF-8');
    htp.p('Content-length: ' || dbms_lob.getlength(l_blob));
    htp.p('Content-Disposition: inline; filename="' || p_file_name || '"');
    owa_util.http_header_close;
    wpg_docload.download_file(l_blob);
    apex_application.stop_apex_engine;
    
    pit.leave_optional;
  exception when others then
    htp.p('error: ' || sqlerrm);
    apex_application.stop_apex_engine;
    pit.leave_optional;
  end download_clob;
end utl_apex;
/
