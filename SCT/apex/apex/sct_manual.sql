set define off
set verify off
set serveroutput on size 1000000
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end;
/
 
 
--application/set_environment
prompt  WEBSHEET APPLICATION 102 - SCT
--
-- Websheet Application Export:
--   Application:     102
--   Name:            SCT
--   Date and Time:   19:37 Dienstag September 4, 2018
--   Exported By:     BUCH_ADMIN
--   Export Type:     Websheet Application Export
--   Version:         18.1.0.00.45
--   Instance ID:     227397589831276
--   Websheet Schema: APEX_BUCH
--
-- Import:
--   Using App Builder
--   or
--   Using SQL*Plus as the Oracle user Websheet schema, APEX_BUCH
 
-- Application Statistics:
--   Pages:                  9
--   Data Grids:             0
--   Reports:                1
 
 
--
-- ORACLE
--
-- Application Express (APEX)
--
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Websheet schema, APEX_BUCH.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,2590499873934823));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'de'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2018.04.04');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_ws_app_id := nvl(wwv_flow_application_install.get_application_id,102);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
 
end;
/

prompt  ...Remove Websheet Application
--application/delete_application
 
begin
 
-- remove internal metadata
wwv_flow_api.remove_ws_app(nvl(wwv_flow_application_install.get_application_id,102));
-- remove websheet metadata
wwv_flow_ws_import_api.remove_ws_components(nvl(wwv_flow_application_install.get_application_id,102));
 
end;
/

prompt  ...Create Websheet Application
--application/create_ws_app
begin
    wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
 
end;
/

begin
wwv_flow_api.create_ws_app(
  p_id    => nvl(wwv_flow_application_install.get_application_id,102),
  p_name  => 'SCT',
  p_owner => nvl(wwv_flow_application_install.get_schema,'APEX_BUCH'),
  p_description => '',
  p_status => 'AVAILABLE',
  p_date_format => 'dd.mm.yyyy',
  p_language => 'de',
  p_territory => 'GERMANY',
  p_home_page_id => 3468677429831871+wwv_flow_api.g_id_offset,
  p_auth_id => 3468791898831871+wwv_flow_api.g_id_offset,
  p_acl_type => 'DEFAULT',
  p_login_url => '',
  p_logout_url => '',
  p_allow_sql_yn => 'Y',
  p_show_reset_passwd_yn => 'Y',
  p_allow_public_access_yn => 'Y',
  p_logo_type => 'TEXT',
  p_logo_text => 'Anwenderhandbuch SCT-Aministrationsanwendung',
  p_varchar2_table => wwv_flow_api.g_varchar2_table,
  p_email_from => '');
----------------
  wwv_flow_api.create_ws_app_sug_objects (
    p_id => 3491733790062745+wwv_flow_api.g_id_offset,
    p_ws_app_id => nvl(wwv_flow_application_install.get_application_id,102),
    p_object_name => 'SCT_UI_ACTION_TYPE_HELP',
    p_object_comment => 'Liefert Hilfstext',
    p_last_updated_by => 'BUCH_ADMIN',
    p_last_updated_on => to_date('201809011641','YYYYMMDDHH24MI'),
    p_created_by => 'BUCH_ADMIN',
    p_created_on => to_date('201809011633','YYYYMMDDHH24MI'));
 
end;
/

----------------
--package app map
--
prompt  ...Create Access Control List
prompt  ...Create Application Authentication Set Up
declare
  sf varchar2(32767) := null;
  vf varchar2(32767) := null;
  pre_ap varchar2(32767) := null;
  af varchar2(32767) := null;
  post_ap varchar2(32767) := null;
begin
af:=af||'-BUILTIN-';

wwv_flow_api.create_ws_auth_setup(
  p_id => 3468791898831871+wwv_flow_api.g_id_offset,
  p_websheet_application_id => wwv_flow.g_ws_app_id,
  p_name => 'Apex Authentication',
  p_invalid_session_url => 'f?p=4900:101:&SESSION.::NO::WS_APP_ID,P900_ID:&WS_APP_ID.,&P900_ID.&p_lang=&APP_SESSION_LANG.&p_territory=&APP_SESSION_TERRITORY.',
  p_auth_function => af,
  p_cookie_name => '&WORKSPACE_COOKIE.',
  p_use_secure_cookie_yn => 'N',
  p_logout_url => 'ws?p='||wwv_flow.g_ws_app_id||':home'
  );
 
end;
/

prompt  ...Create Data Grid
prompt  ...Create Report
declare
  q varchar2(32767) := null;
begin
q:=q||'select * from "SCT_UI_ACTION_TYPE_HELP"';

wwv_flow_api.create_ws_worksheet (
  p_id => 3495304670234187+wwv_flow_api.g_id_offset,
  p_page_id => 3000,
  p_region_id => null,
  p_name => 'Hilfe zu Aktionstypen',
  p_max_row_count => '1000000',
  p_max_row_count_message => 'Die maximale Anzahl der Zeilen für diesen Bericht ist #MAX_ROW_COUNT#. Wenden Sie einen Filter an, um die Anzahl der Datensätze in der Abfrage zu reduzieren.',
  p_no_data_found_message => 'Keine Daten gefunden.',
  p_sql_query => q,
  p_status => 'AVAILABLE_FOR_OWNER',
  p_allow_report_saving => 'Y',
  p_allow_report_categories => 'Y',
  p_pagination_type => 'ROWS_X_TO_Y_OF_Z',
  p_pagination_display_pos => 'BOTTOM_RIGHT',
  p_show_finder_drop_down => 'Y',
  p_show_display_row_count => 'N',
  p_show_search_bar => 'Y',
  p_show_search_textbox => 'Y',
  p_show_actions_menu => 'Y',
  p_report_list_mode => 'TABS',
  p_fixed_header => 'NONE',
  p_show_select_columns => 'Y',
  p_show_filter => 'Y',
  p_show_sort => 'Y',
  p_show_control_break => 'Y',
  p_show_highlight => 'Y',
  p_show_computation => 'Y',
  p_show_aggregate => 'Y',
  p_show_chart => 'Y',
  p_show_group_by => 'Y',
  p_show_pivot => 'Y',
  p_show_calendar => 'Y',
  p_show_flashback => 'Y',
  p_show_reset => 'Y',
  p_show_download => 'Y',
  p_show_help => 'Y',
  p_show_detail_link => 'Y',
  p_download_formats => 'CSV:HTML:EMAIL',
  p_detail_link_text => '<img src="#IMAGE_PREFIX#ws/small_page.gif" alt="" />',
  p_allow_exclude_null_values => 'Y',
  p_allow_hide_extra_columns => 'Y',
  p_icon_view_enabled_yn => 'N',
  p_icon_view_use_custom=>'N',
  p_detail_view_enabled_yn => 'N',
  p_show_notify => 'N',
  p_allow_save_rpt_public => 'N',
  p_show_rows_per_page => 'Y',
  p_internal_uid => 3495304670234187
  );
end;
/
begin
wwv_flow_api.create_ws_data_grid (
    p_id => 3495404049234187+wwv_flow_api.g_id_offset,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_worksheet_id => 3495304670234187+wwv_flow_api.g_id_offset,
    p_ws_report_owner => 'APEX_BUCH',
    p_is_template => '',
    p_status => 'PRIVATE',
    p_websheet_type => 'REPORT',
    p_websheet_name => 'Hilfe zu Aktionstypen',
    p_websheet_alias => 'ACTION_TYPE_HELP',
    p_websheet_owner => 'BUCH_ADMIN',
    p_geo_resp_sep => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 3495577779234189+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 3495304670234187+wwv_flow_api.g_id_offset,
  p_websheet_id => 3495404049234187+wwv_flow_api.g_id_offset,
  p_db_column_name => 'SAT_NAME',
  p_display_order => 1,
  p_data_grid_form_seq => 1,
  p_column_identifier => 'A',
  p_column_label => 'Sat Name',
  p_report_label => 'Sat Name',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'LEFT',
  p_column_alignment => 'LEFT',
  p_max_length => null,
  p_display_width => null,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 3495663582234189+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 3495304670234187+wwv_flow_api.g_id_offset,
  p_websheet_id => 3495404049234187+wwv_flow_api.g_id_offset,
  p_db_column_name => 'SAT_DESCRIPTION',
  p_display_order => 2,
  p_data_grid_form_seq => 2,
  p_column_identifier => 'B',
  p_column_label => 'Sat Description',
  p_report_label => 'Sat Description',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'N',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'N',
  p_allow_aggregations => 'N',
  p_allow_computations => 'N',
  p_allow_charting => 'N',
  p_allow_group_by => 'N',
  p_allow_pivot => 'N',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'CLOB',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'WITHOUT_MODIFICATION',
  p_heading_alignment => 'LEFT',
  p_column_alignment => 'LEFT',
  p_max_length => null,
  p_display_width => null,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'N',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 3495757752234189+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 3495304670234187+wwv_flow_api.g_id_offset,
  p_websheet_id => 3495404049234187+wwv_flow_api.g_id_offset,
  p_db_column_name => 'SAT_IS_EDITABLE',
  p_display_order => 3,
  p_data_grid_form_seq => 3,
  p_column_identifier => 'C',
  p_column_label => 'Sat Is Editable',
  p_report_label => 'Sat Is Editable',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'LEFT',
  p_column_alignment => 'LEFT',
  p_max_length => null,
  p_display_width => null,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'SAT_NAME:SAT_DESCRIPTION:SAT_IS_EDITABLE';

wwv_flow_api.create_ws_rpt(
  p_id => 3495819102234200+wwv_flow_api.g_id_offset,
  p_page_id=> 3000,
  p_worksheet_id => 3495304670234187+wwv_flow_api.g_id_offset,
  p_websheet_id  => 3495404049234187+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_DEFAULT',
  p_report_seq => 10,
  p_report_alias => '34959',
  p_status => 'PUBLIC',
  p_is_default => 'Y',
  p_display_rows => 50,
  p_report_columns => rc1,
  p_flashback_enabled => 'N',
  p_calendar_display_column => ''
  );
end;
/
 
--application/pages/page_3480434153889967
prompt  ...PAGE 3480434153889967: SCT-Administrationsanwendung
--
begin
wwv_flow_api.create_ws_page (
    p_id => 3480434153889967+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => null+wwv_flow_api.g_id_offset,
    p_name => 'SCT-Administrationsanwendung',
    p_upper_name => 'SCT-ADMINISTRATIONSANWENDUNG',
    p_page_alias => 'HOME',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

prompt  ...Create Page
 
--application/pages/page_3468677429831871
prompt  ...PAGE 3468677429831871: Übersicht der Regelgruppen
--
begin
wwv_flow_api.create_ws_page (
    p_id => 3468677429831871+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 3480434153889967+wwv_flow_api.g_id_offset,
    p_name => 'Übersicht der Regelgruppen',
    p_upper_name => 'ÜBERSICHT DER REGELGRUPPEN',
    p_page_alias => 'ADMIN_SGR',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>Die Seite dient dem Export von einzelnen oder mehreren Regelgruppen in eine SQL-Textdatei.</p>'||chr(10)||
''||chr(10)||
'<p>Die Exportdatei umfasst die Regelgruppen, die einzelnen Regeln sowie die Aktionen der Einzelregeln.<br />'||chr(10)||
'Werden alle Regelgruppen einer Anwendung exportiert, umfasst die Exportdatei auch die Aktionstypen, die durch die Entwickler angelegt wurden.</p>'||chr(10)||
''||chr(10)||
'<p>Werden die Regelgruppen aller Anwendungen ';

c:=c||'exportiert, umfasst die Exportdatei zus&auml;tzlich die Aktionstypen, die mit der Anwendung mitgeliefert werden. Dieser Export dient dem Zusammenstellen eigener Importskripte inklusiv der mitgelieferten Aktionstypen.</p>'||chr(10)||
''||chr(10)||
'<p>Einzelne Regelgruppen werden als SQL-Textdatei ausgeliefert, mehrere Regelgruppen als ein ZIP mit mehreren SQL-Textdateien</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 197235628017553824348746729284572709330+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 3468677429831871+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'TEXT',
   p_title => 'Regelgruppe exportieren',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

 
--application/pages/page_3480340898887564
prompt  ...PAGE 3480340898887564: Aktionstypen
--
begin
wwv_flow_api.create_ws_page (
    p_id => 3480340898887564+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 3480434153889967+wwv_flow_api.g_id_offset,
    p_name => 'Aktionstypen',
    p_upper_name => 'AKTIONSTYPEN',
    p_page_alias => 'ADMIN_SAT',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

 
--application/pages/page_3480553967899885
prompt  ...PAGE 3480553967899885: Regelgruppe erzeugen/bearbeiten
--
begin
wwv_flow_api.create_ws_page (
    p_id => 3480553967899885+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 3468677429831871+wwv_flow_api.g_id_offset,
    p_name => 'Regelgruppe erzeugen/bearbeiten',
    p_upper_name => 'REGELGRUPPE ERZEUGEN/BEARBEITEN',
    p_page_alias => 'EDIT_SGR',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>Eine Regelgruppe stellt den Ankerpunkt f&uuml;r ein SCT-Plugin auf der Anwendungsseite dar. Sie fasst die einzelnen Regeln der Seite zusammen und verbindet diese &uuml;ber die Referenz auf den Regelgruppennamen mit einer Anwendungsseite.</p>'||chr(10)||
''||chr(10)||
'<p>Die Seite erfordert die Angabe dieses Regelgruppennamens sowie einer kurzen, sprechenden Beschreibung</p>'||chr(10)||
''||chr(10)||
'<p>Verbinden Sie anschlie&szlig;end die Rege';

c:=c||'lgruppe mit einer Anwendung und einer Seite innerhalb dieser Anwendung. Auf diese Anwendungsseite muss das korrespondierende Plugin mit dem hier vergebenen Regelgruppennamen eingerichtet werden.</p>'||chr(10)||
''||chr(10)||
'<p>Eine Regelgruppe kann als Ganzes aktiviert oder deaktiviert werden. Dies ist zur Entwicklungszeit hilfreich</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 24940513690687792320331102890075850382+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 3480553967899885+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'TEXT',
   p_title => 'Regelgruppe erstellen/bearbeiten',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

 
--application/pages/page_3480653930902917
prompt  ...PAGE 3480653930902917: Regelgruppe exportieren
--
begin
wwv_flow_api.create_ws_page (
    p_id => 3480653930902917+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 3468677429831871+wwv_flow_api.g_id_offset,
    p_name => 'Regelgruppe exportieren',
    p_upper_name => 'REGELGRUPPE EXPORTIEREN',
    p_page_alias => 'EXPORT_SGR',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

 
--application/pages/page_3480850007906135
prompt  ...PAGE 3480850007906135: Regel erzeugen
--
begin
wwv_flow_api.create_ws_page (
    p_id => 3480850007906135+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 3468677429831871+wwv_flow_api.g_id_offset,
    p_name => 'Regel erzeugen',
    p_upper_name => 'REGEL ERZEUGEN',
    p_page_alias => 'EDIT_SRU',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>Eine Regel analysiert eine Bedingung und entscheidet, was in dem Fall, dass die Bedingung zu <code>WAHR</code> evaluiert, was zu tun ist.<br />'||chr(10)||
'Ob die Einzelregel ausgef&uuml;hrt wird, h&auml;ngt neben dieser Bedingung noch von weiteren Faktoren ab:</p>'||chr(10)||
''||chr(10)||
'<ul>'||chr(10)||
'	<li>'||chr(10)||
'	<p>Die Reihenfolge der Regeln, die erste erfolgreiche Regel wird ausgef&uuml;hrt</p>'||chr(10)||
'	</li>'||chr(10)||
'	<li>Dem Flag <code>Beim Seitenladen a';

c:=c||'usf&uuml;hren</code>. Dieses Flag legt fest, dass diese Regel zus&auml;tzlich zur ersten Regel ausgef&uuml;hrt wird, wenn die Seite initialisiert wird.</li>'||chr(10)||
'</ul>'||chr(10)||
''||chr(10)||
'<p>Legen Sie einen Regelnamen sowie die Regelbedingung fest. Die Regelbedingung ist ein Ausriss einer <code>WHERE</code>-Klausel, in der folgende Spalten zur Verf&uuml;gung stehen:</p>'||chr(10)||
''||chr(10)||
'<h2>Aktionen</h2>'||chr(10)||
''||chr(10)||
'<p>Aktionen regeln, was gescheh';

c:=c||'en soll, wenn die Regel ausgef&uuml;hrt wird.</p>'||chr(10)||
''||chr(10)||
'<p>Eine Aktion bezieht sich immer auf ein Seitenelement oder auf <code>DOCUMENT</code>, wenn kein konkretes Element angesprochen werden soll.<br />'||chr(10)||
'Schaltfl&auml;chen und Regionen lassen sich nur ansprechen, wenn ihnen auf der Anwendungsseite eine statische ID zugewiesen wurde. Auf diese Weise wird verhindert, dass in den Aktionen kryptische, inte';

c:=c||'rne IDs verwendet werden m&uuml;ssen.</p>'||chr(10)||
''||chr(10)||
'<p>Als Aktion wird eine Eintrag aus der Liste der Aktionstypen ausgew&auml;hlt. Sollte die ben&ouml;tigte Aktion nicht vorhanden sein, kann sie als Aktionstyp angelegt und hier referenziert werden.</p>'||chr(10)||
''||chr(10)||
'<h3>Achtung</h3>'||chr(10)||
''||chr(10)||
'<p>Bitte &auml;ndern Sie nicht die mitgelieferten Aktionstypen, da diese unter zum Teil spezielle Funktionen ansprechen, die nur in Komb';

c:=c||'ination mit dem SCT korrekt funktionieren</p>'||chr(10)||
''||chr(10)||
'<p>&nbsp;</p>'||chr(10)||
''||chr(10)||
'<p><code>&lt;Name des Seitenelements&gt;</code></p>'||chr(10)||
''||chr(10)||
'<p>Diese Spalte enth&auml;lt den aktuellen Wert des Seitenelements auf der Seite. Ist das Seitenelement mit einer Formatmaske auf der Seite angelegt worden, ist diese Maske bereits angewendet worden. Dadurch ist ein Nummernfeld eine Zahl und ein Datumsfeld ein Datum.<br />'||chr(10)||
'Ist das Sei';

c:=c||'tenelement eine Schaltfl&auml;che, enth&auml;lt die Spalte den Wert <code>1</code>, falls diese Schaltfl&auml;che geklickt wurde und <code>0</code> anderenfalls.</p>'||chr(10)||
''||chr(10)||
'<p><code>FIRING_ITEM</code></p>'||chr(10)||
''||chr(10)||
'<p>Diese Spalte enth&auml;lt den Namen des Seitenelements, dass die Regelausf&uuml;hrung ausgel&ouml;st hat. Beim Initialisieren der Seite ist der Inhalt <code>DOCUMENT</code>, bei einem Klick auf ein';

c:=c||'e Schaltfl&auml;che die statische ID der Schaltfl&auml;che, ansonsten der Elementname</p>'||chr(10)||
''||chr(10)||
'<p><code>INITIALIZING</code></p>'||chr(10)||
''||chr(10)||
'<p>Die Spalte enth&auml;lt den Wert <code>1</code>, wenn die Seite initialisiert, und <code>0</code> anderenfalls</p>'||chr(10)||
''||chr(10)||
'<p><code>DOCUMENT</code></p>'||chr(10)||
''||chr(10)||
'<p>Die Spalte enth&auml;lt den Wert <code>1</code>, falls die Seite initialisiert wird und <code>0</code> anderenfalls.</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 241875488554205211368454991286361428228+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 3480850007906135+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'TEXT',
   p_title => 'Einzelregel erzeugen/bearbeiten',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

 
--application/pages/page_3490986440030165
prompt  ...PAGE 3490986440030165: Regelgruppe kopieren
--
begin
wwv_flow_api.create_ws_page (
    p_id => 3490986440030165+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 3468677429831871+wwv_flow_api.g_id_offset,
    p_name => 'Regelgruppe kopieren',
    p_upper_name => 'REGELGRUPPE KOPIEREN',
    p_page_alias => 'COPY_SGR',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>Die Seite kopiert eine Regelgruppe innerhalb einer Anwendung oder zwischen Anwendungen</p>'||chr(10)||
''||chr(10)||
'<p>Bevor eine Anwendung kopiert werden kann, muss sichergestellt sein, dass auf der Zielseite alle Seitenelemente, die in der Regelgruppe angesprochen werden, vorhanden sind.</p>'||chr(10)||
''||chr(10)||
'<p>Klassischer Anwendungsfall ist, dass eine Regelgruppe auf eine Kopie der Anwendungsseite, die innerhalb einer Anwendung od';

c:=c||'er in einer anderen Anwendung angelegt wurde, kopiert werden soll.</p>'||chr(10)||
''||chr(10)||
'<p>Ein alternativer Weg zum Kopieren einer Regelgruppe in eine andere Anwendung ist der Export der Regelgruppe und die Installation in der Zielanwendung. Dieser Weg sollte beschritten werden, wenn Quell- und Zielanwendung identisch sind, aber auf verschiedenen Datenbanken installiert wurden, wie zum Beispiel Entwicklung -&gt; ';

c:=c||'Test -&gt; Produktion</p>'||chr(10)||
''||chr(10)||
'<p>Zum Kopieren einer Regelgruppe muss diese ausgew&auml;hlt sowie die Zielanwendung bestimmt werden. Anschlie&szlig;end kann mittels des Attributs <em>&Uuml;berschreiben</em> festgelegt werden, ob eine exisiterende Regelgruppe dieser Seite &uuml;berschrieben werden soll oder nicht.</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 177483833263890372575655880912641374757+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 3490986440030165+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'TEXT',
   p_title => 'Regelgruppe kopieren',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

 
--application/pages/page_3490621146015401
prompt  ...PAGE 3490621146015401: Aktionstyp bearbeiten
--
begin
wwv_flow_api.create_ws_page (
    p_id => 3490621146015401+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 3480340898887564+wwv_flow_api.g_id_offset,
    p_name => 'Aktionstyp bearbeiten',
    p_upper_name => 'AKTIONSTYP BEARBEITEN',
    p_page_alias => 'EDIT_SAT',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<h2>Hinweise</h2>'||chr(10)||
''||chr(10)||
'<ul>'||chr(10)||
'	<li>PL/SQL-Code wird ausgef&uuml;hrt, bevor die JavaScript-Aktionen ausgef&uuml;hrt werden.</li>'||chr(10)||
'	<li>Ergebnisse des PL/SQL-Code k&ouml;nnen im SessionState hinterlegt werden, ge&auml;nderte Werte werden auf die Anwendungsseite &uuml;bernommen. Nutzen Sie hierf&uuml;r <em>nicht</em> die Funktion <code>APEX_UTIL.SET_SESSION_STATE</code>, sondern das Pendant <code>PLUGIN_SCT';

c:=c||'.SET_SESSION_STATE</code>, da ansonsten das Plugin nicht wei&szlig;, dass die Information ge&auml;ndert wurde.</li>'||chr(10)||
'	<li>Fehlermeldungen von PL/SQL-Code sollten &uuml;ber die Prozedur <code>plugin_sct.register_error(&#39;#ITEM#&#39;, &#39;#ATTRIBUTE#&#39;);</code> aufgezeichnet werden, damit sie auf der Oberfl&auml;che angezeigt werden k&ouml;nnen. <code>#ATTRIBUTE#</code> referenziert dabei die F';

c:=c||'ehlermeldung.</li>'||chr(10)||
'</ul>'||chr(10)||
''||chr(10)||
'<p><code>#ITEM#</code></p>'||chr(10)||
''||chr(10)||
'<p>Referenz auf den aktuellen Elementnamen</p>'||chr(10)||
''||chr(10)||
'<p><code>#ATTRIBUTE#</code></p>'||chr(10)||
''||chr(10)||
'<p>Referenz auf einen Attributwert, der zu einer Aktion definiert wird</p>'||chr(10)||
''||chr(10)||
'<p><code>#ATTRIBUTE_2#</code></p>'||chr(10)||
''||chr(10)||
'<p>Referenz auf einen zweiten Attributwert, der zu einer Aktion definiert wird</p>'||chr(10)||
''||chr(10)||
'<p><code>#ALLOW_RECURSION#</code></p>'||chr(10)||
''||chr(10)||
'<p>&Uuml;bergibt ein Flag, das ';

c:=c||'festlegt, ob dieses Element rekursiv ausgef&uuml;hrt wird oder nicht.</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 327470598078547576362275795539748143707+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 3490621146015401+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'TEXT',
   p_title => 'Ersetzungszeichenfolgen',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

 
--application/pages/page_3491616561052640
prompt  ...PAGE 3491616561052640: Hilfe zu Aktionstypen
--
begin
wwv_flow_api.create_ws_page (
    p_id => 3491616561052640+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 3480340898887564+wwv_flow_api.g_id_offset,
    p_name => 'Hilfe zu Aktionstypen',
    p_upper_name => 'HILFE ZU AKTIONSTYPEN',
    p_page_alias => 'HELP_SAT',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<pre>'||chr(10)||
'[[ report: ACTION_TYPE_HELP ]]</pre>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 34508078613373431366205121536340957794+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 3491616561052640+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'TEXT',
   p_title => 'Hilfe zu Aktionstypen',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

prompt  ...Create Annotations
begin
--application/end_environment
commit;
end;
/

begin
execute immediate 'begin sys.dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/

set verify on
set feedback on
prompt  ...done
