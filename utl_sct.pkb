CREATE OR REPLACE PACKAGE BODY utl_sct
AS
  
  ----------------------- interne Methoden ------------------------------------------------------------------------
  FUNCTION get_msg (ip_msg IN VARCHAR2)
  RETURN VARCHAR2
  AS
    C_CMD_TEMPLATE VARCHAR2(200) := 'begin :x := #COMMAND#; end;';
    s_cmd VARCHAR2(32767);
    s_msg VARCHAR2(32767) := ip_msg;
  BEGIN
    IF INSTR(ip_msg,'pit.') <> 0 THEN
      s_cmd := REPLACE(C_CMD_TEMPLATE, '#COMMAND#', REPLACE(trim(ip_msg), ';'));
      EXECUTE IMMEDIATE s_cmd USING OUT s_msg;
    END IF;
    
    RETURN s_msg;
  END get_msg;
  ----------------------- interne Methoden ENDE -------------------------------------------------------------------


  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   clear_tip
  --
  --  Historie:
  --    08.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE clear_tip
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('CLEAR_TIP');
    pit.leave_optional;
  END clear_tip;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   close_modal_dialog
  --
  --  Historie:
  --    14.10.2019 J. Sieben: Erstellung
  --    17.10.2019 J. Sieben: Erweiterung um KEY/MESSAGE-Parameter fuer vereinfachte Meldungsuebermittlung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE close_modal_dialog (ip_action  IN VARCHAR2 DEFAULT NULL,
                                ip_key     IN VARCHAR2 DEFAULT 'message',
                                ip_message IN VARCHAR2 DEFAULT NULL)
  AS
    C_JSON_PATTERN VARCHAR2(100) := q'^{"#KEY#":"#MESSAGE#"}^';
    s_action utl_apex.max_char;
  BEGIN
    pit.enter_optional;
    CASE WHEN ip_action IS NOT NULL THEN
      s_action := ip_action;
    WHEN ip_message IS NOT NULL THEN
      s_action := utl_text.bulk_replace(C_JSON_PATTERN, char_table(
                    '#KEY#', ip_key,
                    '#MESSAGE#', ip_message));
    ELSE
      NULL;
    END CASE;
    plugin_sct.execute_action(
      p_action_id => 'CLOSE_MODAL_DIALOG', 
      p_attribute_1 => s_action);
    pit.leave_optional;
  END close_modal_dialog;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   confirm_command
  --
  --  Historie:
  --    10.10.2019 J. Sieben: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE confirm_command (ip_item_sel  IN VARCHAR2,
                             ip_message   IN VARCHAR2,
                             ip_command   IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action(
      p_action_id => 'CONFIRM_COMMAND',
      p_item_name => ip_item_sel,
      p_attribute_1 => ip_message,
      p_attribute_2 => ip_command);
    pit.leave_optional;
  END confirm_command;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   disable_button
  --
  --  Historie:
  --    06.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE disable_button (ip_item_sel   IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('DISABLE_BUTTON', ip_item_sel);
    pit.leave_optional;
  END disable_button;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   disable_item
  --
  --  Historie:
  --    17.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE disable_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                          ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('DISABLE_ITEM', ip_item_sel, null, ip_jquery_sel);
    pit.leave_optional;
  END disable_item;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   dynamic_js
  --
  --  Historie:
  --    06.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE dynamic_js (ip_plsql_func   IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('DYNAMIC_JAVASCRIPT', apex_escape.js_literal(ip_plsql_func));
    pit.leave_optional;
  END dynamic_js;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   empty_field
  --
  --  Historie:
  --    17.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE empty_field (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                         ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('EMPTY_FIELD', ip_item_sel, null, ip_jquery_sel);
    pit.leave_optional;
  END empty_field;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   enable_button
  --
  --  Historie:
  --    06.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE enable_button (ip_item_sel   IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('ENABLE_BUTTON', ip_item_sel);
    pit.leave_optional;
  END enable_button;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   enable_item
  --
  --  Historie:
  --    17.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE enable_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                         ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                         ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('ENABLE_ITEM', ip_item_sel, ip_whole_row, ip_jquery_sel);
    pit.leave_optional;
  END enable_item;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   hide_item
  --
  --  Historie:
  --    17.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE hide_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                       ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                       ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('HIDE_ITEM', ip_item_sel, ip_whole_row, ip_jquery_sel);
    pit.leave_optional;
  END hide_item;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   is_mandatory
  --
  --  Historie:
  --    17.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE is_mandatory (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                          ip_msg_text   IN VARCHAR2 DEFAULT NULL,
                          ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
    s_msg_text utl_apex.sql_char;
  BEGIN
    pit.enter_optional;
    -- apex_escape liefert auch bei leerer Meldung einen String, der die Standardmeldung ueberschreibt
    IF ip_msg_text IS NOT NULL THEN
      s_msg_text := apex_escape.js_literal(ip_msg_text);
    END IF;
    plugin_sct.execute_action('IS_MANDATORY', ip_item_sel, s_msg_text, ip_jquery_sel);
    pit.leave_optional;
  END is_mandatory;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   is_optional
  --
  --  Historie:
  --    17.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE is_optional (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                         ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('IS_OPTIONAL', ip_item_sel, NULL, ip_jquery_sel);
    pit.leave_optional;
  END is_optional;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   item_null_show
  --
  --  Historie:
  --    06.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE item_null_show (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                            ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                            ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('ITEM_NULL_SHOW', ip_item_sel, ip_whole_row, ip_jquery_sel);
    pit.leave_optional;
  END item_null_show;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   java_script_code
  --
  --  Historie:
  --    06.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE java_script_code (ip_js_code   IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('JAVA_SCRIPT_CODE', ip_js_code);
    pit.leave_optional;
  END java_script_code;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   refresh_item
  --
  --  Historie:
  --    17.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE refresh_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                          ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('REFRESH_ITEM', ip_item_sel, NULL, ip_jquery_sel);
    pit.leave_optional;
  END refresh_item;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   validate_item
  --
  --  Historie:
  --    24.01.2020 J. Sieben: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE validate_item (ip_item        IN VARCHAR2,
                           ip_item_type   IN VARCHAR2,
                           ip_existenz    IN BOOLEAN,
                           ip_return_item IN VARCHAR2 DEFAULT NULL)
  AS
    s_action sct_action_type.sat_id%TYPE;
  BEGIN
    pit.enter_optional;
    
    IF ip_existenz THEN
      s_action := 'VALIDATE_EXIST_ITEM';
    ELSE
      s_action := 'VALIDATE_EXIST_ITEM';
    END IF;
    plugin_sct.execute_action(s_action, ip_item, UPPER(ip_item_type), ip_return_item);
    
    pit.leave_optional;
  END validate_item;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   set_button_access_key
  --
  --  Historie:
  --    10.10.2019 J. Sieben: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_button_access_key (ip_item_sel IN VARCHAR2,
                                   ip_position IN PLS_INTEGER)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action(
      p_action_id => 'SET_BUTTON_ACCESSKEY', 
      p_item_name => ip_item_sel,
      p_attribute_1 => TO_CHAR(ip_position));
    pit.leave_optional;
  END set_button_access_key;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   refresh_and_set_value
  --
  --  Historie:
  --    06.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE refresh_and_set_value (ip_item_sel   IN VARCHAR2,
                                   ip_item_val   IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('REFRESH_AND_SET_VALUE', ip_item_sel, ip_item_val, NULL);
    pit.leave_optional;
  END refresh_and_set_value;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   set_console
  --
  --  Historie:
  --    07.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_console (ip_log_msg IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SET_CONSOLE', ip_log_msg);
    pit.leave_optional;
  END set_console;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   set_focus
  --
  --  Historie:
  --    17.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_focus (ip_item_sel IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SET_FOCUS', ip_item_sel);
    pit.leave_optional;
  END set_focus;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   set_item
  --
  --  Historie:
  --    08.04.2019 S. Harbrecht: Erstellung
  --    24.01.2020 J. Sieben: Erweiterung um IP_RAISE_EVENT, um auch SET_VALUE_ONLY abbilden zu koennen
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_item (ip_item_sel     IN VARCHAR2 DEFAULT 'DOCUMENT',
                      ip_item_value   IN VARCHAR2,
                      ip_jquery_sel   IN VARCHAR2 DEFAULT NULL,
                      ip_raise_event  IN BOOLEAN DEFAULT TRUE)
  AS
    s_action sct_action_type.sat_id%TYPE := 'SET_ITEM';
    s_item_value utl_apex.max_char;
    c_apos constant varchar2(1 byte) := '''';
  BEGIN
    pit.enter_optional;
    s_item_value := apex_escape.js_literal(ip_item_value);
    IF NOT ip_raise_event THEN
      s_action := 'SET_VALUE_ONLY';
      s_item_value := trim(c_apos from s_item_value);
    END IF;
    plugin_sct.execute_action(s_action, ip_item_sel, s_item_value, ip_jquery_sel);
    pit.leave_optional;
  END set_item;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   set_item_label
  --
  --  Historie:
  --    18.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_item_label (ip_item_sel    IN VARCHAR2 DEFAULT 'DOCUMENT',
                            ip_item_label  IN VARCHAR2,
                            ip_jquery_sel  IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SET_ITEM_LABEL', ip_item_sel, trim('''' from apex_escape.js_literal(ip_item_label)), ip_jquery_sel);
    pit.leave_optional;
  END set_item_label;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   set_modal_dialog_title
  --
  --  Historie:
  --    07.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_modal_dialog_title (ip_title IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SET_MODAL_DIALOG_TITLE', p_attribute_1 => ip_title);
    pit.leave_optional;
  END set_modal_dialog_title;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   set_null_disable
  --
  --  Historie:
  --    07.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_null_disable (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                              ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SET_NULL_DISABLE', ip_item_sel, null, ip_jquery_sel);
    pit.leave_optional;
  END set_null_disable;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   set_null_hide
  --
  --  Historie:
  --    07.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_null_hide (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                           ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                           ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SET_NULL_HIDE', ip_item_sel, ip_whole_row, ip_jquery_sel);
    pit.leave_optional;
  END set_null_hide;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   show_alert
  --
  --  Historie:
  --    12.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_alert (ip_focus_item_sel  IN VARCHAR2,
                        ip_msg_text        IN VARCHAR2,
                        ip_msg_type        IN VARCHAR2 DEFAULT 'Hinweis')
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SHOW_ALERT', ip_focus_item_sel, ip_msg_text, ip_msg_type);
    pit.leave_optional;
  END show_alert;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   show_error
  --
  --  Historie:
  --    07.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_error (ip_item_sel  IN VARCHAR2,
                        ip_msg_text  IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SHOW_ERROR', ip_item_sel, apex_escape.js_literal(ip_msg_text), NULL);
    pit.leave_optional;
  END show_error;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   show_hide_item
  --
  --  Historie:
  --    07.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_hide_item (ip_jquery_sel_show  IN VARCHAR2,
                            ip_jquery_sel_hide  IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SHOW_HIDE_ITEM', 'DOCUMENT', ip_jquery_sel_show, ip_jquery_sel_hide);
    pit.leave_optional;
  END show_hide_item;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   show_hint
  --
  --  Historie:
  --    08.04.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_hint (ip_msg_text  IN VARCHAR2,
                       ip_msg_type  IN VARCHAR2 DEFAULT 'Hinweis')
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SHOW_HINT', null, ip_msg_text, ip_msg_type); --get_msg(ip_msg_text)
    pit.leave_optional;
  END show_hint;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   show_item
  --
  --  Historie:
  --    07.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                       ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                       ip_jquery_sel IN VARCHAR2 DEFAULT NULL)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SHOW_ITEM', ip_item_sel, ip_whole_row, ip_jquery_sel);
    pit.leave_optional;
  END show_item;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   show_message
  --
  --  Historie:
  --    07.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_message (ip_focus_item_sel  IN VARCHAR2,
                          ip_msg_text        IN VARCHAR2,
                          ip_msg_type        IN VARCHAR2 DEFAULT 'Hinweis')
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('SHOW_MESSAGE', ip_focus_item_sel, ip_msg_text, ip_msg_type);
    pit.leave_optional;
  END show_message;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   wait_for_refresh
  --
  --  Historie:
  --    07.06.2019 S. Harbrecht: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE wait_for_refresh (ip_region_sel  IN VARCHAR2)
  AS
  BEGIN
    pit.enter_optional;
    plugin_sct.execute_action('WAIT_FOR_REFRESH', ip_region_sel);
    pit.leave_optional;
  END wait_for_refresh;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Procedure:   handle_bulk_errors
  --
  --  Historie:
  --    12.06.2020 J. Sieben: Erstellung
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE handle_bulk_errors (ip_mapping_list  IN char_table)
  AS
    TYPE mapping_table_t IS TABLE OF utl_apex.ora_name_type INDEX BY utl_apex.ora_name_type;
    mapping_table mapping_table_t;
    message_list pit_message_table;
    message message_type;
    l_page_item utl_apex.ora_name_type;
  BEGIN
    pit.enter_optional;
    -- Lese Fehlerliste aus PIT
    message_list := pit.get_message_collection;
    IF message_list.COUNT > 0 THEN
      -- Fehler ist aufgetreten, Mapping erstellen
      FOR i IN 1 .. ip_mapping_list.COUNT LOOP
        IF MOD(I, 2) = 1 THEN
          mapping_table(ip_mapping_list(i)) := ip_mapping_list(i + 1);
        END IF;
      END LOOP;
      
      FOR i IN 1 .. message_list.COUNT LOOP
        -- Mappe Error-Codes auf Seitenelemente und gebe Fehlermeldung aus
        message := message_list(i);
        IF mapping_table.EXISTS(message.error_code) THEN
          l_page_item := mapping_table(i);
        ELSE
          l_page_item := 'DOCUMENT';
        END IF;
        
        show_error(
          ip_item_sel => l_page_item,
          ip_msg_text => message.message_text);
      END LOOP;      
    END IF;
    pit.leave_optional;
  END handle_bulk_errors;
  ---------------------------------------------------------------------------------------------------------------


END utl_sct;
/
