create or replace package body sct_ui_pkg
as

  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;
  c_zip_file_name constant varchar2(50 char) := 'all_rule_groups.zip';

  c_true constant pls_integer := 1;
  c_false constant pls_integer := 0;

  g_page_values utl_apex.page_value_t;
  g_edit_sgr_row sct_rule_group%rowtype;
  g_edit_sru_row sct_rule%rowtype;
  g_edit_sra_row sct_rule_action%rowtype;
  g_edit_saa_row sct_apex_action%rowtype;


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
  procedure copy_edit_sgr
  as
  begin
    g_page_values := utl_apex.get_page_values;
    g_edit_sgr_row.sgr_id := to_number(utl_apex.get(g_page_values, 'SGR_ID'), 'fm9999999999990d99999999');
    g_edit_sgr_row.sgr_name := clean_sct_name(utl_apex.get(g_page_values, 'SGR_NAME'));
    g_edit_sgr_row.sgr_description := utl_apex.get(g_page_values, 'SGR_DESCRIPTION');
    g_edit_sgr_row.sgr_app_id := to_number(utl_apex.get(g_page_values, 'SGR_APP_ID'), 'fm9999999999990d99999999');
    g_edit_sgr_row.sgr_page_id := to_number(utl_apex.get(g_page_values, 'SGR_PAGE_ID'), 'fm9999999999990d99999999');
    g_edit_sgr_row.sgr_active := to_number(utl_apex.get(g_page_values, 'SGR_ACTIVE'), 'fm9999999999990d99999999');
    g_edit_sgr_row.sgr_with_recursion := to_number(utl_apex.get(g_page_values, 'SGR_WITH_RECURSION'), 'fm9999999999990d99999999');
  end copy_edit_sgr;


  /* Hilfsfunktion zur Uebernahme der Seitenelementwerten
   * %usage  Wird aufgerufen, um fuer die aktuell ausgefuehrte APEX-Seite den Sessionstatus
   *         zu kopieren und in einem typsicheren Record verfuegbar zu machen
   */
  procedure copy_edit_sru
  as
  begin
    g_page_values := utl_apex.get_page_values;
    g_edit_sru_row.sru_id := to_number(utl_apex.get(g_page_values, 'SRU_ID'), '999990');
    g_edit_sru_row.sru_sgr_id := to_number(utl_apex.get(g_page_values, 'SRU_SGR_ID'), '999990');
    g_edit_sru_row.sru_sort_seq := to_number(utl_apex.get(g_page_values, 'SRU_SORT_SEQ'), 'fm9999999999990d99999999');
    g_edit_sru_row.sru_name := utl_apex.get(g_page_values, 'SRU_NAME');
    g_edit_sru_row.sru_condition := utl_apex.get(g_page_values, 'SRU_CONDITION');
    g_edit_sru_row.sru_active := to_number(utl_apex.get(g_page_values, 'SRU_ACTIVE'), 'fm9999999999990d99999999');
  end copy_edit_sru;


  /* Hilfsfunktion zur Uebernahme der Seitenelementwerte eines interaktiven Grids
   * %usage  Wird aufgerufen, um fuer die aktuell ausgefuehrte APEX-Seite den Sessionstatus
   *         zu kopieren und in einem typsicheren Record verfuegbar zu machen
   */
  procedure copy_edit_sra
  as
  begin
    g_edit_sra_row.sra_sgr_id := to_number(coalesce(v('SRA_SGR_ID'), v('P5_SRU_SGR_ID_BAC')));
    g_edit_sra_row.sra_sru_id := to_number(coalesce(v('SRA_SRU_ID'), v('P5_SRU_ID_BAC')));
    g_edit_sra_row.sra_spi_id := v('SRA_SPI_ID');
    g_edit_sra_row.sra_sat_id := v('SRA_SAT_ID');
    g_edit_sra_row.sra_attribute := v('SRA_ATTRIBUTE');
    g_edit_sra_row.sra_attribute_2 := v('SRA_ATTRIBUTE_2');
    g_edit_sra_row.sra_sort_seq := to_number(v('SRA_SORT_SEQ'));
    g_edit_sra_row.sra_active := coalesce(to_number(v('SRA_ACTIVE')), c_true);
    g_edit_sra_row.sra_raise_recursive := coalesce(to_number(v('SRA_RAISE_RECURSIVE')), c_true);
    g_edit_sra_row.sra_comment := v('SRA_COMMENT');
    g_edit_sra_row.sra_on_error := coalesce(to_number(v('SRA_ON_ERROR')), c_false);
  end copy_edit_sra;


  procedure copy_edit_saa
  as
  begin
    g_page_values := utl_apex.get_page_values;
    g_edit_saa_row.saa_sgr_id := to_number(utl_apex.get(g_page_values, 'SAA_SGR_ID'), 'fm9999999999990d99999999');
    g_edit_saa_row.saa_sty_id := utl_apex.get(g_page_values, 'SAA_STY_ID');
    g_edit_saa_row.saa_name := utl_apex.get(g_page_values, 'SAA_NAME');
    g_edit_saa_row.saa_label := utl_apex.get(g_page_values, 'SAA_LABEL');
    g_edit_saa_row.saa_context_label := utl_apex.get(g_page_values, 'SAA_CONTEXT_LABEL');
    g_edit_saa_row.saa_icon := utl_apex.get(g_page_values, 'SAA_ICON');
    g_edit_saa_row.saa_icon_type := utl_apex.get(g_page_values, 'SAA_ICON_TYPE');
    g_edit_saa_row.saa_title := utl_apex.get(g_page_values, 'SAA_TITLE');
    g_edit_saa_row.saa_shortcut := utl_apex.get(g_page_values, 'SAA_SHORTCUT');
    g_edit_saa_row.saa_initially_disabled := to_number(utl_apex.get(g_page_values, 'SAA_INITIALLY_DISABLED'), 'fm9999999999990d99999999');
    g_edit_saa_row.saa_initially_hidden := to_number(utl_apex.get(g_page_values, 'SAA_INITIALLY_HIDDEN'), 'fm9999999999990d99999999');
    g_edit_saa_row.saa_href := utl_apex.get(g_page_values, 'SAA_HREF');
    g_edit_saa_row.saa_href_noop := utl_apex.get(g_page_values, 'SAA_HREF_NOOP');
    g_edit_saa_row.saa_action := utl_apex.get(g_page_values, 'SAA_ACTION');
    g_edit_saa_row.saa_action_noop := utl_apex.get(g_page_values, 'SAA_ACTION_NOOP');
    g_edit_saa_row.saa_on_label := utl_apex.get(g_page_values, 'SAA_ON_LABEL');
    g_edit_saa_row.saa_off_label := utl_apex.get(g_page_values, 'SAA_OFF_LABEL');
    g_edit_saa_row.saa_get := utl_apex.get(g_page_values, 'SAA_GET');
    g_edit_saa_row.saa_set := utl_apex.get(g_page_values, 'SAA_SET');
    g_edit_saa_row.saa_choices := utl_apex.get(g_page_values, 'SAA_CHOICES');
    g_edit_saa_row.saa_label_classes := utl_apex.get(g_page_values, 'SAA_LABEL_CLASSES');
    g_edit_saa_row.saa_label_start_classes := utl_apex.get(g_page_values, 'SAA_LABEL_START_CLASSES');
    g_edit_saa_row.saa_label_end_classes := utl_apex.get(g_page_values, 'SAA_LABEL_END_CLASSES');
    g_edit_saa_row.saa_item_wrap_class := utl_apex.get(g_page_values, 'SAA_ITEM_WRAP_CLASS');
  end copy_edit_saa;


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


  procedure export_all_rule_groups
  as
    cursor sgr_cur is
      select sgr_id, lower(sgr_name) sgr_name
        from sct_rule_group;
    l_blob blob;
    l_zip_file blob;
  begin
    pit.enter_mandatory('export_all_rule_groups', c_pkg);

    --l_blob := utl_text.clob_to_blob(sct_admin.export_action_types(true));
    apex_zip.add_file(
      p_zipped_blob => l_zip_file,
      p_file_name => 'merge_base_action_types.sql',
      p_content => l_blob);

    l_blob := utl_text.clob_to_blob(sct_admin.export_action_types);
    apex_zip.add_file(
      p_zipped_blob => l_zip_file,
      p_file_name => 'merge_action_types.sql',
      p_content => l_blob);

    for sgr in sgr_cur loop
      l_blob := utl_text.clob_to_blob(sct_admin.export_rule_group(sgr.sgr_id));
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
          l_blob := utl_text.clob_to_blob(sct_admin.export_rule_group(sgr.sgr_id));
          apex_zip.add_file(
            p_zipped_blob => l_zip_file,
            p_file_name => 'merge_rule_' || sgr.sgr_name || '.sql',
            p_content => l_blob);
        end loop;

        -- Bei Export aller Regelgruppen einer Anwendung Aktionstypen integrieren
        l_blob := utl_text.clob_to_blob(sct_admin.export_action_types);
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


  /* Methods to maintain user entries on APEX pages */
  function validate_edit_sgr
    return boolean
  as
    l_exists binary_integer;
  begin
    copy_edit_sgr;

    -- Validierungen
    utl_apex.assert_not_null(g_edit_sgr_row.sgr_app_id, msg.APEX_REQUIRED_VAL_MISSING, utl_apex.get_page|| 'SGR_APP_ID');
    utl_apex.assert_not_null(g_edit_sgr_row.sgr_page_id, msg.APEX_REQUIRED_VAL_MISSING, utl_apex.get_page|| 'SGR_PAGE_ID');
    utl_apex.assert_not_null(g_edit_sgr_row.sgr_name, msg.APEX_REQUIRED_VAL_MISSING, utl_apex.get_page|| 'SGR_NAME');

    if utl_apex.inserting then
      select count(*)
        into l_exists
        from dual
       where exists(
             select null
               from sct_rule_group
              where sgr_app_id = g_edit_sgr_row.sgr_app_id
                and sgr_name = g_edit_sgr_row.sgr_name);
      utl_apex.assert(
        p_condition => l_exists = 0,
        p_message_name => msg.SCT_SGR_MUS_BE_UNIQUE,
        p_arg_list => null,
        p_affected_id => utl_apex.get_page || 'SGR_NAME');
    end if;

    return true;
  end validate_edit_sgr;


  procedure process_edit_sgr
  as
  begin
    copy_edit_sgr;

    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_rule_group(
        p_sgr_app_id => g_edit_sgr_row.sgr_app_id,
        p_sgr_page_id => g_edit_sgr_row.sgr_page_id,
        p_sgr_id => g_edit_sgr_row.sgr_id,
        p_sgr_name => g_edit_sgr_row.sgr_name,
        p_sgr_description => g_edit_sgr_row.sgr_description,
        p_sgr_with_recursion => g_edit_sgr_row.sgr_with_recursion,
        p_sgr_active => g_edit_sgr_row.sgr_active);
      sct_admin.propagate_rule_change(g_edit_sgr_row.sgr_id);
    when utl_apex.deleting then
      sct_admin.delete_rule_group(g_edit_sgr_row.sgr_id);
      sct_admin.propagate_rule_change(g_edit_sgr_row.sgr_id);
    else
      pit.error(msg.APEX_UNHANDLED_REQUEST, msg_args(v('REQUEST')));
    end case;

  end process_edit_sgr;


  function validate_edit_sru
    return boolean
  as
    l_error varchar2(4000);
  begin
    copy_edit_sru;

    /*sct_admin.validate_rule(
      p_sgr_id => g_edit_sru_row.sru_sgr_id,
      p_sru_condition => g_edit_sru_row.sru_condition,
      p_error => l_error);*/
    utl_apex.assert_is_null(
      p_condition => l_error,
      p_message_name => msg.APEX_LOG_MESSAGE,
      p_arg_list => msg_args(l_error));

    return true;
  end validate_edit_sru;


  procedure process_edit_sru
  as
  begin
    copy_edit_sru;
    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_rule(
        p_sru_id => g_edit_sru_row.sru_id,
        p_sru_sgr_id => g_edit_sru_row.sru_sgr_id,
        p_sru_name => g_edit_sru_row.sru_name,
        p_sru_condition => g_edit_sru_row.sru_condition,
        p_sru_fire_on_page_load => g_edit_sru_row.sru_fire_on_page_load,
        p_sru_sort_seq => g_edit_sru_row.sru_sort_seq,
        p_sru_active => g_edit_sru_row.sru_active);
    when utl_apex.deleting then
      sct_admin.delete_rule(g_edit_sru_row.sru_id);
    else
      pit.error(msg.UTL_INVALID_REQUEST, msg_args(v('REQUEST')));
    end case;
  end process_edit_sru;


  function validate_edit_sra
    return boolean
  as
    l_error varchar2(4000);
  begin
    pit.set_context('DEBUG');
    pit.enter('validate_edit_sra', C_PKG);
    copy_edit_sra;

    utl_apex.assert_not_null(g_edit_sra_row.sra_sru_id, msg.APEX_REQUIRED_VAL_MISSING, 'SRA_SRU_ID');
    utl_apex.assert_not_null(g_edit_sra_row.sra_sgr_id, msg.APEX_REQUIRED_VAL_MISSING, 'SRA_SGR_ID');
    utl_apex.assert_not_null(g_edit_sra_row.sra_spi_id, msg.APEX_REQUIRED_VAL_MISSING, 'SRA_SPI_ID');
    utl_apex.assert_not_null(g_edit_sra_row.sra_sat_id, msg.APEX_REQUIRED_VAL_MISSING, 'SRA_SAT_ID');
    
    pit.leave;
    return true;
  end validate_edit_sra;


  procedure process_edit_sra
  as
  begin
    copy_edit_sra;
    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_rule_action(
        p_sra_sru_id => g_edit_sra_row.sra_sru_id,
        p_sra_sgr_id => g_edit_sra_row.sra_sgr_id,
        p_sra_spi_id => g_edit_sra_row.sra_spi_id,
        p_sra_sat_id => g_edit_sra_row.sra_sat_id,
        p_sra_attribute => g_edit_sra_row.sra_attribute,
        p_sra_attribute_2 => g_edit_sra_row.sra_attribute_2,
        p_sra_sort_seq => g_edit_sra_row.sra_sort_seq,
        p_sra_on_error => g_edit_sra_row.sra_on_error,
        p_sra_raise_recursive => g_edit_sra_row.sra_raise_recursive,
        p_sra_active => g_edit_sra_row.sra_active,
        p_sra_comment => g_edit_sra_row.sra_comment);
    when utl_apex.deleting then
      pit.verbose(msg.SCT_GENERIC_ERROR, msg_args('Deleting row'));
      sct_admin.delete_rule_action(
        p_sra_sru_id => g_edit_sra_row.sra_sru_id,
        p_sra_sgr_id => g_edit_sra_row.sra_sgr_id,
        p_sra_spi_id => g_edit_sra_row.sra_spi_id,
        p_sra_sat_id => g_edit_sra_row.sra_sat_id,
        p_sra_on_error => g_edit_sra_row.sra_on_error);
    else
      pit.error(msg.UTL_INVALID_REQUEST, msg_args(v('APEX$ROW_STATUS')));
    end case;
    pit.reset_context;
  end process_edit_sra;


  function validate_edit_saa
    return boolean
  as
  begin
    -- copy_edit_saa;
    -- Validierungen. Falls keine Validierung, copy-Methode auskommentiert lassen
    return true;
  end validate_edit_saa;


  procedure process_edit_saa
  as
  begin
    copy_edit_saa;
    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_apex_action(g_edit_saa_row);
    else
      sct_admin.delete_apex_action(g_edit_saa_row);
    end case;
  end process_edit_saa;


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
    l_help_text varchar2(32767);
  begin
    pit.enter_mandatory('get_action_type_help', c_pkg);

      with params as(
           select uttm_text template, uttm_mode
             from utl_text_templates
            where uttm_type = 'SCT'
              and uttm_name = 'ACTION_TYPE_HELP')
    select utl_text.generate_text(cursor(
             select template,
                    utl_text.generate_text(cursor(
                      select p.template,
                             sat_name, sat_description,
                             case sat_is_editable when sct_admin.c_false then '(nicht editierbar)' end sat_is_editable
                         from sct_action_type
                        cross join params p
                        where uttm_mode = 'HELP'
                        order by sat_name), sct_admin.c_cr) help_list
               from dual)
           )
      into l_help_text
      from params
     where uttm_mode = 'FRAME';
    htp.p(l_help_text);

    pit.leave_mandatory;
  end get_action_type_help;

end sct_ui_pkg;
/
