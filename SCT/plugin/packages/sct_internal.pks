create or replace package sct_internal
  authid definer
  accessible by (package plugin_sct, package sct_ui, package sct_validation, package sct_ui)
as 
  
  type environment_rec is record(
    sgr_id sct_rule_group.sgr_id%type,               -- ID der Regelgruppe
    sru_id sct_rule.sru_id%type,                     -- ID der Regel
    firing_item sct_page_item.spi_id%type,           -- Element das die Bearbeitung ausloest (oder DOCUMENT)
    firing_event sct_page_item_type.sit_event%type   -- Ereignis das die Bearbeitung ausloest
  );
  
  C_PAGE_ITEMS constant number := 1;
  C_FIRING_ITEMS constant number := 2;
  
  /* getter-Funktionen fuer das PLUGIN_SCT und UI_SCT_PKG */
  /* Funktion liefert den Namen des ausloesenden APEX-Elements. Falls kein Element
   * ausgeloest hat, wird DOCUMENT geliefert.
   */
  function get_firing_item
    return varchar2;
    
  function get_event
    return varchar2;
    
  /* Funktion liefert eine Liste von Elementen, die durch den uebergebenen
   * jQuery-Ausdruck identifiziert werden konnten.
   * %param p_spi_id ITEM-ID, muss DOCUMENT sein, ansonsten wird von einem Element ausgegangen
   * %param p_param_2 jQuery-Ausdruck, der zu Elementen evaluiert wird
   * %return Instanz von CHAR_TABLE mit den Namen der Elemente
   * %usage Analysiert den uebergebenen jQuery-Ausdruck und ermittelt die angesprochenen Elemente.
   *        Moegliche Auspraegungen:
   *        - CSS-Klasse oder CSS-Klassen, durch Kommata getrennt
   *          Elemente muessen die entsprechende Klasse als Element-CSS enthalten
   *        - Komma-separierte Liste von IDs
   *          Die IDs muessen inklusive vorangestelltem #-Zeichen angegeben werden
   */
  function get_firing_items(
    p_spi_id in sct_page_item.spi_id%type,
    p_param_2 in sct_rule_action.sra_param_2%type)
    return char_table;
    
  
  /* Stack maintenance */
  /* Stackverwaltung, legt ein Seitenelement auf den Elementestack
   * %param p_item_name Name des Seitenelements, das auf den Stack gelegt werden soll
   * %usage Wird verwendet, um Elementlisten fuer Seitenelemente zu pflegen
   */
  procedure push_page_item(
    p_item_name in sct_page_item.spi_id%type);
    
    
  /* Stackverwaltung, legt ein zu bindendes Element auf den Elementestack
   * %param p_item_name Name des Seitenelements, das auf den Stack gelegt werden soll
   * %usage Wird verwendet, um Elementlisten fuer relevante Seitenelemente zu pflegen
   */
  procedure push_bind_item(
    p_item_name in sct_page_item.spi_id%type);
    
    
  /* Stackverwaltung, legt ein feuerndes Element auf den Elementestack
   * %param p_item_name Name des Seitenelements, das auf den Stack gelegt werden soll
   * %usage Wird verwendet, um Elementlisten fuer aufrufende Elemente zu pflegen
   */
  procedure push_firing_item(
    p_item_name in varchar2);
  
    
  /* Stackverwaltung, legt einen Fehler auf den Fehlerstack
   * %param  p_error  APEX-Fehler, der auf den Fehlerstack gelegt werden soll
   * %usage  Wird verwendet, um eine Liste der aufgelaufenden Fehler zu pflegen
   */
  procedure push_error(
    p_error in apex_error.t_error);
    
    
  /* Hilfsprozedur zum Zusammenfuehren einer Liste von Werten des Item-Stacks in eine
   * Liste, getrennt durch C_DELIMITER
   * %param p_list Eine der Konnstanten C_PAGE_ITEMS|C_FIRING_ITEMS
   * %return Zeichenkette mit den zusammengefuehrten Elementen
   * %usage Wird verwendet, um eine Liste von Werten zur Uebergabe an die JSON-Antwort
   *        zu generieren.
   */
  function join_list(
    p_list in number)
    return varchar2;
  
    
  /* Hilfsprozedur zum Umkopieren der Attribute auf einen globalen Record
   * %param  p_firing_item           Ausloesendes Element
   * %param  p_event                 Ausloesendes Ereignis
   * %param  p_with_comments         Flag, das die Menge der Ausgabekommentare steuert
   * %param  p_rule_group_name       Name der Regelgruppe
   * %param  p_error_dependent_items Liste der Elemente, die bei Fehlern deaktiviert werden
   * %usage  Wird vor dem Rendern und Refresh aufgerufen, um an zentraler Stelle
   *         die APEX-Parameter auf lokale Variablen zu kopieren
   */
  procedure read_settings(
    p_firing_item in varchar2,
    p_event in varchar2,
    p_with_comments in varchar2,
    p_rule_group_name in varchar2,
    p_error_dependent_items in varchar2);
    
    
  procedure notify(
    p_message in varchar2);
  
  
  procedure execute_javascript(
    p_plsql in varchar2);
      
      
  procedure add_javascript(
    p_javascript in varchar2);
    
  /* Hilfsfunktion zur Erzeugung eines JSON-Objekts fuer die relevanten Elemente
   * der Regelgruppe
   * %return JSON-Instanz mit ID und Event fuer alle relevanten Seitenelemente
   * %usage Wird aufgerufen, wenn das Plugin initialisiert wird.
   *        Ermittelt alle relevanten Elemente der Regelgruppe, die einen Event
   *        binden sollen und erstellt aus der Liste eine JSON-Instanz, die durch
   *        das Pugin zur Initialisierung ausgefuehrt wird.
   */
  function get_json_from_bind_items
    return clob;
  
  
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in sct_util.flag_type default sct_util.C_TRUE,
    p_param_2 in sct_rule_action.sra_param_2%type default null);
    
    
  /* MANDATORY MAINTENANCE */
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean,
    p_param_2 in sct_rule_action.sra_param_2%type default null);
    
    
  procedure check_mandatory(
    p_firing_item in sct_page_item.spi_id%type,
    p_push_item out nocopy sct_page_item.spi_id%type);
    
    
  /* CONVERSION FUNCTIONS */
  function get_char(
    p_spi_id in sct_page_item.spi_id%type)
    return varchar2;
  
  
  function get_number(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in boolean default false)
    return number;
    
  
  procedure check_number(
    p_spi_id in sct_page_item.spi_id%type);
    
    
  function get_date(
    p_spi_id in sct_page_item.spi_id%type,
    p_format_mask in varchar2,
    p_throw_error in boolean default false)
    return date;
    
  
  procedure check_date(
    p_spi_id in sct_page_item.spi_id%type);
    
  
  /* Setzt Flag, ob ein Fehler aufgetreten ist
   * %usage Wird durch PLUGIN_SCT aufgerufen, falls ein Fehler aufgetreten ist
   *        Das Flag wird mit jedem Rekursionslauf zurueckgesetzt, um zu ermoeglichen,
   *        das Fehlerhandling in der Rekursion ausgefuehrt wird
   */
  procedure set_error_flag;
  
  function get_error_flag
    return boolean;  
    
    
  procedure register_item(
    p_item in varchar2,
    p_allow_recursion in sct_util.flag_type default sct_util.C_TRUE);
    
    
  /* Methode analysiert, welche Seitenelemente durch die Aktion C_REGISTER_OBSERVER bei jedem
   * Ereignis in den Session State kopiert werden muessen.
   * %usage Wird waehrend der Initialisierung aufgerufen, um alle Elemente zu ermitteln,
   *        deren Werte auf der Oberflaeche beim Ausloesen eines Events in den Session State
   *        kopiert werden sollen. Dies ist erforderlich, wenn Elementwerte benoetigt werden,
   *        auf den Elementen selbst aber keine Regeln aufgebaut werden sollen
   */
  function register_observer
    return varchar2;
    
    
  procedure register_error(
    p_spi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2);
    
  
  procedure register_error(
    p_spi_id in varchar2,
    p_message_name in varchar2,
    p_arg_list in msg_args default null);
    
    
  procedure register_notification(
    p_text in varchar2);
  
  
  procedure register_notification(
    p_message_name in varchar2,
    p_arg_list in msg_args);
    
    
  procedure submit_page;
    
  
  procedure stop_rule;
      
  
  /* Hilfsmethode zur Ausgabe von Seitenelementwerten, basierend auf einem Filter
   * %param  p_filter  Instanz von CHAR_TABLE mit einer Kombination aus CSS-Klassen oder Elementnamen
   * %return Werte der gewählten Instanzen, ohne Verweis auf die Herkunft, nur die Werte
   * %usage  Wird verwendet, um fuer eine Liste von Selektoren die Elementwerte auszugeben
   *         Nur zur internen Verwendung, nicht ausserhalb des Packages verwenden.
   */
  function pipe_page_values(
    p_filter in varchar2)
    return char_table pipelined;
    
    
  procedure xor(
    p_item in varchar2,
    p_value_list in varchar2,
    p_message in varchar2,
    p_error_on_null in boolean default false);
    
  
  function xor(
    p_value_list in varchar2)
    return number;
    
    
  procedure not_null(
    p_item in varchar2,
    p_value_list in varchar2,
    p_message in varchar2);
    
    
  function not_null(
    p_value_list in varchar2)
    return number;
      
  /* Methode fuehrt Initialisierungscode aus falls in Regelgruppe vorhanden
   * %usage Wird aufgerufen, um die Standardwerte der Seitenelemente zu berechnen,
   *        soweit moeglich. Dies ist Voraussetzung dafuer, dass SCT die Initialisierungsregeln
   *        ohne Roundtrip zur Anwendungsseite berechnen kann.
   */
  procedure process_initialization_code;

  
  /* Methode zur Verarbeitung einer Anfrage des SCT ueber die Oberflaeche
   * %return Antwort auf die Anfrage
   * %usage Wird verwendet, um den aktuellen Sessionstatus gegen das hinterlegte
   *        Regelwerk auszufuehren und eine passende Antwort fuer die aktuelle
   *        Situation zu formulieren
   */
  function process_request
    return clob;
end sct_internal;
/
