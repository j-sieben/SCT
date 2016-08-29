create or replace package sct_admin
  authid current_user
as

  /* Package SCT_ADMIN maintenance package for State Chart Toolkit SCT
   * %author Jürgen Sieben, ConDeS Gmbh & Co. KG
   * %usage Used to maintain metadata for the SCT
   *        The methods provided here are called using the packages
   *        - UI_SCT_PKG as an interface for the APEX application for SCT
   *        - PLUGIN_SCT as an interface for the APEX Dynamic Action Plugin
   */
    
  
  /* Funktion zur Ermittlung des View-Namens fuer eine gegebene Regelgruppe
   * %param p_sgr_name Name der Regelgruppe
   * %return Name der durch dieses Package erzeugten View
   * %usage Wird von SCT_PKG aufgerufen, um fuer eine gegebene Regelgruppe den
   *        aktuellen View-Namen zu erfragen
   */
  function get_view_name(
    p_sgr_id sct_group.sgr_id%type)
    return varchar2;
    
    
  /* Getter fuer den Namen der JavaScript-Funktion, die im Plugin genutzt wird
   * %return Name der Funktion
   * %usage Wird hier gesetzt, weil der Name auch bei der Erzeugung von JavaScript
   *        Skripten genutzt wird
   */
  function get_js_function
    return varchar2;
    
    
  /* Getter fuer den Namen des JavaScript-Namensraums fuer das Plugin
   * %return Name des Namensraums
   * %usage Wird hier gesetzt, weil der Name auch bei der Erzeugung von JavaScript
   *        Skripten genutzt wird
   */
  function get_js_namespace
    return varchar2;
    
    
  /* Funktion zur Ermittlung des ausloesenden Elements
   * %usage Wird verwendet, um aus SQL Zugriff auf den Namen des Elements zu erhalten,
   *        das die Regelberechnung ausgeloest hat.
   */
  function get_firing_item
    return varchar2;
  
  
  /* Prozedur zur Erzeugung der PL/SQL- und JavaScript-Aktion fuer den aktuellen
   * Sessionstatus
   * %param p_sgr_id ID der Regelgruppe
   * %param p_plsql_action Reuckgabeparameter fuer die PL/SQL-Aktion
   * %param p_js_action Reuckgabeparameter fuer die JavaScript-Aktion
   * %usage Wird vom Plugin aufgerufen, um fuer den aktuellen Sessionstatus die
   *        folgenden Aktionen zu berechnen
   */
  procedure create_action(
    p_sgr_id in sct_group.sgr_id%type,
    p_firing_item in varchar2,
    p_plsql_action out nocopy varchar2,
    p_js_action out nocopy varchar2);
    
  
  /* Bereich Verwaltung der Regeln und Regelgruppen */
  
  /* Prozedur zur Anlage oder Aenderung einer Regelgruppe 
   * %param p_sgr_app_id ID der APEX-Anwendung, fuer die die Regelgruppe gelten soll
   * %param p_sgr_page_id ID der APEX-Anwendungsseite, fuer die die Regelgruppe gelten soll
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sgr_name Klartextbezeichnung der Regelgruppe
   * %param p_sgr_description Beschreibung der Regelgruppe
   * %usage Wird von UI_SCT_PKG aufgerufen, um Regelgruppen anzulegen oder zu aendern
   */
  procedure merge_rule_group(
    p_sgr_app_id in sct_group.sgr_app_id%type,
    p_sgr_page_id in sct_group.sgr_page_id%type,
    p_sgr_id in sct_group.sgr_id%type default null,
    p_sgr_name in sct_group.sgr_name%type,
    p_sgr_description in sct_group.sgr_description%type);
    
  
  procedure delete_rule_group(
    p_sgr_id in sct_group.sgr_id%type);
    
    
  /* Prozedur zur erneuten Nummerierung der Spalten SGR_SORT_SEQ und SRU_SORT_SEQ
   * %usage Wird verwendet, um die Spalte SGR_SORT_SEQ der Tabelle SCT_GROUP
   *        sowie Spalte SRU_SORT_SEQ der Tabelle SCT_RULE neu zu nummerieren.
   *        Sortiert nach den bisherigen Spaltenwerten, erhalten die Spalten eine
   *        um 10 aufsteigende Nummerierung, um weitere Umsortierungen zu ermoeglichen.
   *        Wird duch das Package UI_SCT_PKG aufgerufen
   */
  procedure resequence_rule_group(
    p_sgr_id in sct_group.sgr_id%type);
    
    
  /* Prozedur zum Kopieren einer Regelgruppe auf eine andere APEX-Anwendung(sseite)
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sgr_app_id ID der Anwendung, in die die Regelgruppe kopiert werden soll
   * %param p_sgr_page_id ID der Anwendungsseite, fuer die die Regelgruppe gelten soll
   * %usage Wird vom Package UI_SCT_PKG aufgerufen, um eine Regelgruppe inkl. aller
   *        Einzelregeln und -Aktionen auf eine neue Anwendung bzw. Anwendungsseite
   *        umzukopieren.
   *        Wird verwendet, um Regelgruppen bei Neuanlagen von Seiten oder Kopien
   *        von Anwendungen mitziehen zu lassen
   */
  procedure copy_rule_group(
    p_sgr_id in sct_group.sgr_id%type,
    p_sgr_app_id sct_group.sgr_app_id%type,
    p_sgr_page_id sct_group.sgr_page_id%type);
    
    
  /* Prozedur zur Nachbereitung einer Regelaenderung
   * %param p_sgr_id ID der Regelgruppe
   * %usage Nachdem eine Regelgruppe in einem Aspekt geaendert wurde muss diese
   *        Aenderung propagiert werden, um z.B. die Regelview anzupassen und 
   *        weitere interne Anpassungen vorzunehmen.
   *        Die Prozedur wird vom Package UI_SCT_PKG aufegerufen, insbesondere dann,
   *        wenn APEX direkt auf die Tabellen des SCT schreibt.
   */
  procedure propagate_rule_change(
    p_sgr_id in sct_group.sgr_id%type);
    
    
  /* Prozedur zur Validierung einer Einzelregel
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sru_condition Regelbedingung, die geprueft werden soll
   * %param p_error Ausgabetext im Fehlerfall, ansonsten NULL
   * %usage Wird vom Package UI_SCT_PKG als Validierungsfunktion verwendet,
   *        um Regelbedingungen gegen die Regelgruppe zu validieren.
   */
  procedure validate_rule(
    p_sgr_id in sct_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2);

end sct_admin;
/