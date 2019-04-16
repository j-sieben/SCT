create or replace package sct_ui_pkg
  authid definer
as

  /** Maintain SCT rules via an APEX frontend
   * @author Juergen Sieben, ConDeS GmbH
   * @headcom
   * @usage  This package implements the methods required to maintain SCT rule groups via an APEX application
   */
   
  /* Getter/Setter */
  
  /** Method to adjust rule group region headers
   * @return String that is set as the new region header
   */
  function set_rule_overview_heading
    return varchar2;


  /** Method to copy a rule group to a different application or application page
   * @usage  Is used after an APEX application has been copiued to a different ID within the same workspace
   *         to copy all rule groups to the newly created application
   */
  procedure copy_sgr;
    
  
  /** Method to export one or many rule groups as a zip or clob file to the application page as download
   */
  procedure process_export_sgr;
  
  /** Method to calculate the initial export state based on session state settings
   * @return One of the states ALL|APP|SGR
   */
  function get_export_type
    return varchar2;
  
  
  /* Methode zum Validieren der Seite EDIT_GROUP
   */
  function validate_edit_sgr
    return boolean;
    
  /** Method to process user data from page EDIT_SGR
   */
  procedure process_edit_sgr;
  
  
  /** Method toi initialize an APEX collection for SRA (SCT Rule Actions)
   * @usage  Is called upon initialization of page EDIT_SRU to copy existing rule actions to an APEX collection.
   *         Required to capture new rule actions without  saving them to the target table directly
   */
  procedure initialize_sra_collection;
  
  
  /** Method to initialize an APEX collection for SAA (SCT APEX Action)
   * @usage  Is called upon initialization of page EDIT_SGR to copy existing rule actions to an APEX collection.
   *         Required to capture new rule actions without  saving them to the target table directly
   */
  procedure initialize_saa_collection;
  
  
  /** Method to validate a rule condition
   * @usage  Is called to validate a rule condition.
   *         Register any error with the SCT error stack.
   */
  procedure validate_rule;
  
  
  /** Method to validate page EDIT_SRU
   * @usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_sru
    return boolean;
    
  /** Method to process page EDIT_SRU
   * @usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_sru;
  
  
  /** Method to prepare or update page EDIT_SRA based on Action Type selection
   * @usage  Is called if relevant changes are reported to SCT
   */
  procedure configure_edit_sra;
  
  
  /** Method to validate page EDIT_SRA
   * @usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_sra
    return boolean;
    
  /** Method to process page EDIT_SRA
   * @usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_sra;
  
  
  /** Method to validate page EDIT_SAT
   * @usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_sat
    return boolean;
    
  /** Method to process page EDIT_SAT
   * @usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_sat;
  
  
  /** Method to print SAT help text to help region
   * @usage  Is called to dynamically show the help text for a given SAT
   */
  procedure print_sat_help;
  
  
  /** Method to validate page EDIT_SAA
   * @usage  Is called to validate user data if the page is submitted
   */
  function validate_edit_saa
    return boolean;
    
  /** Method to process page EDIT_SAA
   * @usage  Is called to process user data if the page is submitted
   */
  procedure process_edit_saa;
    

  /** Helper to calculate the next sort sequence number for a Rule
   * %return Next sort sequence value
   * @usage  Is used to preset the sort sequence if a new rule is added.
   *         Calculated in steps of 10
   */
  function get_sru_sort_seq
    return number;
    

  /** Helper to calculate the next sort sequence number for a Rule Action
   * %return Next sort sequence value
   * @usage  Is used to preset the sort sequence if a new rule action is added.
   *         Calculated in steps of 10
   */
  function get_sra_sort_seq
    return number;
    
    
  /** Method to calculate a help text for an Action Type
   * @usage  Prints a help text based on action type metadata via the http stream.
   */
  procedure get_action_type_help;
    
    
  /** Method to maintain APEX actions for page ADMIN_SGR
   * @usage  Is called if relevant changes are reported to SCT
   */
  procedure set_action_admin_sgr;
  
  /** Method to maintain APEX actions for page EDIT_SGR
   * @usage  Is called if relevant changes are reported to SCT
   */
  procedure set_action_edit_sgr;
  
  /** Method to maintain APEX actions for page EXPORT_SGR
   * @usage  Is called if relevant changes are reported to SCT
   */
  procedure set_action_export_sgr;
  
  /** Method to maintain APEX actions for page EDIT_SRU
   * @usage  Is called if relevant changes are reported to SCT
   */
  procedure set_action_edit_sru;

end sct_ui_pkg;
/

