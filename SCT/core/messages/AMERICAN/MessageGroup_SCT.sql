begin
    
  pit_admin.merge_message_group(
    p_pmg_name => 'SCT',
    p_pmg_description => q'^SCT Plugin messages^');

  pit_admin.merge_message(
    p_pms_name => 'ALLG_PASS_INFORMATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'CONVERSION_IMPOSSIBLE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^A conversion could not be executed^',
    p_pms_description => q'^^',
    p_pms_pse_id => 20,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ACTION_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^SCT action #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_APP_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^APEX application #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_CLOB_JS_SCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_DEBUG_RULE_STMT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Rule SQL: "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_DYNAMIC_JAVASCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^#1#// Dynamically generated JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ERROR_HANDLING',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Error at #1#: #2# (#3#), Firing Item: "#4#", proceed with error actions^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_EXPECTED_FORMAT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Expected format "#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_GENERIC_ERROR',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^"#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INITIALZE_SGR_FAILED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Error during initialization of rule group #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INITIALZE_SRU_FAILED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Error during initialization of single rule #1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INIT_ORIGIN',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Rule #1# (#2#), fired on page load^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INTERNAL_ERROR',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^An error has occurred on the page: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_FORMAT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Invalid date. Expected format: "#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -1861);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Invalid number. Expected format: "#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_INVALID_NUMBER_REMOVED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Invalid number removed: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Page item "#1#" does not exist in application #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Page item "#1#" is mandatory. Please provide a valid value.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Exception when merging rule #1#: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_ACTION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Exception when merging rule action #1#: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_MERGE_RULE_GROUP',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Exception when merging rule group #1#: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_DATA_FOR_ITEM',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^No data found for "#1#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_EXPORT_DATA_FOUND',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^No data found for workspace "#1#" and alias "#2#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// No JavaScript code for rule "#1#"^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_JAVASCRIPT_ACTION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// No JavaScript action^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_NO_RULE_GROUP_FOUND',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^No data found for workspace #1# and application alias #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_ONE_ITEM_IS_MANDATORY',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Exactly one of the fields #1# and #2# is mandatory.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_OUTPUT_CLIPPED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^'// Further JavaScript action suppressed, because too long^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_OUTPUT_REDUCED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^'// Output reduced to level #1# due to length'^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^APEX page #1# does not exist in application #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_PAGE_HAS_ERRORS',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Page contains errors. Please solve open errors before submit.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_PROCESSING_RULE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Creating action for rule #1# (#2#)^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LIMIT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Page item "#1#" has exceeded recursion depth #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RECURSION_LOOP',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Page item "#1#" has created a recursion loop at depth #2# and was ignored.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_DOES_NOT_EXIST',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Rule #1# does not exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_ORIGIN',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Recursion #1#: #2# (#3#), Firing Item: "#4#", Duration: #TIME##NOTIFICATION#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VALIDATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Exception when validating rule #1#: #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_CREATED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Rule view "#1#" created.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_RULE_VIEW_DELETED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Rule view "#1#" deleted.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_SESSION_STATE_SET',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Page item "#1#" set to "#2#".^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_SGR_MUS_BE_UNIQUE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^The name of the rule group must be unique for this application.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_SGR_MUST_BE_UNIQUE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^The rule group already exists. Choose a unique name.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_STANDARD_JS',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^// Standard SCT JavaScript^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_TARGET_EQUALS_SOURCE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Rule group #1# is already installed at application #2#, page #3#. It can't be installed over itself.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNEXPECTED_CONV_TYPE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Unexpected item type "#1#" with format mask.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNHANDLED_EXCEPTION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Exception while executing "#1#", cannot continue work.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNKNOWN_SPT',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Unknown parameter type: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATED',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Rule group view "#1#" created succesfully.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'SCT_VIEW_CREATION',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Exception when creating rule group "#1#": #2#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_WHERE_CLAUSE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Exception when creating WHERE-clause: #SQLERRM#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SCT_UNKNOWN_EXPORT_MODE',
    p_pms_pmg_name => 'SCT',
    p_pms_text => q'^Export type #1# is unknown.^',
    p_pms_description => q'^An unsupported export type was requested. Only use the constants C_%_GROUP(S).^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/