begin

  pit_admin.merge_message_group(
    p_pmg_name => 'SCT',
    p_pmg_description => 'SCT Plugin messages');

  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~APEX application #1# does not exist.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Expected format "#1#".~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_GENERIC_ERROR',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~"#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_CLOB_JS_SCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => '#1#',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN'
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_FORMAT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Invalid date. Expected format: "#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1861
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Invalid number. Expected format: "#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Page item "#1#" does not exist in application #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Page item "#1#" is mandatory. Please provide a valid value.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~APEX page #1# does not exist in application #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_HAS_ERRORS',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Page contains errors. Please solve open errors before submit.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Page item "#1#" has exceeded recursion depth #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LOOP',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Page item "#1#" has created a recursion loop at depth #2# and was ignored.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Rule #1# does not exist.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VALIDATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Exception when validating rule #1#: #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Rule view "#1#" created.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Rule view "#1#" deleted.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_SESSION_STATE_SET',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Page item "#1#" set to "#2#".~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Unexpected item type "#1#" with format mask.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Rule group view "#1#" created succesfully.~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Exception when creating rule group "#1#": #2#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_DATA_FOR_ITEM',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~No data found for "#1#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SCT_WHERE_CLAUSE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Exception when creating WHERE-clause: #SQLERRM#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_GROUP',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Exception when merging rule group #1#: #SQLERRM#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Exception when merging rule #1#: #SQLERRM#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_ACTION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Exception when merging rule action #1#: #SQLERRM#.~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_EXPORT_DATA_FOUND',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~No data found for workspace "#1#" and alias "#2#".~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN'
  );
  
  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// No JavaScript code for rule "#1#"^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_DYNAMIC_JAVASCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Dynamically created JavaScript^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_INIT_ORIGIN',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Rule #1# (#2#), fired on page load~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_ORIGIN',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Recursion #1#: #2# (#3#), Firing Item: "#4#"~',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Error at #1#: #2# (#3#), Firing Item: "#4#", proceed with error actions~',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_STANDARD_JS',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~// Standard-SCT JavaScript~',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN');
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_INITIALZE_SGR_FAILED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Error during initialization of rule group #1#: #2#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN'
  );
    
  pit_admin.merge_message(
    p_pms_name => 'SCT_INITIALZE_SRU_FAILED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'~Error during initialization of single rule #1#: #2#~',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN'
  );
    
  commit;
  pit_admin.create_message_package;
end;
/