begin

  param_admin.edit_parameter_group(
    p_pgr_id => 'SCT',
    p_pgr_description => 'Parameter des SCT Plugins',
    p_pgr_is_modifiable => true
  );

  param_admin.edit_parameter(
    p_par_id => 'RAISE_RECURSION_LOOP'
   ,p_par_pgr_id => 'SCT'
   ,p_par_description => 'Steuert, ob eine rekursive Schleife als Fehler geworfen oder nur benachrichtigt wird'   ,p_par_boolean_value => false   ,p_par_is_modifiable => null
  );

  param_admin.edit_parameter(
    p_par_id => 'RECURSION_LIMIT'
   ,p_par_pgr_id => 'SCT'
   ,p_par_description => 'Steuert die Rekursionstiefe die das Plugin maximal einnehmen darf'   ,p_par_integer_value => 10   ,p_par_boolean_value => null   ,p_par_is_modifiable => null   ,p_par_validation_string => q'^#NUMBER_VAL# between 1 and 100^'   ,p_par_validation_message => q'^Der Wert muss zwischen 1 und 100 liegen^'
  );

  commit;
end;
/