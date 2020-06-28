create or replace package utl_sct 
  authid definer
as

  /** Package to wrap SCT functionality in methods to allow to control SCT remotely from PL/SQL
   *  This enables a developer to call SCT actions from within PL/SQL logic to reduce complexity of SCT rules
   */
   
  C_DOCUMENT constant utl_apex.ora_name_type := sct_util.C_NO_FIRING_ITEM;
  C_ERROR constant utl_apex.ora_name_type := 'ERROR';
  C_WARNING constant utl_apex.ora_name_type := 'WARNING';
  C_NOTE constant utl_apex.ora_name_type := 'NOTE';
  

  /** Remove note or error text from the message region
   */
  procedure clear_tip;


  /** Closes a modal window and allows the transmission of a message etc.
   * @param [p_action]  Optional action to be transmitted, for example, a message object
   * @param [p_key]     JSON element name, used for a simplified message transmission
   * @param [p_message] Message text that is translated into JSON and assigned to the P_KEY element
   */
  procedure close_modal_dialog(
    p_action in varchar2 default null,
    p_key in varchar2 default 'message',
    p_message in varchar2 default null);


  /** Shows a confirmation dialog and executes a command on confirmation
   * @param  p_spi_id  Element which then receives focus
   * @param  p_message   Message text to display
   * @param  p_command   Name of the command to be executed. Can be used in SCT conditions via COMMAND = '<P_COMMAND>'.
   *                     Naming convention is <action>-<object> in lowercase, fi export-rulegroup
   */
  procedure confirm_command(
    p_spi_id in varchar2,
    p_message in varchar2,
    p_command in varchar2);


  /** Disable buttons
   * @param  p_spi_id  button to disable
   */
  procedure disable_button(
    p_spi_id in varchar2);


  /** Disables one or many page items
   * @param [p_spi_id]     Element to be deactivated (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure disable_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null);


  /** Executes the transferred JavaScript on the page
   * @param  p_plsql_function  PL/SQL function that outputs a JavaScript statement. Without "javascript:", just the JavaScript code
   */
  procedure dynamic_javascript(
    p_plsql_function in varchar2);


  /** Sets the element value of a field to NULL
   * @param [p_spi_id]     Element to be emptied (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure empty_field(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null);


  /** Enables a button
   * @param  p_spi_id  button to enable
   */
  procedure enable_button(
    p_spi_id in varchar2);


  /** Activates and displays the referenced page element.
   * @param [p_spi_id]     Element to be activated (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param [p_whole_row]  display the complete row, e.g. if several elements are in one column and should be displayed at different times 
   *                       (Default NULL, if effect on whole row, 'N', if effect only on the element)
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure enable_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null);


  /** Hides the referenced page element
   * @param [p_spi_id]     Element to be hidden (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param [p_whole_row]  display the complete row, e.g. if several elements are in one column and should be displayed at different times 
   *                       (Default NULL, if effect on whole row, 'N', if effect only on the element)
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure hide_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null);


  /** Makes a page element a mandatory element and activates mandatory field validation.
   * @param [p_spi_id]     Mandatory element (Default DOCUMENT, if p_jquery_sel filled)
   * @param [p_msg_text]   Message text in quotation marks or function that returns a value (default NULL, then standard text)
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure is_mandatory(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_msg_text in varchar2 default null,
    p_jquery_sel in varchar2 default null);


  /** Makes a page element an optional element and suspends mandatory field validation.
   * @param [p_spi_id]     optional element (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure is_optional(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null);


  /** Sets the referenced element to NULL, activates it on the page and displays it
   * @param [p_spi_id]     Element to be emptied and activated (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param [p_whole_row]  display the complete row, e.g. if several elements are in one column and should be displayed at different times 
   *                       (Default NULL, if effect on whole row, 'N', if effect only on the element)
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure item_null_show(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null);


  /** Executes the JavaScript code passed as parameter
   * @param  p_js_code  JavaScript statement to be executed. (without semicolon)
   */
  procedure java_script_code(
    p_js_code in varchar2);


  /** Updates an element and sets the session state
   * @param  p_spi_id  element to be updated
   * @param  p_item_val  Value of the element in the following format:
   *                     - constant in quotation marks or 
   *                     - JavaScript expression, which is calculated at runtime or 
   *                     - empty character string (''). In this case the value of the session state is used
   *                       (this can be calculated in advance)
   */
  procedure refresh_and_set_value(
    p_spi_id in varchar2,
    p_item_val in varchar2);


  /** Initiate APEX-refresh on the referenced page element
   * @param [p_spi_id]     element to be updated
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure refresh_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null);


  /** A message is written to the developer tools console
   * @param  p_log_msg  Message as text
   */
  procedure log_console(
    p_log_msg in varchar2);


  /** Sets the focus to the element defined in p_spi_id
   * @param  p_spi_id   element to focus on
   */
  procedure set_focus(
    p_spi_id in varchar2);


  /** Sets the referenced page element to the value passed as parameter
   * @param [p_spi_id]      Element to be set (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param  p_item_value   Value of the element in quotation marks or function that returns value.
   * @param [p_jquery_sel]  jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   * @param [p_raise_event] Flag indicating whether a Change Event should be triggered. (Default TRUE, event is triggered)
   */
  procedure set_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_item_value in varchar2,
    p_jquery_sel in varchar2 default null,
    p_raise_event in boolean default true);


  /** Sets a field label to the transferred value
   * @param [p_spi_id]      Element to be set (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param  p_item_label   Label of the element in quotation marks or function that returns value.
   * @param [p_jquery_sel]  jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure set_item_label(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_item_label in varchar2,
    p_jquery_sel in varchar2 default null);


  /** Sets title of the modal dialog box
   * @param  p_title  New title
   */
  procedure set_modal_dialog_title(
    p_title in varchar2);


  /** Sets the referenced element to NULL, deactivates it on the
   * @param [p_spi_id]     Element to be emptied and deactivated (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure set_null_disable(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_jquery_sel in varchar2 default null);


  /** Sets the referenced element to NULL and hides it
   * @param [p_spi_id   Element to be cleared and hidden (default DOCUMENT, if p_jquery_sel filled)
   * @param [p_whole_row  display the complete row, e.g. if several elements are in one column and should be displayed at different times 
   *                      (Default NULL, if effect on whole row, 'N', if effect only on the element)
   * @param [p_jquery_sel jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure set_null_hide(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null);


  /** Display note only in message window (alert box)
   * @param  p_spi_id_focus  Element which receives the focus after confirmation
   * @param  p_msg_text      Message text in quotation marks or function that returns value
   * @param [p_msg_type]     Message type in quotation marks: C_ERROR, C_WARNING, C_NOTE
   */
  procedure show_alert(
    p_spi_id_focus in varchar2,
    p_msg_text in varchar2,
    p_msg_type in varchar2 default C_NOTE);


  /** Shows the error message passed as parameter on the page
   * @param  p_spi_id  Element containing the error (C_DOCUMENT if global error)
   * @param  p_msg_text  Error message text in quotation marks or function that returns value
   */
  procedure show_error(
    p_spi_id in varchar2,
    p_msg_text in varchar2);


  /** Hides the element from P_JQUERY_SEL_SHOW on the page and the elements from P_JQUERY_SEL_HIDE
   * @param  p_jquery_sel_show  jQuery expression to display multiple elements
   * @param  p_jquery_sel_hide  jQuery expression to hide multiple elements
   */
  procedure show_hide_item(
    p_jquery_sel_show in varchar2,
    p_jquery_sel_hide in varchar2);


  /** Display note only in message region
   * @param  p_msg_text  Message text in quotation marks or function that returns value
   * @param [p_msg_type] Message type in quotation marks: C_ERROR, C_WARNING, C_NOTE
   */
  procedure show_hint(
    p_msg_text in varchar2,
    p_msg_type in varchar2 default C_NOTE);


  /** Displays the referenced page element
   * @param [p_spi_id]     Element to be displayed (default DOCUMENT, if P_JQUERY_SEL filled)
   * @param [p_whole_row]  display the complete row, e.g. if several elements are in one column and should be displayed at different times 
   *                       (Default NULL, if effect on whole row, 'N', if effect only on the element)
   * @param [p_jquery_sel] jQuery expression to edit multiple elements. (Default NULL, if p_spi_id filled)
   */
  procedure show_item(
    p_spi_id in varchar2 default C_DOCUMENT,
    p_whole_row in varchar2 default null,
    p_jquery_sel in varchar2 default null);


  /** Display note in message window and region
   *  The action must be linked to a specific element. This element receives the focus after confirmation of the message.
   * @param  p_spi_id_focus  Element which receives the focus after confirmation
   * @param  p_msg_text      Message text in quotation marks or function that returns value
   * @param [p_msg_type]     Message type in quotation marks: C_ERROR, C_WARNING, C_NOTE
   */
  procedure show_message(
    p_spi_id_focus in varchar2,
    p_msg_text in varchar2,
    p_msg_type in varchar2 default C_NOTE);


  /** Show wait spin until APEX-Refresh is successful.
   *  Makes sure an wait spin is shown on that page until an APEX-refresh action has been successfully completed
   * @param  p_region_sel  Region awaiting update
   */
  procedure wait_for_refresh(
    p_region_sel in varchar2);

  
  /** Method to encapsulate PIT collection mode error treatment
   * @param [p_mapping] CHAR_TABLE instance with error code - page item names couples, according to DECODE function
   * @usage  Is used to retrieve the collection of messages collected during validation of a use case in PIT collect mode.
   *         The method retrieves the messages and maps the error codes to page items passed in via P_MAPPING.
   *         If found, it shows the exception inline with field and notification to those items, otherwise it shows the
   *         message without item reference in the notification area only.
   *         Supports #LABEL# replacement, page item name may be passed in with or without page prefix.
   *         Similar to UTL_APEX.HANDLE_BULK_ERRORS, but uses SCT to show the messages dynamically as opposed to UTL_APEX
   *         that encapsulates the messages in the validation life cycle step of APEX.
   */
  procedure handle_bulk_errors(
    p_mapping in char_table default null);
  
end utl_sct;
/