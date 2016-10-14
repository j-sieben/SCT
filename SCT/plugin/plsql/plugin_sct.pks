create or replace package plugin_sct 
as 

  /* Package PLUGIN_SCT zur Verwaltung von State Charts
   * %author Juergen Sieben, ConDeS GmbH
   * %usage Das Package implementiert die datenbankseitige Logik des SCT-APEX-Plugins
   */
  
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
    
  /* Prozedur zur (De-)Registrierung von Pflichtelementen auf der Seite
   * %param p_spi_id Name des Pflichelements
   * %param p_spi_mandatory_message Optionale Benachrichtigung beim Regelverstoss
   * %param p_is_mandatory Flag, das anzeigt, ob das Element ein Pflichtelement
   *        ist oder nicht.
   * %usage Wird aufgerufen, um Pflichtelemente im Plugin zu registrieren.
   *        Pflichtelemente werden vor dem Absenden der Seite durch das Plugin
   *        gegen den SessionState geprueft, um sicherzustellen, dass ein Wert
   *        enthalten ist.
   *        Bei einem Verstoss wird die SUBMIT-Anweisung nicht gesendet.
   */
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean);
    
    
  /* Hilfsmethode, prueft, ob ein Pflichtfeld NULL ist und registriert entsprechenden Fehler
   * %param p_firing_item Name des Elements, das sich geaendert hat
   * %usage Wird verwendet, wenn SCT Pflichtfelder verwaltet.
   */
  procedure check_mandatory(
    p_firing_item in sct_page_item.spi_id%type);
    
    
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
   *        die aber nicht verwendet werden sollte, weil mit PLUGIN_SCT.SET_SESSION_STATE
   *        Weg das Plugin alle Aenderungen am Session State registrieren und
   *        and die Oberflaeche zurueckliefern kann
   */
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2);
    
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in date);
    
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in number);

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
