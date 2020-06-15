begin
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_ELEMENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'SCT',
    p_pti_name => 'Element');
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_PAGE_ELEMENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'SCT',
    p_pti_name => 'Seitenelement');
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_BUTTON',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'SCT',
    p_pti_name => 'Schaltfläche');
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_REGION',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'SCT',
    p_pti_name => 'Region');
  
  pit_admin.merge_translatable_item(
    p_pti_id => 'ITEM_TYPE_DOCUMENT',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'SCT',
    p_pti_name => 'Dokument');
    
  commit;
end;
/