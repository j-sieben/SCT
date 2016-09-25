create or replace package ui_sct_pkg
  authid current_user
as

  /* Package SCT_ADMIN zur Verwaltung von State Charts
   * %author Juergen Sieben, ConDeS GmbH
   * %usage Das Package dient als Schnittstelle zu einer APEX-Anwendung, um das SCT
   *        zu administrieren
   */

  /* Erzeugt eine neue oder aendert eine bestehende Regelgruppe
   * %param p_sgr_app_id Anwendungs-ID, auf die sich die Regelruppe bezieht
   * %param p_sgr_page_id Seiten-ID, auf die sich die Regelgruppe bezieht
   * %param p_sgr_name Klartextname der Regelgruppe
   * %param p_sgr_description Bescchreibung der Regelgruppe
   * %usage Wird von der Oberflaeche aufgerufen, um eine neue Regelgruppe zu erzeugen
   *        oder eine bestehende Regelgruppe zu aendern.
   *        Wird derzeit nicht verwendet, da ein Standard-APEX-Prozess zur Speicherung
   *        eingesetzt wird.
   */
  procedure merge_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_sgr_description in sct_rule_group.sgr_description%type,
    p_sgr_active in sct_rule_group.sgr_active%type default sct_const.c_true);


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
  
  
  /* Prozedur veranlasst den Export einer oder mehrerer Regelgruppen. Die Regelgruppen
   * werden als Datei auf den Client-rechner geladen
   */
  procedure export_rule_group;


  /* Re-sequenziert die Ausfuehrungsreihenfolge der Einzelregeln
   * %param p_sgr_id ID der Regelgruppe, die resequenziert werden soll
   * %usage Wird aufgerufen, um alle Einzelregeln nach Aenderung der Reihenfolge
   *        erneut in 10er-Schritten zu nummerieren.
   */
  procedure resequence_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type);


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

  /* Hilfsfunktion zur Ermittlung der nächsten Sequenznummer für Regeln
   * %param p_sgr_id ID der Regelgruppe
   * %return Naechste Sequenznummer
   * %usage Wird von der Anwendung genutzt, um eine neue Sequenznummer vorzublenden
   */
  function get_sru_sort_seq(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return number;

  /* Hilfsfunktion zur Ermittlung der nächsten Sequenznummer für Regelaktionen
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sru_id ID der Einzelregel
   * %return Naechste Sequenznummer
   * %usage Wird von der Anwendung genutzt, um eine neue Sequenznummer vorzublenden
   */
  function get_sra_sort_seq(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_id in sct_rule.sru_id%type)
    return number;

end ui_sct_pkg;
/
