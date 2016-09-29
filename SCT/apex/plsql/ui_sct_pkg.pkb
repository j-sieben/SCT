create or replace package body ui_sct_pkg
as

  /* Hilfmethode zum Speichern eines CLOB auf dem Client-rechner */
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
  exception when others then
    htp.p('error: ' || sqlerrm);
    apex_application.stop_apex_engine;
  end download_clob;
  

  procedure merge_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_sgr_description in sct_rule_group.sgr_description%type,
    p_sgr_active in sct_rule_group.sgr_active%type default sct_const.c_true)
  as
  begin
    sct_admin.merge_rule_group(
      p_sgr_app_id => p_sgr_app_id,
      p_sgr_page_id => p_sgr_page_id,
      p_sgr_id => p_sgr_id,
      p_sgr_name => p_sgr_name,
      p_sgr_description => p_sgr_description);
  end merge_rule_group;


  procedure delete_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    sct_admin.delete_rule_group(p_sgr_id);
  end delete_rule_group;


  procedure resequence_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    sct_admin.resequence_rule_group(p_sgr_id);
  end resequence_rule_group;


  procedure copy_rule_group
  as
  begin
    sct_admin.copy_rule_group(
      p_sgr_app_id => v('P4_SGR_APP_ID'),
      p_sgr_page_id => v('P4_SGR_PAGE_ID'),
      p_sgr_id => v('P4_SGR_ID'),
      p_sgr_app_to => v('P4_SGR_APP_TO'),
      p_sgr_page_to => v('P4_SGR_PAGE_TO'));
  end copy_rule_group;


  procedure export_rule_group
  as
    l_sgr_app_id sct_rule_group.sgr_app_id%type;
    l_sgr_id sct_rule_group.sgr_id%type;
    l_file_name varchar2(200);
    l_export_file clob;
  begin
    l_sgr_app_id := to_number(v('P8_SGR_APP_ID'));
    l_sgr_id := to_number(v('P8_SGR_ID'));
    if l_sgr_id is not null then
      l_export_file := sct_admin.export_rule_group(l_sgr_id);
      download_clob(l_export_file, 'SCT_RULE_GROUP_' || l_sgr_id || '.sql');
    else
      l_export_file := sct_admin.export_rule_groups(l_sgr_app_id);
      download_clob(l_export_file, 'SCT_APP_' || l_sgr_app_id || '.sql');
    end if;
  end export_rule_group;
  
  
  procedure process_rule_change(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    sct_admin.propagate_rule_change(p_sgr_id);
  end process_rule_change;


  function validate_rule_is_valid(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type)
    return varchar2
  as
    l_error varchar2(4000);
  begin
    sct_admin.validate_rule(
      p_sgr_id => p_sgr_id,
      p_sru_condition => p_sru_condition,
      p_error => l_error);
    return l_error;
  end validate_rule_is_valid;


  function get_sru_sort_seq(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return number
  as
    l_sru_sort_seq sct_rule.sru_sort_seq%type;
  begin
    select max(trunc(sru_sort_seq, -1)) + 10
      into l_sru_sort_seq
      from sct_rule
     where sru_sgr_id = p_sgr_id;
    return coalesce(l_sru_sort_seq, 10);
  end get_sru_sort_seq;
  
  
  function get_sra_sort_seq(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_id in sct_rule.sru_id%type)
    return number
  as
    l_sra_sort_seq sct_rule_action.sra_sort_seq%type;
  begin
    select max(trunc(sra_sort_seq, -1)) + 10
      into l_sra_sort_seq
      from sct_rule_action
     where sra_sgr_id = p_sgr_id
       and sra_sru_id = p_sru_id;
    return coalesce(l_sra_sort_seq, 10);
  end get_sra_sort_seq;

end ui_sct_pkg;
/