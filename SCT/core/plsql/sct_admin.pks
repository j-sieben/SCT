create or replace package sct_admin
  authid current_user
as

  /* Package SCT_ADMIN maintenance package for State Chart Toolkit SCT
   * %author Jürgen Sieben, ConDeS Gmbh
   * %usage Used to maintain metadata for the SCT
   *        The methods provided here are called using the packages
   *        - UI_SCT_PKG as an interface for the APEX application for SCT
   *        - PLUGIN_SCT as an interface for the APEX Dynamic Action Plugin
   */
    
  /* GETTER-METHODEN */
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
  /* REGELGRUPPEN */
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
    
  
  /* Prozedur zum Exportieren bestehender Regeln
   * %param p_sgr_id ID der Regelgruppe, optional. Falls nicht gesetzt, werden 
   *        alle Regelgruppen exportiert
   * %usage Wird verwendet, um bestehende Regelgruppen in eine Datei zu exportieren
   *        um sie ausliefern zu koennen.
   */
  procedure export_rule_group(
    p_sgr_id in sct_group.sgr_id%type default null);
    
  
  /* REGELN */
  /* Prozedur zum Anlegen oder Aendern einer Einzelregel
   * %param p_sru_id ID der Einzelregel. Optional, wird durch SCT_SEQ erzeugt, falls NULL
   * %param p_sru_sgr_id Referenz auf SCT_GROUP.SGR_ID
   * %param p_sru_name Sprechender Name der Einzelregel
   * %param p_sru_condition Bedingung, die fuer diese Einzelregel gilt
   * %param p_sru_sort_seq Ausfuehrungsreihenfolge der Einezelregel
   * %usage Wird aufgerufen, um eine Einzelregel anzulegen oder zu aendern.
   *        Kann von APEX aufgerufen werden oder von einem Export
   */
  procedure merge_rule(
    p_sru_id in sct_rule.sru_id%type default null,
    p_sru_sgr_id in sct_group.sgr_id%type,
    p_sru_name in sct_rule.sru_name%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_sru_sort_seq in sct_rule.sru_sort_seq%type);
    
    
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
    
  
  /* RULE_ACTION */
  /* Prozedur zum Erstellen einer RULE ACTION
   * %param p_sra_sru_id ID der Einzelregel
   * %param p_sra_sgr_id ID der Regelgruppe
   * %param p_sra_spi_id ID des betroffenen Seitenelements
   * %param p_sra_sat_id ID des Aktionstyps
   * %param p_sra_attribute Optionale Attribute fuer die Aktion
   * %param p_sra_sort_seq Ausfuehrungsreihenfolge der Aktion
   * %usage Wird verwendet, um eine RULE ACTION anzulegen oder zu aendern.
   *        Kann von APEX aufgerufen werden oder durch einen Import-Skript.
   */
  procedure merge_rule_action(
    p_sra_sru_id in sct_rule.sru_id%type,
    p_sra_sgr_id in sct_group.sgr_id%type,
    p_sra_spi_id in sct_page_item.spi_id%type,
    p_sra_sat_id in sct_action_type.sat_id%type,
    p_sra_attribute in sct_rule_action.sra_attribute%type,
    p_sra_sort_seq in sct_rule_action.sra_sort_seq%type);
  
  
  /* ACTION_TYPE */
  /* Prozedur zur Erzeugung eines ACTION_TYPE
   * %param p_sat_id ID des Actiontyps
   * %param p_sat_name Name des Actiontyps
   * %param p_sat_pl_sql PL/SQL-Code, der fuer diesen Actionstyp ausgefuehrt werden soll
   * %param p_sta_js JavaScript-Code, der fuer diesen Actionstyp ausgefuehrt werden soll
   * %param p_sta_changes_value Flag, das anzeigt, ob der ausgefuehrte Code den Wert
   *        des betroffenen Elements aendern wird
   * %usage Wird verwendet, um einen ACTION_TYPE anzulegen.
   *        Kann durch die APEX-Anwendung oder durch einen Import-Skript aufgerufen werden.
   */
  procedure merge_action_type(
    p_sat_id in sct_action_type.sat_id%type,
    p_sat_name in sct_action_type.sat_name%type,
    p_sat_pl_sql in sct_action_type.sat_pl_sql%type,
    p_sat_js in sct_action_type.sat_js%type,
    p_sat_changes_value in sct_action_type.sat_changes_value%type);
    
end sct_admin;
/