begin
  param_admin.edit_parameter_group(
    p_pgr_id => 'SCT',
    p_pgr_description => 'Parameter des SCT Plugins',
    p_pgr_is_modifiable => true);

  param_admin.edit_parameter(
    p_par_id => 'RECURSION_LIMIT',
    p_par_pgr_id => 'SCT',
    p_par_description => 'Steuert die Rekursionstiefe die das Plugin maximal einnehmen darf',
    p_par_integer_value => 10,
    p_par_validation_string => '#NUMBER_VAL# between 1 and 100',
    p_par_validation_message => 'Der Wert muss zwischen 1 und 100 liegen');

  commit;
end;
/