create or replace package sct_validation
  authid definer
  --accessible by (package plugin_sct, package sct_ui, package sct_internal)
as 

  /* Method checks that a lov view exists for an action parameter type with an item type of SELECT_LIST
   * %param  p_spt_id         Parameter Type
   * @param  p_spt_item_type  Item type
   * %usage  Method is used to assert that a LOV for a parameter type of item type SELECT_LIST exists 
   *         with the correct column structure that is able to deliver LOV data
   * @throws msg.SCT_PARAM_LOV_MISSING if LOV view is required but missing
   *         msg.SCT_PARAM_LOV_INCORRECT if required LOV view exists but with the wrong structure
   */
  procedure validate_param_lov(
    p_spt_id in sct_action_param_type.spt_id%type,
    p_spt_item_type in sct_action_param_type.spt_item_type%type);

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
    p_environment in sct_util.environment_rec);
    
end sct_validation;
/
