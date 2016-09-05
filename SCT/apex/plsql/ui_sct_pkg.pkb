create or replace package body ui_sct_pkg
as

  procedure merge_rule_group(
    p_sgr_app_id in sct_group.sgr_app_id%type,
    p_sgr_page_id in sct_group.sgr_page_id%type,
    p_sgr_id in sct_group.sgr_id%type default null,
    p_sgr_name in sct_group.sgr_name%type,
    p_sgr_description in sct_group.sgr_description%type)
  as
  begin
    sct_admin.merge_rule_group(
      p_sgr_app_id => p_sgr_app_id,
      p_sgr_page_id => p_sgr_page_id,
      p_sgr_id => p_sgr_id,
      p_sgr_name => p_sgr_name,
      p_sgr_description => p_sgr_description);
  end merge_rule_group;


  procedure delete_rule_group(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    sct_admin.delete_rule_group(p_sgr_id);
  end delete_rule_group;


  procedure resequence_rule_group(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    sct_admin.resequence_rule_group(p_sgr_id);
  end resequence_rule_group;


  procedure copy_rule_group(
    p_sgr_id in sct_group.sgr_id%type,
    p_sgr_app_id sct_group.sgr_app_id%type,
    p_sgr_page_id sct_group.sgr_page_id%type default null)
  as
    l_sct_group sct_group%rowtype;
  begin
    sct_admin.copy_rule_group(p_sgr_id, p_sgr_app_id, p_sgr_page_id);
  end copy_rule_group;


  procedure process_rule_change(
    p_sgr_id in sct_group.sgr_id%type)
  as
  begin
    sct_admin.propagate_rule_change(p_sgr_id);
  end process_rule_change;


  function validate_rule_is_valid(
    p_sgr_id in sct_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type)
    return varchar2
  as
    l_error varchar2(4000);
  begin
    sct_admin.validate_rule(
      p_sgr_id => p_sgr_id,
      p_sru_condition => p_sru_condition,
      p_error => l_error);
    return l_error;
  end validate_rule_is_valid;


end ui_sct_pkg;
/