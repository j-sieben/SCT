create or replace package bl_sct 
as 
  
  /*** Get- bzw. Set-Funktionen fuer das PLUGIN_SCT und UI_SCT_PKG ***/
  /* Funktion liefert den Namen des ausloesenden APEX-Elements. Falls kein Element
   * ausgeloest hat, wird DOCUMENT geliefert.
   */
  function get_firing_item
    return varchar2;
    
  /* Funktion liefert eine Liste von Elementen, die durch den uebergebenen
   * jQuery-Ausdruck identifiziert werden konnten.
   * %param  p_spi_id       ITEM-ID, muss DOCUMENT sein, ansonsten wird von einem Element ausgegangen
   * %param  p_attribute_2  jQuery-Ausdruck, der zu Elementen evaluiert wird
   * %return Instanz von CHAR_TABLE mit den Namen der Elemente
   * %usage  Analysiert den uebergebenen jQuery-Ausdruck und ermittelt die angesprochenen Elemente.
   *         Moegliche Auspraegungen:
   *         - CSS-Klasse oder CSS-Klassen, durch Kommata getrennt
   *           Elemente muessen die entsprechende Klasse als Element-CSS enthalten
   *         - Komma-separierte Liste von IDs
   *           Die IDs muessen inklusive vorangestelltem #-Zeichen angegeben werden
   */
  function get_firing_items(
    p_spi_id in sct_page_item.spi_id%type,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type)
    return char_table;
    
  
  /* Liefert die Einstellung, welche Kommentare ausgegeben werden sollen
   */
  function get_comment_level
    return number;
    
  /* Setzt Kommentar-Level
   * %param  p_with_comment  Level, das angibt, welche Kommentare in JavaScript ausgegeben
   *                         werden sollen 
   *                         Werte entsprechen den Debugleveln aus PIT, Kommentare haben die
   *                         Ebenen 40, 50, 60 und 70
   * %usage  Wird verwendet, um festzulegen, welche Kommentare ausgegeben werden sollen
   */
  procedure set_comment_level(
    p_level in number);
    
    
  /* Getter/Setter fuer das Stop-Flag
   * %usage  Wird verwendet, um eine Regel zu stoppen
   */
  function get_stop_flag
    return boolean;
    
  procedure set_stop_flag;
    
  
  /* Setzt Flag, ob ein Fehler aufgetreten ist
   * %usage Wird durch PLUGIN_SCT aufgerufen, falls ein Fehler aufgetreten ist
   *        Das Flag wird mit jedem Rekursionslauf zurueckgesetzt, um zu ermoeglichen,
   *        das Fehlerhandling in der Rekursion ausgefuehrt wird
   */
  procedure set_error_flag;
  
  function get_error_flag
    return boolean;
    
  
  /*** Methoden zur Verarbeitung eines SCT-Aufrufs ***/
  /* Methode bereitet die Bearbeitung eines SCT-Aufrufs vor
   * %param  p_sgr_name               Name der Regelgruppe
   * %param  p_firing_item            Name des ausloesenden Elements
   * %param  p_error_dependent_items  Seitenelemente, die deaktiviert werden, wenn auf der Seite Fehler vorhanden sind
   * %usage  Wird verwendet, um einen SCT-Aufruf vorzubereiten und die noetigen Datenstrukturen zu initialisieren
   */
  procedure initialize_call(
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_firing_item in sct_page_item.spi_id%type,
    p_error_dependent_items in varchar2);

  
  /* Methode fuehrt Initialisierungscode aus falls in Regelgruppe vorhanden
   * %usage  Wird aufgerufen, um die Standardwerte der Seitenelemente zu berechnen, soweit moeglich. 
   *         Dies ist Voraussetzung dafuer, dass SCT die Initialisierungsregeln ohne Roundtrip zur 
   *         Anwendungsseite berechnen kann.
   */
  procedure process_initialization_code;
  

  /* Methode zur Verarbeitung einer Anfrage des SCT ueber die Oberflaeche
   * %return Antwort auf die Anfrage
   * %usage  Wird verwendet, um den aktuellen Sessionstatus gegen das hinterlegte Regelwerk auszufuehren und 
   *         eine passende Antwort fuer die aktuelle Situation zu formulieren
   */
  function process_request
    return clob;
    
      
  /* Funktion zum Auslesen aller geaenderter Seitenelemente im Session State.
   * %return JSON-Instanz aller Elemente und Elementwerte, die im Session State
   *         veraendert wurden
   * %usage  Die Funktion iteriert ueber alle Elemente, die waehrend der Aktualisierung
   *         durch REGISTER_ITEM vermerkt wurden und stellt sie mit aktuellem Elementwert
   *         zu einer JSON-Instanz zusammen, die als Teil der Antwort gesendet wird.
   *         Die Funktion wird bei jedem Refresh aufgerufen
   */
  function get_page_items
    return varchar2;
    
    
  /* Funktion zur Erzeugung eines JSON-Objekts fuer die relevanten Elemente
   * der Regelgruppe
   * %return JSON-Instanz mit ID und Event fuer alle relevanten Seitenelemente
   * %usage  Wird aufgerufen, wenn das Plugin initialisiert wird.
   *         Ermittelt alle relevanten Elemente der Regelgruppe, die einen Event binden sollen und 
   *         erstellt aus der Liste eine JSON-Instanz, die durch das Pugin zur Initialisierung ausgefuehrt wird.
   */
  function get_bind_items
    return varchar2;
    
    
  /* Funktion zur Ermittlung eines JSON-Strings mit den APEX-Actions dieser Regelgruppe
   * %param  p_sgr_id  ID der Regelgruppe, deren Aktionen ermittelt werden sollen
   * %usage  Wird verwendet, um beim Rendern der Seite eventuelle APEX-Actions auf der Seite zu platzieren.
   * %return JSON-Instanz, die auf der Seite im entsprechendne Kontext die APEX-Actions anlegt.
   */
  function get_apex_actions(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return clob;
  
  
  /* Methode zum Aufraeumen nach einem SCT-Aufruf
   * %usage  Wird verwendet, um nach einem SCT-Aufruf die Speicherstrukturen zu
   *         bereinigen
   */
  procedure terminate_call;
  
  
  /*** Methoden zur Implementierung von Aktionstyp-Funktionalitaet ***/
  
  /* Prozedur zum Setzen des Session Status
   * %param  p_item             Name des Feldes, das gesetzt werden soll
   * %param  p_value            Wert, der gesetzt werden soll
   * %param [p_allow_recursion] Flag, das anzeigt, ob die Aenderung des Wertes rekursive Regeln ausloesen soll
   * %param [p_attribute_2]     Optionaler Selektor, der mehrere Elemente identifiziert, die auf den gleichen Wert gesetzt
   *                            werden sollen
   * %usage  Wird verwendet, um den Session Status eines Elementes zu aendern.
   *         Die Prozedur ist ein Wrapper um APEX_UTIL.SET_SESSION_STATE, die aber nicht verwendet werden sollte, 
   *         weil mit PLUGIN_SCT.SET_SESSION_STATE Weg das Plugin alle Aenderungen am Session State registrieren und
   *         and die Oberflaeche zurueckliefern kann
   *         Der Parameter P_ATTRIBUTE_2 erlaubt die Uebergabe eines jQuery-Selektors, der eine Menge von Elementen identifiziert,
   +         die auf einen gleichen Wert gesetzt werden sollen. Sinnvoll z.B., um mehrere Elemente zu leeren
   */
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in number default sct_const.c_true,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null);
    
    
  /* Methode, um ein Element als verpflichtendes Element festzulegen
   * %param  p_spi_id                ID des Seitenelements
   * %param  p_spi_mandatory_mesage  Nachrichtentext, der ausgegeben werden soll, wenn gegen die Verpflichtung zum Ausfuellen
   *                                 verstoßen wird
   * %param  p_is_mandatory          Flag, das anzeigt, ob das Element ein Pflichtelement ist oder nicht
   * %param [p_attribute_2]          Optionaler Selektor, der mehrere Elemente identifiziert, die als Pflichtelement
   *                                 registriert werden sollen
   * %usage  Wird verwendet, um ein Element (oder eine Gruppe von Elementen) als Pflichtelement zu kennzeichnen oder nicht.
   *         Ein Pflichtelement wird beim Verlassen der Seite geprueft und gibt die uebergebene Fehlermeldung oder eine 
   *         Standardmeldung aus, wenn das Element Pflichtfeld und leer ist.
   *         Voraussetzung dieser Pruefung ist, dass die Seite durch SCT abgesendet wird.
   */
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type);
    
    
  /* Methode zum Pruefen, ob alle Pflichtelemente Werte enthalten
   * %param [p_spi_id] Falls angegeben, wird nur dieses Seitenelement geprueft, ansonsten alle Pflichtfelder der Seite
   * %usage  Wird aufgerufen, um zu Pruefen, ob das oder die Pflichtelemente der Seite einen Wert enthalten
   */
  procedure check_mandatory(
    p_spi_id in sct_page_item.spi_id%type default null);
    
  
  /* Methode zur Uebermittlung einer Meldung an den JavaScript-Stack
   * %param  p_text  Name der Meldung
   * %usage  Wird verwendet, um eine Meldung in die Antwort von SCT zu integrieren
   */
  procedure notify(
    p_text in varchar2);
    
  /* Ueberladung fuer PIT */
  procedure notify(
    p_message in varchar2,
    p_msg_args in msg_args);
    
    
  /* Prozedur zum dynamischen Ausfuehren eines berechneten JavaScript-Blocks
   * %param  p_plsql  PL/SQL-Anweisung, die das JavaScript berechnet, das ausgefuehrt werden soll
   * %usage  Wird verwendet, um in PL/SQL einen JavaScript-Block berechnen zu lassen,
   *         der anschliessend auf der Seite ausgefuehrt wird.
   */
  procedure execute_javascript(
    p_plsql in varchar2);
  
  
  /* Prozedur zum Registrieren von Fehlern
   * %param  p_error  Instanz eines APEX-Fehlers (APEX_ERROR.T_ERROR)
   * %usage  Wird automatisiert aufgerufen, wenn eine Aktivitaet ausgefuehrt wird.
   */
  procedure register_error(
    p_error apex_error.t_error);

end bl_sct;
/
