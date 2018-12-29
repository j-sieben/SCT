create or replace package plugin_sct
  authid definer
as 

  /* Package PLUGIN_SCT zur Verwaltung von State Charts
   * %author Juergen Sieben, ConDeS GmbH
   * %usage Das Package implementiert die datenbankseitige Logik des SCT-APEX-Plugins
   */
   
  procedure stop_rule;
  
  
  /* Methode zur Registrierung eines Elements im Rekursionsstack
   * %param p_item Name des Elements
   * %param p_allow_recursion Flag, das anzeigt, ob Rekursion erlaubt ist oder nicht
   * %usage Wird normalerweise nicht explizit benoetigt.
   */
  procedure register_item(
    p_item in varchar2,
    p_allow_recursion in number default utl_apex.C_TRUE);
    
  
  /* Prozedur zum Registrieren von Fehlern
   * %param p_spi_id Name des Feldes, das den Fehler enthaelt
   * %param p_error_msg Fehlermeldung, die registriert werden soll
   * %param p_internal_error Optionale zweite, technische Fehlermeldung
   * %usage Wird automatisiert aufgerufen, wenn eine Aktivitaet ausgefuehrt wird.
   *        Existiert eine technische Fehlermeldung und wird eine anwendungsseitige
   *        Fehlermeldung produziert kann die technische Fehlermeldung als
   *        Parameter P_INTERNAL_ERROR uebergeben werden. In jedem Fall muss
   *        P_ERROR_MSG einen Wert enthalten.
   */
  procedure register_error(
    p_spi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null);
  
  function has_errors
    return boolean;
    
  function has_no_errors
    return boolean;
  
  
  /* Ueberladung als Schnittstelle zu PIT
   * %param p_spi_id Name des Feldes, das den Fehler enthaelt
   * %param p_message_name Fehlermeldung, Referenz auf PIT-Nachricht
   * %param p_arg_list Liste von PIT-Meldungsparametern
   * %usage Wird automatisiert aufgerufen, wenn eine Aktivitaet ausgefuehrt wird.
   *        Es wird eine, in PIT definierte Meldung aufgerufen und optional
   *        die erforderlichen Parameter uebergeben.
   *        Die Ausgabe wird in den Error-Stack des Plugins integriert.
   */
  procedure register_error(
    p_spi_id in varchar2,
    p_message_name in varchar2,
    p_arg_list in msg_args default null);
    
  
  /* Prozedur zum Registrieren von Meldungen
   * %param p_text Meldungstext
   * %usage Wird aufgerufen, wenn waehrend der Verarbeitung innerhalb der Datenbank
   *        eine Information an die Antwort uebermittelt werden soll, die aktuell
   *        bearbeitet wird. Die Meldungen werden zu den entsprechenden Prozessen
   *        als Kommentare der Antwort vor dem JavaScript-Code ausgegeben
   */
  procedure register_notification(
    p_text in varchar2);
    
    
  /* Ueberladung als Schnittstelle zu PIT
   * %param p_message_name Fehlermeldung, Rferenz auf PIT-Nachricht
   * %param p_arg_list Liste von PIT-Meldungsparmetern
   * %usage Wird aufgerufen, wenn waehrend der Verarbeitung innerhalb der Datenbank
   *        eine Informaiton an die Antwort uebermittelt werden soll.
   *        Es wird eine, in PIT definierte Meldung uafgerufen und optional
   *        die erforderlichen Parameter uebergeben.
   */
  procedure register_notification(
    p_message_name in varchar2,
    p_arg_list in msg_args);
    
    
  /* Prozedur zur (De-)Registrierung von Pflichtelementen auf der Seite
   * %param p_spi_id Name des Pflichelements
   * %param p_spi_mandatory_message Optionale Benachrichtigung beim Regelverstoss
   * %param p_is_mandatory Flag, das anzeigt, ob das Element ein Pflichtelement
   *        ist oder nicht.
   * %param p_param_2 Optionales Argument, das genutzt wird, wenn mehrere Elemente
   *        ueber einen jQuery-Ausdruck angesprochen werden.
   * %usage Wird aufgerufen, um Pflichtelemente im Plugin zu registrieren.
   *        Pflichtelemente werden vor dem Absenden der Seite durch das Plugin
   *        gegen den SessionState geprueft, um sicherzustellen, dass ein Wert
   *        enthalten ist.
   *        Bei einem Verstoss wird die SUBMIT-Anweisung nicht gesendet.
   */
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean,
    p_param_2 in sct_rule_action.sra_param_2%type default null);
    
    
  /* Hilfsmethode, prueft, ob ein Pflichtfeld NULL ist und registriert entsprechenden Fehler
   * %param p_firing_item Name des Elements, das sich geaendert hat
   * %usage Wird verwendet, wenn SCT Pflichtfelder verwaltet.
   */
  procedure check_mandatory(
    p_firing_item in sct_page_item.spi_id%type);
    
  
  /* Getter Methods
   */
  function get_firing_item
    return varchar2;
    
  function get_event
    return varchar2;
    
    
  /* Hilfsmethode, ermittelt den Zeichenkettenwert eines Anwendungselements.
   * %param  p_spi_id       Names des Elements, dessen Wert ermittelt werden soll
   * %return Sessionstatuswert
   * %usage  Wird verwendet, um den aktuellen Sessionstatus fuer ein Element zu ermitteln.
   *         In Erweiterung zu V(P_SPI_ID) wird ein eventueller Defaultwert zurueckgegeben, wenn
   *         das Element ein Pflichtfeld ist und ansonsten NULL waere.
   *         Der Standardwert wird aus den APEX-Metadaten zum Feld ermittelt
   */
  function get_char(
    p_spi_id in varchar2)
    return varchar2;
    
    
  /* Hilfsmethode, prueft, ob sich ein Element aus dem Sessionstatus in eine Zahl ueberfuehren laesst.
   * %param  p_spi_id       Names des Elements, dessen Wert umgeformt werden soll
   * %param  p_format_mask  Formatmaske, die den Wert umformen soll
   * %param [p_throw_error] TRUE: bei nicht erfolgreicher Umformung wird ein Fehler registriert und zusaetzlich geworfen
   *                        FALSE: bei nicht erfolgreicher Umformung wird ein Fehler nur registriert
   *                        Default: TRUE
   * %return Zahlwert nach der Umwandlung
   * %usage  Wird verwendet, um eine Umwandlung in eine Zahl durchzufuehren.
   *         Gelingt die Umformung nicht, wird ein Fehler registriert und ein weiterer Fehler geworfen,
   *         falls dies von P_THROW_ERROR angefordert wird. Hierdurch wird die weitere Verarbeitung
   *         der Regel abgebrochen
   *         Ist das Element ein Pflichtfeld, wird ein eventueller Defaultwert zurueckgegeben, wenn
   *         das Element ansonsten NULL waere
   */
  function get_number(
    p_spi_id in varchar2,
    p_format_mask in varchar2,
    p_throw_error in boolean default false)
    return number;
    
  
  /* Methode prueft, ob ein Eingabefeld einen gueltigen Zahlwert enthaelt.
   * %param  p_spi_id Name des Eingabefeldes
   * %usage  Wird verwendet, um zu pruefen, ob ein Eingabefeld einen numerischen Wert
   *         enthaelt. Hierzu schlaegt die Methode die Formatmaske des Eingabefeldes
   *         nach und versucht eine entsprechende Konvertierung. Gelingt diese nicht,
   *         wird ein entsprechender Fehler registriert.
   */
  procedure check_number(
    p_spi_id in varchar2);
    
    
  /* Hilfsmethode, prueft, ob sich ein Element aus dem Sessionstatus in ein Datum ueberfuehren laesst.
   * %param  p_spi_id       Names des Elements, dessen Wert umgeformt werden soll
   * %param  p_format_mask  Formatmaske, die den Wert umformen soll
   * %param [p_throw_error] TRUE: bei nicht erfolgreicher Umformung wird ein Fehler registriert und zusaetzlich geworfen
   *                        FALSE: bei nicht erfolgreicher Umformung wird ein Fehler nur registriert
   *                        Default: TRUE
   * %return Datumswert nach der Umwandlung
   * %usage  Wird verwendet, um eine Umwandlung in eine Zahl durchzufuehren.
   *         Gelingt die Umformung nicht, wird ein Fehler registriert und ein weiterer Fehler geworfen,
   *         falls dies von P_THROW_ERROR angefordert wird. Hierdurch wird die weitere Verarbeitung
   *         der Regel abgebrochen
   *         Ist das Element ein Pflichtfeld, wird ein eventueller Defaultwert zurueckgegeben, wenn
   *         das Element ansonsten NULL waere
   */
  function get_date(
    p_spi_id in varchar2,
    p_format_mask in varchar2,
    p_throw_error in boolean default false)
    return date;
    
  
  /* Methode prueft, ob ein Eingabefeld ein gueltiges Datum enthaelt.
   * %param  p_spi_id Name des Eingabefeldes
   * %usage  Wird verwendet, um zu pruefen, ob ein Eingabefeld ein gueltiges Datum
   *         enthaelt. Hierzu schlaegt die Methode die Formatmaske des Eingabefeldes
   *         nach und versucht eine entsprechende Konvertierung. Gelingt diese nicht,
   *         wird ein entsprechender Fehler registriert.
   */
  procedure check_date(
    p_spi_id in varchar2);
    
  
  /* Prozedur zum Ausfuehren eines PL/SQL-Blocks
   * %param  p_cmd  Anweisung, die ausgefuehrt werden soll.
   * %usage  Wird verwendet, um dynamische PL/SQL-Aufrufe auszufuehren
   */
  procedure do_cmd(
    p_cmd in varchar2);
    
    
  /* Prozedur zur Vorbereitung des Speicherns der Seite
   * %usage Diese Prozedur sollte nur verwendet werden, wenn SCT eine Seite
   *        vollstaendig verwaltet. Die Prozedur prueft alle Seitenelemente,
   *        die durch SCT auf MANDATORY gesetzt wurden, gegen den Session-State.
   *        Ist ein Pflichtfeld NULL wird ein Fehler registriert und das Absenden
   *        der Seite dadurch verhindert.
   */
  procedure submit_page;
  
  
  /* Prozedur zum Setzen des Session Status
   * %param p_item Name des Feldes, das gesetzt werden soll
   * %param p_value Wert, der gesetzt werden soll
   * %usage Wird verwendet, um den Session Status eines Elementes zu aendern.
   *        Die Prozedur ist ein Wrapper um APEX_UTIL.SET_SESSION_STATE,
   *        die aber nicht verwendet werden sollte, weil PLUGIN_SCT.SET_SESSION_STATE
   *        alle Aenderungen am Session State registriert und an die Oberflaeche zurueckliefert
   */
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in utl_apex.flag_type default utl_apex.C_TRUE,
    p_param_2 in sct_rule_action.sra_param_2%type default null);
    
    
  /* Prozedur zum Setzen des Session Status, falls kein Fehler vorliegt.
   * %param p_item Name des Feldes, das gesetzt werden soll
   * %param p_value Wert, der gesetzt werden soll
   * %param p_error Fehlermeldung. Falls NULL, wird Session State gesetzt, sonst Fehler
   * %usage Wird verwendet, um als Ergebnis einer externen Validierung mit Fehlertext
   *        eine Hilfsfunktion anzubieten, die selbststaendig zwischen Fehlermeldung und
   *        Session State entscheidet.
   */
  procedure set_session_state_or_error(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_error in varchar2,
    p_allow_recursion in utl_apex.flag_type default utl_apex.C_TRUE);
    
    
  /* Prozedur zum Setzen des Session Status, basierend auf einer SQL-Anweisung
   * %param  p_item Name des Feldes, das gesetzt werden soll
   * %param  p_stmt select-Anweisung, die eine einzelne Zeile liefert
   * %usage  Wird verwendet, um den Wert eines oder mehrerer Elemente im Sessionstatus zu setzen
   *         Zwei Anwendungsmodi:
   *         - P_ITEM ist auf Elementnamen gesetzt (Ersetzungsanker #ITEM#, entspricht SEITENELEMENT in Aktion)
   *           In diesem Modus darf die Anweisung nur eine Spalte zurueckliefern, der Wert wird in 
   *           das uebergebene Element gesetzt
   *         - P_ITEM ist DOCUMENT oder NULL
   *           In diesem Modus darf die Anweisung mehrere Spalten liefern. Die Spaltenbezeichner 
   *           muessen Elementnamen entsprechen, die Abfrageergebnisse werden in den zugehoerigen
   *           Seitenelementen gesetzt
   */
  procedure set_value_from_stmt(
    p_item in sct_page_item.spi_id%type,
    p_stmt in varchar2);
    
    
  /* Prozedur zum Setzen des Session Status, basierend auf einer SQL-Anweisung, die eine
   * Liste von Werten zurueckliefert
   * %param p_item Name des Feldes, das gesetzt werden soll
   * %param p_stmt select-Anweisung, die eine Liste von Werten liefert
   */
  procedure set_list_from_stmt(
    p_item in sct_page_item.spi_id%type,
    p_stmt in varchar2);
    
    
  /* Methode gibt eine Meldung auf der Oberflaeche aus.
   * %param  p_message  Meldung oder PL/SQL-Aufruf, der eine Meldung erzeugt
   * %usage  Wird verwendet, um eine Meldung auf der APEX-Oberflaeche auszugeben.
   *         Zwei Benutzungsvarianten:
   *         - Uebergabe einer Zeichenkette, die als konstante Meldung ausgegeben wird
   *         - Uebergabe einer PL/SQL-Funktion, die eine Zeichenkette mit der Meldung liefert
   */
  procedure notify(
    p_message in varchar2);
    
    
  /* Method to directly execute a SCT action from PL/SQL
   * %param  p_sat_id   Reference to SCT_ACTION_TYPE, action to execute
   * %param  p_item     Page item or DOCUMENT, references the page item the action shall work with
   * %param [p_param_1] Optional first parameter
   * %param [p_param_2] Optional second parameter
   * %param [p_param_3] Optional third parameter
   * %usage  Is used to directly execute an SCT action in case logic needs to perfrom a wider variety of
   *         steps, fi when configuring a page. Executing the SCT actions directly helps reduce the need 
   *         to create many rules with rather similar conditions
   */
  procedure execute_action(
    p_sat_id in varchar2,
    p_item in varchar2,
    p_param_1 in varchar2 default null,
    p_param_2 in varchar2 default null,
    p_param_3 in varchar2 default null);
    
    
  /* Prozedur zum dynamischen Ausfuehren eines berechneten JavaScript-Blocks
   * %param p_plsql PL/SQL-Anweisung, die das JavaScript berechnet, das ausgefuehrt werden soll
   * %usage Wird verwendet, um in PL/SQL einen JavaScript-Block berechnen zu lassen,
   *        der anschliessend auf der Seite ausgefuehrt wird.
   */
  procedure execute_javascript(
    p_plsql in varchar2);
    
    
  /* Prozedur fuegt berechnetes JavaScript der Antwort hinzu
   * %param  p_javascript  JavaScript-Code der ausgefuehrt werden soll
   * %usage  Wird verwendet, um andernorts berechnetes JavaScript in die Antwort zu integrieren.
   *         Funktional eine Ueberladung der Prozedur EXECUTE_JAVSCRIPT, nur das hier extern der
   *         auszufuehrende Script berechnet wird.
   */
  procedure add_javascript(
    p_javascript in varchar2);
    
  /* XOR-Methoden
   * %param  p_value_list     Liste von Element-NAMEN, die geprueft werden sollen
   * %param [p_error_on_null] Flag, das anzeigt, ob ein Fehler geworfen werden soll,
   *                          wenn alle Elemente NULL-Werte sind
   * %raises MSG.ASSERTION_FAILED_ERR, wenn 
   *         - Mehr als ein Elementwert NOT NULL ist
   *         - Alle Elementwerte NULL sind und P_ERROR_ON_NULL gesetzt ist
   * %usage  Wird verwendet, um innerhalb einer SCT-Aktion sicherzustellen, dass
   *         Genau ein Wert ausgewaehlt wurde. Falls ein Verstoss vorliegt, kann im 
   *         Exception-Teil auf diesen Fehler reagiert werden
   */
  procedure xor(
    p_item in varchar2,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED,
    p_error_on_null in boolean default false);
    
  
  /* Ueberladung als Funktion
   * %param  p_value_list  Liste von Element-WERTEN (Spaltenwerten), die geprueft werden sollen
   * %return - 1, falls Bedindung erfuellt
   *         - 0, falls Bedingung nicht erfuellt
   *         - NULL, falls alle Elemente NULL sind
   * %usage  Wird verwendet, um in einer Regelpruefung auf XOR zu testen
   */
  function xor(
    p_value_list in varchar2)
    return number;
    
    
  /* Methode zur Pruefung, dass mindestens ein Wert gesetzt ist
   * %param  p_value_list  Liste von Element-NAMEN, die geprueft werden sollen
   * %usage  Wird verwendet, um innerhalb einer SCT-Aktion sicherzustellen, dass
   *         mindestens ein Wert gesetzt wurde. Falls ein Verstoss vorliegt, kann im 
   *         Exception-Teil auf diesen Fehler reagiert werden
   * %raises MSG.ASSERTION_FAILED_ERR, falls alle Elementwerte NULL waren
   */
  procedure not_null(
    p_item in varchar2,
    p_value_list in varchar2,
    p_message in varchar2 default msg.ASSERTION_FAILED);
    
  
  /* Ueberladung als Funktion
   * %param  p_value_list  Liste von Element-WERTEN (Spaltenwerten), die geprueft werden sollen
   * %return - 1, falls Bedindung erfuellt
   *         - 0, falls Bedingung nicht erfuellt
   * %usage  Wird verwendet, um in einer Regelpruefung auf NOT NULL zu testen
   */
  function not_null(
    p_value_list in varchar2)
    return number;
    

  /* RENDER-Funktion des Plugins gem. APEX-Vorgaben */
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result;
    
  /* AJAX-Funktion des Plugins gem. APEX-Vorgaben */
  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result;

end plugin_sct;
/
