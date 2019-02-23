begin

  pit_admin.merge_translatable_item(
    p_pti_id => 'FAULTY_ERROR_MESSAGE',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'SCT',
    p_pti_name => 'Faulty error message');
    
  pit_admin.merge_translatable_item(
    p_pti_id => 'INVALID_ERROR_MESSAGE',
    p_pti_pml_name => 'AMERICAN',
    p_pti_pmg_name => 'SCT',
    p_pti_name => 'Invalid error message');
  
  commit;
end;
/