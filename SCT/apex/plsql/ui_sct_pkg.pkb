create or replace package body ui_sct_pkg
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


  /* INTERFACE */
  procedure delete_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('delete_rule_group', c_pkg);
    sct_admin.delete_rule_group(p_sgr_id);
    pit.leave_mandatory;
  end delete_rule_group;


  procedure resequence_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('resequence_rule_group', c_pkg);
    sct_admin.resequence_rule_group(p_sgr_id);
    pit.leave_mandatory;
  end resequence_rule_group;


  procedure copy_rule_group
  as
  begin
    pit.enter_mandatory('validate_rule_group', c_pkg);
    sct_admin.copy_rule_group(
      p_sgr_app_id => v('P4_SGR_APP_ID'),
      p_sgr_page_id => v('P4_SGR_PAGE_ID'),
      p_sgr_id => v('P4_SGR_ID'),
      p_sgr_app_to => v('P4_SGR_APP_TO'),
      p_sgr_page_to => v('P4_SGR_PAGE_TO'));
    pit.leave_mandatory;
  end copy_rule_group;
  
  
  procedure validate_rule_group
  as
    cursor rule_group_cur(
      p_sgr_app_id in sct_rule_group.sgr_app_id%type,
      p_sgr_id in sct_rule_group.sgr_id%type) is
      select sgr_id
        from sct_rule_group
       where sgr_app_id = p_sgr_app_id
         and (sgr_id = p_sgr_id or p_sgr_id is null);
    l_error_list varchar2(32767);
  begin
    pit.enter_mandatory('validate_rule_group', c_pkg);
    
    for sgr in rule_group_cur(v('P8_SGR_APP_ID'), v('P8_SGR_ID')) loop
      l_error_list := l_error_list || sct_admin.validate_rule_group(sgr.sgr_id);
    end loop;
    if l_error_list is not null then
      plugin_sct.register_error('B8_EXPORT', l_error_list, '');
    end if;
    
    pit.leave_mandatory;
  end validate_rule_group;
  
  
  procedure validate_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
    l_result varchar2(4000);
  begin
    pit.enter_mandatory('validate_rule_group', c_pkg);
    l_result := sct_admin.validate_rule_group(p_sgr_id);
    pit.leave_mandatory;
  end;


  procedure export_rule_group
  as
    l_sgr_app_id sct_rule_group.sgr_app_id%type;
    l_sgr_id sct_rule_group.sgr_id%type;
    l_export_file clob;
  begin
    pit.enter_mandatory('export_rule_group', c_pkg);
    
    l_sgr_app_id := to_number(v('P8_SGR_APP_ID'));
    l_sgr_id := to_number(v('P8_SGR_ID'));
    
    if l_sgr_id is not null then
      l_export_file := sct_admin.export_rule_group(l_sgr_id);
      download_clob(l_export_file, 'SCT_RULE_GROUP_' || l_sgr_id || '.sql');
    else
      l_export_file := sct_admin.export_rule_groups(l_sgr_app_id);
      download_clob(l_export_file, 'SCT_APP_' || l_sgr_app_id || '.sql');
    end if;
    
    pit.leave_mandatory;
  end export_rule_group;
  
  
  procedure process_rule_change(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('process_rule_change', c_pkg);
    sct_admin.propagate_rule_change(p_sgr_id);
    pit.leave_mandatory;
  end process_rule_change;


  function validate_rule_is_valid(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type)
    return varchar2
  as
    l_error varchar2(4000);
  begin
    pit.enter_mandatory('validate_rule_is_valid', c_pkg);
    sct_admin.validate_rule(
      p_sgr_id => p_sgr_id,
      p_sru_condition => p_sru_condition,
      p_error => l_error);
    
    pit.leave_mandatory;
    return l_error;
  end validate_rule_is_valid;


  function get_sru_sort_seq(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return number
  as
    l_sru_sort_seq sct_rule.sru_sort_seq%type;
  begin
    pit.enter_mandatory('get_sru_sort_seq', c_pkg);
    select max(trunc(sru_sort_seq, -1)) + 10
      into l_sru_sort_seq
      from sct_rule
     where sru_sgr_id = p_sgr_id;
    
    pit.leave_mandatory;
    return coalesce(l_sru_sort_seq, 10);
  end get_sru_sort_seq;
  
  
  function get_sra_sort_seq(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_id in sct_rule.sru_id%type)
    return number
  as
    l_sra_sort_seq sct_rule_action.sra_sort_seq%type;
  begin
    pit.enter_mandatory('get_sra_sort_seq', c_pkg);
    
    select max(trunc(sra_sort_seq, -1)) + 10
      into l_sra_sort_seq
      from sct_rule_action
     where sra_sgr_id = p_sgr_id
       and sra_sru_id = p_sru_id;
    
    pit.leave_mandatory;
    return coalesce(l_sra_sort_seq, 10);
  end get_sra_sort_seq;
  
  
  procedure get_action_type_help
  as
    cursor action_type_help_cur is
      select sat_name, sat_description,
             case sat_is_editable
               when sct_const.c_false then '(nicht editierbar)'
             end sat_is_editable
        from sct_action_type
       order by sat_name;
    l_help_text varchar2(32767);
  begin
    pit.enter_mandatory('get_action_type_help', c_pkg);
    
    for ath in action_type_help_cur loop
      utl_text.append(
        l_help_text, 
        utl_text.bulk_replace(sct_const.c_action_type_help_entry, char_table(
          '#SAT_NAME#', ath.sat_name,
          '#SAT_IS_EDITABLE#', ath.sat_is_editable,
          '#SAT_DESCRIPTION#', coalesce(ath.sat_description, '- keine Hilfe vorhanden') )));
    end loop;
    l_help_text := replace(sct_const.c_action_type_help_template, '#HELP_LIST#', l_help_text);
    htp.p(l_help_text);
    
    pit.leave_mandatory;
  end get_action_type_help;

end ui_sct_pkg;
/