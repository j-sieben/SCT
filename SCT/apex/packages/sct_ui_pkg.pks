create or replace package sct_ui_pkg
  authid definer
as

  /* Maintain SCT rules via an APEX frontend
   * %author Juergen Sieben, ConDeS GmbH
   * %usage  This package implements the methods required to maintain SCT rule groups via an APEX application
   */
   
  /* Getter/Setter */
  
  /* Methode zur Aktualisierung der Regionsueberschrift von Regelgruppen */
  function set_rule_overview_heading
    return varchar2;


  /* Kopiert eine Regelgruppe auf eine andere Anwendung/Anwendungsseite
   * %usage Soll eine Anwendung kopiert werden, koennen mit dieser Funktion
   *        die definierten Regelgruppen in die neue Anwendung uebernommen werden.
   */
  procedure copy_sgr;
    
  
  /* Prozedur veranlasst den Export einer oder mehrerer Regelgruppen. Die Regelgruppen
   * werden als Datei auf den Client-rechner geladen
   */
  procedure process_export_sgr;
  
  /* Methode ermittelt auf Basis des SessionState die initiale Art des Regelgruppenexports */
  function get_export_type
    return varchar2;
  
  
  /* Methode zum Validieren der Seite EDIT_GROUP
   */
  function validate_edit_sgr
    return boolean;
    
  /* Methode zur Verarbeiten der Seite EDIT_GROUP
   */
  procedure process_edit_sgr;
  
  
  /* Methode zum Fuellen einer APEX-Collection der Regelaktionen
   * %usage  Wird beim Initialisieren der Seite EDIT_SRU aufgerufen, um bestehende Aktionen in die Collection zu kopieren-
   *         Erforderlich, um per modalen Dialog neue Aktionen aufnehmen zu koennen, ohne diese direkt in die DB speichern
   *         zu muessen
   */
  procedure initialize_sra_collection;
  
  
  /* Methode zum Fuellen einer APEX-Collection der APEX-Aktionen
   * %usage  Wird beim Initialisieren der Seite EDIT_SAA aufgerufen, um bestehende Aktionen in die Collection zu kopieren-
   *         Erforderlich, um per modalen Dialog neue Aktionen aufnehmen zu koennen, ohne diese direkt in die DB speichern
   *         zu muessen
   */
  procedure initialize_saa_collection;
  
  
  /* Methode zur Validierung einer Regelbedingung
   * %usage  Wird aufgerufen, um eine Regelbedingung zu testen.
   *         Registriert eventuelle Fehler im APEX Error Stack
   */
  procedure validate_rule;
  
  
  /* Methode zum Validieren der Seite EDIT_RULE
   */
  function validate_edit_sru
    return boolean;
    
  /* Methode zur Verarbeiten der Seite EDIT_RULE
   */
  procedure process_edit_sru;
  
  
  /* Method to prepare or update page EDIT_SRA based on Action Type selection
   */
  procedure configure_edit_sra;
  
  
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
    

  /* Hilfsfunktion zur Ermittlung der naechsten Sequenznummer fuer Regeln
   * %return Naechste Sequenznummer
   * %usage Wird von der Anwendung genutzt, um eine neue Sequenznummer vorzublenden
   */
  function get_sru_sort_seq
    return number;
    

  /* Hilfsfunktion zur Ermittlung der naechsten Sequenznummer fuer Regelaktionen
   * %return Naechste Sequenznummer
   * %usage Wird von der Anwendung genutzt, um eine neue Sequenznummer vorzublenden
   */
  function get_sra_sort_seq
    return number;
    
  /* Hilfsfunktionen fuer Aktionstypen
   * %usage Liefert einen Hilfstext fuer Aktionstypen
   */
  procedure get_action_type_help;
    
    
  /* Methoden zur Kontrolle von APEX-Aktionen */
  procedure set_action_admin_sgr;
  
  procedure set_action_edit_sgr;
  
  procedure set_action_export_sgr;
  
  procedure set_action_edit_sru;

end sct_ui_pkg;
/

