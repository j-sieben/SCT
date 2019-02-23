set define off

begin
  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'^\CR\^' || 
q'^set define ^\CR\^' || 
q'^\CR\^' || 
q'^declare\CR\^' || 
q'^  l_foo number;\CR\^' || 
q'^  l_app_id number;\CR\^' ||
q'^begin\CR\^' || 
q'^  l_foo := sct_admin.map_id;\CR\^' || 
q'^  l_app_id := coalesce(apex_application_install.get_application_id, ^APP_ID.);\CR\^' || 
q'^\CR\^' || 
q'^  dbms_output.put_line('&s1.Rulegroup #SGR_NAME#');\CR\^' || 
q'^\CR\^' || 
q'^  sct_admin.prepare_rule_group_import(\CR\^' || 
q'^    p_sgr_app_id => l_app_id,\CR\^' || 
q'^    p_sgr_page_id => #SGR_PAGE_ID#,\CR\^' || 
q'^    p_sgr_name => '#SGR_NAME#');\CR\^' || 
q'^\CR\^' || 
q'^  sct_admin.merge_rule_group(\CR\^' || 
q'^    p_sgr_id => sct_admin.map_id(#SGR_ID#),\CR\^' || 
q'^    p_sgr_name => '#SGR_NAME#',\CR\^' || 
q'^    p_sgr_description => q'|#SGR_DESCRIPTION#|',\CR\^' || 
q'^    p_sgr_app_id => l_app_id,\CR\^' || 
q'^    p_sgr_page_id => #SGR_PAGE_ID#,\CR\^' || 
q'^    p_sgr_with_recursion => #SGR_WITH_RECURSION#,\CR\^' || 
q'^    p_sgr_active => #SGR_ACTIVE#);\CR\^' || 
q'^  #RULES#\CR\^' || 
q'^  #APEX_ACTIONS#\CR\^' || 
q'^  sct_admin.propagate_rule_change(sct_admin.map_id(#SGR_ID#));\CR\^' || 
q'^\CR\^' || 
q'^  commit;\CR\^' || 
q'^end;\CR\^' || 
q'^/\CR\^' || 
q'^\CR\^' || 
q'^set define on\CR\^' || 
q'^^',
    p_uttm_log_text => q'^Rule group #SGR_NAME# exported.^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'RULE',
    p_uttm_text => q'^\CR\^' || 
q'^  sct_admin.merge_rule(\CR\^' || 
q'^    p_sru_id => sct_admin.map_id(#SRU_ID#),\CR\^' || 
q'^    p_sru_sgr_id => sct_admin.map_id(#SRU_SGR_ID#),\CR\^' || 
q'^    p_sru_name => '#SRU_NAME#',\CR\^' || 
q'^    p_sru_condition => q'|#SRU_CONDITION#|',\CR\^' || 
q'^    p_sru_sort_seq => #SRU_SORT_SEQ#,\CR\^' || 
q'^    p_sru_fire_on_page_load => #SRU_FIRE_ON_PAGE_LOAD#,\CR\^' || 
q'^    p_sru_active => #SRU_ACTIVE#);\CR\^' || 
q'^  #RULE_ACTIONS#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'RULE_ACTION',
    p_uttm_text => q'^\CR\^' || 
q'^  sct_admin.merge_rule_action(\CR\^' || 
q'^    p_sra_id => sct_admin.map_id(#SRA_ID#),\CR\^' ||
q'^    p_sra_sru_id => sct_admin.map_id(#SRA_SRU_ID#),\CR\^' || 
q'^    p_sra_sgr_id => sct_admin.map_id(#SRA_SGR_ID#),\CR\^' || 
q'^    p_sra_spi_id => '#SRA_SPI_ID#',\CR\^' || 
q'^    p_sra_sat_id => '#SRA_SAT_ID#',\CR\^' || 
q'^    p_sra_param_1 => q'|#SRA_PARAM_1#|',\CR\^' || 
q'^    p_sra_param_2 => q'|#SRA_PARAM_2#|',\CR\^' || 
q'^    p_sra_param_3 => q'|#SRA_PARAM_3#|',\CR\^' || 
q'^    p_sra_sort_seq => #SRA_SORT_SEQ#,\CR\^' || 
q'^    p_sra_on_error => #SRA_ON_ERROR#,\CR\^' || 
q'^    p_sra_raise_recursive => #SRA_RAISE_RECURSIVE#,\CR\^' || 
q'^    p_sra_active => #SRA_ACTIVE#);^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APEX_ACTION_ACTION',
    p_uttm_text => q'^\CR\^' || 
q'^  sct_admin.merge_apex_action(    \CR\^' || 
q'^    p_saa_id => sct_admin.map_id(#SAA_ID#),\CR\^' || 
q'^    p_saa_sgr_id => sct_admin.map_id(#SGR_ID#),\CR\^' || 
q'^    p_saa_sty_id => '#SAA_STY_ID#',\CR\^' || 
q'^    p_saa_name => '#SAA_NAME#',\CR\^' || 
q'^    p_saa_label => '#SAA_LABEL#',\CR\^' || 
q'^    p_saa_context_label => '#SAA_CONTEXT_LABEL#',\CR\^' || 
q'^    p_saa_icon => '#SAA_ICON#',\CR\^' || 
q'^    p_saa_icon_type => '#SAA_ICON_TYPE#',\CR\^' || 
q'^    p_saa_title => '#SAA_TITLE#',\CR\^' || 
q'^    p_saa_shortcut => '#SAA_SHORTCUT#',\CR\^' ||
q'^    p_saa_initially_disabled => #SAA_INITIALLY_DISABLED#,\CR\^' || 
q'^    p_saa_initially_hidden => #SAA_INITIALLY_HIDDEN#,\CR\^' || 
q'^    p_saa_href => '#SAA_HREF#',\CR\^' || 
q'^    p_saa_action => '#SAA_ACTION#');\CR\^' || 
q'^  #APEX_ACTION_ITEMS#\CR\^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APEX_ACTION_TOGGLE',
    p_uttm_text => q'^\CR\^' || 
q'^  sct_admin.merge_apex_action(    \CR\^' || 
q'^    p_saa_id => sct_admin.map_id(#SAA_ID#),\CR\^' || 
q'^    p_saa_sgr_id => sct_admin.map_id(#SGR_ID#),\CR\^' || 
q'^    p_saa_name => '#SAA_NAME#',\CR\^' || 
q'^    p_saa_type => '#SAA_TYPE#',\CR\^' || 
q'^    p_saa_label => '#SAA_LABEL#',\CR\^' || 
q'^    p_saa_on_label => '#SAA_ON_LABEL#',\CR\^' || 
q'^    p_saa_off_label => '#SAA_OFF_LABEL#',\CR\^' || 
q'^    p_saa_context_label => '#SAA_CONTEXT_LABEL#',\CR\^' || 
q'^    p_saa_icon => '#SAA_ICON#',\CR\^' || 
q'^    p_saa_icon_type => '#SAA_ICON_TYPE#',\CR\^' || 
q'^    p_saa_title => '#SAA_TITLE#',\CR\^' || 
q'^    p_saa_shortcut => '#SAA_SHORTCUT#',\CR\^' || 
q'^    p_saa_initially_disabled => '#SAA_INITIALLY_DISABLED#',\CR\^' || 
q'^    p_saa_initially_hidden => '#SAA_INITIALLY_HIDDEN#',\CR\^' ||
q'^    p_saa_href => '#SAA_HREF#',\CR\^' || 
q'^    p_saa_action => '#SAA_ACTION#',\CR\^' || 
q'^    p_saa_get => '#SAA_GET#',\CR\^' || 
q'^    p_saa_set => '#SAA_SET#');\CR\^' || 
q'^  #APEX_ACTION_ITEMS#\CR\^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APEX_ACTION_RADIO_GROUP',
    p_uttm_text => q'^\CR\^' || 
q'^  sct_admin.merge_apex_action(    \CR\^' || 
q'^    p_saa_id => sct_admin.map_id(#SAA_ID#),\CR\^' || 
q'^    p_saa_sgr_id => sct_admin.map_id(#SGR_ID#),\CR\^' || 
q'^    p_saa_sty_id => '#SAA_STY_ID#',\CR\^' || 
q'^    p_saa_name => '#SAA_NAME#',\CR\^' || 
q'^    p_saa_label => '#SAA_LABEL#',\CR\^' || 
q'^    p_saa_context_label => '#SAA_CONTEXT_LABEL#',\CR\^' || 
q'^    p_saa_icon => '#SAA_ICON#',\CR\^' || 
q'^    p_saa_icon_type => '#SAA_ICON_TYPE#',\CR\^' || 
q'^    p_saa_title => '#SAA_TITLE#',\CR\^' || 
q'^    p_saa_href => '#SAA_HREF#',\CR\^' || 
q'^    p_saa_action => '#SAA_ACTION#',\CR\^' || 
q'^    p_saa_initially_disabled => '#SAA_INITIALLY_DISABLED#',\CR\^' || 
q'^    p_saa_initially_hidden => '#SAA_INITIALLY_HIDDEN#',\CR\^' ||
q'^    p_saa_get => '#SAA_GET#',\CR\^' || 
q'^    p_saa_set => '#SAA_SET#',\CR\^' || 
q'^    p_saa_choices => '#SAA_CHOICES#',\CR\^' || 
q'^    p_saa_label_classes => '#SAA_LABEL_CLASSES#',\CR\^' || 
q'^    p_saa_label_start_classes => '#SAA_LABEL_START_CLASSES#',\CR\^' || 
q'^    p_saa_label_end_classes => '#SAA_LABEL_END_CLASSES#',\CR\^' || 
q'^    p_saa_item_wrap_class => '#SAA_ITEM_WRAP_CLASSES#');\CR\^' || 
q'^  #APEX_ACTION_ITEMS#\CR\^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APEX_ACTION_ITEM',
    p_uttm_text => q'^\CR\^' || 
q'^  sct_admin.merge_apex_action_item(\CR\^' || 
q'^    p_sai_saa_id => sct_admin.map_id(#SAI_SAA_ID#),\CR\^' || 
q'^    p_sai_spi_sgr_id => sct_admin.map_id(#SAI_SPI_SGR_ID#),\CR\^' || 
q'^    p_sai_spi_id => '#SAI_SPI_ID#',\CR\^' || 
q'^    p_sai_active => #SAI_ACTIVE#);\CR\^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  

  utl_text.merge_template(
    p_uttm_name => 'RULE_VIEW',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'^create or replace force view #PREFIX##SGR_ID# as\CR\^' || 
q'^  with session_state as(\CR\^' || 
q'^       select #COLUMN_LIST#,\CR\^' || 
q'^              sct_util.get_true is_true,\CR\^' || 
q'^              sct_util.get_false is_false\CR\^' || 
q'^         from dual),\CR\^' || 
q'^       data as (\CR\^' || 
q'^       select /*+ NO_MERGE(s) */\CR\^' || 
q'^              r.sru_id, r.sru_name, r.sru_firing_items, r.sru_fire_on_page_load,\CR\^' || 
q'^              r.sra_spi_id, r.sra_sat_id, r.sra_param_1, r.sra_param_2, r.sra_param_3, r.sra_on_error, r.sra_raise_recursive, r.sra_sort_seq,\CR\^' || 
q'^              rank() over (order by r.sru_sort_seq) rang, case s.initializing when 1 then s.is_true else s.is_false end initializing\CR\^' || 
q'^         from sct_bl_rules r\CR\^' || 
q'^         join session_state s\CR\^' || 
q'^           on instr(r.sru_firing_items, ',' || s.firing_item || ',') > 0\CR\^' || 
q'^           or sru_fire_on_page_load = s.is_true\CR\^' || 
q'^        where r.sgr_id = #SGR_ID#\CR\^' || 
q'^          and (#WHERE_CLAUSE#))\CR\^' || 
q'^select sru_id, sru_name, sra_spi_id, sra_sat_id, sra_param_1, sra_param_2, sra_param_3, sra_on_error, sra_raise_recursive, sra_sort_seq\CR\^' || 
q'^  from data\CR\^' || 
q'^ where rang = 1\CR\^' || 
q'^    or sru_fire_on_page_load = initializing\CR\^' || 
q'^ order by sru_fire_on_page_load, rang^',
    p_uttm_log_text => q'^Rule View #PREFIX##SGR_ID# created.^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'RULE_VALIDATION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'^  with session_state as(\CR\^' || 
q'^       select #COLUMN_LIST#\CR\^' || 
q'^         from dual)\CR\^' || 
q'^select *\CR\^' || 
q'^  from session_state\CR\^' || 
q'^ where #CONDITION#^',
    p_uttm_log_text => q'^Rule View #PREFIX##SGR_ID# validated.^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'RULE_VIEW',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'WHERE_CLAUSE',
    p_uttm_text => q'^(r.sru_id = #SRU_ID# and (#SRU_CONDITION#))^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ITEM',
    p_uttm_text => q'^v('#ITEM#') #ITEM#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ITEM',
    p_uttm_text => q'^itm.#ITEM#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'NUMBER_ITEM',
    p_uttm_text => q'^to_number(v('#ITEM#'), '#CONVERSION#') #ITEM#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'NUMBER_ITEM',
    p_uttm_text => q'^to_char(itm.#ITEM#, '#CONVERSION#')^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DATE_ITEM',
    p_uttm_text => q'^to_date(v('#ITEM#'), '#CONVERSION#') #ITEM#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DATE_ITEM',
    p_uttm_text => q'^to_char(to_date(itm.#ITEM#), '#CONVERSION#')^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APP_ITEM',
    p_uttm_text => q'^v('#ITEM#') #ITEM#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APP_ITEM',
    p_uttm_text => q'^itm.#ITEM#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'BUTTON',
    p_uttm_text => q'^case plugin_sct.get_firing_item when '#ITEM#' then 1 else 0 end #ITEM#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'BUTTON',
    p_uttm_text => q'^null^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'REGION',
    p_uttm_text => q'^null #ITEM#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'REGION',
    p_uttm_text => q'^null^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DOCUMENT',
    p_uttm_text => q'^null #ITEM#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DOCUMENT',
    p_uttm_text => q'^null^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
    
  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'^set define off\CR\^' || 
q'^set sqlblanklines on\CR\^' || 
q'^\CR\^' || 
q'^begin\CR\^' || 
q'^  #ACTION_PARAM_TYPES#\CR\^' || 
q'^  #ACTION_ITEM_FOCUS#\CR\^' || 
q'^  #ACTION_TYPE_GROUPS#\CR\^' || 
q'^  #ACTION_TYPES#\CR\^' || 
q'^  commit;\CR\^' || 
q'^end;\CR\^' || 
q'^/\CR\^' || 
q'^\CR\^' || 
q'^set define on\CR\^' || 
q'^set sqlblanklines off^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ACTION_TYPE',
    p_uttm_text => q'^  sct_admin.merge_action_type(\CR\^' || 
q'^    p_sat_id => '#SAT_ID#',\CR\^' || 
q'^    p_sat_stg_id => '#SAT_STG_ID#',\CR\^' || 
q'^    p_sat_sif_id => '#SAT_SIF_ID#',\CR\^' || 
q'^    p_sat_name => '#SAT_NAME#',\CR\^' || 
q'^    p_sat_description => #SAT_DESCRIPTION#,\CR\^' || 
q'^    p_sat_pl_sql => #SAT_PL_SQL#,\CR\^' || 
q'^    p_sat_js => #SAT_JS#,\CR\^' || 
q'^    p_sat_is_editable => #SAT_IS_EDITABLE#,\CR\^' || 
q'^    p_sat_raise_recursive => #SAT_RAISE_RECURSIVE#);\CR\^' || 
q'^\CR\^' || 
q'^  #RULE_ACTION_PARAMS#^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'PARAM_TYPE',
    p_uttm_text => q'^  sct_admin.merge_action_param_type(\CR\^' || 
q'^    p_spt_id => '#SPT_ID#',\CR\^' || 
q'^    p_spt_name => '#SPT_NAME#',\CR\^' || 
q'^    p_spt_description => #SPT_DESCRIPTION#,\CR\^' || 
q'^    p_spt_active => #SPT_ACTIVE#);\CR\^' || 
q'^^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  ); 
  
  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ITEM_FOCUS',
    p_uttm_text => q'^  sct_admin.merge_action_item_focus(\CR\^' || 
q'^    p_sif_id => '#SIF_ID#',\CR\^' || 
q'^    p_sif_name => '#SIF_NAME#',\CR\^' || 
q'^    p_sif_description => #SIF_DESCRIPTION#,\CR\^' || 
q'^    p_sif_active => #SIF_ACTIVE#);\CR\^' || 
q'^^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  ); 
  
  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ACTION_PARAMS',
    p_uttm_text => q'^  sct_admin.merge_action_parameter(\CR\^' || 
q'^    p_sap_sat_id => '#SAP_SAT_ID#',\CR\^' || 
q'^    p_sap_spt_id => '#SAP_SPT_ID#',\CR\^' || 
q'^    p_sap_sort_seq => #SAP_SORT_SEQ#,\CR\^' || 
q'^    p_sap_default => #SAP_DEFAULT#,\CR\^' || 
q'^    p_sap_description => #SAP_DESCRIPTION#,\CR\^' || 
q'^    p_sap_display_name => '#SAP_DISPLAY_NAME#',\CR\^' || 
q'^    p_sap_mandatory => #SAP_MANDATORY#,\CR\^' || 
q'^    p_sap_active => #SAP_ACTIVE#);\CR\^' || 
q'^^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'EXPORT_ACTION_TYPE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ACTION_TYPE_GROUP',
    p_uttm_text => q'^  sct_admin.merge_action_type_group(\CR\^' || 
q'^    p_stg_id => '#STG_ID#',\CR\^' || 
q'^    p_stg_name => '#STG_NAME#',\CR\^' || 
q'^    p_stg_description => #STG_DESCRIPTION#,\CR\^' || 
q'^    p_stg_active => #STG_ACTIVE#);\CR\^' || 
q'^^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  
  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'^declare\CR\^' || 
q'^  cursor item_cur is\CR\^' || 
q'^    #SQL_STMT#;\CR\^' || 
q'^begin\CR\^' || 
q'^  for itm in item_cur loop\CR\^' || 
q'^    #ITEM_STMT#\CR\^' || 
q'^  end loop;\CR\^' || 
q'^end;^',
    p_uttm_log_text => q'^Initialization code for rule group #SGR_ID# created.^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ROWID',
    p_uttm_text => q'^select rowid, v.*\CR\^' || 
q'^  from #ATTRIBUTE_02# v\CR\^' || 
q'^ where #ATTRIBUTE_04# = (select v('#ATTRIBUTE_03#') from dual)^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'^select *\CR\^' || 
q'^  from #ATTRIBUTE_02# v\CR\^' || 
q'^ where #ATTRIBUTE_04# = (select v('#ATTRIBUTE_03#') from dual)^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'VALUE',
    p_uttm_text => q'^apex_util.set_session_state('#ITEM#', #ITEM_SOURCE#);^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'PAGE_ITEM_ERROR',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'^<p>Regelgruppe "#SGR_NAME#" kann nicht exportiert werden:</p><ul>#ERROR_LIST#</ul>^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'PAGE_ITEM_ERROR',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'^<li>#SIT_NAME# "#SPI_ID#" existiert in Anwendung #SGR_APP_ID# nicht</li>^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'^// Integration von APEX-Actions\CR\^' || 
q'^#BIND_ACTION_ITEMS#\CR\^' || 
q'^\CR\^' || 
q'^apex.actions.add(\CR\^' || 
q'^  [#ACTION_LIST#\CR\^' || 
q'^  ]);^',
    p_uttm_log_text => q'^APEX actions created^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'BUTTON',
    p_uttm_text => q'^$('##SPI_ID#').removeClass('js-actionButton').addClass('js-actionButton').attr('data-action', '#SAA_NAME#');^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
    utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ACTION',
    p_uttm_text => q'^{"name":"#SAA_NAME#"^' || 
q'^#SAA_LABEL|,^CR^"label":"|"|#^' || 
q'^#SAA_CONTEXT_LABEL|,^CR^"contextLabel":"|"|#^' || 
q'^#SAA_ICON|,^CR^"icon":"|"|#^' || 
q'^#SAA_ICON_TYPE|,^CR^"iconType":"|"|#^' || 
q'^#SAA_INITIALLY_DISABLED|,^CR^"disabled":||#^' || 
q'^#SAA_INITIALLY_HIDDEN|,^CR^"hide":||#^' || 
q'^#SAA_TITLE|,^CR^"title":"|^SAA_SHORTCUT~ (~)~^"|#^' || 
q'^#SAA_SHORTCUT|,^CR^"shortcut":"|"|#^' || 
q'^#SAA_HREF|,^CR^"href":"|"|#^' || 
q'^#SAA_ACTION|,^CR^"action":"|"|#}^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'TOGGLE',
    p_uttm_text => q'^{"action":\CR\^' || 
q'^  {"name":"#SAA_NAME#",\CR\^' || 
q'^   "#LABEL_KEY#":"#SAA_LABEL#",\CR\^' || 
q'^   "#ON_LABEL_KEY#":"#SAA_ON_LABEL#",\CR\^' || 
q'^   "#OFF_LABEL_KEY#":"#SAA_OFF_LABEL#",\CR\^' || 
q'^   "contextLabel":"#SAA_CONTEXT_LABEL#",\CR\^' || 
q'^   "icon":"#SAA_ICON#",\CR\^' || 
q'^   "iconType":"#SAA_ICON_TYPE#",\CR\^' || 
q'^   "disabled":"#SAA_INITIALLY_DISABLED#",\CR\^' || 
q'^   "hide":"#SAA_INITIALLY_HIDDEN#",\CR\^' || 
q'^   "title":"#SAA_TITLE#",\CR\^' || 
q'^   "shortcut":"#SAA_SHORTCUT#",\CR\^' || 
q'^   "get":"#SAA_GET#",\CR\^' || 
q'^   "set":"#SAA_SET#",\CR\^' || 
q'^  }\CR\^' || 
q'^}^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'RADIO_GROUP',
    p_uttm_text => q'^{"action":\CR\^' || 
q'^  {"name":"#SAA_NAME#",\CR\^' || 
q'^   "#LABEL_KEY#":"#SAA_LABEL#",\CR\^' || 
q'^   "contextLabel":"#SAA_CONTEXT_LABEL#",\CR\^' || 
q'^   "icon":"#SAA_ICON#",\CR\^' || 
q'^   "iconType":"#SAA_ICON_TYPE#",\CR\^' || 
q'^   "disabled":"#SAA_INITIALLY_DISABLED#",\CR\^' || 
q'^   "hide":"#SAA_INITIALLY_HIDDEN#",\CR\^' || 
q'^   "title":"#SAA_TITLE#",\CR\^' || 
q'^   "shortcut":"#SAA_SHORTCUT#",\CR\^' || 
q'^   "get":"#SAA_GET#",\CR\^' || 
q'^   "set":"#SAA_SET#",\CR\^' || 
q'^   "choices":[#SAA_CHOICES#],\CR\^' || 
q'^   "labelClasses":"#SAA_LABEL_CLASSES#",\CR\^' || 
q'^   "labelStartClasses":"#SAA_LABEL_START_CLASSES#",\CR\^' || 
q'^   "labelEndClasses":"#SAA_LABEL_END_CLASSES#",\CR\^' || 
q'^   "itemWrapClasses":"#SAA_ITEM_WRAP_CLASS#",\CR\^' || 
q'^  }\CR\^' || 
q'^}^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'RADIO_GROUP_CHOICE',
    p_uttm_text => q'^{#RG_LABEL_KEY#:"#RG_LABEL#",\CR\^' || 
q'^ "value":"#RG_VALUE#",\CR\^' ||  
q'^ "icon":"#RG_ICON#",\CR\^' || 
q'^ "iconType":"#RG_ICON_TYPE#",\CR\^' || 
q'^ "disabled":"#RG_INITIALLY_DISABLED#",\CR\^' ||
q'^ "shortcut":"#RG_SHORTCUT#"#RG_GROUP|,^CR^"group":"|^"|#\CR\^' || 
q'^}^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'JSON_ERRORS',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'^{"count":#ERROR_COUNT#,"errorDependentItems":"#DEPENDENT_ITEMS#","firingItems":"#FIRING_ITEMS#","errors":[#JSON_ERRORS#]}^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'JSON_ERRORS',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ERROR',
    p_uttm_text => q'^{"type":"error","item":"#PAGE_ITEM#","message":"#MESSAGE#","location":#LOCATION#,"additionalInfo":"#ADDITIONAL_INFO#","unsafe":"false"}^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'RULE_STMT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'^  with params as (\CR\^' || 
q'^       select sct_util.get_true is_true,
                 sct_util.get_false is_false
            from dual)\CR\^' || 
q'^select /*+ no_merge(p) */sru.sru_id, sru.sru_sort_seq, sru.sru_name, sru.sru_firing_items, sru_fire_on_page_load,\CR\^' || 
q'^       sra_spi_id item, sat_pl_sql pl_sql, sat_js js, sra_param_1 param_1, sra_param_2 param_2, sra_param_3 param_3, sra_on_error,\CR\^' || 
q'^       max(sra_on_error) over (partition by sru_sort_seq) sru_on_error,\CR\^' || 
q'^       case row_number() over (partition by sru_sort_seq, sra_on_error order by srg.sra_sort_seq) when 1 then is_true else is_false end is_first_row\CR\^' || 
q'^  from #RULE_VIEW# srg\CR\^' || 
q'^  join sct_rule sru\CR\^' || 
q'^    on srg.sru_id = sru.sru_id\CR\^' || 
q'^  join sct_action_type sat\CR\^' || 
q'^    on srg.sra_sat_id = sat.sat_id\CR\^' || 
q'^ cross join params p\CR\^' || 
q'^ where sat.sat_raise_recursive in (is_true, '#IS_RECURSIVE#')\CR\^' || 
q'^   and srg.sra_raise_recursive in (is_true, '#IS_RECURSIVE#')\CR\^' || 
q'^ order by sru.sru_sort_seq desc, srg.sra_sort_seq^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'ACTION_TYPE_HELP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'^'<h2>#SAT_NAME#</h2><div>#SAT_DESCRIPTION#</div>#PARAMETERS|<h3>Parameter:</h3><div><dl>|</dl></div>#'^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'ACTION_TYPE_HELP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'PARAMETERS',
    p_uttm_text => q'^<dt>#SPT_NAME#</dt><dd>#SAP_DESCRIPTION##SPT_DESCRIPTION#</dd>^',
    p_uttm_log_text => q'^^',
    p_uttm_log_severity => 70
  );
  
  commit;
end;
/
set define on