create or replace package sct_internal
  authid definer
  --accessible by (package plugin_sct, package sct_ui, package sct_validation)
as

  /** Package SCT_INTERNAL to maintain State Charts as a dynamic action plugin
   * @author Juergen Sieben, ConDeS GmbH
   * @usage  Used to implement the internal logic of SCT.
   * @headcom
   */
   
  /* Record with environmental information about the actually executed rule
   * @usage  Is used in sct_validation for checks against the meta data of SCT
   */
  type environment_rec is record(
    sgr_id sct_rule_group.sgr_id%type,
    app_id sct_rule_group.sgr_app_id%type,
    page_id sct_rule_group.sgr_page_id%type);

  /* Internal methods to support the plugin functionality */

  /** Getter to retriece all elements that needs to be bound to an event handler as JSON
   * @return JSON instance containing name and event of all relevant page items
   * @usage  Is called during plugin initialization.
   *         The instance contains all relevant elements SCT needs to observe, along with the event it watches. For these items
   *         SCT will instantiate an event handler that calls SCT.
   */
  function get_bind_items_as_json
    return clob;
    
    
  /** Method to retrieve the value of a page item as char
   * @param  p_spi_id  ID of the page item
   * @return Value of the requested page item
   * @usage  Is used to get the value of a page item.
   *         As an extension to V(P_SPI_ID) this method retrieves a default value as defined within the APEX data dictionary
   *         if the actual value of the page item is NULL
   */
  function get_char(
    p_spi_id in sct_page_item.spi_id%type)
    return varchar2;
    
    
  /** Method to retrieve the value of a page item as char
   * @param  p_spi_id       ID of the page item
   * @param  p_format_mask  Format mask that is used to convert the string representation within the session state
   * @param [p_throw_error] Flag to indicate whether a non successful conversion is treated as an error. Defaults to C_TRUE.
   *                        - C_TRUE: an error is registered and thrown
   *                        - C_FALSE: an error is registered but not thrown
   * @return DATE value
   * @usage  Is used to convert a session state string value into date
   *         Depending on parameter P_THROW_ERROR an error is not only register upon unsuccessful conversion but thrown as well.
   *         This is useful if a rule cannot be processed any further if the conversion is not successful.
   *         If the element is mandatory and NULL, a default value is returned as defined in the APEX metadata
   */
  function get_date(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in sct_util.flag_type default sct_util.C_TRUE)
    return date;


  /* Getter to read the error status
   * @return TRUE if the execution of the SCT rule encountered an error, FALSE if not
   */
  function get_error_flag
    return boolean;


  /** Getter to get the event that was raised.
   * @return Name of the event
   */
  function get_event
    return varchar2;
    

  /** Getter to get the name of the firing item. If NULL, DOCUMENT is returned
   * @return Name of the firing item or DOCUMENT if NULL
   */
  function get_firing_item
    return varchar2;
  
  
  /** Method to retrieve the value of a page item as number
   * @param  p_spi_id       ID of the page item
   * @param  p_format_mask  Format mask that is used to convert the string representation within the session state
   * @param [p_throw_error] Flag to indicate whether a non successful conversion is treated as an error. Defaults to C_FALSE.
   *                        - C_TRUE: an error is registered and thrown
   *                        - C_FALSE: an error is registered but not thrown
   * @return DATE value
   * @usage  Is used to convert a session state string value into date
   *         Depending on parameter P_THROW_ERROR an error is not only register upon unsuccessful conversion but thrown as well.
   *         This is useful if a rule cannot be processed any further if the conversion is not successful.
   *         If the element is mandatory and NULL, a default value is returned as defined in the APEX metadata
   */
  function get_number(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in sct_util.flag_type default sct_util.c_false)
    return number;
    

  /** Getter to retrieve a list of elements that potentially have changed during execution of SCT
   * @return C_DELIMITER delimited list of page items that potentially have changed
   * @usage  Is used to put together a C_DELIMITER delimited list of page items.
   */
  function get_page_items
    return varchar2;
    

  /** Method executes any initialization code of the rule group
   * @usage Is called during initialization of SCT for the page. SCT requires the initial values of the page items and
   *        needs to compute them, as APEX does not store them during initialization in an accessible manner.
   *        To allow for this, SCT re-executes any page computation and row fetch process as far as possible
   */
  procedure process_initialization_code;


  /** Method to process a SCT request
   * @return JavaScript code in response to the request
   * @usage  Is used to calculate the new status of the page based on the session state values and the underlying SCT rules.
   */
  function process_request
    return clob;


  /** Method pushes a page item onto the error stack.
   * @param  p_error  APEX error of type APEX_ERROR.T_ERROR to push onto the stack
   * @usage  Is called during execution of a rule, if an error is registered or if the page is to be
   *         submitted. The stack collects any items that were "touched" by the rule(s) executed during
   *         this processing step.
   */
  procedure push_error(
    p_error in apex_error.t_error);
    

  /** Method pushes a page item onto the firing item stack.
   * @param  p_spi_id  ID of the page item to push onto the stack
   * @usage  SCT maintains a list of all items that fired events.
   */
  procedure push_firing_item(
    p_spi_id in varchar2);
    
    
  /** Helper to copy plugin settings to an internal record G_PARAM
   * @param  p_firing_item           Firing item
   * @param  p_event                 Firing event
   * @param  p_rule_group_name       Name of the rule group
   * @param  p_error_dependent_items List of page items that have to be deactivated if an error is on the page
   * @usage  Is called before the actual rule action takes place (at the beginning of render and AJAX methods)
   *         to copy the status to a package record.
   */
  procedure read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_rule_group_name in varchar2,
    p_error_dependent_items in varchar2);


  /* Methods to implement the SCT specific functionality */
  /* @see plugin_sct.add_javascript */
  procedure add_javascript(
    p_javascript in varchar2);


  /* @see plugin_sct.check_date */
  procedure check_date(
    p_spi_id in sct_page_item.spi_id%type);


  /* @see plugin_sct.execute_action */
  procedure check_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_push_item out nocopy sct_page_item.spi_id%type);


  /* @see plugin_sct.execute_action */
  procedure check_number(
    p_spi_id in sct_page_item.spi_id%type);


  /* @see plugin_sct.execute_action */
  procedure execute_action(
    p_sat_id in sct_action_type.sat_id%type,
    p_spi_id in sct_page_item.spi_id%type,
    p_param_1 in sct_rule_action.sra_param_1%type,
    p_param_2 in sct_rule_action.sra_param_2%type,
    p_param_3 in sct_rule_action.sra_param_3%type);


  /* @see plugin_sct.execute_javascript */
  procedure execute_javascript(
    p_plsql in varchar2);


  /* @see plugin_sct.exclusive_or */
  procedure exclusive_or(
    p_spi_id in sct_page_item.spi_id%type,
    p_value_list in varchar2,
    p_message in varchar2,
    p_error_on_null in boolean default false);


  /* @see plugin_sct.exclusive_or */
  function exclusive_or(
    p_value_list in varchar2)
    return number;


  /* @see plugin_sct.notify */
  procedure notify(
    p_message in varchar2);


  /* @see plugin_sct.not_null */
  procedure not_null(
    p_spi_id in sct_page_item.spi_id%type,
    p_value_list in varchar2,
    p_message in varchar2);


  /* @see plugin_sct.not_null */
  function not_null(
    p_value_list in varchar2)
    return number;


  /* @see plugin_sct.register_error */
  procedure register_error(
    p_spi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2);


  /* @see plugin_sct.register_error */
  procedure register_error(
    p_spi_id in varchar2,
    p_message_name in varchar2,
    p_arg_list in msg_args default null);


  /* @see plugin_sct.register_mandatory */
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean,
    p_param_2 in sct_rule_action.sra_param_2%type default null);


  /* @see plugin_sct.register_notification */
  procedure register_notification(
    p_text in varchar2);


  /* @see plugin_sct.register_notification */
  procedure register_notification(
    p_message_name in varchar2,
    p_arg_list in msg_args);
    
  
  /* @see plugin_sct.register_observer */
  function register_observer
    return varchar2;


  /* @see plugin_sct.set_list_from_stmt */
  procedure set_list_from_stmt(
    p_spi_id in sct_page_item.spi_id%type,
    p_stmt in varchar2);


  /* @see plugin_sct.set_session_state */
  procedure set_session_state(
    p_spi_id in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in sct_util.flag_type default sct_util.C_TRUE,
    p_param_2 in sct_rule_action.sra_param_2%type default null);


  /* @see plugin_sct.set_value_from_stmt */
  procedure set_value_from_stmt(
    p_spi_id in sct_page_item.spi_id%type,
    p_stmt in varchar2);


  /* @see plugin_sct.stop_rule */
  procedure stop_rule;


  /* @see plugin_sct.submit_page */
  procedure submit_page;
end sct_internal;
/