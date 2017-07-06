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
    
    
  /* Methode zur Konvertierung von CLOB nach BLOB.
   * TODO: Falls UTL_TEXT verwendet wird, sollte die dort vorhandene Methode verwendet werden
   */
  function clob_to_blob(
    p_clob in clob)
    return blob;
    
    
  /* Methode zum Laden einer CLOB-Spalte als Datei ueber APEX
   * %param p_clob CLOB-Instanz, die geladen werden soll
   * %param p_file_name Name der Datei des Downloads
   * %usage Wird verwendet, um CLOB-Instanzen ueber eine APEX-Oberflaeche
   *        als Datei zu laden.
   */
  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2);
   
  /* Methode zum Laden einer BLOB-Spalte als Datei ueber APEX
   * %param p_blob BLOB-Instanz, die geladen werden soll
   * %param p_file_name Name der Datei des Downloads
   * %usage Wird verwendet, um CLOB-Instanzen ueber eine APEX-Oberflaeche
   *        als Datei zu laden.
   */
  procedure download_blob(
    p_blob in out nocopy blob,
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
  
  
  function clob_to_blob(
    p_clob in clob)
    return blob
  as
    l_blob blob;
    l_lang_context  integer := dbms_lob.DEFAULT_LANG_CTX;
    l_warning       integer := dbms_lob.WARN_INCONVERTIBLE_CHAR;
    l_dest_offset   integer := 1;
    l_source_offset integer := 1;
  begin
    dbms_lob.createtemporary(l_blob, true, dbms_lob.call);
      dbms_lob.converttoblob (
        dest_lob => l_blob,
        src_clob => p_clob,
        amount => dbms_lob.LOBMAXSIZE,
        dest_offset => l_dest_offset,
        src_offset => l_source_offset,
        blob_csid => dbms_lob.DEFAULT_CSID,
        lang_context => l_lang_context,
        warning => l_warning
      );

    return l_blob;
  end clob_to_blob;


  procedure download_blob(
    p_blob in out nocopy blob,
    p_file_name in varchar2)
  as
  begin
    htp.init;
    owa_util.mime_header('application/octet-stream', FALSE, 'UTF-8');
    htp.p('Content-length: ' || dbms_lob.getlength(p_blob));
    htp.p('Content-Disposition: inline; filename="' || p_file_name || '"');
    owa_util.http_header_close;
    wpg_docload.download_file(p_blob);
    apex_application.stop_apex_engine;
  exception when others then
    htp.p('error: ' || sqlerrm);
    apex_application.stop_apex_engine;
  end download_blob;


  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2)
  as
    l_blob blob;
  begin
    l_blob := clob_to_blob(p_clob);
    download_blob(l_blob, p_file_name);

  end download_clob;
end utl_apex;
/
