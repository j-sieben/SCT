begin

  pit_admin.merge_translatable_item(
    p_pti_id => 'FAULTY_ERROR_MESSAGE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'SCT',
    p_pti_name => 'Fehlerhafte Meldung');
    
  pit_admin.merge_translatable_item(
    p_pti_id => 'INVALID_ERROR_MESSAGE',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'SCT',
    p_pti_name => 'Ungültige Fehlermeldung');
  
  commit;
end;
/