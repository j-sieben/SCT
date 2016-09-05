create or replace package ui_sct_pkg
  authid current_user
as 

  /* Package SCT_ADMIN zur Verwaltung von State Charts
   * %author Jürgen Sieben, ConDeS GmbH
   * %usage Das Package dient als Schnittstelle zu einer APEX-Anwendung, um das SCT
   *        zu administrieren
   */

  /* Erzeugt eine neue oder aendert eine bestehende Regelgruppe
   * %param p_sgr_app_id Anwendungs-ID, auf die sich die Regelruppe bezieht
   * %param p_sgr_page_id Seiten-ID, auf die sich die Regelgruppe bezieht
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sgr_name Klartextname der Regelgruppe
   * %param p_sgr_description Bescchreibung der Regelgruppe
   * %usage Wird von der Oberflaeche aufgerufen, um eine neue Regelgruppe zu erzeugen
   *        oder eine bestehende Regelgruppe zu aendern.
   *        Wird derzeit nicht verwendet, da ein Standard-APEX-Prozess zur Speicherung
   *        eingesetzt wird.
   */
  procedure merge_rule_group(
    p_sgr_app_id in sct_group.sgr_app_id%type,
    p_sgr_page_id in sct_group.sgr_page_id%type,
    p_sgr_id in sct_group.sgr_id%type default null,
    p_sgr_name in sct_group.sgr_name%type,
    p_sgr_description in sct_group.sgr_description%type);
    
  
  /* Loescht eine bestehende Regelgruppe
   * %param p_sgr_id ID der Regelgruppe, die geloescht werden soll
   * %usage Wird verwendet, um eine bestehende Regelgruppe zu loeschen.
   */
  procedure delete_rule_group(
    p_sgr_id in sct_group.sgr_id%type);
    
  
  /* Kopiert eine Regelgruppe auf eine andere Anwendung/Anwendungsseite
   * %param p_sgr_id ID der Regelgruppe, die kopiert werden soll
   * %param p_sgr_app_id ID der Anwendung, in die kopiert werden soll
   * %param p_sgr_page_id Optional, Anwendungsseite, auf die sich die Regelgruppe
   *        bezieht. Falls NULL, wird die aktuelle Seite verwendet
   * %usage Soll eine Anwendung kopiert werden, koennen mit dieser Funktion
   *        die definierten Regelgruppen in die neue Anwendung uebernommen werden.
   */
  procedure copy_rule_group(
    p_sgr_id in sct_group.sgr_id%type,
    p_sgr_app_id sct_group.sgr_app_id%type,
    p_sgr_page_id sct_group.sgr_page_id%type default null);
    
    
  /* Re-sequenziert die Ausfuehrungsreihenfolge der Einzelregeln
   * %param p_sgr_id ID der Regelgruppe, die resequenziert werden soll
   * %usage Wird aufgerufen, um alle Einzelregeln nach Aenderung der Reihenfolge
   *        erneut in 10er-Schritten zu nummerieren.
   */
  procedure resequence_rule_group(
    p_sgr_id in sct_group.sgr_id%type);
    
  
  /* Propagiert das Speichern einer Einzelregel
   * %param p_sgr_id ID der betroffenen Regelgruppe
   * %usage Wird nach dem Aendern von Regelgruppen oder Einzelregeln aufgerufen.
   *        Die Prozedur hat folgende Aufgaben:
   *        - Tabelle SCT_PAGE_ITEM aktualisieren
   *        - SCT_RULES_GROUP_n-View aktualisieren
   *        - Regeln auf die erforderlichen Events einstellen
   */
  procedure process_rule_change(
    p_sgr_id in sct_group.sgr_id%type);
    
  
  /* Validierungsfunktion fuer Einzelregeln
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sru_rule Bedingung der Einzelregel
   * %usage Wird als Validierung aufgerufen, wenn eine Regel erstellt oder geandert
   *        wird. Prueft, ob die Bedingung gegen SCT_RULES_GROUP_n ausfuehrbar ist.
   */
  function validate_rule_is_valid(
    p_sgr_id in sct_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type)
    return varchar2;
    
    
end ui_sct_pkg;
/