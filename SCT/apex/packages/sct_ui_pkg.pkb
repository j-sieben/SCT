create or replace package body sct_ui_pkg
as

  C_SRA_COLLECTION constant sct_util.ora_name_type := 'SCT_UI_EDIT_SRA';
  C_SAA_COLLECTION constant sct_util.ora_name_type := 'SCT_UI_EDIT_SAA';

  g_page_values utl_apex.page_value_t;
  g_edit_sgr_row sct_rule_group%rowtype;
  g_edit_sru_row sct_rule%rowtype;
  g_edit_sra_row sct_ui_edit_sra%rowtype;
  g_edit_saa_row sct_ui_edit_saa%rowtype;
  g_edit_sat_row sct_ui_edit_sat%rowtype;


  /** Helper to sanitize any SCT name to comply with internal naming rules
   * @param  p_name  Name to sanitize
   * @return Name that adheres to the following naming conventions:
   *         - no quotes
   *         - no blanks (replaced by underscores)
   *         - all uppercase
   *         - legnth limit 50
   */
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


  /** Helper to copy APEX session state values into type safe record structures
   * @usage  Is called to copy the actual session state values entered into a type safe record structure.
   *         Type casting is auto detected if APEX has knowledge of the type, fi by using a format mask.
   *         If this does not exist, it will try to find the type based on a fetch row process and a database column reference.
   */
  procedure copy_edit_sgr
  as
  begin
    pit.enter_detailed;
    g_page_values := utl_apex.get_page_values;
    g_edit_sgr_row.sgr_id := coalesce(to_number(utl_apex.get(g_page_values, 'SGR_ID'), '999990'), sct_seq.nextval);
    g_edit_sgr_row.sgr_name := clean_sct_name(utl_apex.get(g_page_values, 'SGR_NAME'));
    g_edit_sgr_row.sgr_description := utl_apex.get(g_page_values, 'SGR_DESCRIPTION');
    g_edit_sgr_row.sgr_app_id := to_number(utl_apex.get(g_page_values, 'SGR_APP_ID'), 'fm9999999999990');
    g_edit_sgr_row.sgr_page_id := to_number(utl_apex.get(g_page_values, 'SGR_PAGE_ID'), 'fm9999999999990');
    g_edit_sgr_row.sgr_active := utl_apex.get(g_page_values, 'SGR_ACTIVE');
    g_edit_sgr_row.sgr_with_recursion := utl_apex.get(g_page_values, 'SGR_WITH_RECURSION');
    pit.leave_detailed;
  end copy_edit_sgr;


  procedure copy_edit_sru
  as
  begin
    pit.enter_detailed;
    g_page_values := utl_apex.get_page_values;
    g_edit_sru_row.sru_id := to_number(utl_apex.get(g_page_values, 'SRU_ID'), '999990');
    g_edit_sru_row.sru_sgr_id := to_number(utl_apex.get(g_page_values, 'SRU_SGR_ID'), '999990');
    g_edit_sru_row.sru_sort_seq := to_number(utl_apex.get(g_page_values, 'SRU_SORT_SEQ'), '999990');
    g_edit_sru_row.sru_name := utl_apex.get(g_page_values, 'SRU_NAME');
    g_edit_sru_row.sru_condition := utl_apex.get(g_page_values, 'SRU_CONDITION');
    g_edit_sru_row.sru_fire_on_page_load := utl_apex.get(g_page_values, 'SRU_FIRE_ON_PAGE_LOAD');
    g_edit_sru_row.sru_active := utl_apex.get(g_page_values, 'SRU_ACTIVE');

    pit.leave_detailed;
  end copy_edit_sru;


  procedure copy_edit_sra
  as
  begin
    pit.enter_detailed;
    g_page_values := utl_apex.get_page_values;
    g_edit_sra_row.seq_id := to_number(utl_apex.get(g_page_values, 'SEQ_ID'), '999990');
    g_edit_sra_row.sra_id := to_number(utl_apex.get(g_page_values, 'SRA_ID'), '999990');
    g_edit_sra_row.sra_sgr_id := to_number(utl_apex.get(g_page_values, 'SRA_SGR_ID'), '999990');
    g_edit_sra_row.sra_sru_id := to_number(utl_apex.get(g_page_values, 'SRA_SRU_ID'), '999990');
    g_edit_sra_row.sra_sort_seq := to_number(utl_apex.get(g_page_values, 'SRA_SORT_SEQ'), '999990');
    g_edit_sra_row.sra_spi_id := utl_apex.get(g_page_values, 'SRA_SPI_ID');
    g_edit_sra_row.sra_sat_id := utl_apex.get(g_page_values, 'SRA_SAT_ID');
    g_edit_sra_row.sra_param_1 := coalesce(utl_apex.get(g_page_values, 'SRA_PARAM_1'), utl_apex.get(g_page_values, 'SRA_PARAM_LOV_1'), utl_apex.get(g_page_values, 'SRA_PARAM_AREA_1'));
    g_edit_sra_row.sra_param_2 := coalesce(utl_apex.get(g_page_values, 'SRA_PARAM_2'), utl_apex.get(g_page_values, 'SRA_PARAM_LOV_2'), utl_apex.get(g_page_values, 'SRA_PARAM_AREA_2'));
    g_edit_sra_row.sra_param_3 := coalesce(utl_apex.get(g_page_values, 'SRA_PARAM_3'), utl_apex.get(g_page_values, 'SRA_PARAM_LOV_3'), utl_apex.get(g_page_values, 'SRA_PARAM_AREA_3'));
    g_edit_sra_row.sra_active := utl_apex.get(g_page_values, 'SRA_ACTIVE');
    g_edit_sra_row.sra_on_error := utl_apex.get(g_page_values, 'SRA_ON_ERROR');
    g_edit_sra_row.sra_raise_recursive := utl_apex.get(g_page_values, 'SRA_RAISE_RECURSIVE');
    g_edit_sra_row.sra_comment := utl_apex.get(g_page_values, 'SRA_COMMENT');

    pit.leave_detailed;
  end copy_edit_sra;


  procedure copy_edit_saa
  as
  begin
    pit.enter_detailed;
    g_page_values := utl_apex.get_page_values;
    g_edit_saa_row.seq_id := to_number(utl_apex.get(g_page_values, 'SEQ_ID'), 'fm9999999999999990d999999999');
    g_edit_saa_row.saa_id := to_number(utl_apex.get(g_page_values, 'SAA_ID'), 'fm9999999999990d99999999');
    g_edit_saa_row.saa_sgr_id := to_number(utl_apex.get(g_page_values, 'SAA_SGR_ID'), 'fm9999999999990d99999999');
    g_edit_saa_row.saa_sty_id := utl_apex.get(g_page_values, 'SAA_STY_ID');
    g_edit_saa_row.saa_name := utl_apex.get(g_page_values, 'SAA_NAME');
    g_edit_saa_row.saa_label := utl_apex.get(g_page_values, 'SAA_LABEL');
    g_edit_saa_row.saa_context_label := utl_apex.get(g_page_values, 'SAA_CONTEXT_LABEL');
    g_edit_saa_row.saa_icon := utl_apex.get(g_page_values, 'SAA_ICON');
    g_edit_saa_row.saa_icon_type := utl_apex.get(g_page_values, 'SAA_ICON_TYPE');
    g_edit_saa_row.saa_title := utl_apex.get(g_page_values, 'SAA_TITLE');
    g_edit_saa_row.saa_shortcut := utl_apex.get(g_page_values, 'SAA_SHORTCUT');
    g_edit_saa_row.saa_initially_disabled := utl_apex.get(g_page_values, 'SAA_INITIALLY_DISABLED');
    g_edit_saa_row.saa_initially_hidden := utl_apex.get(g_page_values, 'SAA_INITIALLY_HIDDEN');
    g_edit_saa_row.saa_href := utl_apex.get(g_page_values, 'SAA_HREF');
    g_edit_saa_row.saa_action := utl_apex.get(g_page_values, 'SAA_ACTION');
    g_edit_saa_row.saa_on_label := utl_apex.get(g_page_values, 'SAA_ON_LABEL');
    g_edit_saa_row.saa_off_label := utl_apex.get(g_page_values, 'SAA_OFF_LABEL');
    g_edit_saa_row.saa_get := utl_apex.get(g_page_values, 'SAA_GET');
    g_edit_saa_row.saa_set := utl_apex.get(g_page_values, 'SAA_SET');
    g_edit_saa_row.saa_choices := utl_apex.get(g_page_values, 'SAA_CHOICES');
    g_edit_saa_row.saa_label_classes := utl_apex.get(g_page_values, 'SAA_LABEL_CLASSES');
    g_edit_saa_row.saa_label_start_classes := utl_apex.get(g_page_values, 'SAA_LABEL_START_CLASSES');
    g_edit_saa_row.saa_label_end_classes := utl_apex.get(g_page_values, 'SAA_LABEL_END_CLASSES');
    g_edit_saa_row.saa_item_wrap_class := utl_apex.get(g_page_values, 'SAA_ITEM_WRAP_CLASS');
    g_edit_saa_row.saa_sai_list := utl_apex.get(g_page_values, 'SAA_SAI_LIST');
    pit.leave_detailed;
  end copy_edit_saa;


  procedure copy_edit_sat
  as
  begin
    pit.enter_detailed;
    g_page_values := utl_apex.get_page_values('EDIT_SAT');
    g_edit_sat_row.sat_id := clean_sct_name(utl_apex.get(g_page_values, 'SAT_ID'));
    g_edit_sat_row.sat_stg_id := clean_sct_name(utl_apex.get(g_page_values, 'SAT_STG_ID'));
    g_edit_sat_row.sat_sif_id := clean_sct_name(utl_apex.get(g_page_values, 'SAT_SIF_ID'));
    g_edit_sat_row.sat_name := utl_apex.get(g_page_values, 'SAT_NAME');
    g_edit_sat_row.sat_description := utl_apex.get(g_page_values, 'SAT_DESCRIPTION');
    g_edit_sat_row.sat_pl_sql := utl_apex.get(g_page_values, 'SAT_PL_SQL');
    g_edit_sat_row.sat_js := utl_apex.get(g_page_values, 'SAT_JS');
    g_edit_sat_row.sat_is_editable := utl_apex.get(g_page_values, 'SAT_IS_EDITABLE');
    g_edit_sat_row.sat_raise_recursive := utl_apex.get(g_page_values, 'SAT_RAISE_RECURSIVE');
    g_edit_sat_row.sat_active := utl_apex.get(g_page_values, 'SAT_ACTIVE');
    g_edit_sat_row.sap_spt_id_1 := utl_apex.get(g_page_values, 'SAP_SPT_ID_1');
    g_edit_sat_row.sap_display_name_1 := utl_apex.get(g_page_values, 'SAP_DISPLAY_NAME_1');
    g_edit_sat_row.sap_description_1 := utl_apex.get(g_page_values, 'SAP_DESCRIPTION_1');
    g_edit_sat_row.sap_default_1 := utl_apex.get(g_page_values, 'SAP_DEFAULT_1');
    g_edit_sat_row.sap_mandatory_1 := utl_apex.get(g_page_values, 'SAP_MANDATORY_1');
    g_edit_sat_row.sap_active_1 := utl_apex.get(g_page_values, 'SAP_ACTIVE_1');
    g_edit_sat_row.sap_spt_id_2 := utl_apex.get(g_page_values, 'SAP_SPT_ID_2');
    g_edit_sat_row.sap_display_name_2 := utl_apex.get(g_page_values, 'SAP_DISPLAY_NAME_2');
    g_edit_sat_row.sap_description_2 := utl_apex.get(g_page_values, 'SAP_DESCRIPTION_2');
    g_edit_sat_row.sap_default_2 := utl_apex.get(g_page_values, 'SAP_DEFAULT_2');
    g_edit_sat_row.sap_mandatory_2 := utl_apex.get(g_page_values, 'SAP_MANDATORY_2');
    g_edit_sat_row.sap_active_2 := utl_apex.get(g_page_values, 'SAP_ACTIVE_2');
    g_edit_sat_row.sap_spt_id_3 := utl_apex.get(g_page_values, 'SAP_SPT_ID_3');
    g_edit_sat_row.sap_display_name_3 := utl_apex.get(g_page_values, 'SAP_DISPLAY_NAME_3');
    g_edit_sat_row.sap_description_3 := utl_apex.get(g_page_values, 'SAP_DESCRIPTION_3');
    g_edit_sat_row.sap_default_3 := utl_apex.get(g_page_values, 'SAP_DEFAULT_3');
    g_edit_sat_row.sap_mandatory_3 := utl_apex.get(g_page_values, 'SAP_MANDATORY_3');
    g_edit_sat_row.sap_active_3 := utl_apex.get(g_page_values, 'SAP_ACTIVE_3');
    pit.leave_detailed;
  end copy_edit_sat;


  /* INTERFACE */
  function set_rule_overview_heading
    return varchar2
  as
    c_script constant varchar2(1000) := q'^$('#R1_RULE_OVERVIEW_heading').html('#HEADING#');^';
    l_script sct_util.max_char;
    l_sgr_id sct_rule_group.sgr_id%type;
  begin
    l_sgr_id := to_number(v('P1_SGR_ID'));
    select replace(c_script, '#HEADING#',
             pit.get_trans_item_name('SCT', 'SGR_REGION_HEADING', msg_args(
               apex_escape.html(sgr_description), to_char(sgr_id))))
      into l_script
      from sct_rule_group
     where sgr_id = l_sgr_id;

    return l_script;

  end set_rule_overview_heading;


  procedure copy_sgr
  as
  begin
    pit.enter_mandatory;
    g_page_values := utl_apex.get_page_values;
    sct_admin.copy_rule_group(
      p_sgr_id => to_number(utl_apex.get(g_page_values, 'SGR_ID')),
      p_sgr_app_id_to => to_number(utl_apex.get(g_page_values, 'SGR_APP_TO')),
      p_sgr_page_id_to => to_number(utl_apex.get(g_page_values, 'SGR_PAGE_TO')));
    pit.leave_mandatory;
  end copy_sgr;


  procedure process_export_sgr
  as
    cursor sgr_cur(
      p_sgr_app_id in sct_rule_group.sgr_app_id%type default null,
      p_sgr_page_id in sct_rule_group.sgr_page_id%type default null)
    is
      select sgr_id, lower(sgr_name) sgr_name
        from sct_rule_group
       where (sgr_app_id = p_sgr_app_id or p_sgr_app_id is null)
         and (sgr_page_id = p_sgr_page_id or p_sgr_page_id is null)
         and sgr_id > 0;

    l_sgr_app_id sct_rule_group.sgr_app_id%type;
    l_sgr_page_id sct_rule_group.sgr_page_id%type;
    l_sgr_id sct_rule_group.sgr_id%type;
    l_sgr_name sct_rule_group.sgr_name%type;
    l_clob clob;
    l_blob blob;
    l_zip_file blob;
    l_file_name varchar2(100);

    C_FILE_NAME constant varchar2(100 byte) := 'merge_rule_group_#SGR_NAME#.sql';
    C_ACTION_TYPE_FILE_NAME constant sct_util.ora_name_type := 'merge_action_types.sql';
    C_ZIP_APP_RULES_NAME constant sct_util.ora_name_type := 'application_#APP_ID#_rule_groups.zip';
    C_ZIP_PAGE_RULES_NAME constant sct_util.ora_name_type := 'app_#APP_ID#_page_#PAGE_ID#_rule_groups.zip';
    C_ZIP_ALL_RULES_NAME constant sct_util.ora_name_type := 'all_rule_groups.zip';
  begin
    pit.enter_mandatory;

    l_sgr_app_id := to_number(v('P8_SGR_APP_ID'));
    l_sgr_page_id := to_number(v('P8_SGR_PAGE_ID'));
    l_sgr_id := to_number(v('P8_SGR_ID'));

    case when utl_apex.request_is('EXPORT_SGR') then
      if l_sgr_id is not null then
        -- export single rule group
        select lower(sgr_name) sgr_name
          into l_file_name
          from sct_rule_group
         where sgr_id = l_sgr_id;

        l_blob := utl_text.clob_to_blob(sct_admin.export_rule_group(p_sgr_id => l_sgr_id));
        utl_apex.download_blob(l_blob, replace(C_FILE_NAME, '#SGR_NAME#', l_file_name));
      end if;
    when utl_apex.request_is('EXPORT_PAGE') then
      -- export all rule groupes of an application page
      for sgr in sgr_cur(l_sgr_app_id, l_sgr_page_id) loop
        l_blob := utl_text.clob_to_blob(sct_admin.export_rule_group(p_sgr_id => sgr.sgr_id));
        l_file_name := replace(C_FILE_NAME, '#SGR_NAME#', sgr.sgr_name);

        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => l_file_name,
          p_content => l_blob);
      end loop;

      apex_zip.finish(l_zip_file);
      utl_apex.download_blob(l_zip_file, replace(C_ZIP_APP_RULES_NAME, '#APP_ID#', l_sgr_app_id));
    when utl_apex.request_is('EXPORT_APP') then
      -- export all rule groupes of an application
      for sgr in sgr_cur(l_sgr_app_id) loop
        l_blob := utl_text.clob_to_blob(sct_admin.export_rule_group(p_sgr_id => sgr.sgr_id));
        l_file_name := replace(C_FILE_NAME, '#SGR_NAME#', sgr.sgr_name);

        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => l_file_name,
          p_content => l_blob);
      end loop;

      apex_zip.finish(l_zip_file);
      utl_apex.download_blob(l_zip_file, replace(C_ZIP_APP_RULES_NAME, '#APP_ID#', l_sgr_app_id));
    else
      -- export action types
      l_blob := utl_text.clob_to_blob(sct_admin.export_action_types);
      apex_zip.add_file(
        p_zipped_blob => l_zip_file,
        p_file_name => C_ACTION_TYPE_FILE_NAME,
        p_content => l_blob);

      -- export all rule groups
      for sgr in sgr_cur loop
        l_blob := utl_text.clob_to_blob(sct_admin.export_rule_group(p_sgr_id => sgr.sgr_id));
        l_file_name := replace(C_FILE_NAME, '#SGR_NAME#', sgr.sgr_name);

        apex_zip.add_file(
          p_zipped_blob => l_zip_file,
          p_file_name => replace(C_FILE_NAME, '#SGR_NAME#', sgr.sgr_name),
          p_content => l_blob);
      end loop;

      apex_zip.finish(l_zip_file);

      utl_apex.download_blob(l_zip_file, C_ZIP_ALL_RULES_NAME);
    end case;

    pit.leave_mandatory;
  end process_export_sgr;


  function get_export_type
    return varchar2
  as
    l_export_type varchar2(20 byte);
  begin
    pit.enter_detailed;

    case when v('P8_SGR_ID') is not null then
      l_export_type := 'SGR';
    when v('P8_SGR_PAGE_ID') is not null then
      l_export_type := 'PAGE';
    when v('P8_SGR_APP_ID') is not null then
      l_export_type := 'APP';
    else
      l_export_type := 'ALL_SGR';
    end case;

    pit.leave_detailed;
    return l_export_type;
  end get_export_type;


  procedure initialize_sra_collection
  as
    cursor sra_cur(p_sru_id in sct_rule.sru_id%type) is
      select *
        from sct_rule_action
       where sra_sru_id = p_sru_id;
    l_sru_id sct_rule.sru_id%type;
  begin
    pit.enter_optional;
    l_sru_id := to_number(v('P5_SRU_ID'));

    apex_collection.create_or_truncate_collection(C_SRA_COLLECTION);
    for sra in sra_cur(l_sru_id) loop
      apex_collection.add_member(
        p_collection_name => c_sra_collection,
        p_n001 => sra.sra_id,
        p_n002 => sra.sra_sgr_id,
        p_n003 => sra.sra_sru_id,
        p_c001 => sra.sra_spi_id,
        p_c002 => sra.sra_sat_id,
        p_n004 => sra.sra_sort_seq,
        p_c003 => sra.sra_param_1,
        p_c004 => sra.sra_param_2,
        p_c005 => sra.sra_param_3,
        p_c006 => sra.sra_comment,
        p_c007 => sra.sra_on_error,
        p_c008 => sra.sra_raise_recursive,
        p_c009 => sra.sra_active,
        p_generate_md5 => sct_util.C_FALSE);
    END LOOP;

    pit.leave_optional;
  end initialize_sra_collection;


  procedure initialize_saa_collection
  as
    cursor saa_cur(p_sgr_id in sct_rule_group.sgr_id%type) is
      select saa.*, sai.saa_sai_list
        from sct_apex_action saa
        left join (
             select sai_saa_id, listagg(sai_spi_id, ':') within group (order by sai_spi_id) saa_sai_list
               from sct_apex_action_item
              group by sai_saa_id) sai
          on saa_id = sai_saa_id
       where saa_sgr_id = p_sgr_id;
    l_sgr_id sct_rule_group.sgr_id%type;
  begin
    pit.enter_optional;
    l_sgr_id := to_number(v('P6_SGR_ID'));

    apex_collection.create_or_truncate_collection(C_SAA_COLLECTION);
    for saa in saa_cur(l_sgr_id) loop
      apex_collection.add_member(
        p_collection_name => C_SAA_COLLECTION,
        p_n001 => saa.saa_id,
        p_n002 => saa.saa_sgr_id,
        p_c001 => saa.saa_sty_id,
        p_c002 => saa.saa_name,
        p_c003 => saa.saa_label,
        p_c004 => saa.saa_context_label,
        p_c005 => saa.saa_icon,
        p_c006 => saa.saa_icon_type,
        p_c007 => saa.saa_title,
        p_c008 => saa.saa_shortcut,
        p_c009 => saa.saa_initially_disabled,
        p_c010 => saa.saa_initially_hidden,
        p_c011 => saa.saa_href,
        p_c012 => saa.saa_action,
        p_c013 => saa.saa_on_label,
        p_c014 => saa.saa_off_label,
        p_c015 => saa.saa_get,
        p_c016 => saa.saa_set,
        p_c017 => saa.saa_choices,
        p_c018 => saa.saa_label_classes,
        p_c019 => saa.saa_label_start_classes,
        p_c020 => saa.saa_label_end_classes,
        p_c021 => saa.saa_item_wrap_class,
        p_c022 => saa.saa_sai_list,
        p_generate_md5 => sct_util.C_FALSE);
    END LOOP;

    pit.leave_optional;
  end initialize_saa_collection;


  /* Methods to maintain user entries on APEX pages */
  function validate_edit_sgr
    return boolean
  as
    l_exists binary_integer;
  begin
    pit.enter_mandatory;
    copy_edit_sgr;

    -- Validierungen
    utl_apex.assert_not_null(g_edit_sgr_row.sgr_app_id, msg.APEX_REQUIRED_VAL_MISSING, 'SGR_APP_ID');
    utl_apex.assert_not_null(g_edit_sgr_row.sgr_page_id, msg.APEX_REQUIRED_VAL_MISSING, 'SGR_PAGE_ID');
    utl_apex.assert_not_null(g_edit_sgr_row.sgr_name, msg.APEX_REQUIRED_VAL_MISSING, 'SGR_NAME');

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
        p_message_name => msg.SCT_SGR_MUST_BE_UNIQUE,
        p_msg_args => null,
        p_page_item => 'SGR_NAME');
    end if;

    pit.leave_mandatory;
    return true;
  end validate_edit_sgr;


  procedure process_edit_sgr
  as
  begin
    pit.enter_mandatory;
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

    if utl_apex.updating then
      begin
        -- Copy data from Collection and merge into SCT_APEX_ACTION
        -- APEX actions can be created after creation of the rule group only
        delete from sct_apex_action
         where saa_sgr_id = g_edit_sgr_row.sgr_id
           and saa_id not in(
               select saa_id
                 from sct_ui_edit_saa);

        merge into sct_apex_action t
        using sct_ui_edit_saa s
           on (t.saa_id = s.saa_id)
         when matched then update set
                t.saa_sty_id = s.saa_sty_id,
                t.saa_name = s.saa_name,
                t.saa_label = s.saa_label,
                t.saa_context_label = s.saa_context_label,
                t.saa_icon = s.saa_icon,
                t.saa_icon_type = s.saa_icon_type,
                t.saa_title = s.saa_title,
                t.saa_shortcut = s.saa_shortcut,
                t.saa_initially_disabled = s.saa_initially_disabled,
                t.saa_initially_hidden = s.saa_initially_hidden,
                t.saa_href = s.saa_href,
                t.saa_action = s.saa_action,
                t.saa_on_label = s.saa_on_label,
                t.saa_off_label = s.saa_off_label,
                t.saa_get = s.saa_get,
                t.saa_set = s.saa_set,
                t.saa_choices = s.saa_choices,
                t.saa_label_classes = s.saa_label_classes,
                t.saa_label_start_classes = s.saa_label_start_classes,
                t.saa_label_end_classes = s.saa_label_end_classes,
                t.saa_item_wrap_class = s.saa_item_wrap_class
         when not matched then insert(
                saa_id, saa_sgr_id, saa_sty_id, saa_name, saa_label, saa_context_label, saa_icon, saa_icon_type, saa_title,
                saa_shortcut, saa_initially_disabled, saa_initially_hidden, saa_href, saa_action, saa_on_label, saa_off_label,
                saa_get, saa_set, saa_choices, saa_label_classes, saa_label_start_classes, saa_label_end_classes, saa_item_wrap_class)
              values (
                s.saa_id, s.saa_sgr_id, s.saa_sty_id, s.saa_name, s.saa_label, s.saa_context_label, s.saa_icon, s.saa_icon_type, s.saa_title,
                s.saa_shortcut, s.saa_initially_disabled, s.saa_initially_hidden, s.saa_href, s.saa_action, s.saa_on_label, s.saa_off_label,
                s.saa_get, s.saa_set, s.saa_choices, s.saa_label_classes, s.saa_label_start_classes, s.saa_label_end_classes, s.saa_item_wrap_class);

        -- Copy data from Collection and merge into SCT_APEX_ACTION_ITEM
        delete from sct_apex_action_item
         where sai_saa_id in
               (select saa_id
                  from sct_ui_edit_saa);

        insert into sct_apex_action_item(sai_saa_id, sai_spi_sgr_id, sai_spi_id)
        select saa_id, saa_sgr_id, column_value
          from sct_ui_edit_saa saa
         cross join table(utl_text.string_to_table(saa.saa_sai_list));
      exception
        when NO_DATA_FOUND then
          null; -- No apex action created, ignore.
      end;
    end if;

    pit.leave_mandatory;
  end process_edit_sgr;


  procedure validate_rule
  as
    l_error varchar2(4000);
  begin
    pit.enter_mandatory;

    sct_admin.validate_rule(
      p_sgr_id => v('P5_SRU_SGR_ID'),
      p_sru_condition => v('P5_SRU_CONDITION'),
      p_error => l_error);

    if l_error is not null then
      sct.register_error(
        p_spi_id => 'P5_SRU_CONDITION',
        p_error_msg => l_error,
        p_internal_error => null);
    end if;

    pit.leave_mandatory;
  end validate_rule;


  function validate_edit_sru
    return boolean
  as
  begin
    pit.enter_mandatory;
    --copy_edit_sru;

    pit.leave_mandatory;
    return true;
  end validate_edit_sru;


  procedure process_edit_sru
  as
  begin
    copy_edit_sru;
    g_edit_sru_row.sru_id := coalesce(g_edit_sru_row.sru_id, sct_seq.nextval);
    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_rule(
        p_sru_id => g_edit_sru_row.sru_id,
        p_sru_sgr_id => g_edit_sru_row.sru_sgr_id,
        p_sru_name => g_edit_sru_row.sru_name,
        p_sru_condition => g_edit_sru_row.sru_condition,
        p_sru_fire_on_page_load => g_edit_sru_row.sru_fire_on_page_load,
        p_sru_sort_seq => g_edit_sru_row.sru_sort_seq,
        p_sru_active => g_edit_sru_row.sru_active);

      -- Copy data from Collection and merge into SCT_RULE_ACTION
      -- Direct DML because of bulk orientied approach against APEX collection view
      delete from sct_rule_action
       where sra_sru_id = g_edit_sru_row.sru_id
         and sra_id not in(
             select sra_id
               from sct_ui_edit_sra);

      begin
        merge into sct_rule_action t
        using sct_ui_edit_sra s
           on (t.sra_id = s.sra_id)
         when matched then update set
                t.sra_spi_id = s.sra_spi_id,
                t.sra_sat_id = s.sra_sat_id,
                t.sra_param_1 = s.sra_param_1,
                t.sra_param_2 = s.sra_param_2,
                t.sra_param_3 = s.sra_param_3,
                t.sra_comment = s.sra_comment,
                t.sra_on_error = s.sra_on_error,
                t.sra_raise_recursive = s.sra_raise_recursive,
                t.sra_sort_seq = s.sra_sort_seq,
                t.sra_active = s.sra_active,
                t.sra_has_error = s.sra_has_error
         when not matched then insert (
                sra_id, sra_sgr_id, sra_sru_id, sra_spi_id, sra_sat_id, sra_param_1, sra_param_2, sra_param_3,
                sra_comment, sra_on_error, sra_raise_recursive, sra_sort_seq, sra_active, sra_has_error)
              values(
                s.sra_id, s.sra_sgr_id, g_edit_sru_row.sru_id, s.sra_spi_id, s.sra_sat_id, s.sra_param_1, s.sra_param_2, s.sra_param_3,
                s.sra_comment, s.sra_on_error, s.sra_raise_recursive, s.sra_sort_seq, s.sra_active, s.sra_has_error);
      exception
        when NO_DATA_FOUND then
          null; -- No rule action added, ignore
      end;
    when utl_apex.deleting then
      sct_admin.delete_rule(g_edit_sru_row.sru_id);
    else
      utl_apex.unhandled_request;
    end case;
    sct_admin.propagate_rule_change(g_edit_sru_row.sru_sgr_id);
  end process_edit_sru;


  procedure configure_edit_sra
  as
    cursor action_type_cur(p_sat_id in sct_action_type.sat_id%type) is
        with params as(
             select sct_util.get_true is_active,
                    p_sat_id sat_id
               from dual)
      select /*+ no_merge (p) */
             sat.sat_id, sat_sif_id, sap_sort_seq, spt_id, spt_item_type,
             coalesce(sap_display_name, spt_name) spt_name
        from sct_action_type_v sat
        join sct_action_parameter_v
          on sat.sat_id = sap_sat_id
        join sct_action_param_type_v
          on sap_spt_id = spt_id
        join params p
          on sat.sat_id = p.sat_id
       where sat_active = p.is_active
         and sap_active = p.is_active
         and spt_active = p.is_active
       order by sat_id, sap_sort_seq;
    C_SET_LABEL constant varchar2(100) := q'^$('^#ITEM_ID#_LABEL').html('#SPT_NAME#');^';
    C_SET_SAT_HELP constant varchar2(100) := q'^$('^R11_SAT_HELP .t-Region-body').html('#HELP_TEXT#');^';
    l_region_id sct_util.ora_name_type;
    l_lov_param_id sct_util.ora_name_type;
    l_item_id sct_util.ora_name_type;
    l_help_text sct_util.max_char;
    l_sat_id sct_action_type.sat_id%type;
  begin
    l_sat_id := v('P11_SRA_SAT_ID');
    sct.toggle_item_visibility(
      p_selector => '.sct-hide',
      p_visible => false);

    -- Adjust Parameter settings to show only required parameters in the correct format
    for param in action_type_cur(l_sat_id) loop
      l_region_id := 'R11_PARAMETER_' || param.sap_sort_seq;

      -- Show region
      sct.toggle_item_visibility(
        p_selector => l_region_id);

      -- UI visibility and label
      case param.spt_item_type
      when 'SELECT_LIST' then
        l_lov_param_id := 'P11_LOV_PARAM_' || param.sap_sort_seq;
        l_item_id := 'P11_SRA_PARAM_LOV_' || param.sap_sort_seq;
        sct.set_session_state(l_lov_param_id, param.spt_id);
        sct.refresh_item(l_item_id);
      when 'TEXT_AREA' then
        l_item_id := 'P11_SRA_PARAM_AREA_' || param.sap_sort_seq;
      else
        l_item_id := 'P11_SRA_PARAM_' || param.sap_sort_seq;
      end case;

      sct.toggle_item_visibility(
        p_selector => l_item_id);
      sct.add_javascript(utl_text.bulk_replace(C_SET_LABEL, char_table('ITEM_ID', l_item_id, 'SPT_NAME', param.spt_name)));

    end loop;

    -- Generate Help text for action type
    select apex_escape.json(help_text)
      into l_help_text
      from sct_bl_sat_help
     where sat_id = l_sat_id;
    sct.add_javascript(utl_text.bulk_replace(C_SET_SAT_HELP, char_table('HELP_TEXT', l_help_text)));

  exception
    when NO_DATA_FOUND then
      sct.add_javascript(utl_text.bulk_replace(C_SET_SAT_HELP, char_table('HELP_TEXT', pit.get_trans_item_name('SCT', 'SRA_NO_HELP'))));
  end configure_edit_sra;


  function validate_edit_sra
    return boolean
  as
    l_error varchar2(4000);
  begin
    pit.enter_mandatory;
    copy_edit_sra;

    --sct_util.assert_not_null(g_edit_sra_row.sra_sru_id, msg.APEX_REQUIRED_VAL_MISSING, 'SRA_SRU_ID');
    utl_apex.assert_not_null(g_edit_sra_row.sra_sgr_id, msg.APEX_REQUIRED_VAL_MISSING, 'SRA_SGR_ID');
    utl_apex.assert_not_null(g_edit_sra_row.sra_spi_id, msg.APEX_REQUIRED_VAL_MISSING, 'SRA_SPI_ID');
    utl_apex.assert_not_null(g_edit_sra_row.sra_sat_id, msg.APEX_REQUIRED_VAL_MISSING, 'SRA_SAT_ID');

    pit.leave_mandatory;
    return true;
  end validate_edit_sra;


  procedure process_edit_sra
  as
  begin
    pit.enter_mandatory;
    copy_edit_sra;
    case
    when utl_apex.INSERTING then
      g_edit_sra_row.sra_id := coalesce(g_edit_sra_row.sra_id, sct_seq.nextval);
      apex_collection.add_member(
        p_collection_name => C_SRA_COLLECTION,
        p_n001 => g_edit_sra_row.sra_id,
        p_n002 => g_edit_sra_row.sra_sgr_id,
        p_n003 => g_edit_sra_row.sra_sru_id,
        p_c001 => g_edit_sra_row.sra_spi_id,
        p_c002 => g_edit_sra_row.sra_sat_id,
        p_n004 => g_edit_sra_row.sra_sort_seq,
        p_c003 => g_edit_sra_row.sra_param_1,
        p_c004 => g_edit_sra_row.sra_param_2,
        p_c005 => g_edit_sra_row.sra_param_3,
        p_c006 => g_edit_sra_row.sra_comment,
        p_c007 => g_edit_sra_row.sra_on_error,
        p_c008 => g_edit_sra_row.sra_raise_recursive,
        p_c009 => g_edit_sra_row.sra_active,
        p_generate_md5 => sct_util.c_false);
    WHEN utl_apex.updating THEN
      apex_collection.update_member(
        p_seq => g_edit_sra_row.seq_id,
        p_collection_name => C_SRA_COLLECTION,
        p_n001 => g_edit_sra_row.sra_id,
        p_n002 => g_edit_sra_row.sra_sgr_id,
        p_n003 => g_edit_sra_row.sra_sru_id,
        p_c001 => g_edit_sra_row.sra_spi_id,
        p_c002 => g_edit_sra_row.sra_sat_id,
        p_n004 => g_edit_sra_row.sra_sort_seq,
        p_c003 => g_edit_sra_row.sra_param_1,
        p_c004 => g_edit_sra_row.sra_param_2,
        p_c005 => g_edit_sra_row.sra_param_3,
        p_c006 => g_edit_sra_row.sra_comment,
        p_c007 => g_edit_sra_row.sra_on_error,
        p_c008 => g_edit_sra_row.sra_raise_recursive,
        p_c009 => g_edit_sra_row.sra_active);
    WHEN utl_apex.deleting THEN
      apex_collection.delete_member(
        p_seq => g_edit_sra_row.seq_id,
        p_collection_name => C_SRA_COLLECTION);
    else
      null;
    end case;
    pit.leave_mandatory;
  end process_edit_sra;


  function validate_edit_sat
    return boolean
  as
  begin
    copy_edit_sat;

    return true;
  end validate_edit_sat;


  procedure process_edit_sat
  as
    l_sat_row sct_action_type_v%rowtype;
    l_sap_row sct_action_parameter_v%rowtype;
  begin
    copy_edit_sat;

    l_sat_row.sat_id := g_edit_sat_row.sat_id;
    l_sat_row.sat_stg_id := g_edit_sat_row.sat_stg_id;
    l_sat_row.sat_sif_id := g_edit_sat_row.sat_sif_id;
    l_sat_row.sat_name := g_edit_sat_row.sat_name;
    l_sat_row.sat_description := g_edit_sat_row.sat_description;
    l_sat_row.sat_pl_sql := g_edit_sat_row.sat_pl_sql;
    l_sat_row.sat_js := g_edit_sat_row.sat_js;
    l_sat_row.sat_is_editable := g_edit_sat_row.sat_is_editable;
    l_sat_row.sat_raise_recursive := g_edit_sat_row.sat_raise_recursive;
    l_sat_row.sat_active := g_edit_sat_row.sat_active;

    -- copy constant parameter values to param record
    l_sap_row.sap_sat_id := l_sat_row.sat_id;

    case
    when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_action_type(l_sat_row);

      if g_edit_sat_row.sap_spt_id_1 is not null then
        l_sap_row.sap_spt_id := g_edit_sat_row.sap_spt_id_1;
        l_sap_row.sap_display_name := g_edit_sat_row.sap_display_name_1;
        l_sap_row.sap_description := g_edit_sat_row.sap_description_1;
        l_sap_row.sap_default := g_edit_sat_row.sap_default_1;
        l_sap_row.sap_mandatory := g_edit_sat_row.sap_mandatory_1;
        l_sap_row.sap_active := g_edit_sat_row.sap_active_1;
        l_sap_row.sap_sort_seq := 1;
        sct_admin.merge_action_parameter(l_sap_row);
      end if;

      if g_edit_sat_row.sap_spt_id_2 is not null then
        l_sap_row.sap_spt_id := g_edit_sat_row.sap_spt_id_2;
        l_sap_row.sap_display_name := g_edit_sat_row.sap_display_name_2;
        l_sap_row.sap_description := g_edit_sat_row.sap_description_2;
        l_sap_row.sap_default := g_edit_sat_row.sap_default_2;
        l_sap_row.sap_mandatory := g_edit_sat_row.sap_mandatory_2;
        l_sap_row.sap_active := g_edit_sat_row.sap_active_2;
        l_sap_row.sap_sort_seq := 2;
        sct_admin.merge_action_parameter(l_sap_row);
      end if;

      if g_edit_sat_row.sap_spt_id_3 is not null then
        l_sap_row.sap_spt_id := g_edit_sat_row.sap_spt_id_3;
        l_sap_row.sap_display_name := g_edit_sat_row.sap_display_name_3;
        l_sap_row.sap_description := g_edit_sat_row.sap_description_3;
        l_sap_row.sap_default := g_edit_sat_row.sap_default_3;
        l_sap_row.sap_mandatory := g_edit_sat_row.sap_mandatory_3;
        l_sap_row.sap_active := g_edit_sat_row.sap_active_3;
        l_sap_row.sap_sort_seq := 3;
        sct_admin.merge_action_parameter(l_sap_row);
      end if;

    when utl_apex.deleting then
      sct_admin.delete_action_type(l_sat_row);
    else
      null;
    end case;
  end process_edit_sat;


  procedure print_sat_help
  as
    l_help_text clob;
    l_sat_id utl_apex.ora_name_type;
  begin
    l_sat_id := v('P3_SAT_ID');

    select help_text
      into l_help_text
      from sct_bl_sat_help
     where sat_id = l_sat_id;

    htp.p(l_help_text);
  exception
    when NO_DATA_FOUND then
      -- No SAT_ID given (fi upon creation), ignore
      null;
  end print_sat_help;


  function validate_edit_saa
    return boolean
  as
  begin
    -- copy_edit_saa;

    return true;
  end validate_edit_saa;


  procedure process_edit_saa
  as
  begin
    copy_edit_saa;
    case
    when utl_apex.inserting then
      g_edit_saa_row.saa_id := coalesce(g_edit_saa_row.saa_id, sct_seq.nextval);
      apex_collection.add_member(
        p_collection_name => C_SAA_COLLECTION,
        p_n001 => g_edit_saa_row.saa_id,
        p_n002 => g_edit_saa_row.saa_sgr_id,
        p_c001 => g_edit_saa_row.saa_sty_id,
        p_c002 => g_edit_saa_row.saa_name,
        p_c003 => g_edit_saa_row.saa_label,
        p_c004 => g_edit_saa_row.saa_context_label,
        p_c005 => g_edit_saa_row.saa_icon,
        p_c006 => g_edit_saa_row.saa_icon_type,
        p_c007 => g_edit_saa_row.saa_title,
        p_c008 => g_edit_saa_row.saa_shortcut,
        p_c009 => g_edit_saa_row.saa_initially_disabled,
        p_c010 => g_edit_saa_row.saa_initially_hidden,
        p_c011 => g_edit_saa_row.saa_href,
        p_c012 => g_edit_saa_row.saa_action,
        p_c013 => g_edit_saa_row.saa_on_label,
        p_c014 => g_edit_saa_row.saa_off_label,
        p_c015 => g_edit_saa_row.saa_get,
        p_c016 => g_edit_saa_row.saa_set,
        p_c017 => g_edit_saa_row.saa_choices,
        p_c018 => g_edit_saa_row.saa_label_classes,
        p_c019 => g_edit_saa_row.saa_label_start_classes,
        p_c020 => g_edit_saa_row.saa_label_end_classes,
        p_c021 => g_edit_saa_row.saa_item_wrap_class,
        p_c022 => g_edit_saa_row.saa_sai_list,
        p_generate_md5 => sct_util.C_FALSE);
    when utl_apex.updating then
      apex_collection.update_member(
        p_seq => g_edit_saa_row.seq_id,
        p_collection_name => C_SAA_COLLECTION,
        p_n001 => g_edit_saa_row.saa_id,
        p_n002 => g_edit_saa_row.saa_sgr_id,
        p_c001 => g_edit_saa_row.saa_sty_id,
        p_c002 => g_edit_saa_row.saa_name,
        p_c003 => g_edit_saa_row.saa_label,
        p_c004 => g_edit_saa_row.saa_context_label,
        p_c005 => g_edit_saa_row.saa_icon,
        p_c006 => g_edit_saa_row.saa_icon_type,
        p_c007 => g_edit_saa_row.saa_title,
        p_c008 => g_edit_saa_row.saa_shortcut,
        p_c009 => g_edit_saa_row.saa_initially_disabled,
        p_c010 => g_edit_saa_row.saa_initially_hidden,
        p_c011 => g_edit_saa_row.saa_href,
        p_c012 => g_edit_saa_row.saa_action,
        p_c013 => g_edit_saa_row.saa_on_label,
        p_c014 => g_edit_saa_row.saa_off_label,
        p_c015 => g_edit_saa_row.saa_get,
        p_c016 => g_edit_saa_row.saa_set,
        p_c017 => g_edit_saa_row.saa_choices,
        p_c018 => g_edit_saa_row.saa_label_classes,
        p_c019 => g_edit_saa_row.saa_label_start_classes,
        p_c020 => g_edit_saa_row.saa_label_end_classes,
        p_c021 => g_edit_saa_row.saa_item_wrap_class,
        p_c022 => g_edit_saa_row.saa_sai_list);
    when utl_apex.deleting then
      apex_collection.delete_member(
        p_seq => g_edit_saa_row.seq_id,
        p_collection_name => C_SAA_COLLECTION);
    else
      null;
    end case;
  end process_edit_saa;


  function get_sru_sort_seq
    return number
  as
    l_sru_sort_seq sct_rule.sru_sort_seq%type;
    l_sgr_id sct_rule_group.sgr_id%type;
  begin
    pit.enter_mandatory;
    l_sgr_id := to_number(v('P5_SRU_SGR_ID'));

    select coalesce(max(trunc(sru_sort_seq, -1)) + 10, 10)
      into l_sru_sort_seq
      from sct_rule
     where sru_sgr_id = l_sgr_id;

    pit.leave_mandatory;
    return l_sru_sort_seq;
  end get_sru_sort_seq;


  function get_sra_sort_seq
    return number
  as
    l_sra_sort_seq sct_rule_action.sra_sort_seq%type;
    l_sru_id sct_rule.sru_id%type;
    l_sra_id sct_rule_action.sra_id%type;
  begin
    pit.enter_mandatory;
    l_sru_id := to_number(v('P11_SRA_SRU_ID'));
    l_sra_id := to_number(v('P11_SRA_ID'));

    if l_sra_id is null then
      select coalesce(max(trunc(sra_sort_seq, -1)) + 10, 10)
        into l_sra_sort_seq
        from sct_ui_edit_sra
       where sra_sru_id = l_sru_id;
    else
      select sra_sort_seq
        into l_sra_sort_seq
        from sct_ui_edit_sra
       where sra_id = l_sra_id;
    end if;

    pit.leave_mandatory;
    return l_sra_sort_seq;
  end get_sra_sort_seq;


  procedure get_action_type_help
  as
    l_help_text sct_util.max_char;
    l_not_editable varchar2(100 char);
  begin
    pit.enter_mandatory;
    l_not_editable := pit.get_trans_item_name('SCT', 'SAT_NOT_EDITABLE');

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
                             case sat_is_editable when sct_util.C_FALSE then l_not_editable end sat_is_editable
                         from sct_action_type_v
                        cross join params p
                        where uttm_mode = 'HELP'
                        order by sat_name), sct_util.C_CR) help_list
               from dual)
           )
      into l_help_text
      from params
     where uttm_mode = 'FRAME';
    htp.p(l_help_text);

    pit.leave_mandatory;
  end get_action_type_help;


  /* APEX-Aktionen */
  procedure set_action_admin_sgr
  as
    l_sgr_id sct_rule_group.sgr_id%type;
    l_sgr_app_id sct_rule_group.sgr_app_id%type;
    l_sgr_page_id sct_rule_group.sgr_page_id%type;
    l_javascript varchar2(32767);
    l_has_target_application number(1, 0);
  begin
    pit.enter_optional;

    l_sgr_id := to_number(v('P1_SGR_ID'));

    -- Action CREATE_RULE
    utl_apex_action.action_init('create-rule');

    if l_sgr_id is not null then
      -- persist APP_ID and PAGE_ID in case exporting this rule is called
      select sgr_app_id, sgr_page_id
        into l_sgr_app_id, l_sgr_page_id
        from sct_rule_group
       where sgr_id = l_sgr_id;
      apex_util.set_session_state('P1_SGR_APP_ID', l_sgr_app_id);
      apex_util.set_session_state('P1_SGR_PAGE_ID', l_sgr_page_id);

      l_javascript := utl_apex.get_page_url(
                        p_page => 'EDIT_SRU',
                        p_param_items => 'P5_SRU_SGR_ID',
                        p_value_items => 'P1_SGR_ID',
                        p_triggering_element => 'R1_RULE_OVERVIEW',
                        p_clear_cache => 5);
      utl_apex_action.set_action(l_javascript);
      utl_apex_action.set_disabled(false);
    else
      utl_apex_action.set_disabled(true);
    end if;

    sct.add_javascript(utl_apex_action.get_action_script);

    -- Action COPY_RULEGROUP
    utl_apex_action.action_init('copy-rulegroup');

    if l_sgr_id is not null then
      -- Check whether a target application to copy the rule to exists
      select count(*)
        into l_has_target_application
        from dual
       where exists(
             select null
               from apex_applications
              where application_id not in (apex_application.g_flow_id, l_sgr_app_id));
      if l_has_target_application = 1 then
        l_javascript := utl_apex.get_page_url(
                          p_page => 'COPY_SGR',
                          p_param_items => 'P4_SGR_ID',
                          p_value_items => 'P1_SGR_ID',
                          p_triggering_element => 'B1_COPY_SGR');
        utl_apex_action.set_action(l_javascript);
        utl_apex_action.set_disabled(false);
      end if;
    else
      utl_apex_action.set_disabled(true);
    end if;

    sct.add_javascript(utl_apex_action.get_action_script);

    -- Action EXPORT_RULEGROUP
    utl_apex_action.action_init('export-rulegroup');

    l_javascript := utl_apex.get_page_url(
                      p_page => 'EXPORT_SGR',
                      p_param_items => 'P8_SGR_ID:P8_SGR_APP_ID:P8_SGR_PAGE_ID',
                      p_value_items => 'P1_SGR_ID:P1_SGR_APP_ID:P1_SGR_PAGE_ID',
                      p_triggering_element => 'B1_EXPORT_SGR');

    utl_apex_action.set_action(l_javascript);
    sct.add_javascript(utl_apex_action.get_action_script);

    pit.leave_optional;
  end set_action_admin_sgr;


  procedure set_action_edit_sgr
  as
    l_javascript varchar2(32767);
  begin
    pit.enter_optional;
    -- Intenionally left blank TODO: Implement
    pit.leave_optional;
  end set_action_edit_sgr;


  procedure set_action_export_sgr
  as
    l_export_type varchar2(10);
    l_sgr_app_id sct_rule_group.sgr_app_id%type;
    l_sgr_page_id sct_rule_group.sgr_page_id%type;
    l_sgr_id sct_rule_group.sgr_id%type;
    l_sgr_name sct_rule_group.sgr_name%type;
    C_SUCCESS_COMMAND constant varchar2(100) := q'^apex.submit('EXPORT_#TYPE#');^';
    l_action varchar2(100);
  begin
    pit.enter_optional;

    -- Initialzation
    l_export_type := v('P8_EXPORT_TYPE');
    l_sgr_app_id := v('P8_SGR_APP_ID');
    l_sgr_page_id := v('P8_SGR_PAGE_ID');
    l_sgr_id := v('P8_SGR_ID');
    l_action := replace(C_SUCCESS_COMMAND, '#TYPE#', l_export_type);

    utl_apex_action.action_init('export-rulegroup');

    -- decision tree
    case
    when l_export_type = 'SGR' and l_sgr_id is not null then
      select pit.get_trans_item_name('SCT', 'SGR_EXPORT_LABEL_SGR', msg_args(sgr_name))
        into l_sgr_name
        from sct_rule_group
       where sgr_id = l_sgr_id;
      utl_apex_action.set_label(l_sgr_name);
      utl_apex_action.set_disabled(false);
      utl_apex_action.set_action(l_action);
    when l_export_type = 'PAGE' and l_sgr_page_id is not null then
      utl_apex_action.set_label(pit.get_trans_item_name('SCT', 'SGR_EXPORT_LABEL_PAGE', msg_args(to_char(l_sgr_page_id))));
      utl_apex_action.set_disabled(false);
      utl_apex_action.set_action(l_action);
    when l_export_type = 'APP' and l_sgr_app_id is not null then
      utl_apex_action.set_label(pit.get_trans_item_name('SCT', 'SGR_EXPORT_LABEL_APP', msg_args(to_char(l_sgr_app_id))));
      utl_apex_action.set_disabled(false);
      utl_apex_action.set_action(l_action);
    when l_export_type = 'ALL_SGR' then
      utl_apex_action.set_label(pit.get_trans_item_name('SCT', 'SGR_EXPORT_LABEL_ALL'));
      utl_apex_action.set_disabled(false);
      utl_apex_action.set_action(l_action);
    else
      if l_export_type = 'APP' then
        utl_apex_action.set_label(pit.get_trans_item_name('SCT', 'SELECT_APP'));
      else
        utl_apex_action.set_label(pit.get_trans_item_name('SCT', 'SELECT_SGR'));
      end if;
      utl_apex_action.set_disabled(true);
    end case;
    sct.add_javascript(utl_apex_action.get_action_script);

    pit.leave_optional;
  exception
    when others then
      sct.register_error('DOCUMENT', sqlerrm, pit_util.get_call_stack);
  end set_action_export_sgr;


  procedure set_action_edit_sru
  as
    l_javascript varchar2(32767);
  begin
    pit.enter_optional;
    -- Intenionally left blank TODO: Implement
    pit.leave_optional;
  end set_action_edit_sru;

end sct_ui_pkg;
/