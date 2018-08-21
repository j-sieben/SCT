create or replace package body sct_ui_pkg
as

  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;
  c_zip_file_name constant varchar2(50 char) := 'all_rule_groups.zip';
  
  c_true constant pls_integer := 1;
  c_false constant pls_integer := 0;
  
  g_page_values utl_apex.page_value_t;
  g_group_row sct_rule_group%rowtype;
  g_rule_row sct_rule%rowtype;
  g_rule_action_row sct_rule_action%rowtype;
  
  function clean_sct_name(
    p_name in varchar2)
    return varchar2
  as
    l_name sct_rule_group.sgr_name%type;
  begin
    l_name := replace(replace(p_name, '"'), ' ', '_');
    l_name := upper(substr(l_name, 1, 50));
    return l_name;
  end clean_sct_name;
  
  
  /* Hilfsfunktion zur Uebernahme der Seitenelementwerten 
   * %usage  Wird aufgerufen, um fuer die aktuell ausgefuehrte APEX-Seite den Sessionstatus
   *         zu kopieren und in einem typsicheren Record verfuegbar zu machen
   */
  procedure copy_edit_group
  as
  begin
    g_page_values := utl_apex.get_page_values;
    g_group_row.sgr_id := to_number(utl_apex.get(g_page_values, 'SGR_ID'), 'fm9999999999990d99999999');
    g_group_row.sgr_name := utl_apex.get(g_page_values, 'SGR_NAME');
    g_group_row.sgr_description := utl_apex.get(g_page_values, 'SGR_DESCRIPTION');
    g_group_row.sgr_app_id := to_number(utl_apex.get(g_page_values, 'SGR_APP_ID'), 'fm9999999999990d99999999');
    g_group_row.sgr_page_id := to_number(utl_apex.get(g_page_values, 'SGR_PAGE_ID'), 'fm9999999999990d99999999');
    g_group_row.sgr_active := to_number(utl_apex.get(g_page_values, 'SGR_ACTIVE'), 'fm9999999999990d99999999');
    g_group_row.sgr_with_recursion := to_number(utl_apex.get(g_page_values, 'SGR_WITH_RECURSION'), 'fm9999999999990d99999999');
  end copy_edit_group;
  
  
  /* Hilfsfunktion zur Uebernahme der Seitenelementwerten 
   * %usage  Wird aufgerufen, um fuer die aktuell ausgefuehrte APEX-Seite den Sessionstatus
   *         zu kopieren und in einem typsicheren Record verfuegbar zu machen
   */
  procedure copy_edit_rule
  as
  begin
    g_page_values := utl_apex.get_page_values;
    g_rule_row.sru_id := to_number(utl_apex.get(g_page_values, 'SRU_ID'), '999990');
    g_rule_row.sru_sgr_id := to_number(utl_apex.get(g_page_values, 'SRU_SGR_ID'), '999990');
    g_rule_row.sru_sort_seq := to_number(utl_apex.get(g_page_values, 'SRU_SORT_SEQ'), 'fm9999999999990d99999999');
    g_rule_row.sru_name := utl_apex.get(g_page_values, 'SRU_NAME');
    g_rule_row.sru_condition := utl_apex.get(g_page_values, 'SRU_CONDITION');
    g_rule_row.sru_active := to_number(utl_apex.get(g_page_values, 'SRU_ACTIVE'), 'fm9999999999990d99999999');
  end copy_edit_rule;
  

  /* Hilfsfunktion zur Uebernahme der Seitenelementwerte eines interaktiven Grids 
   * %usage  Wird aufgerufen, um fuer die aktuell ausgefuehrte APEX-Seite den Sessionstatus
   *         zu kopieren und in einem typsicheren Record verfuegbar zu machen
   */
  procedure copy_edit_rule_action
  as
  begin
    g_rule_action_row.sra_sgr_id := to_number(v('SRA_SGR_ID'));
    g_rule_action_row.sra_sru_id := to_number(v('SRA_SRU_ID'));
    g_rule_action_row.sra_spi_id := v('SRA_SPI_ID');
    g_rule_action_row.sra_sat_id := v('SRA_SAT_ID');
    g_rule_action_row.sra_attribute := v('SRA_ATTRIBUTE');
    g_rule_action_row.sra_attribute_2 := v('SRA_ATTRIBUTE_2');
    g_rule_action_row.sra_sort_seq := to_number(v('SRA_SORT_SEQ'));
    g_rule_action_row.sra_active := coalesce(to_number(v('SRA_ACTIVE')), c_true);
    g_rule_action_row.sra_comment := v('SRA_COMMENT');
    g_rule_action_row.sra_on_error := coalesce(to_number(v('SRA_ON_ERROR')), c_false);
  end;
  

  /* INTERFACE */
  procedure delete_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory('delete_rule_group', c_pkg);
    sct_admin.delete_rule_group(p_sgr_id);
    pit.leave_mandatory;
  end delete_rule_group;


  procedure copy_rule_group
  as
  begin
    pit.enter_mandatory('validate_rule_group', c_pkg);
    g_page_values := utl_apex.get_page_values;
    sct_admin.copy_rule_group(
      p_sgr_app_id => to_number(utl_apex.get(g_page_values, 'SGR_APP_ID')),
      p_sgr_page_id => to_number(utl_apex.get(g_page_values, 'SGR_PAGE_ID')),
      p_sgr_id => to_number(utl_apex.get(g_page_values, 'SGR_ID')),
      p_sgr_app_to => to_number(utl_apex.get(g_page_values, 'SGR_APP_TO')),
      p_sgr_page_to => to_number(utl_apex.get(g_page_values, 'SGR_PAGE_TO')));
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
    l_sgr_app_id pls_integer;
    l_sgr_id pls_integer;
  begin
    pit.enter_mandatory('validate_rule_group', c_pkg);
    
    g_page_values := utl_apex.get_page_values;
    l_sgr_app_id := to_number(utl_apex.get(g_page_values, 'SGR_APP_ID'));
    l_sgr_id := to_number(utl_apex.get(g_page_values, 'SGR_ID'));
    
    for sgr in rule_group_cur(l_sgr_app_id, l_sgr_id) loop
      l_error_list := l_error_list || sct_admin.validate_rule_group(sgr.sgr_id);
    end loop;
    if l_error_list is not null then
      plugin_sct.register_error('B8_EXPORT', l_error_list);
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


  procedure export_all_rule_groups
  as
    cursor sgr_cur is
      select sgr_id, lower(sgr_name) sgr_name
        from sct_rule_group;
    l_blob blob;
    l_zip_file blob;
  begin
    pit.enter_mandatory('export_all_rule_groups', c_pkg);

    l_blob := utl_apex.clob_to_blob(sct_admin.export_action_types(true));
    apex_zip.add_file(
      p_zipped_blob => l_zip_file,
      p_file_name => 'merge_base_action_types.sql',
      p_content => l_blob);

    l_blob := utl_apex.clob_to_blob(sct_admin.export_action_types);
    apex_zip.add_file(
      p_zipped_blob => l_zip_file,
      p_file_name => 'merge_action_types.sql',
      p_content => l_blob);

    for sgr in sgr_cur loop
      l_blob := utl_apex.clob_to_blob(sct_admin.export_rule_group(sgr.sgr_id));
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => 'merge_rule_' || sgr.sgr_name || '.sql',
        p_content => l_blob);
    end loop;

    apex_zip.finish(l_zip_file);

    utl_apex.download_blob(l_zip_file, c_zip_file_name);

    pit.leave_mandatory;
  end export_all_rule_groups;


  procedure export_rule_group
  as
    cursor sgr_cur(p_sgr_app_id in sct_rule_group.sgr_app_id%type) is
      select sgr_id, lower(sgr_name) sgr_name
        from sct_rule_group
       where sgr_app_id = p_sgr_app_id;

    l_sgr_app_id sct_rule_group.sgr_app_id%type;
    l_sgr_id sct_rule_group.sgr_id%type;
    l_sgr_name sct_rule_group.sgr_name%type;
    l_clob clob;
    l_blob blob;
    l_zip_file blob;
  begin
    pit.enter_mandatory('export_rule_group', c_pkg);
    
    g_page_values := utl_apex.get_page_values;
    l_sgr_app_id := to_number(utl_apex.get(g_page_values, 'SGR_APP_ID'));
    l_sgr_id := to_number(utl_apex.get(g_page_values, 'SGR_ID'));

    if l_sgr_id is not null then
      select lower(sgr_name) sgr_name
        into l_sgr_name
        from sct_rule_group
       where sgr_id = l_sgr_id;
      l_clob := sct_admin.export_rule_group(l_sgr_id);
      utl_apex.download_clob(l_clob, 'merge_rule_group_' || l_sgr_name || '.sql');
    else
      if l_sgr_app_id > 0 then
        for sgr in sgr_cur(l_sgr_app_id) loop
          l_blob := utl_apex.clob_to_blob(sct_admin.export_rule_group(sgr.sgr_id));
          apex_zip.add_file(
            p_zipped_blob => l_zip_file,
            p_file_name => 'merge_rule_' || sgr.sgr_name || '.sql',
            p_content => l_blob);
        end loop;

        -- Bei Export aller Regelgruppen einer Anwendung Aktionstypen integrieren
        l_blob := utl_apex.clob_to_blob(sct_admin.export_action_types);
        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => 'merge_action_types.sql',
          p_content => l_blob);

        apex_zip.finish(l_zip_file);

        utl_apex.download_blob(l_zip_file, c_zip_file_name);
      else
        export_all_rule_groups;
      end if;
    end if;

    pit.leave_mandatory;
  end export_rule_group;
  
  
  function validate_edit_group
    return boolean
  as
    l_sgr_exists_stmt varchar2(1000) := 
      q'^select sgr_name
           from sct_rule_group
          where sgr_app_id = #SGR_APP_ID#
            and sgr_name = '#SGR_NAME#'^';
  begin
    copy_edit_group;
    
    -- Validierungen
    if utl_apex.inserting then
      utl_text.bulk_replace(l_sgr_exists_stmt, char_table(
        '#SGR_APP_ID#', g_group_row.sgr_app_id,
        '#SGR_NAME#', g_group_row.sgr_name));
      utl_apex.assert_not_exists(
        p_stmt => l_sgr_exists_stmt,
        p_message_name => msg.SCT_SGR_MUS_BE_UNIQUE,
        p_arg_list => null,
        p_affected_id => utl_apex.get_page || 'SGR_NAME');
    end if;
    
    return true;
  end validate_edit_group;
  
  
  procedure process_edit_group
  as
  begin
    copy_edit_group;
    
    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_rule_group(
        p_sgr_app_id => g_group_row.sgr_app_id,
        p_sgr_page_id => g_group_row.sgr_page_id,
        p_sgr_id => g_group_row.sgr_id,
        p_sgr_name => g_group_row.sgr_name,
        p_sgr_description => g_group_row.sgr_description,
        p_sgr_with_recursion => g_group_row.sgr_with_recursion,
        p_sgr_active => g_group_row.sgr_active);
      sct_admin.propagate_rule_change(g_group_row.sgr_id);
    when utl_apex.deleting then
      sct_admin.delete_rule_group(g_group_row.sgr_id);
      sct_admin.propagate_rule_change(g_group_row.sgr_id);
    else
      pit.error(msg.APEX_UNHANDLED_REQUEST, msg_args(v('REQUEST')));
    end case;
    
  end process_edit_group;
  
  
  function validate_edit_rule
    return boolean
  as
    l_error varchar2(4000);
  begin
    copy_edit_rule;
    
    sct_admin.validate_rule(
      p_sgr_id => g_rule_row.sru_sgr_id,
      p_sru_condition => g_rule_row.sru_condition,
      p_error => l_error);
    pit.assert_is_null(
      p_condition => l_error,
      p_message_name => msg.APEX_LOG_MESSAGE,
      p_arg_list => msg_args(l_error));
      
    return true;
  end validate_edit_rule;
  
  
  procedure process_edit_rule
  as
  begin
    copy_edit_rule;
    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_rule(
        p_sru_id => g_rule_row.sru_id,
        p_sru_sgr_id => g_rule_row.sru_sgr_id,
        p_sru_name => g_rule_row.sru_name,
        p_sru_condition => g_rule_row.sru_condition,
        p_sru_fire_on_page_load => g_rule_row.sru_fire_on_page_load,
        p_sru_sort_seq => g_rule_row.sru_sort_seq,
        p_sru_active => g_rule_row.sru_active);
    else
      sct_admin.delete_rule(g_rule_row.sru_id);
    end case;
  end process_edit_rule;
  
  
  function validate_edit_rule_action
    return boolean
  as
    l_error varchar2(4000);
  begin
    copy_edit_rule_action;
    
    utl_apex.assert_not_null(g_rule_action_row.sra_sru_id, msg.APEX_REQUIRED_VAL_MISSING, utl_apex.get_page|| 'SRA_SRU_ID');
    utl_apex.assert_not_null(g_rule_action_row.sra_sgr_id, msg.APEX_REQUIRED_VAL_MISSING, utl_apex.get_page|| 'SRA_SGR_ID');
    utl_apex.assert_not_null(g_rule_action_row.sra_spi_id, msg.APEX_REQUIRED_VAL_MISSING, utl_apex.get_page|| 'SRA_SPI_ID');
    utl_apex.assert_not_null(g_rule_action_row.sra_sat_id, msg.APEX_REQUIRED_VAL_MISSING, utl_apex.get_page|| 'SRA_SAT_ID');
    return true;
  end validate_edit_rule_action;
  
  
  procedure process_edit_rule_action
  as
  begin
    copy_edit_rule_action;
    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_rule_action(
        p_sra_sru_id => g_rule_action_row.sra_sru_id,
        p_sra_sgr_id => g_rule_action_row.sra_sgr_id,
        p_sra_spi_id => g_rule_action_row.sra_spi_id,
        p_sra_sat_id => g_rule_action_row.sra_sat_id,
        p_sra_attribute => g_rule_action_row.sra_attribute,
        p_sra_attribute_2 => g_rule_action_row.sra_attribute_2,
        p_sra_sort_seq => g_rule_action_row.sra_sort_seq,
        p_sra_on_error => g_rule_action_row.sra_on_error,
        p_sra_raise_recursive => g_rule_action_row.sra_raise_recursive,
        p_sra_active => g_rule_action_row.sra_active,
        p_sra_comment => g_rule_action_row.sra_comment);
    else
      sct_admin.delete_rule_action(
        p_sra_sru_id => g_rule_action_row.sra_sru_id,
        p_sra_sgr_id => g_rule_action_row.sra_sgr_id,
        p_sra_spi_id => g_rule_action_row.sra_spi_id,
        p_sra_sat_id => g_rule_action_row.sra_sat_id,
        p_sra_on_error => g_rule_action_row.sra_on_error);
    end case;
  end process_edit_rule_action;


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

end sct_ui_pkg;
/