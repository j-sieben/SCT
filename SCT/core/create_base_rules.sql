set define off
begin

  -- ACTION TYPES
  sct_admin.merge_action_type(
    p_sat_id => 'CHECK_MANDATORY',
    p_sat_name => 'Pflichtfeld prüfen',
    p_sat_description => q'~<p>Pr&uuml;ft, ob alle Pflichtfelder einen Wert enthalten.</p>

<p><em>Parameter</em>: Keine</p>
~',
    p_sat_pl_sql => q'~plugin_sct.check_mandatory('#ITEM#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 0);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_MANDATORY',
    p_sat_name => 'Feld ist Pflichtfeld',
    p_sat_description => q'~<p>Macht ein Seitenelement zu einem Pflichtfeld inkl. Validierung.</p>

<p><em>Parameter</em>: Fehlermeldung kann optional &uuml;bergeben werden, ansonsten wird eine Standardmeldung verwendet..</p>
~',
    p_sat_pl_sql => q'~plugin_sct.register_mandatory('#ITEM#', '#ATTRIBUTE#', true);~',
    p_sat_js => q'~de.condes.plugin.sct.setMandatory('#ITEM#', true);~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'IS_OPTIONAL',
    p_sat_name => 'Feld ist optional',
    p_sat_description => q'~<p>Macht ein Seitenelement zu einem optionalen Element und setzt Pflichtfeld-Validierung aus.</p>

<p><em>Parameter</em>: Keine.</p>
~',
    p_sat_pl_sql => q'~plugin_sct.register_mandatory('#ITEM#', null, false);~',
    p_sat_js => q'~de.condes.plugin.sct.setMandatory('#ITEM#', false);~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SUBMIT',
    p_sat_name => 'Seite absenden',
    p_sat_description => q'~<p>Pr&uuml;ft alle Pflichtfelder und l&ouml;st SUBMIT der Seite aus.</p>
<p><em>Parameter</em>:</p>
<ul>
	<li><span style="font-family:courier new,courier,monospace">REQUEST </span>kann optional &uuml;bergeben werden, ansonsten wird <span style="font-family:courier new,courier,monospace">SUBMIT </span>verwendet.</li>
	<li><span style="font-family:courier new,courier,monospace">MESSAGE </span>wird verwendet, um die Nachricht auf der Seite zu definieren.</li>
</ul>~',
    p_sat_pl_sql => q'~plugin_sct.submit_page;~',
    p_sat_js => q'~de.condes.plugin.sct.submit('#ATTRIBUTE#', '#ATTRIBUTE_2#')~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 1);

  sct_admin.merge_action_type(
    p_sat_id => 'SET_ELEMENT_FROM_STMT',
    p_sat_name => 'Elementwert mit SQL-Anweisung setzen',
    p_sat_description => q'~<p>Setzt einen Elementwert basierend auf einer SQL-Anweisung, die einen einzelnen Wert zur&uuml;ckgibt.</p>

<p><em>Parameter</em>: SQL-Anweisung, die einen einzelnen Wert in einer Spalte namens VALUE zu&uuml;ckgibt</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_value_from_stmt('#ITEM#', '#ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 0);
  
  sct_admin.merge_action_type(
    p_sat_id => 'SET_LIST_FROM_STMT',
    p_sat_name => 'Liste von Werten mit SQL-Anweisung setzen',
    p_sat_description => q'~<p>Setzt einen Elementwert auf eine Liste von Werten, basierend auf einer SQL-Anweisung.</p>

<p><em>Parameter</em>:  SQL-Anweisung, die eine Werteliste in einer Spalte namens VALUE zu&uuml;ckgibt</p>
~',
    p_sat_pl_sql => q'~plugin_sct.set_list_from_stmt('#ITEM#', '#ATTRIBUTE#');~',
    p_sat_js => q'~~',
    p_sat_is_editable => 0,
    p_sat_raise_recursive => 0);

  -- RULE GROUP SCT_GLOBAL (ID 0
  sct_admin.merge_rule_group(
    p_sgr_app_id => null,
    p_sgr_page_id => null,
    p_sgr_id => 0,
    p_sgr_name => q'~SCT_GLOBAL~',
    p_sgr_description => q'~Globale Regeln, werden immer angewendet~',
    p_sgr_active => 1);
    
  merge into sct_page_item spi
  using (select 0 spi_sgr_id,
                'ALL' spi_id,
                'ITEM' spi_sit_id,
                q'~v(('#ITEM#')~' spi_conversion
           from dual) v
     on (spi.spi_sgr_id = v.spi_sgr_id and spi.spi_id = v.spi_id)
   when not matched then insert (spi_sgr_id, spi_id, spi_sit_id, spi_conversion)
        values (v.spi_sgr_id, v.spi_id, v.spi_sit_id, v.spi_conversion);

  -- RULES~
  sct_admin.merge_rule(
    p_sru_id => 0,
    p_sru_sgr_id => 0,
    p_sru_name => q'~Pflichtfeld~',
    p_sru_condition => q'~firing_item = sra_spi_id~',
    p_sru_sort_seq => 9999,
    p_sru_active => 1);

  -- RULE ACTIONS
  sct_admin.merge_rule_action(
    p_sra_sru_id => 0,
    p_sra_sgr_id => 0,
    p_sra_spi_id => 'ALL',
    p_sra_sat_id => 'CHECK_MANDATORY',
    p_sra_attribute => q'~~',
    p_sra_attribute_2 => q'~~',
    p_sra_sort_seq => 10,
    p_sra_active => 1);

  commit;
end;
/
set define on