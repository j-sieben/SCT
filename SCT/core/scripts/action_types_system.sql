set define off
set sqlblanklines on

begin
  -- ACTION_PARAM_TYPES
  sct_admin.merge_action_param_type(
    p_spt_id => 'APEX_ACTION',
    p_spt_name => 'APEX-Aktion',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Existierende APEX-Aktion der Regelgruppe.</p>}',
    p_spt_item_type => 'SELECT_LIST',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'FUNCTION',
    p_spt_name => 'PL/SQL-Funktion',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Eine bestehende PL/SQL-Funktion oder eine Package-Funktion<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'JAVA_SCRIPT',
    p_spt_name => 'JavaScript-Ausdruck',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Ausführbarer JavaScript-Ausdruck, keine Funktionsdefinition</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_spt_name => 'JavaScript-Funktion',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Name einer JavaScript-Funktion oder anonyme Funktionsdefinition/IIFE</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'JQUERY_SELECTOR',
    p_spt_name => 'jQuery-Selektor',
    p_spt_display_name => '',
    p_spt_description => q'{<p>jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'PAGE_ITEM',
    p_spt_name => 'Seitenelement',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Seitenelement oder Region der aktuellen Seite</p>}',
    p_spt_item_type => 'SELECT_LIST',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'PIT_MESSAGE',
    p_spt_name => 'Name der Meldung',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Bezeichner einer PIT-Meldung in der Form msg.NAME oder 'NAME', muss eine existierende Meldung sein.</p>}',
    p_spt_item_type => 'SELECT_LIST',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'PROCEDURE',
    p_spt_name => 'PL/SQL-Prozedur',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Eine bestehende PL/SQL-Prozedur oder eine Package-Prozedur<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'SEQUENCE',
    p_spt_name => 'Sequenz',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Name einer existierenden Sequenz</p>}',
    p_spt_item_type => 'SELECT_LIST',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'SQL_STATEMENT',
    p_spt_name => 'SQL-Anweisung',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Ausführbare SELECT-Anweisung, die Eingabe erfolgt, wie im SQL-Developer &uuml;blich, es ist keine Angabe eines Semikolons erforderlich.</p>}',
    p_spt_item_type => 'TEXT_AREA',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING',
    p_spt_name => 'Zeichenkette',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Einfache Zeichenkette.<br>Die Zeichenkette wird mit Hochkommata umgeben, daher ist die Eingabe dieser Zeichen nicht erforderlich.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING_OR_FUNCTION',
    p_spt_name => 'Zeichenkette oder PL/SQL-Funktion',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Wird der Wert mit einfachen Hochkommata &uuml;bergeben, wird er als konstanter Text ausgegeben.<br>Wird der Parameter ohne Hochkommata übergeben, wird er als PL/SQL-Funktkion interpretiert, die einen Wert liefert.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING_OR_JAVASCRIPT',
    p_spt_name => 'Zeichenkette oder JS-Ausdruck',
    p_spt_display_name => '',
    p_spt_description => q'{Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein JavaScript-Ausdruck, der zur Laufzeit berechnet wird</li><li>Leere Zeichenkette (&#39;&#39;). In diesem Fall wird der Wert des Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING_OR_PIT_MESSAGE',
    p_spt_name => 'Zeichenkette oder Meldungsname',
    p_spt_display_name => '',
    p_spt_description => q'{<p>Falls nicht mit Hochkommata eingeschlossen, ein PIT-Meldungsname der Form msg.NAME</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);


  -- PAGE_ITEM_TYPES
  sct_admin.merge_page_item_type(
    p_sit_id => 'AFTER_REFRESH',
    p_sit_name => 'Nach Refresh',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_TRUE,
    p_sit_event => 'apexafterrefresh',
    p_sit_col_template => q'{case sct.get_event when 'apexafterrefresh' then sct.get_firing_item end after_refresh}',
    p_sit_init_template => q'{}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'ALL',
    p_sit_name => 'Alle',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_FALSE,
    p_sit_event => '',
    p_sit_col_template => q'{}',
    p_sit_init_template => q'{}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'APP_ITEM',
    p_sit_name => 'Anwendungselement',
    p_sit_has_value => sct_util.C_TRUE,
    p_sit_include_in_view => sct_util.C_FALSE,
    p_sit_event => 'change',
    p_sit_col_template => q'{v('#ITEM#') #ITEM#}',
    p_sit_init_template => q'{itm.#ITEM#}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'BUTTON',
    p_sit_name => 'Schaltfläche',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_FALSE,
    p_sit_event => 'click',
    p_sit_col_template => q'{case sct.get_firing_item when '#ITEM#' then 1 else 0 end #ITEM#}',
    p_sit_init_template => q'{}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'DATE_ITEM',
    p_sit_name => 'Element (Datum)',
    p_sit_has_value => sct_util.C_TRUE,
    p_sit_include_in_view => sct_util.C_FALSE,
    p_sit_event => 'change',
    p_sit_col_template => q'{sct.get_date('#ITEM#', '#CONVERSION#') #ITEM#}',
    p_sit_init_template => q'{to_char(to_date(itm.#ITEM#), '#CONVERSION#')}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'DIALOG_CLOSED',
    p_sit_name => 'Dialog geschlossen',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_TRUE,
    p_sit_event => 'apexafterclosedialog',
    p_sit_col_template => q'{case sct.get_event when 'apexafterclosedialog' then sct.get_firing_item end dialog_closed}',
    p_sit_init_template => q'{}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'DOCUMENT',
    p_sit_name => 'Dokument',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_FALSE,
    p_sit_event => '',
    p_sit_col_template => q'{null #ITEM#}',
    p_sit_init_template => q'{}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'DOUBLE_CLICK',
    p_sit_name => 'Doppelklick',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_TRUE,
    p_sit_event => 'dblclick',
    p_sit_col_template => q'{case sct.get_event when 'dblclick' then sct.get_firing_item end double_click}',
    p_sit_init_template => q'{}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'ENTER_KEY',
    p_sit_name => 'Enter-Taste',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_TRUE,
    p_sit_event => 'enter',
    p_sit_col_template => q'{case sct.get_event when 'enter' then sct.get_firing_item end enter_key}',
    p_sit_init_template => q'{}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'FIRING_ITEM',
    p_sit_name => 'Firing Item',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_TRUE,
    p_sit_event => '',
    p_sit_col_template => q'{sct.get_firing_item firing_item}',
    p_sit_init_template => q'{}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'INITIALIZING',
    p_sit_name => 'Initialize Flag',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_TRUE,
    p_sit_event => '',
    p_sit_col_template => q'{case sct.get_firing_item when 'DOCUMENT' then 1 else 0 end initializing}',
    p_sit_init_template => q'{}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'ITEM',
    p_sit_name => 'Element',
    p_sit_has_value => sct_util.C_TRUE,
    p_sit_include_in_view => sct_util.C_FALSE,
    p_sit_event => 'change',
    p_sit_col_template => q'{sct.get_string('#ITEM#') #ITEM#}',
    p_sit_init_template => q'{itm.#ITEM#}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'NUMBER_ITEM',
    p_sit_name => 'Element (Zahl)',
    p_sit_has_value => sct_util.C_TRUE,
    p_sit_include_in_view => sct_util.C_FALSE,
    p_sit_event => 'change',
    p_sit_col_template => q'{sct.get_number('#ITEM#','#CONVERSION#') #ITEM#}',
    p_sit_init_template => q'{to_char(itm.#ITEM#, '#CONVERSION#')}');
  sct_admin.merge_page_item_type(
    p_sit_id => 'REGION',
    p_sit_name => 'Region',
    p_sit_has_value => sct_util.C_FALSE,
    p_sit_include_in_view => sct_util.C_FALSE,
    p_sit_event => '',
    p_sit_col_template => q'{null #ITEM#}',
    p_sit_init_template => q'{}');


  -- ACTION_ITEM_FOCUS
  sct_admin.merge_action_item_focus(
    p_sif_id => 'ALL',
    p_sif_name => 'Alle Seitenelemente',
    p_sif_description => q'{Alle Seitenelemente der Anwendung}',
    p_sif_actual_page_only => sct_util.C_FALSE,
    p_sif_item_types => 'ALL:APP_ITEM:BUTTON:DATE_ITEM:DOCUMENT:ITEM:NUMBER_ITEM:REGION',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'DATE_ITEM',
    p_sif_name => 'Seitenelement (Datum)',
    p_sif_description => q'{Alle Seitenelemente, die ein Datum enthalten}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'DATE_ITEM',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'ENABLE_DISABLE',
    p_sif_name => 'Seitenelemente, die aktiviert und deaktiviert werden können',
    p_sif_description => q'{Alle Seitenelemente, die aktiviert und deaktiviert werden können}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'DATE_ITEM:ITEM:NUMBER_ITEM:DOCUMENT:BUTTON',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'ITEM_OR_JQUERY',
    p_sif_name => 'Seitenelement oder jQuery-Selektor',
    p_sif_description => q'{Alle Seitenelemente oder ein jQuery-Selektor}',
    p_sif_actual_page_only => sct_util.C_FALSE,
    p_sif_item_types => 'DATE_ITEM:ITEM:NUMBER_ITEM:ELEMENT:DOCUMENT',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'NONE',
    p_sif_name => 'Keine Seitenelemente',
    p_sif_description => q'{Keine Seitenelemente}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'DOCUMENT',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'NUMBER_ITEM',
    p_sif_name => 'Seitenelement (Zahl)',
    p_sif_description => q'{Alle Seitenelemente, die eine Zahl enthalten}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'NUMBER_ITEM',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE',
    p_sif_name => 'Alle Seitenelemente der aktuellen Seite',
    p_sif_description => q'{Alle Seitenelemente der aktuellen Anwendungsseite}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'BUTTON:DATE_ITEM:ITEM:NUMBER_ITEM:REGION:DOCUMENT',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_BUTTON',
    p_sif_name => 'Schaltflächen der aktuellen Seite',
    p_sif_description => q'{Alle Schaltflächen der aktuellen Anwendungsseite}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'BUTTON',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_ITEM',
    p_sif_name => 'Eingabefelder',
    p_sif_description => q'{Alle Eingabefelder der aktuellen Anwendungsseite}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'DATE_ITEM:ITEM:NUMBER_ITEM',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_sif_name => 'Eingabefeld oder Dokument',
    p_sif_description => q'{Alle Eingabefelder oder Auswahl über jQuery-Selektor}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'DOCUMENT:DATE_ITEM:ITEM:NUMBER_ITEM',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_ITEM_OR_JQUERY',
    p_sif_name => 'Eingabefeld oder jQuery-Selektor',
    p_sif_description => q'{Alle Eingabefelder oder ein jQuery-Selektor}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'DATE_ITEM:ITEM:NUMBER_ITEM:ELEMENT',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_REGION',
    p_sif_name => 'Regionen der aktuellen Seite',
    p_sif_description => q'{Alle Regionen der aktuellen Anwendungsseite}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'REGION',
    p_sif_active => sct_util.C_TRUE);

  sct_admin.merge_action_item_focus(
    p_sif_id => 'REFRESHABLE',
    p_sif_name => 'Seitenelemente, die aktualisiert werden können',
    p_sif_description => q'{Alle Seitenelemente, die aktualisiert werden können}',
    p_sif_actual_page_only => sct_util.C_TRUE,
    p_sif_item_types => 'ITEM:REGION:DATE_ITEM:NUMBER_ITEM',
    p_sif_active => sct_util.C_TRUE);


  -- ACTION_TYPE_GROUPS
  sct_admin.merge_action_type_group(
    p_stg_id => 'BUTTON',
    p_stg_name => 'Schaltlfäche',
    p_stg_description => q'{Aktionen für Schaltflächen}',
    p_stg_active => sct_util.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'IG',
    p_stg_name => 'Interactive Grid',
    p_stg_description => q'{Aktionen für das Interaktive Grid}',
    p_stg_active => sct_util.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'ITEM',
    p_stg_name => 'Seitenelemente',
    p_stg_description => q'{Aktionen für allgemeine Seitenelemente}',
    p_stg_active => sct_util.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'JAVA_SCRIPT',
    p_stg_name => 'JavaScript',
    p_stg_description => q'{JavaScript-Funkionen und Events}',
    p_stg_active => sct_util.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'PAGE_ITEM',
    p_stg_name => 'Eingabefelder',
    p_stg_description => q'{Aktionen für Eingabefelder}',
    p_stg_active => sct_util.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'PL_SQL',
    p_stg_name => 'PL/SQL',
    p_stg_description => q'{PL/SQ-Funktionen}',
    p_stg_active => sct_util.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'SCT',
    p_stg_name => 'Framework',
    p_stg_description => q'{Allgemeine Aktionen}',
    p_stg_active => sct_util.C_TRUE);


  -- ACTION TYPES
  sct_admin.merge_action_type(
    p_sat_id => 'AFTER_REFRESH',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'REFRESHABLE',
    p_sat_name => 'Ereignis "After Refresh" überwachen',
    p_sat_description => q'{<p>Registiert einen APEXAfterRefresh-Eventhandler. Wird das Ereignis ausgelöst, wird dies an SCT gemeldet und kann mit einer Regel AFTER_REFRESH = 1 gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'AFTER_REFRESH',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird SCT aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'CHECK_MANDATORY',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Pflichtfelder prüfen',
    p_sat_description => q'{<p>Pr&uuml;ft, ob alle Pflichtfelder einen Wert enthalten.</p>}',
    p_sat_pl_sql => q'{sct.check_mandatory('#ITEM#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'CHECK_MANDATORY',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Titel des Dialogfelds</p>}',
    p_sap_display_name => 'Dialogtitel',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'CHECK_MANDATORY',
    p_sap_spt_id => 'STRING_OR_PIT_MESSAGE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Meldung, die in der Bestätigungsmeldung angezeigt wird</p>}',
    p_sap_display_name => 'Meldung',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'CONFIRM_CLICK',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE_BUTTON',
    p_sat_name => 'Schaltfläche an Bestätigungsfrage binden',
    p_sat_description => q'{<p>Sorgt dafür, dass bei einem Klick auf eine Schaltfläche eine Bestätigungsmeldung gezeigt wird.<br>Nur, wenn diese Nachfrage best&auml;tigt wird, wird das Ereignis an SCT gemeldet.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.bindConfirmation('#ITEM#','#PARAM_1#', '#PARAM_2#');}',
    p_sat_is_editable => sct_util.C_TRUE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'DIALOG_CLOSED',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ereignis "Dialog Close" überwachen',
    p_sat_description => q'{<p>Registiert einen APEXAfterDialogClose-Eventhandler.<br>Wird das Ereignis ausgel&ouml;st, wird dies an SCT gemeldet und kann mit einer Regel DIALOG_CLOSED = 1 gefangen werden.</br>Ausl&ouml;sendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DIALOG_CLOSED',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird SCT aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_BUTTON',
    p_sat_stg_id => 'BUTTON',
    p_sat_sif_id => 'PAGE_BUTTON',
    p_sat_name => 'Schaltfläche deaktivieren',
    p_sat_description => q'{<p>Deaktiviert eine Schaltfl&auml;che. <br>Zum Deaktivieren eines Seitenelements verwenden Sie bitte <span style="font-family:courier new,courier,monospace">Feld deaktivieren</span>.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{apex.item('#ITEM#').disable();$('##ITEM#').removeClass('in_progress');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'DISABLE_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ziel deaktivieren',
    p_sat_description => q'{<p>Deaktiviert das referenzierte Seitenelement.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.disable('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DISABLE_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'DOUBLE_CLICK',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ereignis "Doppelklick" überwachen',
    p_sat_description => q'{<p>Registiert einen DoubleClick-Eventhandler.<br>Wird das Ereignis ausgel&ouml;st, wird dies an SCT gemeldet und kann mit einer Regel DOUBLE_CLICK = 1 gefangen werden. <br>Ausl&ouml;sendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DOUBLE_CLICK',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird SCT aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'DYNAMIC_JAVASCRIPT',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Dynamisches JavaScript ausführen',
    p_sat_description => q'{<p>Führt das übergebene JavaScript auf der Seite aus</p>}',
    p_sat_pl_sql => q'{sct.execute_javascript(q'##PARAM_1##');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'DYNAMIC_JAVASCRIPT',
    p_sap_spt_id => 'FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>PL/SQL-Funktion, die eine JavaScript-Anweisung ausgibt.<br>Ohne "javascript:" verwenden, nur den JavaScript-Code ausgeben</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'EMPTY_FIELD',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM_OR_JQUERY',
    p_sat_name => 'Feld leeren',
    p_sat_description => q'{<p>Setzt den Elementwert eines Feldes auf <span style="font-family:courier new,courier,monospace">NULL</span></p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'EMPTY_FIELD',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'ENABLE_BUTTON',
    p_sat_stg_id => 'BUTTON',
    p_sat_sif_id => 'PAGE_BUTTON',
    p_sat_name => 'Schaltfläche aktivieren',
    p_sat_description => q'{<p>Aktiviert eine Schaltfl&auml;che. Zum Aktivieren eines Seitenelements verwenden Sie bitte <span style="font-family:courier new,courier,monospace">Feld anzeigen</span>.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{apex.item('#ITEM#').enable();}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'ENABLE_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'ENABLE_DISABLE',
    p_sat_name => 'Ziel aktivieren',
    p_sat_description => q'{<p>Deaktiviert das referenzierte Seitenelement.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.enable('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'ENABLE_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'ENTER_KEY',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Ereignis "Enter-Taste" überwachen',
    p_sat_description => q'{<p>Registiert einen Enter-Taste-Eventhandler.<br>Wird das Ereignis ausgelöst, wird dies an SCT gemeldet und kann mit einer RegelENTER_KEY = 1 gefangen werden.<br>Auslösendes Element ist das Element, dass in dieser Aktion als FIRING_ITEM registriert wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'ENTER_KEY',
    p_sap_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Optionale JavaScript-Aktion.<br> Dieser Parameter muss der Name einer JavaScript-Funktion oder eine anonyme Funktionsdefinition sein, die als Callback aufgerufen wird.<br/>Wird kein Parameter definiert, wird SCT aufgerufen und entsprechende Regeln ausgeführt, anderenfalls wird direkt die hier hinterlegte Funktion ausgeführt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'EXECUTE_APEX_ACTION',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Befehl ausführen',
    p_sat_description => q'{<p>Führt einen Befehl aus, der vorab als APEX-Aktion angelegt worden sein muss.</p>}',
    p_sat_pl_sql => q'{sct.execute_apex_action('#PARAM_1#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'EXECUTE_APEX_ACTION',
    p_sap_spt_id => 'APEX_ACTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'EXECUTE_COMMAND',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Seitenkommando ausführen',
    p_sat_description => q'{<p>Führt ein Seitenkommando aus.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'EXECUTE_COMMAND',
    p_sap_spt_id => 'APEX_ACTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Das Seitenkommando, das ausgeführt werden soll.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'GET_SEQ_VAL',
    p_sat_stg_id => 'PL_SQL',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Sequenzwert ermitteln',
    p_sat_description => q'{<p>Setzt das referenzierte Element auf einen neuen Sequenzwert.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#',#PARAM_1#.nextval, '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'GET_SEQ_VAL',
    p_sap_spt_id => 'SEQUENCE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Name der Sequenz</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'HIDE_IR_IG_FILTER',
    p_sat_stg_id => 'IG',
    p_sat_sif_id => 'PAGE_REGION',
    p_sat_name => 'Filterbank von IR/IG ausblenden',
    p_sat_description => q'{<p>Blendet die Filterbank von Interactive Report/Grid aus.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.hideFilterPanel('#ITEM#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_FALSE);


  sct_admin.merge_action_type(
    p_sat_id => 'HIDE_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ziel ausblenden',
    p_sat_description => q'{<p>Blendet das referenzierte Seitenelement aus.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.hide('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'HIDE_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'IG_ALIGN_VERTICAL',
    p_sat_stg_id => 'IG',
    p_sat_sif_id => 'PAGE_REGION',
    p_sat_name => 'Tabellenzellen vertikal oben formatieren',
    p_sat_description => q'{<p>Ändert die Formatierung eines interaktiven Grids/Reports so, dass die Tabellenzellen vertikal oben ausgerichtet sind.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.alignIGVerticalTop('#ITEM#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'IS_DATE',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld enthält Datum',
    p_sat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld ein Datum enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>}',
    p_sat_pl_sql => q'{sct.check_date('#ITEM#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'IS_MANDATORY',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld ist Pflichtfeld',
    p_sat_description => q'{<p>Macht ein Seitenelement zu einem Pflichtfeld inkl. Validierung.</p>}',
    p_sat_pl_sql => q'{sct.register_mandatory('#ITEM#','#PARAM_1#', true, '#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.setMandatory('#SELECTOR#', true);  de.condes.plugin.sct.show('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'IS_MANDATORY',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'IS_MANDATORY',
    p_sap_spt_id => 'STRING_OR_PIT_MESSAGE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{Fehlermeldung kann optional &uuml;bergeben werden, ansonsten wird eine Standardmeldung verwendet.}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_NUMERIC',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld enthält Zahl',
    p_sat_description => q'{<p>Pr&uuml;ft, ob ein Eingabefeld einen numerischen Wert enth&auml;lt. Grundlage f&uuml;r die Konvertierung ist die Formatmaske, die f&uuml;r dieses Feld in APEX hinterlegt ist.</p>}',
    p_sat_pl_sql => q'{sct.check_number('#ITEM#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'IS_OPTIONAL',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld ist optional',
    p_sat_description => q'{<p>Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.</p>}',
    p_sat_pl_sql => q'{sct.register_mandatory('#ITEM#', null, false,'#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.setMandatory('#SELECTOR#',false);}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'IS_OPTIONAL',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'ITEM_NULL_SHOW',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld leeren und aktivieren',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf NULL und zeigt es auf der Seite an.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.enable('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'ITEM_NULL_SHOW',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'JAVA_SCRIPT_CODE',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'JavaScript-Code ausführen',
    p_sat_description => q'{<p>F&uuml;hrt den als Parameter &uuml;bergebenen JavaScript-Code aus.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{#PARAM_1#;}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'JAVA_SCRIPT_CODE',
    p_sap_spt_id => 'JAVA_SCRIPT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>JavaScript-Anweisung, die ausgef&uuml;hrt werden soll. (ohne Semikolon)</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'NOTIFY',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Benachrichtigung zeigen',
    p_sat_description => q'{<p>Zeigt eine Nachricht auf der Anwendungsseite</p>}',
    p_sat_pl_sql => q'{sct.notify(#PARAM_1#);}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'NOTIFY',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Meldungstext</p>}',
    p_sap_display_name => 'Meldung',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'NOT_NULL',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Mindestens einen Wert wählen',
    p_sat_description => q'{<p>Stellt sicher, dass mindestens eines der Elemente aus Attribut 1 einen Wert enthält.</p>}',
    p_sat_pl_sql => q'{sct.not_null('#ITEM#', '#PARAM_1#',#PARAM_2);}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'NOT_NULL',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'NOT_NULL',
    p_sap_spt_id => 'PIT_MESSAGE',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung misslingt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'PLSQL_CODE',
    p_sat_stg_id => 'PL_SQL',
    p_sat_sif_id => 'ALL',
    p_sat_name => 'PL/SQL-Code ausführen',
    p_sat_description => q'{<p>F&uuml;hrt den als Parameter &uuml;bergebenen PL/SQL-Code aus.</p>}',
    p_sat_pl_sql => q'{sct.execute_plsql('#PARAM_1#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'PLSQL_CODE',
    p_sap_spt_id => 'PROCEDURE',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>PL/SQL-Code, der ausgef&uuml;hrt werden soll.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'ALL',
    p_sat_name => 'Feld aktualisieren und Wert setzen',
    p_sat_description => q'{<p>Aktualisiert ein Seitenelement und setzt das Feld auf den Sessionstatus</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.refreshAndSetValue('#ITEM#', #PARAM_1#);}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'REFRESH_AND_SET_VALUE',
    p_sap_spt_id => 'STRING_OR_JAVASCRIPT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Wert, der gesetzt werden soll.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'REFRESH_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'REFRESHABLE',
    p_sat_name => 'Ziel aktualisieren (Refresh)',
    p_sat_description => q'{<p>Löst auf dem referenzierten Seitenelement einen APEX-Refresh aus.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.refresh('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'REGISTER_ITEM',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld-Event auslösen',
    p_sat_description => q'{<p>Löst einen CHANGE-Event auf das angegebene Feld aus und sorgt für die Abarbeitung der zugehörigen Regeln</p>}',
    p_sat_pl_sql => q'{sct.register_item('#ITEM#', '#ALLOW_RECURSION#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'REGISTER_OBSERVER',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld beobachten',
    p_sat_description => q'{<p>Aktion beobachtet ein Feld oder eine Klasse und registriert die Elemente so, dass die entsprechenden Elementwerte bei jedem Ereignis auf der Seite in den Sessionstatus kopiert werden.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'REGISTER_OBSERVER',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_CONSOLE',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Nachricht auf Console ausgeben',
    p_sat_description => q'{<p>In die Console der Developer-Tools wird eine Nachricht geschrieben.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{console.log(#PARAM_1#);}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_CONSOLE',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Meldungstext</p>}',
    p_sap_display_name => 'Nachricht',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ELEMENT_FROM_STMT',
    p_sat_stg_id => 'PL_SQL',
    p_sat_sif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_sat_name => 'Elementwert mit SQL-Anweisung setzen',
    p_sat_description => q'{<p>Setzt einen Elementwert basierend auf einer SQL-Anweisung, die einen einzelnen Wert zurückgibt.</p>}',
    p_sat_pl_sql => q'{sct.set_value_from_stmt('#ITEM#',q'##PARAM_1##');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_ELEMENT_FROM_STMT',
    p_sap_spt_id => 'SQL_STATEMENT',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>SQL-Anweisung, die einen oder mehrere Werte zurückgibt</br>Die Spaltenbezeichner m&uuml;ssen Elementnamen entsprechen, die Abfrageergebnisse werden in den zugehoerigen Seitenelementen gesetzt</dd>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_FOCUS',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Focus in Feld setzen',
    p_sat_description => q'{<p>Fokus in Eingabefeld der Seite setzen</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{$('##SELECTOR#').focus();}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'SET_IG_SELECTION',
    p_sat_stg_id => 'IG',
    p_sat_sif_id => 'PAGE_REGION',
    p_sat_name => 'Auswahl in Feld speichern',
    p_sat_description => q'{<p>Legt die aktuell ausgew&auml;hlten Zeilen-IDs im angegebenen Feld ab.</p>\CR\}' || 
q'{}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.persistIGSelection('#ITEM#', '#PARAM_1#', #PARAM_2#);}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_FALSE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_IG_SELECTION',
    p_sap_spt_id => 'PAGE_ITEM',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Name des Seitenelements, in das die Auswahl des IG gespeichert werden soll.</p>\CR\}' || 
q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_IG_SELECTION',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 2,
    p_sap_default => q'{1}',
    p_sap_description => q'{<p>1- basierte Ordinalzahl der Spalte, die im hinterlegten Element abgelegt werden soll. Die Reihenfolge richtet sich nach der Reihenfolge auf der APEX-Anwendungsseite.</p>\CR\}' || 
q'{}',
    p_sap_display_name => 'Ordinalzahl der Wertespalte',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ITEM',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld auf Wert setzen',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf den als Parameter übergebenen Wert.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', #PARAM_1#, '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_ITEM',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Elementwert.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ITEM_LABEL',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feldbezeichner auf Wert setzen',
    p_sat_description => q'{<p>Setzt den Bezeichner des referenzierten Seitenelements auf den als Parameter übergebenen Wert.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.setItemLabel('#ITEM#', '#PARAM_1#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_FALSE);


  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_DISABLE',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld leeren und deaktivieren',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und deaktiviert es auf der Seite.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.disable('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_NULL_DISABLE',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_NULL_HIDE',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld leeren und ausblenden',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf <span style="font-family:courier new,courier,monospace">NULL </span>und blendet es auf der Seite aus.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#', '', '#ALLOW_RECURSION#', '#PARAM_2#');}',
    p_sat_js => q'{de.condes.plugin.sct.hide('#SELECTOR#');de.condes.plugin.sct.setMandatory('#SELECTOR#', false);}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_NULL_HIDE',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_VALUE_ONLY',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'PAGE_ITEM',
    p_sat_name => 'Feld auf Wert setzen, keine Rekursion auslösen',
    p_sat_description => q'{<p>Setzt das referenzierte Seitenelement auf den übergebenen Wert, ohne weitere Rekursionen auszulösen.</p>}',
    p_sat_pl_sql => q'{sct.set_session_state('#ITEM#','#PARAM_1#', 0, '#PARAM_2#');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_VALUE_ONLY',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SET_VALUE_ONLY',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Elementwert</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ERROR',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_sat_name => 'Fehler anzeigen',
    p_sat_description => q'{<p>Zeigt die als Parameter übergebene Fehlermeldung auf der Seite.</p>}',
    p_sat_pl_sql => q'{sct.register_error('#ITEM#', '#PARAM_1#','');}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SHOW_ERROR',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Elementwert</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_ITEM',
    p_sat_stg_id => 'ITEM',
    p_sat_sif_id => 'PAGE',
    p_sat_name => 'Ziel anzeigen',
    p_sat_description => q'{<p>Blendet das referenzierte Seitenelement auf der Seite ein.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.show('#SELECTOR#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SHOW_ITEM',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SHOW_TIP',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Hinweis anzeigen',
    p_sat_description => q'{<p>In der Meldungsregion einen Hinweis anzeigen</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{drv.ek.sct.setNotification('#PARAM_1#');}',
    p_sat_is_editable => sct_util.C_TRUE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SHOW_TIP',
    p_sap_spt_id => 'STRING_OR_FUNCTION',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Der Elementwert</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'STOP_RULE',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Regel stoppen',
    p_sat_description => q'{<p>Beendet die aktuell laufende Regel und erlaubt keine rekursive Ausführung weiterer Regeln.</p>}',
    p_sat_pl_sql => q'{sct.stop_rule;}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Seite absenden',
    p_sat_description => q'{<p>Prüft alle Pflichtfelder und löst die Weiterlietung der Seite aus.</p>}',
    p_sat_pl_sql => q'{sct.submit_page;}',
    p_sat_js => q'{de.condes.plugin.sct.submit('#PARAM_1#','#PARAM_2#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT',
    p_sap_spt_id => 'PIT_MESSAGE',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Pr&uuml;fung der Seite  misslingt.</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>REQUEST-Wert, kann optional &uuml;bergeben werden, ansonsten wird SUBMIT verwendet.</p>}',
    p_sap_display_name => 'Request',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT_WO_VALIDATION',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Seite absenden, keine Validierung',
    p_sat_description => q'{<p>L&ouml;st die Weiterleitung der Seite ohne vorherige Validierung aus.</p>}',
    p_sat_pl_sql => q'{sct.submit_page(false);}',
    p_sat_js => q'{de.condes.plugin.sct.submit('#PARAM_1#','#PARAM_2#');}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'SUBMIT_WO_VALIDATION',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'TOGGLE_ITEMS',
    p_sat_stg_id => 'PAGE_ITEM',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Ziele ein- und ausblenden',
    p_sat_description => q'{<p>Kontrolliert die Anzeige mehrerer Seitenelemente, indem die Seitzenelemente, die durch den ersten Parameter identifiziert werden, ein- und die Seitenelemente, die durch den zweiten Parameter identifiziert werden, ausgeblendet werden</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{de.condes.plugin.sct.hide('#PARAM_2#');\CR\}' || 
q'{  de.condes.plugin.sct.show('#PARAM_1#');}',
    p_sat_is_editable => sct_util.C_TRUE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'TOGGLE_ITEMS',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>jQuery-Selektor, der die Seitenelemente identifiziert, die eingeblendet werden sollen.</p>}',
    p_sap_display_name => 'Einzublendende Seitenelemente',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'TOGGLE_ITEMS',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>jQuery-Selektor, der die Seitenelemente identifiziert, die ausgeblendet werden sollen.</p>}',
    p_sap_display_name => 'Auszublendende Seitenelemente',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'VALIDATE',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Seite validieren',
    p_sat_description => q'{<p>Prüft alle Pflichtfelder, löst aber keine Weiterleitung der Seite aus.</p>}',
    p_sat_pl_sql => q'{sct.submit_page;}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'WAIT_FOR_REFRESH',
    p_sat_stg_id => 'JAVA_SCRIPT',
    p_sat_sif_id => 'REFRESHABLE',
    p_sat_name => 'Eieruhr zeigen, bis APEX-Refresh erfolgreich',
    p_sat_description => q'{<p>Sorgt dafür, dass auf der Seite eine Eieruhr eingeblendet wird, bis eine APEX-Refresh-Aktion erfolgreich abgeschlossen wurde.<br>Als Seitenelement muss die Region/das Element angegeben werden, auf dessen Aktuialisierung gewartet wird.</p>}',
    p_sat_pl_sql => q'{}',
    p_sat_js => q'{drv.ek.waitUntilRefresh('#ITEM#');}',
    p_sat_is_editable => sct_util.C_TRUE,
    p_sat_raise_recursive => sct_util.C_TRUE);


  sct_admin.merge_action_type(
    p_sat_id => 'XOR',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Genau einen Wert wählen',
    p_sat_description => q'{<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält.</p>}',
    p_sat_pl_sql => q'{sct.xor('#ITEM#', '#PARAM_1#', #PARAM_2#, false);}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte entweder genau ein Feld einen NOT NULL-Wert besitzen, oder alle Werte müssen leer sein</p>}',
    p_sap_display_name => 'Liste der Seitenelemente',
    p_sap_mandatory => sct_util.C_FALSE,
    p_sap_active => sct_util.C_FALSE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR',
    p_sap_spt_id => 'PIT_MESSAGE',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Meldungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</p>}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_type(
    p_sat_id => 'XOR_NN',
    p_sat_stg_id => 'SCT',
    p_sat_sif_id => 'NONE',
    p_sat_name => 'Genau einen Wert wählen, NOT_NULL',
    p_sat_description => q'{<p>Stellt sicher, dass genau eines der Elemente aus Attribut 1 einen Wert enthält. NULL wird nicht zugelassen</p>}',
    p_sat_pl_sql => q'{sct.xor('#ITEM#', '#PARAM_1#', #PARAM_2#, true);}',
    p_sat_js => q'{}',
    p_sat_is_editable => sct_util.C_FALSE,
    p_sat_raise_recursive => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR_NN',
    p_sap_spt_id => 'JQUERY_SELECTOR',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{}',
    p_sap_display_name => '',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR_NN',
    p_sap_spt_id => 'PIT_MESSAGE',
    p_sap_sort_seq => 2,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Medlungsname, der ausgegeben werden soll, falls die Prüfung misslingt. Muss ein PIT-Meldungsname sein, in der Form MSG.&lt;Meldungsname&gt;</p>}',
    p_sap_display_name => 'Meldungsname',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);

  sct_admin.merge_action_parameter(
    p_sap_sat_id => 'XOR_NN',
    p_sap_spt_id => 'STRING',
    p_sap_sort_seq => 1,
    p_sap_default => q'{}',
    p_sap_description => q'{<p>Komma-separierte Liste von Elementnamen oder CSS-Klassen, die die Felder identifizieren, die zu einer Gruppe zusammengefasst werden. Innerhalb dieser Gruppe muss beim Prüfen der Werte genau ein Feld einen NOT NULL-Wert besitzen.<br>Sind alle Elemente NULL oder sind mehr al ein Element NOT NULL, wird ein Fehler geworfen</p>}',
    p_sap_display_name => 'Seitenelemente',
    p_sap_mandatory => sct_util.C_TRUE,
    p_sap_active => sct_util.C_TRUE);



  -- APEX_ACTION TYPES
  sct_admin.merge_apex_action_type(
    p_sty_id => 'ACTION',
    p_sty_name => 'Befehl/Verweis',
    p_sty_description => q'{JavaScript oder PL/SQL-Befehl, alternativ Verweis}',
    p_sty_active  => sct_util.C_TRUE);

  sct_admin.merge_apex_action_type(
    p_sty_id => 'RADIO_GROUP',
    p_sty_name => 'Optionsgruppe',
    p_sty_description => q'{Auswahlliste, Optionsfelder}',
    p_sty_active  => sct_util.C_TRUE);

  sct_admin.merge_apex_action_type(
    p_sty_id => 'TOGGLE',
    p_sty_name => 'Schalter',
    p_sty_description => q'{Wahlschalter (JA|NEIN)}',
    p_sty_active  => sct_util.C_TRUE);

  commit;
end;
/

set define on
set sqlblanklines off
