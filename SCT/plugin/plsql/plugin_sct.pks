create or replace package plugin_sct 
as 

  /* Package PLUGIN_SCT zur Verwaltung von State Charts
   * %author Jürgen Sieben, ConDeS Gmbh & Co. KG
   * %usage Das Package implementiert die datenbankseitige Logik des SCT-APEX-Plugins
   */
  
  /* Prozedur zum Registrieren von Fehlern
   * %param p_item Name des Feldes, das den Fehler enthaelt
   * %param Fehlermeldung, die registriert werden soll
   * %param Optionale zweite, technische Fehlermeldung
   * %usage Wird automatisiert aufegrufen, wenn eine Aktivitaet ausgefuehrt wird.
   *        Existiert eine technische Fehlermeldung und wird eine anwendungsseitige
   *        Fehlermeldung produziert kann die technische Fehlermeldung als
   *        Parameter P_INTERNAL_ERROR uebergeben werden. In jedem Fall muss
   *        P_ERROR_MSG einen Wert enthalten.
   */
  procedure register_error(
    p_item in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null);

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