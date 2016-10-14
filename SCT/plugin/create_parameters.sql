begin
  param_admin.edit_parameter_group(
    p_parameter_group_id => 'SCT',
    p_group_description => 'Parameter des SCT Plugins',
    p_is_modifiable => 'Y');
    
  param_admin.edit_parameter(
    p_parameter_id => 'RECURSION_LIMIT',
    p_parameter_group_id => 'SCT',
	  p_parameter_description => 'Steuert die Rekursionstiefe die das Plugin maximal einnehmen darf',
    p_integer_value => 10,
    p_validation_string => '#NUMBER_VAL# between 1 and 100',
    p_validation_message => 'Der Wert muss zwischen 1 und 100 liegen');
    
end;
/