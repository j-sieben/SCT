set define off

begin
  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'°\CR\°' || 
q'°begin\CR\°' || 
q'°  dbms_output.put_line('&s1.Rulegroup #SGR_NAME#');\CR\°' || 
q'°  sct_admin.merge_rule_group(\CR\°' || 
q'°    p_sgr_id => sct_admin.map_id(#SGR_ID#),\CR\°' || 
q'°    p_sgr_name => '#SGR_NAME#',\CR\°' || 
q'°    p_sgr_description => q'|#SGR_DESCRIPTION#|',\CR\°' || 
q'°    p_sgr_app_id => coalesce(apex_application_install.get_application_id, &APP_ID.),\CR\°' || 
q'°    p_sgr_page_id => #SGR_PAGE_ID#,\CR\°' || 
q'°    p_sgr_with_recursion => #SGR_WITH_RECURSION#,\CR\°' || 
q'°    p_sgr_active => #SGR_ACTIVE#);\CR\°' || 
q'°  #RULES#\CR\°' || 
q'°  #APEX_ACTIONS#\CR\°' || 
q'°  commit;\CR\°' || 
q'°end;\CR\°' || 
q'°/°',
    p_uttm_log_text => q'°Rule group #SGR_NAME# exported.°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'RULE',
    p_uttm_text => q'°\CR\°' || 
q'°  sct_admin.merge_rule(\CR\°' || 
q'°    p_sru_id => sct_admin.map_id(#SRU_ID#),\CR\°' || 
q'°    p_sru_sgr_id => sct_admin.map_id(#SRU_SGR_ID#),\CR\°' || 
q'°    p_sru_name => '#SRU_NAME#',\CR\°' || 
q'°    p_sru_condition => q'|#SRU_CONDITION#|',\CR\°' || 
q'°    p_sru_sort_seq => #SRU_SORT_SEQ#,\CR\°' || 
q'°    p_sru_fire_on_page_load => #SRU_FIRE_ON_PAGE_LOAD#,\CR\°' || 
q'°    p_sru_active => #SRU_ACTIVE#);\CR\°' || 
q'°\CR\°' || 
q'°  #RULE_ACTIONS#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'RULE_ACTION',
    p_uttm_text => q'°\CR\°' || 
q'°  sct_admin.merge_rule_action(\CR\°' || 
q'°    p_sra_sru_id => sct_admin.map_id(#SRA_SRU_ID#),\CR\°' || 
q'°    p_sra_sgr_id => sct_admin.map_id(#SRA_SGR_ID#),\CR\°' || 
q'°    p_sra_spi_id => '#SRA_SPI_ID#',\CR\°' || 
q'°    p_sra_sat_id => '#SRA_SAT_ID#',\CR\°' || 
q'°    p_sra_attribute => q'|#SRA_ATTRIBUTE#|',\CR\°' || 
q'°    p_sra_attribute_2 => q'|#SRA_ATTRIBUTE_2#|',\CR\°' || 
q'°    p_sra_sort_seq => #SRA_SORT_SEQ#,\CR\°' || 
q'°    p_sra_on_error => #SRA_ON_ERROR#,\CR\°' || 
q'°    p_sra_raise_recursive => #SRA_RAISE_RECURSIVE#,\CR\°' || 
q'°    p_sra_active => #SRA_ACTIVE#);°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APEX_ACTION_ACTION',
    p_uttm_text => q'°\CR\°' || 
q'°  sct_admin.merge_apex_action(    \CR\°' || 
q'°    p_saa_sgr_id => sct_admin.map_id(#SGR_ID#),\CR\°' || 
q'°    p_saa_name => '#SAA_NAME#',\CR\°' || 
q'°    p_saa_type => '#SAA_TYPE#',\CR\°' || 
q'°    p_saa_label => '#SAA_LABEL#',\CR\°' || 
q'°    p_saa_context_label => '#SAA_CONTEXT_LABEL#',\CR\°' || 
q'°    p_saa_icon => '#SAA_ICON#',\CR\°' || 
q'°    p_saa_icon_type => '#SAA_ICON_TYPE#',\CR\°' || 
q'°    p_saa_title => '#SAA_TITLE#',\CR\°' || 
q'°    p_saa_shortcut => '#SAA_SHORTCUT#',\CR\°' ||
q'°    p_saa_initially_disabled => '#SAA_INITIALLY_DISABLED#',\CR\°' || 
q'°    p_saa_initially_hidden => '#SAA_INITIALLY_HIDDEN#',\CR\°' || 
q'°    p_saa_href => '#SAA_HREF#',\CR\°' || 
q'°    p_saa_action => '#SAA_ACTION#');\CR\°' || 
q'°°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APEX_ACTION_TOGGLE',
    p_uttm_text => q'°\CR\°' || 
q'°  sct_admin.merge_apex_action(    \CR\°' || 
q'°    p_saa_sgr_id => sct_admin.map_id(#SGR_ID#),\CR\°' || 
q'°    p_saa_name => '#SAA_NAME#',\CR\°' || 
q'°    p_saa_type => '#SAA_TYPE#',\CR\°' || 
q'°    p_saa_label => '#SAA_LABEL#',\CR\°' || 
q'°    p_saa_on_label => '#SAA_ON_LABEL#',\CR\°' || 
q'°    p_saa_off_label => '#SAA_OFF_LABEL#',\CR\°' || 
q'°    p_saa_context_label => '#SAA_CONTEXT_LABEL#',\CR\°' || 
q'°    p_saa_icon => '#SAA_ICON#',\CR\°' || 
q'°    p_saa_icon_type => '#SAA_ICON_TYPE#',\CR\°' || 
q'°    p_saa_title => '#SAA_TITLE#',\CR\°' || 
q'°    p_saa_shortcut => '#SAA_SHORTCUT#',\CR\°' || 
q'°    p_saa_initially_disabled => '#SAA_INITIALLY_DISABLED#',\CR\°' || 
q'°    p_saa_initially_hidden => '#SAA_INITIALLY_HIDDEN#',\CR\°' ||
q'°    p_saa_href => '#SAA_HREF#',\CR\°' || 
q'°    p_saa_action => '#SAA_ACTION#',\CR\°' || 
q'°    p_saa_get => '#SAA_GET#',\CR\°' || 
q'°    p_saa_set => '#SAA_SET#');\CR\°' || 
q'°°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'EXPORT_RULE_GROUP',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APEX_ACTION_RADIO_GROUP',
    p_uttm_text => q'°\CR\°' || 
q'°  sct_admin.merge_apex_action(    \CR\°' || 
q'°    p_saa_sgr_id => sct_admin.map_id(#SGR_ID#),\CR\°' || 
q'°    p_saa_sty_id => '#SAA_STY_ID#',\CR\°' || 
q'°    p_saa_name => '#SAA_NAME#',\CR\°' || 
q'°    p_saa_label => '#SAA_LABEL#',\CR\°' || 
q'°    p_saa_context_label => '#SAA_CONTEXT_LABEL#',\CR\°' || 
q'°    p_saa_icon => '#SAA_ICON#',\CR\°' || 
q'°    p_saa_icon_type => '#SAA_ICON_TYPE#',\CR\°' || 
q'°    p_saa_title => '#SAA_TITLE#',\CR\°' || 
q'°    p_saa_href => '#SAA_HREF#',\CR\°' || 
q'°    p_saa_action => '#SAA_ACTION#',\CR\°' || 
q'°    p_saa_initially_disabled => '#SAA_INITIALLY_DISABLED#',\CR\°' || 
q'°    p_saa_initially_hidden => '#SAA_INITIALLY_HIDDEN#',\CR\°' ||
q'°    p_saa_get => '#SAA_GET#',\CR\°' || 
q'°    p_saa_set => '#SAA_SET#',\CR\°' || 
q'°    p_saa_choices => '#SAA_CHOICES#',\CR\°' || 
q'°    p_saa_label_classes => '#SAA_LABEL_CLASSES#',\CR\°' || 
q'°    p_saa_label_start_classes => '#SAA_LABEL_START_CLASSES#',\CR\°' || 
q'°    p_saa_label_end_classes => '#SAA_LABEL_END_CLASSES#',\CR\°' || 
q'°    p_saa_item_wrap_class => '#SAA_ITEM_WRAP_CLASSES#');\CR\°' || 
q'°°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'RULE_VIEW',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'°create or replace force view #PREFIX##SGR_ID# as\CR\°' || 
q'°  with session_state as(\CR\°' || 
q'°       select bl_sct.get_firing_item firing_item,\CR\°' || 
q'°              case bl_sct.get_firing_item when 'DOCUMENT' then 1 else 0 end initializing,\CR\°' || 
q'°              #COLUMN_LIST#\CR\°' || 
q'°         from dual),\CR\°' || 
q'°       data as (\CR\°' || 
q'°       select /*+ NO_MERGE(s) */\CR\°' || 
q'°              r.sru_id, r.sru_name, r.sru_firing_items, r.sru_fire_on_page_load,\CR\°' || 
q'°              r.sra_spi_id, r.sra_sat_id, r.sra_attribute, r.sra_attribute_2, r.sra_on_error, r.sra_raise_recursive, r.sra_sort_seq,\CR\°' || 
q'°              rank() over (order by r.sru_sort_seq) rang, s.initializing\CR\°' || 
q'°         from sct_bl_rules r\CR\°' || 
q'°         join session_state s\CR\°' || 
q'°           on (instr(r.sru_firing_items, ',' || s.firing_item || ',') > 0 or sru_fire_on_page_load = 1)\CR\°' || 
q'°        where r.sgr_id = #SGR_ID#\CR\°' || 
q'°          and (#WHERE_CLAUSE#))\CR\°' || 
q'°select sru_id, sru_name, sra_spi_id, sra_sat_id, sra_attribute, sra_attribute_2, sra_on_error, sra_raise_recursive, sra_sort_seq\CR\°' || 
q'°  from data\CR\°' || 
q'° where rang = 1 or sru_fire_on_page_load = initializing\CR\°' || 
q'° order by sru_fire_on_page_load desc, rang°',
    p_uttm_log_text => q'°Rule View #PREFIX##SGR_ID# created.°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'RULE_VALIDATION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'°  with session_state as(\CR\°' || 
q'°       select null firing_item,\CR\°' || 
q'°              null initializing\CR\°' || 
q'°              #COLUMN_LIST#\CR\°' || 
q'°         from dual)\CR\°' || 
q'°select *\CR\°' || 
q'°  from session_state\CR\°' || 
q'° where #CONDITION#°',
    p_uttm_log_text => q'°Rule View #PREFIX##SGR_ID# validated.°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'RULE_VIEW',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'JOIN_CLAUSE',
    p_uttm_text => q'°(r.sru_id = #SRU_ID# and ((#SRU_CONDITION#) or sru_fire_on_page_load = initializing))°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ITEM',
    p_uttm_text => q'°v('#ITEM#') #ITEM#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ITEM',
    p_uttm_text => q'°itm.#ITEM#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'NUMBER_ITEM',
    p_uttm_text => q'°to_number(v('#ITEM#'), '#CONVERSION#') #ITEM#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'NUMBER_ITEM',
    p_uttm_text => q'°to_char(itm.#ITEM#, '#CONVERSION#')°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DATE_ITEM',
    p_uttm_text => q'°to_date(v('#ITEM#'), '#CONVERSION#') #ITEM#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DATE_ITEM',
    p_uttm_text => q'°to_char(to_date(itm.#ITEM#), '#CONVERSION#')°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APP_ITEM',
    p_uttm_text => q'°v('#ITEM#') #ITEM#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'APP_ITEM',
    p_uttm_text => q'°itm.#ITEM#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'BUTTON',
    p_uttm_text => q'°case bl_sct.get_firing_item when '#ITEM#' then 1 else 0 end #ITEM#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'BUTTON',
    p_uttm_text => q'°null°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'REGION',
    p_uttm_text => q'°null #ITEM#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'REGION',
    p_uttm_text => q'°null°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_ITEM',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DOCUMENT',
    p_uttm_text => q'°null #ITEM#°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );

  utl_text.merge_template(
    p_uttm_name => 'VIEW_INIT',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DOCUMENT',
    p_uttm_text => q'°null°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
    
  utl_text.merge_template(
    p_uttm_name => 'ACTION_TYPE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'°set define off\CR\°' || 
q'°set sqlblanklines on\CR\°' || 
q'°\CR\°' || 
q'°begin\CR\°' || 
q'°  #ACTION_TYPES#\CR\°' || 
q'°  commit;\CR\°' || 
q'°end;\CR\°' || 
q'°/\CR\°' || 
q'°\CR\°' || 
q'°set define on\CR\°' || 
q'°set sqlblanklines off°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'ACTION_TYPE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'°  sct_admin.merge_action_type(\CR\°' || 
q'°    p_sat_id => '#SAT_ID#',\CR\°' || 
q'°    p_sat_name => '#SAT_NAME#',\CR\°' || 
q'°    p_sat_description => q'~#SAT_DESCRIPTION#~',\CR\°' || 
q'°    p_sat_pl_sql => q'~#SAT_PL_SQL#~',\CR\°' || 
q'°    p_sat_js => q'~#SAT_JS#~',\CR\°' || 
q'°    p_sat_is_editable => #SAT_IS_EDITABLE#,\CR\°' || 
q'°    p_sat_raise_recursive => #SAT_RAISE_RECURSIVE#);\CR\°' || 
q'°°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'°declare\CR\°' || 
q'°  cursor item_cur is\CR\°' || 
q'°    #SQL_STMT#;\CR\°' || 
q'°begin\CR\°' || 
q'°  for itm in item_cur loop\CR\°' || 
q'°    #ITEM_STMT#\CR\°' || 
q'°  end loop;\CR\°' || 
q'°end;°',
    p_uttm_log_text => q'°Initialization code for rule group #SGR_ID# created.°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ROWID',
    p_uttm_text => q'°select rowid, v.*\CR\°' || 
q'°  from #ATTRIBUTE_02# v\CR\°' || 
q'° where #ATTRIBUTE_04# = (select v('#ATTRIBUTE_03#') from dual)°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'°select *\CR\°' || 
q'°  from #ATTRIBUTE_02# v\CR\°' || 
q'° where #ATTRIBUTE_04# = (select v('#ATTRIBUTE_03#') from dual)°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'INITIALIZE_CODE',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'VALUE',
    p_uttm_text => q'°apex_util.set_session_state('#ITEM#', #ITEM_SOURCE#);°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'PAGE_ITEM_ERROR',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'°<p>Regelgruppe "#SGR_NAME#" kann nicht exportiert werden:</p><ul>#ERROR_LIST#</ul>°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'PAGE_ITEM_ERROR',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'DEFAULT',
    p_uttm_text => q'°<li>#SIT_NAME# "#SPI_ID#" existiert in Anwendung #SGR_APP_ID# nicht</li>°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'FRAME',
    p_uttm_text => q'°apex.actions.add(\CR\°' || 
q'°[#ACTION_LIST#\CR\°' || 
q'°]);°',
    p_uttm_log_text => q'°APEX actions created°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'ACTION',
    p_uttm_text => q'°{"action":\CR\°' || 
q'°  {"name":"#SAA_NAME#",\CR\°' || 
q'°   "#LABEL_KEY#":"#SAA_LABEL#",\CR\°' || 
q'°   "contextLabel":"#SAA_CONTEXT_LABEL#",\CR\°' || 
q'°   "icon":"#SAA_ICON#",\CR\°' || 
q'°   "iconType":"#SAA_ICON_TYPE#",\CR\°' || 
q'°   "disabled":"#SAA_INITIALLY_DISABLED#",\CR\°' || 
q'°   "hide":"#SAA_INITIALLY_HIDDEN#",\CR\°' || 
q'°   "title":"#SAA_TITLE#",\CR\°' || 
q'°   "shortcut":"#SAA_SHORTCUT#",\CR\°' || 
q'°   #SAA_HREF|"href:""|"|##SAA_ACTION|"action":"|"|#\CR\°' || 
q'°   #SAA_HREF_NOOP|"href_noop:""|"|null##SAA_ACTION_HREF|"action_href":"|"|null#\CR\°' || 
q'°  }\CR\°' || 
q'°}°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'TOGGLE',
    p_uttm_text => q'°{"action":\CR\°' || 
q'°  {"name":"#SAA_NAME#",\CR\°' || 
q'°   "#LABEL_KEY#":"#SAA_LABEL#",\CR\°' || 
q'°   "#ON_LABEL_KEY#":"#SAA_ON_LABEL#",\CR\°' || 
q'°   "#OFF_LABEL_KEY#":"#SAA_OFF_LABEL#",\CR\°' || 
q'°   "contextLabel":"#SAA_CONTEXT_LABEL#",\CR\°' || 
q'°   "icon":"#SAA_ICON#",\CR\°' || 
q'°   "iconType":"#SAA_ICON_TYPE#",\CR\°' || 
q'°   "disabled":"#SAA_INITIALLY_DISABLED#",\CR\°' || 
q'°   "hide":"#SAA_INITIALLY_HIDDEN#",\CR\°' || 
q'°   "title":"#SAA_TITLE#",\CR\°' || 
q'°   "shortcut":"#SAA_SHORTCUT#",\CR\°' || 
q'°   "get":"#SAA_GET#",\CR\°' || 
q'°   "set":"#SAA_SET#",\CR\°' || 
q'°  }\CR\°' || 
q'°}°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'RADIO_GROUP',
    p_uttm_text => q'°{"action":\CR\°' || 
q'°  {"name":"#SAA_NAME#",\CR\°' || 
q'°   "#LABEL_KEY#":"#SAA_LABEL#",\CR\°' || 
q'°   "contextLabel":"#SAA_CONTEXT_LABEL#",\CR\°' || 
q'°   "icon":"#SAA_ICON#",\CR\°' || 
q'°   "iconType":"#SAA_ICON_TYPE#",\CR\°' || 
q'°   "disabled":"#SAA_INITIALLY_DISABLED#",\CR\°' || 
q'°   "hide":"#SAA_INITIALLY_HIDDEN#",\CR\°' || 
q'°   "title":"#SAA_TITLE#",\CR\°' || 
q'°   "shortcut":"#SAA_SHORTCUT#",\CR\°' || 
q'°   "get":"#SAA_GET#",\CR\°' || 
q'°   "set":"#SAA_SET#",\CR\°' || 
q'°   "choices":[#SAA_CHOICES#],\CR\°' || 
q'°   "labelClasses":"#SAA_LABEL_CLASSES#",\CR\°' || 
q'°   "labelStartClasses":"#SAA_LABEL_START_CLASSES#",\CR\°' || 
q'°   "labelEndClasses":"#SAA_LABEL_END_CLASSES#",\CR\°' || 
q'°   "itemWrapClasses":"#SAA_ITEM_WRAP_CLASS#",\CR\°' || 
q'°  }\CR\°' || 
q'°}°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  utl_text.merge_template(
    p_uttm_name => 'APEX_ACTION',
    p_uttm_type => 'SCT',
    p_uttm_mode => 'RADIO_GROUP_CHOICE',
    p_uttm_text => q'°{#RG_LABEL_KEY#:"#RG_LABEL#",\CR\°' || 
q'° "value":"#RG_VALUE#",\CR\°' ||  
q'° "icon":"#RG_ICON#",\CR\°' || 
q'° "iconType":"#RG_ICON_TYPE#",\CR\°' || 
q'° "disabled":"#RG_INITIALLY_DISABLED#",\CR\°' ||
q'° "shortcut":"#RG_SHORTCUT#"#RG_GROUP|,^CR^"group":"|^"|#\CR\°' || 
q'°}°',
    p_uttm_log_text => q'°°',
    p_uttm_log_severity => 70
  );
  
  commit;
end;
/
set define on