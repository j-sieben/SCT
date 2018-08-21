set define off
set sqlprefix off

begin
  code_generator.merge_template(
    p_cgtm_name => 'EXPORT_RULE_GROUP',
    p_cgtm_type => 'SCT',
    p_cgtm_mode => 'DEFAULT',
    p_cgtm_text => q'°\CR\°' || 
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
    p_cgtm_log_text => q'°Rule group #SGR_NAME# exported.°',
    p_cgtm_log_severity => 70
  );

  code_generator.merge_template(
    p_cgtm_name => 'EXPORT_RULE_GROUP',
    p_cgtm_type => 'SCT',
    p_cgtm_mode => 'RULE',
    p_cgtm_text => q'°\CR\°' || 
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
    p_cgtm_log_text => q'°°',
    p_cgtm_log_severity => 70
  );

  code_generator.merge_template(
    p_cgtm_name => 'EXPORT_RULE_GROUP',
    p_cgtm_type => 'SCT',
    p_cgtm_mode => 'RULE_ACTION',
    p_cgtm_text => q'°\CR\°' || 
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
    p_cgtm_log_text => q'°°',
    p_cgtm_log_severity => 70
  );

  code_generator.merge_template(
    p_cgtm_name => 'EXPORT_RULE_GROUP',
    p_cgtm_type => 'SCT',
    p_cgtm_mode => 'APEX_ACTION_ACTION',
    p_cgtm_text => q'°\CR\°' || 
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
q'°    p_saa_href => '#SAA_HREF#',\CR\°' || 
q'°    p_saa_action => '#SAA_ACTION#');\CR\°' || 
q'°°',
    p_cgtm_log_text => q'°°',
    p_cgtm_log_severity => 70
  );

  code_generator.merge_template(
    p_cgtm_name => 'EXPORT_RULE_GROUP',
    p_cgtm_type => 'SCT',
    p_cgtm_mode => 'APEX_ACTION_TOGGLE',
    p_cgtm_text => q'°\CR\°' || 
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
q'°    p_saa_href => '#SAA_HREF#',\CR\°' || 
q'°    p_saa_action => '#SAA_ACTION#',\CR\°' || 
q'°    p_saa_get => '#SAA_GET#',\CR\°' || 
q'°    p_saa_set => '#SAA_SET#');\CR\°' || 
q'°°',
    p_cgtm_log_text => q'°°',
    p_cgtm_log_severity => 70
  );

  code_generator.merge_template(
    p_cgtm_name => 'EXPORT_RULE_GROUP',
    p_cgtm_type => 'SCT',
    p_cgtm_mode => 'APEX_ACTION_RADIO_GROUP',
    p_cgtm_text => q'°\CR\°' || 
q'°  sct_admin.merge_apex_action(    \CR\°' || 
q'°    p_saa_sgr_id => sct_admin.map_id(#SGR_ID#),\CR\°' || 
q'°    p_saa_name => '#SAA_NAME#',\CR\°' || 
q'°    p_saa_type => '#SAA_TYPE#',\CR\°' || 
q'°    p_saa_label => '#SAA_LABEL#',\CR\°' || 
q'°    p_saa_context_label => '#SAA_CONTEXT_LABEL#',\CR\°' || 
q'°    p_saa_icon => '#SAA_ICON#',\CR\°' || 
q'°    p_saa_icon_type => '#SAA_ICON_TYPE#',\CR\°' || 
q'°    p_saa_title => '#SAA_TITLE#',\CR\°' || 
q'°    p_saa_href => '#SAA_HREF#',\CR\°' || 
q'°    p_saa_action => '#SAA_ACTION#',\CR\°' || 
q'°    p_saa_get => '#SAA_GET#',\CR\°' || 
q'°    p_saa_set => '#SAA_SET#',\CR\°' || 
q'°    p_saa_choices => '#SAA_CHOICES#',\CR\°' || 
q'°    p_saa_label_classes => '#SAA_LABEL_CLASSES#',\CR\°' || 
q'°    p_saa_label_start_classes => '#SAA_LABEL_START_CLASSES#',\CR\°' || 
q'°    p_saa_label_end_classes => '#SAA_LABEL_END_CLASSES#',\CR\°' || 
q'°    p_saa_item_wrap_class => '#SAA_ITEM_WRAP_CLASSES#');\CR\°' || 
q'°°',
    p_cgtm_log_text => q'°°',
    p_cgtm_log_severity => 70
  );
  commit;
end;
/
set define on
set sqlprefix on