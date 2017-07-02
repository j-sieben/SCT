create or replace package sct_ui_pkg
  authid current_user
as

  /* Package SCT_ADMIN zur Verwaltung von State Charts
   * %author Juergen Sieben, ConDeS GmbH
   * %usage Das Package dient als Schnittstelle zu einer APEX-Anwendung, um das SCT
   *        zu administrieren
   */

  /* Loescht eine bestehende Regelgruppe
   * %param p_sgr_id ID der Regelgruppe, die geloescht werden soll
   * %usage Wird verwendet, um eine bestehende Regelgruppe zu loeschen.
   */
  procedure delete_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type);


  /* Kopiert eine Regelgruppe auf eine andere Anwendung/Anwendungsseite
   * %usage Soll eine Anwendung kopiert werden, koennen mit dieser Funktion
   *        die definierten Regelgruppen in die neue Anwendung uebernommen werden.
   */
  procedure copy_rule_group;
  
  
  /* Funktion zur Pruefung einer Regelgruppe vor dem Export
   * %return Fehlermeldung, falls existent
   * %usage Die Methode wird vor dem Export einer Regelgruppe aufgerufen, um 
   *        sicherzustellen, dass sie fehlerfrei exportiert werden kann.
   */
  procedure validate_rule_group;
  
  
  /* Ueberladung fuer eine konkrete Regelgruppe
   * %param p_sgr_id ID der Regelgruppe, die geprueft werden soll
   * %usage Wird verwendet, um eine Regelgruppe explizit zu pruefen
   */
  procedure validate_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type);
    
  
  /* Prozedur veranlasst den Export aller Regelgruppen. Die Regelgruppen
   * werden als Datei auf den Client-rechner geladen
   */
  procedure export_all_rule_groups;
    
  
  /* Prozedur veranlasst den Export einer oder mehrerer Regelgruppen. Die Regelgruppen
   * werden als Datei auf den Client-rechner geladen
   */
  procedure export_rule_group;


  /* Propagiert das Speichern einer Einzelregel
   * %param p_sgr_id ID der betroffenen Regelgruppe
   * %usage Wird nach dem Aendern von Regelgruppen oder Einzelregeln aufgerufen.
   *        Die Prozedur hat folgende Aufgaben:
   *        - Tabelle SCT_PAGE_ITEM aktualisieren
   *        - SCT_RULES_GROUP_n-View aktualisieren
   *        - Regeln auf die erforderlichen Events einstellen
   */
  procedure process_rule_change(
    p_sgr_id in sct_rule_group.sgr_id%type);


  /* Validierungsfunktion fuer Einzelregeln
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sru_rule Bedingung der Einzelregel
   * %usage Wird als Validierung aufgerufen, wenn eine Regel erstellt oder geandert
   *        wird. Prueft, ob die Bedingung gegen SCT_RULES_GROUP_n ausfuehrbar ist.
   */
  function validate_rule_is_valid(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type)
    return varchar2;
    

  /* Hilfsfunktion zur Ermittlung der n�chsten Sequenznummer f�r Regeln
   * %param p_sgr_id ID der Regelgruppe
   * %return Naechste Sequenznummer
   * %usage Wird von der Anwendung genutzt, um eine neue Sequenznummer vorzublenden
   */
  function get_sru_sort_seq(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return number;
    

  /* Hilfsfunktion zur Ermittlung der n�chsten Sequenznummer f�r Regelaktionen
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sru_id ID der Einzelregel
   * %return Naechste Sequenznummer
   * %usage Wird von der Anwendung genutzt, um eine neue Sequenznummer vorzublenden
   */
  function get_sra_sort_seq(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_id in sct_rule.sru_id%type)
    return number;
    
  /* Hilfsfunktionen fuer Aktionstypen
   * %usage Liefert einen Hilfstext fuer Aktionstypen
   */
  procedure get_action_type_help;

end sct_ui_pkg;
/

