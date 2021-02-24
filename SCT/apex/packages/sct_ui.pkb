create or replace package body sct_ui
as

  C_SRA_COLLECTION constant sct_util.ora_name_type := 'SCT_UI_EDIT_SRA';
  C_SAA_COLLECTION constant sct_util.ora_name_type := 'SCT_UI_EDIT_SAA';
  
  C_PAGE_ADMIN_SGR constant binary_integer := 1;
  C_PAGE_EDIT_SGR constant binary_integer := 6;
  C_PAGE_EDIT_SRU constant binary_integer := 5;

  g_page_values utl_apex.page_value_t;
  g_collection_seq_id binary_integer;
  g_edit_sgr_row sct_rule_group%rowtype;
  g_edit_sru_row sct_rule%rowtype;
  g_edit_sra_row sct_rule_action%rowtype;
  g_edit_saa_row sct_ui_edit_saa%rowtype;
  g_edit_sat_row sct_ui_edit_sat%rowtype;
  g_edit_stg_row sct_action_type_group_v%rowtype;


  /** Helper to copy APEX session state values into type safe record structures
   * @usage  Is called to copy the actual session state values entered into a type safe record structure.
   *         Type casting is auto detected if APEX has knowledge of the type, fi by using a format mask.
   *         If this does not exist, it will try to find the type based on a fetch row process and a database column reference.
   */
  procedure copy_edit_sgr
  as
  begin
    pit.enter_detailed;
    g_page_values := utl_apex.get_page_values('EDIT_SGR_FORM');
    g_edit_sgr_row.sgr_id := to_number(utl_apex.get(g_page_values, 'SGR_ID'), '999990');
    g_edit_sgr_row.sgr_name := sct_util.clean_sct_name(utl_apex.get(g_page_values, 'SGR_NAME'));
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
    g_page_values := utl_apex.get_page_values('EDIT_SRU_FORM');
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
    l_param_name_1 sct_util.ora_name_type;
    l_param_name_2 sct_util.ora_name_type;
    l_param_name_3 sct_util.ora_name_type;
  begin
    pit.enter_detailed;
    g_page_values := utl_apex.get_page_values('EDIT_SRA_FORM');
    g_collection_seq_id := to_number(utl_apex.get(g_page_values, 'SEQ_ID'), '999990');
    g_edit_sra_row.sra_id := to_number(utl_apex.get(g_page_values, 'SRA_ID'), '999990');
    g_edit_sra_row.sra_sgr_id := to_number(utl_apex.get(g_page_values, 'SRA_SGR_ID'), '999990');
    g_edit_sra_row.sra_sru_id := to_number(utl_apex.get(g_page_values, 'SRA_SRU_ID'), '999990');
    g_edit_sra_row.sra_sort_seq := to_number(utl_apex.get(g_page_values, 'SRA_SORT_SEQ'), '999990');
    g_edit_sra_row.sra_spi_id := utl_apex.get(g_page_values, 'SRA_SPI_ID');
    g_edit_sra_row.sra_sat_id := utl_apex.get(g_page_values, 'SRA_SAT_ID');
    g_edit_sra_row.sra_active := utl_apex.get(g_page_values, 'SRA_ACTIVE');
    g_edit_sra_row.sra_on_error := utl_apex.get(g_page_values, 'SRA_ON_ERROR');
    g_edit_sra_row.sra_raise_recursive := utl_apex.get(g_page_values, 'SRA_RAISE_RECURSIVE');
    g_edit_sra_row.sra_comment := utl_apex.get(g_page_values, 'SRA_COMMENT');
    
    -- Get the required parameter field
    begin
      with data as (
           select sap_sat_id, sap_sort_seq, 
                  'SRA_PARAM_' ||
                  case spt_item_type
                    when 'TEXT' then null
                    when 'SELECT_LIST' then 'LOV_'
                    when 'TEXT_AREA' then 'AREA_'
                  end || sap_sort_seq item_name
             from sct_action_parameter
             join sct_action_param_type
               on sap_spt_id = spt_id)
      select max(decode(sap_sort_seq, 1, item_name)) item_name_1,
             max(decode(sap_sort_seq, 2, item_name)) item_name_2,
             max(decode(sap_sort_seq, 3, item_name)) item_name_3
        into l_param_name_1, l_param_name_2, l_param_name_3
        from data
       where sap_sat_id = g_edit_sra_row.sra_sat_id
       group by sap_sat_id;
    exception
      when no_data_found then
        null; -- No parameter for action type, ignore
    end;
     
    g_edit_sra_row.sra_param_1 := case when l_param_name_1 is not null then utl_apex.get(g_page_values, l_param_name_1) end;
    g_edit_sra_row.sra_param_2 := case when l_param_name_2 is not null then utl_apex.get(g_page_values, l_param_name_2) end;
    g_edit_sra_row.sra_param_3 := case when l_param_name_3 is not null then utl_apex.get(g_page_values, l_param_name_3) end;    

    pit.leave_detailed;
  end copy_edit_sra;


  procedure copy_edit_saa
  as
  begin
    pit.enter_detailed;
    
    g_page_values := utl_apex.get_page_values('EDIT_SAA_FORM');
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
    
    g_page_values := utl_apex.get_page_values('EDIT_SAT_FORM');
    g_edit_sat_row.sat_id := sct_util.clean_sct_name(utl_apex.get(g_page_values, 'SAT_ID'));
    g_edit_sat_row.sat_stg_id := sct_util.clean_sct_name(utl_apex.get(g_page_values, 'SAT_STG_ID'));
    g_edit_sat_row.sat_sif_id := sct_util.clean_sct_name(utl_apex.get(g_page_values, 'SAT_SIF_ID'));
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
    g_edit_sat_row.sap_spt_id_2 := utl_apex.get(g_page_values, 'SAP_SPT_ID_2');
    g_edit_sat_row.sap_display_name_2 := utl_apex.get(g_page_values, 'SAP_DISPLAY_NAME_2');
    g_edit_sat_row.sap_description_2 := utl_apex.get(g_page_values, 'SAP_DESCRIPTION_2');
    g_edit_sat_row.sap_spt_id_3 := utl_apex.get(g_page_values, 'SAP_SPT_ID_3');
    g_edit_sat_row.sap_display_name_3 := utl_apex.get(g_page_values, 'SAP_DISPLAY_NAME_3');
    g_edit_sat_row.sap_description_3 := utl_apex.get(g_page_values, 'SAP_DESCRIPTION_3');
    
    pit.leave_detailed;
  end copy_edit_sat;


  procedure copy_edit_stg
  as
  begin
    pit.enter_detailed('copy_edit_stg');
  
    g_page_values := utl_apex.get_page_values('EDIT_STG_FORM');
    g_edit_stg_row.stg_id := utl_apex.get(g_page_values, 'stg_id');
    g_edit_stg_row.stg_name := utl_apex.get(g_page_values, 'stg_name');
    g_edit_stg_row.stg_description := utl_apex.get(g_page_values, 'stg_description');
    g_edit_stg_row.stg_active := utl_apex.get(g_page_values, 'stg_active');
  
    pit.leave_detailed;
  end copy_edit_stg;


  /** Helper method to cast the collection type of the SAA collection to a record
   *  of type SCT_APEX_ACTION%ROWTYPE
   * %param  p_row  Instance of the collection
   * %param  p_rec  output record
   */
  procedure copy_row_to_saa_record(
    p_row in sct_ui_edit_saa%rowtype,
    p_rec out nocopy sct_apex_action%rowtype)
  as
  begin
    p_rec.saa_id := p_row.saa_id;
    p_rec.saa_sgr_id := p_row.saa_sgr_id;
    p_rec.saa_sty_id := p_row.saa_sty_id;
    p_rec.saa_name := p_row.saa_name;
    p_rec.saa_label := p_row.saa_label;
    p_rec.saa_context_label := p_row.saa_context_label;
    p_rec.saa_icon := p_row.saa_icon;
    p_rec.saa_icon_type := p_row.saa_icon_type;
    p_rec.saa_title := p_row.saa_title;
    p_rec.saa_shortcut := p_row.saa_shortcut;
    p_rec.saa_initially_disabled := p_row.saa_initially_disabled;
    p_rec.saa_initially_hidden := p_row.saa_initially_hidden;
    -- ACTION
    p_rec.saa_href := p_row.saa_href;
    p_rec.saa_action := p_row.saa_action;
    -- TOGGLE
    p_rec.saa_on_label := p_row.saa_on_label;
    p_rec.saa_off_label := p_row.saa_off_label;
    -- TOGGLE | RADIO_GROUP
    p_rec.saa_get := p_row.saa_get;
    p_rec.saa_set := p_row.saa_set;
    -- RADIO_GROUP
    p_rec.saa_choices := p_row.saa_choices;
    p_rec.saa_label_classes := p_row.saa_label_classes;
    p_rec.saa_label_start_classes := p_row.saa_label_start_classes;
    p_rec.saa_label_end_classes := p_row.saa_label_end_classes;
    p_rec.saa_item_wrap_class := p_row.saa_item_wrap_class;
  end copy_row_to_saa_record;


  /** Helper method to cast the collection type of the SRA collection to a record
   *  of type SCT_RULE_ACTION%ROWTYPE
   * %param  p_row  Instance of the collection
   * %param  p_rec  output record
   */
  procedure copy_row_to_sra_record(
    p_row in sct_ui_edit_sra%rowtype,
    p_rec out nocopy sct_rule_action%rowtype)
  as
  begin
    p_rec.sra_id := p_row.sra_id;
    p_rec.sra_sru_id := coalesce(p_row.sra_sru_id, g_edit_sru_row.sru_id);
    p_rec.sra_sgr_id := p_row.sra_sgr_id;
    p_rec.sra_spi_id := p_row.sra_spi_id;
    p_rec.sra_sat_id := p_row.sra_sat_id;
    p_rec.sra_sort_seq := p_row.sra_sort_seq;
    p_rec.sra_param_1 := p_row.sra_param_1;
    p_rec.sra_param_2 := p_row.sra_param_2;
    p_rec.sra_param_3 := p_row.sra_param_3;
    p_rec.sra_on_error := p_row.sra_on_error;
    p_rec.sra_raise_recursive := p_row.sra_raise_recursive;
    p_rec.sra_active := p_row.sra_active;
    p_rec.sra_comment := p_row.sra_comment;
  end copy_row_to_sra_record;
  
  
  /** Helper method to cast the complex view SCT_UI_EDIT_SAT to a record
   *  of type SCT_ACTION_TYPE%ROWTYPE
   * %param  p_row  Instance of the collection
   * %param  p_rec  output record
   */
  procedure copy_row_to_sat_record(
    p_row in sct_ui_edit_sat%rowtype,
    p_rec out nocopy sct_action_type_v%rowtype)
  as
  begin
    p_rec.sat_id := p_row.sat_id;
    p_rec.sat_stg_id := p_row.sat_stg_id;
    p_rec.sat_sif_id := p_row.sat_sif_id;
    p_rec.sat_name := p_row.sat_name;
    p_rec.sat_description := p_row.sat_description;
    p_rec.sat_pl_sql := p_row.sat_pl_sql;
    p_rec.sat_js := p_row.sat_js;
    p_rec.sat_is_editable := p_row.sat_is_editable;
    p_rec.sat_raise_recursive := p_row.sat_raise_recursive;
    p_rec.sat_active := p_row.sat_active;
  end copy_row_to_sat_record;
  
  
  /** Helper method to cast the complex view SCT_UI_EDIT_SAT to three record
   *  instances of type SCT_ACTION_PARAMETER_V%ROWTYPE
   * %param  p_row  Instance of the collection
   * %param  p_rec  output record
   */
  procedure copy_row_to_sap_records(
    p_row in sct_ui_edit_sat%rowtype,
    p_rec_1 out nocopy sct_action_parameter_v%rowtype,
    p_rec_2 out nocopy sct_action_parameter_v%rowtype,
    p_rec_3 out nocopy sct_action_parameter_v%rowtype)
  as
  begin
    -- Parameter 1
    p_rec_1.sap_sat_id := p_row.sat_id;
    p_rec_1.sap_spt_id := p_row.sap_spt_id_1;
    p_rec_1.sap_display_name := p_row.sap_display_name_1;
    p_rec_1.sap_description := p_row.sap_description_1;
    p_rec_1.sap_default := p_row.sap_default_1;
    p_rec_1.sap_mandatory := p_row.sap_mandatory_1;
    p_rec_1.sap_active := p_row.sap_active_1;
    p_rec_1.sap_sort_seq := 1;
    -- Parameter 2
    p_rec_2.sap_sat_id := p_row.sat_id;
    p_rec_2.sap_spt_id := p_row.sap_spt_id_2;
    p_rec_2.sap_display_name := p_row.sap_display_name_2;
    p_rec_2.sap_description := p_row.sap_description_2;
    p_rec_2.sap_default := p_row.sap_default_2;
    p_rec_2.sap_mandatory := p_row.sap_mandatory_2;
    p_rec_2.sap_active := p_row.sap_active_2;
    p_rec_2.sap_sort_seq := 2;
    -- Parameter 3
    p_rec_3.sap_sat_id := p_row.sat_id;
    p_rec_3.sap_spt_id := p_row.sap_spt_id_3;
    p_rec_3.sap_display_name := p_row.sap_display_name_3;
    p_rec_3.sap_description := p_row.sap_description_3;
    p_rec_3.sap_default := p_row.sap_default_3;
    p_rec_3.sap_mandatory := p_row.sap_mandatory_3;
    p_rec_3.sap_active := p_row.sap_active_3;
    p_rec_3.sap_sort_seq := 3;
  end copy_row_to_sap_records;
  

  /* INTERFACE */
  function get_pk
    return number
  as
  begin
    return sct.get_pk;
  end get_pk;
  
  
  function get_help_websheet_id
    return pls_integer
  as
    l_app_id pls_integer;
  begin
    pit.enter_mandatory;
    
    select application_id
      into l_app_id
      from apex_ws_applications
     where application_name = (select utl_apex.get_application_alias from dual);
     
    pit.leave_mandatory(msg_params(msg_param('ID', l_app_id)));
    return l_app_id;
  end get_help_websheet_id;
  
  
  procedure process_export_sgr
  as
    l_sgr_app_id sct_rule_group.sgr_app_id%type;
    l_sgr_page_id sct_rule_group.sgr_page_id%type;
    l_sgr_id sct_rule_group.sgr_id%type;
    l_mode sct_util.ora_name_type;
    l_zip_file_name sct_util.sql_char;
    l_zip_file blob;

    C_ZIP_SGR_FILE_NAME constant varchar2(100 byte) := 'single_rule_group_#SGR_ID#.zip';
    C_ZIP_PAGE_RULES_NAME constant sct_util.ora_name_type := 'app_#APP_ID#_page_#PAGE_ID#_rule_groups.zip';
    C_ZIP_APP_RULES_NAME constant sct_util.ora_name_type := 'application_#APP_ID#_rule_groups.zip';
    C_ZIP_ALL_RULES_NAME constant sct_util.ora_name_type := 'all_rule_groups.zip';
  begin
    pit.enter_mandatory;

    l_sgr_app_id := utl_apex.get_number('SGR_APP_ID');
    l_sgr_page_id := utl_apex.get_number('SGR_PAGE_ID');
    l_sgr_id := utl_apex.get_number('SGR_ID');

    -- map request to export mode and set zip file name accordingly
    case when utl_apex.request_is('EXPORT_SGR') then
      l_mode := sct_admin.C_ONE_GROUP;
      l_zip_file_name := replace(C_ZIP_SGR_FILE_NAME, '#APP_ID#', l_sgr_id);
    when utl_apex.request_is('EXPORT_PAGE') then
      l_mode := sct_admin.C_PAGE_GROUPS;
      l_zip_file_name := replace(C_ZIP_PAGE_RULES_NAME, '#APP_ID#', l_sgr_app_id);
    when utl_apex.request_is('EXPORT_APP') then
      l_mode := sct_admin.C_APP_GROUPS;
      l_zip_file_name := replace(C_ZIP_APP_RULES_NAME, '#APP_ID#', l_sgr_app_id);
    else
      l_mode := sct_admin.C_ALL_GROUPS;
      l_zip_file_name := C_ZIP_ALL_RULES_NAME;
    end case;

    -- generate ZIP with the requested rule group files and download.
    l_zip_file := sct_admin.export_rule_groups(
                    p_sgr_app_id => l_sgr_app_id,
                    p_sgr_page_id => l_sgr_page_id,
                    p_sgr_id => l_sgr_id,
                    p_mode => l_mode);
    utl_apex.download_blob(l_zip_file, l_zip_file_name);
    
    pit.leave_mandatory;
  end process_export_sgr;


  function get_export_type
    return varchar2
  as
    l_export_type sct_util.ora_name_type;
  begin
    pit.enter_detailed;

    case when utl_apex.get_value('SGR_ID') is not null then
      l_export_type := 'SGR';
    when utl_apex.get_value('SGR_PAGE_ID') is not null then
      l_export_type := 'PAGE';
    when utl_apex.get_value('SGR_APP_ID') is not null then
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
    l_sru_id := utl_apex.get_number('SRU_ID');

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
    end loop;

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
    
    l_sgr_id := utl_apex.get_number('SGR_ID');

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
    end loop;

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

    pit.start_message_collection;
    sct_admin.validate_rule_group(g_edit_sgr_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'SGR_APP_ID_MISSING', 'SGR_APP_ID',
        'SGR_PAGE_ID_MISSING', 'SGR_PAGE_ID',
        'SGR_NAME_MISSING', 'SGR_NAME',
        'SCT_SGR_MUST_BE_UNIQUE', 'SGR_NAME'));
        
    pit.leave_mandatory;
    return true;
  end validate_edit_sgr;
  
  
  /** Helper to extract apex actions maintenace from PROCESS_EDIT_SGR
   * %usage  APEX Actions are maintained using the collection API to allow for
   *         creation of APEX actions while the rule group does not yet exist (is created)
   *         This method harmonizes the entered APEX actions with the underlying table
   */
  procedure maintain_apex_actions
  as
    cursor missing_saa_cur (p_sgr_id in sct_rule_group.sgr_id%TYPE) is
      select saa_id
        from sct_apex_action
       where saa_sgr_id = p_sgr_id
         and saa_id not in (
             select saa_id
               from sct_ui_edit_saa);
               
    cursor saa_cur is
      select *
        from sct_ui_edit_saa;
        
    cursor existing_sai_cur(p_saa_id in sct_ui_edit_saa.saa_id%type) is
      select sai_saa_id
        from sct_apex_action_item
       where sai_saa_id = p_saa_id;
                
    cursor sai_cur (
      p_saa_id in sct_ui_edit_saa.saa_id%type,
      p_saa_sai_list in varchar2) 
    is
      select saa_id sai_saa_id, saa_sgr_id sai_spi_sgr_id, column_value sai_spi_id
        from sct_ui_edit_saa saa
       cross join table(utl_text.string_to_table(p_saa_sai_list))
       where saa_id = p_saa_id;
    l_saa_rec sct_apex_action%rowtype;
    l_sai_rec sct_apex_action_item%rowtype;
  begin
    pit.enter_mandatory;
    
    -- Remove deleted apex actions
    for saa in missing_saa_cur(g_edit_sgr_row.sgr_id) loop
      sct_admin.delete_apex_action(saa.saa_id);
    end loop;
    
    for saa in saa_cur loop
      copy_row_to_saa_record(saa, l_saa_rec);
      sct_admin.merge_apex_action(l_saa_rec);

      -- Copy data from Collection and merge into SCT_APEX_ACTION_ITEM
      for sai in existing_sai_cur(saa.saa_id) loop
        sct_admin.delete_apex_action_item(sai.sai_saa_id);
      end loop;
      
      for sai in sai_cur(saa.saa_id, saa.saa_sai_list) loop
        -- Copy row to record locally
        l_sai_rec.sai_saa_id := sai.sai_saa_id;
        l_sai_rec.sai_spi_sgr_id := sai.sai_spi_sgr_id;
        l_sai_rec.sai_spi_id := sai.sai_spi_id;
        
        sct_admin.merge_apex_action_item(l_sai_rec);
      end loop;
    end loop;
    
    pit.leave_mandatory;
  end maintain_apex_actions;


  procedure process_edit_sgr
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_sgr;

    case when utl_apex.inserting then
      sct_admin.merge_rule_group(g_edit_sgr_row);
    when utl_apex.updating then
      sct_admin.merge_rule_group(g_edit_sgr_row);
      -- APEX actions can be created after creation of the rule group only
      maintain_apex_actions;
    when utl_apex.deleting then
      sct_admin.delete_rule_group(g_edit_sgr_row);
    else
      pit.error(msg.UTL_INVALID_REQUEST, msg_args(utl_apex.get_request));
    end case;
    
    sct_admin.propagate_rule_change(g_edit_sgr_row.sgr_id);

    pit.leave_mandatory;
  end process_edit_sgr;


  function validate_edit_sru
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_sru;

    pit.start_message_collection;
    sct_admin.validate_rule(g_edit_sru_row);
    pit.stop_message_collection;

    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'SQL_ERROR', 'SRU_CONDITION',
        'SRU_CONDITION_MISSING', 'SRU_CONDITION',
        'SRU_SGR_ID_MISSING', 'SRU_SGR_ID',
        'SRU_NAME_MISSING', 'SRU_NAME'));
        
    pit.leave_mandatory;
    return true;
  end validate_edit_sru;


  procedure validate_rule
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_sru;

    pit.start_message_collection;
    sct_admin.validate_rule(g_edit_sru_row);
    pit.stop_message_collection;

    pit.leave_mandatory;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_sct.handle_bulk_errors(char_table(
        'SQL_ERROR', 'SRU_CONDITION',
        'SRU_CONDITION_MISSING', 'SRU_CONDITION',
        'SRU_SGR_ID_MISSING', 'SRU_SGR_ID',
        'SRU_NAME_MISSING', 'SRU_NAME'));
        
    pit.leave_mandatory;
  end validate_rule;
  
  
  /** Helper method to extract rule action maintenace from EDIT_SRU
   * %usage  Rule Actions are maintained using the collection API to allow for
   *         creation of rule actions while the rule does not yet exist (is created)
   *         This method harmonizes the entered rule actions with the underlying table
   */
  procedure maintain_rule_action
  as
    cursor missing_sra_cur is
      select sra_id
        from sct_rule_action
       where sra_sru_id = g_edit_sru_row.sru_id
         and sra_id not in (
             select sra_id
               from sct_ui_edit_sra);
               
    cursor sra_cur is
      select *
        from sct_ui_edit_sra;
    l_sra_rec sct_rule_action%rowtype;
  begin
    pit.enter_mandatory;
    
    for sra in missing_sra_cur loop
      sct_admin.delete_rule_action(sra.sra_id);
    end loop;
    
    for sra in sra_cur loop
      copy_row_to_sra_record(sra, l_sra_rec);
      sct_admin.merge_rule_action(l_sra_rec);
    end loop;
    
    pit.leave_mandatory;
  end maintain_rule_action;


  procedure process_edit_sru
  as
  begin
    pit.enter_mandatory;
    
    -- Initialization
    copy_edit_sru;
    
    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_rule(g_edit_sru_row);
      maintain_rule_action;      
    when utl_apex.deleting then
      sct_admin.delete_rule(g_edit_sru_row.sru_id);
    else
      utl_apex.unhandled_request;
    end case;
    
    sct_admin.propagate_rule_change(g_edit_sru_row.sru_sgr_id);
    
    pit.leave_mandatory;
  end process_edit_sru;


  procedure configure_edit_sra
  as
    C_SET_SAT_HELP constant varchar2(100) := q'^$('^R11_SAT_HELP .t-Region-body').html('#HELP_TEXT#');^';
    
    cursor action_type_cur(p_sat_id in sct_action_type.sat_id%type) is
        with params as(
             select sct_util.get_true is_active,
                    p_sat_id sat_id
               from dual)
      select /*+ no_merge (p) */
             sat.sat_id, sat_sif_id, sap_sort_seq, spt_id, spt_item_type,
             coalesce(sap_display_name, spt_name) spt_name
        from sct_action_type_v sat
        join params p
          on sat.sat_id = p.sat_id
         and sat_active = p.is_active
        left join sct_action_parameter_v
          on sat.sat_id = sap_sat_id
         and p.is_active = sap_active
        left join sct_action_param_type_v
          on sap_spt_id = spt_id
         and p.is_active = spt_active
       order by sat_id, sap_sort_seq;
       
    l_region_id sct_util.ora_name_type;
    l_lov_param_id sct_util.ora_name_type;
    l_item_id sct_util.ora_name_type;
    l_help_text sct_util.max_char;
    l_sat_id sct_action_type.sat_id%type;
    
    l_prefix sct_util.ora_name_type := utl_apex.get_page_prefix;
  begin
    pit.enter_mandatory;
    
    -- Initialize
    l_sat_id := utl_apex.get_value('SRA_SAT_ID');    
    utl_sct.hide_item(p_jquery_sel => '.sct-hide');
 --   utl_sct.empty_field(p_jquery_sel => '.sct-param');

    -- Adjust Parameter settings to show only required parameters in the correct format
    for param in action_type_cur(l_sat_id) loop
      l_region_id := 'R11_PARAMETER_' || param.sap_sort_seq;

      -- Show parameter region
      utl_sct.show_item(l_region_id);

      -- UI visibility and label of the parameter item
      case param.spt_item_type
      when 'SELECT_LIST' then
        l_lov_param_id := 'P11_LOV_PARAM_' || param.sap_sort_seq;
        l_item_id := 'P11_SRA_PARAM_LOV_' || param.sap_sort_seq;
        utl_sct.set_item(l_lov_param_id, param.spt_id);
        -- utl_sct.refresh_item(l_item_id);
      when 'TEXT_AREA' then
        l_item_id := 'P11_SRA_PARAM_AREA_' || param.sap_sort_seq;
      else
        l_item_id := 'P11_SRA_PARAM_' || param.sap_sort_seq;
      end case;

      utl_sct.show_item(l_item_id);        
      utl_sct.set_item_label(l_item_id, param.spt_name);
    end loop;

    -- Generate Help text for action type
    select apex_escape.json(help_text)
      into l_help_text
      from sct_bl_sat_help
     where sat_id = l_sat_id;
    utl_sct.java_script_code(replace(C_SET_SAT_HELP, '#HELP_TEXT#', l_help_text));

    pit.leave_mandatory;
  exception
    when NO_DATA_FOUND then
      -- no help found, generate generic help text
      utl_sct.java_script_code(replace(C_SET_SAT_HELP, '#HELP_TEXT#', sct_util.get_trans_item_name('SRA_NO_HELP')));
      
      pit.leave_mandatory;
  end configure_edit_sra;


  function validate_edit_sra
    return boolean
  as
    l_error varchar2(4000);
  begin
    pit.enter_mandatory;
    copy_edit_sra;

    pit.start_message_collection;
    sct_admin.validate_rule_action(g_edit_sra_row);
    pit.stop_message_collection;

    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'SRA_SRU_ID_MISSING', 'SRA_SRU_ID',
        'SRA_SGR_ID_MISSING', 'SRA_SGR_ID',
        'SRA_SPI_ID_MISSING', 'SRA_SPI_ID',
        'SRA_SAT_ID_MISSING', 'SRA_SAT_ID'));
        
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
    when utl_apex.updating then
      apex_collection.update_member(
        p_seq => g_collection_seq_id,
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
    when utl_apex.deleting then
      apex_collection.delete_member(
        p_seq => g_collection_seq_id,
        p_collection_name => C_SRA_COLLECTION);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end process_edit_sra;


  function validate_edit_sat
    return boolean
  as
    l_sat_rec sct_action_type_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_sat;

    pit.start_message_collection;
    copy_row_to_sat_record(g_edit_sat_row, l_sat_rec);
    sct_admin.validate_action_type(l_sat_rec);
    pit.stop_message_collection;

    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'SAT_ID_MISSING', 'SAT_ID',
        'SAT_STG_ID_MISSING', 'SAT_STG_ID',
        'SAT_SIF_ID_MISSING', 'SAT_SIF_ID',
        'SAT_NAME_MISSING', 'SAT_NAME'));
    
    pit.leave_mandatory;
    return true;
  end validate_edit_sat;


  procedure process_edit_sat
  as
    l_sat_rec sct_action_type_v%rowtype;
    l_sap_rec_1 sct_action_parameter_v%rowtype;
    l_sap_rec_2 sct_action_parameter_v%rowtype;
    l_sap_rec_3 sct_action_parameter_v%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_sat;

    copy_row_to_sat_record(g_edit_sat_row, l_sat_rec);
    copy_row_to_sap_records(g_edit_sat_row, l_sap_rec_1, l_sap_rec_2, l_sap_rec_3);

    case
    when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_action_type(l_sat_rec);

      if l_sap_rec_1.sap_spt_id is not null then
        sct_admin.merge_action_parameter(l_sap_rec_1);
      end if;

      if l_sap_rec_2.sap_spt_id is not null then
        sct_admin.merge_action_parameter(l_sap_rec_2);
      end if;

      if l_sap_rec_3.sap_spt_id is not null then
        sct_admin.merge_action_parameter(l_sap_rec_3);
      end if;

    when utl_apex.deleting then
      sct_admin.delete_action_type(l_sat_rec);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end process_edit_sat;


  procedure print_sat_help
  as
    l_help_text clob;
    l_sat_id utl_apex.ora_name_type;
  begin
    pit.enter_mandatory;
    
    l_sat_id := utl_apex.get_value('SAT_ID');

    select help_text
      into l_help_text
      from sct_bl_sat_help
     where sat_id = l_sat_id;

    htp.p(l_help_text);
    
    pit.enter_mandatory;
  exception
    when NO_DATA_FOUND then
      -- No SAT_ID given (fi upon creation), ignore
      pit.enter_mandatory;
  end print_sat_help;


  function validate_edit_saa
    return boolean
  as
    l_saa_rec sct_apex_action%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_edit_saa;
    
    copy_row_to_saa_record(g_edit_saa_row, l_saa_rec);
    
    pit.start_message_collection;
    sct_admin.validate_apex_action(l_saa_rec);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table(
        -- TODO: Error code mapping
        ));

      pit.leave_mandatory;
      return true;
  end validate_edit_saa;


  procedure process_edit_saa
  as
    l_saa_rec sct_apex_action%rowtype;
    l_saa_sai_list char_table;
  begin
    pit.enter_mandatory;
    
    copy_edit_saa;
    copy_row_to_saa_record(g_edit_saa_row, l_saa_rec);
    -- cast item list to CHAR_TABLE
    utl_text.string_to_table(g_edit_saa_row.saa_sai_list, l_saa_sai_list);
    
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
    
    pit.leave_mandatory;
  end process_edit_saa;
  
    
  function validate_edit_stg
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_stg;
    
    pit.start_message_collection;
    sct_admin.validate_action_type_group(g_edit_stg_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when others then
      utl_apex.handle_bulk_errors(char_table(
        'STG_ID_MISSING', 'STG_ID',
        'STG_NAME_MISSING', 'STG_NAME'
        ));
      return true;
  end validate_edit_stg;
  
  
  procedure process_edit_stg
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_stg;
    case when utl_apex.inserting or utl_apex.updating then
      sct_admin.merge_action_type_group(g_edit_stg_row);
    else
      sct_admin.delete_action_type_group(g_edit_stg_row);
    end case;
    
    pit.leave_mandatory;
  end process_edit_stg;


  function get_sru_sort_seq
    return number
  as
    l_sru_sort_seq sct_rule.sru_sort_seq%type;
    l_sgr_id sct_rule_group.sgr_id%type;
  begin
    pit.enter_mandatory;
    
    l_sgr_id := utl_apex.get_number('SRU_SGR_ID');

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
    
    l_sru_id := utl_apex.get_number('SRA_SRU_ID');
    l_sra_id := utl_apex.get_number('SRA_ID');

    begin
      select sra_sort_seq
        into l_sra_sort_seq
        from sct_ui_edit_sra
       where sra_id = l_sra_id;
    exception
      when NO_DATA_FOUND then
        select coalesce(max(trunc(sra_sort_seq, -1)) + 10, 10)
          into l_sra_sort_seq
          from sct_ui_edit_sra
         where sra_sru_id = l_sru_id;
    end;

    pit.leave_mandatory;
    return l_sra_sort_seq;
  end get_sra_sort_seq;


  procedure get_action_type_help
  as
    l_help_text sct_util.max_char;
    l_not_editable sct_util.ora_name_type;
  begin
    pit.enter_mandatory;
    
    l_not_editable := sct_util.get_trans_item_name('SAT_NOT_EDITABLE');

    with params as(
           select uttm_text template, uttm_mode
             from utl_text_templates
            where uttm_type = sct_util.C_SCT
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
    l_javascript sct_util.max_char;
  begin
    pit.enter_optional;

    l_sgr_id := utl_apex.get_number('SGR_ID');
    l_sgr_app_id := utl_apex.get_number('SGR_APP_ID');
    l_sgr_page_id := utl_apex.get_number('SGR_PAGE_ID');
    
    -- Action CREATE_RULE_GROUP
    utl_apex_action.action_init('create-rulegroup');
    l_javascript := utl_apex.get_page_url(
                      p_page => 'EDIT_SGR',
                      p_param_items => 'P6_SGR_APP_ID:P6_SGR_PAGE_ID',
                      p_value_items => 'P1_SGR_APP_ID:P1_SGR_PAGE_ID',
                      p_triggering_element => 'R1_RULE_GROUP',
                      p_clear_cache => C_PAGE_EDIT_SGR);
    utl_apex_action.set_action(l_javascript);
    utl_sct.java_script_code(utl_apex_action.get_action_script);

    -- Action CREATE_RULE
    utl_apex_action.action_init('create-rule');

    if l_sgr_id is not null then
      l_javascript := utl_apex.get_page_url(
                        p_page => 'EDIT_SRU',
                        p_param_items => 'P5_SRU_SGR_ID',
                        p_value_items => 'P1_SGR_ID',
                        p_triggering_element => 'R1_RULE_OVERVIEW',
                        p_clear_cache => C_PAGE_EDIT_SRU);
      utl_apex_action.set_action(l_javascript);
      utl_apex_action.set_disabled(false);
    else
      utl_apex_action.set_disabled(true);
    end if;

    utl_sct.java_script_code(utl_apex_action.get_action_script);

    -- Action EXPORT_RULEGROUP
    utl_apex_action.action_init('export-rulegroup');
    
    -- Es ist moeglich, dass eine SGR gewaehlt wurde, ohne die Anwendungsseite zu definieren
    -- In diesem Fall vor dem Export die PAGE_ID ermitteln, damit der Exportdialog korrekt arbeitet
    if l_sgr_id is not null and l_sgr_page_id is null then
      select sgr_page_id
        into l_sgr_page_id
        from sct_rule_group
       where sgr_id = l_sgr_id;
      utl_apex.set_value('P1_SGR_PAGE_ID', l_sgr_page_id);
    end if;

    l_javascript := utl_apex.get_page_url(
                      p_page => 'EXPORT_SGR',
                      p_param_items => 'P8_SGR_ID:P8_SGR_APP_ID:P8_SGR_PAGE_ID',
                      p_value_items => 'P1_SGR_ID:P1_SGR_APP_ID:P1_SGR_PAGE_ID',
                      p_triggering_element => 'B1_EXPORT_SGR');

    utl_apex_action.set_action(l_javascript);
    utl_sct.java_script_code(utl_apex_action.get_action_script);

    pit.leave_optional;
  end set_action_admin_sgr;


  procedure set_action_edit_sgr
  as
    l_javascript sct_util.max_char;
  begin
    pit.enter_optional;
    -- Intenionally left blank TODO: Implement
    pit.leave_optional;
  end set_action_edit_sgr;


  procedure set_action_export_sgr
  as
    l_sgr_app_id utl_apex.item_rec;
    l_sgr_page_id utl_apex.item_rec;
    l_sgr_id utl_apex.item_rec;
    l_export_type utl_apex.item_rec;
    l_sgr_name sct_rule_group.sgr_name%type;
    l_action varchar2(100);
    
    C_SUCCESS_COMMAND constant varchar2(100) := q'^apex.submit('EXPORT_#TYPE#');^';
  begin
    pit.enter_optional;
    
    -- Initialization
    l_sgr_app_id := utl_apex.get_page_element('SGR_APP_ID');
    l_sgr_page_id := utl_apex.get_page_element('SGR_PAGE_ID');
    l_sgr_id  := utl_apex.get_page_element('SGR_ID');
    l_export_type := utl_apex.get_page_element('EXPORT_TYPE');
    l_action := replace(C_SUCCESS_COMMAND, '#TYPE#', l_export_type.item_value);
    
    -- If select list values change, set dependent select lists to null and refresh
    case sct.get_firing_item
      when l_sgr_app_id.item_name then 
        -- application Id changed, reset and refresh page and sgr select lists
        l_sgr_page_id.item_value := null;
        utl_sct.empty_field(l_sgr_page_id.item_name);
        utl_sct.refresh_item(l_sgr_page_id.item_name);
        
        l_sgr_id.item_value := null;
        utl_sct.empty_field(l_sgr_id.item_name);
        utl_sct.refresh_item(l_sgr_id.item_name);   
      when l_sgr_page_id.item_name then
        -- page id changed, only reset and refresh sgr select list
        l_sgr_id.item_value := null;
        utl_sct.empty_field(l_sgr_id.item_name); 
        utl_sct.refresh_item(l_sgr_id.item_name);
      else
        null;
    end case;
    
    -- Show/Hide items based on export type
    utl_sct.show_hide_item('.sct-ui-export-' || lower(l_export_type.item_value), '.sct-ui-hide');

    -- harmonize apex action
    utl_apex_action.action_init('export-rulegroup');

    case l_export_type.item_value
      when 'SGR' then
        if l_sgr_id.item_value is not null then
          select sct_util.get_trans_item_name('SGR_EXPORT_LABEL_SGR', msg_args(sgr_name))
            into l_sgr_name
            from sct_rule_group
           where sgr_id = l_sgr_id.item_value;
          utl_apex_action.set_label(l_sgr_name);
          utl_apex_action.set_disabled(false);
          utl_apex_action.set_action(l_action);
        else
          utl_apex_action.set_label(sct_util.get_trans_item_name('SELECT_SGR'));
          utl_apex_action.set_disabled(true);
        end if;
      when 'PAGE' then
        if l_sgr_page_id.item_value is not null then
          utl_apex_action.set_label(sct_util.get_trans_item_name('SGR_EXPORT_LABEL_PAGE', msg_args(l_sgr_page_id.item_value)));
          utl_apex_action.set_disabled(false);
          utl_apex_action.set_action(l_action);
        else
          utl_apex_action.set_label(sct_util.get_trans_item_name('SELECT_PAGE'));
          utl_apex_action.set_disabled(true);
        end if;
      when 'APP' then
        if l_sgr_app_id.item_value is not null then
          utl_apex_action.set_label(sct_util.get_trans_item_name('SGR_EXPORT_LABEL_APP', msg_args(l_sgr_app_id.item_value)));
          utl_apex_action.set_disabled(false);
          utl_apex_action.set_action(l_action);
        else
          utl_apex_action.set_label(sct_util.get_trans_item_name('SELECT_APP'));
          utl_apex_action.set_disabled(true);
        end if;
      when 'ALL_SGR' then
        utl_apex_action.set_label(sct_util.get_trans_item_name('SGR_EXPORT_LABEL_ALL'));
        utl_apex_action.set_disabled(false);
        utl_apex_action.set_action(l_action);
      else
        utl_apex_action.set_action(null);
        utl_apex_action.set_disabled(true);
    end case;
    
    utl_sct.java_script_code(utl_apex_action.get_action_script);

    pit.leave_optional;
  exception
    when others then
      sct.register_error('DOCUMENT', sqlerrm, pit_util.get_call_stack);

      pit.leave_optional;
  end set_action_export_sgr;


  procedure set_action_edit_sru
  as
    l_javascript sct_util.max_char;
  begin
    pit.enter_optional;
    -- Intenionally left blank TODO: Implement
    pit.leave_optional;
  end set_action_edit_sru;

end sct_ui;
/