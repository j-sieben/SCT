begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'SCT',
    p_pmg_description => q'^Meldungen für das SCT Plugin^');

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_SGR_ALL_SGR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^All Rule Groups^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_SGR_APP',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^All Rule Groups of an Application^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_SGR_PAGE',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^All Rule Groups of an Application Page^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LOV_EXPORT_SGR_SGR',
    p_pti_pml_name => q'^AMERICAN^',
    p_pti_pmg_name => q'^SCT^',
    p_pti_name => q'^One Rule Group^',
    p_pti_display_name => q'^^',
    p_pti_description => q'^^'
  );

  commit;
end;
/