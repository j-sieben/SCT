create or replace package bl_sct 
as 
  
  /* getter-Funktionen fuer das PLUGIN_SCT und UI_SCT_PKG */
  /* Funktion liefert den Namen des ausloesenden APEX-Elements. Falls kein Element
   * ausgeloest hat, wird DOCUMENT geliefert.
   */
  function get_firing_item
    return varchar2;
    
  /* Funktion liefert eine Liste von Elementen, die durch den uebergebenen
   * jQuery-Ausdruck identifiziert werden konnten.
   * %param p_spi_id ITEM-ID, muss DOCUMENT sein, ansonsten wird von einem Element ausgegangen
   * %param p_attribute_2 jQuery-Ausdruck, der zu Elementen evaluiert wird
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
    p_attribute_2 in sct_rule_action.sra_attribute_2%type)
    return char_table;
    
  
  /* Liefert die Einstellung, ob Kommentare ausgegeben werden sollen oder nicht
   */
  function get_with_comments
    return boolean;
    
  /* Setzt Kommentar-Flag
   * %param p_with_comment Flag, das angibt, ob Kommentare in JavaScript ausgegeben
   *        werden sollen (TRUE) oder nicht (FALSE)
   */
  procedure set_with_comments(
    p_with_comment in boolean);
    
  
  /* Setzt Flag, ob ein Fehler aufgetreten ist
   * %usage Wird durch PLUGIN_SCT aufgerufen, falls ein Fehler aufgetreten ist
   *        Das Flag wird mit jedem Rekursionslauf zurueckgesetzt, um zu ermoeglichen,
   *        das Fehlerhandling in der Rekursion ausgefuehrt wird
   */
  procedure set_error_flag;
  
  function get_error_flag
    return boolean;
    
  /* Prozedur erzeugt eine Antwort auf eine gegebene Situation im Session State 
   * fuer eine Regelgruppe
   * %param p_sgr_id ID der Regelgruppe, die ausgewertet werden soll
   * %param p_firing_item Element, das die Auswertung ausgeloest hat
   * %param p_firing_items Ausgabe aller Item-Namen, die durch das feuernde Element
   *        in einer Regel verbunden sind. Wird gebraucht, um selektiv Fehlermeldungen 
   *        zu entfernen
   * %param p_js_action Liste der JavaScript-Aktionen, die auf der APEX-Seite als
   *        Ergebnis der Auswertung ausgefuehrt werden sollen
   * %usage Wird aus dem Plugin SCT aufgerufen, um fuer eine gegebene Seitensituation
   *        (die vorab im Session State hinterlegt wurde) die passende Regel zu
   *        finden und aus dieser Handlungsanweisungen fuer die weitere Bearbeitung
   *        abzuleiten.
   */
  procedure create_action(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_firing_item in sct_page_item.spi_id%type,
    p_is_recursive in number,    
    p_firing_items out nocopy varchar2,
    p_js_action out nocopy varchar2);
    

end bl_sct;
