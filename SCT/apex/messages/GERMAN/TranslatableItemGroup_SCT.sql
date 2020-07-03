begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'SCT',
    p_pmg_description => q'^Meldungen für das SCT Plugin^');

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_SGR_ALL_SGR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Alle Regelgruppen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_SGR_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Alle Regelgruppen einer Anwendung^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_SGR_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Alle Regelgruppen einer Anwendungsseite^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_SGR_SGR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Eine Regelgruppe^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Anwendung wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Anwendungsseite wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SELECT_SGR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Regelgruppe wählen^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  

  pit_admin.merge_translatable_item(
    p_pti_id => 'SGR_EXPORT_LABEL_ALL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Alle Regelgruppen exportieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SGR_EXPORT_LABEL_APP',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Regelgruppen der Anwendung "#1#" exportieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SGR_EXPORT_LABEL_PAGE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Regelgruppen der Anwendungsseite "#1#" exportieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SGR_EXPORT_LABEL_SGR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Regelgruppe "#1#" exportieren^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'SGR_REGION_HEADING',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^Regelübersicht »#1#« (#2#)^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );
  
  commit;
end;
/