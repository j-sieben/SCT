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
  
  
  /* Methode zum Validieren der Seite EDIT_GROUP
   */
  function validate_edit_sgr
    return boolean;
    
  /* Methode zur Verarbeiten der Seite EDIT_GROUP
   */
  procedure process_edit_sgr;
  
  
  /* Methode zum Validieren der Seite EDIT_RULE
   */
  function validate_edit_sru
    return boolean;
    
  /* Methode zur Verarbeiten der Seite EDIT_RULE
   */
  procedure process_edit_sru;
  
  
  /* Methode zum Validieren der Seite EDIT_RULE, Interactive Grid RULE_ACTION
   */
  function validate_edit_sra
    return boolean;
    
  /* Methode zur Verarbeiten der Seite EDIT_RULE, Interactive Grid RULE_ACTION
   */
  procedure process_edit_sra;
  
  
  /* Methode zum Validieren der Seite EDIT_SAA
   */
  function validate_edit_saa
    return boolean;
    
  /* Methode zur Verarbeiten der Seite EDIT_SAA
   */
  procedure process_edit_saa;
    

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

