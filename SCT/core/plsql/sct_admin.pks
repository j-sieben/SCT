create or replace package sct_admin
  authid current_user
as 

  /* getter-Funktionen fuer das PLUGIN_SCT und UI_SCT_PKG */
  /* Funktion liefert den Namen des ausloesenden APEX-Elements. Falls kein Element
   * ausgeloest hat, wird DOCUMENT geliefert.
   */
  function get_firing_item
    return varchar2;
    
    
  /* Prozedur erzeugt eine Antwort auf eine gegebene Situation im Session State 
   * fuer eine Regelgruppe
   * %param p_sgr_id ID der Regelgruppe, die ausgewertet werden soll
   * %param p_firing_item Element, das die Auswertung ausgeloest hat
   * %param p_firing_items Ausgabe aller Item-Namen, die durch das feuernde Element
   *        in einer Regel verbunden sind. Wird gebraucht, um selektiv Fehlermeldungen 
   *        zu entfernen
   * %param p_plsql_action List der PL/SQL-Aktionen, die in der Datenbank als
   *        Ergebnis der Auswertung ausgefuehrt werden sollen
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
    p_plsql_action out nocopy varchar2,
    p_js_action out nocopy varchar2);
    
  
  /* Administration von Regelgruppen
   * %usage Diese Methoden werden stand heute nicht von der APEX-Anwendung verwendet,
   *        Um die Daten in der Datenbank zu pflegen, sondern von Import-Skripten.
   */
  /* Erstellt eine Regelgruppe */
  procedure merge_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_sgr_description in sct_rule_group.sgr_description%type,
    p_sgr_active in sct_rule_group.sgr_active%type default sct_const.c_true);
    
    
  /* Entfernt eine Regelgruppe 
   * %param p_sgr_id ID der Regelgruppe, die entfernt werden soll
   * %usage Wird von UI_SCT_PKG aufgerufen, um eine Regelgruppe zu entfernen
   */
  procedure delete_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type);
    
  
  /* Prozedur zum erneuten Nummerieren der Spalten SORT_SEQ in einer Regelgruppe
   * %param p_sgr_id ID der Regelgruppe, die erneut nummeriert werden soll
   * %usage Wird von UI_SCT_PKG aufgerufen, um die Spalten SORT_SEQ der Tabellen
   *        SCT_RULE und SCT_RULE_ACTION auf 10er Schrittweite einzustellen.
   */
  procedure resequence_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type);
    
    
  /* Prozdur zum Kopieren einer Regelgruppe innerhalb oder zwischen APEX-Anwendungen
   * %param p_sgr_app_id Anwendungs-ID der Anwendung, aus der die Regelgruppe kopiert werden soll
   * %param p_sgr_page_id Seiten-ID der Anwendungsseite, aus der die Regelgruppe kopiert werden soll
   * %param p_sgr_name Name der Regelgruppe, die kopiert werden soll
   * %param p_sgr_app_to Anwendungs-ID der Anwendung, in die die Regelgruppe kopiert werden soll
   * %param p_sgr_page_to Seiten-ID der Anwendungsseite, auf die die Regelgruppe kopiert werden soll
   * %usage Wird verwendet, um eine Regelgruppe zwischen Anwendungen oder innerhalb einer Anwendung
   *        zwischen Seiten zu kopieren
   */
  procedure copy_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_app_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_app_to in sct_rule_group.sgr_app_id%type,
    p_sgr_page_to in sct_rule_group.sgr_page_id%type);
    
    
  -- Exportiert alle Regelgruppen einer Anwendung
  function export_rule_groups(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type)
    return clob;
    
  
  -- Export einer Regelgruppe nach ID
  function export_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return clob;
    
  
  -- Bereite Import einer Regegruppe in APEX-Anwendung vor
  procedure prepare_rule_group_import(
    p_app_alias in varchar2);
    
    
  function map_id(
    p_id in number default null)
    return number;
    
    
  /* Administration von Regeln */
  procedure merge_rule(
    p_sru_id in sct_rule.sru_id%type default null,
    p_sru_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_name in sct_rule.sru_name%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_sru_sort_seq in sct_rule.sru_sort_seq%type,
    p_sru_active in sct_rule.sru_active%type default sct_const.c_true);
    
    
  /* Methode zur Nachbereitung einer Regelaenderung, falls diese ueber eine
   * APEX-Seite durchgefuehrt wurde (Assistent-basierte Seite)
   */
  procedure propagate_rule_change(
    p_sgr_id in sct_rule_group.sgr_id%type);
    
  procedure validate_rule(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2);
    
    
  /* Administration von Regelaktivitaeten */
  procedure merge_rule_action(
    p_sra_sru_id in sct_rule.sru_id%type,
    p_sra_sgr_id in sct_rule_group.sgr_id%type,
    p_sra_spi_id in sct_page_item.spi_id%type,
    p_sra_sat_id in sct_action_type.sat_id%type,
    p_sra_attribute in sct_rule_action.sra_attribute%type,
    p_sra_attribute_2 in sct_rule_action.sra_attribute_2%type,
    p_sra_sort_seq in sct_rule_action.sra_sort_seq%type,
    p_sra_active in sct_rule_action.sra_active%type default sct_const.c_true);
    
    
  /* Administration von Aktionstypen */
  procedure merge_action_type(
    p_sat_id in sct_action_type.sat_id%type,
    p_sat_name in sct_action_type.sat_name%type,
    p_sat_pl_sql in sct_action_type.sat_pl_sql%type,
    p_sat_js in sct_action_type.sat_js%type,
    p_sat_is_editable in sct_action_type.sat_is_editable%type default sct_const.c_true,
    p_sat_raise_recursive in sct_action_type.sat_raise_recursive%type default sct_const.c_true);
    
end sct_admin;
/
