create or replace package sct_validation
  authid definer
  --accessible by (package plugin_sct, package sct_ui, package sct_internal)
as 

  /* Method to calculate the SQL statement for a parameter type
   * %param  p_spt_id       Parameter Type
   * %param  p_environment  Record with environmental data such as SGR_ID
   * %usage  Method is used to generate a SQL statement for the parameter LOV
   */
  function get_lov_sql(
    p_spt_id in sct_action_param_type.spt_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2;
  
  /* Method to check an action type parameter
   * %param  p_value        Parameter value to check and format
   * %param  p_spt_id       Parameter Type
   * %param  p_spi_id       UI element to attach the error to
   * %param  p_environment  Record with environmental data such as SGR_ID
   * %usage  Method is used to check an entered parameter value against meta data and format it in order to directly
   *         use it in rule actions
   */
  procedure validate_parameter(
    p_value in out nocopy sct_rule_action.sra_param_1%type,
    p_spt_id in sct_action_param_type.spt_id%type,
    p_spi_id in sct_page_item.spi_id%type,
    p_environment in sct_internal.environment_rec);
       
  /** Method to dynamically execute a validation for a page item
   * %param  p_item             Name of the item the validation refers to
   *                            an error message.
   */
  procedure validate_page_item(
    p_item in varchar2);
    
end sct_validation;
/
