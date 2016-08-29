create or replace package sct_pkg
  authid current_user
as

  /* Erzegut eine neue oder aendert eine bestehende Regelgruppe
   * %param p_sgr_app_id Anwendungs-ID, auf die sich die Regelruppe bezieht
   * %param p_sgr_page_id Seiten-ID, auf die sich die Regelgruppe bezieht
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sgr_name Klartextname der Regelgruppe
   * %param p_sgr_description Bescchreibung der Regelgruppe
   * %usage Wird von der Oberflaeche aufgerufen, um eine neue Regelgruppe zu erzeugen
   *        oder eine bestehende Regelgruppe zu aendern.
   */
  procedure merge_rule_group(
    p_sgr_app_id in sct_group.sgr_app_id%type,
    p_sgr_page_id in sct_group.sgr_page_id%type,
    p_sgr_id in sct_group.sgr_id%type default null,
    p_sgr_name in sct_group.sgr_name%type,
    p_sgr_description in sct_group.sgr_description%type);
    
    
  procedure delete_rule_group(
    p_sgr_id in sct_group.sgr_id%type);
    
  
  procedure copy_rule_group(
    p_sgr_id in sct_group.sgr_id%type,
    p_sgr_app_id sct_group.sgr_app_id%type,
    p_sgr_page_id sct_group.sgr_page_id%type default null);
    
  
  /* Method to resequence columns SRU_SORT_SEQ and SRA_SORT_SEQ.
   * %param p_sgr_id ID of the rule group to resequence. Optional. If null,
   *                 all rule groups get resequenced.
   * %usage Is called by the APEX application. Wrapper for SCT_ADMIN.RESEQUENCE_RULE_GROUP.
   *        Details see there.
   */
  procedure resequence_rule_group(
    p_sgr_id in sct_group.sgr_id%type);
    
  
  /* Method executes tasks necessary after changing a rule or rule group definition.
   * %param p_sgr_id ID of the rule group that has changed
   * %usage Is triggered by the APEX application after a change at a rule or rule group
   *        Wrapper for SCT_ADMIN.PROPAGATE_RULE_CHANGE. Details see there.
   */
  procedure persist_rule_change(
    p_sgr_id in sct_group.sgr_id%type);
    
  
  /* Validates whether an entered condition is syntactically correct
   * %param p_sgr_id ID of the rule group p_sru_condition refers to
   * %param p_sru_condition Condition that needs to get validated
   * %usage This method constructs a view with all available page items as columns
   *        and parses the entered condition at the where clause.
   */
  function validate_rule_is_valid(
    p_sgr_id in sct_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type)
    return varchar2;
    
    
end sct_pkg;
/