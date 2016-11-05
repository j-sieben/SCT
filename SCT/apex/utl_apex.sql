create or replace package utl_apex
as
  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2);
end utl_apex;
/

create or replace package body utl_apex
as
  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;
  
  /* Hilfmethode zum Speichern eines CLOB auf dem Client-rechner 
   * %param p_clob CLOB-Instanz, die heruntergeladen werden soll
   * %param p_file_name Dateiname der geladenen Instanz
   * %usage Wird verwendet, um CLOB-Instanzen ueber einen Speichern-Dialog auf 
   *        den Clientrechner zu laden
   */
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
