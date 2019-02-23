begin

  pit_admin.merge_message_group(
    p_pmg_name => 'SCT',
    p_pmg_description => 'SCT Plugin messages');

  pit_admin.merge_message(
    p_pms_name => 'ALLG_PASS_INFORMATION',
    p_pms_text => q'~#1#~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );
  
  pit_admin.merge_message(
    p_pms_name => 'CONVERSION_IMPOSSIBLE',
    p_pms_text => q'~A conversion couldn't be computed~',
    p_pms_pse_id => 20,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INTERNAL_ERROR',
    p_pms_pmg_name => 'APEX',
    p_pms_text => q'~An internal error occurred: #SQLERRM#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_text => q'~APEX application #1# does not exist.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_ACTION_DOES_NOT_EXIST',
    p_pms_text => q'~SCT ction #1# does not exist.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_DYNAMIC_JAVASCRIPT',
    p_pms_text => q'~#1#  // Dynamically created JavaScript~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT_ACTION',
    p_pms_text => q'~// No JavaScript action~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_OUTPUT_REDUCED',
    p_pms_text => q'~'// Output reduced to level #1# because of length~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_OUTPUT_CLIPPED',
    p_pms_text => q'~'// Additional JavaScript skipped, too long~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_text => q'~// Error in recursion #1#, rule #2# (#3#), firing element: "#4#", proceeding with exception handling~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER_REMOVED',
    p_pms_text => q'~Invalid number removed: #1#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_text => q'~Expected format: ~#1#~.~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_GENERIC_ERROR',
    p_pms_text => q'~"#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INIT_ORIGIN',
    p_pms_text => q'~// Rule #1# (#2#), fired upon page initialization~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER',
    p_pms_text => q'~Invalid number. Expected format ~#1#~.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_DOES_NOT_EXIST',
    p_pms_text => q'~Page item #1# does not exist in application #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_text => q'~Item #1# is mandatory. Please enter a value.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE',
    p_pms_text => q'~Exception during merge of rule #1#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_ACTION',
    p_pms_text => q'~Exception during merge of rule action #1#, #2#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_GROUP',
    p_pms_text => q'~Exception during merge of rule group #1#: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_DATA_FOR_ITEM',
    p_pms_text => q'~No data found for #1#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_EXPORT_DATA_FOUND',
    p_pms_text => q'~No data for Workspace "#1#" and alias "#2#" found.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT',
    p_pms_text => q'~#2#  // No JavaScript code for rule "#1#"~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ONE_ITEM_IS_MANDATORY',
    p_pms_text => q'~Exactly one of items #1# and #2# must be specified.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_text => q'~APEX page #1# does not exist in application #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_HAS_ERRORS',
    p_pms_text => q'~Solve all issues on this page before submitting it.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_text => q'~Item #1# has exceeded max recursion depth of #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LOOP',
    p_pms_text => q'~Item #1# has caused a circular recursion at recursion #2# and was ignored.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_text => q'~Rule #1# does not exist.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_ORIGIN',
    p_pms_text => q'~// Recursion #1#: #2# (#3#), firing element: "#4#", duration: #TIME##NOTIFICATION#~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VALIDATION',
    p_pms_text => q'~Exception when validating rule #1#: #2#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_text => q'~Rule group view #1# created.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_text => q'~Rule group view #1# deleted.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_SESSION_STATE_SET',
    p_pms_text => q'~Item ~#1#~ was set to value ~#2#~~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_text => q'~Unexpected element type ~#1#~ with format mask.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNHANDLED_EXCEPTION',
    p_pms_text => q'~Exception when executing rule "#1#". Cannot proceed.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATED',
    p_pms_text => q'~Rule group #1# created.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_text => q'~Error when creating rule group view #1#: #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_WHERE_CLAUSE',
    p_pms_text => q'~Error when creating WHERE clause: #SQLERRM#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_pms_pmg_name => 'SCT',
    p_error_number => -20000
  );

  commit;
  pit_admin.create_message_package;
end;
/
