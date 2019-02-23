set define off

begin
  sct_admin.merge_action_param_type(
    p_spt_id => 'PIT_MESSAGE',
    p_spt_name => 'Name der Meldung',
    p_spt_description => q'{<p>Bezeichner einer PIT-Meldung in der Form msg.NAME oder 'NAME', muss eine existierende Meldung sein.</p>}',
    p_spt_item_type => 'SELECT_LIST',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'PROCEDURE',
    p_spt_name => 'PL/SQL-Prozedur',
    p_spt_description => q'{<p>Eine bestehende PL/SQL-Prozedur oder eine Package-Prozedur<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'SEQUENCE',
    p_spt_name => 'Sequenz',
    p_spt_description => q'{<p>Name einer existierenden Sequenz</p>}',
    p_spt_item_type => 'SELECT_LIST',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'SQL_STATEMENT',
    p_spt_name => 'SQL-Anweisung',
    p_spt_description => q'{<p>Ausführbare SELECT-Anweisung, die Eingabe erfolgt, wie im SQL-Developer &uuml;blich, es ist keine Angabe eines Semikolons erforderlich.</p>}',
    p_spt_item_type => 'TEXT_AREA',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING',
    p_spt_name => 'Zeichenkette',
    p_spt_description => q'{<p>Einfache Zeichenkette.<br>Die Zeichenkette wird mit Hochkommata umgeben, daher ist die Eingabe dieser Zeichen nicht erforderlich.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'APEX_ACTION',
    p_spt_name => 'APEX-Aktion',
    p_spt_description => q'{<p>Existierende APEX-Aktion der Regelgruppe.</p>}',
    p_spt_item_type => 'SELECT_LIST',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING_OR_FUNCTION',
    p_spt_name => 'Zeichenkette oder PL/SQL-Funktion',
    p_spt_description => q'{<p>Wird der Wert mit einfachen Hochkommata &uuml;bergeben, wird er als konstanter Text ausgegeben.<br>Wird der Parameter ohne Hochkommata übergeben, wird er als PL/SQL-Funktkion interpretiert, die einen Wert liefert.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING_OR_JAVASCRIPT',
    p_spt_name => 'Zeichenkette oder JS-Ausdruck',
    p_spt_description => q'{Kann folgende Werte enthalten:</p><ul><li>Eine Konstante. Die Angabe muss mit Hochkommata erfolgen oder eine Zahl sein</li><li>Ein JavaScript-Ausdruck, der zur Laufzeit berechnet wird</li><li>Leere Zeichenkette (&#39;&#39;). In diesem Fall wird der Wert des Sessionstatus verwendet (dieser kann vorab berechnet werden)</li></ul>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'STRING_OR_PIT_MESSAGE',
    p_spt_name => 'Zeichenkette oder Meldungsname',
    p_spt_description => q'{<p>Falls nicht mit Hochkommata eingeschlossen, ein PIT-Meldungsname der Form msg.NAME</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'FUNCTION',
    p_spt_name => 'PL/SQL-Funktion',
    p_spt_description => q'{<p>Eine bestehende PL/SQL-Funktion oder eine Package-Funktion<br>Es muss kein abschliessendes Semikolon angegeben werden.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'JAVA_SCRIPT',
    p_spt_name => 'JavaScript-Ausdruck',
    p_spt_description => q'{<p>Ausführbarer JavaScript-Ausdruck, keine Funktionsdefinition</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'JAVA_SCRIPT_FUNCTION',
    p_spt_name => 'JavaScript-Funktion',
    p_spt_description => q'{<p>Name einer JavaScript-Funktion oder anonyme Funktionsdefinition/IIFE</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'JQUERY_SELECTOR',
    p_spt_name => 'jQuery-Selektor',
    p_spt_description => q'{<p>jQuery-Ausdruck, um mehrere Elemente zu bearbeiten. Wird dieser Parameter verwendet, muss als ausl&ouml;sendes Element <code>DOCUMENT</code> eingetragen werden.</p>}',
    p_spt_item_type => 'TEXT',
    p_spt_active => sct_util.C_TRUE);

  sct_admin.merge_action_param_type(
    p_spt_id => 'PAGE_ITEM',
    p_spt_name => 'Seitenelement',
    p_spt_description => q'{<p>Seitenelement oder Region der aktuellen Seite</p>}',
    p_spt_item_type => 'SELECT_LIST',
    p_spt_active => sct_util.C_TRUE);
end;
/

set define on