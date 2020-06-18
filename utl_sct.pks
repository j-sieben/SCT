CREATE OR REPLACE PACKAGE utl_sct
  AUTHID DEFINER
AS

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    clear_tip
  --
  --  Zweck:       Hinweis bzw. Fehlertext aus der Meldungsregion entfernen
  --
  --  Parameter:   keine
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE clear_tip;
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    close_modal_dialog
  --
  --  Zweck:       Schliesst ein modales Fenster und erlaubt die Uebermittlung einer Meldung etc.
  --
  --  Parameter:   ip_action   IN  - Optionale Aktion, die uebermittelt werden soll, z.B. ein Meldungsobjekt
  --               ip_key      IN  - JSON-Elementname, der fuer einen vereinfachte Meldungsuebermittlung genutzt wird
  --               ip_message  IN  - Meldungstext, der in JSON uebersetzt und dem Element IP_KEY zugeordnet wird
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE close_modal_dialog (ip_action  IN VARCHAR2 DEFAULT NULL,
                                ip_key     IN VARCHAR2 DEFAULT 'message',
                                ip_message IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    confirm_command
  --
  --  Zweck:       Zeigt einen Bestaetigungsdialog und fuehrt bei Bestaetigung ein Kommando aus
  --
  --  Parameter:   ip_item_sel  IN  - Element, das anschliessend den Fokus erhaelt
  --               ip_message   IN  - Meldung, die ausgegeben werden soll
  --               ip_command   IN  - Name des Kommandos, das ausgefuehrt werden soll. Kann in SCT-Bedingungen
  --                                  ueber COMMAND = '<IP_COMMAND>' gefangen werden
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE confirm_command (ip_item_sel  IN VARCHAR2,
                             ip_message   IN VARCHAR2,
                             ip_command   IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    disable_button
  --
  --  Zweck:       Schaltflaeche deaktivieren
  --
  --  Parameter:   ip_item_sel   IN  - zu deaktivierende Schaltflaeche
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE disable_button (ip_item_sel   IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    disable_item
  --
  --  Zweck:       Ziel deaktivieren
  --
  --  Parameter:   ip_item_sel   IN  - zu deaktivierendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE disable_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                          ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    dynamic_js
  --
  --  Zweck:       Fuehrt das uebergebene JavaScript auf der Seite aus
  --
  --  Parameter:   ip_plsql_func   IN  -  PL/SQL-Funktion, die eine JavaScript-Anweisung ausgibt. Ohne "javascript:"
  --                                      verwenden, nur den JavaScript-Code ausgeben
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE dynamic_js (ip_plsql_func   IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    empty_field
  --
  --  Zweck:       Feld leeren (Setzt den Elementwert eines Feldes auf NULL)
  --
  --  Parameter:   ip_item_sel   IN  - zu leerendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE empty_field (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                         ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    enable_button
  --
  --  Zweck:       Schaltflaeche aktivieren
  --
  --  Parameter:   ip_item_sel   IN  - zu aktivierende Schaltflaeche
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE enable_button (ip_item_sel   IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    enable_item
  --
  --  Zweck:       Ziel aktivieren und anzeigen (Aktiviert das referenzierte Seitenelement und zeigt es an.)
  --
  --  Parameter:   ip_item_sel   IN  - zu aktivierendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_whole_row  IN  - komplette Zeile anzeigen, z.B. wenn mehrere Elemente in einer Spalte stehen und
  --                                  zu unterschiedlichen Zeitpunkten angezeigt werden sollen 
  --                                  (Default NULL, wenn Auswirkung auf ganze Zeile,
  --                                            'N', wenn Auswirkung nur auf das Element)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE enable_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                         ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                         ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    hide_item
  --
  --  Zweck:       Ziel ausblenden (Blendet das referenzierte Seitenelement aus.)
  --
  --  Parameter:   ip_item_sel   IN  - auszublendendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_whole_row  IN  - komplette Zeile ausblenden, z.B. wenn mehrere Elemente in einer Spalte stehen und
  --                                  zu unterschiedlichen Zeitpunkten ausgeblendet werden sollen 
  --                                  (Default NULL, wenn Auswirkung auf ganze Zeile,
  --                                            'N', wenn Auswirkung nur auf das Element)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE hide_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                       ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                       ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    is_mandatory
  --
  --  Zweck:       Feld ist Pflichtfeld und wird angezeigt
  --
  --  Parameter:   ip_item_sel   IN  - Pflicht-Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_msg_text   IN  - Meldungstext in Hochkommata oder Funktion, die Wert liefert (Default NULL, dann Standardtext)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE is_mandatory (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                          ip_msg_text   IN VARCHAR2 DEFAULT NULL,
                          ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    is_optional
  --
  --  Zweck:       Feld ist optional (Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.)
  --
  --  Parameter:   ip_item_sel   IN  - optionales Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE is_optional (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                         ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    item_null_show
  --
  --  Zweck:       Feld leeren und aktivieren (Setzt das referenzierte Element auf NULL, aktiviert es auf der Seite und zeigt es an.)
  --
  --  Parameter:   ip_item_sel   IN  - zu leerendes und aktivierendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_whole_row  IN  - komplette Zeile aktivieren, z.B. wenn mehrere Elemente in einer Spalte stehen und
  --                                   zu unterschiedlichen Zeitpunkten aktiviert werden sollen 
  --                                  (Default NULL, wenn Auswirkung auf ganze Zeile,
  --                                            'N', wenn Auswirkung nur auf das Element)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE item_null_show (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                            ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                            ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    java_script_code
  --
  --  Zweck:       JavaScript-Code ausführen (Fuehrt den als Parameter uebergebenen JavaScript-Code aus.)
  --
  --  Parameter:   ip_js_code   IN  - JavaScript-Anweisung, die ausgefuehrt werden soll. (ohne Semikolon)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE java_script_code (ip_js_code   IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    refresh_and_set_value
  --
  --  Zweck:       Feld aktualisieren und Wert setzen (Aktualisiert ein Element und setzt den Sessionstatus)
  --
  --  Parameter:   ip_item_sel   IN  - zu aktualisierendes Element
  --               ip_item_val   IN  - Wert des Elementes in folgendem Format
  --                                   Konstante in Hochkomma oder JavaScript-Ausdruck, der zur Laufzeit berechnet wird
  --                                   oder leere Zeichenkette (''). In diesem Fall wird der Wert des Sessionstatus verwendet
  --                                   (dieser kann vorab berechnet werden)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE refresh_and_set_value (ip_item_sel   IN VARCHAR2,
                                   ip_item_val   IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    refresh_item
  --
  --  Zweck:       Ziel aktualisieren (Löst auf dem referenzierten Seitenelement einen APEX-Refresh aus.)
  --
  --  Parameter:   ip_item_sel    IN  - zu aktualisierendes Element
  --               ip_jquery_sel  IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, 
  --                                    muss in ip_item_sel 'DOCUMENT' eingetragen werden.
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE refresh_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                          ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    validate_item
  --
  --  Zweck:       Ziel auf Existenz pruefen und formatieren
  --
  --  Parameter:   ip_item        IN  - zu aktualisierendes Element
  --               ip_item_type   IN  - Typ des Elements. Muss eine der Pruefungen sein, die BL_ELEMENTPRUEFUNGEN unterstetzt
  --               ip_existenz    IN  - Flag, das anzeigt, ob die Existenz des Elementwerts ebenfalls geprueft werden soll
  --               ip_return_item IN  - Name des Elements, in das die Rueckgabe erfolgen soll
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE validate_item (ip_item        IN VARCHAR2,
                           ip_item_type   IN VARCHAR2,
                           ip_existenz    IN BOOLEAN,
                           ip_return_item IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    set_button_access_key
  --
  --  Zweck:       In die Konsole der Developer-Tools wird eine Nachricht geschrieben.
  --
  --  Parameter:   ip_item_sel   IN  - Nachricht als Text
  --               ip_position   IN  - Position des Buchstabens, der als ACCESS-Key verwendet werden soll
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_button_access_key (ip_item_sel IN VARCHAR2,
                                   ip_position IN PLS_INTEGER);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    set_console
  --
  --  Zweck:       In die Konsole der Developer-Tools wird eine Nachricht geschrieben.
  --
  --  Parameter:   ip_log_msg   IN  - Nachricht als Text
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_console (ip_log_msg IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    set_focus
  --
  --  Zweck:       Fokus in Feld setzen (Setzt den Fokus auf das in "ip_item_sel" definierte Element)
  --
  --  Parameter:   ip_item_sel   IN  - zu fokussierendes Element
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_focus (ip_item_sel IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    set_item
  --
  --  Zweck:       Feld auf Wert setzen (Setzt das referenzierte Seitenelement auf den als Parameter übergebenen Wert.)
  --
  --  Parameter:   ip_item_sel    IN  - zu setzendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_item_value  IN  - Wert des Elements in Hochkommata oder Funktion, die Wert liefert.
  --               ip_jquery_sel  IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  --               ip_raise_event IN  - Flag, das anzeigt, ob ein Change-Event ausgeloest werden soll. (Default TRUE, Event wird ausgeloest)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_item (ip_item_sel     IN VARCHAR2 DEFAULT 'DOCUMENT',
                      ip_item_value   IN VARCHAR2,
                      ip_jquery_sel   IN VARCHAR2 DEFAULT NULL,
                      ip_raise_event  IN BOOLEAN DEFAULT TRUE);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    set_item_label
  --
  --  Zweck:       Feldbezeichner setzen (Setzt einen Feldbezeichner auf den übergebenen Wert.)
  --
  --  Parameter:   ip_item_sel    IN  - zu setzendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_item_label  IN  - Label des Elements in Hochkommata oder Funktion, die Wert liefert.
  --               ip_jquery_sel  IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_item_label (ip_item_sel    IN VARCHAR2 DEFAULT 'DOCUMENT',
                            ip_item_label  IN VARCHAR2,
                            ip_jquery_sel  IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    set_modal_dialog_title
  --
  --  Zweck:       Setzt Titel des modalen Dialogfensters
  --
  --  Parameter:   ip_title   IN  - neuer Titel
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_modal_dialog_title (ip_title IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    set_null_disable
  --
  --  Zweck:       Feld leeren und deaktivieren (Setzt das referenzierte Element auf NULL, deaktiviert es auf der Seite.)
  --
  --  Parameter:   ip_item_sel   IN  - zu leerendes und deaktivierendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_null_disable (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                              ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    set_null_hide
  --
  --  Zweck:       Feld leeren und ausblenden (Setzt das referenzierte Element auf NULL und blendet es aus.)
  --
  --  Parameter:   ip_item_sel   IN  - zu leerendes und auszublendendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_whole_row  IN  - komplette Zeile ausblenden, z.B. wenn mehrere Elemente in einer Spalte stehen und
  --                                   zu unterschiedlichen Zeitpunkten ausgeblendet werden sollen 
  --                                   (Default NULL, wenn Auswirkung auf ganze Zeile,
  --                                            'N', wenn Auswirkung nur auf das Element)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE set_null_hide (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                           ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                           ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    show_alert
  --
  --  Zweck:       Hinweis nur in Meldungsfenster (Alert-Box) anzeigen
  --
  --  Parameter:   ip_focus_item_sel  IN  - Element, das nach der Bestaetigung den Fokus erhaelt
  --               ip_msg_text        IN  - Meldungstext in Hochkommata oder Funktion, die Wert liefert
  --               ip_msg_type        IN  - Meldungstyp in Hochkommata: Fehler, Warnung, Hinweis
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_alert (ip_focus_item_sel  IN VARCHAR2,
                        ip_msg_text        IN VARCHAR2,
                        ip_msg_type        IN VARCHAR2 DEFAULT 'Hinweis');
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    show_error
  --
  --  Zweck:       Fehler anzeigen in Meldungsregion (Zeigt die als Parameter uebergebene Fehlermeldung auf der Seite.)
  --
  --  Parameter:   ip_item_sel  IN  - Element, das den Fehler enthaelt ('DOCUMENT' falls globaler Fehler)
  --               ip_msg_text  IN  - Fehlermeldungstext in Hochkommata oder Funktion, die Wert liefert
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_error (ip_item_sel  IN VARCHAR2,
                        ip_msg_text  IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    show_hide_item
  --
  --  Zweck:       Ziele anzeigen und andere ausblenden (Blendet die Element aus ip_jquery_sel_show auf der Seite ein und die Elemente aus ip_jquery_sel_hide aus.)
  --
  --  Parameter:   ip_jquery_sel_show  IN  - jQuery-Ausdruck, um mehrere Elemente anzuzeigen
  --               ip_jquery_sel_hide  IN  - jQuery-Ausdruck, um mehrere Elemente auszublenden
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_hide_item (ip_jquery_sel_show  IN VARCHAR2,
                            ip_jquery_sel_hide  IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    show_hint
  --
  --  Zweck:       Hinweis nur in Meldungsregion anzeigen
  --
  --  Parameter:   ip_msg_text  IN  - Meldungstext in Hochkommata oder Funktion, die Wert liefert
  --               ip_msg_type  IN  - Meldungstyp in Hochkommata: Fehler, Warnung, Hinweis
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_hint (ip_msg_text  IN VARCHAR2,
                       ip_msg_type  IN VARCHAR2 DEFAULT 'Hinweis');
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    show_item
  --
  --  Zweck:       Ziel anzeigen (Zeigt das referenzierte Seitenelement an.)
  --
  --  Parameter:   ip_item_sel   IN  - anzuzeigendes Element (Default DOCUMENT, wenn ip_jquery_sel gefuellt)
  --               ip_whole_row  IN  - komplette Zeile anzeigen, z.B. wenn mehrere Elemente in einer Spalte stehen und
  --                                   zu unterschiedlichen Zeitpunkten angezeigt werden sollen 
  --                                  (Default NULL, wenn Auswirkung auf ganze Zeile,
  --                                            'N', wenn Auswirkung nur auf das Element)
  --               ip_jquery_sel IN  - jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. (Default NULL, wenn ip_item_sel gefuellt)
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_item (ip_item_sel   IN VARCHAR2 DEFAULT 'DOCUMENT',
                       ip_whole_row  IN VARCHAR2 DEFAULT NULL,
                       ip_jquery_sel IN VARCHAR2 DEFAULT NULL);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    show_message
  --
  --  Zweck:       Hinweis in Meldungsfenster und -region anzeigen
  --               Die Aktion muss an ein konkretes Element gebunden werden. Dieses Element erhaelt nach Bestaetigung der Meldung den Fokus.
  --
  --  Parameter:   ip_focus_item_sel  IN  - Element, das nach der Bestaetigung den Fokus erhaelt
  --               ip_msg_text        IN  - Meldungstext in Hochkommata oder Funktion, die Wert liefert
  --               ip_msg_type        IN  - Meldungstyp in Hochkommata: Fehler, Warnung, Hinweis
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE show_message (ip_focus_item_sel  IN VARCHAR2,
                          ip_msg_text        IN VARCHAR2,
                          ip_msg_type        IN VARCHAR2 DEFAULT 'Hinweis');
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    wait_for_refresh
  --
  --  Zweck:       Eieruhr zeigen, bis APEX-Refresh erfolgreich (Sorgt dafuer, dass auf der Seite eine Eieruhr eingeblendet wird,
  --               bis eine APEX-Refresh-Aktion erfolgreich abgeschlossen wurde.)
  --
  --  Parameter:   ip_region_sel  IN  - Region, auf deren Aktualisierung gewartet wird
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE wait_for_refresh (ip_region_sel  IN VARCHAR2);
  ---------------------------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------------------------
  --  Prozedur:    handle_bulk_errors
  --  Zweck:       Wird im Zusammenhang mit PIT im Collect-Modus aufgerufen und bearbeitet alle aufgetretenen
  --               Fehler, indem sie auf die entsprechenden Seitenelemente ausgegeben werden.
  --
  --  Parameter:   ip_mapping_list  IN  - CHAR_TABLE-Instanz, in der ein Mapping ERROR_CODE => SEITENELEMENT
  --               hinterlegt wird. Ist ein ERROR_CODE nicht belegt, wird der Fehler auf DOCUMENT ausgegeben
  --  Verwendung:  PIT im Collection-Modus betreiben und diese Funktion im EXCEPTION-Block aufrufen:
  --               EXCEPTION WHEN msg.ALLG_BULK_ERROR_ERR OR msg.ALLG_BULK_FATAL_ERR THEN
  --                 utl_sct.handle_bulk_errors(char_table(
  --                   'ERROR_CODE_1', 'Pn_MY_PAGE_ITEM',
  --                   'ERROR_CODE_2'; 'Pn_MY_OTHER_ITEM',
  --                   ...);
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE handle_bulk_errors (ip_mapping_list  IN char_table);
  ---------------------------------------------------------------------------------------------------------------

END utl_sct;
/