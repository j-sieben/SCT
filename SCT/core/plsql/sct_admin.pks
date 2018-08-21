create or replace package sct_admin
  authid current_user
as 
    
  /* setter-Methode fuer eine Zahl, die auf APP_ID aufgeschlagen wird, wenn Regeln importiert
   * werden. Kann verwendet werden, um ID-Systeme aufeinander abzubilden
   */
  procedure set_app_offset(
    p_offset in binary_integer);
  
  /* Administration von Regelgruppen
   * %usage Diese Methoden werden stand heute nicht von der APEX-Anwendung verwendet,
   *        Um die Daten in der Datenbank zu pflegen, sondern von Import-Skripten.
   */
  /* Erstellt eine Regelgruppe 
   * %param p_sgr_app_id APEX-Anwendungs-ID
   * %param p_sgr_page_id APEX-Anwendungsseite-ID
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sgr_name Klartextbezeichnung der Regelgruppe
   * %param p_sgr_description Optionale Beschreibung der Regelgruppe
   * %param p_sgr_active Flag, das anzeigt, ob die Regelgruppe genutzt wird
   * %usage Wird verwendet, um Regelgruppen skriptgesteuert zu Erzeugen
   */
  procedure merge_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_sgr_description in sct_rule_group.sgr_description%type,
    p_sgr_with_recursion in sct_rule_group.sgr_with_recursion%type,
    p_sgr_active in sct_rule_group.sgr_active%type default sct_const.c_true);
    
    
  /* Entfernt eine Regelgruppe 
   * %param p_sgr_id ID der Regelgruppe, die entfernt werden soll
   * %usage Wird von UI_SCT_PKG aufgerufen, um eine Regelgruppe zu entfernen
   */
  procedure delete_rule_group(
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
    
    
  /* Exportiert alle Regelgruppen
   * %param p_sgr_app_id ID der APEX-Anwendung
   * %usage Ermittelt alle Regelgruppen einer APEX-Anwendungen und exportiert diese.
   *        Umfasst Aktionstypen
   */
  function export_all_rule_groups
    return clob;
    
    
  /* Exportiert alle Regelgruppen einer Anwendung
   * %param p_sgr_app_id ID der APEX-Anwendung
   * %usage Ermittelt alle Regelgruppen einer APEX-Anwendungen und exportiert diese.
   *        Umfasst Aktionstypen
   */
  function export_rule_groups(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type)
    return clob;
    
  
  /* Export einer Regelgruppe
   * %param p_sgr_id ID der Regelgruppe
   * %usage Exportiert alle Einzelregeln einer Regelgruppe.
   */
  function export_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return clob;
    
  
  /* Export der Aktionstypen
   * %param p_core_flag Flag, das steuert, ob die nicht-editierbaren oder die
   *        editierbaren Aktionstypen exportiert werden sollen
   * %usage Exportiert alle Aktionstypen, entweder die editierbaren oder die
   *        mitgelieferten
   */
  function export_action_types(
    p_core_flag in boolean default false)
    return clob;
    
  
  /* Prueft eine Regelgruppe vor dem Export
   * %param p_sgr_id ID der Regelgruppe, die geprueft werden soll
   * %return Fehlermeldung, falls existent
   * %usage Wird von der APEX-Anwendung vor dem Export einer oder mehrerer
   *        Regelgruppen aufgerufen.
   */
  function validate_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2;
    
  
  /* Bereitet Import einer Regegruppe in APEX-Anwendung vor
   * %param p_app_alias Anwendungsalias
   * %usage Die Methode wird verwendet, um nach einem Import einer APEX-Anwendung
   *        anhand des Anwendungsalias die aktuelle APEX-Anwendungs-ID zu ermitteln
   *        Diese wird vor dem Import einer Regelgruppe gesetzt, um zu ermoeglichen,
   *        dass die Regeln auf die neuen ID gemappt werden
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2);
    
    
  /* Ueberladung, falls kein Anwendungsalias zur Verfuegung steht.
   * %param p_app_id ID der Anwendung
   * %usage Die Methode wird verwendet, wenn die APEX-Anwendung kein Anwendungsalias
   *        enthaelt. In diesem Fall ist es nicht moeglich, automatisiert die
   *        vergebene Anwendungs-ID zu erkennen, falls diese automatisch generiert wurde.
   *        Diese Methode sollte also nur verwendet werden, wenn die Anwendungs-ID
   *        nicht veraendert wurde.
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in sct_rule_group.sgr_app_id%type);
    
    
  /* Hilfsmethode zum Mappen technischer IDs
   * %param p_id ID, die gamppt werden soll
   * %usage Da vorab nicht bekannt ist, welche ID durch eine Sequenz als naechstes 
   *        geliefert wird, merkt sich diese Methode fuer eine gegebene ID
   *        eine neu vergebene ID, die anschlieÃŸend geliefert wird. Ist P_ID
   *        nicht bekannt, wird eine neue ID hierfuer erzeugt.
   *        Wird die Methode mit P_ID => NULL aufgerufen, wird der ID-Stack neu
   *        initialisiert. Dies muss vor Verwendung geschehen
   */   
  function map_id(
    p_id in number default null)
    return number;
    
  /* Prozedur zum Initialisieren der Mapping-Funktion
   * %usage Wird aufgerufen, bevor ein Mapping von Primaerschluesselwerten 
   *        erfolgen soll.
   */
  procedure init_map;
    
    
  /* Administration von Regeln */
  /* Methode zur Erzeugung einer Einzelregel
   * %param p_sru_id ID der Einzelregel
   * %param p_sru_sgr_id ID der Regelgruppe
   * %param p_sru_name Name der Einzelregel
   * %param p_sru_condition Regelbedingung
   * %param p_sort_seq Ausfuehrungsreihenfolge der Regel
   * %param p_sru_active Flag, das anzeigt, ob die Regel aktuell verwendet wird.
   * %usage Wird verwendet, um skriptgesteuert eine Einzelregel zu erzeugen
   */
  procedure merge_rule(
    p_sru_id in sct_rule.sru_id%type default null,
    p_sru_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_name in sct_rule.sru_name%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_sru_fire_on_page_load in sct_rule.sru_fire_on_page_load%type,
    p_sru_sort_seq in sct_rule.sru_sort_seq%type,
    p_sru_active in sct_rule.sru_active%type default sct_const.c_true);
    
    
  /* Methode zur Nachbereitung einer Regelaenderung, falls diese ueber eine
   * APEX-Seite durchgefuehrt wurde (Assistent-basierte Seite)
   * %param p_sgr_id ID der Regelgruppe
   * %usage Wird verwendet, um nach einer Regelaenderung interne Arbeiten auszufuehren.
   *        Ist nicht erforderlich, wenn die API zur Erstellung von Regeln genutzt wird.
   */
  procedure propagate_rule_change(
    p_sgr_id in sct_rule_group.sgr_id%type);
    
    
  /* Methode zur Validierung einer Regelbedingung
   * %param p_sgr_id ID der Regelgruppe
   * %param p_sru_condition Regelbedingung
   * %param p_error Fehlermeldung, die geliefert wird, falls die Validierung 
   *        fehlschlaegt.
   * %usage Wird verwendet, um ueber die APEX-Oberflaeche eine Regelbedingung
   *        zu validieren
   */
  procedure validate_rule(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2);
    
    
  /* Administration von Regelaktivitaeten */
  /* Methode zur Erzeugung einer Regeelaktivitaet
   * %param p_sra_sru_id Referenz auf eine Einzelregel
   * %param p_sra_sgr_id Referenz auf eine Regelgruppe
   * %param p_sra_spi_id Referenz auf ein Seitenelement
   * %param p_sra_sat_id Referenz auf einen Aktionstyp
   * %param p_sra_attribute Optionaler Parameter der Aktivitaet
   * %param p_sra_attribute_2 Zweiter optionaler Parameter der Aktivitaet
   * %param p_sort_seq Ausfuehrungsreihenfolge der Aktivitaeten
   * %param p_sra_active Flag, das anzeigt, ob die Aktivitaet aktuell verwendet wird.
   */
  procedure merge_rule_action(
    p_sra_sru_id in sct_rule.sru_id%type,
    p_sra_sgr_id in sct_rule_group.sgr_id%type,
    p_sra_spi_id in sct_page_item.spi_id%type,
    p_sra_sat_id in sct_action_type.sat_id%type,
    p_sra_attribute in sct_rule_action.sra_attribute%type,
    p_sra_attribute_2 in sct_rule_action.sra_attribute_2%type,
    p_sra_sort_seq in sct_rule_action.sra_sort_seq%type,
    p_sra_on_error in sct_rule_action.sra_on_error%type default sct_const.c_false,
    p_sra_raise_recursive in sct_rule_action.sra_raise_recursive%type default sct_const.c_true,
    p_sra_active in sct_rule_action.sra_active%type default sct_const.c_true,
    p_sra_comment in sct_rule_action.sra_comment%type default null);
    
    
  /* Administration von Regelaktivitaeten */
  /* Methode zur Erzeugung einer APEX-Aktivitaet (Wrapper um apex.actions-Namespace)
   * %param p_sra_sru_id Referenz auf eine Einzelregel
   * %param p_sra_sgr_id Referenz auf eine Regelgruppe
   * %param p_sra_spi_id Referenz auf ein Seitenelement
   * %param p_sra_sat_id Referenz auf einen Aktionstyp
   * %param p_sra_attribute Optionaler Parameter der Aktivitaet
   * %param p_sra_attribute_2 Zweiter optionaler Parameter der Aktivitaet
   * %param p_sort_seq Ausfuehrungsreihenfolge der Aktivitaeten
   * %param p_sra_active Flag, das anzeigt, ob die Aktivitaet aktuell verwendet wird.
   */
  procedure delete_apex_action(    
    p_row sct_apex_action%rowtype);  
    
  procedure merge_apex_action(    
    p_row sct_apex_action%rowtype);  
    
  procedure merge_apex_action(
    p_saa_sgr_id in sct_apex_action.saa_sgr_id%type,
    p_saa_name in sct_apex_action.saa_name%type,
    p_saa_type in sct_apex_action.saa_type%type,
    p_saa_label in sct_apex_action.saa_label%type,
    p_saa_on_label in sct_apex_action.saa_on_label%type,
    p_saa_off_label in sct_apex_action.saa_off_label%type,
    p_saa_context_label in sct_apex_action.saa_context_label%type,
    p_saa_icon in sct_apex_action.saa_icon%type,
    p_saa_icon_type in sct_apex_action.saa_icon_type%type,
    p_saa_title in sct_apex_action.saa_title%type,
    p_saa_shortcut in sct_apex_action.saa_shortcut%type,
    p_saa_href in sct_apex_action.saa_href%type,
    p_saa_action in sct_apex_action.saa_action%type,
    p_saa_get in sct_apex_action.saa_get%type,
    p_saa_set in sct_apex_action.saa_set%type,
    p_saa_choices in sct_apex_action.saa_choices%type,
    p_saa_label_classes in sct_apex_action.saa_label_classes%type,
    p_saa_label_start_classes in sct_apex_action.saa_label_start_classes%type,
    p_saa_label_end_classes in sct_apex_action.saa_label_end_classes%type,
    p_saa_item_wrap_class in sct_apex_action.saa_item_wrap_class%type);  
    
    
  /* Administration von Aktionstypen */
  /* Methode zur Erzeugung eines Aktionstyps
   * %param p_sat_id ID des Aktionstyps
   * %param p_sat_name Klartextbezeichnung des Aktionstyps
   * %param p_sat_description Optionale Beschreibung, wird als Hilfstext angezeigt
   * %param p_sat_pl_sql PL/SQL-Anweisung, die ausgefuehrt werden soll
   * %param p_sat_js JavaScript-Anweisung, die ausgefuehrt werden soll
   * %param p_sat_default_attribute_1 Default-Ausdruck, falls Aktion kein Attribut 1 definiert
   * %param p_sat_check_attribute_1 Testausdruck, der Attribut 1 validiert
   * %param p_sat_default_attribute_2 Default-Ausdruck, falls Aktion kein Attribut 2 definiert
   * %param p_sat_check_attribute_2 Testausdruck, der Attribut 2 validiert
   * %param p_sat_is_editable Flag, das anzeigt, ob der Endanwender diese Aktivitaet aendern darf
   * %param p_sat_raise_recursive Flag, das anzeigt, ob der Aktionstyp bei Rekursionen
   *        ausgefuehrt werden soll.
   * %usage Wird verwendet, um einen Aktionstyp zu erstellen
   */
  procedure merge_action_type(
    p_sat_id in sct_action_type.sat_id%type,
    p_sat_name in sct_action_type.sat_name%type,
    p_sat_description in sct_action_type.sat_description%type default null,
    p_sat_pl_sql in sct_action_type.sat_pl_sql%type,
    p_sat_js in sct_action_type.sat_js%type,
    p_sat_default_attribute_1 sct_action_type.sat_default_attribute_1%type default null,
    p_sat_check_attribute_1 sct_action_type.sat_check_attribute_1%type default null,
    p_sat_default_attribute_2 sct_action_type.sat_default_attribute_2%type default null,
    p_sat_check_attribute_2 sct_action_type.sat_check_attribute_2%type default null,
    p_sat_is_editable in sct_action_type.sat_is_editable%type default sct_const.c_true,
    p_sat_raise_recursive in sct_action_type.sat_raise_recursive%type default sct_const.c_true);

end sct_admin;
/
