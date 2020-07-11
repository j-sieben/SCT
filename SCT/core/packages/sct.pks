create or replace package sct
  authid definer
as

  /** Package SCT to implement the public interface to SCT
   * @author Juergen Sieben, ConDeS GmbH
   * @usage  Used to implement the public interface of SCT. Is called by PLUGIN_SCT, SCT rule views and directly from PL/SQL
   * @headcom
   */
   
  $IF sct_util.C_WITH_UNIT_TESTS $THEN
  /* Setter/getter to switch package to test mode
   * %param  p_mode  Switch to toggle test mode
   * %usage  For automated tests, this switch controls wehther SCT fills an object structure with the outcome of
   *         the processing. This is easier and saver than parsing OWA streams
   */
  procedure set_test_mode(
    p_mode in boolean default false);    
    
  function get_test_mode
    return boolean;
    
  /** Method to retrieve the result of the last action
   * @return Object structure that contains the result of the process.
   */
  function get_test_result
    return ut_sct_result;

  $END
  /** Message to retreive a new primary key value from SCT
   * @usage  Is called by the SCT_UI interface to pouplate newly created rules etc.
   */
  function get_pk
    return number;
    

  /* CORE FUNCTIONALITY wrapper around SCT_INTERNAL */
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
   * @param [p_format_mask] Format mask that is used to convert the string representation within the session state.
   *                        If NULL, SCT tries to get the format mask from the meta data
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
    p_format_mask in varchar2 default null,
    p_throw_error in sct_util.flag_type default sct_util.C_TRUE)
    return date;
    
    
  /** Method to retrieve the name of the event that has caused SCT to execute
   * @return Name of the event
   * @usage  Is used to retrieve the SCT event name of the event that has fired.
   *         SCT events differ from normal web browser or APEX events in that they can replace browser events with their own
   *         events, fi by replacing the keypress-event for keycode 13 with an enter event.
   */
  function get_event
    return varchar2;


  /** Method to get the page item id of the item that has fired SCT processing
   * @return ID of the firing item
   * @usage  Is used to get access to the ID of the page item that has fired the event
   */
  function get_firing_item
    return varchar2;


  /** Method to retrieve the value of a page item as number
   * @param  p_spi_id       ID of the page item
   * @param [p_format_mask] Format mask that is used to convert the string representation within the session state.
   *                        If NULL, SCT tries to get the format mask from the meta data
   * @param [p_throw_error] Flag to indicate whether a non successful conversion is treated as an error. Defaults to C_FALSE.
   *                        - C_TRUE: an error is registered and thrown
   *                        - C_FALSE: an error is registered but not thrown
   * @return NUMBER value
   * @usage  Is used to convert a session state string value into date
   *         Depending on parameter P_THROW_ERROR an error is not only register upon unsuccessful conversion but thrown as well.
   *         This is useful if a rule cannot be processed any further if the conversion is not successful.
   *         If the element is mandatory and NULL, a default value is returned as defined in the APEX metadata
   */
  function get_number(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2 default null,
    p_throw_error in sct_util.flag_type default sct_util.C_FALSE)
    return number;
  
  
  /* ADDITIONAL SCT FUNCTIONALITY */
  /** Method to register JavaScript code
   * @param  p_javascript  JavaScript to execute on page
   * @usage  Is used to register JavaScript for execution. Is used if PL/SQL code that is part of the application logic needs
   *         to register JavaScript for execution. In that case, EXECUTE_JAVASCRIPT may not be as elegant to use.
   */
  procedure add_javascript(
    p_javascript in varchar2);


  /** Checks whether a page item contains a valid date according to its format mask
   * @param  p_spi_id  ID of the page item
   * @usage  CHecks the value of a page item against its format mask or against the application default format mask
   */
  procedure check_date(
    p_spi_id in sct_page_item.spi_id%type);


  /** Method to check a mandatory item
   * @param  p_spi_id  ID of the item to check
   * @usage  Is used to explicitly check a mandatory item.
   */
  procedure check_mandatory(
    p_spi_id in sct_page_item.spi_id%type);


  /** Checks whether a page item contains a valid number according to its format mask
   * @param  p_spi_id  ID of the page item
   * @usage  CHecks the value of a page item against its format mask or against the application default format mask
   */
  procedure check_number(
    p_spi_id in sct_page_item.spi_id%type);


  /** Method to assure that exactly one or at most one page item of a selection of page items contains a value
   * @param  p_spi_id         Page item ID that is selected to show the error message
   * @param  p_value_list     List of page item IDs to check
   * @param [p_message]       Optional PIT message name to show if the method throws an error
   * @param [p_error_on_null] Flag to indicate whether an error has to be thrown if all page items are NULL
   * %raises MSG.ASSERTION_FAILED_ERR or <P_MESSAGE>_ERR if
   *         - more than one page item is NOT NULL
   *         - all page items are NULL and P_ERROR_ON_NULL is set to true
   * @usage  Is used to assert that at least one page item of a list of items contains a value. If an error is raised, this
   *         can be used to proceed with an exception handler within the SCT rule.
   */
  procedure exclusive_or(
    p_spi_id in sct_page_item.spi_id%type,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED,
    p_error_on_null in boolean default false);


  /** Function overload
   * @param  p_value_list  colon-separated list of page item IDs to check
   * @return - 1 if rule is satisfied
   *         - 0 if rule is not satisfied
   *         - NULL if all page item values are null
   * @usage  Is used to be able to utilize EXCLUSIVE_OR within an SCT rule condition (used in SQL)
   */
  function exclusive_or(
    p_value_list in varchar2)
    return number;
    

  /** Method to execute a PL/SQL block that returns JavaScript. This script will be part of the SCT answer and will get
   *  executed when SCT returns.
   * @param  p_plsql  PL/SQL block to calculate the JavaScript
   * @usage  Is used to let SCT calculate a JavaScript chunk (such as a call to open a modal dialog) and return it to SCT.
   *         SCT will then incorporate this script into the answer and execute it.
   */
  procedure execute_javascript(
    p_plsql in varchar2);


  /** Method to execute a PL/SQL block
   * @param  p_plsql  PL/SQL block to execute
   * @usage  Is used to execute dynamic PL/SQL blocks
   */
  procedure execute_plsql(
    p_plsql in varchar2);


  /** Method to learn whether the actual rule flow has receieved errors
   * @return FALSE if no error has occured, TRUE otherwise
   * @usage  Is called from PL/SQL code to react if errors have occurred.
   */
  function has_errors
    return boolean;


  /** Method to learn whether the actual rule flow has receieved errors
   * @return TRUE if no error has occured, FALSE otherwise
   * @usage  Is called from PL/SQL code to assure that no errors have occurred so far.
   */
  function has_no_errors
    return boolean;


  /** Method to assure that at least on page item of a list of page items contains a value
   * @param  p_spi_id      Page item ID that is selected to show the error message
   * @param  p_value_list  List of page item IDs to check
   * @param [p_message]    Optional PIT message name to show if the method throws an error
   * @usage  Is used to make sure that at least one page item of a list of page items contains a value.
   * %raises MSG.ASSERTION_FAILED_ERR or <P_MESSAGE>_ERR if all page item values are NULL
   */
  procedure not_null(
    p_spi_id in sct_page_item.spi_id%type,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED);


  /** Overload as function
   * @param  p_value_list  List of page item IDs to check
   * @return - 1 if rule is satisfied
   *         - 0 if rule is not satisfied
   *         - NULL if all page item values are null
   * @usage  Is used to be able to utilize NOT_NULL within an SCT rule condition (used in SQL)
   */
  function not_null(
    p_value_list in varchar2)
    return number;


  /** Method shows a message on the browser screen
   * @param  p_message  Message text or PL/SQL block that returns a message
   * @usage  Is used to show a message on the browser window
   *         Two operation modes:
   *         - Pass in a string, including the ' signs. The message will be shown on screen
   *         - Pass in a PL/SQL-Funktion that returns a message. This message will be shown
   */
  procedure notify(
    p_message in varchar2);


  /** Method to register an error
   * @param  p_spi_id          ID of the page item that is referenced by the error (or DOCUMENT)
   * @param  p_error_msg       Error message to register
   * @param [p_internal_error] Optional additional information, visible for developers
   * @usage  Is called to register an error onto the error stack. May be called from PL/SQL directly or implicitly as the
   *         consequence of an internal error.
   */
  procedure register_error(
    p_spi_id in sct_page_item.spi_id%type,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null);


  /** Overload to allow for PIT messages to be used.
   * @param  p_spi_id        ID of the page item that is referenced by the error (or DOCUMENT)
   * @param  p_message_name  PIT message name to register
   * @param [p_arg_list]     Optional message arguments as defined by PIT
   * @usage  Is called to register an error onto the error stack. May be called from PL/SQL directly or implicitly as the
   *         consequence of an internal error.
   */
  procedure register_error(
    p_spi_id in sct_page_item.spi_id%type,
    p_message_name in varchar2,
    p_arg_list in msg_args default null);


  /** Method to se a page item mandatory or optional
   * @param  p_spi_id                 Page item ID for which the status has to be changed
   * @param  p_spi_mandatory_message  Optional message to show if a mandatory item is set to null or if the page has to be
   *                                  submitted but this page item is NULL
   * @param  p_is_mandatory           Flag to indicate whether P_SPI_ID is mandatory (TRUE) or not (FALSE)
   * @param  p_param_2                Optional parameter to pass in a jQuery selector to select multiple elements. In this case,
   *                                  P_SPI_ID has to be DOCUMENT
   * @usage  Is called to register a page item as mandatory or optional. This does not only change the page items UI settings
   *         but assures that the page can't be submitted if one of the mandatory page items are NULL. If a page item contained
   *         a value and is set to NULL, an error is raised.
   *         The message to show may be defined explicitly. If the message is NULL, a default message is shown.
   */
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in sct_page_item.spi_mandatory_message%type,
    p_is_mandatory in boolean,
    p_param_2 in sct_rule_action.sra_param_2%type default null);


  /** Method to register notifications
   * @param  p_text  Notification text
   * @usage  Is called to allow for notifications to be passed to the UI during the execution of SCT rules.
   *         These messages are logged to the browser console as part of the response
   */
  procedure register_notification(
    p_text in varchar2);


  /** Overload to allow for PIT messages to be used.
   * @param  p_spi_id        ID of the page item that is referenced by the error (or DOCUMENT)
   * @param  p_message_name  PIT message name to register
   * @param [p_arg_list]     Optional message arguments as defined by PIT
   * @usage  Is called to allow for notifications to be passed to the UI during the execution of SCT rules.
   *         These messages are logged to the browser console as part of the response
   */
  procedure register_notification(
    p_message_name in varchar2,
    p_arg_list in msg_args);


  /** Method to set a page item based on a query that returns a list of rows
   * @param  p_spi_id ID of the page item
   * @param  p_stmt   SELECT statement to retrieve the new page item value or values
   * @usage  Is used to define new session state values for page items capable of working with a list of values, such as
   *         shuttle controls or option lists.
   */
  procedure set_list_from_stmt(
    p_spi_id in sct_page_item.spi_id%type,
    p_stmt in varchar2);


  /** Method to set a page item value in session state.
   *  This method is a wrapper around APEX_UTIL.set_session_state with the extension, that SCT is aware of the change and
   *  will report the change to the page when returning the result. This will harmonize the page item on the page with the
   *  session state.
   * @param  p_spi_id           ID of the item whose value is set. If P_SELECTOR is set, this parameter is ignored
   * @param  p_value            Page item value
   * @param [p_allow_recursion] Flag to indicate whether changing this items session value causes SCT rules to fire
   * @param [p_selector]        Optional flag containing a jQuery selector to identify more page items to set the value
   * @usage  Is used to set the session state of one or more items within the database. This method will harmonize the newly
   *         set values with the application page.
   *         If P_SPI_ID is set to a page item name, only this item will be set to the value passed in.
   *         If P_SPI_ID is set to SCT_UTIL.C_NO_FIRING_ITEM then it is expected that a jQuery selector is passed in as P_PARAM_2
   *         In this case, all items that are identified by the jQuery selector are set to P_VALUE.
   *         If set (which is the default), P_ALLOW_RECURSION enables SCT to fire change events on any page item that is
   *         affected by this method. This allows for any SCT rule based on these elements to fire recursively.
   */
  procedure set_session_state(
    p_spi_id in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in sct_util.flag_type default sct_util.C_TRUE,
    p_selector in sct_rule_action.sra_param_1%type default null);


  /** Method to set the value of a page item or raise an error.
   * @param  p_spi_id           ID of the item whose value is set
   * @param  p_value            Page item value
   * @param  p_error            Error message. If NULL, P_VALUE is set in session state, an error is thrown otherwise.
   * @param [p_allow_recursion] Flag to indicate whether changing this items session value causes SCT rules to fire
   * @usage  Is used to offer a possibility for external logic to set a page item value or raise an error if a conversion
   *         was not succesful.
   */
  procedure set_session_state_or_error(
    p_spi_id in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_error in varchar2,
    p_allow_recursion in sct_util.flag_type default sct_util.C_TRUE);


  /** Prozedur zum Setzen des Session Status, basierend auf einer SQL-Anweisung
   * @param  p_spi_id ID of the page item
   * @param  p_stmt   SELECT statement to retrieve the new page item value or values
   * @usage  Is used to set one or more item values based on a SQL query.
   *         Two operation modes:
   *         - P_SPI_ID is set to a page item ID
   *           In this case the SQL query must return a scalar value
   *         - P_SPI_ID ist DOCUMENT oder NULL
   *           In this mode the query is allowed to return more than one column but one row only.
   *           The column names must match page item IDs. If a match is found, the respective element is set to the column value
   */
  procedure set_value_from_stmt(
    p_spi_id in sct_page_item.spi_id%type,
    p_stmt in varchar2);


  /** Method to stop further execution of the active rule
   * @usage  Is used to stop the execution of an SCT rule if an error occured.
   */
  procedure stop_rule;


  /** Prozedur zur Vorbereitung des Speicherns der Seite
   * @usage Diese Prozedur sollte nur verwendet werden, wenn SCT eine Seite
   *        vollstaendig verwaltet. Die Prozedur prueft alle Seitenelemente,
   *        die durch SCT auf MANDATORY gesetzt wurden, gegen den Session-State.
   *        Ist ein Pflichtfeld NULL wird ein Fehler registriert und das Absenden
   *        der Seite dadurch verhindert.
   */
  procedure validate_page;
  
  
  /** CONVENIENCE methods as a wrapper around EXECUTE_ACTION to conveniently call SCT methods from within PL/SQL */
  /*
SHOW_TIP
WAIT_FOR_REFRESH
*/
  procedure toggle_item_mandatory(
    p_selector in varchar2,
    p_mandatory in boolean default true);
    
  procedure toggle_item_status(
    p_selector in varchar2,
    p_enabled in boolean default true,
    p_set_null in boolean default false);
  
  procedure toggle_item_visibility(
    p_selector in varchar2,
    p_visible in boolean default true,
    p_set_null in boolean default false);
  
  procedure toggle_item_visibility(
    p_selector in varchar2,
    p_items_to_show in varchar2);
    
  procedure refresh_item(
    p_spi_id in sct_page_item.spi_id%type,
    p_set_value in varchar2 default null);
    
  procedure set_item(
    p_spi_id in sct_page_item.spi_id%type,
    p_value in varchar2 default null);
    
  procedure set_focus(
    p_spi_id in sct_page_item.spi_id%type);
    
  procedure execute_apex_action(
    p_action_name in sct_apex_action.saa_id%type);
    
  procedure execute_java_script(
    p_java_script in varchar2);
    
  procedure write_to_console(
    p_what in varchar2);

end sct;
/