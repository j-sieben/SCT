prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.05.24'
,p_release=>'18.2.0.00.12'
,p_default_workspace_id=>2562619397308603
,p_default_application_id=>102
,p_default_owner=>'APEX_BUCH'
);
end;
/
 
prompt APPLICATION 102 - SCT-Administrationsanwendung
--
-- Application Export:
--   Application:     102
--   Name:            SCT-Administrationsanwendung
--   Date and Time:   14:29 Montag November 19, 2018
--   Exported By:     BUCH_ADMIN
--   Flashback:       0
--   Export Type:     Application Export
--   Version:         18.2.0.00.12
--   Instance ID:     248206643246362
--

-- Application Statistics:
--   Pages:                     14
--     Items:                   78
--     Computations:             2
--     Validations:              5
--     Processes:               30
--     Regions:                 29
--     Buttons:                 38
--     Dynamic Actions:         22
--   Shared Components:
--     Logic:
--       Items:                  1
--       Computations:           1
--     Navigation:
--       Lists:                  3
--       Breadcrumbs:            1
--         Entries:              3
--     Security:
--       Authentication:         1
--       Authorization:          1
--     User Interface:
--       Themes:                 1
--       Templates:
--         Page:                 9
--         Region:              15
--         Label:                7
--         List:                12
--         Popup LOV:            1
--         Calendar:             1
--         Breadcrumb:           1
--         Button:               3
--         Report:              10
--       LOVs:                   9
--       Shortcuts:              1
--       Plug-ins:               1
--     Globalization:
--     Reports:
--     E-Mail:
--   Supporting Objects:  Included

prompt --application/delete_application
begin
wwv_flow_api.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_display_id=>nvl(wwv_flow_application_install.get_application_id,102)
,p_owner=>nvl(wwv_flow_application_install.get_schema,'APEX_BUCH')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'SCT-Administrationsanwendung')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'SCT')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'N'
,p_checksum_salt=>'4D49DB7C365CABBC67C53646438E477097138139E19AD10172DB050B151A620E'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'5.0'
,p_flow_language=>'de'
,p_flow_language_derived_from=>'0'
,p_date_format=>'dd.mm.yyyy'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(134941278002603591)
,p_populate_roles=>'A'
,p_application_tab_set=>0
,p_logo_image=>'TEXT:SCT-Administrationsanwendung'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181119142926'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>4
,p_ui_type_name => null
);
end;
/
prompt --application/shared_components/navigation/lists/anwendungsbereiche
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(14533494841582546)
,p_name=>'Anwendungsbereiche'
,p_list_type=>'SQL_QUERY'
,p_list_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null, ',
'       label_value,',
'       target_value,',
'       is_current,',
'       image_value,',
'       image_attr_value,',
'       image_alt_value,',
'       attribute_01,',
'       attribute_02,',
'       attribute_03,',
'       attribute_04,',
'       attribute_05,',
'       attribute_06,',
'       attribute_07,',
'       attribute_08,',
'       attribute_09,',
'       attribute_10',
'  from apex_ui_list_menu',
' where list_name = ''Desktop Navigation Menu''',
'   and level_value = 2',
' order by display_sequence'))
,p_list_status=>'PUBLIC'
);
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_menu
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(134898851143603502)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(14529105251552563)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Startseite'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:HOME:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'10'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(134942425985603605)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Regelgruppen'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_SGR:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-calendar-check-o'
,p_parent_list_item_id=>wwv_flow_api.id(14529105251552563)
,p_list_text_01=>'Gruppierung von Regeln'
,p_list_text_02=>'Verwaltung der Regelgruppen und Regeln'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(135303043160646286)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Aktionstypen'
,p_list_item_link_target=>'f?p=&APP_ALIAS.:ADMIN_SAT:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cog'
,p_parent_list_item_id=>wwv_flow_api.id(14529105251552563)
,p_list_text_01=>'Administration der Aktionstypen'
,p_list_text_02=>'Interne und benutzerdefinierte Aktionstypen'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'2'
);
end;
/
prompt --application/shared_components/navigation/lists/desktop_navigation_bar
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(134940898891603572)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(134941127132603588)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Log Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_current_for_pages=>'&LOGOUT_URL.'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(13477402972313485)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Hilfe'
,p_list_item_link_target=>'f?p=&APP_ID.:HELP:&SESSION.::&DEBUG.::P99_TARGET_PAGE:&APP_PAGE_ALIAS.:'
,p_list_item_icon=>'fa-question'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(13426365731503276)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attribute_01=>'LEGACY'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(13426458477503276)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'classic'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(13426464525503374)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_RICH_TEXT_EDITOR'
,p_attribute_01=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(13426702061503276)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IG'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(20846774401716785)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'PLUGIN_DE.CONDES.PLUGIN.SCT'
,p_attribute_01=>'de.condes.plugin.sct.apex_42_18_1'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(134898576753603502)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(134898667867603502)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_CSS_CALENDAR'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(134898762971603502)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'1'
,p_attribute_02=>'Ja'
,p_attribute_03=>'0'
,p_attribute_04=>'Nein'
,p_attribute_05=>'SELECT_LIST'
);
end;
/
prompt --application/shared_components/security/authorizations/ist_sct_admin
begin
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(13506519464917176)
,p_name=>'Ist SCT-Admin'
,p_scheme_type=>'NATIVE_IS_IN_GROUP'
,p_attribute_01=>'SCT_ADMIN'
,p_attribute_02=>'A'
,p_error_message=>unistr('Sie haben keine Berechtigung f\00FCr diese Informationen')
,p_caching=>'BY_USER_BY_SESSION'
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_items
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(42028628668242328)
,p_name=>'APP_HELP_WS'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_computations
begin
wwv_flow_api.create_flow_computation(
 p_id=>wwv_flow_api.id(13476761058309203)
,p_computation_sequence=>10
,p_computation_item=>'APP_HELP_WS'
,p_computation_point=>'ON_NEW_INSTANCE'
,p_computation_type=>'QUERY'
,p_computation_processed=>'REPLACE_EXISTING'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select application_id',
'  from apex_ws_applications',
' where application_name = (select v(''APP_ALIAS'') from dual)'))
);
end;
/
prompt --application/shared_components/logic/application_settings
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs/lov_action_type
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(135035935047724794)
,p_lov_name=>'LOV_ACTION_TYPE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_list_action_type',
' order by d'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_apex_action_type
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(13451221465166582)
,p_lov_name=>'LOV_APEX_ACTION_TYPE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_apex_action_type',
' order by d'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_application_items
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(135456906931892652)
,p_lov_name=>'LOV_APPLICATION_ITEMS'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_sgr_page_items',
' where sgr_id = :P5_SRU_SGR_ID',
' order by d'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_application_pages
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(135221719282542325)
,p_lov_name=>'LOV_APPLICATION_PAGES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_app_pages',
' where application_id = :P6_SGR_APP_ID',
' order by d'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_applications
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(135221558062531624)
,p_lov_name=>'LOV_APPLICATIONS'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_applications',
' order by r'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_export_type
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(42115289147202742)
,p_lov_name=>'LOV_EXPORT_TYPE'
,p_lov_query=>'.'||wwv_flow_api.id(42115289147202742)||'.'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(8028561853572918)
,p_lov_disp_sequence=>0
,p_lov_disp_value=>'Alle Regelgruppen'
,p_lov_return_value=>'ALL'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(42115568725202742)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Alle Regelgruppen einer Anwendung'
,p_lov_return_value=>'APP'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(42116064639202744)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Eine Regelgruppe'
,p_lov_return_value=>'SGR'
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_sgr_application_pages
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(82374468923779452)
,p_lov_name=>'LOV_SGR_APPLICATION_PAGES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_sgr_app_pages',
' where sgr_app_id = :P1_SGR_APP_ID',
' order by r'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_sgr_applications
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(82373583928764511)
,p_lov_name=>'LOV_SGR_APPLICATIONS'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_sgr_applications',
' order by r'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/lov_yes_no
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(4898774116149979)
,p_lov_name=>'LOV_YES_NO'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_yes_no',
' order by d'))
);
end;
/
prompt --application/pages/page_groups
begin
null;
end;
/
prompt --application/comments
begin
null;
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_api.create_menu(
 p_id=>wwv_flow_api.id(134942349375603603)
,p_name=>' Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(14530021000552563)
,p_short_name=>'Startseite'
,p_link=>'f?p=&APP_ID.:10:&SESSION.'
,p_page_id=>10
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(134942694208603606)
,p_parent_id=>0
,p_short_name=>'Regelgruppen'
,p_link=>'f?p=&APP_ALIAS.:ADMIN_SGR:&SESSION.'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(135308442966646309)
,p_parent_id=>0
,p_short_name=>'Aktionstypen'
,p_link=>'f?p=&APP_ALIAS.:ADMIN_SAT:&SESSION.'
,p_page_id=>2
);
end;
/
prompt --application/shared_components/user_interface/templates/page/left_side_column
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(134898882829603506)
,p_theme_id=>42
,p_name=>'Left Side Column'
,p_internal_name=>'LEFT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.leftSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding" role="banner">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-side" id="t_Body_side">',
'      #REGION_POSITION_02#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner" role="main">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>  ',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525196570560608698
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7755205885820070)
,p_page_template_id=>wwv_flow_api.id(134898882829603506)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7755690569820070)
,p_page_template_id=>wwv_flow_api.id(134898882829603506)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7756163654820070)
,p_page_template_id=>wwv_flow_api.id(134898882829603506)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7756717934820070)
,p_page_template_id=>wwv_flow_api.id(134898882829603506)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7757194883820071)
,p_page_template_id=>wwv_flow_api.id(134898882829603506)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7757707351820071)
,p_page_template_id=>wwv_flow_api.id(134898882829603506)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7758168362820071)
,p_page_template_id=>wwv_flow_api.id(134898882829603506)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7758688923820071)
,p_page_template_id=>wwv_flow_api.id(134898882829603506)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/left_and_right_side_columns
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(134899840747603514)
,p_theme_id=>42
,p_name=>'Left and Right Side Columns'
,p_internal_name=>'LEFT_AND_RIGHT_SIDE_COLUMNS'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.bothSideCols();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding" role="banner">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-side" id="t_Body_side">',
'      #REGION_POSITION_02#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner" role="main">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>  ',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525203692562657055
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7763399593820076)
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7763838348820076)
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7764410660820076)
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7764885329820076)
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7765414540820076)
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7765857229820076)
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7766404398820078)
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7766910332820078)
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7767389193820078)
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/login
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(134900816039603516)
,p_theme_id=>42
,p_name=>'Login'
,p_internal_name=>'LOGIN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.appLogin();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody--login no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #REGION_POSITION_01#',
'  #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'  <div class="t-Body-wrap">',
'    <div class="t-Body-col t-Body-col--main">',
'      <div class="t-Login-container" role="main">',
'      #BODY#',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>6
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2099711150063350616
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7769292470820078)
,p_page_template_id=>wwv_flow_api.id(134900816039603516)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7769803668820078)
,p_page_template_id=>wwv_flow_api.id(134900816039603516)
,p_name=>'Body Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/master_detail
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(134901157909603516)
,p_theme_id=>42
,p_name=>'Marquee'
,p_internal_name=>'MASTER_DETAIL'
,p_is_popup=>false
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'))
,p_javascript_code_onload=>'apex.theme42.initializePage.masterDetail();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--masterDetail t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding" role="banner">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-info" id="t_Body_info">',
'        #REGION_POSITION_02#',
'      </div>',
'      <div class="t-Body-contentInner" role="main">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>  ',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>1996914646461572319
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7774146992820081)
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7774699329820081)
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7775163800820081)
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7775684458820081)
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7776166451820081)
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7776671370820081)
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7777205869820081)
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7777696148820081)
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7778173419820081)
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/modal_dialog
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(134902141714603516)
,p_theme_id=>42
,p_name=>'Modal Dialog'
,p_internal_name=>'MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.modalDialog();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--standard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'      <div class="t-Dialog-bodyWrapperIn"><div class="t-Dialog-body" role="main">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      #BODY#',
'      </div></div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--standard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2098960803539086924
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7787394071820085)
,p_page_template_id=>wwv_flow_api.id(134902141714603516)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7787871919820085)
,p_page_template_id=>wwv_flow_api.id(134902141714603516)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7788361748820085)
,p_page_template_id=>wwv_flow_api.id(134902141714603516)
,p_name=>'Dialog Footer'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/right_side_column
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(134902532880603517)
,p_theme_id=>42
,p_name=>'Right Side Column'
,p_internal_name=>'RIGHT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.rightSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8"> ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding" role="banner">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner" role="main">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>  ',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" aria-label="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa fa-bars" a'
||'ria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525200116240651575
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7793013000820087)
,p_page_template_id=>wwv_flow_api.id(134902532880603517)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7793465467820087)
,p_page_template_id=>wwv_flow_api.id(134902532880603517)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7793997977820087)
,p_page_template_id=>wwv_flow_api.id(134902532880603517)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7794456625820089)
,p_page_template_id=>wwv_flow_api.id(134902532880603517)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7794995477820089)
,p_page_template_id=>wwv_flow_api.id(134902532880603517)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7795493768820089)
,p_page_template_id=>wwv_flow_api.id(134902532880603517)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7795921731820089)
,p_page_template_id=>wwv_flow_api.id(134902532880603517)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7796443510820089)
,p_page_template_id=>wwv_flow_api.id(134902532880603517)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/wizard_modal_dialog
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(134903390439603517)
,p_theme_id=>42
,p_name=>'Wizard Modal Dialog'
,p_internal_name=>'WIZARD_MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.wizardModal();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--wizard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'      <div class="t-Dialog-bodyWrapperIn"><div class="t-Dialog-body" role="main">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      #BODY#',
'      </div></div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},''t-Dialog-page--wizard ''+#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2120348229686426515
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7805657856820092)
,p_page_template_id=>wwv_flow_api.id(134903390439603517)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7806136894820092)
,p_page_template_id=>wwv_flow_api.id(134903390439603517)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7806675381820092)
,p_page_template_id=>wwv_flow_api.id(134903390439603517)
,p_name=>'Wizard Buttons'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/standard
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(134903802920603517)
,p_theme_id=>42
,p_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding" role="banner">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'      <div class="t-Body-title" id="t_Body_title">',
'        #REGION_POSITION_01#',
'      </div>',
'      <div class="t-Body-content" id="t_Body_content">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-contentInner" role="main">',
'          #BODY#',
'        </div>',
'        <footer class="t-Footer" role="contentinfo">',
'          <div class="t-Footer-body">',
'            <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'            <div class="t-Footer-apex">',
'              <div class="t-Footer-version">#APP_VERSION#</div>  ',
'              <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'              #BUILT_WITH_LOVE_USING_APEX#',
'            </div>',
'          </div>',
'          <div class="t-Footer-top">',
'            <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'          </div>',
'        </footer>',
'      </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>1
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>4070909157481059304
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7800346626820090)
,p_page_template_id=>wwv_flow_api.id(134903802920603517)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7800835525820090)
,p_page_template_id=>wwv_flow_api.id(134903802920603517)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7801326053820090)
,p_page_template_id=>wwv_flow_api.id(134903802920603517)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7801884277820090)
,p_page_template_id=>wwv_flow_api.id(134903802920603517)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7802356568820090)
,p_page_template_id=>wwv_flow_api.id(134903802920603517)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7802868288820090)
,p_page_template_id=>wwv_flow_api.id(134903802920603517)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7803404124820090)
,p_page_template_id=>wwv_flow_api.id(134903802920603517)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>false
);
end;
/
prompt --application/shared_components/user_interface/templates/page/minimal_no_navigation
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(134904646306603519)
,p_theme_id=>42
,p_name=>'Minimal (No Navigation)'
,p_internal_name=>'MINIMAL_NO_NAVIGATION'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES# t-PageBody--noNav" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding" role="banner">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  <div class="t-Body-main">',
'      <div class="t-Body-title" id="t_Body_title">',
'        #REGION_POSITION_01#',
'      </div>',
'      <div class="t-Body-content" id="t_Body_content">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-contentInner" role="main">',
'          #BODY#',
'        </div>',
'        <footer class="t-Footer" role="contentinfo">',
'          <div class="t-Footer-body">',
'            <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'            <div class="t-Footer-apex">',
'              <div class="t-Footer-version">#APP_VERSION#</div>  ',
'              <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'              #BUILT_WITH_LOVE_USING_APEX#',
'            </div>',
'          </div>',
'          <div class="t-Footer-top">',
'            <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton"><span class="a-Icon icon-up-chevron"></span></a>',
'          </div>',
'        </footer>',
'      </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>4
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2977628563533209425
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7782072479820084)
,p_page_template_id=>wwv_flow_api.id(134904646306603519)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7782568129820084)
,p_page_template_id=>wwv_flow_api.id(134904646306603519)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7783054318820084)
,p_page_template_id=>wwv_flow_api.id(134904646306603519)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7783608817820084)
,p_page_template_id=>wwv_flow_api.id(134904646306603519)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7784028910820084)
,p_page_template_id=>wwv_flow_api.id(134904646306603519)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7784525443820084)
,p_page_template_id=>wwv_flow_api.id(134904646306603519)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(7785102505820084)
,p_page_template_id=>wwv_flow_api.id(134904646306603519)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/button/icon
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(134935734070603550)
,p_template_name=>'Icon'
,p_internal_name=>'ICON'
,p_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"><'
||'/span></button>'
,p_hot_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-h'
||'idden="true"></span></button>'
,p_reference_id=>2347660919680321258
,p_translate_this_template=>'N'
,p_theme_class_id=>5
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/button/text
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(134935871722603552)
,p_template_name=>'Text'
,p_internal_name=>'TEXT'
,p_template=>'<button onclick="#JAVASCRIPT#" class="t-Button #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_hot_template=>'<button onclick="#JAVASCRIPT#" class="t-Button t-Button--hot #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_reference_id=>4070916158035059322
,p_translate_this_template=>'N'
,p_theme_class_id=>1
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/button/text_with_icon
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(134935911270603552)
,p_template_name=>'Text with Icon'
,p_internal_name=>'TEXT_WITH_ICON'
,p_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-label">#LABEL#'
||'</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_hot_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-'
||'label">#LABEL#</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_reference_id=>2081382742158699622
,p_translate_this_template=>'N'
,p_theme_class_id=>4
,p_preset_template_options=>'t-Button--iconRight'
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/region/content_block
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(13959427760421178)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ContentBlock #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ContentBlock-header"><h1 class="t-ContentBlock-title">#TITLE#</h1></div>',
'  <div class="t-ContentBlock-body">#BODY#</div>',
'  <div class="t-ContentBlock-buttons">#PREVIOUS##NEXT#</div>',
'</div>'))
,p_page_plug_template_name=>'Content Block'
,p_internal_name=>'CONTENT_BLOCK'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-ContentBlock--h1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2320668864738842174
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes_no_grid
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(13962195135421181)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#"> ',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Blank with Attributes (No Grid)'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES_NO_GRID'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3369790999010910123
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7817251559820099)
,p_plug_template_id=>wwv_flow_api.id(13962195135421181)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7817757206820099)
,p_plug_template_id=>wwv_flow_api.id(13962195135421181)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/alert
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134905408653603519)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">#BODY#</div>',
'    </div>',
'    <div class="t-Alert-buttons">#PREVIOUS##CLOSE##CREATE##NEXT#</div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Alert'
,p_internal_name=>'ALERT'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2039236646100190748
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7808438864820095)
,p_plug_template_id=>wwv_flow_api.id(134905408653603519)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134906982190603525)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#"> ',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Blank with Attributes'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4499993862448380551
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/carousel_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134906989376603525)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--carousel #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'   <div class="t-Region-carouselRegions">',
'     #SUB_REGIONS#',
'   </div>',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Carousel Container'
,p_internal_name=>'CAROUSEL_CONTAINER'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#plugins/com.oracle.apex.carousel/1.1/com.oracle.apex.carousel#MIN#.js?v=#APEX_VERSION#'))
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-Region--showCarouselControls'
,p_preset_template_options=>'t-Region--hiddenOverflow'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2865840475322558786
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7824141033820103)
,p_plug_template_id=>wwv_flow_api.id(134906989376603525)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7824715783820103)
,p_plug_template_id=>wwv_flow_api.id(134906989376603525)
,p_name=>'Slides'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_dialog
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134910485471603528)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionDialog" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Dialog'
,p_internal_name=>'INLINE_DIALOG'
,p_theme_id=>42
,p_theme_class_id=>24
,p_default_template_options=>'js-modal:js-draggable:js-resizable'
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2671226943886536762
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7859194737820117)
,p_plug_template_id=>wwv_flow_api.id(134910485471603528)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/buttons_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134911385607603528)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ButtonRegion t-Form--floatLeft #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-ButtonRegion-wrap">',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##CLOSE##DELETE#</div></div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--content">',
'      <h2 class="t-ButtonRegion-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      #BODY#',
'      <div class="t-ButtonRegion-buttons">#CHANGE#</div>',
'    </div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Buttons Container'
,p_internal_name=>'BUTTONS_CONTAINER'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>17
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2124982336649579661
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7819331133820099)
,p_plug_template_id=>wwv_flow_api.id(134911385607603528)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7819848859820099)
,p_plug_template_id=>wwv_flow_api.id(134911385607603528)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/collapsible
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134912274378603528)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--hideShow #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems  t-Region-headerItems--controls">',
'    <button class="t-Button t-Button--icon t-Button--hideShow" type="button"></button>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#EDIT#</div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#CLOSE#</div>',
'    <div class="t-Region-buttons-right">#CREATE#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #COPY#',
'     #BODY#',
'     #SUB_REGIONS#',
'     #CHANGE#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
' </div>',
'</div>'))
,p_page_plug_template_name=>'Collapsible'
,p_internal_name=>'COLLAPSIBLE'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>1
,p_preset_template_options=>'is-expanded:t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2662888092628347716
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7840345449820109)
,p_plug_template_id=>wwv_flow_api.id(134912274378603528)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7840895069820109)
,p_plug_template_id=>wwv_flow_api.id(134912274378603528)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/hero
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134914356825603530)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-HeroRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-HeroRegion-wrap">',
'    <div class="t-HeroRegion-col t-HeroRegion-col--left"><span class="t-HeroRegion-icon t-Icon #ICON_CSS_CLASSES#"></span></div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--content">',
'      <h1 class="t-HeroRegion-title">#TITLE#</h1>',
'      #BODY#',
'    </div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--right"><div class="t-HeroRegion-form">#SUB_REGIONS#</div><div class="t-HeroRegion-buttons">#NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Hero'
,p_internal_name=>'HERO'
,p_theme_id=>42
,p_theme_class_id=>22
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672571031438297268
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7855873931820115)
,p_plug_template_id=>wwv_flow_api.id(134914356825603530)
,p_name=>'Region Body'
,p_placeholder=>'#BODY#'
,p_has_grid_support=>false
,p_glv_new_row=>false
);
end;
/
prompt --application/shared_components/user_interface/templates/region/interactive_report
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134914494121603530)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-IRR-region #REGION_CSS_CLASSES#">',
'  <h2 class="u-VisuallyHidden" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Interactive Report'
,p_internal_name=>'INTERACTIVE_REPORT'
,p_theme_id=>42
,p_theme_class_id=>9
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2099079838218790610
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/login
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134914869107603530)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-region t-Form--stretchInputs t-Form--labelsAbove #REGION_CSS_CLASSES#" id="#REGION_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Login-header">',
'    <span class="t-Login-logo #ICON_CSS_CLASSES#"></span>',
'    <h1 class="t-Login-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'  </div>',
'  <div class="t-Login-body">',
'    #BODY#',
'  </div>',
'  <div class="t-Login-buttons">',
'    #NEXT#',
'  </div>',
'  <div class="t-Login-links">',
'    #EDIT##CREATE#',
'  </div>',
'  #SUB_REGIONS#',
'</div>'))
,p_page_plug_template_name=>'Login'
,p_internal_name=>'LOGIN'
,p_theme_id=>42
,p_theme_class_id=>23
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672711194551076376
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7864257716820120)
,p_plug_template_id=>wwv_flow_api.id(134914869107603530)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/standard
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134915058825603530)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'     #SUB_REGIONS#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>',
''))
,p_page_plug_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4070912133526059312
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7865827016820120)
,p_plug_template_id=>wwv_flow_api.id(134915058825603530)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7866400937820120)
,p_plug_template_id=>wwv_flow_api.id(134915058825603530)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/tabs_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134917119777603531)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-TabsRegion #REGION_CSS_CLASSES# apex-tabs-region" #REGION_ATTRIBUTES# id="#REGION_STATIC_ID#">',
'  #BODY#',
'  <div class="t-TabsRegion-items">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Tabs Container'
,p_internal_name=>'TABS_CONTAINER'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>5
,p_preset_template_options=>'t-TabsRegion-mod--simple'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3221725015618492759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7885072865820128)
,p_plug_template_id=>wwv_flow_api.id(134917119777603531)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7885594634820128)
,p_plug_template_id=>wwv_flow_api.id(134917119777603531)
,p_name=>'Tabs'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/title_bar
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134918352376603531)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-BreadcrumbRegion #REGION_CSS_CLASSES#"> ',
'  <div class="t-BreadcrumbRegion-body">',
'    <div class="t-BreadcrumbRegion-breadcrumb">',
'      #BODY#',
'    </div>',
'    <div class="t-BreadcrumbRegion-title">',
'      <h1 class="t-BreadcrumbRegion-titleText">#TITLE#</h1>',
'    </div>',
'  </div>',
'  <div class="t-BreadcrumbRegion-buttons">#PREVIOUS##CLOSE##DELETE##HELP##CHANGE##EDIT##COPY##CREATE##NEXT#</div>',
'</div>'))
,p_page_plug_template_name=>'Title Bar'
,p_internal_name=>'TITLE_BAR'
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BreadcrumbRegion--showBreadcrumb'
,p_preset_template_options=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2530016523834132090
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/region/wizard_container
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(134918853579603533)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Wizard #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Wizard-header">',
'    <h1 class="t-Wizard-title">#TITLE#</h1>',
'    <div class="u-Table t-Wizard-controls">',
'      <div class="u-Table-fit t-Wizard-buttons">#PREVIOUS##CLOSE#</div>',
'      <div class="u-Table-fill t-Wizard-steps">',
'        #BODY#',
'      </div>',
'      <div class="u-Table-fit t-Wizard-buttons">#NEXT#</div>',
'    </div>',
'  </div>',
'  <div class="t-Wizard-body">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Wizard Container'
,p_internal_name=>'WIZARD_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Wizard--hideStepsXSmall'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2117602213152591491
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(7892189844820131)
,p_plug_template_id=>wwv_flow_api.id(134918853579603533)
,p_name=>'Wizard Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>false
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_tabs
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(14011924661421215)
,p_list_template_current=>'<li class="t-NavTabs-item #A03# is-active" id="#A01#"><a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-NavTabs-label">#TEXT_ESC_SC#</span><span class'
||'="t-NavTabs-badge #A05#">#A02#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-NavTabs-item #A03#" id="#A01#"><a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-NavTabs-label">#TEXT_ESC_SC#</span><span class="t-NavTab'
||'s-badge #A05#">#A02#</span></a></li>'
,p_list_template_name=>'Top Navigation Tabs'
,p_internal_name=>'TOP_NAVIGATION_TABS'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-NavTabs--inlineLabels-lg:t-NavTabs--displayLabels-sm'
,p_list_template_before_rows=>'<ul class="t-NavTabs #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_navtabs">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'List Item ID'
,p_a02_label=>'Badge Value'
,p_a03_label=>'List Item Class'
,p_a04_label=>'Link Class'
,p_a05_label=>'Badge Class'
,p_reference_id=>1453011561172885578
);
end;
/
prompt --application/shared_components/user_interface/templates/list/badge_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134926983488603541)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_theme_id=>42
,p_theme_class_id=>3
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--cols t-BadgeList--3cols:t-BadgeList--circular'
,p_list_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Value'
,p_a02_label=>'List item CSS Classes'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'Link Classes'
,p_reference_id=>2062482847268086664
,p_list_template_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'A01: Large Number',
'A02: List Item Classes',
'A03: Link Attributes'))
);
end;
/
prompt --application/shared_components/user_interface/templates/list/cards
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134928734507603542)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item is-active #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3><h4 class="t-Card-subtitle">#A07#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3><h4 class="t-Card-subtitle">#A07#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_list_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Secondary Information'
,p_a03_label=>'Initials'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Attributes'
,p_a06_label=>'Card Color Class'
,p_a07_label=>'Subtitle'
,p_reference_id=>2885322685880632508
);
end;
/
prompt --application/shared_components/user_interface/templates/list/media_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134930810140603544)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item is-active #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item  #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-MediaList--showIcons:t-MediaList--showDesc'
,p_list_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Class'
,p_a06_label=>'Icon Color Class'
,p_reference_id=>2066548068783481421
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_bar
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134931723662603544)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Menu Bar'
,p_internal_name=>'MENU_BAR'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  iconType: ''fa'',',
'  slide: e.hasClass("js-slide"),',
'  menubar: true,',
'  menubarOverflow: true',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-showSubMenuIcons'
,p_list_template_before_rows=>'<div class="t-MenuBar #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_reference_id=>2008709236185638887
);
end;
/
prompt --application/shared_components/user_interface/templates/list/navigation_bar
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134932220581603545)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Navigation Bar'
,p_internal_name=>'NAVIGATION_BAR'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<ul class="t-NavigationBar #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<div class="t-NavigationBar-menu" style="display: none" id="menu_#PARENT_LIST_ITEM_ID#"><ul>'
,p_after_sub_list=>'</ul></div></li>'
,p_sub_list_item_current=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_sub_templ_curr_w_child=>'<li data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_sub_templ_noncurr_w_child=>'<li data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'List  Item CSS Classes'
,p_reference_id=>2846096252961119197
);
end;
/
prompt --application/shared_components/user_interface/templates/list/tabs
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134932355389603545)
,p_list_template_current=>'<li class="t-Tabs-item is-active"><a href="#LINK#" class="t-Tabs-link"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-Tabs-item"><a href="#LINK#" class="t-Tabs-link"><span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_name=>'Tabs'
,p_internal_name=>'TABS'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Tabs--simple'
,p_list_template_before_rows=>'<ul class="t-Tabs #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>3288206686691809997
);
end;
/
prompt --application/shared_components/user_interface/templates/list/wizard_progress
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134933269969603545)
,p_list_template_current=>'<li class="t-WizardSteps-step is-active" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></div></li>'
,p_list_template_noncurrent=>'<li class="t-WizardSteps-step" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"><span class="t-Icon a-Icon icon-check"></span></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"'
||'></span></span></div></li>'
,p_list_template_name=>'Wizard Progress'
,p_internal_name=>'WIZARD_PROGRESS'
,p_javascript_code_onload=>'apex.theme.initWizardProgressBar();'
,p_theme_id=>42
,p_theme_class_id=>17
,p_preset_template_options=>'t-WizardSteps--displayLabels'
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2 class="u-VisuallyHidden">#CURRENT_PROGRESS#</h2>',
'<ul class="t-WizardSteps #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'))
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>2008702338707394488
);
end;
/
prompt --application/shared_components/user_interface/templates/list/links_list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134933762553603547)
,p_list_template_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_list_template_name=>'Links List'
,p_internal_name=>'LINKS_LIST'
,p_theme_id=>42
,p_theme_class_id=>18
,p_list_template_before_rows=>'<ul class="t-LinksList #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<ul class="t-LinksList-list">'
,p_after_sub_list=>'</ul>'
,p_sub_list_item_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_sub_list_item_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_item_templ_curr_w_child=>'<li class="t-LinksList-item is-current is-expanded #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t'
||'-LinksList-badge">#A01#</span></a>#SUB_LISTS#</li>'
,p_item_templ_noncurr_w_child=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'Link Attributes'
,p_a03_label=>'List Item CSS Classes'
,p_reference_id=>4070914341144059318
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_popup
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134934578551603547)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_name=>'Menu Popup'
,p_internal_name=>'MENU_POPUP'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menu", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({ slide: e.hasClass("js-slide"), iconType: ''fa''});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<div id="#PARENT_STATIC_ID#_menu" class="#COMPONENT_CSS_CLASSES#" style="display:none;"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Data ID'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute'
,p_a05_label=>'Shortcut'
,p_reference_id=>3492264004432431646
);
end;
/
prompt --application/shared_components/user_interface/templates/list/side_navigation_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134934648048603547)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Side Navigation Menu'
,p_internal_name=>'SIDE_NAVIGATION_MENU'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.treeView#MIN#.js?v=#APEX_VERSION#'
,p_javascript_code_onload=>'apex.jQuery(''body'').addClass(''t-PageBody--leftNav'');'
,p_theme_id=>42
,p_theme_class_id=>19
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-nav" id="t_Body_nav" role="navigation" aria-label="&APP_TITLE!ATTR.">',
'<div class="t-TreeNav #COMPONENT_CSS_CLASSES#" id="t_TreeNav" data-id="#PARENT_STATIC_ID#_tree" aria-label="&APP_TITLE!ATTR."><ul style="display:none">'))
,p_list_template_after_rows=>'</ul></div></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled True/False'
,p_a04_label=>'Title'
,p_reference_id=>2466292414354694776
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_menu
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(134934769377603547)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Top Navigation Menu'
,p_internal_name=>'TOP_NAVIGATION_MENU'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  if ( apex.actions ) {',
'    apex.actions.addFromMarkup( e );',
'  } else {',
'    apex.debug.warn("Include actions.js to support menu shortcuts");',
'  }',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  slide: e.hasClass("js-slide"),',
'  menubar: true,',
'  menubarOverflow: true',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-tabLike'
,p_list_template_before_rows=>'<div class="t-Header-nav-list #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled True / False'
,p_a03_label=>'Hide'
,p_a04_label=>'Title Attribute'
,p_a05_label=>'Shortcut Key'
,p_reference_id=>2525307901300239072
);
end;
/
prompt --application/shared_components/user_interface/templates/report/timeline
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14057815221421246)
,p_row_template_name=>'Timeline'
,p_internal_name=>'TIMELINE'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <div class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':EVENT_LINK is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <a href="#EVENT_LINK#" class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </a>',
'</li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-Timeline #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_timeline" data-region-id="#REGION_STATIC_ID#">',
''))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_reference_id=>1513373588340069864
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/media_list
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(14058668020421248)
,p_row_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item #LIST_CLASS#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap #LINK_CLASS#" #LINK_ATTR#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#"><span class="t-Icon #ICON_CLASS#"></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#LIST_TITLE#</h3>',
'            <p class="t-MediaList-desc">#LIST_TEXT#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#LIST_BADGE#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_default_template_options=>'t-MediaList--showDesc:t-MediaList--showIcons'
,p_preset_template_options=>'t-MediaList--stack'
,p_reference_id=>2092157460408299055
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/alerts
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(134919409732603534)
,p_row_template_name=>'Alerts'
,p_internal_name=>'ALERTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title">#ALERT_TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">',
'        #ALERT_DESC#',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      #ALERT_ACTION#',
'    </div>',
'  </div>',
'</div>'))
,p_row_template_before_rows=>'<div class="t-Alerts #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_alerts" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</div>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>14
,p_reference_id=>2881456138952347027
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/badge_list
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(134919518286603534)
,p_row_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item">',
' <span class="t-BadgeList-wrap u-color">',
'  <span class="t-BadgeList-label">#COLUMN_HEADER#</span>',
'  <span class="t-BadgeList-value">#COLUMN_VALUE#</span>',
' </span>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed:t-BadgeList--circular'
,p_reference_id=>2103197159775914759
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/cards
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(134921189997603536)
,p_row_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <a href="#CARD_LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':CARD_LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <div class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_cards" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_reference_id=>2973535649510699732
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/comments
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(134923350001603538)
,p_row_template_name=>'Comments'
,p_internal_name=>'COMMENTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Comments-item #COMMENT_MODIFIERS#">',
'    <div class="t-Comments-icon">',
'        <div class="t-Comments-userIcon #ICON_MODIFIER#" aria-hidden="true">#USER_ICON#</div>',
'    </div>',
'    <div class="t-Comments-body">',
'        <div class="t-Comments-info">',
'            #USER_NAME# <span class="t-Comments-date">#COMMENT_DATE#</span> <span class="t-Comments-actions">#ACTIONS#</span>',
'        </div>',
'        <div class="t-Comments-comment">',
'            #COMMENT_TEXT##ATTRIBUTE_1##ATTRIBUTE_2##ATTRIBUTE_3##ATTRIBUTE_4#',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Comments #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>',
''))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Comments--chat'
,p_reference_id=>2611722012730764232
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/search_results
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(134923709377603538)
,p_row_template_name=>'Search Results'
,p_internal_name=>'SEARCH_RESULTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition1=>':LABEL_02 is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition2=>':LABEL_03 is null'
,p_row_template3=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition3=>':LABEL_04 is null'
,p_row_template4=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'      <span class="t-SearchResults-misc">#LABEL_04#: #VALUE_04#</span>',
'    </div>',
'  </li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-SearchResults #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">',
'<ul class="t-SearchResults-list">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>',
'</div>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'NOT_CONDITIONAL'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070913431524059316
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/standard
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(134923861639603538)
,p_row_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_row_template1=>'<td class="t-Report-cell" #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>'
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Report #COMPONENT_CSS_CLASSES#" id="report_#REGION_STATIC_ID#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">',
'  <div class="t-Report-wrap">',
'    <table class="t-Report-pagination" role="presentation">#TOP_PAGINATION#</table>',
'    <div class="t-Report-tableWrap">',
'    <table class="t-Report-report" summary="#REGION_TITLE#">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'      </tbody>',
'    </table>',
'    </div>',
'    <div class="t-Report-links">#EXTERNAL_LINK##CSV_LINK#</div>',
'    <table class="t-Report-pagination t-Report-pagination--bottom" role="presentation">#PAGINATION#</table>',
'  </div>',
'</div>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_before_column_heading=>'<thead>'
,p_column_heading_template=>'<th class="t-Report-colHead" #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>'
,p_after_column_heading=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</thead>',
'<tbody>'))
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Report--altRowsDefault:t-Report--rowHighlight'
,p_reference_id=>2537207537838287671
,p_translate_this_template=>'N'
);
begin
wwv_flow_api.create_row_template_patch(
 p_id=>wwv_flow_api.id(134923861639603538)
,p_row_template_before_first=>'<tr>'
,p_row_template_after_last=>'</tr>'
);
exception when others then null;
end;
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_column
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(134925168029603539)
,p_row_template_name=>'Value Attribute Pairs - Column'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_COLUMN'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #COLUMN_HEADER#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #COLUMN_VALUE#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068636272681754
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_row
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(134926129849603539)
,p_row_template_name=>'Value Attribute Pairs - Row'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #1#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #2#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068321678681753
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional_floating
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(14064450231421253)
,p_template_name=>'Optional - Floating'
,p_internal_name=>'OPTIONAL_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>1607675164727151865
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_floating
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(14064683248421254)
,p_template_name=>'Required - Floating'
,p_internal_name=>'REQUIRED_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>1607675344320152883
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/hidden
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(134935267973603549)
,p_template_name=>'Hidden'
,p_internal_name=>'HIDDEN'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer t-Form-labelContainer--hiddenLabel col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label u-VisuallyHidden">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--hiddenLabel rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>13
,p_reference_id=>2039339104148359505
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(134935294002603549)
,p_template_name=>'Optional'
,p_internal_name=>'OPTIONAL'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>',
''))
,p_before_item=>'<div class="t-Form-fieldContainer rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>2317154212072806530
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional_above
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(134935482425603550)
,p_template_name=>'Optional - Above'
,p_internal_name=>'OPTIONAL_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>#HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>3030114864004968404
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(134935572924603550)
,p_template_name=>'Required'
,p_internal_name=>'REQUIRED'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer is-required rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>2525313812251712801
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_above
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(134935607974603550)
,p_template_name=>'Required - Above'
,p_internal_name=>'REQUIRED_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label> #HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>3030115129444970113
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/breadcrumb/breadcrumb
begin
wwv_flow_api.create_menu_template(
 p_id=>wwv_flow_api.id(134936284759603553)
,p_name=>'Breadcrumb'
,p_internal_name=>'BREADCRUMB'
,p_before_first=>'<ul class="t-Breadcrumb #COMPONENT_CSS_CLASSES#">'
,p_current_page_option=>'<li class="t-Breadcrumb-item is-active"><h1 class="t-Breadcrumb-label">#NAME#</h1></li>'
,p_non_current_page_option=>'<li class="t-Breadcrumb-item"><a href="#LINK#" class="t-Breadcrumb-label">#NAME#</a></li>'
,p_after_last=>'</ul>'
,p_max_levels=>6
,p_start_with_node=>'PARENT_TO_LEAF'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916542570059325
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/popuplov
begin
wwv_flow_api.create_popup_lov_template(
 p_id=>wwv_flow_api.id(134936555433603556)
,p_page_name=>'winlov'
,p_page_title=>'Search Dialog'
,p_page_html_head=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html lang="&BROWSER_LANGUAGE.">',
'<head>',
'<title>#TITLE#</title>',
'#APEX_CSS#',
'#THEME_CSS#',
'#THEME_STYLE_CSS#',
'#FAVICONS#',
'#APEX_JAVASCRIPT#',
'#THEME_JAVASCRIPT#',
'<meta name="viewport" content="width=device-width,initial-scale=1.0" />',
'</head>'))
,p_page_body_attr=>'onload="first_field()" class="t-Page t-Page--popupLOV"'
,p_before_field_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_filter_width=>'20'
,p_filter_max_width=>'100'
,p_filter_text_attr=>'class="apex-item-text"'
,p_find_button_text=>'Search'
,p_find_button_attr=>'class="t-Button t-Button--hot t-Button--padLeft"'
,p_close_button_text=>'Close'
,p_close_button_attr=>'class="t-Button u-pullRight"'
,p_next_button_text=>'Next &gt;'
,p_next_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_prev_button_text=>'&lt; Previous'
,p_prev_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_after_field_text=>'</div>'
,p_scrollbars=>'1'
,p_resizable=>'1'
,p_width=>'380'
,p_result_row_x_of_y=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_result_rows_per_pg=>100
,p_before_result_set=>'<div class="t-PopupLOV-links">'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>2885398517835871876
,p_translate_this_template=>'N'
,p_after_result_set=>'</div>'
);
end;
/
prompt --application/shared_components/user_interface/templates/calendar/calendar
begin
wwv_flow_api.create_calendar_template(
 p_id=>wwv_flow_api.id(134936430867603553)
,p_cal_template_name=>'Calendar'
,p_internal_name=>'CALENDAR'
,p_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" summary="#IMONTH# #YYYY#">'
,p_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>',
''))
,p_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_day_close_format=>'</td>'
,p_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_close_format=>'</td>'
,p_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_nonday_close_format=>'</td>'
,p_week_open_format=>'<tr>'
,p_week_close_format=>'</tr> '
,p_daily_title_format=>'<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>'
,p_daily_open_format=>'<tr>'
,p_daily_close_format=>'</tr>'
,p_weekly_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--weekly">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_weekly_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_weekly_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_weekly_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_weekly_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_day_close_format=>'</div></td>'
,p_weekly_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_close_format=>'</div></td>'
,p_weekly_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_weekly_time_close_format=>'</th>'
,p_weekly_time_title_format=>'#TIME#'
,p_weekly_hour_open_format=>'<tr>'
,p_weekly_hour_close_format=>'</tr>'
,p_daily_day_of_week_format=>'<th scope="col" id="#DY#" class="t-ClassicCalendar-dayColumn">#IDAY#</th>'
,p_daily_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--daily">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #DD#, #YYYY#</h1>'))
,p_daily_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL#" class="t-ClassicCalendar-calendar">'
,p_daily_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_daily_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_day_close_format=>'</div></td>'
,p_daily_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol" id="#TIME#">'
,p_daily_time_close_format=>'</th>'
,p_daily_time_title_format=>'#TIME#'
,p_daily_hour_open_format=>'<tr>'
,p_daily_hour_close_format=>'</tr>'
,p_cust_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_cust_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_cust_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" summary="#IMONTH# #YYYY#">'
,p_cust_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_week_open_format=>'<tr>'
,p_cust_week_close_format=>'</tr> '
,p_cust_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_day_close_format=>'</td>'
,p_cust_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">'
,p_cust_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_cust_nonday_close_format=>'</td>'
,p_cust_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">'
,p_cust_weekend_close_format=>'</td>'
,p_cust_hour_open_format=>'<tr>'
,p_cust_hour_close_format=>'</tr>'
,p_cust_time_title_format=>'#TIME#'
,p_cust_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_cust_time_close_format=>'</th>'
,p_cust_wk_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_cust_wk_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_cust_wk_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_cust_wk_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_wk_week_open_format=>'<tr>'
,p_cust_wk_week_close_format=>'</tr> '
,p_cust_wk_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_day_close_format=>'</div></td>'
,p_cust_wk_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_weekend_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_wk_weekend_close_format=>'</td>'
,p_agenda_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--list">',
'  <div class="t-ClassicCalendar-title">#IMONTH# #YYYY#</div>',
'  <ul class="t-ClassicCalendar-list">',
'    #DAYS#',
'  </ul>',
'</div>'))
,p_agenda_past_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-past">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_today_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-today">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_future_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-future">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_past_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-past">#DATA#</li>'
,p_agenda_today_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-today">#DATA#</li>'
,p_agenda_future_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-future">#DATA#</li>'
,p_month_data_format=>'#DAYS#'
,p_month_data_entry_format=>'<span class="t-ClassicCalendar-event">#DATA#</span>'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916747979059326
);
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(134936971127603563)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(134903802920603517)
,p_default_dialog_template=>wwv_flow_api.id(134902141714603516)
,p_error_template=>wwv_flow_api.id(134900816039603516)
,p_printer_friendly_template=>wwv_flow_api.id(134903802920603517)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(134900816039603516)
,p_default_button_template=>wwv_flow_api.id(134935871722603552)
,p_default_region_template=>wwv_flow_api.id(134915058825603530)
,p_default_chart_template=>wwv_flow_api.id(134915058825603530)
,p_default_form_template=>wwv_flow_api.id(134915058825603530)
,p_default_reportr_template=>wwv_flow_api.id(134915058825603530)
,p_default_tabform_template=>wwv_flow_api.id(134915058825603530)
,p_default_wizard_template=>wwv_flow_api.id(134915058825603530)
,p_default_menur_template=>wwv_flow_api.id(134918352376603531)
,p_default_listr_template=>wwv_flow_api.id(134915058825603530)
,p_default_irr_template=>wwv_flow_api.id(134914494121603530)
,p_default_report_template=>wwv_flow_api.id(134923861639603538)
,p_default_label_template=>wwv_flow_api.id(134935294002603549)
,p_default_menu_template=>wwv_flow_api.id(134936284759603553)
,p_default_calendar_template=>wwv_flow_api.id(134936430867603553)
,p_default_list_template=>wwv_flow_api.id(134933762553603547)
,p_default_nav_list_template=>wwv_flow_api.id(134934769377603547)
,p_default_top_nav_list_temp=>wwv_flow_api.id(134934769377603547)
,p_default_side_nav_list_temp=>wwv_flow_api.id(134934648048603547)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(134911385607603528)
,p_default_dialogr_template=>wwv_flow_api.id(134906982190603525)
,p_default_option_label=>wwv_flow_api.id(134935294002603549)
,p_default_required_label=>wwv_flow_api.id(134935572924603550)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(134932220581603545)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.2/')
,p_files_version=>66
,p_icon_library=>'FONTAWESOME'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(4871446654627810)
,p_theme_id=>42
,p_name=>'Test'
,p_is_current=>true
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_config=>'{"customCSS":".apex-icons-fontawesome .fa-2x{font-famlily:inherit;font-size:28px}","vars":{"@g_Nav_Style":"dark"}}'
,p_theme_roller_output_file_url=>'#THEME_DB_IMAGES#4871446654627810.css'
,p_theme_roller_read_only=>false
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(7540971451819989)
,p_theme_id=>42
,p_name=>'Vista'
,p_css_file_urls=>'#THEME_IMAGES#css/Vista#MIN#.css?v=#APEX_VERSION#'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_read_only=>true
,p_reference_id=>4007676303523989775
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(7541371112819989)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(7541783973819989)
,p_theme_id=>42
,p_name=>'Vita - Dark'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Dark.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Dark#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3543348412015319650
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(7542206585819989)
,p_theme_id=>42
,p_name=>'Vita - Red'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Red.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Red#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>1938457712423918173
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(7542541582819989)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Slate.less'
,p_theme_roller_config=>'{"customCSS":"","vars":{"@g_Accent-BG":"#505f6d","@g_Accent-OG":"#ececec","@g_Body-Title-BG":"#dee1e4","@l_Link-Base":"#337ac0","@g_Body-BG":"#f5f5f5"}}'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Slate#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3291983347983194966
);
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A200D0A202A20546573740D0A202A20202020284F7261636C65204170706C69636174696F6E2045787072657373205468656D65205374796C65290D0A202A200D0A202A2054686973204353532066696C65207761732067656E657261746564207573';
wwv_flow_api.g_varchar2_table(2) := '696E6720746865204F7261636C65204170706C69636174696F6E204578707265737320352E30205468656D6520526F6C6C65722E200D0A202A200D0A202A2F0D0A0D0A2E742D4156504C6973742D76616C7565207B0D0A2020636F6C6F723A2023363436';
wwv_flow_api.g_varchar2_table(3) := '3436343B0D0A7D0D0A2E742D426F64792D696E666F202E742D4156504C6973742D76616C7565207B0D0A2020636F6C6F723A20233636363636363B0D0A7D0D0A2E742D526567696F6E202E742D4156504C6973742D76616C7565207B0D0A2020636F6C6F';
wwv_flow_api.g_varchar2_table(4) := '723A20233636363636363B0D0A7D0D0A2E742D4156504C6973742D6C6162656C207B0D0A2020636F6C6F723A20233462346234623B0D0A7D0D0A2E742D426F64792D696E666F202E742D4156504C6973742D6C6162656C207B0D0A2020636F6C6F723A20';
wwv_flow_api.g_varchar2_table(5) := '233464346434643B0D0A7D0D0A2E742D526567696F6E202E742D4156504C6973742D6C6162656C207B0D0A2020636F6C6F723A20233464346434643B0D0A7D0D0A0D0A2E742D416C6572742D2D77697A6172642C0D0A2E742D416C6572742D2D686F7269';
wwv_flow_api.g_varchar2_table(6) := '7A6F6E74616C207B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A2E742D416C6572742D2D636F6C6F7242472E742D416C6572742D2D7761726E696E672C0D0A2E742D416C6572742D2D636F6C6F7242472E742D416C6572742D2D';
wwv_flow_api.g_varchar2_table(7) := '79656C6C6F77207B0D0A20206261636B67726F756E642D636F6C6F723A20236665663765303B0D0A2020636F6C6F723A20233030303030303B0D0A7D0D0A2E742D416C6572742D2D636F6C6F7242472E742D416C6572742D2D73756363657373207B0D0A';
wwv_flow_api.g_varchar2_table(8) := '20206261636B67726F756E642D636F6C6F723A20236635666166343B0D0A2020636F6C6F723A20233030303030303B0D0A7D0D0A2E742D416C6572742D2D636F6C6F7242472E742D416C6572742D2D64616E6765722C0D0A2E742D416C6572742D2D636F';
wwv_flow_api.g_varchar2_table(9) := '6C6F7242472E742D416C6572742D2D726564207B0D0A20206261636B67726F756E642D636F6C6F723A20236666663866373B0D0A2020636F6C6F723A20233030303030303B0D0A7D0D0A2E742D416C6572742D2D636F6C6F7242472E742D416C6572742D';
wwv_flow_api.g_varchar2_table(10) := '2D696E666F207B0D0A20206261636B67726F756E642D636F6C6F723A20236564663666663B0D0A2020636F6C6F723A20233030303030303B0D0A7D0D0A2E742D416C6572742D69636F6E202E742D49636F6E207B0D0A2020636F6C6F723A20234646463B';
wwv_flow_api.g_varchar2_table(11) := '0D0A7D0D0A0D0A2E742D416C6572742D2D7761726E696E67202E742D416C6572742D69636F6E202E742D49636F6E2C0D0A2E742D416C6572742D2D79656C6C6F77202E742D416C6572742D69636F6E202E742D49636F6E207B0D0A20206261636B67726F';
wwv_flow_api.g_varchar2_table(12) := '756E642D636F6C6F723A20236662636534613B0D0A7D0D0A2E742D416C6572742D2D7761726E696E672E742D416C6572742D2D686F72697A6F6E74616C202E742D416C6572742D69636F6E2C0D0A2E742D416C6572742D2D79656C6C6F772E742D416C65';
wwv_flow_api.g_varchar2_table(13) := '72742D2D686F72697A6F6E74616C202E742D416C6572742D69636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235312C203230362C2037342C20302E3135293B0D0A7D0D0A0D0A2E742D416C6572742D2D737563636573';
wwv_flow_api.g_varchar2_table(14) := '73202E742D416C6572742D69636F6E202E742D49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20233362616132633B0D0A7D0D0A2E742D416C6572742D2D737563636573732E742D416C6572742D2D686F72697A6F6E74616C202E74';
wwv_flow_api.g_varchar2_table(15) := '2D416C6572742D69636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20726762612835392C203137302C2034342C20302E3135293B0D0A7D0D0A0D0A2E742D416C6572742D2D696E666F202E742D416C6572742D69636F6E202E742D4963';
wwv_flow_api.g_varchar2_table(16) := '6F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A7D0D0A2E742D416C6572742D2D696E666F2E742D416C6572742D2D686F72697A6F6E74616C202E742D416C6572742D69636F6E207B0D0A20206261636B67726F';
wwv_flow_api.g_varchar2_table(17) := '756E642D636F6C6F723A207267626128352C203131342C203230362C20302E3135293B0D0A7D0D0A0D0A2E742D416C6572742D2D64616E676572202E742D416C6572742D69636F6E202E742D49636F6E2C0D0A2E742D416C6572742D2D726564202E742D';
wwv_flow_api.g_varchar2_table(18) := '416C6572742D69636F6E202E742D49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236634343333363B0D0A7D0D0A2E742D416C6572742D2D64616E6765722E742D416C6572742D2D686F72697A6F6E74616C202E742D416C657274';
wwv_flow_api.g_varchar2_table(19) := '2D69636F6E2C0D0A2E742D416C6572742D2D7265642E742D416C6572742D2D686F72697A6F6E74616C202E742D416C6572742D69636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283234342C2036372C2035342C20302E31';
wwv_flow_api.g_varchar2_table(20) := '35293B0D0A7D0D0A2E742D416C6572742D2D77697A617264202E742D416C6572742D696E736574207B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A2E742D416C6572742D2D686F72697A6F6E74616C2C0D0A2E742D416C657274';
wwv_flow_api.g_varchar2_table(21) := '2D2D77697A617264207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D416C6572742D2D706167652E742D416C6572742D2D73756363657373207B0D0A20';
wwv_flow_api.g_varchar2_table(22) := '206261636B67726F756E642D636F6C6F723A20726762612835392C203137302C2034342C20302E39293B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D416C6572742D2D706167652E742D416C6572742D2D73756363657373202E74';
wwv_flow_api.g_varchar2_table(23) := '2D416C6572742D69636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D416C6572742D2D706167652E742D416C6572742D2D7375636365';
wwv_flow_api.g_varchar2_table(24) := '7373202E742D427574746F6E2D2D636C6F7365416C657274207B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E742D416C6572742D2D706167652E742D416C6572742D2D73756363657373202E742D416C6572';
wwv_flow_api.g_varchar2_table(25) := '742D636F6E74656E74207B0D0A202070616464696E672D72696768743A20303B0D0A202070616464696E672D6C6566743A20303B0D0A7D0D0A0D0A2E742D42616467654C6973742C0D0A2E742D42616467654C6973743A6E6F74282E752D636F6C6F7273';
wwv_flow_api.g_varchar2_table(26) := '292061202E742D42616467654C6973742D6C6162656C207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D42616467654C6973742D2D63697263756C6172202E742D42616467654C6973742D76616C7565207B0D0A2020626F782D73';
wwv_flow_api.g_varchar2_table(27) := '6861646F773A2030203020302031707820726762612836342C2036342C2036342C20302E312920696E7365743B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D42616467654C6973742D2D63697263756C';
wwv_flow_api.g_varchar2_table(28) := '617220612E742D42616467654C6973742D777261703A686F766572202E742D42616467654C6973742D76616C7565207B0D0A2020626F782D736861646F773A20302030203020347078202330353732636520696E7365743B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(29) := '6E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D42616467654C6973742D2D6461736820612E742D42616467654C6973742D777261703A666F6375732C0D0A2E742D42616467654C697374';
wwv_flow_api.g_varchar2_table(30) := '2D2D64617368202E742D42616467654C6973742D777261703A666F6375732D77697468696E2C0D0A2E742D42616467654C6973742D2D63697263756C617220612E742D42616467654C6973742D777261703A666F637573202E742D42616467654C697374';
wwv_flow_api.g_varchar2_table(31) := '2D76616C75652C0D0A2E742D42616467654C6973742D2D63697263756C6172202E742D42616467654C6973742D76616C756520613A666F637573207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365742C';
wwv_flow_api.g_varchar2_table(32) := '20302030203020327078202366666666666620696E7365743B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D42616467654C6973742D2D64617368202E74';
wwv_flow_api.g_varchar2_table(33) := '2D42616467654C6973742D777261703A666F6375732D77697468696E2C0D0A2E742D42616467654C6973742D2D63697263756C6172202E742D42616467654C6973742D76616C756520613A686F766572207B0D0A20206261636B67726F756E642D636F6C';
wwv_flow_api.g_varchar2_table(34) := '6F723A20233035373263652021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E742D42616467654C6973742D2D64617368202E742D42616467654C6973742D76616C756520613A666F';
wwv_flow_api.g_varchar2_table(35) := '6375732C0D0A2E742D42616467654C6973742D2D6461736820612E742D42616467654C6973742D777261703A666F6375732D77697468696E202E742D42616467654C6973742D6C6162656C207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D';
wwv_flow_api.g_varchar2_table(36) := '0A0D0A2E742D42616467654C6973742E752D636F6C6F72732E742D42616467654C6973742D2D63697263756C6172202E742D42616467654C6973742D777261703A6265666F7265207B0D0A20206261636B67726F756E642D636F6C6F723A202366666666';
wwv_flow_api.g_varchar2_table(37) := '66663B0D0A7D0D0A2E742D42616467654C6973742E752D636F6C6F72732E742D42616467654C6973742D2D63697263756C6172202E742D42616467654C6973742D6C6162656C207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D42';
wwv_flow_api.g_varchar2_table(38) := '616467654C6973742E752D636F6C6F7273202E742D42616467654C6973742D76616C75652061207B0D0A2020636F6C6F723A20696E68657269743B0D0A7D0D0A2E612D4261724368617274202E612D42617243686172742D6974656D3A686F766572207B';
wwv_flow_api.g_varchar2_table(39) := '0D0A20206261636B67726F756E642D636F6C6F723A20236632663266323B0D0A7D0D0A2E742D426F6479202E612D4261724368617274202E612D42617243686172742D6974656D202E612D42617243686172742D76616C7565207B0D0A2020636F6C6F72';
wwv_flow_api.g_varchar2_table(40) := '3A20233765376537653B0D0A7D0D0A2E742D426F64792D7469746C65202E612D4261724368617274202E612D42617243686172742D6974656D202E612D42617243686172742D76616C7565207B0D0A2020636F6C6F723A20233830383038303B0D0A7D0D';
wwv_flow_api.g_varchar2_table(41) := '0A2E742D426F64792D696E666F202E612D4261724368617274202E612D42617243686172742D6974656D202E612D42617243686172742D76616C7565207B0D0A2020636F6C6F723A20233830383038303B0D0A7D0D0A2E742D526567696F6E202E612D42';
wwv_flow_api.g_varchar2_table(42) := '61724368617274202E612D42617243686172742D6974656D202E612D42617243686172742D76616C75652C0D0A2E742D427574746F6E526567696F6E202E612D4261724368617274202E612D42617243686172742D6974656D202E612D42617243686172';
wwv_flow_api.g_varchar2_table(43) := '742D76616C7565207B0D0A2020636F6C6F723A20233830383038303B0D0A7D0D0A2E612D4261724368617274202E612D42617243686172742D6974656D20696D67207B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A2E612D4261';
wwv_flow_api.g_varchar2_table(44) := '724368617274202E612D42617243686172742D626172207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E303235293B0D0A7D0D0A2E612D42617243686172742D2D636C6173736963202E612D42617243';
wwv_flow_api.g_varchar2_table(45) := '686172742D6261722C0D0A2E612D42617243686172742D2D636C6173736963202E612D42617243686172742D66696C6C6564207B0D0A2020626F726465722D7261646975733A203170783B0D0A7D0D0A2E612D42617243686172742D2D636C6173736963';
wwv_flow_api.g_varchar2_table(46) := '202E612D42617243686172742D6974656D3A686F766572202E612D42617243686172742D626172207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3035293B0D0A7D0D0A2E612D42617243686172742D';
wwv_flow_api.g_varchar2_table(47) := '2D6D6F6465726E202E612D42617243686172742D6261722C0D0A2E612D42617243686172742D2D6D6F6465726E202E612D42617243686172742D66696C6C6564207B0D0A2020626F726465722D7261646975733A203170783B0D0A7D0D0A2E612D426172';
wwv_flow_api.g_varchar2_table(48) := '43686172742D2D6D6F6465726E202E612D42617243686172742D6974656D3A686F766572202E612D42617243686172742D626172207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3035293B0D0A7D0D';
wwv_flow_api.g_varchar2_table(49) := '0A2E612D42617243686172742D66696C6C6564207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A7D0D0A0D0A626F6479207B0D0A20206261636B67726F756E643A20236664666466643B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(50) := '3365336533653B0D0A7D0D0A61207B0D0A2020636F6C6F723A20233035366162663B0D0A7D0D0A2E742D426F64792D616374696F6E73207B0D0A20206261636B67726F756E642D636F6C6F723A20236639663966393B0D0A2020626F726465722D6C6566';
wwv_flow_api.g_varchar2_table(51) := '743A2031707820736F6C6964207267626128302C20302C20302C20302E303735293B0D0A7D0D0A2E742D426F64792D7469746C65207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235352C203235352C203235352C20302E3929';
wwv_flow_api.g_varchar2_table(52) := '3B0D0A2020636F6C6F723A20233430343034303B0D0A20202D7765626B69742D6261636B64726F702D66696C7465723A20736174757261746528313830252920626C757228387078293B0D0A7D0D0A2E75692D7769646765742D636F6E74656E74207B0D';
wwv_flow_api.g_varchar2_table(53) := '0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D426F6479202E75692D7769646765742D636F6E74656E74207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D426F64792D7469746C6520';
wwv_flow_api.g_varchar2_table(54) := '2E75692D7769646765742D636F6E74656E74207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D426F64792D696E666F202E75692D7769646765742D636F6E74656E74207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D';
wwv_flow_api.g_varchar2_table(55) := '0A2E742D526567696F6E202E75692D7769646765742D636F6E74656E742C0D0A2E742D427574746F6E526567696F6E202E75692D7769646765742D636F6E74656E74207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D426F64792D';
wwv_flow_api.g_varchar2_table(56) := '73696465207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E617065782D7264732D636F6E7461696E6572207B0D0A20206261636B67726F756E642D636F6C6F';
wwv_flow_api.g_varchar2_table(57) := '723A207472616E73706172656E743B0D0A7D0D0A2E742D426F64792D696E666F202E617065782D7264732D636F6E7461696E6572207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D426F64792D696E66';
wwv_flow_api.g_varchar2_table(58) := '6F202E617065782D7264732D636F6E7461696E65722E69732D737475636B207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235352C203235352C203235352C20302E3935293B0D0A20202D7765626B69742D6261636B64726F70';
wwv_flow_api.g_varchar2_table(59) := '2D66696C7465723A20626C757228347078293B0D0A7D0D0A2E742D426F64792D696E666F207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D426F64792D7469746C652E6A732D68696465427265616463';
wwv_flow_api.g_varchar2_table(60) := '72756D6273207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3935293B0D0A7D0D0A2E742D426F64792D746F70427574746F6E207B0D0A2020626F726465722D7261646975733A20313030253B0D0A20';
wwv_flow_api.g_varchar2_table(61) := '206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20236536653665363B0D0A7D0D0A2E742D426F64792D746F70427574746F6E3A666F637573207B0D0A2020626F782D736861646F773A203020302030203170';
wwv_flow_api.g_varchar2_table(62) := '78202330353732636520696E7365742C20302031707820327078207267626128302C20302C20302C20302E3135293B0D0A7D0D0A2E742D426F64792D746F70427574746F6E3A686F7665722C0D0A2E742D426F64792D746F70427574746F6E3A666F6375';
wwv_flow_api.g_varchar2_table(63) := '73207B0D0A2020636F6C6F723A20233035373263653B0D0A7D0D0A2E742D426F64792D746F70427574746F6E3A616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20236536653665';
wwv_flow_api.g_varchar2_table(64) := '363B0D0A7D0D0A0D0A2E742D4865616465722D6272616E64696E67207B0D0A20206865696768743A20343870783B0D0A7D0D0A2E742D4865616465722D6C6F676F2D6F7261636C65207B0D0A20206C696E652D6865696768743A20343870783B0D0A7D0D';
wwv_flow_api.g_varchar2_table(65) := '0A2E742D4865616465722D6C6F676F2D6F7261636C653A6265666F7265207B0D0A20206865696768743A20343870783B0D0A7D0D0A0D0A2E617065782D736964652D6E6176202E742D426F64792D6E61762C0D0A2E617065782D736964652D6E6176202E';
wwv_flow_api.g_varchar2_table(66) := '742D426F64792D616374696F6E732C0D0A2E617065782D736964652D6E6176202E742D426F64792D7469746C65207B0D0A2020746F703A20343870783B0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A';
wwv_flow_api.g_varchar2_table(67) := '20363431707829207B0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E6176202E742D426F64792D7469746C65207B0D0A202020206C6566743A2032303070783B0D0A20207D0D0A20202E752D52544C202E617065782D73696465';
wwv_flow_api.g_varchar2_table(68) := '2D6E6176202E742D426F64792D7469746C65207B0D0A2020202072696768743A2032303070783B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E6176202E742D426F64792D7469746C65207B0D0A20202020726967';
wwv_flow_api.g_varchar2_table(69) := '68743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E6176202E742D426F64792D7469746C65207B0D0A202020206C6566743A20303B0D0A20207D0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E642028';
wwv_flow_api.g_varchar2_table(70) := '6D696E2D77696474683A20363431707829207B0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E6176202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D6C6566743A2032303070783B0D0A20207D0D0A';
wwv_flow_api.g_varchar2_table(71) := '20202E752D52544C202E617065782D736964652D6E6176202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D72696768743A2032303070783B0D0A20207D0D0A7D0D0A3A6E6F74282E752D52544C29202E617065782D73696465';
wwv_flow_api.g_varchar2_table(72) := '2D6E6176202E742D426F64792D6D61696E207B0D0A20206D617267696E2D6C6566743A20303B0D0A7D0D0A2E752D52544C202E617065782D736964652D6E6176202E742D426F64792D6D61696E207B0D0A20206D617267696E2D72696768743A20303B0D';
wwv_flow_api.g_varchar2_table(73) := '0A7D0D0A0D0A2E617065782D746F702D6E6176202E742D426F64792D616374696F6E73207B0D0A2020746F703A20383870783B0D0A7D0D0A2E617065782D746F702D6E6176202E742D426F64792D7469746C65207B0D0A2020746F703A20383870783B0D';
wwv_flow_api.g_varchar2_table(74) := '0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20363430707829207B0D0A20202E617065782D746F702D6E61762E6A732D6D656E754E6176436F6C6C6170736564202E742D4865616465722D6E6176207B';
wwv_flow_api.g_varchar2_table(75) := '0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C61746559282D31303025293B0D0A202020202D6D732D7472616E73666F726D3A207472616E736C61746559282D31303025293B0D0A202020207472616E73666F726D3A2074';
wwv_flow_api.g_varchar2_table(76) := '72616E736C61746559282D31303025293B0D0A20207D0D0A7D0D0A0D0A2E742D426F64792D6E6176207B0D0A202077696474683A2032303070783B0D0A7D0D0A0D0A2E742D426F64792D616374696F6E73207B0D0A202077696474683A2032303070783B';
wwv_flow_api.g_varchar2_table(77) := '0D0A7D0D0A3A6E6F74282E752D52544C29202E742D426F64792D616374696F6E73202E742D427574746F6E2D2D686561646572207B0D0A20202D7765626B69742D7472616E73666F726D3A207472616E736C6174653364282D343070782C20302C203029';
wwv_flow_api.g_varchar2_table(78) := '3B0D0A20202D6D732D7472616E73666F726D3A207472616E736C617465282D34307078293B0D0A20207472616E73666F726D3A207472616E736C6174653364282D343070782C20302C2030293B0D0A7D0D0A2E752D52544C202E742D426F64792D616374';
wwv_flow_api.g_varchar2_table(79) := '696F6E73202E742D427574746F6E2D2D686561646572207B0D0A20202D7765626B69742D7472616E73666F726D3A207472616E736C617465336428343070782C20302C2030293B0D0A20202D6D732D7472616E73666F726D3A207472616E736C61746528';
wwv_flow_api.g_varchar2_table(80) := '34307078293B0D0A20207472616E73666F726D3A207472616E736C617465336428343070782C20302C2030293B0D0A7D0D0A0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A20363431707829207B0D0A20202E';
wwv_flow_api.g_varchar2_table(81) := '742D426F64792D73696465207B0D0A2020202077696474683A2032343070783B0D0A20207D0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A20363431707829207B0D0A20203A6E6F74282E752D52544C';
wwv_flow_api.g_varchar2_table(82) := '29202E617065782D736964652D6E6176202E742D426F64792D73696465207B0D0A202020206C6566743A20343870783B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E6176202E742D426F64792D73696465207B0D0A2020202072';
wwv_flow_api.g_varchar2_table(83) := '696768743A20343870783B0D0A20207D0D0A7D0D0A0D0A3A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D6D61696E207B0D0A20206D617267696E2D6C6566743A20343870';
wwv_flow_api.g_varchar2_table(84) := '783B0D0A7D0D0A2E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D6D61696E207B0D0A20206D617267696E2D72696768743A20343870783B0D0A7D0D0A3A6E6F74282E752D52544C29202E';
wwv_flow_api.g_varchar2_table(85) := '617065782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D6D61696E207B0D0A20202D7765626B69742D7472616E73666F726D3A207472616E736C61746533642831353270782C20302C2030293B0D0A20202D6D732D74';
wwv_flow_api.g_varchar2_table(86) := '72616E73666F726D3A207472616E736C617465283135327078293B0D0A20207472616E73666F726D3A207472616E736C61746533642831353270782C20302C2030293B0D0A7D0D0A2E752D52544C202E617065782D736964652D6E61762E6A732D6E6176';
wwv_flow_api.g_varchar2_table(87) := '457870616E646564202E742D426F64792D6D61696E207B0D0A20202D7765626B69742D7472616E73666F726D3A207472616E736C6174653364282D31353270782C20302C2030293B0D0A20202D6D732D7472616E73666F726D3A207472616E736C617465';
wwv_flow_api.g_varchar2_table(88) := '282D3135327078293B0D0A20207472616E73666F726D3A207472616E736C6174653364282D31353270782C20302C2030293B0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20343830707829207B0D0A';
wwv_flow_api.g_varchar2_table(89) := '20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D7469746C652C0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870';
wwv_flow_api.g_varchar2_table(90) := '616E646564202E742D426F64792D736964652C0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D6C656674';
wwv_flow_api.g_varchar2_table(91) := '3A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D7469746C652C0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E617645787061';
wwv_flow_api.g_varchar2_table(92) := '6E646564202E742D426F64792D736964652C0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D72696768743A20303B0D0A';
wwv_flow_api.g_varchar2_table(93) := '20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D6D61696E207B0D0A202020206D617267696E2D6C6566743A20303B0D0A20207D0D0A20202E752D52544C';
wwv_flow_api.g_varchar2_table(94) := '202E617065782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D6D61696E207B0D0A202020206D617267696E2D72696768743A20303B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D';
wwv_flow_api.g_varchar2_table(95) := '6E61762E6A732D6E6176457870616E646564202E742D426F64792D6D61696E207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A202020202D6D732D7472616E73666F';
wwv_flow_api.g_varchar2_table(96) := '726D3A207472616E736C617465283230307078293B0D0A202020207472616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176';
wwv_flow_api.g_varchar2_table(97) := '457870616E646564202E742D426F64792D6D61696E207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030293B0D0A202020202D6D732D7472616E73666F726D3A207472616E73';
wwv_flow_api.g_varchar2_table(98) := '6C617465282D3230307078293B0D0A202020207472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030293B0D0A20207D0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A';
wwv_flow_api.g_varchar2_table(99) := '20363431707829207B0D0A20202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D686964654C656674202E742D426F64792D7469746C652C0D0A20202E617065782D736964652D6E61762E6A732D';
wwv_flow_api.g_varchar2_table(100) := '6E6176457870616E6465642E742D50616765426F64792D2D686964654C656674202E742D426F64792D636F6E74656E742C0D0A20202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D686964654C';
wwv_flow_api.g_varchar2_table(101) := '656674202E742D426F64792D6D61696E207B0D0A202020207472616E73666F726D3A206E6F6E653B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F';
wwv_flow_api.g_varchar2_table(102) := '64792D2D686964654C656674202E742D426F64792D7469746C65207B0D0A202020206C6566743A2032303070783B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F';
wwv_flow_api.g_varchar2_table(103) := '64792D2D686964654C656674202E742D426F64792D7469746C65207B0D0A2020202072696768743A2032303070783B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E74';
wwv_flow_api.g_varchar2_table(104) := '2D50616765426F64792D2D686964654C656674202E742D426F64792D7469746C65207B0D0A2020202072696768743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D5061';
wwv_flow_api.g_varchar2_table(105) := '6765426F64792D2D686964654C656674202E742D426F64792D7469746C65207B0D0A202020206C6566743A20303B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D';
wwv_flow_api.g_varchar2_table(106) := '50616765426F64792D2D686964654C656674202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D6C6566743A2031353270783B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E61764578';
wwv_flow_api.g_varchar2_table(107) := '70616E6465642E742D50616765426F64792D2D686964654C656674202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D72696768743A2031353270783B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D73';
wwv_flow_api.g_varchar2_table(108) := '6964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D686964654C656674202E742D426F64792D6D61696E207B0D0A202020206D617267696E2D6C6566743A20343870783B0D0A20207D0D0A20202E752D52544C202E61';
wwv_flow_api.g_varchar2_table(109) := '7065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D686964654C656674202E742D426F64792D6D61696E207B0D0A202020206D617267696E2D72696768743A20343870783B0D0A20207D0D0A20202E6170';
wwv_flow_api.g_varchar2_table(110) := '65782D736964652D6E61762E6A732D6E6176457870616E646564202E742D426F64792D73696465207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A202020202D6D73';
wwv_flow_api.g_varchar2_table(111) := '2D7472616E73666F726D3A207472616E736C617465283230307078293B0D0A202020207472616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61';
wwv_flow_api.g_varchar2_table(112) := '762E6A732D6E6176457870616E646564202E742D426F64792D73696465207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030293B0D0A202020202D6D732D7472616E73666F72';
wwv_flow_api.g_varchar2_table(113) := '6D3A207472616E736C617465282D3230307078293B0D0A202020207472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030293B0D0A20207D0D0A20202E617065782D736964652D6E61762E6A732D6E6176457870616E64';
wwv_flow_api.g_varchar2_table(114) := '65642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E207B0D0A202020207472616E73666F726D3A206E6F6E653B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D';
wwv_flow_api.g_varchar2_table(115) := '6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E207B0D0A202020206D617267696E2D6C6566743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A';
wwv_flow_api.g_varchar2_table(116) := '732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E207B0D0A202020206D617267696E2D72696768743A20303B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D73';
wwv_flow_api.g_varchar2_table(117) := '6964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A202020206C6566743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E';
wwv_flow_api.g_varchar2_table(118) := '61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A2020202072696768743A20303B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D73696465';
wwv_flow_api.g_varchar2_table(119) := '2D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D6C6566743A2032383870783B0D0A20207D0D0A20202E752D52544C202E';
wwv_flow_api.g_varchar2_table(120) := '617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D72696768743A2032383870783B0D0A20207D0D0A';
wwv_flow_api.g_varchar2_table(121) := '20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D636F6E74656E74207B0D0A202020202D7765626B69742D747261';
wwv_flow_api.g_varchar2_table(122) := '6E73666F726D3A207472616E736C61746533642831353270782C20302C2030293B0D0A202020202D6D732D7472616E73666F726D3A207472616E736C617465283135327078293B0D0A202020207472616E73666F726D3A207472616E736C617465336428';
wwv_flow_api.g_varchar2_table(123) := '31353270782C20302C2030293B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D636F6E74656E74207B0D0A20';
wwv_flow_api.g_varchar2_table(124) := '2020202D7765626B69742D7472616E73666F726D3A207472616E736C6174653364282D31353270782C20302C2030293B0D0A202020202D6D732D7472616E73666F726D3A207472616E736C617465282D3135327078293B0D0A202020207472616E73666F';
wwv_flow_api.g_varchar2_table(125) := '726D3A207472616E736C6174653364282D31353270782C20302C2030293B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C65';
wwv_flow_api.g_varchar2_table(126) := '6674202E742D426F64792D7469746C65207B0D0A202020206C6566743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E';
wwv_flow_api.g_varchar2_table(127) := '742D426F64792D7469746C65207B0D0A2020202072696768743A20303B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C6566';
wwv_flow_api.g_varchar2_table(128) := '74202E742D426F64792D7469746C65207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A202020202D6D732D7472616E73666F726D3A207472616E736C617465283230';
wwv_flow_api.g_varchar2_table(129) := '307078293B0D0A202020207472616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D5061676542';
wwv_flow_api.g_varchar2_table(130) := '6F64792D2D73686F774C656674202E742D426F64792D7469746C65207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030293B0D0A202020202D6D732D7472616E73666F726D3A';
wwv_flow_api.g_varchar2_table(131) := '207472616E736C617465282D3230307078293B0D0A202020207472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030293B0D0A20207D0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D';
wwv_flow_api.g_varchar2_table(132) := '77696474683A20393933707829207B0D0A20202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E207B0D0A202020207472616E73666F726D3A';
wwv_flow_api.g_varchar2_table(133) := '206E6F6E653B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E207B0D0A202020206D';
wwv_flow_api.g_varchar2_table(134) := '617267696E2D6C6566743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E207B0D0A202020';
wwv_flow_api.g_varchar2_table(135) := '206D617267696E2D72696768743A20303B0D0A20207D0D0A20202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D7469746C65207B0D0A202020207472';
wwv_flow_api.g_varchar2_table(136) := '616E73666F726D3A206E6F6E652021696D706F7274616E743B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E74';
wwv_flow_api.g_varchar2_table(137) := '2D426F64792D7469746C65207B0D0A202020206D617267696E2D6C6566743A2032303070783B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F77';
wwv_flow_api.g_varchar2_table(138) := '4C656674202E742D426F64792D7469746C65207B0D0A202020206D617267696E2D72696768743A2032303070783B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176457870616E6465642E742D';
wwv_flow_api.g_varchar2_table(139) := '50616765426F64792D2D73686F774C656674202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D6C6566743A2034343070783B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E61764578';
wwv_flow_api.g_varchar2_table(140) := '70616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D72696768743A2034343070783B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D73';
wwv_flow_api.g_varchar2_table(141) := '6964652D6E61762E6A732D6E6176457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D636F6E74656E742C0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176457870616E646564';
wwv_flow_api.g_varchar2_table(142) := '2E742D50616765426F64792D2D73686F774C656674202E742D426F64792D636F6E74656E74207B0D0A202020207472616E73666F726D3A206E6F6E653B0D0A20207D0D0A7D0D0A0D0A2E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170';
wwv_flow_api.g_varchar2_table(143) := '736564202E742D426F64792D6E61762C0D0A2E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D6E6176202E742D547265654E6176207B0D0A202077696474683A20343870783B0D0A7D0D0A3A6E6F74282E';
wwv_flow_api.g_varchar2_table(144) := '752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D636F6E74656E742C0D0A3A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C617073656420';
wwv_flow_api.g_varchar2_table(145) := '2E742D426F64792D7469746C652C0D0A3A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D73696465207B0D0A20206D617267696E2D6C6566743A20343870783B0D0A7D0D';
wwv_flow_api.g_varchar2_table(146) := '0A2E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D636F6E74656E742C0D0A2E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F';
wwv_flow_api.g_varchar2_table(147) := '64792D7469746C652C0D0A2E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D73696465207B0D0A20206D617267696E2D72696768743A20343870783B0D0A7D0D0A3A6E6F74282E752D52';
wwv_flow_api.g_varchar2_table(148) := '544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D7469746C652E69732D737475636B207B0D0A20206C6566743A20303B0D0A7D0D0A2E752D52544C202E617065782D736964652D6E61762E6A73';
wwv_flow_api.g_varchar2_table(149) := '2D6E6176436F6C6C6170736564202E742D426F64792D7469746C652E69732D737475636B207B0D0A202072696768743A20303B0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20343830707829207B0D';
wwv_flow_api.g_varchar2_table(150) := '0A20202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D6E6176207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C61746558282D34387078293B0D0A202020202D6D732D';
wwv_flow_api.g_varchar2_table(151) := '7472616E73666F726D3A207472616E736C61746558282D34387078293B0D0A202020207472616E73666F726D3A207472616E736C61746558282D34387078293B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E61';
wwv_flow_api.g_varchar2_table(152) := '76436F6C6C6170736564202E742D426F64792D6E6176207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C617465582834387078293B0D0A202020202D6D732D7472616E73666F726D3A207472616E736C61746558283438';
wwv_flow_api.g_varchar2_table(153) := '7078293B0D0A202020207472616E73666F726D3A207472616E736C617465582834387078293B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D74';
wwv_flow_api.g_varchar2_table(154) := '69746C652C0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D736964652C0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A73';
wwv_flow_api.g_varchar2_table(155) := '2D6E6176436F6C6C6170736564202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D6C6566743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E';
wwv_flow_api.g_varchar2_table(156) := '742D426F64792D7469746C652C0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D736964652C0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176';
wwv_flow_api.g_varchar2_table(157) := '436F6C6C6170736564202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D72696768743A20303B0D0A20207D0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20363430707829';
wwv_flow_api.g_varchar2_table(158) := '207B0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C61707365642E742D50616765426F64792E6A732D7269676874457870616E646564202E742D426F64792D6D61696E207B0D0A202020206D61';
wwv_flow_api.g_varchar2_table(159) := '7267696E2D6C6566743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F6C6C61707365642E742D50616765426F64792E6A732D7269676874457870616E646564202E742D426F64792D6D61696E';
wwv_flow_api.g_varchar2_table(160) := '207B0D0A202020206D617267696E2D72696768743A20303B0D0A20207D0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A20363431707829207B0D0A20203A6E6F74282E752D52544C29202E617065782D';
wwv_flow_api.g_varchar2_table(161) := '736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D7469746C65207B0D0A202020206D617267696E2D6C6566743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F';
wwv_flow_api.g_varchar2_table(162) := '6C6C6170736564202E742D426F64792D7469746C65207B0D0A202020206D617267696E2D72696768743A20303B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E74';
wwv_flow_api.g_varchar2_table(163) := '2D426F64792D7469746C65207B0D0A202020206C6566743A20343870783B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D7469746C65207B0D0A202020207269';
wwv_flow_api.g_varchar2_table(164) := '6768743A20343870783B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C61707365642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A';
wwv_flow_api.g_varchar2_table(165) := '202020206D617267696E2D6C6566743A20303B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F6C6C61707365642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D7369646520';
wwv_flow_api.g_varchar2_table(166) := '7B0D0A202020206D617267696E2D72696768743A20303B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C61707365642E742D50616765426F64792D2D73686F774C656674202E742D';
wwv_flow_api.g_varchar2_table(167) := '426F64792D636F6E74656E74207B0D0A202020206D617267696E2D6C6566743A2032383870783B0D0A20207D0D0A20202E752D52544C202E617065782D736964652D6E61762E6A732D6E6176436F6C6C61707365642E742D50616765426F64792D2D7368';
wwv_flow_api.g_varchar2_table(168) := '6F774C656674202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D72696768743A2032383870783B0D0A20207D0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A203939337078';
wwv_flow_api.g_varchar2_table(169) := '29207B0D0A20203A6E6F74282E752D52544C29202E617065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D73696465207B0D0A202020206C6566743A20343870783B0D0A20207D0D0A20202E752D52544C202E61';
wwv_flow_api.g_varchar2_table(170) := '7065782D736964652D6E61762E6A732D6E6176436F6C6C6170736564202E742D426F64792D73696465207B0D0A2020202072696768743A20343870783B0D0A20207D0D0A7D0D0A0D0A2E742D50616765426F64792E6A732D7269676874457870616E6465';
wwv_flow_api.g_varchar2_table(171) := '64202E742D426F64792D6D61696E207B0D0A20206D617267696E2D72696768743A20303B0D0A7D0D0A3A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E646564202E742D426F64792D6D61696E2C0D0A3A6E';
wwv_flow_api.g_varchar2_table(172) := '6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E646564202E742D426F64792D6E6176207B0D0A20202D7765626B69742D7472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030';
wwv_flow_api.g_varchar2_table(173) := '293B0D0A20202D6D732D7472616E73666F726D3A207472616E736C617465282D3230307078293B0D0A20207472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030293B0D0A7D0D0A2E752D52544C202E742D5061676542';
wwv_flow_api.g_varchar2_table(174) := '6F64792E6A732D7269676874457870616E646564202E742D426F64792D6D61696E2C0D0A2E752D52544C202E742D50616765426F64792E6A732D7269676874457870616E646564202E742D426F64792D6E6176207B0D0A20202D7765626B69742D747261';
wwv_flow_api.g_varchar2_table(175) := '6E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A20202D6D732D7472616E73666F726D3A207472616E736C617465283230307078293B0D0A20207472616E73666F726D3A207472616E736C61746533642832303070';
wwv_flow_api.g_varchar2_table(176) := '782C20302C2030293B0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A20363431707829207B0D0A20202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F6479';
wwv_flow_api.g_varchar2_table(177) := '2D2D686964654C656674202E742D426F64792D6D61696E2C0D0A20202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D686964654C656674202E742D426F64792D6E6176207B0D0A20202020747261';
wwv_flow_api.g_varchar2_table(178) := '6E73666F726D3A206E6F6E653B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D686964654C656674202E742D426F64792D6D61696E207B0D';
wwv_flow_api.g_varchar2_table(179) := '0A202020206D617267696E2D72696768743A2032303070783B0D0A20207D0D0A20202E752D52544C202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D686964654C656674202E742D426F64792D6D';
wwv_flow_api.g_varchar2_table(180) := '61696E207B0D0A202020206D617267696E2D6C6566743A2032303070783B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D686964654C6566';
wwv_flow_api.g_varchar2_table(181) := '74202E742D426F64792D7469746C65207B0D0A2020202072696768743A2032303070783B0D0A20207D0D0A20202E752D52544C202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D686964654C6566';
wwv_flow_api.g_varchar2_table(182) := '74202E742D426F64792D7469746C65207B0D0A202020206C6566743A2032303070783B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D7368';
wwv_flow_api.g_varchar2_table(183) := '6F774C656674202E742D426F64792D7469746C65207B0D0A2020202072696768743A20303B0D0A20207D0D0A20202E752D52544C202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F774C65';
wwv_flow_api.g_varchar2_table(184) := '6674202E742D426F64792D7469746C65207B0D0A202020206C6566743A20303B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E6465642E6A732D6E6176436F6C6C61707365642E74';
wwv_flow_api.g_varchar2_table(185) := '2D50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A202020206D617267696E2D6C6566743A20303B0D0A20207D0D0A20202E752D52544C202E742D50616765426F64792E6A732D7269676874457870616E6465642E';
wwv_flow_api.g_varchar2_table(186) := '6A732D6E6176436F6C6C61707365642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A202020206D617267696E2D72696768743A20303B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E742D5061';
wwv_flow_api.g_varchar2_table(187) := '6765426F64792E6A732D7269676874457870616E6465642E6A732D6E6176436F6C6C61707365642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A202020206C6566743A20303B0D0A20207D0D0A20202E75';
wwv_flow_api.g_varchar2_table(188) := '2D52544C202E742D50616765426F64792E6A732D7269676874457870616E6465642E6A732D6E6176436F6C6C61707365642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A2020202072696768743A20303B';
wwv_flow_api.g_varchar2_table(189) := '0D0A20207D0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A20393933707829207B0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E6465642E74';
wwv_flow_api.g_varchar2_table(190) := '2D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E207B0D0A202020206D617267696E2D72696768743A2032303070783B0D0A20207D0D0A20202E752D52544C202E742D50616765426F64792E6A732D726967687445787061';
wwv_flow_api.g_varchar2_table(191) := '6E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E207B0D0A202020206D617267696E2D6C6566743A2032303070783B0D0A20207D0D0A20202E742D50616765426F64792E6A732D7269676874457870616E64';
wwv_flow_api.g_varchar2_table(192) := '65642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E2C0D0A20202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6E';
wwv_flow_api.g_varchar2_table(193) := '6176207B0D0A202020207472616E73666F726D3A206E6F6E653B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F774C656674202E74';
wwv_flow_api.g_varchar2_table(194) := '2D426F64792D7469746C65207B0D0A2020202072696768743A2032303070783B0D0A20207D0D0A20202E752D52544C202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F774C656674202E74';
wwv_flow_api.g_varchar2_table(195) := '2D426F64792D7469746C65207B0D0A202020206C6566743A2032303070783B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E6465642E6A732D6E6176436F6C6C61707365642E742D';
wwv_flow_api.g_varchar2_table(196) := '50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A202020206C6566743A20343870783B0D0A20207D0D0A20202E752D52544C202E742D50616765426F64792E6A732D7269676874457870616E6465642E6A732D6E61';
wwv_flow_api.g_varchar2_table(197) := '76436F6C6C61707365642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A2020202072696768743A20343870783B0D0A20207D0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D61';
wwv_flow_api.g_varchar2_table(198) := '782D77696474683A20393932707829207B0D0A20202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D6D61696E207B0D0A202020207472616E73666F726D';
wwv_flow_api.g_varchar2_table(199) := '3A206E6F6E653B0D0A20207D0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D7469746C652C0D0A20203A6E6F';
wwv_flow_api.g_varchar2_table(200) := '74282E752D52544C29202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D736964652C0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64';
wwv_flow_api.g_varchar2_table(201) := '792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D636F6E74656E74207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C6174653364282D3230307078';
wwv_flow_api.g_varchar2_table(202) := '2C20302C2030293B0D0A202020202D6D732D7472616E73666F726D3A207472616E736C617465282D3230307078293B0D0A202020207472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030293B0D0A20207D0D0A20202E';
wwv_flow_api.g_varchar2_table(203) := '752D52544C202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D7469746C652C0D0A20202E752D52544C202E742D50616765426F64792E6A732D72696768';
wwv_flow_api.g_varchar2_table(204) := '74457870616E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D736964652C0D0A20202E752D52544C202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F64792D2D73686F77';
wwv_flow_api.g_varchar2_table(205) := '4C656674202E742D426F64792D636F6E74656E74207B0D0A202020202D7765626B69742D7472616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A202020202D6D732D7472616E73666F726D3A207472616E736C61';
wwv_flow_api.g_varchar2_table(206) := '7465283230307078293B0D0A202020207472616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A20207D0D0A20202E742D50616765426F64792E6A732D7269676874457870616E6465642E742D50616765426F6479';
wwv_flow_api.g_varchar2_table(207) := '2D2D73686F774C656674202E742D426F64792D73696465207B0D0A202020206D617267696E2D6C6566743A20343870782021696D706F7274616E743B0D0A20207D0D0A20202E752D52544C202E742D50616765426F64792E6A732D726967687445787061';
wwv_flow_api.g_varchar2_table(208) := '6E6465642E742D50616765426F64792D2D73686F774C656674202E742D426F64792D73696465207B0D0A202020206D617267696E2D6C6566743A203070782021696D706F7274616E743B0D0A2020202072696768743A20343870782021696D706F727461';
wwv_flow_api.g_varchar2_table(209) := '6E743B0D0A20207D0D0A7D0D0A0D0A2E742D50616765426F64792E6A732D7269676874436F6C6C6170736564202E742D426F64792D6D61696E207B0D0A20206D617267696E2D72696768743A203070783B0D0A7D0D0A2E742D50616765426F64792E6A73';
wwv_flow_api.g_varchar2_table(210) := '2D7269676874436F6C6C6170736564202E742D426F64792D7469746C65207B0D0A202072696768743A203070783B0D0A7D0D0A3A6E6F74282E752D52544C29202E742D50616765426F64792E6A732D7269676874436F6C6C6170736564202E742D426F64';
wwv_flow_api.g_varchar2_table(211) := '792D616374696F6E73207B0D0A20202D7765626B69742D7472616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A20202D6D732D7472616E73666F726D3A207472616E736C617465283230307078293B0D0A202074';
wwv_flow_api.g_varchar2_table(212) := '72616E73666F726D3A207472616E736C61746533642832303070782C20302C2030293B0D0A7D0D0A2E752D52544C202E742D50616765426F64792E6A732D7269676874436F6C6C6170736564202E742D426F64792D616374696F6E73207B0D0A20202D77';
wwv_flow_api.g_varchar2_table(213) := '65626B69742D7472616E73666F726D3A207472616E736C6174653364282D32303070782C20302C2030293B0D0A20202D6D732D7472616E73666F726D3A207472616E736C617465282D3230307078293B0D0A20207472616E73666F726D3A207472616E73';
wwv_flow_api.g_varchar2_table(214) := '6C6174653364282D32303070782C20302C2030293B0D0A7D0D0A0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A20363431707829207B0D0A20203A6E6F74282E752D52544C29202E742D50616765426F64792D';
wwv_flow_api.g_varchar2_table(215) := '2D73686F774C656674202E742D426F64792D636F6E74656E74207B0D0A202020206D617267696E2D6C6566743A2032343070783B0D0A20207D0D0A20202E752D52544C202E742D50616765426F64792D2D73686F774C656674202E742D426F64792D636F';
wwv_flow_api.g_varchar2_table(216) := '6E74656E74207B0D0A202020206D617267696E2D72696768743A2032343070783B0D0A20207D0D0A7D0D0A0D0A2E742D426F64792D636F6E74656E74496E6E6572207B0D0A20206D617267696E3A2030206175746F3B0D0A20206D61782D77696474683A';
wwv_flow_api.g_varchar2_table(217) := '20313030253B0D0A7D0D0A0D0A2E742D42726561646372756D622D6974656D3A6166746572207B0D0A2020636F6C6F723A20726762612836322C2036322C2036322C20302E3735293B0D0A7D0D0A2E742D42726561646372756D622D6974656D2C0D0A2E';
wwv_flow_api.g_varchar2_table(218) := '742D42726561646372756D622D6974656D2061207B0D0A2020636F6C6F723A20233537353735373B0D0A7D0D0A2E742D42726561646372756D622D6974656D20613A686F7665722C0D0A2E742D42726561646372756D622D6974656D20613A666F637573';
wwv_flow_api.g_varchar2_table(219) := '207B0D0A2020636F6C6F723A20233035366162663B0D0A2020746578742D6465636F726174696F6E3A20756E6465726C696E653B0D0A20206F75746C696E653A206E6F6E653B0D0A7D0D0A2E742D426F64792D7469746C652D736872696E6B202E742D42';
wwv_flow_api.g_varchar2_table(220) := '726561646372756D62526567696F6E2D2D75736542726561646372756D625469746C65202E742D42726561646372756D622D6974656D2E69732D6163746976652C0D0A2E742D426F64792D7469746C652D736872696E6B202E742D42726561646372756D';
wwv_flow_api.g_varchar2_table(221) := '62526567696F6E2D2D757365526567696F6E5469746C65202E742D42726561646372756D62526567696F6E2D7469746C6554657874207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E';
wwv_flow_api.g_varchar2_table(222) := '6420286D61782D77696474683A20363430707829207B0D0A20202E742D42726561646372756D62526567696F6E2D2D757365526567696F6E5469746C65202E742D42726561646372756D62526567696F6E2D7469746C6554657874207B0D0A2020202063';
wwv_flow_api.g_varchar2_table(223) := '6F6C6F723A20233365336533653B0D0A20207D0D0A7D0D0A2E742D42726561646372756D622D6974656D202E742D49636F6E3A686F766572207B0D0A2020636F6C6F723A20233035373263653B0D0A7D0D0A2E742D42726561646372756D62526567696F';
wwv_flow_api.g_varchar2_table(224) := '6E2D2D75736542726561646372756D625469746C65202E742D42726561646372756D622D6974656D2E69732D6163746976652C0D0A2E742D42726561646372756D62526567696F6E2D7469746C6554657874207B0D0A2020636F6C6F723A202334303430';
wwv_flow_api.g_varchar2_table(225) := '34303B0D0A7D0D0A0D0A2E742D427574746F6E2C0D0A2E612D427574746F6E2C0D0A2E75692D627574746F6E207B0D0A2020626F726465723A206E6F6E653B0D0A2020746578742D736861646F773A206E6F6E653B0D0A2020626F726465722D72616469';
wwv_flow_api.g_varchar2_table(226) := '75733A203270783B0D0A20207472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E327320656173652C20626F782D736861646F7720302E327320656173652C20636F6C6F7220302E327320656173653B0D0A7D0D0A2E742D4275';
wwv_flow_api.g_varchar2_table(227) := '74746F6E202E742D49636F6E2C0D0A2E612D427574746F6E202E742D49636F6E2C0D0A2E75692D627574746F6E202E742D49636F6E207B0D0A20207472616E736974696F6E3A20696E68657269743B0D0A7D0D0A2E742D427574746F6E3A686F7665722C';
wwv_flow_api.g_varchar2_table(228) := '0D0A2E612D427574746F6E3A686F7665722C0D0A2E75692D627574746F6E3A686F7665722C0D0A2E742D427574746F6E3A666F6375732C0D0A2E612D427574746F6E3A666F6375732C0D0A2E75692D627574746F6E3A666F637573207B0D0A20207A2D69';
wwv_flow_api.g_varchar2_table(229) := '6E6465783A203130303B0D0A20206F75746C696E653A206E6F6E652021696D706F7274616E743B0D0A7D0D0A2E742D427574746F6E3A666F6375733A6265666F72652C0D0A2E612D427574746F6E3A666F6375733A6265666F72652C0D0A2E75692D6275';
wwv_flow_api.g_varchar2_table(230) := '74746F6E3A666F6375733A6265666F72652C0D0A2E742D427574746F6E2E69732D6163746976653A666F6375733A6265666F72652C0D0A2E612D427574746F6E2E69732D6163746976653A666F6375733A6265666F72652C0D0A2E75692D627574746F6E';
wwv_flow_api.g_varchar2_table(231) := '2E69732D6163746976653A666F6375733A6265666F7265207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365742021696D706F7274616E743B0D0A20206F7061636974793A20313B0D0A7D0D0A2E742D42';
wwv_flow_api.g_varchar2_table(232) := '7574746F6E3A666F6375733A6163746976653A6265666F72652C0D0A2E612D427574746F6E3A666F6375733A6163746976653A6265666F72652C0D0A2E75692D627574746F6E3A666F6375733A6163746976653A6265666F72652C0D0A2E742D42757474';
wwv_flow_api.g_varchar2_table(233) := '6F6E2E69732D6163746976653A666F6375733A6163746976653A6265666F72652C0D0A2E612D427574746F6E2E69732D6163746976653A666F6375733A6163746976653A6265666F72652C0D0A2E75692D627574746F6E2E69732D6163746976653A666F';
wwv_flow_api.g_varchar2_table(234) := '6375733A6163746976653A6265666F7265207B0D0A20206F7061636974793A20303B0D0A7D0D0A2E742D427574746F6E3A6E6F74282E742D427574746F6E2D2D6C696E6B293A6E6F74282E742D427574746F6E2D2D686561646572293A6163746976652C';
wwv_flow_api.g_varchar2_table(235) := '0D0A2E742D427574746F6E3A6E6F74282E742D427574746F6E2D2D6C696E6B293A6E6F74282E742D427574746F6E2D2D686561646572292E69732D616374697665207B0D0A2020626F782D736861646F773A20302030203020317078207267626128302C';
wwv_flow_api.g_varchar2_table(236) := '20302C20302C20302E31352920696E7365742C20302032707820327078207267626128302C20302C20302C20302E312920696E7365742021696D706F7274616E743B0D0A7D0D0A0D0A2E612D427574746F6E3A6265666F72652C0D0A2E742D427574746F';
wwv_flow_api.g_varchar2_table(237) := '6E3A6265666F72652C0D0A2E75692D627574746F6E3A6265666F72652C0D0A2E612D427574746F6E3A61667465722C0D0A2E742D427574746F6E3A61667465722C0D0A2E75692D627574746F6E3A6166746572207B0D0A2020636F6E74656E743A202727';
wwv_flow_api.g_varchar2_table(238) := '3B0D0A2020706F736974696F6E3A206162736F6C7574653B0D0A2020746F703A20303B0D0A20206C6566743A20303B0D0A202077696474683A20313030253B0D0A20206865696768743A20313030253B0D0A2020626F726465722D7261646975733A2069';
wwv_flow_api.g_varchar2_table(239) := '6E68657269743B0D0A20206F7061636974793A20303B0D0A20207472616E736974696F6E3A202E327320656173653B0D0A7D0D0A2E612D427574746F6E3A6265666F72652C0D0A2E742D427574746F6E3A6265666F72652C0D0A2E75692D627574746F6E';
wwv_flow_api.g_varchar2_table(240) := '3A6265666F7265207B0D0A20207A2D696E6465783A20313B0D0A7D0D0A2E612D427574746F6E3A61667465722C0D0A2E742D427574746F6E3A61667465722C0D0A2E75692D627574746F6E3A6166746572207B0D0A20207A2D696E6465783A202D313B0D';
wwv_flow_api.g_varchar2_table(241) := '0A2020626F782D736861646F773A20302032707820317078207267626128302C20302C20302C20302E303735293B0D0A20207472616E73666F726D3A207472616E736C61746559282D327078293B0D0A7D0D0A2E612D427574746F6E3A666F6375733A61';
wwv_flow_api.g_varchar2_table(242) := '667465722C0D0A2E742D427574746F6E3A666F6375733A61667465722C0D0A2E75692D627574746F6E3A666F6375733A61667465722C0D0A2E612D427574746F6E3A6E6F74282E742D427574746F6E2D2D6C696E6B293A686F7665723A61667465722C0D';
wwv_flow_api.g_varchar2_table(243) := '0A2E742D427574746F6E3A6E6F74282E742D427574746F6E2D2D6C696E6B293A686F7665723A61667465722C0D0A2E75692D627574746F6E3A6E6F74282E742D427574746F6E2D2D6C696E6B293A686F7665723A6166746572207B0D0A20206F70616369';
wwv_flow_api.g_varchar2_table(244) := '74793A20313B0D0A20207472616E73666F726D3A207472616E736C617465592830293B0D0A7D0D0A2E612D427574746F6E3A666F6375733A6163746976653A61667465722C0D0A2E742D427574746F6E3A666F6375733A6163746976653A61667465722C';
wwv_flow_api.g_varchar2_table(245) := '0D0A2E75692D627574746F6E3A666F6375733A6163746976653A6166746572207B0D0A20206F7061636974793A20303B0D0A20207472616E73666F726D3A207472616E736C61746559282D327078293B0D0A7D0D0A2E612D427574746F6E3A666F637573';
wwv_flow_api.g_varchar2_table(246) := '3A61667465722C0D0A2E742D427574746F6E3A666F6375733A61667465722C0D0A2E75692D627574746F6E3A666F6375733A6166746572207B0D0A20207472616E73666F726D3A207472616E736C617465592830293B0D0A2020626F782D736861646F77';
wwv_flow_api.g_varchar2_table(247) := '3A203020302031707820317078207267626128352C203131342C203230362C20302E3235293B0D0A7D0D0A0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726F';
wwv_flow_api.g_varchar2_table(248) := '75702D2D726320696E707574202B206C6162656C2C0D0A2E617065782D627574746F6E2D67726F757020696E707574202B206C6162656C2C0D0A2E742D427574746F6E3A6E6F74282E742D427574746F6E2D2D73696D706C65292C0D0A2E75692D627574';
wwv_flow_api.g_varchar2_table(249) := '746F6E2C0D0A2E612D427574746F6E207B0D0A2020636F6C6F723A20233338333833383B0D0A20206261636B67726F756E642D636F6C6F723A20236638663866383B0D0A2020626F782D736861646F773A20302030203020317078207267626128302C20';
wwv_flow_api.g_varchar2_table(250) := '302C20302C20302E3132352920696E7365743B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726F75702D2D726320696E707574202B206C6162656C3A';
wwv_flow_api.g_varchar2_table(251) := '686F7665722C0D0A2E617065782D627574746F6E2D67726F757020696E707574202B206C6162656C3A686F7665722C0D0A2E742D427574746F6E3A6E6F74282E742D427574746F6E2D2D73696D706C65293A686F7665722C0D0A2E75692D627574746F6E';
wwv_flow_api.g_varchar2_table(252) := '3A686F7665722C0D0A2E612D427574746F6E3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020626F782D736861646F773A20302030203020317078207267626128302C20302C20302C20302E3135';
wwv_flow_api.g_varchar2_table(253) := '2920696E7365743B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726F75702D2D726320696E707574202B206C6162656C3A666F6375732C0D0A2E6170';
wwv_flow_api.g_varchar2_table(254) := '65782D627574746F6E2D67726F757020696E707574202B206C6162656C3A666F6375732C0D0A2E742D427574746F6E3A6E6F74282E742D427574746F6E2D2D73696D706C65293A666F6375732C0D0A2E75692D627574746F6E3A666F6375732C0D0A2E61';
wwv_flow_api.g_varchar2_table(255) := '2D427574746F6E3A666F637573207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D697465';
wwv_flow_api.g_varchar2_table(256) := '6D2D67726F75702D2D726320696E707574202B206C6162656C2E69732D6163746976652C0D0A2E617065782D627574746F6E2D67726F757020696E707574202B206C6162656C2E69732D6163746976652C0D0A2E742D427574746F6E3A6E6F74282E742D';
wwv_flow_api.g_varchar2_table(257) := '427574746F6E2D2D73696D706C65292E69732D6163746976652C0D0A2E75692D627574746F6E2E69732D6163746976652C0D0A2E612D427574746F6E2E69732D6163746976652C0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164';
wwv_flow_api.g_varchar2_table(258) := '696F427574746F6E47726F7570202E617065782D6974656D2D67726F75702D2D726320696E707574202B206C6162656C3A6163746976652C0D0A2E617065782D627574746F6E2D67726F757020696E707574202B206C6162656C3A6163746976652C0D0A';
wwv_flow_api.g_varchar2_table(259) := '2E742D427574746F6E3A6E6F74282E742D427574746F6E2D2D73696D706C65293A6163746976652C0D0A2E75692D627574746F6E3A6163746976652C0D0A2E612D427574746F6E3A616374697665207B0D0A20206261636B67726F756E642D636F6C6F72';
wwv_flow_api.g_varchar2_table(260) := '3A20236465646564653B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726964207B0D0A20206261636B67726F756E642D636F6C6F723A202364386438';
wwv_flow_api.g_varchar2_table(261) := '64383B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726F75702D2D726320696E7075743A61';
wwv_flow_api.g_varchar2_table(262) := '6374697665202B206C6162656C2C0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726F75702D2D726320696E7075743A666F6375733A6E6F74283A636865636B';
wwv_flow_api.g_varchar2_table(263) := '656429202B206C6162656C2C0D0A2E617065782D627574746F6E2D67726F757020696E7075743A616374697665202B206C6162656C2C0D0A2E617065782D627574746F6E2D67726F757020696E7075743A666F6375733A6E6F74283A636865636B656429';
wwv_flow_api.g_varchar2_table(264) := '202B206C6162656C207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365742C20302030203020327078202366396639663920696E7365742021696D706F7274616E743B0D0A20206F75746C696E653A206E';
wwv_flow_api.g_varchar2_table(265) := '6F6E653B0D0A2020626F726465722D636F6C6F723A20233035373263653B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666662021696D706F7274616E743B0D0A2020636F6C6F723A20233338333833382021696D706F7274616E74';
wwv_flow_api.g_varchar2_table(266) := '3B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726F75702D2D726320696E7075743A636865636B65643A666F637573202B206C6162656C2C0D0A2E61';
wwv_flow_api.g_varchar2_table(267) := '7065782D627574746F6E2D67726F757020696E7075743A636865636B65643A666F637573202B206C6162656C207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365742C2030203020302032707820236639';
wwv_flow_api.g_varchar2_table(268) := '6639663920696E7365742021696D706F7274616E743B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726F75702D2D726320696E7075743A636865636B';
wwv_flow_api.g_varchar2_table(269) := '6564202B206C6162656C2C0D0A2E617065782D627574746F6E2D67726F757020696E7075743A636865636B6564202B206C6162656C207B0D0A2020626F726465722D636F6C6F723A20233035373263653B0D0A20206261636B67726F756E642D636F6C6F';
wwv_flow_api.g_varchar2_table(270) := '723A20233035373263653B0D0A2020636F6C6F723A20236639663966393B0D0A2020626F782D736861646F773A206E6F6E653B0D0A7D0D0A0D0A2E612D427574746F6E2D2D686F742C0D0A2E742D427574746F6E2D2D686F743A6E6F74282E742D427574';
wwv_flow_api.g_varchar2_table(271) := '746F6E2D2D73696D706C65292C0D0A626F6479202E75692D627574746F6E2E75692D627574746F6E2D2D686F742C0D0A626F6479202E75692D73746174652D64656661756C742E75692D7072696F726974792D7072696D617279207B0D0A20206261636B';
wwv_flow_api.g_varchar2_table(272) := '67726F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E612D427574746F6E2D2D686F743A686F7665722C0D0A2E742D427574746F6E2D2D686F743A6E6F74282E742D427574746F6E2D2D73';
wwv_flow_api.g_varchar2_table(273) := '696D706C65293A686F7665722C0D0A626F6479202E75692D627574746F6E2E75692D627574746F6E2D2D686F743A686F7665722C0D0A626F6479202E75692D73746174652D64656661756C742E75692D7072696F726974792D7072696D6172793A686F76';
wwv_flow_api.g_varchar2_table(274) := '65722C0D0A2E612D427574746F6E2D2D686F743A6E6F74283A616374697665293A666F6375732C0D0A2E742D427574746F6E2D2D686F743A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74283A616374697665293A666F6375732C0D0A';
wwv_flow_api.g_varchar2_table(275) := '626F6479202E75692D627574746F6E2E75692D627574746F6E2D2D686F743A6E6F74283A616374697665293A666F6375732C0D0A626F6479202E75692D73746174652D64656661756C742E75692D7072696F726974792D7072696D6172793A6E6F74283A';
wwv_flow_api.g_varchar2_table(276) := '616374697665293A666F637573207B0D0A20206261636B67726F756E642D636F6C6F723A20233036383065373B0D0A7D0D0A2E612D427574746F6E2D2D686F743A6163746976652C0D0A2E742D427574746F6E2D2D686F743A6E6F74282E742D42757474';
wwv_flow_api.g_varchar2_table(277) := '6F6E2D2D73696D706C65293A6163746976652C0D0A626F6479202E75692D627574746F6E2E75692D627574746F6E2D2D686F743A6163746976652C0D0A626F6479202E75692D73746174652D64656661756C742E75692D7072696F726974792D7072696D';
wwv_flow_api.g_varchar2_table(278) := '6172793A6163746976652C0D0A2E612D427574746F6E2D2D686F742E69732D6163746976652C0D0A2E742D427574746F6E2D2D686F743A6E6F74282E742D427574746F6E2D2D73696D706C65292E69732D6163746976652C0D0A626F6479202E75692D62';
wwv_flow_api.g_varchar2_table(279) := '7574746F6E2E75692D627574746F6E2D2D686F742E69732D6163746976652C0D0A626F6479202E75692D73746174652D64656661756C742E75692D7072696F726974792D7072696D6172792E69732D616374697665207B0D0A20206261636B67726F756E';
wwv_flow_api.g_varchar2_table(280) := '642D636F6C6F723A20233034363462353B0D0A7D0D0A626F6479202E75692D627574746F6E2E75692D627574746F6E2D2D686F74207B0D0A2020666F6E742D7765696768743A20626F6C643B0D0A7D0D0A0D0A2E742D427574746F6E2D2D7761726E696E';
wwv_flow_api.g_varchar2_table(281) := '673A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F7429207B0D0A2020636F6C6F723A20233434333330323B0D0A7D0D0A2E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D42757474';
wwv_flow_api.g_varchar2_table(282) := '6F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74293A686F7665722C0D0A2E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74';
wwv_flow_api.g_varchar2_table(283) := '293A6E6F74283A616374697665293A666F637573207B0D0A20206261636B67726F756E642D636F6C6F723A20236663646337633B0D0A7D0D0A2E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E';
wwv_flow_api.g_varchar2_table(284) := '6F74282E742D427574746F6E2D2D686F74292C0D0A2E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74293A6163746976652C0D0A2E742D427574746F';
wwv_flow_api.g_varchar2_table(285) := '6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74292E69732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20236662636534613B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(286) := '0D0A2E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F7429207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D427574746F6E2D2D';
wwv_flow_api.g_varchar2_table(287) := '737563636573733A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74293A686F7665722C0D0A2E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D73696D706C6529';
wwv_flow_api.g_varchar2_table(288) := '3A6E6F74282E742D427574746F6E2D2D686F74293A6E6F74283A616374697665293A666F637573207B0D0A20206261636B67726F756E642D636F6C6F723A20233432626533313B0D0A7D0D0A2E742D427574746F6E2D2D737563636573733A6E6F74282E';
wwv_flow_api.g_varchar2_table(289) := '742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74292C0D0A2E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74';
wwv_flow_api.g_varchar2_table(290) := '293A6163746976652C0D0A2E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74292E69732D616374697665207B0D0A20206261636B67726F756E642D63';
wwv_flow_api.g_varchar2_table(291) := '6F6C6F723A20233362616132633B0D0A7D0D0A0D0A2E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F7429207B0D0A2020636F6C6F723A20236666666666';
wwv_flow_api.g_varchar2_table(292) := '663B0D0A7D0D0A2E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74293A686F7665722C0D0A2E742D427574746F6E2D2D64616E6765723A6E6F74282E74';
wwv_flow_api.g_varchar2_table(293) := '2D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74293A6E6F74283A616374697665293A666F637573207B0D0A20206261636B67726F756E642D636F6C6F723A20236635356134653B0D0A7D0D0A2E742D427574746F';
wwv_flow_api.g_varchar2_table(294) := '6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74292C0D0A2E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F7428';
wwv_flow_api.g_varchar2_table(295) := '2E742D427574746F6E2D2D686F74293A6163746976652C0D0A2E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74292E69732D616374697665207B0D0A20';
wwv_flow_api.g_varchar2_table(296) := '206261636B67726F756E642D636F6C6F723A20236634343333363B0D0A7D0D0A0D0A2E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F7429207B0D0A20';
wwv_flow_api.g_varchar2_table(297) := '20636F6C6F723A20233031313232303B0D0A7D0D0A2E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74293A686F7665722C0D0A2E742D427574746F6E';
wwv_flow_api.g_varchar2_table(298) := '2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74293A6E6F74283A616374697665293A666F637573207B0D0A20206261636B67726F756E642D636F6C6F723A202362626466';
wwv_flow_api.g_varchar2_table(299) := '66643B0D0A7D0D0A2E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74292C0D0A2E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D4275';
wwv_flow_api.g_varchar2_table(300) := '74746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D686F74293A6163746976652C0D0A2E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D73696D706C65293A6E6F74282E742D427574746F6E2D2D';
wwv_flow_api.g_varchar2_table(301) := '686F74292E69732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20236132643366643B0D0A7D0D0A0D0A2E742D427574746F6E2D2D73696D706C653A6E6F74282E742D427574746F6E2D2D686F74293A6E6F74282E742D4275';
wwv_flow_api.g_varchar2_table(302) := '74746F6E2D2D64616E676572293A6E6F74282E742D427574746F6E2D2D7072696D617279293A6E6F74282E742D427574746F6E2D2D73756363657373293A6E6F74282E742D427574746F6E2D2D7761726E696E6729207B0D0A20206261636B67726F756E';
wwv_flow_api.g_varchar2_table(303) := '642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233430343034303B0D0A2020626F782D736861646F773A20302030203020317078207267626128302C20302C20302C20302E3132352920696E7365743B0D0A7D0D0A2E742D427574';
wwv_flow_api.g_varchar2_table(304) := '746F6E2D2D73696D706C653A6E6F74282E742D427574746F6E2D2D686F74293A6E6F74282E742D427574746F6E2D2D64616E676572293A6E6F74282E742D427574746F6E2D2D7072696D617279293A6E6F74282E742D427574746F6E2D2D737563636573';
wwv_flow_api.g_varchar2_table(305) := '73293A6E6F74282E742D427574746F6E2D2D7761726E696E67293A686F7665722C0D0A2E742D427574746F6E2D2D73696D706C653A6E6F74282E742D427574746F6E2D2D686F74293A6E6F74282E742D427574746F6E2D2D64616E676572293A6E6F7428';
wwv_flow_api.g_varchar2_table(306) := '2E742D427574746F6E2D2D7072696D617279293A6E6F74282E742D427574746F6E2D2D73756363657373293A6E6F74282E742D427574746F6E2D2D7761726E696E67293A666F6375732C0D0A2E742D427574746F6E2D2D73696D706C653A6E6F74282E74';
wwv_flow_api.g_varchar2_table(307) := '2D427574746F6E2D2D686F74293A6E6F74282E742D427574746F6E2D2D64616E676572293A6E6F74282E742D427574746F6E2D2D7072696D617279293A6E6F74282E742D427574746F6E2D2D73756363657373293A6E6F74282E742D427574746F6E2D2D';
wwv_flow_api.g_varchar2_table(308) := '7761726E696E67292E69732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20236536653665363B0D0A7D0D0A0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D686F74207B0D0A2020626F782D7368';
wwv_flow_api.g_varchar2_table(309) := '61646F773A20302030203020317078202330353732636520696E7365743B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D686F742C0D0A2E';
wwv_flow_api.g_varchar2_table(310) := '742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D686F74202E742D49636F6E207B0D0A2020636F6C6F723A20233035373263653B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D686F743A686F7665';
wwv_flow_api.g_varchar2_table(311) := '722C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D686F743A666F6375732C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D686F742E69732D616374697665207B0D0A20206261636B67726F756E';
wwv_flow_api.g_varchar2_table(312) := '642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D686F743A686F766572202E742D49636F6E2C0D0A2E742D427574746F6E2D2D';
wwv_flow_api.g_varchar2_table(313) := '73696D706C652E742D427574746F6E2D2D686F743A666F637573202E742D49636F6E2C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D686F742E69732D616374697665202E742D49636F6E207B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(314) := '6666666666663B0D0A7D0D0A0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D686F7429207B0D0A2020626F782D736861646F773A2030203020302031707820236132';
wwv_flow_api.g_varchar2_table(315) := '6433666420696E7365743B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D686F74';
wwv_flow_api.g_varchar2_table(316) := '292C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D686F7429202E742D49636F6E207B0D0A2020636F6C6F723A20233236393966613B0D0A7D0D0A2E742D42757474';
wwv_flow_api.g_varchar2_table(317) := '6F6E2D2D73696D706C652E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D686F74293A686F7665722C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D';
wwv_flow_api.g_varchar2_table(318) := '427574746F6E2D2D686F74293A666F6375732C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D686F74292E69732D616374697665207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(319) := '6E642D636F6C6F723A20236132643366643B0D0A2020636F6C6F723A20233031313232303B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D686F74293A686F';
wwv_flow_api.g_varchar2_table(320) := '766572202E742D49636F6E2C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D686F74293A666F637573202E742D49636F6E2C0D0A2E742D427574746F6E2D2D73696D';
wwv_flow_api.g_varchar2_table(321) := '706C652E742D427574746F6E2D2D7072696D6172793A6E6F74282E742D427574746F6E2D2D686F74292E69732D616374697665202E742D49636F6E207B0D0A2020636F6C6F723A20233031313232303B0D0A7D0D0A0D0A2E742D427574746F6E2D2D7369';
wwv_flow_api.g_varchar2_table(322) := '6D706C652E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D686F7429207B0D0A2020626F782D736861646F773A20302030203020317078202366626365346120696E7365743B0D0A20206261636B67726F756E642D63';
wwv_flow_api.g_varchar2_table(323) := '6F6C6F723A20236666666666663B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D686F74292C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574';
wwv_flow_api.g_varchar2_table(324) := '746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D686F7429202E742D49636F6E207B0D0A2020636F6C6F723A20236331393130343B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7761726E696E';
wwv_flow_api.g_varchar2_table(325) := '673A6E6F74282E742D427574746F6E2D2D686F74293A686F7665722C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D686F74293A666F6375732C0D0A2E742D427574';
wwv_flow_api.g_varchar2_table(326) := '746F6E2D2D73696D706C652E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D686F74292E69732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20236662636534613B0D0A2020636F6C6F72';
wwv_flow_api.g_varchar2_table(327) := '3A20233434333330323B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D686F74293A686F766572202E742D49636F6E2C0D0A2E742D427574746F6E2D2D7369';
wwv_flow_api.g_varchar2_table(328) := '6D706C652E742D427574746F6E2D2D7761726E696E673A6E6F74282E742D427574746F6E2D2D686F74293A666F637573202E742D49636F6E2C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7761726E696E673A6E6F74282E';
wwv_flow_api.g_varchar2_table(329) := '742D427574746F6E2D2D686F74292E69732D616374697665202E742D49636F6E207B0D0A2020636F6C6F723A20233434333330323B0D0A7D0D0A0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D64616E6765723A6E6F74282E';
wwv_flow_api.g_varchar2_table(330) := '742D427574746F6E2D2D686F7429207B0D0A2020626F782D736861646F773A20302030203020317078202366343433333620696E7365743B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D427574746F6E';
wwv_flow_api.g_varchar2_table(331) := '2D2D73696D706C652E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D686F74292C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D686F';
wwv_flow_api.g_varchar2_table(332) := '7429202E742D49636F6E207B0D0A2020636F6C6F723A20236634343333363B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D686F74293A686F7665722C0D0A2E';
wwv_flow_api.g_varchar2_table(333) := '742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D686F74293A666F6375732C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D64616E6765723A6E6F74';
wwv_flow_api.g_varchar2_table(334) := '282E742D427574746F6E2D2D686F74292E69732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20236634343333363B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E';
wwv_flow_api.g_varchar2_table(335) := '742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D686F74293A686F766572202E742D49636F6E2C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F';
wwv_flow_api.g_varchar2_table(336) := '6E2D2D686F74293A666F637573202E742D49636F6E2C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D64616E6765723A6E6F74282E742D427574746F6E2D2D686F74292E69732D616374697665202E742D49636F6E207B0D0A';
wwv_flow_api.g_varchar2_table(337) := '2020636F6C6F723A20236666666666663B0D0A7D0D0A0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D686F7429207B0D0A2020626F782D736861646F773A20302030';
wwv_flow_api.g_varchar2_table(338) := '203020317078202333626161326320696E7365743B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D737563636573733A6E6F74282E742D42';
wwv_flow_api.g_varchar2_table(339) := '7574746F6E2D2D686F74292C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D686F7429202E742D49636F6E207B0D0A2020636F6C6F723A20233362616132633B0D0A';
wwv_flow_api.g_varchar2_table(340) := '7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D686F74293A686F7665722C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7375636365';
wwv_flow_api.g_varchar2_table(341) := '73733A6E6F74282E742D427574746F6E2D2D686F74293A666F6375732C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D686F74292E69732D616374697665207B0D0A';
wwv_flow_api.g_varchar2_table(342) := '20206261636B67726F756E642D636F6C6F723A20233362616132633B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F';
wwv_flow_api.g_varchar2_table(343) := '6E2D2D686F74293A686F766572202E742D49636F6E2C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D686F74293A666F637573202E742D49636F6E2C0D0A2E742D42';
wwv_flow_api.g_varchar2_table(344) := '7574746F6E2D2D73696D706C652E742D427574746F6E2D2D737563636573733A6E6F74282E742D427574746F6E2D2D686F74292E69732D616374697665202E742D49636F6E207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A0D0A2E742D';
wwv_flow_api.g_varchar2_table(345) := '427574746F6E2D2D6E6F5549207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E742021696D706F7274616E743B0D0A7D0D0A2E742D427574746F6E2D2D6E6F55493A6E6F74283A686F766572293A6E6F74283A666F63';
wwv_flow_api.g_varchar2_table(346) := '7573293A6E6F74282E69732D61637469766529207B0D0A2020626F782D736861646F773A206E6F6E653B0D0A7D0D0A2E742D427574746F6E2D2D6E6F55493A686F7665722C0D0A2E742D427574746F6E2D2D6E6F55493A666F6375732C0D0A2E742D4275';
wwv_flow_api.g_varchar2_table(347) := '74746F6E2D2D6E6F55492E69732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20236536653665363B0D0A7D0D0A2E742D427574746F6E2D2D6E6F55493A666F6375733A686F766572207B0D0A2020626F782D736861646F77';
wwv_flow_api.g_varchar2_table(348) := '3A20302030203020317078207267626128302C20302C20302C20302E3132352920696E7365743B0D0A7D0D0A0D0A2E742D427574746F6E2D2D6C696E6B207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E742021696D';
wwv_flow_api.g_varchar2_table(349) := '706F7274616E743B0D0A2020626F782D736861646F773A206E6F6E652021696D706F7274616E743B0D0A7D0D0A2E742D427574746F6E2D2D6C696E6B3A686F766572207B0D0A2020746578742D6465636F726174696F6E3A20756E6465726C696E653B0D';
wwv_flow_api.g_varchar2_table(350) := '0A7D0D0A2E742D427574746F6E2D2D6C696E6B2E742D427574746F6E2C0D0A2E742D427574746F6E2D2D6C696E6B202E742D49636F6E207B0D0A2020636F6C6F723A20233035366162663B0D0A7D0D0A0D0A2E742D427574746F6E2D2D6E6F55492E742D';
wwv_flow_api.g_varchar2_table(351) := '427574746F6E2D2D686F742C0D0A2E742D427574746F6E2D2D6E6F55492E742D427574746F6E2D2D686F74202E742D49636F6E207B0D0A2020636F6C6F723A20233035373263653B0D0A7D0D0A0D0A2E742D427574746F6E2D2D6E6F55492E742D427574';
wwv_flow_api.g_varchar2_table(352) := '746F6E2D2D7072696D6172792C0D0A2E742D427574746F6E2D2D6C696E6B2E742D427574746F6E2D2D7072696D6172792C0D0A2E742D427574746F6E2D2D6E6F55492E742D427574746F6E2D2D7072696D617279202E742D49636F6E2C0D0A2E742D4275';
wwv_flow_api.g_varchar2_table(353) := '74746F6E2D2D6C696E6B2E742D427574746F6E2D2D7072696D617279202E742D49636F6E207B0D0A2020636F6C6F723A20233236393966612021696D706F7274616E743B0D0A7D0D0A0D0A2E742D427574746F6E2D2D6E6F55492E742D427574746F6E2D';
wwv_flow_api.g_varchar2_table(354) := '2D7761726E696E672C0D0A2E742D427574746F6E2D2D6C696E6B2E742D427574746F6E2D2D7761726E696E672C0D0A2E742D427574746F6E2D2D6E6F55492E742D427574746F6E2D2D7761726E696E67202E742D49636F6E2C0D0A2E742D427574746F6E';
wwv_flow_api.g_varchar2_table(355) := '2D2D6C696E6B2E742D427574746F6E2D2D7761726E696E67202E742D49636F6E207B0D0A2020636F6C6F723A20236331393130342021696D706F7274616E743B0D0A7D0D0A0D0A2E742D427574746F6E2D2D6E6F55492E742D427574746F6E2D2D64616E';
wwv_flow_api.g_varchar2_table(356) := '6765722C0D0A2E742D427574746F6E2D2D6C696E6B2E742D427574746F6E2D2D64616E6765722C0D0A2E742D427574746F6E2D2D6E6F55492E742D427574746F6E2D2D64616E676572202E742D49636F6E2C0D0A2E742D427574746F6E2D2D6C696E6B2E';
wwv_flow_api.g_varchar2_table(357) := '742D427574746F6E2D2D64616E676572202E742D49636F6E207B0D0A2020636F6C6F723A20236634343333362021696D706F7274616E743B0D0A7D0D0A0D0A2E742D427574746F6E2D2D6E6F55492E742D427574746F6E2D2D737563636573732C0D0A2E';
wwv_flow_api.g_varchar2_table(358) := '742D427574746F6E2D2D6C696E6B2E742D427574746F6E2D2D737563636573732C0D0A2E742D427574746F6E2D2D6E6F55492E742D427574746F6E2D2D73756363657373202E742D49636F6E2C0D0A2E742D427574746F6E2D2D6C696E6B2E742D427574';
wwv_flow_api.g_varchar2_table(359) := '746F6E2D2D73756363657373202E742D49636F6E207B0D0A2020636F6C6F723A20233362616132632021696D706F7274616E743B0D0A7D0D0A0D0A2E742D4865616465722D6272616E64696E67202E742D427574746F6E207B0D0A20206261636B67726F';
wwv_flow_api.g_varchar2_table(360) := '756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D427574746F6E2E742D427574746F6E2D2D686561646572207B0D0A2020626F726465722D7261646975733A203270783B0D0A2020626F782D736861646F773A206E6F6E653B';
wwv_flow_api.g_varchar2_table(361) := '0D0A7D0D0A2E742D427574746F6E2E742D427574746F6E2D2D6865616465723A666F6375733A6265666F72652C0D0A2E742D427574746F6E2E742D427574746F6E2D2D6865616465723A6163746976653A666F6375733A6265666F7265207B0D0A202062';
wwv_flow_api.g_varchar2_table(362) := '6F782D736861646F773A20302030203020317078202332363939666120696E7365742021696D706F7274616E743B0D0A7D0D0A2E742D427574746F6E2E742D427574746F6E2D2D6865616465723A686F7665722C0D0A2E742D427574746F6E2E742D4275';
wwv_flow_api.g_varchar2_table(363) := '74746F6E2D2D6865616465723A666F6375732C0D0A2E742D427574746F6E2E742D427574746F6E2D2D6865616465723A616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D4275';
wwv_flow_api.g_varchar2_table(364) := '74746F6E2E742D427574746F6E2D2D6865616465723A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E31293B0D0A7D0D0A2E742D427574746F6E2E742D427574746F6E2D2D6865616465';
wwv_flow_api.g_varchar2_table(365) := '723A6163746976652C0D0A2E742D427574746F6E2E742D427574746F6E2D2D6865616465723A666F6375733A616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E34293B0D0A7D0D0A2E74';
wwv_flow_api.g_varchar2_table(366) := '2D427574746F6E2E742D427574746F6E2D2D6865616465722E69732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3235293B0D0A2020626F782D736861646F773A206E6F6E653B0D';
wwv_flow_api.g_varchar2_table(367) := '0A7D0D0A2E742D427574746F6E2E742D427574746F6E2D2D68656164657254726565207B0D0A20206D696E2D77696474683A20333270783B0D0A7D0D0A2E742D427574746F6E2E742D427574746F6E2D2D686561646572547265653A666F637573207B0D';
wwv_flow_api.g_varchar2_table(368) := '0A2020626F782D736861646F773A20302030203020317078202332363939666120696E7365743B0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20343830707829207B0D0A20202E742D427574746F6E';
wwv_flow_api.g_varchar2_table(369) := '2E742D427574746F6E2D2D68656164657254726565207B0D0A202020206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3235293B0D0A20207D0D0A7D0D0A2E742D427574746F6E2E742D427574746F6E2D2D686561';
wwv_flow_api.g_varchar2_table(370) := '6465725269676874207B0D0A20206261636B67726F756E642D636F6C6F723A20236639663966393B0D0A2020626F726465723A2031707820736F6C696420236530653065303B0D0A7D0D0A2E742D427574746F6E2E742D427574746F6E2D2D6865616465';
wwv_flow_api.g_varchar2_table(371) := '7252696768743A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236530653065303B0D0A7D0D0A2E742D427574746F6E2E742D427574746F6E2D2D68656164657252696768743A6163746976652C0D0A2E742D427574746F6E2E';
wwv_flow_api.g_varchar2_table(372) := '742D427574746F6E2D2D68656164657252696768742E69732D616374697665207B0D0A2020636F6C6F723A20233361336133613B0D0A7D0D0A2E742D427574746F6E2D2D6E6176426172202E742D427574746F6E2D6261646765207B0D0A2020626F7264';
wwv_flow_api.g_varchar2_table(373) := '65722D7261646975733A203270783B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3335293B0D0A7D0D0A2E742D427574746F6E2D2D68656C70427574746F6E202E612D49636F6E207B0D0A20206F7061';
wwv_flow_api.g_varchar2_table(374) := '636974793A202E353B0D0A7D0D0A0D0A2E742D4865616465722D6E6176426172202E742D427574746F6E2D2D6865616465722E69732D616374697665207B0D0A2020626F726465722D626F74746F6D2D72696768742D7261646975733A20303B0D0A2020';
wwv_flow_api.g_varchar2_table(375) := '626F726465722D626F74746F6D2D6C6566742D7261646975733A20303B0D0A20206261636B67726F756E642D636F6C6F723A20233033343938333B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A0D0A2E742D427574746F6E2E742D427574';
wwv_flow_api.g_varchar2_table(376) := '746F6E2D2D6E6F5549202E66613A61667465722C0D0A2E742D427574746F6E2E742D427574746F6E2D2D6C696E6B202E66613A61667465722C0D0A2E742D427574746F6E2E742D427574746F6E2D2D73696D706C65202E66613A6166746572207B0D0A20';
wwv_flow_api.g_varchar2_table(377) := '206261636B67726F756E642D636F6C6F723A20234646463B0D0A7D0D0A0D0A2E742D427574746F6E2D2D64616E676572202E66613A61667465722C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D64616E6765723A686F7665';
wwv_flow_api.g_varchar2_table(378) := '72202E66613A6166746572207B0D0A20206261636B67726F756E642D636F6C6F723A20236634343333363B0D0A7D0D0A0D0A2E742D427574746F6E2D2D73756363657373202E66613A61667465722C0D0A2E742D427574746F6E2D2D73696D706C652E74';
wwv_flow_api.g_varchar2_table(379) := '2D427574746F6E2D2D737563636573733A686F766572202E66613A6166746572207B0D0A20206261636B67726F756E642D636F6C6F723A20233362616132633B0D0A7D0D0A0D0A2E742D427574746F6E2D2D7072696D617279202E66613A61667465722C';
wwv_flow_api.g_varchar2_table(380) := '0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7072696D6172793A686F766572202E66613A6166746572207B0D0A20206261636B67726F756E642D636F6C6F723A20236132643366643B0D0A7D0D0A0D0A2E742D427574746F';
wwv_flow_api.g_varchar2_table(381) := '6E2D2D7761726E696E67202E66613A61667465722C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D7761726E696E673A686F766572202E66613A6166746572207B0D0A20206261636B67726F756E642D636F6C6F723A202366';
wwv_flow_api.g_varchar2_table(382) := '62636534613B0D0A7D0D0A0D0A2E742D427574746F6E2D2D686F74202E66613A61667465722C0D0A2E742D427574746F6E2D2D73696D706C652E742D427574746F6E2D2D686F743A686F766572202E66613A6166746572207B0D0A20206261636B67726F';
wwv_flow_api.g_varchar2_table(383) := '756E642D636F6C6F723A20233035373263653B0D0A7D0D0A0D0A2E742D427574746F6E526567696F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233430343034303B0D0A2020626F7264';
wwv_flow_api.g_varchar2_table(384) := '65722D7261646975733A203270783B0D0A7D0D0A2E742D427574746F6E526567696F6E2D2D6E6F5549207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D427574746F6E526567696F6E2D2D77';
wwv_flow_api.g_varchar2_table(385) := '697A6172642C0D0A2E742D427574746F6E526567696F6E2D2D6469616C6F67526567696F6E207B0D0A2020626F726465722D7261646975733A2030203020327078203270783B0D0A7D0D0A2E742D427574746F6E526567696F6E2D2D6469616C6F675265';
wwv_flow_api.g_varchar2_table(386) := '67696F6E207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D426F6479202E742D427574746F6E526567696F6E2D2D73686F775469746C65202E742D427574746F6E526567696F6E2D7469746C';
wwv_flow_api.g_varchar2_table(387) := '65207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D426F64792D7469746C65202E742D427574746F6E526567696F6E2D2D73686F775469746C65202E742D427574746F6E526567696F6E2D7469746C65207B0D0A2020636F6C6F72';
wwv_flow_api.g_varchar2_table(388) := '3A20233430343034303B0D0A7D0D0A2E742D426F64792D696E666F202E742D427574746F6E526567696F6E2D2D73686F775469746C65202E742D427574746F6E526567696F6E2D7469746C65207B0D0A2020636F6C6F723A20233430343034303B0D0A7D';
wwv_flow_api.g_varchar2_table(389) := '0D0A2E742D526567696F6E202E742D427574746F6E526567696F6E2D2D73686F775469746C65202E742D427574746F6E526567696F6E2D7469746C652C0D0A2E742D427574746F6E526567696F6E202E742D427574746F6E526567696F6E2D2D73686F77';
wwv_flow_api.g_varchar2_table(390) := '5469746C65202E742D427574746F6E526567696F6E2D7469746C65207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D426F64792D616374696F6E73202E742D427574746F6E526567696F6E207B0D0A20206261636B67726F756E64';
wwv_flow_api.g_varchar2_table(391) := '2D636F6C6F723A207472616E73706172656E743B0D0A2020626F726465722D7261646975733A20303B0D0A7D0D0A0D0A2E66632E75692D776964676574207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E66';
wwv_flow_api.g_varchar2_table(392) := '632D746F6F6C626172207B0D0A2020626F726465722D636F6C6F723A20236562656265623B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020626F726465722D7261646975733A2032707820327078203020303B0D0A';
wwv_flow_api.g_varchar2_table(393) := '7D0D0A2E66632D746F6F6C6261722068322C0D0A2E6663202E66632D62617369632D766965772074642E66632D6461792D6E756D6265722C0D0A2E6663202E66632D6461792D6E756D626572207B0D0A2020636F6C6F723A20233430343034303B0D0A7D';
wwv_flow_api.g_varchar2_table(394) := '0D0A2E66632D6461792D6865616465722E75692D7769646765742D6865616465722C0D0A2E66632D76696577202E75692D7769646765742D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20236632663266323B0D0A2020636F';
wwv_flow_api.g_varchar2_table(395) := '6C6F723A20233236323632363B0D0A2020626F726465722D636F6C6F723A20236536653665363B0D0A7D0D0A6469762E66632D6167656E64614C697374207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020626F72';
wwv_flow_api.g_varchar2_table(396) := '6465722D636F6C6F723A20236562656265623B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E6663202E66632D6167656E64614C6973742D646179486561646572207B0D0A20206261636B67726F756E642D636F6C6F723A202364396439';
wwv_flow_api.g_varchar2_table(397) := '64393B0D0A2020636F6C6F723A20233236323632363B0D0A2020626F726465722D636F6C6F723A20236661666166613B0D0A7D0D0A2E6663202E66632D6167656E64614C6973742D646179207B0D0A2020636F6C6F723A20233236323632363B0D0A7D0D';
wwv_flow_api.g_varchar2_table(398) := '0A2E6663202E66632D6167656E64614C6973742D64617465207B0D0A2020636F6C6F723A20233464346434643B0D0A7D0D0A2E6663202E66632D6167656E64614C697374202E66632D6576656E742D73746172742D74696D652C0D0A2E6663202E66632D';
wwv_flow_api.g_varchar2_table(399) := '6167656E64614C697374202E66632D6576656E742D616C6C2D646179207B0D0A2020636F6C6F723A20233636363636363B0D0A7D0D0A626F6479202E66632074642E66632D746F6461792C0D0A626F6479202E6663202E75692D7769646765742D636F6E';
wwv_flow_api.g_varchar2_table(400) := '74656E74207B0D0A2020626F726465722D636F6C6F723A20236536653665363B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A626F6479202E75692D7769646765742D636F6E74656E742E66632D746F6461792E75692D73746174652D6869';
wwv_flow_api.g_varchar2_table(401) := '67686C69676874207B0D0A20206261636B67726F756E642D636F6C6F723A20236632663266323B0D0A7D0D0A2E6663202E66632D6167656E64614C6973742D6974656D207B0D0A2020626F726465722D636F6C6F723A20236661666166613B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(402) := '2E6663202E75692D627574746F6E3A6163746976652C0D0A2E6663202E75692D627574746F6E3A666F6375732C0D0A2E66632D766965773A6163746976652C0D0A2E66632D766965773A666F637573207B0D0A20206F75746C696E653A2031707820736F';
wwv_flow_api.g_varchar2_table(403) := '6C696420233035373263653B0D0A7D0D0A2E66632D766965772D636F6E7461696E6572203E202E66632D766965773A6163746976652C0D0A2E66632D766965772D636F6E7461696E6572203E202E66632D766965773A666F637573207B0D0A20206F7574';
wwv_flow_api.g_varchar2_table(404) := '6C696E653A206E6F6E653B0D0A7D0D0A0D0A2E742D436172642D77726170207B0D0A2020626F726465722D7261646975733A203270783B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D436172642D7772';
wwv_flow_api.g_varchar2_table(405) := '61703A666F637573207B0D0A2020626F726465722D636F6C6F723A20233035373263653B0D0A7D0D0A2E742D436172642D69636F6E207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D436172642D64657363207B0D0A2020636F6C';
wwv_flow_api.g_varchar2_table(406) := '6F723A20233430343034303B0D0A7D0D0A2E742D436172642D696E666F2C0D0A2E742D436172642D7375627469746C65207B0D0A2020636F6C6F723A20233636363636363B0D0A7D0D0A2E742D436172642D7469746C65207B0D0A2020636F6C6F723A20';
wwv_flow_api.g_varchar2_table(407) := '233430343034303B0D0A7D0D0A2E742D436172642D636F6C6F7246696C6C2C0D0A2E742D436172642D69636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236266626662663B0D0A7D0D0A0D0A2E742D436C617373696343616C656E64';
wwv_flow_api.g_varchar2_table(408) := '61722D6D6F6E74685469746C65207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D436C617373696343616C656E6461722D646179436F6C756D6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236661666166613B0D';
wwv_flow_api.g_varchar2_table(409) := '0A2020766572746963616C2D616C69676E3A20746F703B0D0A2020626F726465722D636F6C6F723A20236632663266323B0D0A2020636F6C6F723A20233636363636363B0D0A7D0D0A2E742D436C617373696343616C656E6461722D646179207B0D0A20';
wwv_flow_api.g_varchar2_table(410) := '20626F726465722D636F6C6F723A20236632663266323B0D0A7D0D0A2E742D436C617373696343616C656E6461722D6461792E69732D696E616374697665202E742D436C617373696343616C656E6461722D64617465207B0D0A20206F7061636974793A';
wwv_flow_api.g_varchar2_table(411) := '202E353B0D0A7D0D0A2E742D436C617373696343616C656E6461722D6461792E69732D7765656B656E642C0D0A2E742D436C617373696343616C656E6461722D6461792E69732D696E616374697665207B0D0A20206261636B67726F756E642D636F6C6F';
wwv_flow_api.g_varchar2_table(412) := '723A20236663666366633B0D0A7D0D0A2E742D436C617373696343616C656E6461722D6461792E69732D746F646179202E742D436C617373696343616C656E6461722D64617465207B0D0A20206261636B67726F756E642D636F6C6F723A202330353732';
wwv_flow_api.g_varchar2_table(413) := '63653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D436C617373696343616C656E6461722D64617465207B0D0A2020636F6C6F723A20233830383038303B0D0A7D0D0A2E742D436C617373696343616C656E6461722D6576656E74';
wwv_flow_api.g_varchar2_table(414) := '207B0D0A20206261636B67726F756E642D636F6C6F723A20236632663266323B0D0A7D0D0A2E742D436C617373696343616C656E6461722D6576656E74207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D436C617373696343616C';
wwv_flow_api.g_varchar2_table(415) := '656E6461722D6576656E742061207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D436C617373696343616C656E6461722D2D7765656B6C79202E742D43';
wwv_flow_api.g_varchar2_table(416) := '6C617373696343616C656E6461722D74696D65436F6C2C0D0A2E742D436C617373696343616C656E6461722D2D6461696C79202E742D436C617373696343616C656E6461722D74696D65436F6C207B0D0A20206261636B67726F756E642D636F6C6F723A';
wwv_flow_api.g_varchar2_table(417) := '20236661666166613B0D0A7D0D0A2E742D436C617373696343616C656E6461722D2D7765656B6C79202E742D436C617373696343616C656E6461722D6461794576656E74732C0D0A2E742D436C617373696343616C656E6461722D2D6461696C79202E74';
wwv_flow_api.g_varchar2_table(418) := '2D436C617373696343616C656E6461722D6461794576656E7473207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D436C617373696343616C656E6461722D2D7765656B6C79202E742D436C617373696343616C656E6461722D6461';
wwv_flow_api.g_varchar2_table(419) := '794576656E747320612C0D0A2E742D436C617373696343616C656E6461722D2D6461696C79202E742D436C617373696343616C656E6461722D6461794576656E74732061207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B';
wwv_flow_api.g_varchar2_table(420) := '0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D436C617373696343616C656E6461722D2D7765656B6C79202E742D436C617373696343616C656E6461722D6461792E69732D746F6461792C0D0A2E742D436C617373696343616C656E';
wwv_flow_api.g_varchar2_table(421) := '6461722D2D6461696C79202E742D436C617373696343616C656E6461722D6461792E69732D746F646179207B0D0A20206261636B67726F756E642D636F6C6F723A20236434656266653B0D0A7D0D0A2E742D436C617373696343616C656E6461722D6C69';
wwv_flow_api.g_varchar2_table(422) := '7374207B0D0A2020626F726465722D636F6C6F723A20236632663266323B0D0A7D0D0A2E742D436C617373696343616C656E6461722D6C6973745469746C652C0D0A2E742D436C617373696343616C656E6461722D6C6973744576656E74207B0D0A2020';
wwv_flow_api.g_varchar2_table(423) := '626F726465722D636F6C6F723A20236632663266323B0D0A7D0D0A2E742D436C617373696343616C656E6461722D6C6973745469746C65207B0D0A20206261636B67726F756E642D636F6C6F723A20236661666166613B0D0A2020636F6C6F723A202336';
wwv_flow_api.g_varchar2_table(424) := '36363636363B0D0A7D0D0A2E742D436C617373696343616C656E6461722D6C6973744576656E74207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D436F6D6D656E74732D2D63686174202E742D436F6D6D656E74732D636F6D6D65';
wwv_flow_api.g_varchar2_table(425) := '6E74207B0D0A20206261636B67726F756E642D636F6C6F723A20236565663466393B0D0A2020636F6C6F723A20233030303030303B0D0A7D0D0A2E742D436F6D6D656E74732D2D63686174202E742D436F6D6D656E74732D636F6D6D656E743A61667465';
wwv_flow_api.g_varchar2_table(426) := '72207B0D0A2020626F726465722D72696768742D636F6C6F723A20236565663466393B0D0A7D0D0A2E742D436F6D6D656E74732D2D63686174202E742D436F6D6D656E74732D6974656D2E69732D616374697665202E742D436F6D6D656E74732D636F6D';
wwv_flow_api.g_varchar2_table(427) := '6D656E74207B0D0A20206261636B67726F756E642D636F6C6F723A20236363646565643B0D0A2020636F6C6F723A20233030303030303B0D0A7D0D0A2E742D436F6D6D656E74732D2D63686174202E742D436F6D6D656E74732D6974656D2E69732D6163';
wwv_flow_api.g_varchar2_table(428) := '74697665202E742D436F6D6D656E74732D636F6D6D656E743A6166746572207B0D0A2020626F726465722D72696768742D636F6C6F723A20236363646565643B0D0A7D0D0A2E742D436F6D6D656E74732D2D6261736963202E742D436F6D6D656E74732D';
wwv_flow_api.g_varchar2_table(429) := '6974656D2E69732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20236662666266623B0D0A7D0D0A2E742D436F6D6D656E74732D6974656D2E69732D73797374656D4D657373616765207B0D0A20206261636B67726F756E64';
wwv_flow_api.g_varchar2_table(430) := '2D636F6C6F723A20236462653766323B0D0A7D0D0A2E742D436F6D6D656E74732D696E666F207B0D0A2020636F6C6F723A20233561356135613B0D0A7D0D0A2E742D436F6D6D656E74732D636F6D6D656E74207B0D0A2020636F6C6F723A202330303030';
wwv_flow_api.g_varchar2_table(431) := '30303B0D0A7D0D0A2E742D436F6E66696750616E656C2D61626F7574207B0D0A20206261636B67726F756E642D636F6C6F723A20236666663765303B0D0A2020636F6C6F723A20233536353635363B0D0A7D0D0A2E742D436F6E66696750616E656C2D69';
wwv_flow_api.g_varchar2_table(432) := '636F6E207B0D0A2020626F726465722D7261646975733A20313030253B0D0A20206261636B67726F756E642D636F6C6F723A20234130413041303B0D0A2020636F6C6F723A20234646463B0D0A7D0D0A2E742D436F6E66696750616E656C2D69636F6E2E';
wwv_flow_api.g_varchar2_table(433) := '69732D656E61626C6564207B0D0A20206261636B67726F756E642D636F6C6F723A20233362616132633B0D0A7D0D0A2E742D436F6E66696750616E656C2D69636F6E2E69732D64697361626C6564207B0D0A20206261636B67726F756E642D636F6C6F72';
wwv_flow_api.g_varchar2_table(434) := '3A20236634343333363B0D0A7D0D0A2E742D436F6E66696750616E656C2D73657474696E672C0D0A2E742D436F6E66696750616E656C2D737461747573207B0D0A2020636F6C6F723A20233733373337333B0D0A7D0D0A2E742D436F6E66696750616E65';
wwv_flow_api.g_varchar2_table(435) := '6C2D737461747573207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D436F6E66696750616E656C2D617474724C696E6B207B0D0A2020636F6C6F723A20233733373337333B0D0A7D0D0A2E742D436F6E66696750616E656C2D6174';
wwv_flow_api.g_varchar2_table(436) := '74724C696E6B3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3035293B0D0A7D0D0A2E742D436F6E66696750616E656C2D6174747256616C7565207B0D0A2020636F6C6F723A202330';
wwv_flow_api.g_varchar2_table(437) := '35366162663B0D0A7D0D0A2E742D4469616C6F67207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A0D0A2E742D4469616C6F67203A3A2D7765626B69742D7363726F6C6C6261722D7468756D62207B0D0A2020';
wwv_flow_api.g_varchar2_table(438) := '6261636B67726F756E642D636F6C6F723A20236266626662663B0D0A7D0D0A2E742D4469616C6F67203A3A2D7765626B69742D7363726F6C6C6261722D7468756D623A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A2023623362';
wwv_flow_api.g_varchar2_table(439) := '3362333B0D0A7D0D0A2E742D4469616C6F673A3A2D7765626B69742D7363726F6C6C6261722D747261636B207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A0D0A2E742D466F6F7465722D746F70427574746F';
wwv_flow_api.g_varchar2_table(440) := '6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233731373137313B0D0A7D0D0A2E742D466F6F7465722D746F70427574746F6E3A666F637573207B0D0A2020626F782D736861646F773A20';
wwv_flow_api.g_varchar2_table(441) := '302030203020317078202330353732636520696E7365743B0D0A7D0D0A2E742D466F726D2D696E707574436F6E7461696E65723A6265666F7265207B0D0A2020636F6C6F723A20233339333933393B0D0A7D0D0A2E617065782D6974656D2D7465787461';
wwv_flow_api.g_varchar2_table(442) := '7265612C0D0A2E617065782D6974656D2D746578742C0D0A2E617065782D6974656D2D73656C656374207B0D0A2020636F6C6F723A20233339333933393B0D0A20206261636B67726F756E642D636F6C6F723A20236639663966393B0D0A2020626F7264';
wwv_flow_api.g_varchar2_table(443) := '65722D636F6C6F723A20236466646664663B0D0A7D0D0A2E617065782D6974656D2D74657874617265612E617065782D706167652D6974656D2D6572726F722C0D0A2E617065782D6974656D2D746578742E617065782D706167652D6974656D2D657272';
wwv_flow_api.g_varchar2_table(444) := '6F722C0D0A2E617065782D6974656D2D73656C6563742E617065782D706167652D6974656D2D6572726F72207B0D0A2020626F726465722D636F6C6F723A20236637373036363B0D0A7D0D0A2E617065782D6974656D2D74657874617265612E61706578';
wwv_flow_api.g_varchar2_table(445) := '2D706167652D6974656D2D6572726F723A72657175697265643A76616C69642C0D0A2E617065782D6974656D2D746578742E617065782D706167652D6974656D2D6572726F723A72657175697265643A76616C69642C0D0A2E617065782D6974656D2D73';
wwv_flow_api.g_varchar2_table(446) := '656C6563742E617065782D706167652D6974656D2D6572726F723A72657175697265643A76616C6964207B0D0A2020626F726465722D636F6C6F723A20236466646664663B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D666C';
wwv_flow_api.g_varchar2_table(447) := '6F6174696E674C6162656C202E742D466F726D2D696E707574436F6E7461696E6572202E617065782D6974656D2D646973706C61792D6F6E6C79207B0D0A2020636F6C6F723A20233339333933393B0D0A20206261636B67726F756E642D636F6C6F723A';
wwv_flow_api.g_varchar2_table(448) := '20236666666666663B0D0A2020626F726465722D636F6C6F723A20236466646664663B0D0A2020626F726465722D7374796C653A206461736865643B0D0A7D0D0A0D0A2E617065782D6974656D2D66696C652D64726F707A6F6E652D6C6162656C207B0D';
wwv_flow_api.g_varchar2_table(449) := '0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20726762612835372C2035372C2035372C20302E37293B0D0A2020626F726465722D7261646975733A2032707820302030203270783B0D0A7D0D0A2E75';
wwv_flow_api.g_varchar2_table(450) := '2D52544C202E617065782D6974656D2D66696C652D64726F707A6F6E652D6C6162656C207B0D0A2020626F726465722D7261646975733A2030203270782032707820303B0D0A7D0D0A2E617065782D6974656D2D66696C652D64726F707A6F6E652D6963';
wwv_flow_api.g_varchar2_table(451) := '6F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236639663966393B0D0A2020626F726465722D7261646975733A2030203270782032707820303B0D0A7D0D0A2E752D52544C202E617065782D6974656D2D66696C652D64726F707A6F6E';
wwv_flow_api.g_varchar2_table(452) := '652D69636F6E207B0D0A2020626F726465722D7261646975733A2032707820302030203270783B0D0A7D0D0A2E617065782D6974656D2D66696C653A686F766572202B202E617065782D6974656D2D66696C652D64726F707A6F6E65202E617065782D69';
wwv_flow_api.g_varchar2_table(453) := '74656D2D66696C652D64726F707A6F6E652D6C6162656C207B0D0A2020636F6C6F723A20233339333933393B0D0A7D0D0A2E617065782D6974656D2D66696C653A686F766572202B202E617065782D6974656D2D66696C652D64726F707A6F6E65202E61';
wwv_flow_api.g_varchar2_table(454) := '7065782D6974656D2D66696C652D64726F707A6F6E652D69636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233339333933393B0D0A7D0D0A2E617065782D6974656D2D66696C653A66';
wwv_flow_api.g_varchar2_table(455) := '6F637573202B202E617065782D6974656D2D66696C652D64726F707A6F6E65202E617065782D6974656D2D66696C652D64726F707A6F6E652D6C6162656C207B0D0A2020626F726465722D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(456) := '20233339333933393B0D0A7D0D0A2E617065782D6974656D2D66696C653A666F637573202B202E617065782D6974656D2D66696C652D64726F707A6F6E65202E617065782D6974656D2D66696C652D64726F707A6F6E652D69636F6E207B0D0A2020626F';
wwv_flow_api.g_varchar2_table(457) := '726465722D636F6C6F723A20233035373263653B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E617065782D6974656D2D74657874617265613A666F6375732C';
wwv_flow_api.g_varchar2_table(458) := '0D0A2E617065782D6974656D2D746578743A666F6375732C0D0A2E617065782D6974656D2D73656C6563743A666F637573207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666662021696D706F7274616E743B0D0A2020626F7264';
wwv_flow_api.g_varchar2_table(459) := '65722D636F6C6F723A20233035373263652021696D706F7274616E743B0D0A7D0D0A2E617065782D6974656D2D74657874617265613A686F7665722C0D0A2E617065782D6974656D2D746578743A686F7665722C0D0A2E617065782D6974656D2D73656C';
wwv_flow_api.g_varchar2_table(460) := '6563743A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D466F726D2D696E707574436F6E7461696E657220696E7075743A3A2D7765626B69742D696E7075742D706C616365686F6C6465';
wwv_flow_api.g_varchar2_table(461) := '72207B0D0A2020636F6C6F723A20233030303030303B0D0A20206F7061636974793A202E343B0D0A7D0D0A2E742D466F726D2D696E707574436F6E7461696E657220696E7075743A3A2D6D6F7A2D706C616365686F6C646572207B0D0A2020636F6C6F72';
wwv_flow_api.g_varchar2_table(462) := '3A20233030303030303B0D0A20206F7061636974793A202E343B0D0A7D0D0A2E742D466F726D2D696E707574436F6E7461696E657220696E7075743A2D6D732D696E7075742D706C616365686F6C646572207B0D0A2020636F6C6F723A20233030303030';
wwv_flow_api.g_varchar2_table(463) := '303B0D0A20206F7061636974793A202E343B0D0A7D0D0A2E742D466F726D20696E7075742E66696C65207B0D0A2020636F6C6F723A20233339333933393B0D0A7D0D0A2E742D466F726D2D696E707574436F6E7461696E6572207370616E2E646973706C';
wwv_flow_api.g_varchar2_table(464) := '61795F6F6E6C79207B0D0A2020626F726465722D636F6C6F723A207472616E73706172656E743B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D466F726D2D73656C6563742C0D0A2E742D466F';
wwv_flow_api.g_varchar2_table(465) := '726D2D696E707574436F6E7461696E65722073656C6563742E73656C6563746C6973742C0D0A2E742D466F726D2D696E707574436F6E7461696E65722073656C6563742E7965735F6E6F207B0D0A2020636F6C6F723A20233339333933393B0D0A202062';
wwv_flow_api.g_varchar2_table(466) := '6F726465722D636F6C6F723A20236466646664663B0D0A7D0D0A2E742D466F726D2D6669656C642D2D726561644F6E6C79207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D466F726D2D7261';
wwv_flow_api.g_varchar2_table(467) := '64696F4C6162656C2C0D0A2E742D466F726D2D696E707574436F6E7461696E6572202E726164696F5F67726F7570206C6162656C2C0D0A2E742D466F726D2D636865636B626F784C6162656C2C0D0A2E742D466F726D2D696E707574436F6E7461696E65';
wwv_flow_api.g_varchar2_table(468) := '72202E636865636B626F785F67726F7570206C6162656C2C0D0A2E742D466F726D2D6C6162656C207B0D0A2020636F6C6F723A20233464346434643B0D0A7D0D0A2E742D466F726D2D6572726F72207B0D0A2020636F6C6F723A20236634343333363B0D';
wwv_flow_api.g_varchar2_table(469) := '0A7D0D0A2E742D466F726D2D706F737454657874207B0D0A2020636F6C6F723A20236363636363633B0D0A7D0D0A2E742D466F726D2D2D73656172636820696E7075742E742D466F726D2D7365617263684669656C64207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(470) := '6E642D636F6C6F723A20236639663966393B0D0A2020636F6C6F723A20233339333933393B0D0A7D0D0A2E612D427574746F6E2E612D427574746F6E2D2D63616C656E6461722C0D0A2E612D427574746F6E2E612D427574746F6E2D2D706F7075704C4F';
wwv_flow_api.g_varchar2_table(471) := '56207B0D0A2020626F726465722D7261646975733A2030203270782032707820303B0D0A7D0D0A2E752D52544C202E612D427574746F6E2E612D427574746F6E2D2D63616C656E6461722C0D0A2E752D52544C202E612D427574746F6E2E612D42757474';
wwv_flow_api.g_varchar2_table(472) := '6F6E2D2D706F7075704C4F56207B0D0A2020626F726465722D7261646975733A2032707820302030203270783B0D0A7D0D0A2E742D466F726D2D696E707574436F6E7461696E657220696E7075742E686173446174657069636B65722C0D0A2E742D466F';
wwv_flow_api.g_varchar2_table(473) := '726D2D696E707574436F6E7461696E657220696E7075742E706F7075705F6C6F76207B0D0A2020626F726465722D7261646975733A2032707820302030203270783B0D0A7D0D0A2E752D52544C202E742D466F726D2D696E707574436F6E7461696E6572';
wwv_flow_api.g_varchar2_table(474) := '20696E7075742E686173446174657069636B65722C0D0A2E752D52544C202E742D466F726D2D696E707574436F6E7461696E657220696E7075742E706F7075705F6C6F76207B0D0A2020626F726465722D7261646975733A203020327078203270782030';
wwv_flow_api.g_varchar2_table(475) := '3B0D0A7D0D0A0D0A2E636865636B626F785F67726F757020696E7075742C0D0A2E726164696F5F67726F757020696E707574207B0D0A20200D0A20200D0A7D0D0A2E636865636B626F785F67726F757020696E707574202B206C6162656C3A6265666F72';
wwv_flow_api.g_varchar2_table(476) := '652C0D0A2E726164696F5F67726F757020696E707574202B206C6162656C3A6265666F7265207B0D0A20206261636B67726F756E642D636F6C6F723A20236639663966393B0D0A7D0D0A2E636865636B626F785F67726F757020696E7075743A666F6375';
wwv_flow_api.g_varchar2_table(477) := '73202B206C6162656C3A6265666F72652C0D0A2E726164696F5F67726F757020696E7075743A666F637573202B206C6162656C3A6265666F7265207B0D0A2020626F726465722D636F6C6F723A20233035373263653B0D0A7D0D0A2E636865636B626F78';
wwv_flow_api.g_varchar2_table(478) := '5F67726F757020696E7075743A666F6375733A636865636B6564202B206C6162656C3A6265666F72652C0D0A2E726164696F5F67726F757020696E7075743A666F6375733A636865636B6564202B206C6162656C3A6265666F7265207B0D0A2020626F72';
wwv_flow_api.g_varchar2_table(479) := '6465722D636F6C6F723A20233035373263653B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A2020626F782D736861646F773A20302030203020317078202366396639663920696E7365743B0D0A7D0D0A2E636865636B';
wwv_flow_api.g_varchar2_table(480) := '626F785F67726F757020696E7075743A636865636B6564202B206C6162656C3A6265666F72652C0D0A2E726164696F5F67726F757020696E7075743A636865636B6564202B206C6162656C3A6265666F7265207B0D0A2020626F726465722D636F6C6F72';
wwv_flow_api.g_varchar2_table(481) := '3A20233035373263653B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A7D0D0A0D0A2E726164696F5F67726F757020696E707574202B206C6162656C3A6166746572207B0D0A20206261636B67726F756E642D636F6C6F';
wwv_flow_api.g_varchar2_table(482) := '723A20236639663966393B0D0A7D0D0A0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E636865636B626F785F67726F757020696E707574207B0D0A20200D0A20200D0A7D0D0A2E742D466F';
wwv_flow_api.g_varchar2_table(483) := '726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E636865636B626F785F67726F757020696E707574202B206C6162656C3A6265666F7265207B0D0A20206261636B67726F756E642D636F6C6F723A2023653665';
wwv_flow_api.g_varchar2_table(484) := '3665363B0D0A2020626F726465722D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E636865636B626F785F67726F757020696E7075';
wwv_flow_api.g_varchar2_table(485) := '743A666F637573202B206C6162656C3A6265666F7265207B0D0A2020626F726465722D636F6C6F723A20233035373263653B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E636865';
wwv_flow_api.g_varchar2_table(486) := '636B626F785F67726F757020696E7075743A666F6375733A636865636B6564202B206C6162656C3A6265666F7265207B0D0A2020626F726465722D636F6C6F723A20236639663966393B0D0A20206261636B67726F756E642D636F6C6F723A2023663966';
wwv_flow_api.g_varchar2_table(487) := '3966393B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E636865636B626F785F';
wwv_flow_api.g_varchar2_table(488) := '67726F757020696E7075743A666F6375733A636865636B6564202B206C6162656C3A6166746572207B0D0A2020636F6C6F723A20233035373263653B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E';
wwv_flow_api.g_varchar2_table(489) := '47726F7570202E636865636B626F785F67726F757020696E7075743A636865636B6564202B206C6162656C3A6265666F7265207B0D0A2020626F726465722D636F6C6F723A20236639663966393B0D0A20206261636B67726F756E642D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(490) := '236639663966393B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E636865636B626F785F67726F757020696E7075743A636865636B6564202B206C6162656C3A6166746572207B0D';
wwv_flow_api.g_varchar2_table(491) := '0A2020636F6C6F723A20233035373263653B0D0A7D0D0A0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D70726554657874426C6F636B202E742D466F726D2D6974656D546578742D2D7072652C0D0A2E742D466F726D2D6669656C6443';
wwv_flow_api.g_varchar2_table(492) := '6F6E7461696E65722D2D706F737454657874426C6F636B202E742D466F726D2D6974656D546578742D2D706F7374207B0D0A20206261636B67726F756E642D636F6C6F723A20236639663966393B0D0A2020626F782D736861646F773A20302030203020';
wwv_flow_api.g_varchar2_table(493) := '302E3172656D202364666466646620696E7365743B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D70726554657874426C6F636B202E742D466F726D2D6974656D5465';
wwv_flow_api.g_varchar2_table(494) := '78742D2D707265207B0D0A2020626F726465722D7261646975733A2032707820302030203270783B0D0A7D0D0A2E752D52544C202E742D466F726D2D6669656C64436F6E7461696E65722D2D70726554657874426C6F636B202E742D466F726D2D697465';
wwv_flow_api.g_varchar2_table(495) := '6D546578742D2D707265207B0D0A2020626F726465722D7261646975733A2030203270782032707820303B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D706F737454657874426C6F636B202E742D466F726D2D6974656D5465';
wwv_flow_api.g_varchar2_table(496) := '78742D2D706F7374207B0D0A2020626F726465722D7261646975733A2030203270782032707820303B0D0A7D0D0A2E752D52544C202E742D466F726D2D6669656C64436F6E7461696E65722D2D706F737454657874426C6F636B202E742D466F726D2D69';
wwv_flow_api.g_varchar2_table(497) := '74656D546578742D2D706F7374207B0D0A2020626F726465722D7261646975733A2032707820302030203270783B0D0A7D0D0A0D0A2E617065782D6974656D2D6861732D69636F6E3A666F637573202B202E617065782D6974656D2D69636F6E207B0D0A';
wwv_flow_api.g_varchar2_table(498) := '2020636F6C6F723A20233035373263653B0D0A7D0D0A0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D666C6F6174696E674C6162656C202E617065782D6974656D2D69636F6E207B0D0A2020636F6C6F723A20233636363636363B0D0A';
wwv_flow_api.g_varchar2_table(499) := '2020626F782D736861646F773A202D302E3172656D20302030202364666466646620696E7365743B0D0A2020626F726465722D7261646975733A2032707820302030203270783B0D0A7D0D0A2E752D52544C202E742D466F726D2D6669656C64436F6E74';
wwv_flow_api.g_varchar2_table(500) := '61696E65722D2D666C6F6174696E674C6162656C202E617065782D6974656D2D69636F6E207B0D0A2020626F782D736861646F773A20302E3172656D20302030202364666466646620696E7365743B0D0A2020626F726465722D7261646975733A203020';
wwv_flow_api.g_varchar2_table(501) := '3270782032707820303B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D666C6F6174696E674C6162656C202E617065782D6974656D2D6861732D69636F6E3A666F637573202B202E617065782D6974656D2D69636F6E207B0D0A';
wwv_flow_api.g_varchar2_table(502) := '2020626F782D736861646F773A206E6F6E653B0D0A7D0D0A0D0A2E742D466F726D2D68656C70427574746F6E3A666F637573202E612D49636F6E207B0D0A2020636F6C6F723A20233035373263653B0D0A7D0D0A0D0A2E742D466F726D2D6669656C6443';
wwv_flow_api.g_varchar2_table(503) := '6F6E7461696E65722D2D726164696F427574746F6E47726F7570202E742D466F726D2D6974656D57726170706572203E202E617065782D6974656D2D67726F7570203E202E617065782D6974656D2D6F7074696F6E3A66697273742D6F662D7479706520';
wwv_flow_api.g_varchar2_table(504) := '6C6162656C207B0D0A2020626F726465722D7261646975733A2032707820327078203020303B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E742D466F726D2D6974656D57726170';
wwv_flow_api.g_varchar2_table(505) := '706572203E202E617065782D6974656D2D67726F7570203E202E617065782D6974656D2D6F7074696F6E3A6C6173742D6F662D74797065206C6162656C207B0D0A2020626F726465722D7261646975733A2030203020327078203270783B0D0A7D0D0A0D';
wwv_flow_api.g_varchar2_table(506) := '0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726964202E617065782D6974656D2D677269642D726F773A6F6E6C792D6368696C64202E617065782D6974656D2D';
wwv_flow_api.g_varchar2_table(507) := '6F7074696F6E3A66697273742D6F662D74797065206C6162656C207B0D0A2020626F726465722D7261646975733A2032707820302030203270783B0D0A7D0D0A2E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47';
wwv_flow_api.g_varchar2_table(508) := '726F7570202E617065782D6974656D2D67726964202E617065782D6974656D2D677269642D726F773A6F6E6C792D6368696C64202E617065782D6974656D2D6F7074696F6E3A6C6173742D6F662D74797065206C6162656C207B0D0A2020626F72646572';
wwv_flow_api.g_varchar2_table(509) := '2D7261646975733A2030203270782032707820303B0D0A7D0D0A2E752D52544C202E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726964202E617065782D6974656D';
wwv_flow_api.g_varchar2_table(510) := '2D677269642D726F773A6F6E6C792D6368696C64202E617065782D6974656D2D6F7074696F6E3A66697273742D6F662D74797065206C6162656C207B0D0A2020626F726465722D7261646975733A2030203270782032707820303B0D0A7D0D0A2E752D52';
wwv_flow_api.g_varchar2_table(511) := '544C202E742D466F726D2D6669656C64436F6E7461696E65722D2D726164696F427574746F6E47726F7570202E617065782D6974656D2D67726964202E617065782D6974656D2D677269642D726F773A6F6E6C792D6368696C64202E617065782D697465';
wwv_flow_api.g_varchar2_table(512) := '6D2D6F7074696F6E3A6C6173742D6F662D74797065206C6162656C207B0D0A2020626F726465722D7261646975733A2032707820302030203270783B0D0A7D0D0A0D0A2E742D4865616465722D6272616E64696E67207B0D0A20206261636B67726F756E';
wwv_flow_api.g_varchar2_table(513) := '642D636F6C6F723A20233035373263653B0D0A7D0D0A2E742D4865616465722D6C6F676F2C0D0A2E742D486561646572202E742D427574746F6E2D2D6865616465722E69732D6163746976652C0D0A2E742D486561646572202E742D427574746F6E2D2D';
wwv_flow_api.g_varchar2_table(514) := '686561646572207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D4865616465722D6C6F676F3A686F7665722C0D0A2E742D486561646572202E742D427574746F6E2D2D6865616465722E69732D6163746976653A686F7665722C0D';
wwv_flow_api.g_varchar2_table(515) := '0A2E742D486561646572202E742D427574746F6E2D2D6865616465723A686F766572207B0D0A2020746578742D6465636F726174696F6E3A206E6F6E653B0D0A7D0D0A2E742D4865616465722D6C6F676F2D6C696E6B207B0D0A2020636F6C6F723A2069';
wwv_flow_api.g_varchar2_table(516) := '6E68657269743B0D0A7D0D0A2E742D4865616465722D6C6F676F2D6C696E6B3A666F6375732C0D0A2E742D4865616465722D6C6F676F2D6C696E6B3A6163746976653A666F637573207B0D0A20206F75746C696E653A206E6F6E653B0D0A2020626F782D';
wwv_flow_api.g_varchar2_table(517) := '736861646F773A20302030203020317078202332363939666120696E7365743B0D0A7D0D0A2E742D4865616465722D6E6176207B0D0A20206261636B67726F756E642D636F6C6F723A20233331333733633B0D0A7D0D0A2E742D486561646572202E612D';
wwv_flow_api.g_varchar2_table(518) := '4D656E754261722D6974656D3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D486561646572202E612D4D656E754261722D6974656D203E202E612D4D656E752D7375624D65';
wwv_flow_api.g_varchar2_table(519) := '6E75436F6C202E612D49636F6E207B0D0A2020626F726465722D7261646975733A20313030253B0D0A7D0D0A2E742D486561646572202E612D4D656E752E612D4D656E752D2D746F70203E202E612D4D656E752D636F6E74656E74207B0D0A2020626F72';
wwv_flow_api.g_varchar2_table(520) := '6465722D746F702D77696474683A20303B0D0A7D0D0A2E742D486561646572202E612D4D656E752D636F6E74656E74207B0D0A2020626F782D736861646F773A20302032707820367078207267626128302C20302C20302C20302E3135293B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(521) := '2E742D4865616465722D6E61762D6C697374207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D4865726F526567696F6E2D69636F6E207B0D0A2020626F726465722D7261646975733A203470';
wwv_flow_api.g_varchar2_table(522) := '783B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D4865726F526567696F6E2D7469746C65207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D';
wwv_flow_api.g_varchar2_table(523) := '0A2E742D4865726F526567696F6E2D636F6C2D2D636F6E74656E74207B0D0A2020636F6C6F723A20233731373137313B0D0A7D0D0A0D0A2E612D495252207B0D0A2020626F726465722D7261646975733A203270783B0D0A2020626F726465722D636F6C';
wwv_flow_api.g_varchar2_table(524) := '6F723A207267626128302C20302C20302C20302E31293B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E612D495252202E612D4952522D706167696E6174696F6E2D6C6162656C207B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(525) := '20233733373337333B0D0A7D0D0A2E612D4952522D7265706F727453756D6D6172792D76616C7565207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E612D4952522D636F6E74726F6C73436F6E7461696E6572207B0D0A2020626F7264';
wwv_flow_api.g_varchar2_table(526) := '65722D746F702D636F6C6F723A20236635663566353B0D0A20206261636B67726F756E642D636F6C6F723A20236661666166613B0D0A7D0D0A2E612D4952522D66756C6C56696577207B0D0A20206261636B67726F756E642D636F6C6F723A2023666666';
wwv_flow_api.g_varchar2_table(527) := '6666663B0D0A7D0D0A2E612D4952522D627574746F6E2E612D4952522D627574746F6E2D2D636F6E74726F6C73207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E612D4952522D746F6F6C626172';
wwv_flow_api.g_varchar2_table(528) := '207B0D0A20206261636B67726F756E643A20236666666666663B0D0A2020626F726465722D636F6C6F723A20236536653665363B0D0A7D0D0A2E612D5265706F72742D70657263656E7443686172742D66696C6C207B0D0A20206261636B67726F756E64';
wwv_flow_api.g_varchar2_table(529) := '2D636F6C6F723A20233035373263653B0D0A7D0D0A2E612D5265706F72742D70657263656E744368617274207B0D0A20206261636B67726F756E642D636F6C6F723A20236434656266653B0D0A7D0D0A2E612D4952522D627574746F6E2D2D636F6C5365';
wwv_flow_api.g_varchar2_table(530) := '61726368207B0D0A20202D7765626B69742D626F726465722D746F702D72696768742D7261646975733A203070782021696D706F7274616E743B0D0A20202D7765626B69742D626F726465722D626F74746F6D2D72696768742D7261646975733A203070';
wwv_flow_api.g_varchar2_table(531) := '782021696D706F7274616E743B0D0A20202D6D6F7A2D626F726465722D7261646975732D746F7072696768743A20307078202021696D706F7274616E743B0D0A20202D6D6F7A2D626F726465722D7261646975732D626F74746F6D72696768743A203070';
wwv_flow_api.g_varchar2_table(532) := '782021696D706F7274616E743B0D0A2020626F726465722D746F702D72696768742D7261646975733A203070782021696D706F7274616E743B0D0A2020626F726465722D626F74746F6D2D72696768742D7261646975733A203070782021696D706F7274';
wwv_flow_api.g_varchar2_table(533) := '616E743B0D0A7D0D0A2E612D4952522D69636F6E566965775461626C652C0D0A2E612D4952522D6368617274566965772C0D0A2E612D4952522D7069766F74566965772C0D0A2E612D4952522D67726F75704279566965772C0D0A2E612D4952522D6465';
wwv_flow_api.g_varchar2_table(534) := '7461696C56696577207B0D0A2020626F726465722D746F702D636F6C6F723A20236635663566353B0D0A7D0D0A2E612D4952522D746F6F6C6261722D2D73696E676C65526F77207B0D0A2020626F726465722D626F74746F6D2D636F6C6F723A20236630';
wwv_flow_api.g_varchar2_table(535) := '663066303B0D0A7D0D0A2E612D4952522D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20236661666166613B0D0A2020626F726465722D746F703A2031707820736F6C696420236536653665363B0D0A2020626F782D736861';
wwv_flow_api.g_varchar2_table(536) := '646F773A20696E7365742031707820302030203020236536653665363B0D0A7D0D0A2E612D4952522D6865616465723A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236632663266323B0D0A7D0D0A2E612D4952522D686561';
wwv_flow_api.g_varchar2_table(537) := '6465722E69732D6163746976652061207B0D0A2020636F6C6F723A20696E68657269743B0D0A7D0D0A2E612D4952522D6865616465722E69732D616374697665202E612D4952522D686561646572536F7274207B0D0A2020636F6C6F723A20696E686572';
wwv_flow_api.g_varchar2_table(538) := '69743B0D0A7D0D0A2E612D4952522D6865616465722E69732D6163746976652C0D0A2E612D47562D6865616465722E69732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20233230323032303B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(539) := '4646463B0D0A7D0D0A2E612D4952522D6865616465722D2D67726F7570207B0D0A20206261636B67726F756E642D636F6C6F723A20236635663566353B0D0A7D0D0A2E612D4952522D7461626C65207472207464207B0D0A20206261636B67726F756E64';
wwv_flow_api.g_varchar2_table(540) := '2D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E612D4952522D7461626C65207B0D0A2020626F726465722D636F6C6C617073653A2073657061726174653B0D0A7D0D0A2E612D4952522D7461626C';
wwv_flow_api.g_varchar2_table(541) := '652074723A686F766572207464207B0D0A20206261636B67726F756E642D636F6C6F723A20236639663966393B0D0A7D0D0A2E742D4952522D726567696F6E2D2D6E6F426F7264657273202E612D495252207B0D0A2020626F726465722D726164697573';
wwv_flow_api.g_varchar2_table(542) := '3A203270783B0D0A7D0D0A2E612D4952522D7461626C65207464207B0D0A2020626F726465722D6C6566743A2031707820736F6C696420236632663266323B0D0A2020626F726465722D746F703A2031707820736F6C696420236632663266323B0D0A7D';
wwv_flow_api.g_varchar2_table(543) := '0D0A2E612D4952522D6865616465724C696E6B3A666F637573207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A7D0D0A2E612D4952522D7365617263682D6669656C643A666F637573207B0D';
wwv_flow_api.g_varchar2_table(544) := '0A2020626F726465722D636F6C6F723A20233035373263653B0D0A2020626F782D736861646F773A202D31707820302030202330353732636520696E7365742C2031707820302030202330353732636520696E7365743B0D0A7D0D0A2E612D4952522D73';
wwv_flow_api.g_varchar2_table(545) := '696E676C65526F772D6E616D652C0D0A2E612D4952522D73696E676C65526F772D76616C7565207B0D0A2020626F726465722D626F74746F6D2D636F6C6F723A20236630663066303B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E612D';
wwv_flow_api.g_varchar2_table(546) := '4952522D73696E676C65526F772D76616C7565207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E612D4952522D73696E676C65526F772D726F773A686F766572202E612D4952522D73696E676C65526F772D';
wwv_flow_api.g_varchar2_table(547) := '76616C7565207B0D0A20206261636B67726F756E642D636F6C6F723A20236637663766373B0D0A7D0D0A2E612D4952522D73696E676C65526F772D6E616D65207B0D0A20206261636B67726F756E642D636F6C6F723A20236637663766373B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(548) := '2E612D4952522D73696E676C65526F772D726F773A686F766572202E612D4952522D73696E676C65526F772D6E616D65207B0D0A20206261636B67726F756E642D636F6C6F723A20236630663066303B0D0A7D0D0A2E612D4952522D627574746F6E2E61';
wwv_flow_api.g_varchar2_table(549) := '2D4952522D627574746F6E2D2D706167696E6174696F6E3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A7D0D0A2E612D4952522D7265706F727453756D6D6172792D6C6162656C2C0D0A2E612D4952';
wwv_flow_api.g_varchar2_table(550) := '522D636F6E74726F6C734C6162656C207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A406D65646961206F6E6C792073637265656E20616E6420286D696E2D77696474683A20373639707829207B0D0A20202E';
wwv_flow_api.g_varchar2_table(551) := '69732D6D6178696D697A65642E742D4952522D726567696F6E202E742D6668742D7468656164202E612D4952522D686561646572207B0D0A20202020626F726465722D626F74746F6D3A2031707820736F6C696420236536653665363B0D0A20207D0D0A';
wwv_flow_api.g_varchar2_table(552) := '7D0D0A2E75692D7769646765742D636F6E74656E74202E612D4952522D69636F6E4C6973742D6C696E6B207B0D0A2020636F6C6F723A20233430343034303B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E61';
wwv_flow_api.g_varchar2_table(553) := '2D4952522D69636F6E4C6973742D6C696E6B3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236637663766373B0D0A7D0D0A0D0A2E612D4952522D627574746F6E3A666F637573207B0D0A2020626F782D736861646F773A20';
wwv_flow_api.g_varchar2_table(554) := '696E68657269743B0D0A7D0D0A0D0A2E612D4952522D736F7274576964676574207B0D0A20206261636B67726F756E642D636F6C6F723A20726762612833322C2033322C2033322C20302E3935293B0D0A20202D7765626B69742D6261636B64726F702D';
wwv_flow_api.g_varchar2_table(555) := '66696C7465723A20626C757228347078293B0D0A2020636F6C6F723A20234646463B0D0A2020626F726465722D77696474683A20303B0D0A2020626F782D736861646F773A20302032707820347078202D327078207267626128302C20302C20302C2030';
wwv_flow_api.g_varchar2_table(556) := '2E35292C2030203870782031367078202D347078207267626128302C20302C20302C20302E3135293B0D0A7D0D0A2E612D4952522D736F7274576964676574203A3A2D7765626B69742D7363726F6C6C626172207B0D0A202077696474683A203870783B';
wwv_flow_api.g_varchar2_table(557) := '0D0A20206865696768743A203870783B0D0A7D0D0A2E612D4952522D736F7274576964676574203A3A2D7765626B69742D7363726F6C6C6261722D7468756D62207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235352C203235';
wwv_flow_api.g_varchar2_table(558) := '352C203235352C20302E35293B0D0A7D0D0A2E612D4952522D736F7274576964676574203A3A2D7765626B69742D7363726F6C6C6261722D747261636B207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235352C203235352C20';
wwv_flow_api.g_varchar2_table(559) := '3235352C20302E3235293B0D0A7D0D0A0D0A2E612D4952522D736F72745769646765742D68656C70207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A0D0A2E612D4952522D736F7274576964676574';
wwv_flow_api.g_varchar2_table(560) := '2D616374696F6E73207B0D0A202070616464696E673A203870783B0D0A2020626F726465722D7261646975733A203270783B0D0A202077696474683A206175746F3B0D0A2020626F726465722D626F74746F6D2D77696474683A20303B0D0A7D0D0A2E61';
wwv_flow_api.g_varchar2_table(561) := '2D4952522D736F72745769646765742D616374696F6E732D6974656D207B0D0A2020626F726465722D72696768742D77696474683A20303B0D0A7D0D0A2E612D4952522D627574746F6E2E612D4952522D736F72745769646765742D627574746F6E207B';
wwv_flow_api.g_varchar2_table(562) := '0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A2020636F6C6F723A20234646463B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A2E612D4952522D627574746F6E2E612D4952522D736F';
wwv_flow_api.g_varchar2_table(563) := '72745769646765742D627574746F6E3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E35293B0D0A7D0D0A2E612D4952522D627574746F6E2E612D4952522D736F72745769646765742D';
wwv_flow_api.g_varchar2_table(564) := '627574746F6E3A666F637573207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A7D0D0A2E612D4952522D627574746F6E2E612D4952522D736F72745769646765742D627574746F6E2E69732D';
wwv_flow_api.g_varchar2_table(565) := '6163746976652C0D0A2E612D4952522D627574746F6E2E612D4952522D736F72745769646765742D627574746F6E3A6163746976653A666F637573207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E35';
wwv_flow_api.g_varchar2_table(566) := '293B0D0A7D0D0A2E612D4952522D736F72745769646765742D7365617263684C6162656C207B0D0A20206865696768743A20343070783B0D0A202070616464696E673A2031327078203870783B0D0A7D0D0A2E612D4952522D736F72745769646765742D';
wwv_flow_api.g_varchar2_table(567) := '7365617263684C6162656C3A6265666F7265207B0D0A2020636F6C6F723A20234646463B0D0A7D0D0A2E612D4952522D736F72745769646765742D736561726368203E202E612D4952522D736F72745769646765742D7365617263684669656C645B7479';
wwv_flow_api.g_varchar2_table(568) := '70653D2274657874225D207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A2020617070656172616E63653A206E6F6E653B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235352C2032';
wwv_flow_api.g_varchar2_table(569) := '35352C203235352C20302E31293B0D0A20206865696768743A20343070783B0D0A2020636F6C6F723A20234646463B0D0A7D0D0A2E612D4952522D736F72745769646765742D736561726368203E202E612D4952522D736F72745769646765742D736561';
wwv_flow_api.g_varchar2_table(570) := '7263684669656C645B747970653D2274657874225D3A666F637573207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A7D0D0A2E612D4952522D736F72745769646765742D726F7773207B0D0A';
wwv_flow_api.g_varchar2_table(571) := '2020626F726465722D746F702D77696474683A20303B0D0A7D0D0A2E612D4952522D736F72745769646765742D726F77207B0D0A2020636F6C6F723A20234646463B0D0A2020626F782D736861646F773A206E6F6E653B0D0A7D0D0A2E612D4952522D73';
wwv_flow_api.g_varchar2_table(572) := '6F72745769646765742D726F773A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235352C203235352C203235352C20302E3135293B0D0A7D0D0A2E612D4952522D736F72745769646765742D726F773A666F6375';
wwv_flow_api.g_varchar2_table(573) := '73207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A7D0D0A2E612D4947202E612D4952522D736F72745769646765743A6265666F7265207B0D0A2020636F6C6F723A20726762612833322C20';
wwv_flow_api.g_varchar2_table(574) := '33322C2033322C20302E3935293B0D0A7D0D0A2E6F6A2D6476742D63617465676F727931207B0D0A2020636F6C6F723A20233330396664623B0D0A7D0D0A2E6F6A2D6476742D63617465676F727932207B0D0A2020636F6C6F723A20233363616638353B';
wwv_flow_api.g_varchar2_table(575) := '0D0A7D0D0A2E6F6A2D6476742D63617465676F727933207B0D0A2020636F6C6F723A20236662636534613B0D0A7D0D0A2E6F6A2D6476742D63617465676F727934207B0D0A2020636F6C6F723A20236539356235343B0D0A7D0D0A2E6F6A2D6476742D63';
wwv_flow_api.g_varchar2_table(576) := '617465676F727935207B0D0A2020636F6C6F723A20233835346539623B0D0A7D0D0A2E6F6A2D6476742D63617465676F727936207B0D0A2020636F6C6F723A20233265626662633B0D0A7D0D0A2E6F6A2D6476742D63617465676F727937207B0D0A2020';
wwv_flow_api.g_varchar2_table(577) := '636F6C6F723A20236564383133653B0D0A7D0D0A2E6F6A2D6476742D63617465676F727938207B0D0A2020636F6C6F723A20236538356438383B0D0A7D0D0A2E6F6A2D6476742D63617465676F727939207B0D0A2020636F6C6F723A2023313362366366';
wwv_flow_api.g_varchar2_table(578) := '3B0D0A7D0D0A2E6F6A2D6476742D63617465676F72793130207B0D0A2020636F6C6F723A20233831626235663B0D0A7D0D0A2E6F6A2D6476742D63617465676F72793131207B0D0A2020636F6C6F723A20236361353839643B0D0A7D0D0A2E6F6A2D6476';
wwv_flow_api.g_varchar2_table(579) := '742D63617465676F72793132207B0D0A2020636F6C6F723A20236464646535333B0D0A7D0D0A0D0A2E742D4C696E6B734C6973742D6974656D2C0D0A2E742D4C696E6B734C6973742D6C696E6B207B0D0A2020626F726465722D636F6C6F723A20236536';
wwv_flow_api.g_varchar2_table(580) := '653665363B0D0A7D0D0A2E742D4C696E6B734C6973742D69636F6E207B0D0A2020636F6C6F723A20236439643964393B0D0A7D0D0A2E742D4C696E6B734C6973742D6C696E6B3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(581) := '236632663266323B0D0A7D0D0A2E742D4C696E6B734C6973742D6C696E6B3A666F637573207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A7D0D0A0D0A2E742D4C696E6B734C6973742D2D73';
wwv_flow_api.g_varchar2_table(582) := '686F774172726F77202E742D4C696E6B734C6973742D6C696E6B3A6265666F7265207B0D0A2020636F6C6F723A20236439643964393B0D0A7D0D0A0D0A2E742D4C696E6B734C6973742D2D73686F774261646765202E742D4C696E6B734C6973742D6261';
wwv_flow_api.g_varchar2_table(583) := '646765207B0D0A20206261636B67726F756E642D636F6C6F723A20236635663566353B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D4C696E6B734C6973742D2D73686F774261646765202E742D4C696E6B734C6973742D6C696E6B';
wwv_flow_api.g_varchar2_table(584) := '3A686F766572202E742D4C696E6B734C6973742D6261646765207B0D0A20206261636B67726F756E642D636F6C6F723A20236562656265623B0D0A7D0D0A2E742D4C696E6B734C6973742D2D73686F774261646765202E742D4C696E6B734C6973742D69';
wwv_flow_api.g_varchar2_table(585) := '74656D2E69732D657870616E646564203E202E742D4C696E6B734C6973742D6C696E6B202E742D4C696E6B734C6973742D6261646765207B0D0A20206261636B67726F756E642D636F6C6F723A20236266626662663B0D0A7D0D0A0D0A2E742D4C696E6B';
wwv_flow_api.g_varchar2_table(586) := '734C6973742D2D627269676874486F766572202E742D4C696E6B734C6973742D6974656D2E69732D657870616E646564202E742D4C696E6B734C6973742D6C696E6B3A686F7665723A6265666F7265207B0D0A2020636F6C6F723A207267626128323535';
wwv_flow_api.g_varchar2_table(587) := '2C203235352C203235352C20302E35293B0D0A7D0D0A2E742D4C696E6B734C6973742D2D627269676874486F766572202E742D4C696E6B734C6973742D6C696E6B3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A202330353732';
wwv_flow_api.g_varchar2_table(588) := '63653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D4C696E6B734C6973742D2D627269676874486F766572202E742D4C696E6B734C6973742D6C696E6B3A686F766572202E742D4C696E6B734C6973742D69636F6E207B0D0A2020';
wwv_flow_api.g_varchar2_table(589) := '636F6C6F723A2072676261283235352C203235352C203235352C20302E3735293B0D0A7D0D0A2E742D4C696E6B734C6973742D6974656D2E69732D657870616E646564207B0D0A20206261636B67726F756E642D636F6C6F723A20234643464346433B0D';
wwv_flow_api.g_varchar2_table(590) := '0A20206261636B67726F756E643A206C696E6561722D6772616469656E74287267626128302C20302C20302C20302E303135292C207267626128302C20302C20302C203029292C206C696E6561722D6772616469656E74287267626128302C20302C2030';
wwv_flow_api.g_varchar2_table(591) := '2C2030292C207267626128302C20302C20302C20302E30313529293B0D0A7D0D0A2E742D4C696E6B734C6973742D6974656D2E69732D657870616E646564202E742D4C696E6B734C6973742D6C696E6B3A686F7665723A6265666F7265207B0D0A202063';
wwv_flow_api.g_varchar2_table(592) := '6F6C6F723A20233035373263653B0D0A7D0D0A2E742D4C696E6B734C6973742D6974656D2E69732D657870616E646564202E742D4C696E6B734C6973742D6C696E6B3A6265666F7265207B0D0A2020636F6C6F723A207267626128302C20302C20302C20';
wwv_flow_api.g_varchar2_table(593) := '302E3235293B0D0A7D0D0A2E742D4C696E6B734C6973742D2D73686F774261646765202E742D4C696E6B734C6973742D6261646765207B0D0A2020626F726465722D7261646975733A203470783B0D0A7D0D0A2E742D4C696E6B734C6973742D2D69636F';
wwv_flow_api.g_varchar2_table(594) := '6E4F6E6C79202E742D4C696E6B734C6973742D69636F6E207B0D0A2020626F726465722D7261646975733A20313030253B0D0A7D0D0A2E742D4C696E6B734C6973742D2D616374696F6E73202E742D4C696E6B734C6973742D6C6162656C207B0D0A2020';
wwv_flow_api.g_varchar2_table(595) := '636F6C6F723A20233361336133613B0D0A7D0D0A2E742D4C696E6B734C6973742D2D616374696F6E73202E742D4C696E6B734C6973742D69636F6E207B0D0A2020636F6C6F723A20233361336133613B0D0A7D0D0A2E742D4C696E6B734C6973742D2D61';
wwv_flow_api.g_varchar2_table(596) := '6374696F6E73202E742D4C696E6B734C6973742D6C696E6B3A686F766572202E742D4C696E6B734C6973742D69636F6E2C0D0A2E742D4C696E6B734C6973742D2D616374696F6E73202E742D4C696E6B734C6973742D6C696E6B3A686F766572202E742D';
wwv_flow_api.g_varchar2_table(597) := '4C696E6B734C6973742D6C6162656C2C0D0A2E742D4C696E6B734C6973742D2D616374696F6E73202E742D4C696E6B734C6973742D6C696E6B3A686F766572202E742D4C696E6B734C6973742D6261646765207B0D0A2020636F6C6F723A202333653365';
wwv_flow_api.g_varchar2_table(598) := '33653B0D0A7D0D0A2E742D426F64792D616374696F6E73202E742D4C696E6B734C6973742D6C696E6B3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236563656365633B0D0A7D0D0A0D0A2E742D4C6F67696E2D69636F6E56';
wwv_flow_api.g_varchar2_table(599) := '616C69646174696F6E207B0D0A20206261636B67726F756E643A20233362616132633B0D0A2020636F6C6F723A2077686974653B0D0A7D0D0A626F6479202E742D4C6F67696E2D7469746C65207B0D0A2020636F6C6F723A20233430343034303B0D0A7D';
wwv_flow_api.g_varchar2_table(600) := '0D0A2E742D4C6F67696E2D726567696F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D4C6F67696E2D6C6F676F207B0D0A2020636F6C6F723A20233035373263653B0D0A7D0D0A406D6564696120';
wwv_flow_api.g_varchar2_table(601) := '6F6E6C792073637265656E20616E6420286D61782D77696474683A20343830707829207B0D0A20202E742D50616765426F64792D2D6C6F67696E2C0D0A20202E742D50616765426F64792D2D6C6F67696E202E742D426F6479207B0D0A20202020626163';
wwv_flow_api.g_varchar2_table(602) := '6B67726F756E642D636F6C6F723A20236666666666663B0D0A20207D0D0A7D0D0A0D0A2E742D4D656469614C697374207B0D0A2020626F726465722D636F6C6F723A20236530653065303B0D0A20206261636B67726F756E642D636F6C6F723A20236666';
wwv_flow_api.g_varchar2_table(603) := '666666663B0D0A7D0D0A2E742D4D656469614C6973742D6974656D207B0D0A2020626F726465722D636F6C6F723A20236530653065303B0D0A7D0D0A2E742D4D656469614C6973742D6974656D2E69732D616374697665207B0D0A20206261636B67726F';
wwv_flow_api.g_varchar2_table(604) := '756E642D636F6C6F723A207267626128302C20302C20302C20302E3035293B0D0A7D0D0A2E742D4D656469614C6973742D2D686F72697A6F6E74616C202E742D4D656469614C6973742D6974656D207B0D0A2020626F726465722D72696768743A203170';
wwv_flow_api.g_varchar2_table(605) := '7820736F6C696420236530653065303B0D0A7D0D0A0D0A612E742D4D656469614C6973742D6974656D57726170207B0D0A2020636F6C6F723A20233035366162663B0D0A7D0D0A612E742D4D656469614C6973742D6974656D577261703A686F76657220';
wwv_flow_api.g_varchar2_table(606) := '7B0D0A20206261636B67726F756E642D636F6C6F723A20236661666166613B0D0A2020636F6C6F723A20233035366162663B0D0A7D0D0A612E742D4D656469614C6973742D6974656D577261703A666F637573207B0D0A2020626F782D736861646F773A';
wwv_flow_api.g_varchar2_table(607) := '20302030203020317078202330353732636520696E7365743B0D0A7D0D0A2E742D4D656469614C6973742D6974656D57726170207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D4D656469614C6973742D62616467652C0D0A2E74';
wwv_flow_api.g_varchar2_table(608) := '2D4D656469614C6973742D64657363207B0D0A2020636F6C6F723A20233733373337333B0D0A7D0D0A2E742D4D656469614C6973742D69636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236266626662663B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(609) := '20236666666666663B0D0A7D0D0A2E742D4D656469614C6973742D2D636F6C73207B0D0A2020626F782D736861646F773A202D317078202D31707820302030202365306530653020696E7365743B0D0A7D0D0A2E742D4D656469614C6973742D2D636F6C';
wwv_flow_api.g_varchar2_table(610) := '73202E742D4D656469614C6973742D6974656D3A6265666F72652C0D0A2E742D4D656469614C6973742D2D636F6C73202E742D4D656469614C6973742D6974656D3A6166746572207B0D0A20206261636B67726F756E642D636F6C6F723A202365366536';
wwv_flow_api.g_varchar2_table(611) := '65363B0D0A7D0D0A0D0A2E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A20236666666666663B0D0A20206C696E652D6865696768743A20323070783B0D0A7D0D0A2E612D4D656E754261722D6974656D203E202E612D4D656E752D';
wwv_flow_api.g_varchar2_table(612) := '7375624D656E75436F6C207B0D0A2020646973706C61793A20696E6C696E652D626C6F636B3B0D0A202070616464696E673A2038707820303B0D0A2020766572746963616C2D616C69676E3A20746F703B0D0A20206D617267696E2D72696768743A2038';
wwv_flow_api.g_varchar2_table(613) := '70783B0D0A20206D617267696E2D6C6566743A202D3470783B0D0A7D0D0A2E612D4D656E754261722D6974656D207B0D0A20206261636B67726F756E643A20233035373263653B0D0A2020626F726465722D72696768743A2031707820736F6C69642023';
wwv_flow_api.g_varchar2_table(614) := '3064386466393B0D0A2020626F726465722D6C6566743A2031707820736F6C696420233064386466393B0D0A20206D617267696E2D6C6566743A202D3170783B0D0A7D0D0A2E612D4D656E754261722D6974656D3A66697273742D6368696C64207B0D0A';
wwv_flow_api.g_varchar2_table(615) := '20206D617267696E2D6C6566743A20303B0D0A7D0D0A2E612D4D656E754261722D6974656D2E612D4D656E752D2D73706C6974203E202E612D4D656E752D7375624D656E75436F6C2C0D0A2E612D4D656E754261722E752D52544C202E612D4D656E7542';
wwv_flow_api.g_varchar2_table(616) := '61722D6974656D2E612D4D656E752D2D73706C6974203E202E612D4D656E752D7375624D656E75436F6C207B0D0A2020626F726465723A206E6F6E653B0D0A20206D617267696E2D72696768743A20303B0D0A202070616464696E673A20387078203870';
wwv_flow_api.g_varchar2_table(617) := '7820387078203470783B0D0A7D0D0A2E612D4D656E754261722D6974656D2E69732D64697361626C6564202E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A2072676261283235352C203235352C203235352C20302E35293B0D0A7D';
wwv_flow_api.g_varchar2_table(618) := '0D0A2E612D4D656E754261722D6974656D3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233064386466393B0D0A7D0D0A2E612D4D656E754261722D6974656D2E69732D657870616E646564207B0D0A20206261636B67726F';
wwv_flow_api.g_varchar2_table(619) := '756E642D636F6C6F723A20233064386466393B0D0A7D0D0A0D0A2E742D4D656E752D6261646765207B0D0A2020646973706C61793A20696E6C696E652D626C6F636B3B0D0A2020626F726465722D7261646975733A203270783B0D0A202070616464696E';
wwv_flow_api.g_varchar2_table(620) := '673A2030203670783B0D0A2020666F6E742D73697A653A20313170783B0D0A2020666F6E742D7765696768743A206E6F726D616C3B0D0A2020766572746963616C2D616C69676E3A20746F703B0D0A20206261636B67726F756E642D636F6C6F723A2072';
wwv_flow_api.g_varchar2_table(621) := '67626128302C20302C20302C20302E3235293B0D0A7D0D0A2E612D4D656E752D6C6162656C436F6E7461696E6572202E742D4D656E752D6261646765207B0D0A20206C696E652D6865696768743A20313670783B0D0A20206D617267696E2D6C6566743A';
wwv_flow_api.g_varchar2_table(622) := '203470783B0D0A20206D617267696E2D746F703A203870783B0D0A7D0D0A0D0A2E612D4D656E752D636F6E74656E74207B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A2E612D4D656E75202E612D4D656E752D6974656D207B0D';
wwv_flow_api.g_varchar2_table(623) := '0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E612D4D656E752D68536570617261746F72207B0D0A2020626F726465722D636F6C6F723A207267626128302C20302C20302C20302E3135293B0D0A7D0D0A2E612D4D656E752D2D6375727265';
wwv_flow_api.g_varchar2_table(624) := '6E74207B0D0A20206261636B67726F756E642D636F6C6F723A20233366613466613B0D0A7D0D0A2E612D4D656E75202E612D4D656E752D6974656D2E69732D64697361626C65642E69732D666F6375736564207B0D0A20206261636B67726F756E642D63';
wwv_flow_api.g_varchar2_table(625) := '6F6C6F723A20236664666466643B0D0A7D0D0A2E612D4D656E75202E612D4D656E752D6974656D2E69732D64697361626C65642E69732D666F6375736564203E202E612D4D656E752D696E6E6572202E612D4D656E752D7375624D656E75436F6C207B0D';
wwv_flow_api.g_varchar2_table(626) := '0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E612D4D656E75202E612D4D656E752D6974656D2E69732D64697361626C65642E69732D666F6375736564203E202E612D4D656E752D696E6E6572202E612D4D656E752D616363656C207B0D0A';
wwv_flow_api.g_varchar2_table(627) := '2020636F6C6F723A20233765376537653B0D0A7D0D0A2E612D4D656E75202E612D4D656E752D6974656D2E69732D666F63757365642C0D0A2E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564207B0D0A20206261636B6772';
wwv_flow_api.g_varchar2_table(628) := '6F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E612D4D656E75202E612D4D656E752D6974656D2E69732D666F6375736564203E202E612D4D656E752D696E6E6572202E612D4D656E752D';
wwv_flow_api.g_varchar2_table(629) := '737461747573436F6C2C0D0A2E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564203E202E612D4D656E752D696E6E6572202E612D4D656E752D737461747573436F6C2C0D0A2E612D4D656E75202E612D4D656E752D697465';
wwv_flow_api.g_varchar2_table(630) := '6D2E69732D666F6375736564203E202E612D4D656E752D696E6E6572202E612D4D656E752D7375624D656E75436F6C2C0D0A2E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564203E202E612D4D656E752D696E6E6572202E';
wwv_flow_api.g_varchar2_table(631) := '612D4D656E752D7375624D656E75436F6C2C0D0A2E612D4D656E75202E612D4D656E752D6974656D2E69732D666F6375736564203E202E612D4D656E752D696E6E6572202E612D4D656E752D616363656C2C0D0A2E612D4D656E75202E612D4D656E752D';
wwv_flow_api.g_varchar2_table(632) := '6974656D2E69732D657870616E646564203E202E612D4D656E752D696E6E6572202E612D4D656E752D616363656C207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E612D4D656E75202E612D4D656E752D616363656C207B0D0A202063';
wwv_flow_api.g_varchar2_table(633) := '6F6C6F723A20726762612836322C2036322C2036322C20302E3735293B0D0A7D0D0A2E612D4D656E752D636F6E74656E74207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235332C203235332C203235332C20302E3935293B0D';
wwv_flow_api.g_varchar2_table(634) := '0A2020626F726465722D636F6C6F723A20236534653465343B0D0A2020626F782D736861646F773A20302031707820327078207267626128302C20302C20302C20302E3035293B0D0A7D0D0A2E612D4D656E75426172207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(635) := '6E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D4865616465722D6E61762D6C6973742C0D0A2E742D486561646572202E612D4D656E75426172207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B';
wwv_flow_api.g_varchar2_table(636) := '0D0A7D0D0A2E742D526567696F6E207B0D0A20200D0A20200D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A20233333333333333B0D0A20206C696E652D6865696768743A20323070783B0D0A';
wwv_flow_api.g_varchar2_table(637) := '7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D203E202E612D4D656E752D7375624D656E75436F6C207B0D0A2020646973706C61793A20696E6C696E652D626C6F636B3B0D0A202070616464696E673A2038707820303B0D0A2020';
wwv_flow_api.g_varchar2_table(638) := '766572746963616C2D616C69676E3A20746F703B0D0A20206D617267696E2D72696768743A203870783B0D0A20206D617267696E2D6C6566743A202D3470783B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D207B0D0A2020';
wwv_flow_api.g_varchar2_table(639) := '6261636B67726F756E643A20236632663266323B0D0A2020626F726465722D72696768743A2031707820736F6C696420236439643964393B0D0A2020626F726465722D6C6566743A2031707820736F6C696420236439643964393B0D0A20206D61726769';
wwv_flow_api.g_varchar2_table(640) := '6E2D6C6566743A202D3170783B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D3A66697273742D6368696C64207B0D0A20206D617267696E2D6C6566743A20303B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261';
wwv_flow_api.g_varchar2_table(641) := '722D6974656D2E612D4D656E752D2D73706C6974203E202E612D4D656E752D7375624D656E75436F6C2C0D0A2E742D526567696F6E202E612D4D656E754261722E752D52544C202E612D4D656E754261722D6974656D2E612D4D656E752D2D73706C6974';
wwv_flow_api.g_varchar2_table(642) := '203E202E612D4D656E752D7375624D656E75436F6C207B0D0A2020626F726465723A206E6F6E653B0D0A20206D617267696E2D72696768743A20303B0D0A202070616464696E673A203870782038707820387078203470783B0D0A7D0D0A2E742D526567';
wwv_flow_api.g_varchar2_table(643) := '696F6E202E612D4D656E754261722D6974656D2E69732D64697361626C6564202E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A20726762612835312C2035312C2035312C20302E35293B0D0A7D0D0A2E742D526567696F6E202E61';
wwv_flow_api.g_varchar2_table(644) := '2D4D656E754261722D6974656D3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236439643964393B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E69732D657870616E646564207B0D0A202062';
wwv_flow_api.g_varchar2_table(645) := '61636B67726F756E642D636F6C6F723A20236439643964393B0D0A7D0D0A2E742D526567696F6E202E742D4D656E752D6261646765207B0D0A2020646973706C61793A20696E6C696E652D626C6F636B3B0D0A2020626F726465722D7261646975733A20';
wwv_flow_api.g_varchar2_table(646) := '3270783B0D0A202070616464696E673A2030203670783B0D0A2020666F6E742D73697A653A20313170783B0D0A2020666F6E742D7765696768743A206E6F726D616C3B0D0A2020766572746963616C2D616C69676E3A20746F703B0D0A20206261636B67';
wwv_flow_api.g_varchar2_table(647) := '726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3235293B0D0A7D0D0A2E612D4D656E752D6C6162656C436F6E7461696E6572202E742D526567696F6E202E742D4D656E752D6261646765207B0D0A20206C696E652D6865696768';
wwv_flow_api.g_varchar2_table(648) := '743A20313670783B0D0A20206D617267696E2D6C6566743A203470783B0D0A20206D617267696E2D746F703A203870783B0D0A7D0D0A2E742D526567696F6E202E612D4D656E752D636F6E74656E74207B0D0A2020626F726465722D7261646975733A20';
wwv_flow_api.g_varchar2_table(649) := '3270783B0D0A7D0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E202E612D4D656E752D68536570617261746F72207B0D0A202062';
wwv_flow_api.g_varchar2_table(650) := '6F726465722D636F6C6F723A207267626128302C20302C20302C20302E3135293B0D0A7D0D0A2E742D526567696F6E202E612D4D656E752D2D63757272656E74207B0D0A20206261636B67726F756E642D636F6C6F723A20236266626662663B0D0A7D0D';
wwv_flow_api.g_varchar2_table(651) := '0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D64697361626C65642E69732D666F6375736564207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E';
wwv_flow_api.g_varchar2_table(652) := '202E612D4D656E75202E612D4D656E752D6974656D2E69732D64697361626C65642E69732D666F6375736564203E202E612D4D656E752D696E6E6572202E612D4D656E752D7375624D656E75436F6C207B0D0A2020636F6C6F723A20233430343034303B';
wwv_flow_api.g_varchar2_table(653) := '0D0A7D0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D64697361626C65642E69732D666F6375736564203E202E612D4D656E752D696E6E6572202E612D4D656E752D616363656C207B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(654) := '20233830383038303B0D0A7D0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D666F63757365642C0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564';
wwv_flow_api.g_varchar2_table(655) := '207B0D0A20206261636B67726F756E642D636F6C6F723A20236632663266323B0D0A2020636F6C6F723A20233333333333333B0D0A7D0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D666F6375736564203E20';
wwv_flow_api.g_varchar2_table(656) := '2E612D4D656E752D696E6E6572202E612D4D656E752D737461747573436F6C2C0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564203E202E612D4D656E752D696E6E6572202E612D4D656E75';
wwv_flow_api.g_varchar2_table(657) := '2D737461747573436F6C2C0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D666F6375736564203E202E612D4D656E752D696E6E6572202E612D4D656E752D7375624D656E75436F6C2C0D0A2E742D526567696F';
wwv_flow_api.g_varchar2_table(658) := '6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564203E202E612D4D656E752D696E6E6572202E612D4D656E752D7375624D656E75436F6C2C0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974';
wwv_flow_api.g_varchar2_table(659) := '656D2E69732D666F6375736564203E202E612D4D656E752D696E6E6572202E612D4D656E752D616363656C2C0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564203E202E612D4D656E752D69';
wwv_flow_api.g_varchar2_table(660) := '6E6E6572202E612D4D656E752D616363656C207B0D0A2020636F6C6F723A20233333333333333B0D0A7D0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D616363656C207B0D0A2020636F6C6F723A20726762612836342C2036342C';
wwv_flow_api.g_varchar2_table(661) := '2036342C20302E3735293B0D0A7D0D0A2E742D526567696F6E202E612D4D656E752D636F6E74656E74207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235352C203235352C203235352C20302E3935293B0D0A2020626F726465';
wwv_flow_api.g_varchar2_table(662) := '722D636F6C6F723A20236536653665363B0D0A2020626F782D736861646F773A20302031707820327078207267626128302C20302C20302C20302E3035293B0D0A7D0D0A0D0A2E742D486561646572207B0D0A20200D0A20200D0A20200D0A20200D0A20';
wwv_flow_api.g_varchar2_table(663) := '200D0A20200D0A7D0D0A2E742D486561646572202E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A20236664666466643B0D0A2020766572746963616C2D616C69676E3A20746F703B0D0A7D0D0A2E742D486561646572202E612D4D';
wwv_flow_api.g_varchar2_table(664) := '656E754261722D6974656D207B0D0A2020766572746963616C2D616C69676E3A20746F703B0D0A7D0D0A2E742D486561646572202E612D4D656E754261722D6974656D2E69732D666F63757365642C0D0A2E742D486561646572202E612D4D656E754261';
wwv_flow_api.g_varchar2_table(665) := '722D6974656D3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233034363462352021696D706F7274616E743B0D0A7D0D0A2E742D486561646572202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E';
wwv_flow_api.g_varchar2_table(666) := '742C0D0A2E742D486561646572202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69732D666F6375736564207B0D0A20206261636B67726F756E642D636F6C6F723A20233034363462352021696D706F7274616E743B0D';
wwv_flow_api.g_varchar2_table(667) := '0A7D0D0A2E742D486561646572202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E74202E612D4D656E754261722D6C6162656C2C0D0A2E742D486561646572202E612D4D656E754261722D6974656D2E612D4D656E752D2D63';
wwv_flow_api.g_varchar2_table(668) := '757272656E742E69732D666F6375736564202E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A20236664666466642021696D706F7274616E743B0D0A2020666F6E742D7765696768743A20626F6C643B0D0A7D0D0A2E742D48656164';
wwv_flow_api.g_varchar2_table(669) := '6572202E612D4D656E754261722D6974656D2E69732D657870616E6465642C0D0A2E742D486561646572202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69732D657870616E646564207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(670) := '6E642D636F6C6F723A20233034363462352021696D706F7274616E743B0D0A7D0D0A2E742D486561646572202E612D4D656E754261722D6974656D203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(671) := '2072676261283235332C203235332C203235332C20302E38293B0D0A2020626F726465722D636F6C6F723A20233035373263653B0D0A2020626F726465722D7261646975733A20313030253B0D0A7D0D0A2E742D486561646572202E612D4D656E754261';
wwv_flow_api.g_varchar2_table(672) := '722D6974656D2E612D4D656E752D2D63757272656E742E69732D666F6375736564203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E2C0D0A2E742D486561646572202E612D4D656E754261722D6974656D203E202E612D4D656E75';
wwv_flow_api.g_varchar2_table(673) := '2D7375624D656E75436F6C3A686F766572202E612D49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20233064386466393B0D0A2020626F726465722D636F6C6F723A20233064386466393B0D0A2020636F6C6F723A20236666666666';
wwv_flow_api.g_varchar2_table(674) := '663B0D0A7D0D0A2E742D486561646572202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E74203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A2020636F6C6F723A20233236393966613B0D0A';
wwv_flow_api.g_varchar2_table(675) := '2020626F726465722D636F6C6F723A20233236393966613B0D0A7D0D0A2E742D486561646572202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69732D657870616E646564203E202E612D4D656E752D7375624D656E75';
wwv_flow_api.g_varchar2_table(676) := '436F6C202E612D49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236664666466643B0D0A2020626F726465722D636F6C6F723A20236664666466643B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D48656164';
wwv_flow_api.g_varchar2_table(677) := '6572202E612D4D656E754261722D6974656D2E69732D657870616E646564203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20233761633166633B0D0A2020626F726465';
wwv_flow_api.g_varchar2_table(678) := '722D636F6C6F723A20233761633166633B0D0A2020636F6C6F723A20233032326435323B0D0A7D0D0A2E742D486561646572202E612D4D656E752D636F6E74656E74207B0D0A2020626F726465722D77696474683A20303B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(679) := '6E642D636F6C6F723A20233034363462353B0D0A7D0D0A2E742D486561646572202E612D4D656E75202E612D4D656E752D6974656D207B0D0A2020636F6C6F723A20236664666466643B0D0A7D0D0A2E742D486561646572202E612D4D656E752D616363';
wwv_flow_api.g_varchar2_table(680) := '656C207B0D0A2020636F6C6F723A2072676261283235332C203235332C203235332C20302E3735293B0D0A7D0D0A2E742D486561646572202E612D4D656E75202E612D4D656E752D6974656D2E69732D666F63757365642C0D0A2E742D48656164657220';
wwv_flow_api.g_varchar2_table(681) := '2E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564207B0D0A20206261636B67726F756E642D636F6C6F723A20233034353639632021696D706F7274616E743B0D0A7D0D0A2E742D426F6479207B0D0A20200D0A20200D0A20';
wwv_flow_api.g_varchar2_table(682) := '200D0A20200D0A20200D0A20200D0A7D0D0A2E742D426F6479202E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A20233365336533653B0D0A2020766572746963616C2D616C69676E3A20746F703B0D0A7D0D0A2E742D426F647920';
wwv_flow_api.g_varchar2_table(683) := '2E612D4D656E754261722D6974656D207B0D0A2020766572746963616C2D616C69676E3A20746F703B0D0A7D0D0A2E742D426F6479202E612D4D656E754261722D6974656D2E69732D666F63757365642C0D0A2E742D426F6479202E612D4D656E754261';
wwv_flow_api.g_varchar2_table(684) := '722D6974656D3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236534653465342021696D706F7274616E743B0D0A7D0D0A2E742D426F6479202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742C';
wwv_flow_api.g_varchar2_table(685) := '0D0A2E742D426F6479202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69732D666F6375736564207B0D0A20206261636B67726F756E642D636F6C6F723A20236534653465342021696D706F7274616E743B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(686) := '2E742D426F6479202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E74202E612D4D656E754261722D6C6162656C2C0D0A2E742D426F6479202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69';
wwv_flow_api.g_varchar2_table(687) := '732D666F6375736564202E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A20233365336533652021696D706F7274616E743B0D0A2020666F6E742D7765696768743A20626F6C643B0D0A7D0D0A2E742D426F6479202E612D4D656E75';
wwv_flow_api.g_varchar2_table(688) := '4261722D6974656D2E69732D657870616E6465642C0D0A2E742D426F6479202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69732D657870616E646564207B0D0A20206261636B67726F756E642D636F6C6F723A202365';
wwv_flow_api.g_varchar2_table(689) := '34653465342021696D706F7274616E743B0D0A7D0D0A2E742D426F6479202E612D4D656E754261722D6974656D203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A2020636F6C6F723A20726762612836322C2036322C20';
wwv_flow_api.g_varchar2_table(690) := '36322C20302E38293B0D0A2020626F726465722D636F6C6F723A20236666666666663B0D0A2020626F726465722D7261646975733A20313030253B0D0A7D0D0A2E742D426F6479202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272';
wwv_flow_api.g_varchar2_table(691) := '656E742E69732D666F6375736564203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E2C0D0A2E742D426F6479202E612D4D656E754261722D6974656D203E202E612D4D656E752D7375624D656E75436F6C3A686F766572202E612D';
wwv_flow_api.g_varchar2_table(692) := '49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236264626462643B0D0A2020626F726465722D636F6C6F723A20236264626462643B0D0A2020636F6C6F723A20233030303030303B0D0A7D0D0A2E742D426F6479202E612D4D656E';
wwv_flow_api.g_varchar2_table(693) := '754261722D6974656D2E612D4D656E752D2D63757272656E74203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A2020636F6C6F723A20236666666666663B0D0A2020626F726465722D636F6C6F723A2023666666666666';
wwv_flow_api.g_varchar2_table(694) := '3B0D0A7D0D0A2E742D426F6479202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69732D657870616E646564203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(695) := '6E642D636F6C6F723A20233365336533653B0D0A2020626F726465722D636F6C6F723A20233365336533653B0D0A2020636F6C6F723A20236664666466643B0D0A7D0D0A2E742D426F6479202E612D4D656E754261722D6974656D2E69732D657870616E';
wwv_flow_api.g_varchar2_table(696) := '646564203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020626F726465722D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(697) := '20236534653465343B0D0A7D0D0A2E742D426F6479202E612D4D656E752D636F6E74656E74207B0D0A2020626F726465722D77696474683A20303B0D0A20206261636B67726F756E642D636F6C6F723A20236534653465343B0D0A7D0D0A2E742D426F64';
wwv_flow_api.g_varchar2_table(698) := '79202E612D4D656E75202E612D4D656E752D6974656D207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D426F6479202E612D4D656E752D616363656C207B0D0A2020636F6C6F723A20726762612836322C2036322C2036322C2030';
wwv_flow_api.g_varchar2_table(699) := '2E3735293B0D0A7D0D0A2E742D426F6479202E612D4D656E75202E612D4D656E752D6974656D2E69732D666F63757365642C0D0A2E742D426F6479202E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564207B0D0A20206261';
wwv_flow_api.g_varchar2_table(700) := '636B67726F756E642D636F6C6F723A20236630663066302021696D706F7274616E743B0D0A7D0D0A2E742D426F6479202E612D4D656E75426172203E20756C207B0D0A20206261636B67726F756E642D636F6C6F723A20236536653665363B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(701) := '2E742D426F6479202E612D4D656E754261722D6974656D207B0D0A2020626F726465722D636F6C6F723A20236534653465343B0D0A7D0D0A2E742D426F6479202E612D4D656E754261722D6974656D2E69732D666F6375736564207B0D0A2020626F782D';
wwv_flow_api.g_varchar2_table(702) := '736861646F773A206E6F6E653B0D0A7D0D0A2E742D526567696F6E207B0D0A20200D0A20200D0A20200D0A20200D0A20200D0A20200D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A20233430';
wwv_flow_api.g_varchar2_table(703) := '343034303B0D0A2020766572746963616C2D616C69676E3A20746F703B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D207B0D0A2020766572746963616C2D616C69676E3A20746F703B0D0A7D0D0A2E742D526567696F6E20';
wwv_flow_api.g_varchar2_table(704) := '2E612D4D656E754261722D6974656D2E69732D666F63757365642C0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236536653665362021696D706F727461';
wwv_flow_api.g_varchar2_table(705) := '6E743B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742C0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69732D666F63';
wwv_flow_api.g_varchar2_table(706) := '75736564207B0D0A20206261636B67726F756E642D636F6C6F723A20236536653665362021696D706F7274616E743B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E74202E612D4D656E';
wwv_flow_api.g_varchar2_table(707) := '754261722D6C6162656C2C0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69732D666F6375736564202E612D4D656E754261722D6C6162656C207B0D0A2020636F6C6F723A202334303430';
wwv_flow_api.g_varchar2_table(708) := '34302021696D706F7274616E743B0D0A2020666F6E742D7765696768743A20626F6C643B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E69732D657870616E6465642C0D0A2E742D526567696F6E202E612D4D656E754261';
wwv_flow_api.g_varchar2_table(709) := '722D6974656D2E612D4D656E752D2D63757272656E742E69732D657870616E646564207B0D0A20206261636B67726F756E642D636F6C6F723A20236536653665362021696D706F7274616E743B0D0A7D0D0A2E742D526567696F6E202E612D4D656E7542';
wwv_flow_api.g_varchar2_table(710) := '61722D6974656D203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A2020636F6C6F723A20726762612836342C2036342C2036342C20302E38293B0D0A2020626F726465722D636F6C6F723A20236666666666663B0D0A20';
wwv_flow_api.g_varchar2_table(711) := '20626F726465722D7261646975733A20313030253B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E742E69732D666F6375736564203E202E612D4D656E752D7375624D656E75436F6C20';
wwv_flow_api.g_varchar2_table(712) := '2E612D49636F6E2C0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D203E202E612D4D656E752D7375624D656E75436F6C3A686F766572202E612D49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236266626662';
wwv_flow_api.g_varchar2_table(713) := '663B0D0A2020626F726465722D636F6C6F723A20236266626662663B0D0A2020636F6C6F723A20233030303030303B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E612D4D656E752D2D63757272656E74203E202E612D4D';
wwv_flow_api.g_varchar2_table(714) := '656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A2020636F6C6F723A20236666666666663B0D0A2020626F726465722D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E';
wwv_flow_api.g_varchar2_table(715) := '612D4D656E752D2D63757272656E742E69732D657870616E646564203E202E612D4D656E752D7375624D656E75436F6C202E612D49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20233430343034303B0D0A2020626F726465722D63';
wwv_flow_api.g_varchar2_table(716) := '6F6C6F723A20233430343034303B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E69732D657870616E646564203E202E612D4D656E752D7375624D656E75436F6C202E612D';
wwv_flow_api.g_varchar2_table(717) := '49636F6E207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020626F726465722D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20236536653665363B0D0A7D0D0A2E742D526567696F6E202E612D4D';
wwv_flow_api.g_varchar2_table(718) := '656E752D636F6E74656E74207B0D0A2020626F726465722D77696474683A20303B0D0A20206261636B67726F756E642D636F6C6F723A20236536653665363B0D0A7D0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D207B';
wwv_flow_api.g_varchar2_table(719) := '0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E202E612D4D656E752D616363656C207B0D0A2020636F6C6F723A20726762612836342C2036342C2036342C20302E3735293B0D0A7D0D0A2E742D526567696F6E202E61';
wwv_flow_api.g_varchar2_table(720) := '2D4D656E75202E612D4D656E752D6974656D2E69732D666F63757365642C0D0A2E742D526567696F6E202E612D4D656E75202E612D4D656E752D6974656D2E69732D657870616E646564207B0D0A20206261636B67726F756E642D636F6C6F723A202366';
wwv_flow_api.g_varchar2_table(721) := '32663266322021696D706F7274616E743B0D0A7D0D0A2E742D526567696F6E202E612D4D656E75426172203E20756C207B0D0A20206261636B67726F756E642D636F6C6F723A20236536653665363B0D0A7D0D0A2E742D526567696F6E202E612D4D656E';
wwv_flow_api.g_varchar2_table(722) := '754261722D6974656D207B0D0A2020626F726465722D636F6C6F723A20236536653665363B0D0A7D0D0A2E742D526567696F6E202E612D4D656E754261722D6974656D2E69732D666F6375736564207B0D0A2020626F782D736861646F773A206E6F6E65';
wwv_flow_api.g_varchar2_table(723) := '3B0D0A7D0D0A2E742D4865616465722D757365724D656E75202E612D4D656E752D636F6E74656E74207B0D0A2020626F726465722D77696474683A20303B0D0A20206261636B67726F756E642D636F6C6F723A20233438353135383B0D0A7D0D0A2E742D';
wwv_flow_api.g_varchar2_table(724) := '4865616465722D757365724D656E75202E612D4D656E752D6974656D2E69732D666F63757365642C0D0A2E742D4865616465722D757365724D656E75202E612D4D656E752D6974656D2E69732D657870616E646564207B0D0A20206261636B67726F756E';
wwv_flow_api.g_varchar2_table(725) := '642D636F6C6F723A20233363343434612021696D706F7274616E743B0D0A7D0D0A2E742D4865616465722D757365724D656E752E612D4D656E75202E612D4D656E752D6974656D202E612D4D656E752D6C6162656C207B0D0A2020636F6C6F723A202366';
wwv_flow_api.g_varchar2_table(726) := '66666666663B0D0A7D0D0A2E742D4E617654616273207B0D0A20206261636B67726F756E642D636F6C6F723A20233331333733633B0D0A7D0D0A2E742D4E6176546162733A3A2D7765626B69742D7363726F6C6C6261722D7468756D62207B0D0A202062';
wwv_flow_api.g_varchar2_table(727) := '61636B67726F756E642D636F6C6F723A20233231323532383B0D0A2020626F782D736861646F773A20696E7365742031707820302030203020233331333733633B0D0A7D0D0A2E742D4E6176546162733A3A2D7765626B69742D7363726F6C6C6261722D';
wwv_flow_api.g_varchar2_table(728) := '7468756D623A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233363343434613B0D0A7D0D0A2E742D4E6176546162733A3A2D7765626B69742D7363726F6C6C6261722D747261636B207B0D0A20206261636B67726F756E643A';
wwv_flow_api.g_varchar2_table(729) := '20233331333733633B0D0A7D0D0A2E742D4E6176546162733A3A2D7765626B69742D7363726F6C6C6261722D747261636B3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233533356536363B0D0A7D0D0A2E742D4E61765461';
wwv_flow_api.g_varchar2_table(730) := '62732D6974656D207B0D0A2020636F6C6F723A20236666666666663B0D0A2020626F726465722D636F6C6F723A20233363343434613B0D0A7D0D0A2E742D4E6176546162732D6974656D3A686F7665722C0D0A2E742D4E6176546162732D6974656D2E69';
wwv_flow_api.g_varchar2_table(731) := '732D616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A20233161316432303B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D4E6176546162732D6261646765207B0D0A20206261636B67726F756E642D636F6C';
wwv_flow_api.g_varchar2_table(732) := '6F723A20236666666666663B0D0A2020636F6C6F723A20233161316432303B0D0A7D0D0A0D0A2E742D4E617669676174696F6E4261722D6D656E75202E612D4D656E752D636F6E74656E74207B0D0A2020626F726465722D7261646975733A2030203020';
wwv_flow_api.g_varchar2_table(733) := '327078203270783B0D0A20206261636B67726F756E642D636F6C6F723A20233033343938333B0D0A2020626F726465722D77696474683A20303B0D0A7D0D0A2E742D4E617669676174696F6E4261722D6D656E75202E612D4D656E752D6974656D2E6973';
wwv_flow_api.g_varchar2_table(734) := '2D666F63757365642C0D0A2E742D4E617669676174696F6E4261722D6D656E75202E612D4D656E752D6974656D2E69732D657870616E646564207B0D0A20206261636B67726F756E642D636F6C6F723A20233034363462352021696D706F7274616E743B';
wwv_flow_api.g_varchar2_table(735) := '0D0A7D0D0A2E742D4E617669676174696F6E4261722D6D656E75202E612D4D656E752D6974656D2E69732D666F6375736564203E202E612D4D656E752D6C6162656C2C0D0A2E742D4E617669676174696F6E4261722D6D656E75202E612D4D656E752D69';
wwv_flow_api.g_varchar2_table(736) := '74656D2E69732D657870616E646564203E202E612D4D656E752D6C6162656C207B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E742D4E617669676174696F6E4261722D6D656E75202E612D4D656E752D6974';
wwv_flow_api.g_varchar2_table(737) := '656D202E612D4D656E752D6C6162656C2C0D0A2E742D4E617669676174696F6E4261722D6D656E752E612D4D656E75202E612D4D656E752D6974656D20612C0D0A2E742D4E617669676174696F6E4261722D6D656E752E612D4D656E75202E612D4D656E';
wwv_flow_api.g_varchar2_table(738) := '752D6974656D202E612D4D656E752D737461747573436F6C207B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A0D0A2E742D506F7075704C4F562D6C696E6B7320613A686F766572207B0D0A20206261636B6772';
wwv_flow_api.g_varchar2_table(739) := '6F756E642D636F6C6F723A20233035366162663B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D506F7075704C4F562D726573756C74735365742074723A686F766572207464207B0D0A20206261636B67726F756E642D636F6C6F72';
wwv_flow_api.g_varchar2_table(740) := '3A20234543463246422021696D706F7274616E743B0D0A7D0D0A2E742D506F7075704C4F562D726573756C74735365742074723A6E74682D6368696C6428326E29207464207B0D0A20206261636B67726F756E642D636F6C6F723A20234641464146413B';
wwv_flow_api.g_varchar2_table(741) := '0D0A7D0D0A2E742D506F7075704C4F562D726573756C74735365742D6C696E6B2C0D0A2E75692D7769646765742D636F6E74656E7420612E742D506F7075704C4F562D726573756C74735365742D6C696E6B207B0D0A2020636F6C6F723A202330353661';
wwv_flow_api.g_varchar2_table(742) := '62663B0D0A7D0D0A2E742D506167652D2D706F7075704C4F56207B0D0A20206261636B67726F756E642D636F6C6F723A20234646463B0D0A7D0D0A2E742D506F7075704C4F562D616374696F6E73207B0D0A20206261636B67726F756E642D636F6C6F72';
wwv_flow_api.g_varchar2_table(743) := '3A20236664666466643B0D0A7D0D0A2E742D426F6479202E742D506F7075704C4F562D6C696E6B732061207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D426F64792D7469746C65202E742D506F7075704C4F562D6C696E6B7320';
wwv_flow_api.g_varchar2_table(744) := '61207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D426F64792D696E666F202E742D506F7075704C4F562D6C696E6B732061207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E202E742D506F';
wwv_flow_api.g_varchar2_table(745) := '7075704C4F562D6C696E6B7320612C0D0A2E742D427574746F6E526567696F6E202E742D506F7075704C4F562D6C696E6B732061207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D506F7075704C4F562D6C696E6B7320613A686F';
wwv_flow_api.g_varchar2_table(746) := '766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233036383566313B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D426F6479202E742D506F7075704C4F562D706167696E6174696F6E207B0D0A2020636F6C6F72';
wwv_flow_api.g_varchar2_table(747) := '3A20233765376537653B0D0A7D0D0A2E742D426F64792D7469746C65202E742D506F7075704C4F562D706167696E6174696F6E207B0D0A2020636F6C6F723A20233830383038303B0D0A7D0D0A2E742D426F64792D696E666F202E742D506F7075704C4F';
wwv_flow_api.g_varchar2_table(748) := '562D706167696E6174696F6E207B0D0A2020636F6C6F723A20233830383038303B0D0A7D0D0A2E742D526567696F6E202E742D506F7075704C4F562D706167696E6174696F6E2C0D0A2E742D427574746F6E526567696F6E202E742D506F7075704C4F56';
wwv_flow_api.g_varchar2_table(749) := '2D706167696E6174696F6E207B0D0A2020636F6C6F723A20233830383038303B0D0A7D0D0A0D0A2E742D526567696F6E2C0D0A2E742D436F6E74656E74426C6F636B2D2D6C696768744247202E742D436F6E74656E74426C6F636B2D626F6479207B0D0A';
wwv_flow_api.g_varchar2_table(750) := '20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D426F6479202E6669656C64646174612062207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D426F64792D7469746C65202E6669656C6464';
wwv_flow_api.g_varchar2_table(751) := '6174612062207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D426F64792D696E666F202E6669656C64646174612062207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E202E6669656C646461';
wwv_flow_api.g_varchar2_table(752) := '746120622C0D0A2E742D427574746F6E526567696F6E202E6669656C64646174612062207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A';
wwv_flow_api.g_varchar2_table(753) := '20236666666666663B0D0A2020636F6C6F723A20233236323632363B0D0A7D0D0A2E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B';
wwv_flow_api.g_varchar2_table(754) := '207B0D0A2020636F6C6F723A20233236323632363B0D0A7D0D0A2E742D426F64792D616374696F6E73202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E643A207472616E73706172656E743B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(755) := '3361336133613B0D0A7D0D0A2E742D526567696F6E2D2D737461636B6564207B0D0A2020626F726465722D7261646975733A20302021696D706F7274616E743B0D0A7D0D0A2E742D526567696F6E2D2D6E6F426F72646572203E202E742D526567696F6E';
wwv_flow_api.g_varchar2_table(756) := '2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E2D2D6E6F426F72646572203E202E742D526567696F6E2D6865616465';
wwv_flow_api.g_varchar2_table(757) := '72202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D6E6F426F72646572203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(758) := '0D0A2E742D526567696F6E2D2D616363656E7431203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20233330396664623B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D5265';
wwv_flow_api.g_varchar2_table(759) := '67696F6E2D2D616363656E7431203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E7431203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D';
wwv_flow_api.g_varchar2_table(760) := '6C696E6B207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E74312E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F72';
wwv_flow_api.g_varchar2_table(761) := '3A20233330396664623B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E7432203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20233133623663663B0D0A2020636F6C6F723A20236534';
wwv_flow_api.g_varchar2_table(762) := '663966643B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7432203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E7432203E202E742D526567696F6E2D686561';
wwv_flow_api.g_varchar2_table(763) := '646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20236534663966643B0D0A7D0D0A2E742D526567696F6E2D2D616363656E74322E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D6865';
wwv_flow_api.g_varchar2_table(764) := '61646572207B0D0A2020636F6C6F723A20233133623663663B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E7433203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A2023326562666263';
wwv_flow_api.g_varchar2_table(765) := '3B0D0A2020636F6C6F723A20236630666366623B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7433203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E743320';
wwv_flow_api.g_varchar2_table(766) := '3E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20236630666366623B0D0A7D0D0A2E742D526567696F6E2D2D616363656E74332E742D526567696F6E2D2D74657874436F6E74656E74';
wwv_flow_api.g_varchar2_table(767) := '203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A20233265626662633B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E7434203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E64';
wwv_flow_api.g_varchar2_table(768) := '2D636F6C6F723A20233363616638353B0D0A2020636F6C6F723A20236630666166363B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7434203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D52';
wwv_flow_api.g_varchar2_table(769) := '6567696F6E2D2D616363656E7434203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20236630666166363B0D0A7D0D0A2E742D526567696F6E2D2D616363656E74342E742D52656769';
wwv_flow_api.g_varchar2_table(770) := '6F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A20233363616638353B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E7435203E202E742D526567696F6E2D68656164657220';
wwv_flow_api.g_varchar2_table(771) := '7B0D0A20206261636B67726F756E642D636F6C6F723A20233831626235663B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7435203E202E742D526567696F6E2D686561646572202E742D42757474';
wwv_flow_api.g_varchar2_table(772) := '6F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E7435203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D';
wwv_flow_api.g_varchar2_table(773) := '2D616363656E74352E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A20233831626235663B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E7436203E202E74';
wwv_flow_api.g_varchar2_table(774) := '2D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20236464646535333B0D0A2020636F6C6F723A20233261326130383B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7436203E202E742D526567696F6E';
wwv_flow_api.g_varchar2_table(775) := '2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E7436203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20233261326130383B';
wwv_flow_api.g_varchar2_table(776) := '0D0A7D0D0A2E742D526567696F6E2D2D616363656E74362E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A20236464646535333B0D0A7D0D0A0D0A2E742D526567696F';
wwv_flow_api.g_varchar2_table(777) := '6E2D2D616363656E7437203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20236662636534613B0D0A2020636F6C6F723A20233434333330323B0D0A7D0D0A2E742D526567696F6E2D2D61636365';
wwv_flow_api.g_varchar2_table(778) := '6E7437203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E7437203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020';
wwv_flow_api.g_varchar2_table(779) := '636F6C6F723A20233434333330323B0D0A7D0D0A2E742D526567696F6E2D2D616363656E74372E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A20236662636534613B';
wwv_flow_api.g_varchar2_table(780) := '0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E7438203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20236564383133653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(781) := '2E742D526567696F6E2D2D616363656E7438203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E7438203E202E742D526567696F6E2D686561646572202E742D427574';
wwv_flow_api.g_varchar2_table(782) := '746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E74382E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020';
wwv_flow_api.g_varchar2_table(783) := '636F6C6F723A20236564383133653B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E7439203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20236539356235343B0D0A2020636F6C6F72';
wwv_flow_api.g_varchar2_table(784) := '3A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7439203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E7439203E202E742D526567696F';
wwv_flow_api.g_varchar2_table(785) := '6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E74392E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D52656769';
wwv_flow_api.g_varchar2_table(786) := '6F6E2D686561646572207B0D0A2020636F6C6F723A20236539356235343B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E743130203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(787) := '6538356438383B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E743130203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D61';
wwv_flow_api.g_varchar2_table(788) := '6363656E743130203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7431302E742D526567696F6E2D2D7465';
wwv_flow_api.g_varchar2_table(789) := '7874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A20236538356438383B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E743131203E202E742D526567696F6E2D686561646572207B0D0A2020';
wwv_flow_api.g_varchar2_table(790) := '6261636B67726F756E642D636F6C6F723A20236361353839643B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E743131203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D';
wwv_flow_api.g_varchar2_table(791) := '6E6F55492C0D0A2E742D526567696F6E2D2D616363656E743131203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D6163';
wwv_flow_api.g_varchar2_table(792) := '63656E7431312E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A20236361353839643B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E743132203E202E742D';
wwv_flow_api.g_varchar2_table(793) := '526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20233835346539623B0D0A2020636F6C6F723A20236636663066383B0D0A7D0D0A2E742D526567696F6E2D2D616363656E743132203E202E742D526567696F6E';
wwv_flow_api.g_varchar2_table(794) := '2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E743132203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A2023663666306638';
wwv_flow_api.g_varchar2_table(795) := '3B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7431322E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A20233835346539623B0D0A7D0D0A0D0A2E742D526567';
wwv_flow_api.g_varchar2_table(796) := '696F6E2D2D616363656E743133203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20233561363861643B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D61';
wwv_flow_api.g_varchar2_table(797) := '6363656E743133203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E743133203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B20';
wwv_flow_api.g_varchar2_table(798) := '7B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7431332E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A202335';
wwv_flow_api.g_varchar2_table(799) := '61363861643B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E743134203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20236166626163353B0D0A2020636F6C6F723A20233331336134';
wwv_flow_api.g_varchar2_table(800) := '343B0D0A7D0D0A2E742D526567696F6E2D2D616363656E743134203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E743134203E202E742D526567696F6E2D68656164';
wwv_flow_api.g_varchar2_table(801) := '6572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20233331336134343B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7431342E742D526567696F6E2D2D74657874436F6E74656E74203E202E742D526567696F6E2D6865';
wwv_flow_api.g_varchar2_table(802) := '61646572207B0D0A2020636F6C6F723A20236166626163353B0D0A7D0D0A0D0A2E742D526567696F6E2D2D616363656E743135203E202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A20233665383539';
wwv_flow_api.g_varchar2_table(803) := '383B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E743135203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6E6F55492C0D0A2E742D526567696F6E2D2D616363656E74';
wwv_flow_api.g_varchar2_table(804) := '3135203E202E742D526567696F6E2D686561646572202E742D427574746F6E2D2D6C696E6B207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E2D2D616363656E7431352E742D526567696F6E2D2D74657874436F6E';
wwv_flow_api.g_varchar2_table(805) := '74656E74203E202E742D526567696F6E2D686561646572207B0D0A2020636F6C6F723A20233665383539383B0D0A7D0D0A2E742D526567696F6E2D626F6479207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E2D2D';
wwv_flow_api.g_varchar2_table(806) := '6869646553686F772E69732D636F6C6C6170736564207B0D0A2020626F726465722D626F74746F6D2D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D426F64792D616374696F6E73202E742D526567696F6E207B0D0A20206261636B';
wwv_flow_api.g_varchar2_table(807) := '67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D426F64792D616374696F6E73202E742D526567696F6E2D686561646572207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D';
wwv_flow_api.g_varchar2_table(808) := '0A7D0D0A2E742D426F64792D73696465202E742D526567696F6E207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D526567696F6E2C0D0A2E742D526567696F6E2D686561646572207B0D0A20';
wwv_flow_api.g_varchar2_table(809) := '20626F726465722D7261646975733A203270783B0D0A7D0D0A2E742D526567696F6E2D2D6E6F4247207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D426F64792D616374696F6E73202E742D';
wwv_flow_api.g_varchar2_table(810) := '526567696F6E207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D526567696F6E2D2D6361726F7573656C202E612D546162732D627574746F6E207B0D0A20206261636B67726F756E642D636F';
wwv_flow_api.g_varchar2_table(811) := '6C6F723A207472616E73706172656E743B0D0A2020626F726465722D7261646975733A203270783B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3235293B0D0A2020636F6C6F723A20234646463B0D0A';
wwv_flow_api.g_varchar2_table(812) := '7D0D0A2E742D526567696F6E2D2D6361726F7573656C202E612D546162732D627574746F6E3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E35293B0D0A7D0D0A2E742D526567696F6E';
wwv_flow_api.g_varchar2_table(813) := '2D2D6361726F7573656C202E612D546162732D627574746F6E3A6163746976652C0D0A2E742D526567696F6E2D2D6361726F7573656C202E612D546162732D627574746F6E3A6163746976653A666F637573207B0D0A20206261636B67726F756E642D63';
wwv_flow_api.g_varchar2_table(814) := '6F6C6F723A207267626128302C20302C20302C20302E3735293B0D0A7D0D0A2E742D526567696F6E2D2D6361726F7573656C202E612D546162732D6E6578742D726567696F6E207B0D0A2020626F726465722D7261646975733A20327078203020302032';
wwv_flow_api.g_varchar2_table(815) := '70783B0D0A7D0D0A2E742D526567696F6E2D2D6361726F7573656C202E612D546162732D70726576696F75732D726567696F6E207B0D0A2020626F726465722D7261646975733A2030203270782032707820303B0D0A7D0D0A2E742D526567696F6E2D2D';
wwv_flow_api.g_varchar2_table(816) := '6361726F7573656C202E612D526567696F6E2D6361726F7573656C4E61764974656D2E612D546162732D73656C6563746564202E612D526567696F6E2D6361726F7573656C4C696E6B207B0D0A20206261636B67726F756E642D636F6C6F723A20726762';
wwv_flow_api.g_varchar2_table(817) := '6128302C20302C20302C20302E3435293B0D0A7D0D0A2E742D526567696F6E2D2D6361726F7573656C202E612D526567696F6E2D6361726F7573656C4E61764974656D2E612D546162732D73656C6563746564202E612D526567696F6E2D6361726F7573';
wwv_flow_api.g_varchar2_table(818) := '656C4C696E6B3A666F637573207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A7D0D0A2E742D526567696F6E2D2D6361726F7573656C202E612D526567696F6E2D6361726F7573656C4C696E6B207B0D0A2020626163';
wwv_flow_api.g_varchar2_table(819) := '6B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3135293B0D0A2020626F726465722D7261646975733A20313030253B0D0A7D0D0A0D0A2E742D5265706F72742D63656C6C2C0D0A2E742D5265706F72742D636F6C48656164';
wwv_flow_api.g_varchar2_table(820) := '207B0D0A2020626F726465723A2031707820736F6C696420236536653665363B0D0A7D0D0A2E742D5265706F72742D7265706F7274207472202E742D5265706F72742D63656C6C3A6C6173742D6368696C642C0D0A2E742D5265706F72742D7265706F72';
wwv_flow_api.g_varchar2_table(821) := '74207472202E742D5265706F72742D636F6C486561643A6C6173742D6368696C64207B0D0A2020626F726465722D72696768743A2031707820736F6C696420236536653665363B0D0A7D0D0A2E742D5265706F72742D7265706F72742074723A6C617374';
wwv_flow_api.g_varchar2_table(822) := '2D6368696C64202E742D5265706F72742D63656C6C207B0D0A2020626F726465722D626F74746F6D3A2031707820736F6C696420236536653665363B0D0A7D0D0A2E742D5265706F7274202E69732D737475636B202E742D5265706F72742D636F6C4865';
wwv_flow_api.g_varchar2_table(823) := '6164207B0D0A20206261636B67726F756E642D636F6C6F723A2072676261283235352C203235352C203235352C20302E3935293B0D0A20202D7765626B69742D6261636B64726F702D66696C7465723A20626C757228347078293B0D0A7D0D0A2E742D52';
wwv_flow_api.g_varchar2_table(824) := '65706F72742D2D726F77486967686C69676874202E742D5265706F72742D7265706F72742074723A686F766572202E742D5265706F72742D63656C6C2C0D0A2E742D5265706F72742D2D726F77486967686C69676874202E742D5265706F72742D726570';
wwv_flow_api.g_varchar2_table(825) := '6F72742074723A6E74682D6368696C64286F6464293A686F766572202E742D5265706F72742D63656C6C207B0D0A20206261636B67726F756E642D636F6C6F723A20236661666166612021696D706F7274616E743B0D0A7D0D0A2E742D5265706F72742D';
wwv_flow_api.g_varchar2_table(826) := '2D737461746963526F77436F6C6F7273202E742D5265706F72742D7265706F72742074723A6E74682D6368696C64286F646429202E742D5265706F72742D63656C6C207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E';
wwv_flow_api.g_varchar2_table(827) := '743B0D0A7D0D0A0D0A2E742D5265706F72742D2D616C74526F777344656661756C74202E742D5265706F72742D7265706F72742074723A6E74682D6368696C64286F646429202E742D5265706F72742D63656C6C207B0D0A20206261636B67726F756E64';
wwv_flow_api.g_varchar2_table(828) := '2D636F6C6F723A20236663666366633B0D0A7D0D0A0D0A2E742D5265706F72742D706167696E6174696F6E5465787420622C0D0A2E742D5265706F72742D706167696E6174696F6E5465787420613A686F766572207B0D0A20206261636B67726F756E64';
wwv_flow_api.g_varchar2_table(829) := '2D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D536561726368526573756C74732D64657363207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D53656172636852657375';
wwv_flow_api.g_varchar2_table(830) := '6C74732D64617465207B0D0A2020636F6C6F723A20233731373137313B0D0A7D0D0A2E742D536561726368526573756C74732D6D697363207B0D0A2020636F6C6F723A20233731373137313B0D0A7D0D0A2E742D526567696F6E202E742D536561726368';
wwv_flow_api.g_varchar2_table(831) := '526573756C74732D64657363207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E202E742D536561726368526573756C74732D64617465207B0D0A2020636F6C6F723A20233733373337333B0D0A7D0D0A2E742D5265';
wwv_flow_api.g_varchar2_table(832) := '67696F6E202E742D536561726368526573756C74732D6D697363207B0D0A2020636F6C6F723A20233733373337333B0D0A7D0D0A2E742D5374617475734C6973742D626C6F636B486561646572207B0D0A2020636F6C6F723A20233430343034303B0D0A';
wwv_flow_api.g_varchar2_table(833) := '20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D5374617475734C6973742D68656164657254657874416C742C0D0A2E742D5374617475734C6973742D617474722C0D0A2E742D5374617475734C6973742D7465';
wwv_flow_api.g_varchar2_table(834) := '787444657363207B0D0A2020636F6C6F723A20233733373337333B0D0A7D0D0A2E742D5374617475734C6973742D6974656D5469746C65207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D5374617475734C6973742D2D64617465';
wwv_flow_api.g_varchar2_table(835) := '73202E742D5374617475734C6973742D6D61726B6572207B0D0A2020636F6C6F723A20233730373037303B0D0A2020626F726465722D7261646975733A203270783B0D0A20206261636B67726F756E642D636F6C6F723A20234646463B0D0A7D0D0A2E74';
wwv_flow_api.g_varchar2_table(836) := '2D5374617475734C6973742D2D6461746573202E742D5374617475734C6973742D6D61726B65723A6166746572207B0D0A20206261636B67726F756E642D636F6C6F723A20234130413041303B0D0A2020626F726465722D7261646975733A2032707820';
wwv_flow_api.g_varchar2_table(837) := '327078203020303B0D0A7D0D0A2E742D5374617475734C6973742D2D62756C6C657473202E742D5374617475734C6973742D6D61726B6572207B0D0A2020626F726465722D7261646975733A20323470783B0D0A20206261636B67726F756E642D636F6C';
wwv_flow_api.g_varchar2_table(838) := '6F723A20236666663B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D5374617475734C6973742D2D62756C6C657473202E742D5374617475734C6973742D6974656D2E69732D636F6D706C657465202E742D5374617475734C697374';
wwv_flow_api.g_varchar2_table(839) := '2D6D61726B6572207B0D0A20206261636B67726F756E642D636F6C6F723A20233730373037303B0D0A7D0D0A2E742D5374617475734C6973742D2D62756C6C657473202E742D5374617475734C6973742D6974656D2E69732D64616E676572202E742D53';
wwv_flow_api.g_varchar2_table(840) := '74617475734C6973742D6D61726B65722C0D0A2E742D5374617475734C6973742D2D62756C6C657473202E742D5374617475734C6973742D6974656D2E69732D6572726F72202E742D5374617475734C6973742D6D61726B6572207B0D0A20206261636B';
wwv_flow_api.g_varchar2_table(841) := '67726F756E642D636F6C6F723A20236666336233303B0D0A7D0D0A2E742D5374617475734C6973742D2D62756C6C657473202E742D5374617475734C6973742D6974656D2E69732D6F70656E202E742D5374617475734C6973742D6D61726B6572207B0D';
wwv_flow_api.g_varchar2_table(842) := '0A20206261636B67726F756E642D636F6C6F723A20233463643936343B0D0A7D0D0A2E742D5374617475734C6973742D2D62756C6C657473202E742D5374617475734C6973742D6974656D2E69732D7761726E696E67202E742D5374617475734C697374';
wwv_flow_api.g_varchar2_table(843) := '2D6D61726B6572207B0D0A20206261636B67726F756E642D636F6C6F723A20236666636330303B0D0A7D0D0A2E742D5374617475734C6973742D2D62756C6C657473202E742D5374617475734C6973742D6974656D2E69732D6E756C6C202E742D537461';
wwv_flow_api.g_varchar2_table(844) := '7475734C6973742D6D61726B6572207B0D0A20206261636B67726F756E642D636F6C6F723A20234630463046303B0D0A7D0D0A2E742D5374617475734C6973742D2D62756C6C657473202E742D5374617475734C6973742D6974656D2E69732D6E756C6C';
wwv_flow_api.g_varchar2_table(845) := '202E742D5374617475734C6973742D6D61726B6572207B0D0A2020636F6C6F723A20234130413041303B0D0A7D0D0A0D0A2E742D546162732D2D73696D706C65202E742D546162732D6974656D2E69732D616374697665202E742D546162732D6C696E6B';
wwv_flow_api.g_varchar2_table(846) := '207B0D0A2020626F782D736861646F773A2030202D3270782030202330353732636520696E7365743B0D0A7D0D0A2E742D546162732D2D73696D706C65202E742D546162732D6C696E6B3A666F637573207B0D0A2020626F782D736861646F773A203020';
wwv_flow_api.g_varchar2_table(847) := '30203020317078202330353732636520696E7365743B0D0A7D0D0A2E742D546162732D2D70696C6C207B0D0A20206261636B67726F756E642D636F6C6F723A20236639663966393B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(848) := '2E742D546162732D2D70696C6C202E742D49636F6E207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D546162732D2D70696C6C202E742D546162732D6C696E6B207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E';
wwv_flow_api.g_varchar2_table(849) := '742D546162732D2D70696C6C202E742D546162732D6C696E6B3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D546162732D2D70696C6C202E742D546162732D6C696E6B3A666F637573';
wwv_flow_api.g_varchar2_table(850) := '207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A7D0D0A2E742D546162732D2D70696C6C202E742D546162732D6C696E6B3A616374697665207B0D0A20206261636B67726F756E642D636F6C';
wwv_flow_api.g_varchar2_table(851) := '6F723A20236666666666663B0D0A7D0D0A2E742D546162732D2D70696C6C202E742D546162732D6974656D3A66697273742D6368696C64202E742D546162732D6C696E6B207B0D0A2020626F726465722D7261646975733A203270782030203020327078';
wwv_flow_api.g_varchar2_table(852) := '3B0D0A7D0D0A2E742D546162732D2D70696C6C202E742D546162732D6974656D2E69732D616374697665202E742D546162732D6C696E6B207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D546162732D';
wwv_flow_api.g_varchar2_table(853) := '2D73696D706C65202E742D49636F6E207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D546162732D2D73696D706C65202E742D546162732D6C696E6B207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D5461';
wwv_flow_api.g_varchar2_table(854) := '62732D2D73696D706C65202E742D546162732D6C696E6B3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E303235293B0D0A7D0D0A2E742D546162732D2D73696D706C65202E742D5461';
wwv_flow_api.g_varchar2_table(855) := '62732D6C696E6B3A616374697665207B0D0A20206261636B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E3135293B0D0A7D0D0A2E742D426F6479202E742D546162732D2D73696D706C65202E742D546162732D6C696E6B20';
wwv_flow_api.g_varchar2_table(856) := '7B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D426F64792D7469746C65202E742D546162732D2D73696D706C65202E742D546162732D6C696E6B207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D52656769';
wwv_flow_api.g_varchar2_table(857) := '6F6E202E742D546162732D2D73696D706C65202E742D546162732D6C696E6B207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A0D0A2E617065782D726473202E617065782D7264732D73656C6563746564207370616E207B0D0A2020626F';
wwv_flow_api.g_varchar2_table(858) := '782D736861646F773A2030202D3270782030202330353732636520696E7365743B0D0A7D0D0A2E617065782D72647320613A666F637573207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A7D';
wwv_flow_api.g_varchar2_table(859) := '0D0A2E617065782D7264732061207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D426F64792D7469746C65202E617065782D7264732061207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E20';
wwv_flow_api.g_varchar2_table(860) := '2E617065782D7264732061207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E617065782D72647320613A686F766572207B0D0A2020636F6C6F723A20233035366162663B0D0A7D0D0A2E617065782D726473202E617065782D7264732D';
wwv_flow_api.g_varchar2_table(861) := '73656C65637465642061207B0D0A2020636F6C6F723A20233035366162663B0D0A7D0D0A2E617065782D7264732D686F7665722E6C6566742061207B0D0A20206261636B67726F756E643A202D7765626B69742D6C696E6561722D6772616469656E7428';
wwv_flow_api.g_varchar2_table(862) := '6C6566742C2023666666666666203530252C2072676261283235352C203235352C203235352C2030292031303025293B0D0A20200D0A20206261636B67726F756E643A206C696E6561722D6772616469656E7428746F2072696768742C20236666666666';
wwv_flow_api.g_varchar2_table(863) := '66203530252C2072676261283235352C203235352C203235352C2030292031303025293B0D0A20200D0A7D0D0A2E617065782D7264732D686F7665722E72696768742061207B0D0A20206261636B67726F756E643A202D7765626B69742D6C696E656172';
wwv_flow_api.g_varchar2_table(864) := '2D6772616469656E74286C6566742C20236666666666662030252C2072676261283235352C203235352C203235352C2030292031252C202366666666666620353025293B0D0A20200D0A20206261636B67726F756E643A206C696E6561722D6772616469';
wwv_flow_api.g_varchar2_table(865) := '656E7428746F2072696768742C20236666666666662030252C2072676261283235352C203235352C203235352C2030292031252C202366666666666620353025293B0D0A20200D0A7D0D0A0D0A2E766572746963616C2D726473202E617065782D726473';
wwv_flow_api.g_varchar2_table(866) := '202E617065782D7264732D73656C6563746564207370616E2C0D0A2E742D426F64792D73696465202E617065782D726473202E617065782D7264732D73656C6563746564207370616E207B0D0A2020626F782D736861646F773A20347078203020302023';
wwv_flow_api.g_varchar2_table(867) := '30353732636520696E7365743B0D0A7D0D0A2E752D52544C202E766572746963616C2D726473202E617065782D726473202E617065782D7264732D73656C6563746564207370616E2C0D0A2E752D52544C202E742D426F64792D73696465202E61706578';
wwv_flow_api.g_varchar2_table(868) := '2D726473202E617065782D7264732D73656C6563746564207370616E207B0D0A2020626F782D736861646F773A202D34707820302030202330353732636520696E7365743B0D0A7D0D0A0D0A2E612D546167436C6F75642D6C696E6B207B0D0A2020626F';
wwv_flow_api.g_varchar2_table(869) := '726465722D636F6C6F723A20236632663266323B0D0A2020626F726465722D7261646975733A203270783B0D0A20206261636B67726F756E643A20236661666166613B0D0A20207472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220';
wwv_flow_api.g_varchar2_table(870) := '302E32732C20626F726465722D636F6C6F7220302E32732C20626F782D736861646F7720302E32732C20636F6C6F7220302E32733B0D0A2020636F6C6F723A20233035363762613B0D0A7D0D0A2E612D546167436C6F75642D6C696E6B207370616E207B';
wwv_flow_api.g_varchar2_table(871) := '0D0A20207472616E736974696F6E3A20636F6C6F72202E32733B0D0A7D0D0A2E612D546167436C6F75642D6C696E6B3A686F766572207B0D0A2020746578742D6465636F726174696F6E3A206E6F6E653B0D0A20206261636B67726F756E642D636F6C6F';
wwv_flow_api.g_varchar2_table(872) := '723A20233035373263653B0D0A2020626F726465722D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A2020626F782D736861646F773A20302030203020327078202330353732636520696E7365743B0D0A7D0D';
wwv_flow_api.g_varchar2_table(873) := '0A2E612D546167436C6F75642D6C696E6B3A686F766572207370616E207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E612D546167436C6F75642D636F756E74207B0D0A2020636F6C6F723A20233636363636363B0D0A2020666F6E74';
wwv_flow_api.g_varchar2_table(874) := '2D7765696768743A203530303B0D0A7D0D0A2E742D54696D656C696E65207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D54696D656C696E652D757365726E616D652C0D0A2E742D54696D656C696E652D646174652C0D0A2E742D';
wwv_flow_api.g_varchar2_table(875) := '54696D656C696E652D64657363207B0D0A2020636F6C6F723A20233733373337333B0D0A7D0D0A2E742D54696D656C696E652D77726170207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D54696D656C696E652D74797065207B0D';
wwv_flow_api.g_varchar2_table(876) := '0A20206261636B67726F756E642D636F6C6F723A20236635663566353B0D0A2020636F6C6F723A20233236323632363B0D0A7D0D0A2E742D54696D656C696E652D747970652E69732D6E6577207B0D0A20206261636B67726F756E642D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(877) := '233362616132633B0D0A2020636F6C6F723A20234646463B0D0A7D0D0A2E742D54696D656C696E652D747970652E69732D75706461746564207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(878) := '4646463B0D0A7D0D0A2E742D54696D656C696E652D747970652E69732D72656D6F766564207B0D0A20206261636B67726F756E642D636F6C6F723A20236634343333363B0D0A2020636F6C6F723A20234646463B0D0A7D0D0A2E742D54696D656C696E65';
wwv_flow_api.g_varchar2_table(879) := '2D777261703A666F637573207B0D0A20206F75746C696E653A206E6F6E653B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A7D0D0A406D6564696120286D696E2D77696474683A203736397078';
wwv_flow_api.g_varchar2_table(880) := '29207B0D0A20202E742D426F64792D6E6176207B0D0A202020206261636B67726F756E642D636F6C6F723A20233331333733633B0D0A20207D0D0A7D0D0A2E742D547265654E6176207B0D0A20206261636B67726F756E642D636F6C6F723A2023333133';
wwv_flow_api.g_varchar2_table(881) := '3733633B0D0A7D0D0A2E742D50616765426F64792D2D6C6566744E6176202E742D426F64792D6E61763A3A2D7765626B69742D7363726F6C6C6261722D7468756D62207B0D0A20206261636B67726F756E642D636F6C6F723A20233231323532383B0D0A';
wwv_flow_api.g_varchar2_table(882) := '2020626F782D736861646F773A20696E7365742031707820302030203020233331333733633B0D0A7D0D0A2E742D50616765426F64792D2D6C6566744E6176202E742D426F64792D6E61763A3A2D7765626B69742D7363726F6C6C6261722D7468756D62';
wwv_flow_api.g_varchar2_table(883) := '3A686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233363343434613B0D0A7D0D0A2E742D50616765426F64792D2D6C6566744E6176202E742D426F64792D6E61763A3A2D7765626B69742D7363726F6C6C6261722D747261636B';
wwv_flow_api.g_varchar2_table(884) := '207B0D0A20206261636B67726F756E643A20233331333733633B0D0A7D0D0A2E742D50616765426F64792D2D6C6566744E6176202E742D426F64792D6E61763A3A2D7765626B69742D7363726F6C6C6261722D747261636B3A686F766572207B0D0A2020';
wwv_flow_api.g_varchar2_table(885) := '6261636B67726F756E642D636F6C6F723A20233533356536363B0D0A7D0D0A2E742D526567696F6E207B0D0A20200D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D';
wwv_flow_api.g_varchar2_table(886) := '726F772E69732D666F6375736564207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D5265';
wwv_flow_api.g_varchar2_table(887) := '67696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D726F772E69732D63757272656E742C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E61';
wwv_flow_api.g_varchar2_table(888) := '2D54726565566965772D726F772E69732D73656C65637465642C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D726F772E69732D63757272656E742D2D746F702E69732D';
wwv_flow_api.g_varchar2_table(889) := '73656C6563746564207B0D0A20206261636B67726F756E642D636F6C6F723A20236637663766373B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D726F772E6973';
wwv_flow_api.g_varchar2_table(890) := '2D63757272656E742D2D746F702C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D636F6C6C61707369626C65203E202E612D54726565566965772D726F772C0D0A2E742D526567696F6E202E61';
wwv_flow_api.g_varchar2_table(891) := '2D54726565566965772D6E6F64652D2D746F704C6576656C20756C207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C';
wwv_flow_api.g_varchar2_table(892) := '202E612D54726565566965772D726F772E69732D686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236630663066302021696D706F7274616E743B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D';
wwv_flow_api.g_varchar2_table(893) := '2D746F704C6576656C202E612D54726565566965772D726F772E69732D686F766572202B202E612D54726565566965772D746F67676C652C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D636F';
wwv_flow_api.g_varchar2_table(894) := '6C6C61707369626C65202E612D54726565566965772D746F67676C65207B0D0A2020636F6C6F723A20726762612836342C2036342C2036342C20302E3735293B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F70';
wwv_flow_api.g_varchar2_table(895) := '4C6576656C202E612D54726565566965772D726F772E69732D686F766572202B202E612D54726565566965772D746F67676C653A686F7665722C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D';
wwv_flow_api.g_varchar2_table(896) := '636F6C6C61707369626C65202E612D54726565566965772D746F67676C653A686F766572207B0D0A2020636F6C6F723A20233430343034302021696D706F7274616E743B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D';
wwv_flow_api.g_varchar2_table(897) := '2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D686F766572207B0D0A2020636F6C6F723A20233430343034302021696D706F7274616E743B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64';
wwv_flow_api.g_varchar2_table(898) := '652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E74207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D547265';
wwv_flow_api.g_varchar2_table(899) := '65566965772D636F6E74656E74202E66612C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E74202E612D49636F6E207B0D0A2020636F6C6F723A20726762';
wwv_flow_api.g_varchar2_table(900) := '612836342C2036342C2036342C20302E3935293B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E74202E66613A6265666F72652C0D0A2E742D5265';
wwv_flow_api.g_varchar2_table(901) := '67696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E74202E612D49636F6E3A6265666F7265207B0D0A2020636F6C6F723A20696E68657269743B0D0A7D0D0A2E742D526567696F';
wwv_flow_api.g_varchar2_table(902) := '6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D686F766572202E66612C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C';
wwv_flow_api.g_varchar2_table(903) := '202E612D54726565566965772D636F6E74656E742E69732D63757272656E742D2D746F70202E66612C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E';
wwv_flow_api.g_varchar2_table(904) := '69732D686F766572202E612D49636F6E2C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D63757272656E742D2D746F70202E612D49636F6E20';
wwv_flow_api.g_varchar2_table(905) := '7B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D6C6162656C207B0D0A2020636F6C6F723A20696E68657269743B';
wwv_flow_api.g_varchar2_table(906) := '0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D63757272656E742C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64';
wwv_flow_api.g_varchar2_table(907) := '652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D73656C65637465642C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E7465';
wwv_flow_api.g_varchar2_table(908) := '6E742E69732D63757272656E742D2D746F70207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D746F67676C6520';
wwv_flow_api.g_varchar2_table(909) := '7B0D0A2020636F6C6F723A20726762612836342C2036342C2036342C20302E3735293B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D746F67676C653A686F7665';
wwv_flow_api.g_varchar2_table(910) := '72207B0D0A2020636F6C6F723A20233430343034302021696D706F7274616E743B0D0A7D0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D636F6C6C61707369626C65203E202E612D5472656556';
wwv_flow_api.g_varchar2_table(911) := '6965772D726F772E69732D73656C65637465642C0D0A2E742D526567696F6E202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D636F6C6C61707369626C65203E202E612D54726565566965772D726F772E69732D666F637573';
wwv_flow_api.g_varchar2_table(912) := '6564207B0D0A20206261636B67726F756E642D636F6C6F723A20236637663766373B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D726F772E69732D666F6375';
wwv_flow_api.g_varchar2_table(913) := '736564207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365743B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A7D0D0A2E742D547265654E6176202E612D5472';
wwv_flow_api.g_varchar2_table(914) := '6565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D726F772E69732D63757272656E742C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D5472656556696577';
wwv_flow_api.g_varchar2_table(915) := '2D726F772E69732D73656C65637465642C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D726F772E69732D63757272656E742D2D746F702E69732D73656C6563746564';
wwv_flow_api.g_varchar2_table(916) := '207B0D0A20206261636B67726F756E642D636F6C6F723A20233231323532383B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D726F772E69732D63757272656E';
wwv_flow_api.g_varchar2_table(917) := '742D2D746F702C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D636F6C6C61707369626C65203E202E612D54726565566965772D726F772C0D0A2E742D547265654E6176202E612D54726565';
wwv_flow_api.g_varchar2_table(918) := '566965772D6E6F64652D2D746F704C6576656C20756C207B0D0A20206261636B67726F756E642D636F6C6F723A20233161316432303B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D';
wwv_flow_api.g_varchar2_table(919) := '54726565566965772D726F772E69732D686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233238326433312021696D706F7274616E743B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F';
wwv_flow_api.g_varchar2_table(920) := '704C6576656C202E612D54726565566965772D726F772E69732D686F766572202B202E612D54726565566965772D746F67676C652C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D636F6C6C';
wwv_flow_api.g_varchar2_table(921) := '61707369626C65202E612D54726565566965772D746F67676C65207B0D0A2020636F6C6F723A2072676261283235352C203235352C203235352C20302E3735293B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D74';
wwv_flow_api.g_varchar2_table(922) := '6F704C6576656C202E612D54726565566965772D726F772E69732D686F766572202B202E612D54726565566965772D746F67676C653A686F7665722C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E';
wwv_flow_api.g_varchar2_table(923) := '69732D636F6C6C61707369626C65202E612D54726565566965772D746F67676C653A686F766572207B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E';
wwv_flow_api.g_varchar2_table(924) := '6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D686F766572207B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965';
wwv_flow_api.g_varchar2_table(925) := '772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E74207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C20';
wwv_flow_api.g_varchar2_table(926) := '2E612D54726565566965772D636F6E74656E74202E66612C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E74202E612D49636F6E207B0D0A2020636F6C';
wwv_flow_api.g_varchar2_table(927) := '6F723A20236666666666663B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E74202E66613A6265666F72652C0D0A2E742D547265654E6176202E';
wwv_flow_api.g_varchar2_table(928) := '612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E74202E612D49636F6E3A6265666F7265207B0D0A2020636F6C6F723A20696E68657269743B0D0A7D0D0A2E742D547265654E6176202E612D';
wwv_flow_api.g_varchar2_table(929) := '54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D686F766572202E66612C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D';
wwv_flow_api.g_varchar2_table(930) := '54726565566965772D636F6E74656E742E69732D63757272656E742D2D746F70202E66612C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D';
wwv_flow_api.g_varchar2_table(931) := '686F766572202E612D49636F6E2C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D63757272656E742D2D746F70202E612D49636F6E207B0D';
wwv_flow_api.g_varchar2_table(932) := '0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D6C6162656C207B0D0A2020636F6C6F723A20696E68657269743B0D';
wwv_flow_api.g_varchar2_table(933) := '0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D63757272656E742C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F';
wwv_flow_api.g_varchar2_table(934) := '64652D2D746F704C6576656C202E612D54726565566965772D636F6E74656E742E69732D73656C65637465642C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D636F6E';
wwv_flow_api.g_varchar2_table(935) := '74656E742E69732D63757272656E742D2D746F70207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D746F6767';
wwv_flow_api.g_varchar2_table(936) := '6C65207B0D0A2020636F6C6F723A2072676261283235352C203235352C203235352C20302E3735293B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C202E612D54726565566965772D746F6767';
wwv_flow_api.g_varchar2_table(937) := '6C653A686F766572207B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D636F6C6C61707369626C65202E61';
wwv_flow_api.g_varchar2_table(938) := '2D54726565566965772D636F6E74656E74202E66612C0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D636F6C6C61707369626C65202E612D54726565566965772D636F6E74656E74202E612D';
wwv_flow_api.g_varchar2_table(939) := '49636F6E207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C2E69732D636F6C6C61707369626C65202E612D54726565566965772D636F6E7465';
wwv_flow_api.g_varchar2_table(940) := '6E74207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E6A732D6E6176436F6C6C6170736564202E742D547265654E6176202E612D54726565566965772D6E6F64652D2D746F704C6576656C203E202E612D54726565566965772D636F6E';
wwv_flow_api.g_varchar2_table(941) := '74656E74202E612D54726565566965772D6C6162656C202E612D54726565566965772D6261646765207B0D0A20206261636B67726F756E643A20233066313031323B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D547265654E6176';
wwv_flow_api.g_varchar2_table(942) := '202E612D54726565566965772D6261646765207B0D0A2020626F782D736861646F773A203020302030203170782072676261283235352C203235352C203235352C20302E31293B0D0A2020666F6E742D7765696768743A203430303B0D0A7D0D0A2E742D';
wwv_flow_api.g_varchar2_table(943) := '547265654E6176202E612D54726565566965772D636F6E74656E742E69732D63757272656E74202E612D54726565566965772D6C6162656C2C0D0A2E742D547265654E6176202E612D54726565566965772D636F6E74656E742E69732D63757272656E74';
wwv_flow_api.g_varchar2_table(944) := '2D2D746F70202E612D54726565566965772D6C6162656C207B0D0A2020666F6E742D7765696768743A203530303B0D0A7D0D0A0D0A2E742D56616C69646174696F6E2D64617465207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D';
wwv_flow_api.g_varchar2_table(945) := '56616C69646174696F6E2D75736572207B0D0A2020636F6C6F723A20233539353935393B0D0A7D0D0A2E742D426F64792D616374696F6E73202E742D56616C69646174696F6E2D64617465207B0D0A2020636F6C6F723A20233361336133613B0D0A7D0D';
wwv_flow_api.g_varchar2_table(946) := '0A2E742D426F64792D616374696F6E73202E742D56616C69646174696F6E2D75736572207B0D0A2020636F6C6F723A20233533353335333B0D0A7D0D0A0D0A2E742D4469616C6F672D706167652D2D77697A617264207B0D0A2020626F726465723A2023';
wwv_flow_api.g_varchar2_table(947) := '6536653665363B0D0A7D0D0A2E742D57697A617264207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020626F726465722D7261646975733A203270783B0D0A2020626F726465722D636F6C6F723A20236536653665';
wwv_flow_api.g_varchar2_table(948) := '363B0D0A7D0D0A2E742D57697A617264202E742D57697A6172642D7469746C65207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D57697A617264202E742D57697A6172642D686561646572207B0D0A20206261636B67726F756E64';
wwv_flow_api.g_varchar2_table(949) := '2D636F6C6F723A20236661666166613B0D0A2020626F726465722D636F6C6F723A20236564656465643B0D0A7D0D0A2E742D57697A61726453746570732D777261703A6166746572207B0D0A20206261636B67726F756E642D636F6C6F723A2023653665';
wwv_flow_api.g_varchar2_table(950) := '3665363B0D0A7D0D0A2E742D57697A61726453746570732D73746570202E742D57697A61726453746570732D6D61726B6572207B0D0A20206261636B67726F756E642D636F6C6F723A20236363636363633B0D0A7D0D0A2E742D57697A61726453746570';
wwv_flow_api.g_varchar2_table(951) := '732D737465702E69732D636F6D706C657465202E742D57697A61726453746570732D6D61726B6572207B0D0A20206261636B67726F756E642D636F6C6F723A20233362616132633B0D0A2020636F6C6F723A20234646463B0D0A7D0D0A2E742D57697A61';
wwv_flow_api.g_varchar2_table(952) := '726453746570732D737465702E69732D616374697665202E742D57697A61726453746570732D6D61726B6572207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A7D0D0A2E742D57697A61726453746570732D6C616265';
wwv_flow_api.g_varchar2_table(953) := '6C207B0D0A2020636F6C6F723A20233636363636363B0D0A7D0D0A2E742D57697A61726453746570732D737465702E69732D616374697665202E742D57697A61726453746570732D6C6162656C207B0D0A2020636F6C6F723A20233430343034303B0D0A';
wwv_flow_api.g_varchar2_table(954) := '7D0D0A0D0A2E75692D776964676574207B0D0A2020666F6E742D66616D696C793A202748656C766574696361204E657565272C20275365676F65205549272C2048656C7665746963612C20417269616C2C2073616E732D73657269663B0D0A2020666F6E';
wwv_flow_api.g_varchar2_table(955) := '742D73697A653A20313270783B0D0A7D0D0A2E75692D776964676574202E75692D776964676574207B0D0A2020666F6E742D73697A653A20313270783B0D0A7D0D0A0D0A626F6479202E75692D7769646765742D636F6E74656E74207B0D0A2020626F72';
wwv_flow_api.g_varchar2_table(956) := '6465722D636F6C6F723A20236562656265623B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A626F6479202E75692D7769646765742D636F6E74656E742061207B';
wwv_flow_api.g_varchar2_table(957) := '0D0A2020636F6C6F723A20233035366162663B0D0A7D0D0A626F6479202E75692D7769646765742D686561646572207B0D0A2020626F726465722D636F6C6F723A20236562656265623B0D0A20206261636B67726F756E642D636F6C6F723A2023666666';
wwv_flow_api.g_varchar2_table(958) := '6666663B0D0A2020636F6C6F723A20233236323632363B0D0A7D0D0A626F6479202E75692D7769646765742D6865616465722061207B0D0A2020636F6C6F723A20233236323632363B0D0A7D0D0A0D0A626F6479202E75692D73746174652D6465666175';
wwv_flow_api.g_varchar2_table(959) := '6C742C0D0A626F6479202E75692D7769646765742D636F6E74656E74202E75692D73746174652D64656661756C742C0D0A626F6479202E75692D7769646765742D686561646572202E75692D73746174652D64656661756C74207B0D0A20206261636B67';
wwv_flow_api.g_varchar2_table(960) := '726F756E642D636F6C6F723A20236638663866383B0D0A2020636F6C6F723A20233338333833383B0D0A7D0D0A626F6479202E75692D73746174652D64656661756C7420612C0D0A626F6479202E75692D73746174652D64656661756C7420613A6C696E';
wwv_flow_api.g_varchar2_table(961) := '6B2C0D0A626F6479202E75692D73746174652D64656661756C7420613A766973697465642C0D0A626F6479202E75692D73746174652D61637469766520612C0D0A626F6479202E75692D73746174652D61637469766520613A6C696E6B2C0D0A626F6479';
wwv_flow_api.g_varchar2_table(962) := '202E75692D73746174652D61637469766520613A76697369746564207B0D0A2020636F6C6F723A20233035366162663B0D0A7D0D0A626F6479202E75692D73746174652D686F7665722C0D0A626F6479202E75692D7769646765742D636F6E74656E7420';
wwv_flow_api.g_varchar2_table(963) := '2E75692D73746174652D686F7665722C0D0A626F6479202E75692D7769646765742D686561646572202E75692D73746174652D686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(964) := '3338333833383B0D0A7D0D0A626F6479202E75692D73746174652D666F6375732C0D0A626F6479202E75692D7769646765742D636F6E74656E74202E75692D73746174652D666F6375732C0D0A626F6479202E75692D7769646765742D68656164657220';
wwv_flow_api.g_varchar2_table(965) := '2E75692D73746174652D666F637573207B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365742C203020302031707820327078207267626128352C203131342C203230362C20302E3235292021696D706F72';
wwv_flow_api.g_varchar2_table(966) := '74616E743B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233338333833383B0D0A7D0D0A626F6479202E75692D646174657069636B6572202E75692D646174657069636B65722D627574746F6E';
wwv_flow_api.g_varchar2_table(967) := '70616E6520627574746F6E3A666F637573207B0D0A20206F75746C696E653A206E6F6E653B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365742C203020302031707820327078207267626128352C203131';
wwv_flow_api.g_varchar2_table(968) := '342C203230362C20302E3235292021696D706F7274616E743B0D0A7D0D0A626F6479202E75692D73746174652D686F76657220612C0D0A626F6479202E75692D73746174652D686F76657220613A686F7665722C0D0A626F6479202E75692D7374617465';
wwv_flow_api.g_varchar2_table(969) := '2D686F76657220613A6C696E6B2C0D0A626F6479202E75692D73746174652D686F76657220613A766973697465642C0D0A626F6479202E75692D73746174652D666F63757320612C0D0A626F6479202E75692D73746174652D666F63757320613A686F76';
wwv_flow_api.g_varchar2_table(970) := '65722C0D0A626F6479202E75692D73746174652D666F63757320613A6C696E6B2C0D0A626F6479202E75692D73746174652D666F63757320613A76697369746564207B0D0A2020636F6C6F723A20233035366162663B0D0A7D0D0A626F6479202E75692D';
wwv_flow_api.g_varchar2_table(971) := '73746174652D6163746976652C0D0A626F6479202E75692D7769646765742D636F6E74656E74202E75692D73746174652D6163746976652C0D0A626F6479202E75692D7769646765742D686561646572202E75692D73746174652D616374697665207B0D';
wwv_flow_api.g_varchar2_table(972) := '0A20206261636B67726F756E642D636F6C6F723A20236465646564653B0D0A2020636F6C6F723A20233338333833383B0D0A7D0D0A0D0A626F6479202E75692D73746174652D686967686C696768742C0D0A626F6479202E75692D7769646765742D636F';
wwv_flow_api.g_varchar2_table(973) := '6E74656E74202E75692D73746174652D686967686C696768742C0D0A626F6479202E75692D7769646765742D686561646572202E75692D73746174652D686967686C69676874207B0D0A20206261636B67726F756E642D636F6C6F723A20236434656266';
wwv_flow_api.g_varchar2_table(974) := '653B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A626F6479202E75692D73746174652D686967686C6967687420612C0D0A626F6479202E75692D7769646765742D636F6E74656E74202E75692D73746174652D686967686C696768742061';
wwv_flow_api.g_varchar2_table(975) := '2C0D0A626F6479202E75692D7769646765742D686561646572202E75692D73746174652D686967686C696768742061207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A626F6479202E75692D73746174652D6572726F722C0D0A626F6479';
wwv_flow_api.g_varchar2_table(976) := '202E75692D7769646765742D636F6E74656E74202E75692D73746174652D6572726F722C0D0A626F6479202E75692D7769646765742D686561646572202E75692D73746174652D6572726F72207B0D0A20206261636B67726F756E642D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(977) := '236634343333363B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A626F6479202E75692D73746174652D6572726F7220612C0D0A626F6479202E75692D7769646765742D636F6E74656E74202E75692D73746174652D6572726F7220612C0D';
wwv_flow_api.g_varchar2_table(978) := '0A626F6479202E75692D7769646765742D686561646572202E75692D73746174652D6572726F722061207B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A626F6479202E75692D73746174652D6572726F722D746578742C0D0A626F647920';
wwv_flow_api.g_varchar2_table(979) := '2E75692D7769646765742D636F6E74656E74202E75692D73746174652D6572726F722D746578742C0D0A626F6479202E75692D7769646765742D686561646572202E75692D73746174652D6572726F722D74657874207B0D0A2020636F6C6F723A202366';
wwv_flow_api.g_varchar2_table(980) := '34343333363B0D0A7D0D0A0D0A626F6479202E75692D646174657069636B6572207464207370616E2E75692D73746174652D64656661756C742C0D0A626F6479202E75692D646174657069636B657220746420612E75692D73746174652D64656661756C';
wwv_flow_api.g_varchar2_table(981) := '74207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E743B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A626F6479202E75692D646174657069636B6572207464207370616E2E75692D73746174652D6465';
wwv_flow_api.g_varchar2_table(982) := '6661756C742E75692D73746174652D6163746976652C0D0A626F6479202E75692D646174657069636B657220746420612E75692D73746174652D64656661756C742E75692D73746174652D616374697665207B0D0A20206261636B67726F756E642D636F';
wwv_flow_api.g_varchar2_table(983) := '6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A2020666F6E742D7765696768743A20626F6C643B0D0A7D0D0A626F6479202E75692D646174657069636B6572207464207370616E2E75692D73746174652D64656661';
wwv_flow_api.g_varchar2_table(984) := '756C742E75692D73746174652D6163746976652E75692D73746174652D686F7665722C0D0A626F6479202E75692D646174657069636B657220746420612E75692D73746174652D64656661756C742E75692D73746174652D6163746976652E75692D7374';
wwv_flow_api.g_varchar2_table(985) := '6174652D686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263652021696D706F7274616E743B0D0A7D0D0A626F6479202E75692D646174657069636B6572207464207370616E2E75692D73746174652D64656661756C';
wwv_flow_api.g_varchar2_table(986) := '742E75692D73746174652D686F7665722C0D0A626F6479202E75692D646174657069636B657220746420612E75692D73746174652D64656661756C742E75692D73746174652D686F766572207B0D0A20206261636B67726F756E642D636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(987) := '6632663266322021696D706F7274616E743B0D0A7D0D0A626F6479202E75692D646174657069636B6572207464207370616E2E75692D73746174652D64656661756C743A666F6375732C0D0A626F6479202E75692D646174657069636B65722074642061';
wwv_flow_api.g_varchar2_table(988) := '2E75692D73746174652D64656661756C743A666F637573207B0D0A20206F75746C696E653A206E6F6E653B0D0A2020626F782D736861646F773A20302030203020317078202330353732636520696E7365742C2030203020317078203270782072676261';
wwv_flow_api.g_varchar2_table(989) := '28352C203131342C203230362C20302E3235292021696D706F7274616E743B0D0A7D0D0A626F6479202E75692D646174657069636B6572207464207370616E2E75692D73746174652D64656661756C742E75692D73746174652D686967686C696768742C';
wwv_flow_api.g_varchar2_table(990) := '0D0A626F6479202E75692D646174657069636B657220746420612E75692D73746174652D64656661756C742E75692D73746174652D686967686C69676874207B0D0A20206261636B67726F756E642D636F6C6F723A20236562656265623B0D0A7D0D0A62';
wwv_flow_api.g_varchar2_table(991) := '6F6479202E75692D646174657069636B6572207468207B0D0A2020636F6C6F723A20233830383038303B0D0A7D0D0A626F6479202E75692D646174657069636B6572202E75692D646174657069636B65722D6865616465722C0D0A626F6479202E75692D';
wwv_flow_api.g_varchar2_table(992) := '646174657069636B6572202E75692D646174657069636B65722D627574746F6E70616E6520627574746F6E2C0D0A626F6479202E75692D646174657069636B6572202E75692D646174657069636B65722D6E6578742C0D0A626F6479202E75692D646174';
wwv_flow_api.g_varchar2_table(993) := '657069636B6572202E75692D646174657069636B65722D70726576207B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A0D0A626F6479202E75692D6469616C6F67202E75692D6469616C6F672D7469746C65626172207B0D0A2020';
wwv_flow_api.g_varchar2_table(994) := '6261636B67726F756E642D636F6C6F723A20236666666666663B0D0A2020626F726465722D626F74746F6D3A2031707820736F6C6964207267626128302C20302C20302C20302E3035293B0D0A7D0D0A626F6479202E75692D6469616C6F67202E75692D';
wwv_flow_api.g_varchar2_table(995) := '6469616C6F672D7469746C65207B0D0A2020636F6C6F723A20233236323632363B0D0A7D0D0A626F6479202E75692D6469616C6F67202E75692D6469616C6F672D636F6E74656E742C0D0A2E742D4469616C6F672D70616765207B0D0A20206261636B67';
wwv_flow_api.g_varchar2_table(996) := '726F756E642D636F6C6F723A20236666666666663B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A0D0A2E742D4469616C6F672D2D77697A6172642E75692D6469616C6F672C0D0A2E742D4469616C6F672D2D77697A6172642E75692D6469';
wwv_flow_api.g_varchar2_table(997) := '616C6F67202E75692D6469616C6F672D7469746C656261722C0D0A2E742D4469616C6F672D2D77697A61726420626F6479202E75692D6469616C6F67202E75692D6469616C6F672D636F6E74656E74207B0D0A20206261636B67726F756E642D636F6C6F';
wwv_flow_api.g_varchar2_table(998) := '723A20236666666666663B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D4469616C6F672D2D77697A6172642E75692D6469616C6F67202E75692D6469616C6F672D7469746C65207B0D0A2020636F6C6F723A20233430343034303B';
wwv_flow_api.g_varchar2_table(999) := '0D0A7D0D0A0D0A626F6479202E75692D636F726E65722D616C6C207B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A626F6479202E75692D636F726E65722D746F702C0D0A626F6479202E75692D636F726E65722D6C6566742C0D';
wwv_flow_api.g_varchar2_table(1000) := '0A626F6479202E75692D636F726E65722D746C207B0D0A2020626F726465722D746F702D6C6566742D7261646975733A203270783B0D0A7D0D0A626F6479202E75692D636F726E65722D746F702C0D0A626F6479202E75692D636F726E65722D72696768';
wwv_flow_api.g_varchar2_table(1001) := '742C0D0A626F6479202E75692D636F726E65722D7472207B0D0A2020626F726465722D746F702D72696768742D7261646975733A203270783B0D0A7D0D0A626F6479202E75692D636F726E65722D626F74746F6D2C0D0A626F6479202E75692D636F726E';
wwv_flow_api.g_varchar2_table(1002) := '65722D6C6566742C0D0A626F6479202E75692D636F726E65722D626C207B0D0A2020626F726465722D626F74746F6D2D6C6566742D7261646975733A203270783B0D0A7D0D0A626F6479202E75692D636F726E65722D626F74746F6D2C0D0A626F647920';
wwv_flow_api.g_varchar2_table(1003) := '2E75692D636F726E65722D72696768742C0D0A626F6479202E75692D636F726E65722D6272207B0D0A2020626F726465722D626F74746F6D2D72696768742D7261646975733A203270783B0D0A7D0D0A0D0A626F6479202E75692D627574746F6E2E7569';
wwv_flow_api.g_varchar2_table(1004) := '2D636F726E65722D616C6C207B0D0A2020626F726465722D7261646975733A203270783B0D0A7D0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D746F702C0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D6C';
wwv_flow_api.g_varchar2_table(1005) := '6566742C0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D746C207B0D0A2020626F726465722D746F702D6C6566742D7261646975733A203270783B0D0A7D0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D74';
wwv_flow_api.g_varchar2_table(1006) := '6F702C0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D72696768742C0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D7472207B0D0A2020626F726465722D746F702D72696768742D7261646975733A203270';
wwv_flow_api.g_varchar2_table(1007) := '783B0D0A7D0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D626F74746F6D2C0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D6C6566742C0D0A626F6479202E75692D627574746F6E2E75692D636F726E6572';
wwv_flow_api.g_varchar2_table(1008) := '2D626C207B0D0A2020626F726465722D626F74746F6D2D6C6566742D7261646975733A203270783B0D0A7D0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D626F74746F6D2C0D0A626F6479202E75692D627574746F6E2E75692D63';
wwv_flow_api.g_varchar2_table(1009) := '6F726E65722D72696768742C0D0A626F6479202E75692D627574746F6E2E75692D636F726E65722D6272207B0D0A2020626F726465722D626F74746F6D2D72696768742D7261646975733A203270783B0D0A7D0D0A0D0A2E752D7761726E696E67207B0D';
wwv_flow_api.g_varchar2_table(1010) := '0A20206261636B67726F756E642D636F6C6F723A20236662636534612021696D706F7274616E743B0D0A2020636F6C6F723A20233434333330323B0D0A7D0D0A2E752D7761726E696E672D74657874207B0D0A2020636F6C6F723A202366626365346120';
wwv_flow_api.g_varchar2_table(1011) := '21696D706F7274616E743B0D0A7D0D0A2E752D7761726E696E672D6267207B0D0A20206261636B67726F756E642D636F6C6F723A20236662636534612021696D706F7274616E743B0D0A7D0D0A2E752D7761726E696E672D626F72646572207B0D0A2020';
wwv_flow_api.g_varchar2_table(1012) := '626F726465722D636F6C6F723A20236662636534612021696D706F7274616E743B0D0A7D0D0A0D0A2E752D73756363657373207B0D0A20206261636B67726F756E642D636F6C6F723A20233362616132632021696D706F7274616E743B0D0A2020636F6C';
wwv_flow_api.g_varchar2_table(1013) := '6F723A20236666666666663B0D0A7D0D0A2E752D737563636573732D74657874207B0D0A2020636F6C6F723A20233362616132632021696D706F7274616E743B0D0A7D0D0A2E752D737563636573732D6267207B0D0A20206261636B67726F756E642D63';
wwv_flow_api.g_varchar2_table(1014) := '6F6C6F723A20233362616132632021696D706F7274616E743B0D0A7D0D0A2E752D737563636573732D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233362616132632021696D706F7274616E743B0D0A7D0D0A0D0A2E752D64616E67';
wwv_flow_api.g_varchar2_table(1015) := '6572207B0D0A20206261636B67726F756E642D636F6C6F723A20236634343333362021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D64616E6765722D74657874207B0D0A2020636F6C6F723A2023663434';
wwv_flow_api.g_varchar2_table(1016) := '3333362021696D706F7274616E743B0D0A7D0D0A2E752D64616E6765722D6267207B0D0A20206261636B67726F756E642D636F6C6F723A20236634343333362021696D706F7274616E743B0D0A7D0D0A2E752D64616E6765722D626F72646572207B0D0A';
wwv_flow_api.g_varchar2_table(1017) := '2020626F726465722D636F6C6F723A20236634343333362021696D706F7274616E743B0D0A7D0D0A0D0A2E752D696E666F207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263652021696D706F7274616E743B0D0A2020636F6C6F';
wwv_flow_api.g_varchar2_table(1018) := '723A20236666666666663B0D0A7D0D0A2E752D696E666F2D74657874207B0D0A2020636F6C6F723A20233035373263652021696D706F7274616E743B0D0A7D0D0A2E752D696E666F2D6267207B0D0A20206261636B67726F756E642D636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(1019) := '3035373263652021696D706F7274616E743B0D0A7D0D0A2E752D696E666F2D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233035373263652021696D706F7274616E743B0D0A7D0D0A0D0A2E752D686F74207B0D0A20206261636B67';
wwv_flow_api.g_varchar2_table(1020) := '726F756E642D636F6C6F723A20233035373263652021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D686F742D74657874207B0D0A2020636F6C6F723A20233035373263652021696D706F7274616E743B0D';
wwv_flow_api.g_varchar2_table(1021) := '0A7D0D0A2E752D686F742D6267207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263652021696D706F7274616E743B0D0A7D0D0A2E752D686F742D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233035373263';
wwv_flow_api.g_varchar2_table(1022) := '652021696D706F7274616E743B0D0A7D0D0A0D0A2E752D6E6F726D616C207B0D0A20206261636B67726F756E642D636F6C6F723A20236664666466642021696D706F7274616E743B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E752D6E';
wwv_flow_api.g_varchar2_table(1023) := '6F726D616C2D74657874207B0D0A2020636F6C6F723A20233365336533652021696D706F7274616E743B0D0A7D0D0A2E752D6E6F726D616C2D6267207B0D0A20206261636B67726F756E642D636F6C6F723A20233365336533652021696D706F7274616E';
wwv_flow_api.g_varchar2_table(1024) := '743B0D0A7D0D0A2E752D6E6F726D616C2D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233365336533652021696D706F7274616E743B0D0A7D0D0A626F6479202E75692D6469616C6F67202E75692D6469616C6F672D7469746C6562';
wwv_flow_api.g_varchar2_table(1025) := '61722D636C6F7365207B0D0A2020626F726465722D7261646975733A20313030253B0D0A7D0D0A626F6479202E75692D6469616C6F67202E75692D6469616C6F672D627574746F6E70616E65207B0D0A2020626F726465722D746F702D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1026) := '236562656265623B0D0A7D0D0A2E742D426F6479207B0D0A20200D0A20200D0A20200D0A7D0D0A2E742D426F6479202E612D4D696E6943616C207B0D0A2020626F726465723A2031707820736F6C696420236534653465343B0D0A2020626F726465722D';
wwv_flow_api.g_varchar2_table(1027) := '7261646975733A203270783B0D0A20206261636B67726F756E642D636F6C6F723A20236664666466643B0D0A7D0D0A2E742D426F6479202E612D4D696E6943616C2D7469746C65207B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D';
wwv_flow_api.g_varchar2_table(1028) := '426F6479202E612D4D696E6943616C2D6461794F665765656B207B0D0A2020636F6C6F723A20233765376537653B0D0A7D0D0A2E742D426F6479202E612D4D696E6943616C2D646179207B0D0A2020626F726465722D636F6C6F723A2023663766376637';
wwv_flow_api.g_varchar2_table(1029) := '3B0D0A2020636F6C6F723A20233365336533653B0D0A7D0D0A2E742D426F6479202E612D4D696E6943616C2D6461792E69732D746F646179202E612D4D696E6943616C2D64617465207B0D0A20206261636B67726F756E642D636F6C6F723A2023303537';
wwv_flow_api.g_varchar2_table(1030) := '3263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D426F6479202E612D4D696E6943616C2D6461792E69732D616374697665202E612D4D696E6943616C2D64617465207B0D0A20206261636B67726F756E642D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1031) := '236662636534613B0D0A2020636F6C6F723A20233434333330323B0D0A7D0D0A2E742D426F6479202E612D4D696E6943616C2D6461792E69732D7765656B656E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236638663866383B0D0A7D';
wwv_flow_api.g_varchar2_table(1032) := '0D0A2E742D426F6479202E612D4D696E6943616C2D6461792E69732D6E756C6C207B0D0A20206261636B67726F756E642D636F6C6F723A20236633663366333B0D0A7D0D0A2E742D526567696F6E207B0D0A20200D0A20200D0A20200D0A7D0D0A2E742D';
wwv_flow_api.g_varchar2_table(1033) := '526567696F6E202E612D4D696E6943616C207B0D0A2020626F726465723A2031707820736F6C696420236536653665363B0D0A2020626F726465722D7261646975733A203270783B0D0A20206261636B67726F756E642D636F6C6F723A20236666666666';
wwv_flow_api.g_varchar2_table(1034) := '663B0D0A7D0D0A2E742D526567696F6E202E612D4D696E6943616C2D7469746C65207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E202E612D4D696E6943616C2D6461794F665765656B207B0D0A2020636F6C6F72';
wwv_flow_api.g_varchar2_table(1035) := '3A20233830383038303B0D0A7D0D0A2E742D526567696F6E202E612D4D696E6943616C2D646179207B0D0A2020626F726465722D636F6C6F723A20236639663966393B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D526567696F6E';
wwv_flow_api.g_varchar2_table(1036) := '202E612D4D696E6943616C2D6461792E69732D746F646179202E612D4D696E6943616C2D64617465207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E742D52';
wwv_flow_api.g_varchar2_table(1037) := '6567696F6E202E612D4D696E6943616C2D6461792E69732D616374697665202E612D4D696E6943616C2D64617465207B0D0A20206261636B67726F756E642D636F6C6F723A20236662636534613B0D0A2020636F6C6F723A20233434333330323B0D0A7D';
wwv_flow_api.g_varchar2_table(1038) := '0D0A2E742D526567696F6E202E612D4D696E6943616C2D6461792E69732D7765656B656E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236661666166613B0D0A7D0D0A2E742D526567696F6E202E612D4D696E6943616C2D6461792E69';
wwv_flow_api.g_varchar2_table(1039) := '732D6E756C6C207B0D0A20206261636B67726F756E642D636F6C6F723A20236635663566353B0D0A7D0D0A2E742D426F64792D616374696F6E73207B0D0A20200D0A20200D0A20200D0A7D0D0A2E742D426F64792D616374696F6E73202E612D4D696E69';
wwv_flow_api.g_varchar2_table(1040) := '43616C207B0D0A2020626F726465723A2031707820736F6C696420236530653065303B0D0A2020626F726465722D7261646975733A203270783B0D0A20206261636B67726F756E642D636F6C6F723A20236639663966393B0D0A7D0D0A2E742D426F6479';
wwv_flow_api.g_varchar2_table(1041) := '2D616374696F6E73202E612D4D696E6943616C2D7469746C65207B0D0A2020636F6C6F723A20233361336133613B0D0A7D0D0A2E742D426F64792D616374696F6E73202E612D4D696E6943616C2D6461794F665765656B207B0D0A2020636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1042) := '233761376137613B0D0A7D0D0A2E742D426F64792D616374696F6E73202E612D4D696E6943616C2D646179207B0D0A2020626F726465722D636F6C6F723A20236633663366333B0D0A2020636F6C6F723A20233361336133613B0D0A7D0D0A2E742D426F';
wwv_flow_api.g_varchar2_table(1043) := '64792D616374696F6E73202E612D4D696E6943616C2D6461792E69732D746F646179202E612D4D696E6943616C2D64617465207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F723A2023666666666666';
wwv_flow_api.g_varchar2_table(1044) := '3B0D0A7D0D0A2E742D426F64792D616374696F6E73202E612D4D696E6943616C2D6461792E69732D616374697665202E612D4D696E6943616C2D64617465207B0D0A20206261636B67726F756E642D636F6C6F723A20236662636534613B0D0A2020636F';
wwv_flow_api.g_varchar2_table(1045) := '6C6F723A20233434333330323B0D0A7D0D0A2E742D426F64792D616374696F6E73202E612D4D696E6943616C2D6461792E69732D7765656B656E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236634663466343B0D0A7D0D0A2E742D42';
wwv_flow_api.g_varchar2_table(1046) := '6F64792D616374696F6E73202E612D4D696E6943616C2D6461792E69732D6E756C6C207B0D0A20206261636B67726F756E642D636F6C6F723A20236566656665663B0D0A7D0D0A2E742D426F64792D696E666F207B0D0A20200D0A20200D0A20200D0A7D';
wwv_flow_api.g_varchar2_table(1047) := '0D0A2E742D426F64792D696E666F202E612D4D696E6943616C207B0D0A2020626F726465723A2031707820736F6C696420236536653665363B0D0A2020626F726465722D7261646975733A203270783B0D0A20206261636B67726F756E642D636F6C6F72';
wwv_flow_api.g_varchar2_table(1048) := '3A20236666666666663B0D0A7D0D0A2E742D426F64792D696E666F202E612D4D696E6943616C2D7469746C65207B0D0A2020636F6C6F723A20233430343034303B0D0A7D0D0A2E742D426F64792D696E666F202E612D4D696E6943616C2D6461794F6657';
wwv_flow_api.g_varchar2_table(1049) := '65656B207B0D0A2020636F6C6F723A20233830383038303B0D0A7D0D0A2E742D426F64792D696E666F202E612D4D696E6943616C2D646179207B0D0A2020626F726465722D636F6C6F723A20236639663966393B0D0A2020636F6C6F723A202334303430';
wwv_flow_api.g_varchar2_table(1050) := '34303B0D0A7D0D0A2E742D426F64792D696E666F202E612D4D696E6943616C2D6461792E69732D746F646179202E612D4D696E6943616C2D64617465207B0D0A20206261636B67726F756E642D636F6C6F723A20233035373263653B0D0A2020636F6C6F';
wwv_flow_api.g_varchar2_table(1051) := '723A20236666666666663B0D0A7D0D0A2E742D426F64792D696E666F202E612D4D696E6943616C2D6461792E69732D616374697665202E612D4D696E6943616C2D64617465207B0D0A20206261636B67726F756E642D636F6C6F723A2023666263653461';
wwv_flow_api.g_varchar2_table(1052) := '3B0D0A2020636F6C6F723A20233434333330323B0D0A7D0D0A2E742D426F64792D696E666F202E612D4D696E6943616C2D6461792E69732D7765656B656E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236661666166613B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1053) := '2E742D426F64792D696E666F202E612D4D696E6943616C2D6461792E69732D6E756C6C207B0D0A20206261636B67726F756E642D636F6C6F723A20236635663566353B0D0A7D0D0A0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E';
wwv_flow_api.g_varchar2_table(1054) := '202B203129202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233330396664623B0D0A202066696C6C3A20233330396664623B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E20';
wwv_flow_api.g_varchar2_table(1055) := '3A6E74682D6368696C642834356E202B203129202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203129202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E';
wwv_flow_api.g_varchar2_table(1056) := '642D636F6C6F723A20233330396664623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203129202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203129';
wwv_flow_api.g_varchar2_table(1057) := '202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233330396664623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203129202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E';
wwv_flow_api.g_varchar2_table(1058) := '74682D6368696C642834356E202B203129202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233330396664623B0D0A20207374726F6B653A20233330396664623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E';
wwv_flow_api.g_varchar2_table(1059) := '74682D6368696C642834356E202B203229202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233133623663663B0D0A202066696C6C3A20233133623663663B0D0A2020636F6C6F723A20236534663966643B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1060) := '2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203229202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203229202E752D636F6C6F722D6261636B67726F756E64207B0D';
wwv_flow_api.g_varchar2_table(1061) := '0A20206261636B67726F756E642D636F6C6F723A20233133623663663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203229202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368';
wwv_flow_api.g_varchar2_table(1062) := '696C642834356E202B203229202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233133623663663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203229202E752D636F6C6F722D62642C0D0A2E75';
wwv_flow_api.g_varchar2_table(1063) := '2D636F6C6F7273203E203A6E74682D6368696C642834356E202B203229202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233133623663663B0D0A20207374726F6B653A20233133623663663B0D0A7D0D0A2E75';
wwv_flow_api.g_varchar2_table(1064) := '2D636F6C6F7273203E203A6E74682D6368696C642834356E202B203329202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233265626662633B0D0A202066696C6C3A20233265626662633B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(1065) := '6630666366623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203329202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203329202E752D636F6C6F722D62';
wwv_flow_api.g_varchar2_table(1066) := '61636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233265626662633B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203329202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F';
wwv_flow_api.g_varchar2_table(1067) := '7273203E203A6E74682D6368696C642834356E202B203329202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233265626662633B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203329202E752D63';
wwv_flow_api.g_varchar2_table(1068) := '6F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203329202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233265626662633B0D0A20207374726F6B653A20233265';
wwv_flow_api.g_varchar2_table(1069) := '626662633B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203429202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233363616638353B0D0A202066696C6C3A20233363616638353B';
wwv_flow_api.g_varchar2_table(1070) := '0D0A2020636F6C6F723A20236630666166363B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203429202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2034';
wwv_flow_api.g_varchar2_table(1071) := '29202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233363616638353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203429202E752D636F6C6F722D74';
wwv_flow_api.g_varchar2_table(1072) := '78742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203429202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233363616638353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834';
wwv_flow_api.g_varchar2_table(1073) := '356E202B203429202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203429202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233363616638353B0D0A20';
wwv_flow_api.g_varchar2_table(1074) := '207374726F6B653A20233363616638353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203529202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233831626235663B0D0A20206669';
wwv_flow_api.g_varchar2_table(1075) := '6C6C3A20233831626235663B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203529202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D63';
wwv_flow_api.g_varchar2_table(1076) := '68696C642834356E202B203529202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233831626235663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2035';
wwv_flow_api.g_varchar2_table(1077) := '29202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203529202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233831626235663B0D0A7D0D0A2E752D636F6C6F7273203E20';
wwv_flow_api.g_varchar2_table(1078) := '3A6E74682D6368696C642834356E202B203529202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203529202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A';
wwv_flow_api.g_varchar2_table(1079) := '20233831626235663B0D0A20207374726F6B653A20233831626235663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203629202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A202364';
wwv_flow_api.g_varchar2_table(1080) := '64646535333B0D0A202066696C6C3A20236464646535333B0D0A2020636F6C6F723A20233261326130383B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203629202E752D636F6C6F722D62672C0D0A2E752D636F6C';
wwv_flow_api.g_varchar2_table(1081) := '6F7273203E203A6E74682D6368696C642834356E202B203629202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236464646535333B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D63';
wwv_flow_api.g_varchar2_table(1082) := '68696C642834356E202B203629202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203629202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236464646535333B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1083) := '2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203629202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203629202E752D636F6C6F722D626F72646572207B0D0A202062';
wwv_flow_api.g_varchar2_table(1084) := '6F726465722D636F6C6F723A20236464646535333B0D0A20207374726F6B653A20236464646535333B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203729202E752D636F6C6F72207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(1085) := '6E642D636F6C6F723A20236662636534613B0D0A202066696C6C3A20236662636534613B0D0A2020636F6C6F723A20233434333330323B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203729202E752D636F6C6F72';
wwv_flow_api.g_varchar2_table(1086) := '2D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203729202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236662636534613B0D0A7D0D0A2E752D636F6C';
wwv_flow_api.g_varchar2_table(1087) := '6F7273203E203A6E74682D6368696C642834356E202B203729202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203729202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(1088) := '6662636534613B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203729202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203729202E752D636F6C6F722D62';
wwv_flow_api.g_varchar2_table(1089) := '6F72646572207B0D0A2020626F726465722D636F6C6F723A20236662636534613B0D0A20207374726F6B653A20236662636534613B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203829202E752D636F6C6F72207B';
wwv_flow_api.g_varchar2_table(1090) := '0D0A20206261636B67726F756E642D636F6C6F723A20236564383133653B0D0A202066696C6C3A20236564383133653B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B';
wwv_flow_api.g_varchar2_table(1091) := '203829202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203829202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A2023656438313365';
wwv_flow_api.g_varchar2_table(1092) := '3B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203829202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203829202E752D636F6C6F722D74657874207B';
wwv_flow_api.g_varchar2_table(1093) := '0D0A2020636F6C6F723A20236564383133653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203829202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2038';
wwv_flow_api.g_varchar2_table(1094) := '29202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236564383133653B0D0A20207374726F6B653A20236564383133653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2039';
wwv_flow_api.g_varchar2_table(1095) := '29202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236539356235343B0D0A202066696C6C3A20236539356235343B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E7468';
wwv_flow_api.g_varchar2_table(1096) := '2D6368696C642834356E202B203929202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203929202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F';
wwv_flow_api.g_varchar2_table(1097) := '6C6F723A20236539356235343B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203929202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203929202E752D';
wwv_flow_api.g_varchar2_table(1098) := '636F6C6F722D74657874207B0D0A2020636F6C6F723A20236539356235343B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B203929202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D63';
wwv_flow_api.g_varchar2_table(1099) := '68696C642834356E202B203929202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236539356235343B0D0A20207374726F6B653A20236539356235343B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D63';
wwv_flow_api.g_varchar2_table(1100) := '68696C642834356E202B20313029202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236538356438383B0D0A202066696C6C3A20236538356438383B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D';
wwv_flow_api.g_varchar2_table(1101) := '636F6C6F7273203E203A6E74682D6368696C642834356E202B20313029202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313029202E752D636F6C6F722D6261636B67726F756E64207B0D0A';
wwv_flow_api.g_varchar2_table(1102) := '20206261636B67726F756E642D636F6C6F723A20236538356438383B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313029202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368';
wwv_flow_api.g_varchar2_table(1103) := '696C642834356E202B20313029202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236538356438383B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313029202E752D636F6C6F722D62642C0D0A';
wwv_flow_api.g_varchar2_table(1104) := '2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313029202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236538356438383B0D0A20207374726F6B653A20236538356438383B0D0A7D0D';
wwv_flow_api.g_varchar2_table(1105) := '0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313129202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236361353839643B0D0A202066696C6C3A20236361353839643B0D0A2020636F6C6F';
wwv_flow_api.g_varchar2_table(1106) := '723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313129202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313129202E752D63';
wwv_flow_api.g_varchar2_table(1107) := '6F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236361353839643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313129202E752D636F6C6F722D7478742C0D0A';
wwv_flow_api.g_varchar2_table(1108) := '2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313129202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236361353839643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B';
wwv_flow_api.g_varchar2_table(1109) := '20313129202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313129202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236361353839643B0D0A202073';
wwv_flow_api.g_varchar2_table(1110) := '74726F6B653A20236361353839643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313229202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233835346539623B0D0A202066696C';
wwv_flow_api.g_varchar2_table(1111) := '6C3A20233835346539623B0D0A2020636F6C6F723A20236636663066383B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313229202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D63';
wwv_flow_api.g_varchar2_table(1112) := '68696C642834356E202B20313229202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233835346539623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20';
wwv_flow_api.g_varchar2_table(1113) := '313229202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313229202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233835346539623B0D0A7D0D0A2E752D636F6C6F7273';
wwv_flow_api.g_varchar2_table(1114) := '203E203A6E74682D6368696C642834356E202B20313229202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313229202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D63';
wwv_flow_api.g_varchar2_table(1115) := '6F6C6F723A20233835346539623B0D0A20207374726F6B653A20233835346539623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313329202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C';
wwv_flow_api.g_varchar2_table(1116) := '6F723A20233561363861643B0D0A202066696C6C3A20233561363861643B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313329202E752D636F6C6F722D62672C0D';
wwv_flow_api.g_varchar2_table(1117) := '0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313329202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233561363861643B0D0A7D0D0A2E752D636F6C6F727320';
wwv_flow_api.g_varchar2_table(1118) := '3E203A6E74682D6368696C642834356E202B20313329202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313329202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233561';
wwv_flow_api.g_varchar2_table(1119) := '363861643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313329202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313329202E752D636F6C6F722D62';
wwv_flow_api.g_varchar2_table(1120) := '6F72646572207B0D0A2020626F726465722D636F6C6F723A20233561363861643B0D0A20207374726F6B653A20233561363861643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313429202E752D636F6C6F7220';
wwv_flow_api.g_varchar2_table(1121) := '7B0D0A20206261636B67726F756E642D636F6C6F723A20236166626163353B0D0A202066696C6C3A20236166626163353B0D0A2020636F6C6F723A20233331336134343B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E20';
wwv_flow_api.g_varchar2_table(1122) := '2B20313429202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313429202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A2023616662';
wwv_flow_api.g_varchar2_table(1123) := '6163353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313429202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313429202E752D636F6C6F722D74';
wwv_flow_api.g_varchar2_table(1124) := '657874207B0D0A2020636F6C6F723A20236166626163353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313429202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834';
wwv_flow_api.g_varchar2_table(1125) := '356E202B20313429202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236166626163353B0D0A20207374726F6B653A20236166626163353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C6428';
wwv_flow_api.g_varchar2_table(1126) := '34356E202B20313529202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233665383539383B0D0A202066696C6C3A20233665383539383B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F72';
wwv_flow_api.g_varchar2_table(1127) := '73203E203A6E74682D6368696C642834356E202B20313529202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313529202E752D636F6C6F722D6261636B67726F756E64207B0D0A2020626163';
wwv_flow_api.g_varchar2_table(1128) := '6B67726F756E642D636F6C6F723A20233665383539383B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313529202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834';
wwv_flow_api.g_varchar2_table(1129) := '356E202B20313529202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233665383539383B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313529202E752D636F6C6F722D62642C0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1130) := '6C6F7273203E203A6E74682D6368696C642834356E202B20313529202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233665383539383B0D0A20207374726F6B653A20233665383539383B0D0A7D0D0A2E752D63';
wwv_flow_api.g_varchar2_table(1131) := '6F6C6F7273203E203A6E74682D6368696C642834356E202B20313629202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233539623265323B0D0A202066696C6C3A20233539623265323B0D0A2020636F6C6F723A202366';
wwv_flow_api.g_varchar2_table(1132) := '66666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313629202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313629202E752D636F6C6F722D';
wwv_flow_api.g_varchar2_table(1133) := '6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233539623265323B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313629202E752D636F6C6F722D7478742C0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1134) := '6C6F7273203E203A6E74682D6368696C642834356E202B20313629202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233539623265323B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2031362920';
wwv_flow_api.g_varchar2_table(1135) := '2E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313629202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233539623265323B0D0A20207374726F6B65';
wwv_flow_api.g_varchar2_table(1136) := '3A20233539623265323B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313729202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233432633564393B0D0A202066696C6C3A202334';
wwv_flow_api.g_varchar2_table(1137) := '32633564393B0D0A2020636F6C6F723A20233035313531373B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313729202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C6428';
wwv_flow_api.g_varchar2_table(1138) := '34356E202B20313729202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233432633564393B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313729202E';
wwv_flow_api.g_varchar2_table(1139) := '752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313729202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233432633564393B0D0A7D0D0A2E752D636F6C6F7273203E203A6E';
wwv_flow_api.g_varchar2_table(1140) := '74682D6368696C642834356E202B20313729202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313729202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A';
wwv_flow_api.g_varchar2_table(1141) := '20233432633564393B0D0A20207374726F6B653A20233432633564393B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313829202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(1142) := '3538636363393B0D0A202066696C6C3A20233538636363393B0D0A2020636F6C6F723A20233039316331633B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313829202E752D636F6C6F722D62672C0D0A2E752D63';
wwv_flow_api.g_varchar2_table(1143) := '6F6C6F7273203E203A6E74682D6368696C642834356E202B20313829202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233538636363393B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74';
wwv_flow_api.g_varchar2_table(1144) := '682D6368696C642834356E202B20313829202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313829202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233538636363393B';
wwv_flow_api.g_varchar2_table(1145) := '0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313829202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313829202E752D636F6C6F722D626F72646572';
wwv_flow_api.g_varchar2_table(1146) := '207B0D0A2020626F726465722D636F6C6F723A20233538636363393B0D0A20207374726F6B653A20233538636363393B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313929202E752D636F6C6F72207B0D0A2020';
wwv_flow_api.g_varchar2_table(1147) := '6261636B67726F756E642D636F6C6F723A20233633626639643B0D0A202066696C6C3A20233633626639643B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313929';
wwv_flow_api.g_varchar2_table(1148) := '202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313929202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233633626639643B0D';
wwv_flow_api.g_varchar2_table(1149) := '0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313929202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313929202E752D636F6C6F722D74657874207B';
wwv_flow_api.g_varchar2_table(1150) := '0D0A2020636F6C6F723A20233633626639643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20313929202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20';
wwv_flow_api.g_varchar2_table(1151) := '313929202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233633626639643B0D0A20207374726F6B653A20233633626639643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B';
wwv_flow_api.g_varchar2_table(1152) := '20323029202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233961633937663B0D0A202066696C6C3A20233961633937663B0D0A2020636F6C6F723A20233230333331363B0D0A7D0D0A2E752D636F6C6F7273203E203A';
wwv_flow_api.g_varchar2_table(1153) := '6E74682D6368696C642834356E202B20323029202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323029202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(1154) := '6E642D636F6C6F723A20233961633937663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323029202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20';
wwv_flow_api.g_varchar2_table(1155) := '323029202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233961633937663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323029202E752D636F6C6F722D62642C0D0A2E752D636F6C6F727320';
wwv_flow_api.g_varchar2_table(1156) := '3E203A6E74682D6368696C642834356E202B20323029202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233961633937663B0D0A20207374726F6B653A20233961633937663B0D0A7D0D0A2E752D636F6C6F7273';
wwv_flow_api.g_varchar2_table(1157) := '203E203A6E74682D6368696C642834356E202B20323129202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236534653537353B0D0A202066696C6C3A20236534653537353B0D0A2020636F6C6F723A2023346334633066';
wwv_flow_api.g_varchar2_table(1158) := '3B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323129202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323129202E752D636F6C6F722D6261636B67';
wwv_flow_api.g_varchar2_table(1159) := '726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236534653537353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323129202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F727320';
wwv_flow_api.g_varchar2_table(1160) := '3E203A6E74682D6368696C642834356E202B20323129202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236534653537353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323129202E752D636F';
wwv_flow_api.g_varchar2_table(1161) := '6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323129202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236534653537353B0D0A20207374726F6B653A20236534';
wwv_flow_api.g_varchar2_table(1162) := '653537353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323229202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236663643836653B0D0A202066696C6C3A2023666364383665';
wwv_flow_api.g_varchar2_table(1163) := '3B0D0A2020636F6C6F723A20233639346630323B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323229202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B';
wwv_flow_api.g_varchar2_table(1164) := '20323229202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236663643836653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323229202E752D636F6C';
wwv_flow_api.g_varchar2_table(1165) := '6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323229202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236663643836653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368';
wwv_flow_api.g_varchar2_table(1166) := '696C642834356E202B20323229202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323229202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A2023666364';
wwv_flow_api.g_varchar2_table(1167) := '3836653B0D0A20207374726F6B653A20236663643836653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323329202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236631396136';
wwv_flow_api.g_varchar2_table(1168) := '353B0D0A202066696C6C3A20236631396136353B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323329202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273';
wwv_flow_api.g_varchar2_table(1169) := '203E203A6E74682D6368696C642834356E202B20323329202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236631396136353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D636869';
wwv_flow_api.g_varchar2_table(1170) := '6C642834356E202B20323329202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323329202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236631396136353B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1171) := '2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323329202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323329202E752D636F6C6F722D626F72646572207B0D0A20';
wwv_flow_api.g_varchar2_table(1172) := '20626F726465722D636F6C6F723A20236631396136353B0D0A20207374726F6B653A20236631396136353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323429202E752D636F6C6F72207B0D0A20206261636B67';
wwv_flow_api.g_varchar2_table(1173) := '726F756E642D636F6C6F723A20236564376337363B0D0A202066696C6C3A20236564376337363B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323429202E752D63';
wwv_flow_api.g_varchar2_table(1174) := '6F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323429202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236564376337363B0D0A7D0D0A2E';
wwv_flow_api.g_varchar2_table(1175) := '752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323429202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323429202E752D636F6C6F722D74657874207B0D0A202063';
wwv_flow_api.g_varchar2_table(1176) := '6F6C6F723A20236564376337363B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323429202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323429202E';
wwv_flow_api.g_varchar2_table(1177) := '752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236564376337363B0D0A20207374726F6B653A20236564376337363B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2032352920';
wwv_flow_api.g_varchar2_table(1178) := '2E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236564376461303B0D0A202066696C6C3A20236564376461303B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D63';
wwv_flow_api.g_varchar2_table(1179) := '68696C642834356E202B20323529202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323529202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F';
wwv_flow_api.g_varchar2_table(1180) := '6C6F723A20236564376461303B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323529202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323529202E';
wwv_flow_api.g_varchar2_table(1181) := '752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236564376461303B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323529202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74';
wwv_flow_api.g_varchar2_table(1182) := '682D6368696C642834356E202B20323529202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236564376461303B0D0A20207374726F6B653A20236564376461303B0D0A7D0D0A2E752D636F6C6F7273203E203A6E';
wwv_flow_api.g_varchar2_table(1183) := '74682D6368696C642834356E202B20323629202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236435373962313B0D0A202066696C6C3A20236435373962313B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D';
wwv_flow_api.g_varchar2_table(1184) := '0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323629202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323629202E752D636F6C6F722D6261636B67726F756E64';
wwv_flow_api.g_varchar2_table(1185) := '207B0D0A20206261636B67726F756E642D636F6C6F723A20236435373962313B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323629202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74';
wwv_flow_api.g_varchar2_table(1186) := '682D6368696C642834356E202B20323629202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236435373962313B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323629202E752D636F6C6F722D62';
wwv_flow_api.g_varchar2_table(1187) := '642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323629202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236435373962313B0D0A20207374726F6B653A20236435373962313B';
wwv_flow_api.g_varchar2_table(1188) := '0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323729202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233964373161663B0D0A202066696C6C3A20233964373161663B0D0A2020';
wwv_flow_api.g_varchar2_table(1189) := '636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323729202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2032372920';
wwv_flow_api.g_varchar2_table(1190) := '2E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233964373161663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323729202E752D636F6C6F722D7478';
wwv_flow_api.g_varchar2_table(1191) := '742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323729202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233964373161663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834';
wwv_flow_api.g_varchar2_table(1192) := '356E202B20323729202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323729202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233964373161663B0D';
wwv_flow_api.g_varchar2_table(1193) := '0A20207374726F6B653A20233964373161663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323829202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233762383662643B0D0A20';
wwv_flow_api.g_varchar2_table(1194) := '2066696C6C3A20233762383662643B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323829202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E';
wwv_flow_api.g_varchar2_table(1195) := '74682D6368696C642834356E202B20323829202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233762383662643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C64283435';
wwv_flow_api.g_varchar2_table(1196) := '6E202B20323829202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323829202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233762383662643B0D0A7D0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1197) := '6C6F7273203E203A6E74682D6368696C642834356E202B20323829202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323829202E752D636F6C6F722D626F72646572207B0D0A2020626F7264';
wwv_flow_api.g_varchar2_table(1198) := '65722D636F6C6F723A20233762383662643B0D0A20207374726F6B653A20233762383662643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323929202E752D636F6C6F72207B0D0A20206261636B67726F756E64';
wwv_flow_api.g_varchar2_table(1199) := '2D636F6C6F723A20236266633864313B0D0A202066696C6C3A20236266633864313B0D0A2020636F6C6F723A20233364343835343B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323929202E752D636F6C6F722D';
wwv_flow_api.g_varchar2_table(1200) := '62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323929202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236266633864313B0D0A7D0D0A2E752D636F6C';
wwv_flow_api.g_varchar2_table(1201) := '6F7273203E203A6E74682D6368696C642834356E202B20323929202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323929202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(1202) := '20236266633864313B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323929202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20323929202E752D636F6C';
wwv_flow_api.g_varchar2_table(1203) := '6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236266633864313B0D0A20207374726F6B653A20236266633864313B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333029202E752D636F';
wwv_flow_api.g_varchar2_table(1204) := '6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233862396461643B0D0A202066696C6C3A20233862396461643B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C6428';
wwv_flow_api.g_varchar2_table(1205) := '34356E202B20333029202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333029202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1206) := '233862396461643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333029202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333029202E752D636F6C';
wwv_flow_api.g_varchar2_table(1207) := '6F722D74657874207B0D0A2020636F6C6F723A20233862396461643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333029202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D636869';
wwv_flow_api.g_varchar2_table(1208) := '6C642834356E202B20333029202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233862396461643B0D0A20207374726F6B653A20233862396461643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368';
wwv_flow_api.g_varchar2_table(1209) := '696C642834356E202B20333129202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233139386363613B0D0A202066696C6C3A20233139386363613B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D63';
wwv_flow_api.g_varchar2_table(1210) := '6F6C6F7273203E203A6E74682D6368696C642834356E202B20333129202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333129202E752D636F6C6F722D6261636B67726F756E64207B0D0A20';
wwv_flow_api.g_varchar2_table(1211) := '206261636B67726F756E642D636F6C6F723A20233139386363613B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333129202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D636869';
wwv_flow_api.g_varchar2_table(1212) := '6C642834356E202B20333129202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233139386363613B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333129202E752D636F6C6F722D62642C0D0A2E';
wwv_flow_api.g_varchar2_table(1213) := '752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333129202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233139386363613B0D0A20207374726F6B653A20233139386363613B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1214) := '2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333229202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233032613562653B0D0A202066696C6C3A20233032613562653B0D0A2020636F6C6F72';
wwv_flow_api.g_varchar2_table(1215) := '3A20233030303030303B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333229202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333229202E752D636F';
wwv_flow_api.g_varchar2_table(1216) := '6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233032613562653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333229202E752D636F6C6F722D7478742C0D0A2E';
wwv_flow_api.g_varchar2_table(1217) := '752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333229202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233032613562653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20';
wwv_flow_api.g_varchar2_table(1218) := '333229202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333229202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233032613562653B0D0A20207374';
wwv_flow_api.g_varchar2_table(1219) := '726F6B653A20233032613562653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333329202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233138623161653B0D0A202066696C6C';
wwv_flow_api.g_varchar2_table(1220) := '3A20233138623161653B0D0A2020636F6C6F723A20233030303030303B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333329202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368';
wwv_flow_api.g_varchar2_table(1221) := '696C642834356E202B20333329202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233138623161653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2033';
wwv_flow_api.g_varchar2_table(1222) := '3329202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333329202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233138623161653B0D0A7D0D0A2E752D636F6C6F727320';
wwv_flow_api.g_varchar2_table(1223) := '3E203A6E74682D6368696C642834356E202B20333329202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333329202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F';
wwv_flow_api.g_varchar2_table(1224) := '6C6F723A20233138623161653B0D0A20207374726F6B653A20233138623161653B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333429202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F';
wwv_flow_api.g_varchar2_table(1225) := '723A20233234613437353B0D0A202066696C6C3A20233234613437353B0D0A2020636F6C6F723A20236566666266373B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333429202E752D636F6C6F722D62672C0D0A';
wwv_flow_api.g_varchar2_table(1226) := '2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333429202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233234613437353B0D0A7D0D0A2E752D636F6C6F7273203E';
wwv_flow_api.g_varchar2_table(1227) := '203A6E74682D6368696C642834356E202B20333429202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333429202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A2023323461';
wwv_flow_api.g_varchar2_table(1228) := '3437353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333429202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333429202E752D636F6C6F722D626F';
wwv_flow_api.g_varchar2_table(1229) := '72646572207B0D0A2020626F726465722D636F6C6F723A20233234613437353B0D0A20207374726F6B653A20233234613437353B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333529202E752D636F6C6F72207B';
wwv_flow_api.g_varchar2_table(1230) := '0D0A20206261636B67726F756E642D636F6C6F723A20233661616434323B0D0A202066696C6C3A20233661616434323B0D0A2020636F6C6F723A20233063313530363B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B';
wwv_flow_api.g_varchar2_table(1231) := '20333529202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333529202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A202336616164';
wwv_flow_api.g_varchar2_table(1232) := '34323B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333529202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333529202E752D636F6C6F722D7465';
wwv_flow_api.g_varchar2_table(1233) := '7874207B0D0A2020636F6C6F723A20233661616434323B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333529202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C64283435';
wwv_flow_api.g_varchar2_table(1234) := '6E202B20333529202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233661616434323B0D0A20207374726F6B653A20233661616434323B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834';
wwv_flow_api.g_varchar2_table(1235) := '356E202B20333629202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236339636133393B0D0A202066696C6C3A20236339636133393B0D0A2020636F6C6F723A20233264326530343B0D0A7D0D0A2E752D636F6C6F7273';
wwv_flow_api.g_varchar2_table(1236) := '203E203A6E74682D6368696C642834356E202B20333629202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333629202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B';
wwv_flow_api.g_varchar2_table(1237) := '67726F756E642D636F6C6F723A20236339636133393B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333629202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C64283435';
wwv_flow_api.g_varchar2_table(1238) := '6E202B20333629202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236339636133393B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333629202E752D636F6C6F722D62642C0D0A2E752D636F6C';
wwv_flow_api.g_varchar2_table(1239) := '6F7273203E203A6E74682D6368696C642834356E202B20333629202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236339636133393B0D0A20207374726F6B653A20236339636133393B0D0A7D0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1240) := '6C6F7273203E203A6E74682D6368696C642834356E202B20333729202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236439623133623B0D0A202066696C6C3A20236439623133623B0D0A2020636F6C6F723A20233436';
wwv_flow_api.g_varchar2_table(1241) := '333430303B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333729202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333729202E752D636F6C6F722D62';
wwv_flow_api.g_varchar2_table(1242) := '61636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236439623133623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333729202E752D636F6C6F722D7478742C0D0A2E752D636F6C';
wwv_flow_api.g_varchar2_table(1243) := '6F7273203E203A6E74682D6368696C642834356E202B20333729202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236439623133623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333729202E';
wwv_flow_api.g_varchar2_table(1244) := '752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333729202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236439623133623B0D0A20207374726F6B653A';
wwv_flow_api.g_varchar2_table(1245) := '20236439623133623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333829202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236437366132373B0D0A202066696C6C3A20236437';
wwv_flow_api.g_varchar2_table(1246) := '366132373B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333829202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834';
wwv_flow_api.g_varchar2_table(1247) := '356E202B20333829202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236437366132373B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333829202E75';
wwv_flow_api.g_varchar2_table(1248) := '2D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333829202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236437366132373B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74';
wwv_flow_api.g_varchar2_table(1249) := '682D6368696C642834356E202B20333829202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333829202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1250) := '236437366132373B0D0A20207374726F6B653A20236437366132373B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333929202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A202364';
wwv_flow_api.g_varchar2_table(1251) := '32343233623B0D0A202066696C6C3A20236432343233623B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333929202E752D636F6C6F722D62672C0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1252) := '6C6F7273203E203A6E74682D6368696C642834356E202B20333929202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236432343233623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E7468';
wwv_flow_api.g_varchar2_table(1253) := '2D6368696C642834356E202B20333929202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333929202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236432343233623B0D';
wwv_flow_api.g_varchar2_table(1254) := '0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333929202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20333929202E752D636F6C6F722D626F7264657220';
wwv_flow_api.g_varchar2_table(1255) := '7B0D0A2020626F726465722D636F6C6F723A20236432343233623B0D0A20207374726F6B653A20236432343233623B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343029202E752D636F6C6F72207B0D0A202062';
wwv_flow_api.g_varchar2_table(1256) := '61636B67726F756E642D636F6C6F723A20236431343336663B0D0A202066696C6C3A20236431343336663B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2034302920';
wwv_flow_api.g_varchar2_table(1257) := '2E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343029202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236431343336663B0D0A';
wwv_flow_api.g_varchar2_table(1258) := '7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343029202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343029202E752D636F6C6F722D74657874207B0D';
wwv_flow_api.g_varchar2_table(1259) := '0A2020636F6C6F723A20236431343336663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343029202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2034';
wwv_flow_api.g_varchar2_table(1260) := '3029202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236431343336663B0D0A20207374726F6B653A20236431343336663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20';
wwv_flow_api.g_varchar2_table(1261) := '343129202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20236261336438383B0D0A202066696C6C3A20236261336438383B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E';
wwv_flow_api.g_varchar2_table(1262) := '74682D6368696C642834356E202B20343129202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343129202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E';
wwv_flow_api.g_varchar2_table(1263) := '642D636F6C6F723A20236261336438383B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343129202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B2034';
wwv_flow_api.g_varchar2_table(1264) := '3129202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20236261336438383B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343129202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E';
wwv_flow_api.g_varchar2_table(1265) := '203A6E74682D6368696C642834356E202B20343129202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236261336438383B0D0A20207374726F6B653A20236261336438383B0D0A7D0D0A2E752D636F6C6F727320';
wwv_flow_api.g_varchar2_table(1266) := '3E203A6E74682D6368696C642834356E202B20343229202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233737333339333B0D0A202066696C6C3A20233737333339333B0D0A2020636F6C6F723A20236636656666393B';
wwv_flow_api.g_varchar2_table(1267) := '0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343229202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343229202E752D636F6C6F722D6261636B6772';
wwv_flow_api.g_varchar2_table(1268) := '6F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233737333339333B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343229202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E';
wwv_flow_api.g_varchar2_table(1269) := '203A6E74682D6368696C642834356E202B20343229202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233737333339333B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343229202E752D636F6C';
wwv_flow_api.g_varchar2_table(1270) := '6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343229202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233737333339333B0D0A20207374726F6B653A2023373733';
wwv_flow_api.g_varchar2_table(1271) := '3339333B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343329202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A20233364346561333B0D0A202066696C6C3A20233364346561333B';
wwv_flow_api.g_varchar2_table(1272) := '0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343329202E752D636F6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20';
wwv_flow_api.g_varchar2_table(1273) := '343329202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233364346561333B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343329202E752D636F6C6F';
wwv_flow_api.g_varchar2_table(1274) := '722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343329202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233364346561333B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D636869';
wwv_flow_api.g_varchar2_table(1275) := '6C642834356E202B20343329202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343329202E752D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A202333643465';
wwv_flow_api.g_varchar2_table(1276) := '61333B0D0A20207374726F6B653A20233364346561333B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343429202E752D636F6C6F72207B0D0A20206261636B67726F756E642D636F6C6F723A2023386339656230';
wwv_flow_api.g_varchar2_table(1277) := '3B0D0A202066696C6C3A20233863396562303B0D0A2020636F6C6F723A20233238336134643B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343429202E752D636F6C6F722D62672C0D0A2E752D636F6C6F727320';
wwv_flow_api.g_varchar2_table(1278) := '3E203A6E74682D6368696C642834356E202B20343429202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233863396562303B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C';
wwv_flow_api.g_varchar2_table(1279) := '642834356E202B20343429202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343429202E752D636F6C6F722D74657874207B0D0A2020636F6C6F723A20233863396562303B0D0A7D0D0A2E';
wwv_flow_api.g_varchar2_table(1280) := '752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343429202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343429202E752D636F6C6F722D626F72646572207B0D0A2020';
wwv_flow_api.g_varchar2_table(1281) := '626F726465722D636F6C6F723A20233863396562303B0D0A20207374726F6B653A20233863396562303B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343529202E752D636F6C6F72207B0D0A20206261636B6772';
wwv_flow_api.g_varchar2_table(1282) := '6F756E642D636F6C6F723A20233465373339313B0D0A202066696C6C3A20233465373339313B0D0A2020636F6C6F723A20236666666666663B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343529202E752D636F';
wwv_flow_api.g_varchar2_table(1283) := '6C6F722D62672C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343529202E752D636F6C6F722D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233465373339313B0D0A7D0D0A2E75';
wwv_flow_api.g_varchar2_table(1284) := '2D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343529202E752D636F6C6F722D7478742C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343529202E752D636F6C6F722D74657874207B0D0A2020636F';
wwv_flow_api.g_varchar2_table(1285) := '6C6F723A20233465373339313B0D0A7D0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343529202E752D636F6C6F722D62642C0D0A2E752D636F6C6F7273203E203A6E74682D6368696C642834356E202B20343529202E75';
wwv_flow_api.g_varchar2_table(1286) := '2D636F6C6F722D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233465373339313B0D0A20207374726F6B653A20233465373339313B0D0A7D0D0A0D0A2E752D636F6C6F722D31207B0D0A20206261636B67726F756E642D636F6C6F72';
wwv_flow_api.g_varchar2_table(1287) := '3A20233330396664622021696D706F7274616E743B0D0A202066696C6C3A20233330396664622021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D312D62672C0D';
wwv_flow_api.g_varchar2_table(1288) := '0A2E752D636F6C6F722D312D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233330396664622021696D706F7274616E743B0D0A202066696C6C3A20233330396664622021696D706F7274616E743B0D0A7D0D0A2E';
wwv_flow_api.g_varchar2_table(1289) := '752D636F6C6F722D312D7478742C0D0A2E752D636F6C6F722D312D74657874207B0D0A2020636F6C6F723A20233330396664622021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D312D62642C0D0A2E752D636F6C6F722D312D626F726465';
wwv_flow_api.g_varchar2_table(1290) := '72207B0D0A2020626F726465722D636F6C6F723A20233330396664622021696D706F7274616E743B0D0A20207374726F6B653A20233330396664622021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(1291) := '6E642D636F6C6F723A20233133623663662021696D706F7274616E743B0D0A202066696C6C3A20233133623663662021696D706F7274616E743B0D0A2020636F6C6F723A20236534663966642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F';
wwv_flow_api.g_varchar2_table(1292) := '722D322D62672C0D0A2E752D636F6C6F722D322D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233133623663662021696D706F7274616E743B0D0A202066696C6C3A20233133623663662021696D706F7274616E';
wwv_flow_api.g_varchar2_table(1293) := '743B0D0A7D0D0A2E752D636F6C6F722D322D7478742C0D0A2E752D636F6C6F722D322D74657874207B0D0A2020636F6C6F723A20233133623663662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D322D62642C0D0A2E752D636F6C6F72';
wwv_flow_api.g_varchar2_table(1294) := '2D322D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233133623663662021696D706F7274616E743B0D0A20207374726F6B653A20233133623663662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33207B0D0A2020';
wwv_flow_api.g_varchar2_table(1295) := '6261636B67726F756E642D636F6C6F723A20233265626662632021696D706F7274616E743B0D0A202066696C6C3A20233265626662632021696D706F7274616E743B0D0A2020636F6C6F723A20236630666366622021696D706F7274616E743B0D0A7D0D';
wwv_flow_api.g_varchar2_table(1296) := '0A2E752D636F6C6F722D332D62672C0D0A2E752D636F6C6F722D332D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233265626662632021696D706F7274616E743B0D0A202066696C6C3A20233265626662632021';
wwv_flow_api.g_varchar2_table(1297) := '696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D332D7478742C0D0A2E752D636F6C6F722D332D74657874207B0D0A2020636F6C6F723A20233265626662632021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D332D62642C0D0A';
wwv_flow_api.g_varchar2_table(1298) := '2E752D636F6C6F722D332D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233265626662632021696D706F7274616E743B0D0A20207374726F6B653A20233265626662632021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F72';
wwv_flow_api.g_varchar2_table(1299) := '2D34207B0D0A20206261636B67726F756E642D636F6C6F723A20233363616638352021696D706F7274616E743B0D0A202066696C6C3A20233363616638352021696D706F7274616E743B0D0A2020636F6C6F723A20236630666166362021696D706F7274';
wwv_flow_api.g_varchar2_table(1300) := '616E743B0D0A7D0D0A2E752D636F6C6F722D342D62672C0D0A2E752D636F6C6F722D342D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233363616638352021696D706F7274616E743B0D0A202066696C6C3A2023';
wwv_flow_api.g_varchar2_table(1301) := '3363616638352021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D342D7478742C0D0A2E752D636F6C6F722D342D74657874207B0D0A2020636F6C6F723A20233363616638352021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F72';
wwv_flow_api.g_varchar2_table(1302) := '2D342D62642C0D0A2E752D636F6C6F722D342D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233363616638352021696D706F7274616E743B0D0A20207374726F6B653A20233363616638352021696D706F7274616E743B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1303) := '2E752D636F6C6F722D35207B0D0A20206261636B67726F756E642D636F6C6F723A20233831626235662021696D706F7274616E743B0D0A202066696C6C3A20233831626235662021696D706F7274616E743B0D0A2020636F6C6F723A2023666666666666';
wwv_flow_api.g_varchar2_table(1304) := '2021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D352D62672C0D0A2E752D636F6C6F722D352D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233831626235662021696D706F7274616E743B0D0A20';
wwv_flow_api.g_varchar2_table(1305) := '2066696C6C3A20233831626235662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D352D7478742C0D0A2E752D636F6C6F722D352D74657874207B0D0A2020636F6C6F723A20233831626235662021696D706F7274616E743B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1306) := '2E752D636F6C6F722D352D62642C0D0A2E752D636F6C6F722D352D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233831626235662021696D706F7274616E743B0D0A20207374726F6B653A20233831626235662021696D706F727461';
wwv_flow_api.g_varchar2_table(1307) := '6E743B0D0A7D0D0A2E752D636F6C6F722D36207B0D0A20206261636B67726F756E642D636F6C6F723A20236464646535332021696D706F7274616E743B0D0A202066696C6C3A20236464646535332021696D706F7274616E743B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(1308) := '20233261326130382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D362D62672C0D0A2E752D636F6C6F722D362D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236464646535332021696D706F72';
wwv_flow_api.g_varchar2_table(1309) := '74616E743B0D0A202066696C6C3A20236464646535332021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D362D7478742C0D0A2E752D636F6C6F722D362D74657874207B0D0A2020636F6C6F723A20236464646535332021696D706F727461';
wwv_flow_api.g_varchar2_table(1310) := '6E743B0D0A7D0D0A2E752D636F6C6F722D362D62642C0D0A2E752D636F6C6F722D362D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236464646535332021696D706F7274616E743B0D0A20207374726F6B653A202364646465353320';
wwv_flow_api.g_varchar2_table(1311) := '21696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D37207B0D0A20206261636B67726F756E642D636F6C6F723A20236662636534612021696D706F7274616E743B0D0A202066696C6C3A20236662636534612021696D706F7274616E743B0D0A';
wwv_flow_api.g_varchar2_table(1312) := '2020636F6C6F723A20233434333330322021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D372D62672C0D0A2E752D636F6C6F722D372D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236662636534';
wwv_flow_api.g_varchar2_table(1313) := '612021696D706F7274616E743B0D0A202066696C6C3A20236662636534612021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D372D7478742C0D0A2E752D636F6C6F722D372D74657874207B0D0A2020636F6C6F723A202366626365346120';
wwv_flow_api.g_varchar2_table(1314) := '21696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D372D62642C0D0A2E752D636F6C6F722D372D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236662636534612021696D706F7274616E743B0D0A20207374726F6B653A20';
wwv_flow_api.g_varchar2_table(1315) := '236662636534612021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D38207B0D0A20206261636B67726F756E642D636F6C6F723A20236564383133652021696D706F7274616E743B0D0A202066696C6C3A20236564383133652021696D706F';
wwv_flow_api.g_varchar2_table(1316) := '7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D382D62672C0D0A2E752D636F6C6F722D382D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F72';
wwv_flow_api.g_varchar2_table(1317) := '3A20236564383133652021696D706F7274616E743B0D0A202066696C6C3A20236564383133652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D382D7478742C0D0A2E752D636F6C6F722D382D74657874207B0D0A2020636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1318) := '236564383133652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D382D62642C0D0A2E752D636F6C6F722D382D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236564383133652021696D706F7274616E743B0D0A2020';
wwv_flow_api.g_varchar2_table(1319) := '7374726F6B653A20236564383133652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D39207B0D0A20206261636B67726F756E642D636F6C6F723A20236539356235342021696D706F7274616E743B0D0A202066696C6C3A202365393562';
wwv_flow_api.g_varchar2_table(1320) := '35342021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D392D62672C0D0A2E752D636F6C6F722D392D6261636B67726F756E64207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(1321) := '6E642D636F6C6F723A20236539356235342021696D706F7274616E743B0D0A202066696C6C3A20236539356235342021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D392D7478742C0D0A2E752D636F6C6F722D392D74657874207B0D0A20';
wwv_flow_api.g_varchar2_table(1322) := '20636F6C6F723A20236539356235342021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D392D62642C0D0A2E752D636F6C6F722D392D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236539356235342021696D706F7274';
wwv_flow_api.g_varchar2_table(1323) := '616E743B0D0A20207374726F6B653A20236539356235342021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3130207B0D0A20206261636B67726F756E642D636F6C6F723A20236538356438382021696D706F7274616E743B0D0A20206669';
wwv_flow_api.g_varchar2_table(1324) := '6C6C3A20236538356438382021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31302D62672C0D0A2E752D636F6C6F722D31302D6261636B67726F756E64207B0D';
wwv_flow_api.g_varchar2_table(1325) := '0A20206261636B67726F756E642D636F6C6F723A20236538356438382021696D706F7274616E743B0D0A202066696C6C3A20236538356438382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31302D7478742C0D0A2E752D636F6C6F72';
wwv_flow_api.g_varchar2_table(1326) := '2D31302D74657874207B0D0A2020636F6C6F723A20236538356438382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31302D62642C0D0A2E752D636F6C6F722D31302D626F72646572207B0D0A2020626F726465722D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1327) := '236538356438382021696D706F7274616E743B0D0A20207374726F6B653A20236538356438382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3131207B0D0A20206261636B67726F756E642D636F6C6F723A2023636135383964202169';
wwv_flow_api.g_varchar2_table(1328) := '6D706F7274616E743B0D0A202066696C6C3A20236361353839642021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31312D62672C0D0A2E752D636F6C6F722D31';
wwv_flow_api.g_varchar2_table(1329) := '312D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236361353839642021696D706F7274616E743B0D0A202066696C6C3A20236361353839642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3131';
wwv_flow_api.g_varchar2_table(1330) := '2D7478742C0D0A2E752D636F6C6F722D31312D74657874207B0D0A2020636F6C6F723A20236361353839642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31312D62642C0D0A2E752D636F6C6F722D31312D626F72646572207B0D0A20';
wwv_flow_api.g_varchar2_table(1331) := '20626F726465722D636F6C6F723A20236361353839642021696D706F7274616E743B0D0A20207374726F6B653A20236361353839642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3132207B0D0A20206261636B67726F756E642D636F';
wwv_flow_api.g_varchar2_table(1332) := '6C6F723A20233835346539622021696D706F7274616E743B0D0A202066696C6C3A20233835346539622021696D706F7274616E743B0D0A2020636F6C6F723A20236636663066382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31322D';
wwv_flow_api.g_varchar2_table(1333) := '62672C0D0A2E752D636F6C6F722D31322D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233835346539622021696D706F7274616E743B0D0A202066696C6C3A20233835346539622021696D706F7274616E743B0D';
wwv_flow_api.g_varchar2_table(1334) := '0A7D0D0A2E752D636F6C6F722D31322D7478742C0D0A2E752D636F6C6F722D31322D74657874207B0D0A2020636F6C6F723A20233835346539622021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31322D62642C0D0A2E752D636F6C6F72';
wwv_flow_api.g_varchar2_table(1335) := '2D31322D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233835346539622021696D706F7274616E743B0D0A20207374726F6B653A20233835346539622021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3133207B0D0A';
wwv_flow_api.g_varchar2_table(1336) := '20206261636B67726F756E642D636F6C6F723A20233561363861642021696D706F7274616E743B0D0A202066696C6C3A20233561363861642021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A';
wwv_flow_api.g_varchar2_table(1337) := '7D0D0A2E752D636F6C6F722D31332D62672C0D0A2E752D636F6C6F722D31332D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233561363861642021696D706F7274616E743B0D0A202066696C6C3A202335613638';
wwv_flow_api.g_varchar2_table(1338) := '61642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31332D7478742C0D0A2E752D636F6C6F722D31332D74657874207B0D0A2020636F6C6F723A20233561363861642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31';
wwv_flow_api.g_varchar2_table(1339) := '332D62642C0D0A2E752D636F6C6F722D31332D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233561363861642021696D706F7274616E743B0D0A20207374726F6B653A20233561363861642021696D706F7274616E743B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1340) := '2E752D636F6C6F722D3134207B0D0A20206261636B67726F756E642D636F6C6F723A20236166626163352021696D706F7274616E743B0D0A202066696C6C3A20236166626163352021696D706F7274616E743B0D0A2020636F6C6F723A20233331336134';
wwv_flow_api.g_varchar2_table(1341) := '342021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31342D62672C0D0A2E752D636F6C6F722D31342D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236166626163352021696D706F7274616E743B';
wwv_flow_api.g_varchar2_table(1342) := '0D0A202066696C6C3A20236166626163352021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31342D7478742C0D0A2E752D636F6C6F722D31342D74657874207B0D0A2020636F6C6F723A20236166626163352021696D706F7274616E743B';
wwv_flow_api.g_varchar2_table(1343) := '0D0A7D0D0A2E752D636F6C6F722D31342D62642C0D0A2E752D636F6C6F722D31342D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236166626163352021696D706F7274616E743B0D0A20207374726F6B653A20236166626163352021';
wwv_flow_api.g_varchar2_table(1344) := '696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3135207B0D0A20206261636B67726F756E642D636F6C6F723A20233665383539382021696D706F7274616E743B0D0A202066696C6C3A20233665383539382021696D706F7274616E743B0D0A';
wwv_flow_api.g_varchar2_table(1345) := '2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31352D62672C0D0A2E752D636F6C6F722D31352D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A2023366538';
wwv_flow_api.g_varchar2_table(1346) := '3539382021696D706F7274616E743B0D0A202066696C6C3A20233665383539382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31352D7478742C0D0A2E752D636F6C6F722D31352D74657874207B0D0A2020636F6C6F723A2023366538';
wwv_flow_api.g_varchar2_table(1347) := '3539382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31352D62642C0D0A2E752D636F6C6F722D31352D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233665383539382021696D706F7274616E743B0D0A20207374';
wwv_flow_api.g_varchar2_table(1348) := '726F6B653A20233665383539382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3136207B0D0A20206261636B67726F756E642D636F6C6F723A20233539623265322021696D706F7274616E743B0D0A202066696C6C3A20233539623265';
wwv_flow_api.g_varchar2_table(1349) := '322021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31362D62672C0D0A2E752D636F6C6F722D31362D6261636B67726F756E64207B0D0A20206261636B67726F';
wwv_flow_api.g_varchar2_table(1350) := '756E642D636F6C6F723A20233539623265322021696D706F7274616E743B0D0A202066696C6C3A20233539623265322021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31362D7478742C0D0A2E752D636F6C6F722D31362D74657874207B';
wwv_flow_api.g_varchar2_table(1351) := '0D0A2020636F6C6F723A20233539623265322021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31362D62642C0D0A2E752D636F6C6F722D31362D626F72646572207B0D0A2020626F726465722D636F6C6F723A2023353962326532202169';
wwv_flow_api.g_varchar2_table(1352) := '6D706F7274616E743B0D0A20207374726F6B653A20233539623265322021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3137207B0D0A20206261636B67726F756E642D636F6C6F723A20233432633564392021696D706F7274616E743B0D';
wwv_flow_api.g_varchar2_table(1353) := '0A202066696C6C3A20233432633564392021696D706F7274616E743B0D0A2020636F6C6F723A20233035313531372021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31372D62672C0D0A2E752D636F6C6F722D31372D6261636B67726F75';
wwv_flow_api.g_varchar2_table(1354) := '6E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233432633564392021696D706F7274616E743B0D0A202066696C6C3A20233432633564392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31372D7478742C0D0A2E752D';
wwv_flow_api.g_varchar2_table(1355) := '636F6C6F722D31372D74657874207B0D0A2020636F6C6F723A20233432633564392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31372D62642C0D0A2E752D636F6C6F722D31372D626F72646572207B0D0A2020626F726465722D636F';
wwv_flow_api.g_varchar2_table(1356) := '6C6F723A20233432633564392021696D706F7274616E743B0D0A20207374726F6B653A20233432633564392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3138207B0D0A20206261636B67726F756E642D636F6C6F723A202335386363';
wwv_flow_api.g_varchar2_table(1357) := '63392021696D706F7274616E743B0D0A202066696C6C3A20233538636363392021696D706F7274616E743B0D0A2020636F6C6F723A20233039316331632021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31382D62672C0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1358) := '6C6F722D31382D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233538636363392021696D706F7274616E743B0D0A202066696C6C3A20233538636363392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C';
wwv_flow_api.g_varchar2_table(1359) := '6F722D31382D7478742C0D0A2E752D636F6C6F722D31382D74657874207B0D0A2020636F6C6F723A20233538636363392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31382D62642C0D0A2E752D636F6C6F722D31382D626F72646572';
wwv_flow_api.g_varchar2_table(1360) := '207B0D0A2020626F726465722D636F6C6F723A20233538636363392021696D706F7274616E743B0D0A20207374726F6B653A20233538636363392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3139207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(1361) := '6E642D636F6C6F723A20233633626639642021696D706F7274616E743B0D0A202066696C6C3A20233633626639642021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F';
wwv_flow_api.g_varchar2_table(1362) := '722D31392D62672C0D0A2E752D636F6C6F722D31392D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233633626639642021696D706F7274616E743B0D0A202066696C6C3A20233633626639642021696D706F7274';
wwv_flow_api.g_varchar2_table(1363) := '616E743B0D0A7D0D0A2E752D636F6C6F722D31392D7478742C0D0A2E752D636F6C6F722D31392D74657874207B0D0A2020636F6C6F723A20233633626639642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D31392D62642C0D0A2E752D';
wwv_flow_api.g_varchar2_table(1364) := '636F6C6F722D31392D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233633626639642021696D706F7274616E743B0D0A20207374726F6B653A20233633626639642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32';
wwv_flow_api.g_varchar2_table(1365) := '30207B0D0A20206261636B67726F756E642D636F6C6F723A20233961633937662021696D706F7274616E743B0D0A202066696C6C3A20233961633937662021696D706F7274616E743B0D0A2020636F6C6F723A20233230333331362021696D706F727461';
wwv_flow_api.g_varchar2_table(1366) := '6E743B0D0A7D0D0A2E752D636F6C6F722D32302D62672C0D0A2E752D636F6C6F722D32302D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233961633937662021696D706F7274616E743B0D0A202066696C6C3A20';
wwv_flow_api.g_varchar2_table(1367) := '233961633937662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32302D7478742C0D0A2E752D636F6C6F722D32302D74657874207B0D0A2020636F6C6F723A20233961633937662021696D706F7274616E743B0D0A7D0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1368) := '6C6F722D32302D62642C0D0A2E752D636F6C6F722D32302D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233961633937662021696D706F7274616E743B0D0A20207374726F6B653A20233961633937662021696D706F7274616E743B';
wwv_flow_api.g_varchar2_table(1369) := '0D0A7D0D0A2E752D636F6C6F722D3231207B0D0A20206261636B67726F756E642D636F6C6F723A20236534653537352021696D706F7274616E743B0D0A202066696C6C3A20236534653537352021696D706F7274616E743B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(1370) := '3463346330662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32312D62672C0D0A2E752D636F6C6F722D32312D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236534653537352021696D706F72';
wwv_flow_api.g_varchar2_table(1371) := '74616E743B0D0A202066696C6C3A20236534653537352021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32312D7478742C0D0A2E752D636F6C6F722D32312D74657874207B0D0A2020636F6C6F723A20236534653537352021696D706F72';
wwv_flow_api.g_varchar2_table(1372) := '74616E743B0D0A7D0D0A2E752D636F6C6F722D32312D62642C0D0A2E752D636F6C6F722D32312D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236534653537352021696D706F7274616E743B0D0A20207374726F6B653A2023653465';
wwv_flow_api.g_varchar2_table(1373) := '3537352021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3232207B0D0A20206261636B67726F756E642D636F6C6F723A20236663643836652021696D706F7274616E743B0D0A202066696C6C3A20236663643836652021696D706F727461';
wwv_flow_api.g_varchar2_table(1374) := '6E743B0D0A2020636F6C6F723A20233639346630322021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32322D62672C0D0A2E752D636F6C6F722D32322D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A';
wwv_flow_api.g_varchar2_table(1375) := '20236663643836652021696D706F7274616E743B0D0A202066696C6C3A20236663643836652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32322D7478742C0D0A2E752D636F6C6F722D32322D74657874207B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(1376) := '20236663643836652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32322D62642C0D0A2E752D636F6C6F722D32322D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236663643836652021696D706F7274616E743B0D';
wwv_flow_api.g_varchar2_table(1377) := '0A20207374726F6B653A20236663643836652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3233207B0D0A20206261636B67726F756E642D636F6C6F723A20236631396136352021696D706F7274616E743B0D0A202066696C6C3A2023';
wwv_flow_api.g_varchar2_table(1378) := '6631396136352021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32332D62672C0D0A2E752D636F6C6F722D32332D6261636B67726F756E64207B0D0A20206261';
wwv_flow_api.g_varchar2_table(1379) := '636B67726F756E642D636F6C6F723A20236631396136352021696D706F7274616E743B0D0A202066696C6C3A20236631396136352021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32332D7478742C0D0A2E752D636F6C6F722D32332D74';
wwv_flow_api.g_varchar2_table(1380) := '657874207B0D0A2020636F6C6F723A20236631396136352021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32332D62642C0D0A2E752D636F6C6F722D32332D626F72646572207B0D0A2020626F726465722D636F6C6F723A202366313961';
wwv_flow_api.g_varchar2_table(1381) := '36352021696D706F7274616E743B0D0A20207374726F6B653A20236631396136352021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3234207B0D0A20206261636B67726F756E642D636F6C6F723A20236564376337362021696D706F7274';
wwv_flow_api.g_varchar2_table(1382) := '616E743B0D0A202066696C6C3A20236564376337362021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32342D62672C0D0A2E752D636F6C6F722D32342D626163';
wwv_flow_api.g_varchar2_table(1383) := '6B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236564376337362021696D706F7274616E743B0D0A202066696C6C3A20236564376337362021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32342D7478742C';
wwv_flow_api.g_varchar2_table(1384) := '0D0A2E752D636F6C6F722D32342D74657874207B0D0A2020636F6C6F723A20236564376337362021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32342D62642C0D0A2E752D636F6C6F722D32342D626F72646572207B0D0A2020626F7264';
wwv_flow_api.g_varchar2_table(1385) := '65722D636F6C6F723A20236564376337362021696D706F7274616E743B0D0A20207374726F6B653A20236564376337362021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3235207B0D0A20206261636B67726F756E642D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1386) := '236564376461302021696D706F7274616E743B0D0A202066696C6C3A20236564376461302021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32352D62672C0D0A';
wwv_flow_api.g_varchar2_table(1387) := '2E752D636F6C6F722D32352D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236564376461302021696D706F7274616E743B0D0A202066696C6C3A20236564376461302021696D706F7274616E743B0D0A7D0D0A2E';
wwv_flow_api.g_varchar2_table(1388) := '752D636F6C6F722D32352D7478742C0D0A2E752D636F6C6F722D32352D74657874207B0D0A2020636F6C6F723A20236564376461302021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32352D62642C0D0A2E752D636F6C6F722D32352D62';
wwv_flow_api.g_varchar2_table(1389) := '6F72646572207B0D0A2020626F726465722D636F6C6F723A20236564376461302021696D706F7274616E743B0D0A20207374726F6B653A20236564376461302021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3236207B0D0A2020626163';
wwv_flow_api.g_varchar2_table(1390) := '6B67726F756E642D636F6C6F723A20236435373962312021696D706F7274616E743B0D0A202066696C6C3A20236435373962312021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E75';
wwv_flow_api.g_varchar2_table(1391) := '2D636F6C6F722D32362D62672C0D0A2E752D636F6C6F722D32362D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236435373962312021696D706F7274616E743B0D0A202066696C6C3A2023643537396231202169';
wwv_flow_api.g_varchar2_table(1392) := '6D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32362D7478742C0D0A2E752D636F6C6F722D32362D74657874207B0D0A2020636F6C6F723A20236435373962312021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32362D62642C';
wwv_flow_api.g_varchar2_table(1393) := '0D0A2E752D636F6C6F722D32362D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236435373962312021696D706F7274616E743B0D0A20207374726F6B653A20236435373962312021696D706F7274616E743B0D0A7D0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1394) := '6C6F722D3237207B0D0A20206261636B67726F756E642D636F6C6F723A20233964373161662021696D706F7274616E743B0D0A202066696C6C3A20233964373161662021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D';
wwv_flow_api.g_varchar2_table(1395) := '706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32372D62672C0D0A2E752D636F6C6F722D32372D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233964373161662021696D706F7274616E743B0D0A202066';
wwv_flow_api.g_varchar2_table(1396) := '696C6C3A20233964373161662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32372D7478742C0D0A2E752D636F6C6F722D32372D74657874207B0D0A2020636F6C6F723A20233964373161662021696D706F7274616E743B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1397) := '2E752D636F6C6F722D32372D62642C0D0A2E752D636F6C6F722D32372D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233964373161662021696D706F7274616E743B0D0A20207374726F6B653A20233964373161662021696D706F72';
wwv_flow_api.g_varchar2_table(1398) := '74616E743B0D0A7D0D0A2E752D636F6C6F722D3238207B0D0A20206261636B67726F756E642D636F6C6F723A20233762383662642021696D706F7274616E743B0D0A202066696C6C3A20233762383662642021696D706F7274616E743B0D0A2020636F6C';
wwv_flow_api.g_varchar2_table(1399) := '6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32382D62672C0D0A2E752D636F6C6F722D32382D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233762383662642021';
wwv_flow_api.g_varchar2_table(1400) := '696D706F7274616E743B0D0A202066696C6C3A20233762383662642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32382D7478742C0D0A2E752D636F6C6F722D32382D74657874207B0D0A2020636F6C6F723A20233762383662642021';
wwv_flow_api.g_varchar2_table(1401) := '696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32382D62642C0D0A2E752D636F6C6F722D32382D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233762383662642021696D706F7274616E743B0D0A20207374726F6B653A';
wwv_flow_api.g_varchar2_table(1402) := '20233762383662642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3239207B0D0A20206261636B67726F756E642D636F6C6F723A20236266633864312021696D706F7274616E743B0D0A202066696C6C3A20236266633864312021696D';
wwv_flow_api.g_varchar2_table(1403) := '706F7274616E743B0D0A2020636F6C6F723A20233364343835342021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32392D62672C0D0A2E752D636F6C6F722D32392D6261636B67726F756E64207B0D0A20206261636B67726F756E642D63';
wwv_flow_api.g_varchar2_table(1404) := '6F6C6F723A20236266633864312021696D706F7274616E743B0D0A202066696C6C3A20236266633864312021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32392D7478742C0D0A2E752D636F6C6F722D32392D74657874207B0D0A202063';
wwv_flow_api.g_varchar2_table(1405) := '6F6C6F723A20236266633864312021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D32392D62642C0D0A2E752D636F6C6F722D32392D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236266633864312021696D706F7274';
wwv_flow_api.g_varchar2_table(1406) := '616E743B0D0A20207374726F6B653A20236266633864312021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3330207B0D0A20206261636B67726F756E642D636F6C6F723A20233862396461642021696D706F7274616E743B0D0A20206669';
wwv_flow_api.g_varchar2_table(1407) := '6C6C3A20233862396461642021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33302D62672C0D0A2E752D636F6C6F722D33302D6261636B67726F756E64207B0D';
wwv_flow_api.g_varchar2_table(1408) := '0A20206261636B67726F756E642D636F6C6F723A20233862396461642021696D706F7274616E743B0D0A202066696C6C3A20233862396461642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33302D7478742C0D0A2E752D636F6C6F72';
wwv_flow_api.g_varchar2_table(1409) := '2D33302D74657874207B0D0A2020636F6C6F723A20233862396461642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33302D62642C0D0A2E752D636F6C6F722D33302D626F72646572207B0D0A2020626F726465722D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1410) := '233862396461642021696D706F7274616E743B0D0A20207374726F6B653A20233862396461642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3331207B0D0A20206261636B67726F756E642D636F6C6F723A2023313938636361202169';
wwv_flow_api.g_varchar2_table(1411) := '6D706F7274616E743B0D0A202066696C6C3A20233139386363612021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33312D62672C0D0A2E752D636F6C6F722D33';
wwv_flow_api.g_varchar2_table(1412) := '312D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233139386363612021696D706F7274616E743B0D0A202066696C6C3A20233139386363612021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3331';
wwv_flow_api.g_varchar2_table(1413) := '2D7478742C0D0A2E752D636F6C6F722D33312D74657874207B0D0A2020636F6C6F723A20233139386363612021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33312D62642C0D0A2E752D636F6C6F722D33312D626F72646572207B0D0A20';
wwv_flow_api.g_varchar2_table(1414) := '20626F726465722D636F6C6F723A20233139386363612021696D706F7274616E743B0D0A20207374726F6B653A20233139386363612021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3332207B0D0A20206261636B67726F756E642D636F';
wwv_flow_api.g_varchar2_table(1415) := '6C6F723A20233032613562652021696D706F7274616E743B0D0A202066696C6C3A20233032613562652021696D706F7274616E743B0D0A2020636F6C6F723A20233030303030302021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33322D';
wwv_flow_api.g_varchar2_table(1416) := '62672C0D0A2E752D636F6C6F722D33322D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233032613562652021696D706F7274616E743B0D0A202066696C6C3A20233032613562652021696D706F7274616E743B0D';
wwv_flow_api.g_varchar2_table(1417) := '0A7D0D0A2E752D636F6C6F722D33322D7478742C0D0A2E752D636F6C6F722D33322D74657874207B0D0A2020636F6C6F723A20233032613562652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33322D62642C0D0A2E752D636F6C6F72';
wwv_flow_api.g_varchar2_table(1418) := '2D33322D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233032613562652021696D706F7274616E743B0D0A20207374726F6B653A20233032613562652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3333207B0D0A';
wwv_flow_api.g_varchar2_table(1419) := '20206261636B67726F756E642D636F6C6F723A20233138623161652021696D706F7274616E743B0D0A202066696C6C3A20233138623161652021696D706F7274616E743B0D0A2020636F6C6F723A20233030303030302021696D706F7274616E743B0D0A';
wwv_flow_api.g_varchar2_table(1420) := '7D0D0A2E752D636F6C6F722D33332D62672C0D0A2E752D636F6C6F722D33332D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233138623161652021696D706F7274616E743B0D0A202066696C6C3A202331386231';
wwv_flow_api.g_varchar2_table(1421) := '61652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33332D7478742C0D0A2E752D636F6C6F722D33332D74657874207B0D0A2020636F6C6F723A20233138623161652021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33';
wwv_flow_api.g_varchar2_table(1422) := '332D62642C0D0A2E752D636F6C6F722D33332D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233138623161652021696D706F7274616E743B0D0A20207374726F6B653A20233138623161652021696D706F7274616E743B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(1423) := '2E752D636F6C6F722D3334207B0D0A20206261636B67726F756E642D636F6C6F723A20233234613437352021696D706F7274616E743B0D0A202066696C6C3A20233234613437352021696D706F7274616E743B0D0A2020636F6C6F723A20236566666266';
wwv_flow_api.g_varchar2_table(1424) := '372021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33342D62672C0D0A2E752D636F6C6F722D33342D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233234613437352021696D706F7274616E743B';
wwv_flow_api.g_varchar2_table(1425) := '0D0A202066696C6C3A20233234613437352021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33342D7478742C0D0A2E752D636F6C6F722D33342D74657874207B0D0A2020636F6C6F723A20233234613437352021696D706F7274616E743B';
wwv_flow_api.g_varchar2_table(1426) := '0D0A7D0D0A2E752D636F6C6F722D33342D62642C0D0A2E752D636F6C6F722D33342D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233234613437352021696D706F7274616E743B0D0A20207374726F6B653A20233234613437352021';
wwv_flow_api.g_varchar2_table(1427) := '696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3335207B0D0A20206261636B67726F756E642D636F6C6F723A20233661616434322021696D706F7274616E743B0D0A202066696C6C3A20233661616434322021696D706F7274616E743B0D0A';
wwv_flow_api.g_varchar2_table(1428) := '2020636F6C6F723A20233063313530362021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33352D62672C0D0A2E752D636F6C6F722D33352D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A2023366161';
wwv_flow_api.g_varchar2_table(1429) := '6434322021696D706F7274616E743B0D0A202066696C6C3A20233661616434322021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33352D7478742C0D0A2E752D636F6C6F722D33352D74657874207B0D0A2020636F6C6F723A2023366161';
wwv_flow_api.g_varchar2_table(1430) := '6434322021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33352D62642C0D0A2E752D636F6C6F722D33352D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233661616434322021696D706F7274616E743B0D0A20207374';
wwv_flow_api.g_varchar2_table(1431) := '726F6B653A20233661616434322021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3336207B0D0A20206261636B67726F756E642D636F6C6F723A20236339636133392021696D706F7274616E743B0D0A202066696C6C3A20236339636133';
wwv_flow_api.g_varchar2_table(1432) := '392021696D706F7274616E743B0D0A2020636F6C6F723A20233264326530342021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33362D62672C0D0A2E752D636F6C6F722D33362D6261636B67726F756E64207B0D0A20206261636B67726F';
wwv_flow_api.g_varchar2_table(1433) := '756E642D636F6C6F723A20236339636133392021696D706F7274616E743B0D0A202066696C6C3A20236339636133392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33362D7478742C0D0A2E752D636F6C6F722D33362D74657874207B';
wwv_flow_api.g_varchar2_table(1434) := '0D0A2020636F6C6F723A20236339636133392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33362D62642C0D0A2E752D636F6C6F722D33362D626F72646572207B0D0A2020626F726465722D636F6C6F723A2023633963613339202169';
wwv_flow_api.g_varchar2_table(1435) := '6D706F7274616E743B0D0A20207374726F6B653A20236339636133392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3337207B0D0A20206261636B67726F756E642D636F6C6F723A20236439623133622021696D706F7274616E743B0D';
wwv_flow_api.g_varchar2_table(1436) := '0A202066696C6C3A20236439623133622021696D706F7274616E743B0D0A2020636F6C6F723A20233436333430302021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33372D62672C0D0A2E752D636F6C6F722D33372D6261636B67726F75';
wwv_flow_api.g_varchar2_table(1437) := '6E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236439623133622021696D706F7274616E743B0D0A202066696C6C3A20236439623133622021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33372D7478742C0D0A2E752D';
wwv_flow_api.g_varchar2_table(1438) := '636F6C6F722D33372D74657874207B0D0A2020636F6C6F723A20236439623133622021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33372D62642C0D0A2E752D636F6C6F722D33372D626F72646572207B0D0A2020626F726465722D636F';
wwv_flow_api.g_varchar2_table(1439) := '6C6F723A20236439623133622021696D706F7274616E743B0D0A20207374726F6B653A20236439623133622021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3338207B0D0A20206261636B67726F756E642D636F6C6F723A202364373661';
wwv_flow_api.g_varchar2_table(1440) := '32372021696D706F7274616E743B0D0A202066696C6C3A20236437366132372021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33382D62672C0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1441) := '6C6F722D33382D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236437366132372021696D706F7274616E743B0D0A202066696C6C3A20236437366132372021696D706F7274616E743B0D0A7D0D0A2E752D636F6C';
wwv_flow_api.g_varchar2_table(1442) := '6F722D33382D7478742C0D0A2E752D636F6C6F722D33382D74657874207B0D0A2020636F6C6F723A20236437366132372021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33382D62642C0D0A2E752D636F6C6F722D33382D626F72646572';
wwv_flow_api.g_varchar2_table(1443) := '207B0D0A2020626F726465722D636F6C6F723A20236437366132372021696D706F7274616E743B0D0A20207374726F6B653A20236437366132372021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3339207B0D0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(1444) := '6E642D636F6C6F723A20236432343233622021696D706F7274616E743B0D0A202066696C6C3A20236432343233622021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F';
wwv_flow_api.g_varchar2_table(1445) := '722D33392D62672C0D0A2E752D636F6C6F722D33392D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236432343233622021696D706F7274616E743B0D0A202066696C6C3A20236432343233622021696D706F7274';
wwv_flow_api.g_varchar2_table(1446) := '616E743B0D0A7D0D0A2E752D636F6C6F722D33392D7478742C0D0A2E752D636F6C6F722D33392D74657874207B0D0A2020636F6C6F723A20236432343233622021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D33392D62642C0D0A2E752D';
wwv_flow_api.g_varchar2_table(1447) := '636F6C6F722D33392D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236432343233622021696D706F7274616E743B0D0A20207374726F6B653A20236432343233622021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34';
wwv_flow_api.g_varchar2_table(1448) := '30207B0D0A20206261636B67726F756E642D636F6C6F723A20236431343336662021696D706F7274616E743B0D0A202066696C6C3A20236431343336662021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F727461';
wwv_flow_api.g_varchar2_table(1449) := '6E743B0D0A7D0D0A2E752D636F6C6F722D34302D62672C0D0A2E752D636F6C6F722D34302D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236431343336662021696D706F7274616E743B0D0A202066696C6C3A20';
wwv_flow_api.g_varchar2_table(1450) := '236431343336662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34302D7478742C0D0A2E752D636F6C6F722D34302D74657874207B0D0A2020636F6C6F723A20236431343336662021696D706F7274616E743B0D0A7D0D0A2E752D636F';
wwv_flow_api.g_varchar2_table(1451) := '6C6F722D34302D62642C0D0A2E752D636F6C6F722D34302D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236431343336662021696D706F7274616E743B0D0A20207374726F6B653A20236431343336662021696D706F7274616E743B';
wwv_flow_api.g_varchar2_table(1452) := '0D0A7D0D0A2E752D636F6C6F722D3431207B0D0A20206261636B67726F756E642D636F6C6F723A20236261336438382021696D706F7274616E743B0D0A202066696C6C3A20236261336438382021696D706F7274616E743B0D0A2020636F6C6F723A2023';
wwv_flow_api.g_varchar2_table(1453) := '6666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34312D62672C0D0A2E752D636F6C6F722D34312D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20236261336438382021696D706F72';
wwv_flow_api.g_varchar2_table(1454) := '74616E743B0D0A202066696C6C3A20236261336438382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34312D7478742C0D0A2E752D636F6C6F722D34312D74657874207B0D0A2020636F6C6F723A20236261336438382021696D706F72';
wwv_flow_api.g_varchar2_table(1455) := '74616E743B0D0A7D0D0A2E752D636F6C6F722D34312D62642C0D0A2E752D636F6C6F722D34312D626F72646572207B0D0A2020626F726465722D636F6C6F723A20236261336438382021696D706F7274616E743B0D0A20207374726F6B653A2023626133';
wwv_flow_api.g_varchar2_table(1456) := '6438382021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3432207B0D0A20206261636B67726F756E642D636F6C6F723A20233737333339332021696D706F7274616E743B0D0A202066696C6C3A20233737333339332021696D706F727461';
wwv_flow_api.g_varchar2_table(1457) := '6E743B0D0A2020636F6C6F723A20236636656666392021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34322D62672C0D0A2E752D636F6C6F722D34322D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A';
wwv_flow_api.g_varchar2_table(1458) := '20233737333339332021696D706F7274616E743B0D0A202066696C6C3A20233737333339332021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34322D7478742C0D0A2E752D636F6C6F722D34322D74657874207B0D0A2020636F6C6F723A';
wwv_flow_api.g_varchar2_table(1459) := '20233737333339332021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34322D62642C0D0A2E752D636F6C6F722D34322D626F72646572207B0D0A2020626F726465722D636F6C6F723A20233737333339332021696D706F7274616E743B0D';
wwv_flow_api.g_varchar2_table(1460) := '0A20207374726F6B653A20233737333339332021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3433207B0D0A20206261636B67726F756E642D636F6C6F723A20233364346561332021696D706F7274616E743B0D0A202066696C6C3A2023';
wwv_flow_api.g_varchar2_table(1461) := '3364346561332021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34332D62672C0D0A2E752D636F6C6F722D34332D6261636B67726F756E64207B0D0A20206261';
wwv_flow_api.g_varchar2_table(1462) := '636B67726F756E642D636F6C6F723A20233364346561332021696D706F7274616E743B0D0A202066696C6C3A20233364346561332021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34332D7478742C0D0A2E752D636F6C6F722D34332D74';
wwv_flow_api.g_varchar2_table(1463) := '657874207B0D0A2020636F6C6F723A20233364346561332021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34332D62642C0D0A2E752D636F6C6F722D34332D626F72646572207B0D0A2020626F726465722D636F6C6F723A202333643465';
wwv_flow_api.g_varchar2_table(1464) := '61332021696D706F7274616E743B0D0A20207374726F6B653A20233364346561332021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3434207B0D0A20206261636B67726F756E642D636F6C6F723A20233863396562302021696D706F7274';
wwv_flow_api.g_varchar2_table(1465) := '616E743B0D0A202066696C6C3A20233863396562302021696D706F7274616E743B0D0A2020636F6C6F723A20233238336134642021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34342D62672C0D0A2E752D636F6C6F722D34342D626163';
wwv_flow_api.g_varchar2_table(1466) := '6B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233863396562302021696D706F7274616E743B0D0A202066696C6C3A20233863396562302021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34342D7478742C';
wwv_flow_api.g_varchar2_table(1467) := '0D0A2E752D636F6C6F722D34342D74657874207B0D0A2020636F6C6F723A20233863396562302021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34342D62642C0D0A2E752D636F6C6F722D34342D626F72646572207B0D0A2020626F7264';
wwv_flow_api.g_varchar2_table(1468) := '65722D636F6C6F723A20233863396562302021696D706F7274616E743B0D0A20207374726F6B653A20233863396562302021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D3435207B0D0A20206261636B67726F756E642D636F6C6F723A20';
wwv_flow_api.g_varchar2_table(1469) := '233465373339312021696D706F7274616E743B0D0A202066696C6C3A20233465373339312021696D706F7274616E743B0D0A2020636F6C6F723A20236666666666662021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34352D62672C0D0A';
wwv_flow_api.g_varchar2_table(1470) := '2E752D636F6C6F722D34352D6261636B67726F756E64207B0D0A20206261636B67726F756E642D636F6C6F723A20233465373339312021696D706F7274616E743B0D0A202066696C6C3A20233465373339312021696D706F7274616E743B0D0A7D0D0A2E';
wwv_flow_api.g_varchar2_table(1471) := '752D636F6C6F722D34352D7478742C0D0A2E752D636F6C6F722D34352D74657874207B0D0A2020636F6C6F723A20233465373339312021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D34352D62642C0D0A2E752D636F6C6F722D34352D62';
wwv_flow_api.g_varchar2_table(1472) := '6F72646572207B0D0A2020626F726465722D636F6C6F723A20233465373339312021696D706F7274616E743B0D0A20207374726F6B653A20233465373339312021696D706F7274616E743B0D0A7D0D0A0D0A2E752D636F6C6F722D7472616E7370617265';
wwv_flow_api.g_varchar2_table(1473) := '6E74207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E742021696D706F7274616E743B0D0A2020636F6C6F723A207472616E73706172656E742021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D747261';
wwv_flow_api.g_varchar2_table(1474) := '6E73706172656E742D6267207B0D0A20206261636B67726F756E642D636F6C6F723A207472616E73706172656E742021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D7472616E73706172656E742D7478742C0D0A2E752D636F6C6F722D74';
wwv_flow_api.g_varchar2_table(1475) := '72616E73706172656E742D74657874207B0D0A2020636F6C6F723A207472616E73706172656E742021696D706F7274616E743B0D0A7D0D0A2E752D636F6C6F722D7472616E73706172656E742D62642C0D0A2E752D636F6C6F722D7472616E7370617265';
wwv_flow_api.g_varchar2_table(1476) := '6E742D626F72646572207B0D0A2020626F726465722D636F6C6F723A207472616E73706172656E742021696D706F7274616E743B0D0A7D0D0A0D0A2F2A200D0A202A204F7261636C65204170706C69636174696F6E204578707265737320352E30205468';
wwv_flow_api.g_varchar2_table(1477) := '656D6520526F6C6C657220437573746F6D20435353200D0A202A0D0A202A2F0D0A0D0A2E617065782D69636F6E732D666F6E74617765736F6D65202E66612D32787B666F6E742D66616D6C696C793A696E68657269743B666F6E742D73697A653A323870';
wwv_flow_api.g_varchar2_table(1478) := '787D';
null;
end;
/
begin
wwv_flow_api.create_theme_file(
 p_id=>wwv_flow_api.id(4871810140627823)
,p_theme_id=>42
,p_file_name=>'4871446654627810.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
null;
end;
/
prompt --application/shared_components/user_interface/theme_display_points
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7653648926820032)
,p_theme_id=>42
,p_name=>'BUTTON_SET'
,p_display_name=>'Button Set'
,p_display_sequence=>40
,p_template_types=>'BUTTON'
,p_help_text=>'Enables you to group many buttons together into a pill. You can use this option to specify where the button is within this set. Set the option to Default if this button is not part of a button set.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7654109662820032)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7654503922820032)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the size of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7654892861820032)
,p_theme_id=>42
,p_name=>'SPACING_BOTTOM'
,p_display_name=>'Spacing Bottom'
,p_display_sequence=>100
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the bottom of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7655261265820032)
,p_theme_id=>42
,p_name=>'SPACING_LEFT'
,p_display_name=>'Spacing Left'
,p_display_sequence=>70
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the left of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7655661024820032)
,p_theme_id=>42
,p_name=>'SPACING_RIGHT'
,p_display_name=>'Spacing Right'
,p_display_sequence=>80
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the right of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7656075509820034)
,p_theme_id=>42
,p_name=>'SPACING_TOP'
,p_display_name=>'Spacing Top'
,p_display_sequence=>90
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the top of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7656442002820034)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>30
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the style of the button. Use the "Simple" option for secondary actions or sets of buttons. Use the "Remove UI Decoration" option to make the button appear as text.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7656910505820034)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7657265486820034)
,p_theme_id=>42
,p_name=>'WIDTH'
,p_display_name=>'Width'
,p_display_sequence=>60
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the width of the button.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7657638519820034)
,p_theme_id=>42
,p_name=>'BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the bottom margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7658052341820034)
,p_theme_id=>42
,p_name=>'ITEM_POST_TEXT'
,p_display_name=>'Item Post Text'
,p_display_sequence=>30
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Post Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7658495966820034)
,p_theme_id=>42
,p_name=>'ITEM_PRE_TEXT'
,p_display_name=>'Item Pre Text'
,p_display_sequence=>20
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Pre Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7658909952820034)
,p_theme_id=>42
,p_name=>'LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the left margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7659254349820034)
,p_theme_id=>42
,p_name=>'PRESERVE_LABEL_SPACING'
,p_display_name=>'Preserve Label Spacing'
,p_display_sequence=>1
,p_template_types=>'FIELD'
,p_help_text=>'Preserves the label space and enables use of the Label Column Span property.'
,p_null_text=>'Yes'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7659646860820034)
,p_theme_id=>42
,p_name=>'RADIO_GROUP_DISPLAY'
,p_display_name=>'Item Group Display'
,p_display_sequence=>300
,p_template_types=>'FIELD'
,p_help_text=>'Determines the display style for radio and check box items.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7660040277820034)
,p_theme_id=>42
,p_name=>'RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'FIELD'
,p_help_text=>'Set the right margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7660462946820034)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7660845220820034)
,p_theme_id=>42
,p_name=>'TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'FIELD'
,p_help_text=>'Set the top margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7661316635820035)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>80
,p_template_types=>'LIST'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7661644357820035)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7662041645820035)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'LIST'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7662503995820035)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7662876582820035)
,p_theme_id=>42
,p_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_sequence=>90
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a desktop-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7663299180820035)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7663644234820035)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7664085559820035)
,p_theme_id=>42
,p_name=>'ICON_STYLE'
,p_display_name=>'Icon Style'
,p_display_sequence=>35
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7664472137820035)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7664906960820035)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7665236853820035)
,p_theme_id=>42
,p_name=>'MOBILE'
,p_display_name=>'Mobile'
,p_display_sequence=>100
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a mobile-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7665643823820035)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7666087187820035)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7666507992820035)
,p_theme_id=>42
,p_name=>'ACCENT'
,p_display_name=>'Accent'
,p_display_sequence=>30
,p_template_types=>'REGION'
,p_help_text=>'Set the Region''s accent. This accent corresponds to a Theme-Rollable color and sets the background of the Region''s Header.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7666829929820037)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7667295662820037)
,p_theme_id=>42
,p_name=>'ALERT_ICONS'
,p_display_name=>'Alert Icons'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets how icons are handled for the Alert Region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7667631116820037)
,p_theme_id=>42
,p_name=>'ALERT_TITLE'
,p_display_name=>'Alert Title'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the title of the alert is displayed.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7668041175820037)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7668517231820037)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the animation when navigating within the Carousel Region.'
,p_null_text=>'Fade'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7668887868820037)
,p_theme_id=>42
,p_name=>'BODY_HEIGHT'
,p_display_name=>'Body Height'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body height. You can also specify a custom height by modifying the Region''s CSS Classes and using the height helper classes "i-hXXX" where XXX is any increment of 10 from 100 to 800.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7669263597820037)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7669625371820037)
,p_theme_id=>42
,p_name=>'BODY_PADDING'
,p_display_name=>'Body Padding'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body padding for the region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7670086510820037)
,p_theme_id=>42
,p_name=>'BODY_STYLE'
,p_display_name=>'Body Style'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the region''s body container.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7670496322820037)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7670907931820037)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7671269591820037)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON'
,p_display_name=>'Display Icon'
,p_display_sequence=>50
,p_template_types=>'REGION'
,p_help_text=>'Display the Hero Region icon.'
,p_null_text=>'Yes (Default)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7671680185820037)
,p_theme_id=>42
,p_name=>'HEADER'
,p_display_name=>'Header'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Determines the display of the Region Header which also contains the Region Title.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7672025661820037)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7672434169820039)
,p_theme_id=>42
,p_name=>'ITEM_PADDING'
,p_display_name=>'Item Padding'
,p_display_sequence=>100
,p_template_types=>'REGION'
,p_help_text=>'Sets the padding around items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7672880614820039)
,p_theme_id=>42
,p_name=>'ITEM_SIZE'
,p_display_name=>'Item Size'
,p_display_sequence=>110
,p_template_types=>'REGION'
,p_help_text=>'Sets the size of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7673288855820039)
,p_theme_id=>42
,p_name=>'ITEM_WIDTH'
,p_display_name=>'Item Width'
,p_display_sequence=>120
,p_template_types=>'REGION'
,p_help_text=>'Sets the width of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7673712480820039)
,p_theme_id=>42
,p_name=>'LABEL_ALIGNMENT'
,p_display_name=>'Label Alignment'
,p_display_sequence=>130
,p_template_types=>'REGION'
,p_help_text=>'Set the label text alignment for items within this region.'
,p_null_text=>'Right'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7674110105820039)
,p_theme_id=>42
,p_name=>'LABEL_POSITION'
,p_display_name=>'Label Position'
,p_display_sequence=>140
,p_template_types=>'REGION'
,p_help_text=>'Sets the position of the label relative to the form item.'
,p_null_text=>'Inline - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7674432898820039)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7674832117820039)
,p_theme_id=>42
,p_name=>'REGION_BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>210
,p_template_types=>'REGION'
,p_help_text=>'Set the bottom margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7675256173820039)
,p_theme_id=>42
,p_name=>'REGION_LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'REGION'
,p_help_text=>'Set the left margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7675697032820039)
,p_theme_id=>42
,p_name=>'REGION_RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'REGION'
,p_help_text=>'Set the right margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7676024622820039)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7676510223820039)
,p_theme_id=>42
,p_name=>'REGION_TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'REGION'
,p_help_text=>'Set the top margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7676866344820039)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the region is styled. Use the "Remove Borders" template option to remove the region''s borders and shadows.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7677223625820039)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7677715310820040)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7678078539820040)
,p_theme_id=>42
,p_name=>'TIMER'
,p_display_name=>'Timer'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets the timer for when to automatically navigate to the next region within the Carousel Region.'
,p_null_text=>'No Timer'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7678512336820040)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7678873302820040)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>70
,p_template_types=>'REPORT'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7679247061820040)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7679635312820040)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'REPORT'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7680092007820040)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7680439174820040)
,p_theme_id=>42
,p_name=>'COMMENTS_STYLE'
,p_display_name=>'Comments Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the style in which comments are displayed.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7680908130820040)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Controls how to handle icons in the report.'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7681268621820040)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7681670231820040)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7682065078820040)
,p_theme_id=>42
,p_name=>'PAGINATION_DISPLAY'
,p_display_name=>'Pagination Display'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of pagination for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7682498901820040)
,p_theme_id=>42
,p_name=>'REPORT_BORDER'
,p_display_name=>'Report Border'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of the Report''s borders.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7682827762820040)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7683313432820042)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>35
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(7683628086820042)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the overall style for the component.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/user_interface/template_options
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7704784219820049)
,p_theme_id=>42
,p_name=>'FBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(7657638519820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7705495211820049)
,p_theme_id=>42
,p_name=>'RBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_api.id(7674832117820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7706201471820051)
,p_theme_id=>42
,p_name=>'FBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(7657638519820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7706863361820051)
,p_theme_id=>42
,p_name=>'RBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_api.id(7674832117820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7707569747820051)
,p_theme_id=>42
,p_name=>'FBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(7657638519820034)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7708227658820051)
,p_theme_id=>42
,p_name=>'RBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_api.id(7674832117820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes the bottom margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7708999067820051)
,p_theme_id=>42
,p_name=>'FBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(7657638519820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small bottom margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7709681254820051)
,p_theme_id=>42
,p_name=>'RBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_api.id(7674832117820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small bottom margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7710378232820053)
,p_theme_id=>42
,p_name=>'FLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(7658909952820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7711036072820053)
,p_theme_id=>42
,p_name=>'RLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_api.id(7675256173820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7711813981820053)
,p_theme_id=>42
,p_name=>'FLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(7658909952820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7712476581820053)
,p_theme_id=>42
,p_name=>'RLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_api.id(7675256173820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7713201951820053)
,p_theme_id=>42
,p_name=>'FLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(7658909952820034)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7713870497820053)
,p_theme_id=>42
,p_name=>'RLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_api.id(7675256173820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes the left margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7714589051820053)
,p_theme_id=>42
,p_name=>'FLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(7658909952820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small left margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7715315172820054)
,p_theme_id=>42
,p_name=>'RLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_api.id(7675256173820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small left margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7716012924820054)
,p_theme_id=>42
,p_name=>'FRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(7660040277820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7716682118820054)
,p_theme_id=>42
,p_name=>'RRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_api.id(7675697032820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7717347292820054)
,p_theme_id=>42
,p_name=>'FRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(7660040277820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7718043389820054)
,p_theme_id=>42
,p_name=>'RRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_api.id(7675697032820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7718780560820054)
,p_theme_id=>42
,p_name=>'FRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(7660040277820034)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7719489746820056)
,p_theme_id=>42
,p_name=>'RRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_api.id(7675697032820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes the right margin from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7720135996820056)
,p_theme_id=>42
,p_name=>'FRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(7660040277820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small right margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7720826793820056)
,p_theme_id=>42
,p_name=>'RRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_api.id(7675697032820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small right margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7721574439820056)
,p_theme_id=>42
,p_name=>'FTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(7660845220820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7722318155820056)
,p_theme_id=>42
,p_name=>'RTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_api.id(7676510223820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7722926572820056)
,p_theme_id=>42
,p_name=>'FTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(7660845220820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7723677693820057)
,p_theme_id=>42
,p_name=>'RTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_api.id(7676510223820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7724343614820057)
,p_theme_id=>42
,p_name=>'FTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(7660845220820034)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7725030232820057)
,p_theme_id=>42
,p_name=>'RTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_api.id(7676510223820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes the top margin for this region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7725806115820057)
,p_theme_id=>42
,p_name=>'FTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(7660845220820034)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small top margin for this field.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7726476105820057)
,p_theme_id=>42
,p_name=>'RTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_api.id(7676510223820039)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small top margin to the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7727154299820057)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(7656910505820034)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7727910610820057)
,p_theme_id=>42
,p_name=>'LARGEBOTTOMMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapBottom'
,p_group_id=>wwv_flow_api.id(7654892861820032)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7728586109820059)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(7655261265820032)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7729249362820059)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(7655661024820032)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7730001894820059)
,p_theme_id=>42
,p_name=>'LARGETOPMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapTop'
,p_group_id=>wwv_flow_api.id(7656075509820034)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7730663574820059)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(7654503922820032)
,p_template_types=>'BUTTON'
,p_help_text=>'A large button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7731407945820059)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_LINK'
,p_display_name=>'Display as Link'
,p_display_sequence=>30
,p_css_classes=>'t-Button--link'
,p_group_id=>wwv_flow_api.id(7656442002820034)
,p_template_types=>'BUTTON'
,p_help_text=>'This option makes the button appear as a text link.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7732066621820060)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(7656442002820034)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7732724390820060)
,p_theme_id=>42
,p_name=>'SMALLBOTTOMMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padBottom'
,p_group_id=>wwv_flow_api.id(7654892861820032)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7733443344820060)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(7655261265820032)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7734136573820060)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(7655661024820032)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7734881080820060)
,p_theme_id=>42
,p_name=>'SMALLTOPMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padTop'
,p_group_id=>wwv_flow_api.id(7656075509820034)
,p_template_types=>'BUTTON'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7735555987820060)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(7653648926820032)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7736317241820060)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(7653648926820032)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7737015384820062)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(7653648926820032)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7737545595820062)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(7656910505820034)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7738291178820062)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(7656442002820034)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7738998108820062)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(7654503922820032)
,p_template_types=>'BUTTON'
,p_help_text=>'A small button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7739677228820062)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(7657265486820034)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7740328700820062)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(7656910505820034)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7741066415820064)
,p_theme_id=>42
,p_name=>'TINY'
,p_display_name=>'Tiny'
,p_display_sequence=>10
,p_css_classes=>'t-Button--tiny'
,p_group_id=>wwv_flow_api.id(7654503922820032)
,p_template_types=>'BUTTON'
,p_help_text=>'A very small button.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7741727782820064)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(7656910505820034)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7742454537820064)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(7674110105820039)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7743184119820064)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(7672880614820039)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7743865362820064)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(7673712480820039)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7744532114820064)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(7672434169820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7745305270820064)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(7672434169820039)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7746007406820065)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(7673288855820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7746640198820065)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(7672880614820039)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7747340062820065)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(7660462946820034)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7748044408820065)
,p_theme_id=>42
,p_name=>'POST_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--postTextBlock'
,p_group_id=>wwv_flow_api.id(7658052341820034)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Post Text in a block style immediately after the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7748789635820065)
,p_theme_id=>42
,p_name=>'PRE_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--preTextBlock'
,p_group_id=>wwv_flow_api.id(7658495966820034)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Pre Text in a block style immediately before the item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7749479469820067)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_PILL_BUTTON'
,p_display_name=>'Display as Pill Button'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--radioButtonGroup'
,p_group_id=>wwv_flow_api.id(7659646860820034)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the radio buttons to look like a button set / pill button.  Note that the the radio buttons must all be in the same row for this option to work.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7749838041820067)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7750550777820067)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(7660462946820034)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7751313549820067)
,p_theme_id=>42
,p_name=>'HIDE_WHEN_ALL_ROWS_DISPLAYED'
,p_display_name=>'Hide when all rows displayed'
,p_display_sequence=>10
,p_css_classes=>'t-Report--hideNoPagination'
,p_group_id=>wwv_flow_api.id(7682065078820040)
,p_template_types=>'REPORT'
,p_help_text=>'This option will hide the pagination when all rows are displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(7925970264820148)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134934578551603547)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Enables you to define a keyboard shortcut to activate the menu item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13812352920421087)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(134898882829603506)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13821455518421095)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(134899840747603514)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13832611830421101)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(134901157909603516)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13839956442421104)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(134904646306603519)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13843613791421106)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(134902141714603516)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13844012011421106)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_api.id(134902141714603516)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13852524658421110)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(134902532880603517)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13859818894421113)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_api.id(134903802920603517)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13863491043421117)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_api.id(134903390439603517)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13863882131421117)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_api.id(134903390439603517)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13866385369421121)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--removeHeading'
,p_group_id=>wwv_flow_api.id(7667631116820037)
,p_template_types=>'REGION'
,p_help_text=>'Hides the Alert Title from being displayed.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13867027650421121)
,p_theme_id=>42
,p_name=>'HIDDENHEADER'
,p_display_name=>'Hidden but Accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--accessibleHeading'
,p_group_id=>wwv_flow_api.id(7667631116820037)
,p_template_types=>'REGION'
,p_help_text=>'Visually hides the alert title, but assistive technologies can still read it.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13876688277421128)
,p_theme_id=>42
,p_name=>'STICK_TO_BOTTOM'
,p_display_name=>'Stick to Bottom for Mobile'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134911385607603528)
,p_css_classes=>'t-ButtonRegion--stickToBottom'
,p_template_types=>'REGION'
,p_help_text=>'This will position the button container region to the bottom of the screen for small screens.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13881890132421131)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13898577847421142)
,p_theme_id=>42
,p_name=>'REMEMBER_COLLAPSIBLE_STATE'
,p_display_name=>'Remember Collapsible State'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
,p_help_text=>'This option saves the current state of the collapsible region for the duration of the session.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13910636318421149)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134914356825603530)
,p_css_classes=>'t-HeroRegion--featured'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13911302415421149)
,p_theme_id=>42
,p_name=>'STACKED_FEATURED'
,p_display_name=>'Stacked Featured'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134914356825603530)
,p_css_classes=>'t-HeroRegion--featured t-HeroRegion--centered'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13912048130421149)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON_NO'
,p_display_name=>'No'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134914356825603530)
,p_css_classes=>'t-HeroRegion--hideIcon'
,p_group_id=>wwv_flow_api.id(7671269591820037)
,p_template_types=>'REGION'
,p_help_text=>'Hide the Hero Region icon.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13912427662421149)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134914356825603530)
,p_css_classes=>'t-HeroRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the hero region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13916173330421153)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(134910485471603528)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13923775726421156)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13924412215421156)
,p_theme_id=>42
,p_name=>'TEXT_CONTENT'
,p_display_name=>'Text Content'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--textContent'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_help_text=>'Useful for displaying primarily text-based content, such as FAQs and more.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13925079786421157)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13925811669421157)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13926502252421157)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13927265143421157)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13927886271421159)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13928654413421159)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13929350253421159)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13930033708421159)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13930736432421160)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13931469700421160)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13954657998421174)
,p_theme_id=>42
,p_name=>'USE_COMPACT_STYLE'
,p_display_name=>'Use Compact Style'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134918352376603531)
,p_css_classes=>'t-BreadcrumbRegion--compactTitle'
,p_template_types=>'REGION'
,p_help_text=>'Uses a compact style for the breadcrumbs.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13959928137421181)
,p_theme_id=>42
,p_name=>'ADD_BODY_PADDING'
,p_display_name=>'Add Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(13959427760421178)
,p_css_classes=>'t-ContentBlock--padded'
,p_template_types=>'REGION'
,p_help_text=>'Adds padding to the region''s body container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13960356104421181)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H1'
,p_display_name=>'Heading Level 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(13959427760421178)
,p_css_classes=>'t-ContentBlock--h1'
,p_group_id=>wwv_flow_api.id(7676024622820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13960751199421181)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H2'
,p_display_name=>'Heading Level 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(13959427760421178)
,p_css_classes=>'t-ContentBlock--h2'
,p_group_id=>wwv_flow_api.id(7676024622820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13961113429421181)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H3'
,p_display_name=>'Heading Level 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(13959427760421178)
,p_css_classes=>'t-ContentBlock--h3'
,p_group_id=>wwv_flow_api.id(7676024622820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13961511020421181)
,p_theme_id=>42
,p_name=>'LIGHT_BACKGROUND'
,p_display_name=>'Light Background'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(13959427760421178)
,p_css_classes=>'t-ContentBlock--lightBG'
,p_group_id=>wwv_flow_api.id(7670086510820037)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly lighter background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13961883734421181)
,p_theme_id=>42
,p_name=>'SHADOW_BACKGROUND'
,p_display_name=>'Shadow Background'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(13959427760421178)
,p_css_classes=>'t-ContentBlock--shadowBG'
,p_group_id=>wwv_flow_api.id(7670086510820037)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly darker background.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13964365048421184)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13965043865421184)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(7666087187820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13965719057421185)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(7666087187820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13975986272421192)
,p_theme_id=>42
,p_name=>'CARDS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--stacked'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Stacks the cards on top of each other.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13976725849421192)
,p_theme_id=>42
,p_name=>'COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(7661316635820035)
,p_template_types=>'LIST'
,p_help_text=>'Fills the card background with the color of the icon or default link style.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13977468215421192)
,p_theme_id=>42
,p_name=>'RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(7661316635820035)
,p_template_types=>'LIST'
,p_help_text=>'Raises the card so it pops up.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13977798671421193)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13978505759421193)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(7666087187820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13994256327421203)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies colors from the Theme''s color palette to icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(13994898916421203)
,p_theme_id=>42
,p_name=>'LIST_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(7665643823820035)
,p_template_types=>'LIST'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14002516790421209)
,p_theme_id=>42
,p_name=>'COLLAPSED_DEFAULT'
,p_display_name=>'Collapsed by Default'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134934648048603547)
,p_css_classes=>'js-defaultCollapsed'
,p_template_types=>'LIST'
,p_help_text=>'This option will load the side navigation menu in a collapsed state by default.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14009564922421213)
,p_theme_id=>42
,p_name=>'VERTICAL_LIST'
,p_display_name=>'Vertical Orientation'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134933269969603545)
,p_css_classes=>'t-WizardSteps--vertical'
,p_template_types=>'LIST'
,p_help_text=>'Displays the wizard progress list in a vertical orientation and is suitable for displaying within a side column of a page.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14012391525421215)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS_SM'
,p_display_name=>'Display labels'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(14011924661421215)
,p_css_classes=>'t-NavTabs--displayLabels-sm'
,p_group_id=>wwv_flow_api.id(7665236853820035)
,p_template_types=>'LIST'
,p_help_text=>'Displays the label for the list items below the icon'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14012801283421215)
,p_theme_id=>42
,p_name=>'HIDE_LABELS_SM'
,p_display_name=>'Do not display labels'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(14011924661421215)
,p_css_classes=>'t-NavTabs--hiddenLabels-sm'
,p_group_id=>wwv_flow_api.id(7665236853820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14013216713421215)
,p_theme_id=>42
,p_name=>'LABEL_ABOVE_LG'
,p_display_name=>'Display labels above'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(14011924661421215)
,p_css_classes=>'t-NavTabs--stacked'
,p_group_id=>wwv_flow_api.id(7662876582820035)
,p_template_types=>'LIST'
,p_help_text=>'Display the label stacked above the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14013586333421217)
,p_theme_id=>42
,p_name=>'LABEL_INLINE_LG'
,p_display_name=>'Display labels inline'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(14011924661421215)
,p_css_classes=>'t-NavTabs--inlineLabels-lg'
,p_group_id=>wwv_flow_api.id(7662876582820035)
,p_template_types=>'LIST'
,p_help_text=>'Display the label inline with the icon and badge'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14014034318421217)
,p_theme_id=>42
,p_name=>'NO_LABEL_LG'
,p_display_name=>'Do not display labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(14011924661421215)
,p_css_classes=>'t-NavTabs--hiddenLabels-lg'
,p_group_id=>wwv_flow_api.id(7662876582820035)
,p_template_types=>'LIST'
,p_help_text=>'Hides the label for the list item'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14015355890421218)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14016023003421220)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_api.id(7683628086820042)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14016756560421220)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_api.id(7683628086820042)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14026930830421226)
,p_theme_id=>42
,p_name=>'CARDS_COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_api.id(7678873302820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14027635860421226)
,p_theme_id=>42
,p_name=>'CARD_RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_api.id(7678873302820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14028345129421226)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_api.id(7683628086820042)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14028692605421228)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14058292476421248)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_api.id(14057815221421246)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_api.id(7683628086820042)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact version of timeline with smaller text and fewer columns.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14059098509421248)
,p_theme_id=>42
,p_name=>'2_COLUMN_GRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14059550608421248)
,p_theme_id=>42
,p_name=>'3_COLUMN_GRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14059938269421248)
,p_theme_id=>42
,p_name=>'4_COLUMN_GRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14060302336421248)
,p_theme_id=>42
,p_name=>'5_COLUMN_GRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14060712951421249)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14061084789421249)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_api.id(7683313432820042)
,p_template_types=>'REPORT'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14061507765421249)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14061917471421249)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14062280097421249)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14062684930421249)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(14063130599421249)
,p_theme_id=>42
,p_name=>'STACK'
,p_display_name=>'Stack'
,p_display_sequence=>5
,p_report_template_id=>wwv_flow_api.id(14058668020421248)
,p_css_classes=>'t-MediaList--stack'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134905678906603522)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134905827154603525)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(7667295662820037)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134906024829603525)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(7668041175820037)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134906126971603525)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(7667295662820037)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134906305843603525)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(7666829929820037)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134906394337603525)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(7668041175820037)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134906546319603525)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(7667295662820037)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134906603882603525)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(7668041175820037)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134906766393603525)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(7668041175820037)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134906859936603525)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134905408653603519)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(7666829929820037)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134907435196603527)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134907493718603527)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134907635511603527)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134907762420603527)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134907957066603527)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(7678078539820040)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908005568603527)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(7678078539820040)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908094325603527)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(7678078539820040)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908230142603527)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(7678078539820040)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908319662603527)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908455623603527)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908613733603527)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908739959603527)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908791407603527)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908916873603527)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134908992125603527)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134909191864603527)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(7668517231820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134909360728603527)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(7668517231820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134909556656603527)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(7669263597820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134909777092603527)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(7671680185820037)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134909883548603527)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134910080303603527)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134910093375603527)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(7671680185820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134910281122603527)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(7669263597820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134910334045603527)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134910463241603528)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134906989376603525)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134910851025603528)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134910485471603528)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(7670907931820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134910891437603528)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134910485471603528)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(7670907931820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134911014307603528)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134910485471603528)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(7670907931820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134911157130603528)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134910485471603528)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134911280867603528)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134910485471603528)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134911285170603528)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134910485471603528)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134911733530603528)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(134911385607603528)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134911936297603528)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(134911385607603528)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(7669625371820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134912039554603528)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(134911385607603528)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134912090064603528)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(134911385607603528)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(7669625371820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134912574801603528)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134912673750603528)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134912758276603528)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134912819989603528)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913049489603528)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(7670496322820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913121102603530)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(7670496322820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913263958603530)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913326623603530)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913413144603530)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913504471603530)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913617208603530)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913726909603530)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(7669263597820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913877673603530)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913931938603530)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134913985650603530)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134914167028603530)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(7669263597820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134914269105603530)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134912274378603528)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134914596282603530)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134914494121603530)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134914765199603530)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134914494121603530)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134915308832603530)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134915443876603530)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134915554573603530)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134915588398603530)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(7668887868820037)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134915700665603530)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134915866861603531)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134915909567603531)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916024990603531)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916087989603531)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916208622603531)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(7666507992820035)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916303178603531)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(7669263597820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916432417603531)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(7671680185820037)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916532878603531)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916649189603531)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916702334603531)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916868264603531)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(7671680185820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134916953637603531)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(7669263597820037)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134917066828603531)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134915058825603530)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(7676866344820039)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134917474742603531)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134917119777603531)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134917612136603531)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134917119777603531)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(7674432898820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134917847413603531)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134917119777603531)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(7677223625820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134918024627603531)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134917119777603531)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(7677715310820040)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134918121546603531)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134917119777603531)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(7677715310820040)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134918244592603531)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134917119777603531)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(7677223625820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134918471236603531)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(134918352376603531)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134918594110603533)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(134918352376603531)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(7676024622820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134918714202603533)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(134918352376603531)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(7676024622820039)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134919118875603533)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(134918853579603533)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(7672025661820037)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134919231707603533)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134918853579603533)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(7672025661820037)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134919356568603533)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(134918853579603533)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134919692535603536)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134919783993603536)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134919951586603536)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134920033140603536)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134920118796603536)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134920193307603536)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134920357337603536)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134920522041603536)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(7679247061820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134920637107603536)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(7679247061820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134920870992603536)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(7679247061820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134920965032603536)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134921047944603536)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(7679247061820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134921177430603536)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(134919518286603534)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(7679247061820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134921285238603536)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134921469559603536)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134921558774603536)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134921741807603536)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(7683628086820042)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134921916823603536)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134922004655603536)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134922121005603536)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(7683628086820042)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134922334450603536)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(7679635312820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134922396508603538)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(7679635312820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134922528336603538)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(7679635312820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134922700828603538)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(7680908130820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134922869768603538)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(7680908130820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134922965529603538)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(7683628086820042)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134923053260603538)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134923177164603538)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(7679635312820040)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134923234285603538)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(134921189997603536)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134923572698603538)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134923350001603538)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(7680439174820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134923617273603538)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134923350001603538)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(7680439174820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134923991867603538)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134923861639603538)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(7678512336820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134924241081603539)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134923861639603538)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(7682498901820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134924324926603539)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(134923861639603538)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(7682498901820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134924481633603539)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(134923861639603538)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(7682498901820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134924643199603539)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134923861639603538)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(7682827762820040)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134924768587603539)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134923861639603538)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(7682827762820040)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134924794306603539)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134923861639603538)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(7678512336820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134924912197603539)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134923861639603538)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134925062571603539)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134923861639603538)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(7682498901820040)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134925288700603539)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(134925168029603539)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134925423131603539)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134925168029603539)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134925504557603539)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134925168029603539)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134925677972603539)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134925168029603539)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134925704117603539)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134925168029603539)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134925826674603539)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(134925168029603539)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134925967915603539)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(134925168029603539)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134926027870603539)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(134925168029603539)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134926218428603539)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(134926129849603539)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134926352116603539)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134926129849603539)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134926422360603539)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134926129849603539)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134926491455603539)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(134926129849603539)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134926649597603539)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(134926129849603539)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(7681670231820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134926701959603539)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(134926129849603539)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134926804420603539)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(134926129849603539)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134926883723603539)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(134926129849603539)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(7681268621820040)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134927264185603542)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(7661644357820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134927388611603542)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134927548190603542)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134927643430603542)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134927718888603542)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134927816524603542)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134927900248603542)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134928033742603542)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134928103757603542)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(7661644357820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134928281992603542)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(7661644357820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134928448029603542)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(7661644357820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134928484418603542)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134928627155603542)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(134926983488603541)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(7661644357820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134928839394603542)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134928979498603544)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134929031482603544)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134929227551603544)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(7666087187820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134929383965603544)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134929535049603544)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134929635217603544)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(7666087187820035)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134929881335603544)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(7662041645820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134929930883603544)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(7662041645820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134930009761603544)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(7662041645820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134930208347603544)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(7663644234820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134930318886603544)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(7663644234820035)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134930427459603544)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_api.id(7666087187820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134930503134603544)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134930662698603544)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(7662041645820035)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134930756013603544)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134930897818603544)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931060902603544)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931085946603544)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931203487603544)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931296803603544)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931465206603544)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931566022603544)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931584969603544)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134930810140603544)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Display an icon next to the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931789668603545)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(134931723662603544)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931903805603545)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134931723662603544)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134931984214603545)
,p_theme_id=>42
,p_name=>'ENABLE_SLIDE_ANIMATION'
,p_display_name=>'Enable Slide Animation'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134931723662603544)
,p_css_classes=>'js-slide'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134932117679603545)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134931723662603544)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134932425413603545)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(134932355389603545)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(7664906960820035)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134932552373603545)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134932355389603545)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(7663644234820035)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134932662552603545)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134932355389603545)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(7663644234820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134932834005603545)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134932355389603545)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(7665643823820035)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134932932500603545)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134932355389603545)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(7666087187820035)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134933025213603545)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134932355389603545)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(7666087187820035)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134933159126603545)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(134932355389603545)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(7665643823820035)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134933391832603545)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134933269969603545)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(7664472137820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134933504661603547)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134933269969603545)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(7664472137820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134933659563603547)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134933269969603545)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(7664472137820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134933792290603547)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134933762553603547)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(7666087187820035)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134933934824603547)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(134933762553603547)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134933983419603547)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134933762553603547)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134934146731603547)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134933762553603547)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134934282846603547)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(134933762553603547)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(7663299180820035)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134934465551603547)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(134933762553603547)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(7663299180820035)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134934801196603547)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(134934769377603547)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134934910554603547)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(134934769377603547)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134935077456603547)
,p_theme_id=>42
,p_name=>'ENABLE_SLIDE_ANIMATION'
,p_display_name=>'Enable Slide Animation'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(134934769377603547)
,p_css_classes=>'js-slide'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134935113731603549)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(134934769377603547)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134936154807603552)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(134935911270603552)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(7654109662820032)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(134936237873603552)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(134935911270603552)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(7654109662820032)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/logic/build_options
begin
null;
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/globalization/translations
begin
null;
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/user_interface/shortcuts/delete_confirm_msg
begin
wwv_flow_api.create_shortcut(
 p_id=>wwv_flow_api.id(134961937414929395)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>unistr('Bitte best\00E4tigen Sie, dass diese Daten gel\00F6scht werden sollen')
);
end;
/
prompt --application/shared_components/security/authentications/apex
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(134941278002603591)
,p_name=>'APEX'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
end;
/
prompt --application/shared_components/plugins/dynamic_action/de_condes_plugin_sct
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(151130082189393034)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'DE.CONDES.PLUGIN.SCT'
,p_display_name=>'StatusChartToolkit'
,p_category=>'NAVIGATION'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','DE.CONDES.PLUGIN.SCT'),'')
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'../de/condes/plugin/sct/js/sct.js',
'../de/condes/plugin/sct/js/sctApex.js'))
,p_css_file_urls=>'../de/condes/plugin/sct/css/sct.css'
,p_api_version=>1
,p_render_function=>'plugin_sct.render'
,p_ajax_function=>'plugin_sct.ajax'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>Plugin StatusChartToolkit</h2>',
'<p>Das Plugin vereinfacht die Verwaltung von Formularen auf einer Seite.<br/>Folgende Funktionen sind implementiert:</p>',
unistr('<ul><li>Es k\00F6nnen Regeln definiert werden, die steuern, ob Elemente auf der Seite angezeigt werden oder nicht</li>'),
unistr('  <li>Elemente k\00F6nnen regelbasiert zu Pflichtfeldern erkl\00E4rt und gepr\00FCft werden</li>'),
unistr('  <li>Regeln k\00F6nnen Validierungs- oder Initialisierungscode auf der Datenbank aufrufen</li>'),
unistr('  <li>Regeln werden automatisch rekursiv aufgel\00F6st und rduzieren so die Anzahl der ben\00F6tigten Regeln</li>'),
'  <li>Treten Fehler bei der Initialisierung, Berechnung oder Validierung von Werten auf, werden diese dynamisch auf die Seite integriert</li>',
'</ul>',
unistr('<p>Regeln werden innerhalb von Tabellen in der Datenbank abgelegt. Diese Regeln k\00F6nnen durch eine eigene APEX-Anwendung verwaltet werden und anwendungs\00FCbergreifend eingesetzt werden.</p>')))
,p_version_identifier=>'1.0'
,p_files_version=>24
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(20846395859716776)
,p_plugin_id=>wwv_flow_api.id(151130082189393034)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'SCT-Apexfunktionen'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'de.condes.plugin.sct.apex_42_5_0'
,p_display_length=>40
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>SCT-APEX-Funktionen</h2>',
unistr('<p>Dieser Parameter definiert den Namensraum der JavaScript-Funktionalit\00E4t, die f\00FCr das SCT ben\00F6tigt wird.</p>'),
unistr('<p>Standardm\00E4\00DFig wird de.condes.plugin.sct.apex verwendet und mitgeliefert. Wenn diese Funktionen zum eingesetzten Theme nicht passen, k\00F6nnen Sie eine eigene Kopie dieser Datei erstellen und anpassen.<br/>Stellen Sie sicher, dass die in der mitgelief')
||unistr('erten Datei SCTApex.js implementierten, \00F6ffentlichen Funktionen auch in Ihrer Implementierung vorhanden sind.</p>')))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(151130735923732452)
,p_plugin_id=>wwv_flow_api.id(151130082189393034)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Name der Regelgruppe'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_display_length=>30
,p_max_length=>50
,p_is_translatable=>false
,p_help_text=>unistr('Geben Sie hier den Namen der Regelgruppe ein, die f\00FCr dieses Plugin genutzt werden soll.')
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(82368416177702992)
,p_plugin_id=>wwv_flow_api.id(151130082189393034)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>unistr('Fehlerabh\00E4ngige Elemente')
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_max_length=>200
,p_is_translatable=>false
,p_text_case=>'UPPER'
,p_help_text=>'<p>Liste von Elementnamen, die deaktiviert werden, wenn auf der Seite Fehler auftreten</p>'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2F204E616D6573706163650D0A766172206465203D206465207C7C207B7D3B0D0A64652E636F6E646573203D2064652E636F6E646573207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E203D2064652E636F6E6465732E706C7567696E20';
wwv_flow_api.g_varchar2_table(2) := '7C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E2E736374203D207B7D3B0D0A0D0A0D0A2F2A210D0A2020506C7567696E207A757220537465756572756E67206B6F6D706C6578657220415045582D466F726D756C6172650D0A202A2F0D0A2F';
wwv_flow_api.g_varchar2_table(3) := '2A2A0D0A202A204066696C654F766572766965770D0A202A2044617320506C7567696E2064656C65676965727420646965204265726563686E756E67206465732053746174757320766F6E20466F726D756C6172656C656D656E74656E2065696E657220';
wwv_flow_api.g_varchar2_table(4) := '415045582D536569746520616E2064696520446174656E62616E6B2E0D0A202A20486965727A75207370726963687420657320696E2064657220446174656E62616E6B2065696E6520526567656C67727570706520616E2C2064696520526567656C6E20';
wwv_flow_api.g_varchar2_table(5) := '656E7468C3A46C742E20446965736520526567656C6E206265726563686E656E0D0A202A2064656E205374617475732064657220416E77656E64756E6773656C656D656E74652064657220616B7475656C6C656E2053656974652C20626173696572656E';
wwv_flow_api.g_varchar2_table(6) := '64206175662064656D206D6F6D656E74616E656E2053657373696F6E7374617475732E0D0A202A0D0A202A2044617320506C7567696E2062656EC3B674696774206E75722077656E69676520506172616D657465723A0D0A202A20616A61784964656E74';
wwv_flow_api.g_varchar2_table(7) := '69666965723A20415045582D67656E6572696572746572204964656E7469666965720D0A202A2062696E644974656D733A204C6973746520766F6E2053656974656E656C656D656E74656E2C20616E2064696520616E204576656E747320676562756E64';
wwv_flow_api.g_varchar2_table(8) := '656E20776972642E20446965204C6973746520776972642064757263682064696520446174656E62616E6B0D0A202A2020202020202020202020206265726563686E65742028626173696572656E64206175662064656E2045696E7A656C726567656C6E';
wwv_flow_api.g_varchar2_table(9) := '2920756E6420616C73204A534F4E2D4F626A656B742067656C6965666572742E205A75206A6564656D2053656974656E656C656D656E740D0A202A202020202020202020202020776972642064696520494420756E6420646572204576656E7420616E67';
wwv_flow_api.g_varchar2_table(10) := '65676562656E2C2064657220676562756E64656E2077657264656E20736F6C6C2E0D0A202A20706167654974656D733A204C6973746520766F6E2053656974656E656C656D656E74656E2C20646572656E20616B7475656C6C657220456C656D656E7477';
wwv_flow_api.g_varchar2_table(11) := '657274206265696D204175736CC3B673656E2065696E6573204576656E7473206175662065696E656D200D0A202A202020202020202020202020676562756E64656E656E20456C656D656E742061757367656C6573656E20756E6420616E206469652044';
wwv_flow_api.g_varchar2_table(12) := '6174656E62616E6B20676573636869636B742077657264656E20736F6C6C2E0D0A202A202020202020202020202020446965204C69737465207769726420766F6E2064657220446174656E62616E6B206265726563686E657420756E6420626569206465';
wwv_flow_api.g_varchar2_table(13) := '7220496E697469616C6973696572756E67207665726D65726B740D0A202A20417065784A533A202020204F626A656B742C20646173206469652056697375616C6973696572756E6720766F6E20506C7567696E66756E6B74696F6E656E20617566206465';
wwv_flow_api.g_varchar2_table(14) := '72204F626572666CC3A4636865206B617073656C742E0D0A202A20202020202020202020202044696573657220506172616D65746572207769726420616C73204170706C69636174696F6E2D506172616D657465722064657320506C7567696E73207665';
wwv_flow_api.g_varchar2_table(15) := '7277616C74657420756E64206765737461747465742065732C20646965204A6176615363726970742D0D0A202A2020202020202020202020204C6962726172792C206469652066C3BC7220646965204461727374656C6C756E672076657277656E646574';
wwv_flow_api.g_varchar2_table(16) := '20776972642C2065696E7A757374656C6C656E2E0D0A202A202020202020202020202020446965206B6F6E6B7265746520496D706C656D656E74696572756E67206B616E6E20647572636820646966666572696572656E646520416E666F72646572756E';
wwv_flow_api.g_varchar2_table(17) := '67656E2C206765C3A46E64657274652054656D706C61746573206F64657220736F6E73746967650D0A202A2020202020202020202020204772C3BC6E6465206E696368742067656E65726973636820646566696E696572742077657264656E2E20537461';
wwv_flow_api.g_varchar2_table(18) := '6E646172646DC3A4C39F696720776972642064652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F302076657277656E6465742E0D0A202A20202020202020202020202044657461696C73207A752065696E657220C39C62657273';
wwv_flow_api.g_varchar2_table(19) := '636872656962756E67206469657365722044617465692066696E646574207369636820696E2064657220446F6B756D656E746174696F6E2064657220446174656920736374417065782E6A730D0A202A2020202020202020202020202D207375626D6974';
wwv_flow_api.g_varchar2_table(20) := '0D0A202A2020202020202020202020202020202053656E646574206469652053656974652061622C206E61636864656D2073696368657267657374656C6C742077757264652C206461737320616C6C652050666C6963687466656C646572205765727465';
wwv_flow_api.g_varchar2_table(21) := '20656E7468616C74656E0D0A202A2020202020202020202020202D207365744D616E6461746F72790D0A202A202020202020202020202020202020204D616368742065696E2053656974656E656C656D656E74207A756D2050666C696368742D206F6465';
wwv_flow_api.g_varchar2_table(22) := '72206F7074696F6E616C656E2046656C642C20626173696572656E64206175662065696E656D20626F6F6C65736368656E20506172616D657465720D0A202A2020202020202020202020202D206E6F746966790D0A202A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(23) := '2020205A656967742065696E65204572666F6C67736D656C64756E670D0A202A2020202020202020202020202D207365744572726F72730D0A202A202020202020202020202020202020205A65696774204665686C65726D656C64756E67656E20617566';
wwv_flow_api.g_varchar2_table(24) := '206465722053656974652E2046616C6C732065696E65204665686C6572726567696F6E206578697374696572742C2077657264656E20646965204665686C65726D656C64756E67656E200D0A202A2020202020202020202020202020202068696E7A7567';
wwv_flow_api.g_varchar2_table(25) := '6566C3BC67742C20616E6F6E7374656E20776972642065696E65204665686C6572726567696F6E2065727374656C6C740D0A202A202020202020202020202020576972642065696E6520656967656E6520496D706C656D656E74696572756E6720766F72';
wwv_flow_api.g_varchar2_table(26) := '67656E6F6D6D656E2C20656D70666965686C7420657320736963682C20766F6E20646572206578697374696572656E64656E20736374417065782E6A732061627A756C656974656E2E0D0A202A0D0A202A2044617320506C7567696E2077697264206175';
wwv_flow_api.g_varchar2_table(27) := '662064657220536569746520616C732044796E616D696320416374696F6E207A756D205A65697470756E6B7420504147455F4C4F41442065696E676562756E64656E2E200D0A202A204265696D2045696E66C3BC67656E207769726420646572204E616D';
wwv_flow_api.g_varchar2_table(28) := '6520646572207265666572656E7A69657274656E20526567656C67727570706520616E6765676562656E20736F776965206F7074696F6E616C2065696E65204C6973746520766F6E2053656974656E656C656D656E74656E2C0D0A202A20646965206465';
wwv_flow_api.g_varchar2_table(29) := '616B746976696572742077657264656E20736F6C6C656E2C2077656E6E2065696E204665686C6572206175662064657220536569746520616E67657A6569677420776972642E0D0A202A20576569746572652061646D696E697374726174697665204172';
wwv_flow_api.g_varchar2_table(30) := '6265697420697374206E69636874206572666F726465726C6963680D0A202A2F0D0A2866756E6374696F6E287363742C20242C20736572766572297B0D0A2020200D0A2020766172200D0A2020435F42494E445F4556454E54203D20276368616E676527';
wwv_flow_api.g_varchar2_table(31) := '2C0D0A2020435F434C49434B5F4556454E54203D2027636C69636B272C0D0A2020435F415045585F52454652455348203D20276170657872656672657368272C0D0A2020435F415045585F4245464F52455F52454652455348203D202761706578626566';
wwv_flow_api.g_varchar2_table(32) := '6F726572656672657368272C0D0A2020435F415045585F41465445525F52454652455348203D202761706578616674657272656672657368272C0D0A2020435F4E4F5F54524947474552494E475F4954454D203D2027444F43554D454E54273B0D0A2020';
wwv_flow_api.g_varchar2_table(33) := '0D0A20207363742E616A61784964656E746966696572203D207B7D3B0D0A20207363742E6C6173744974656D56616C756573203D207B7D3B0D0A0D0A2020200D0A20202F2A200D0A20202020507269766174652048696C66736D6574686F64656E200D0A';
wwv_flow_api.g_varchar2_table(34) := '2020202A2F0D0A2020200D0A20202F2F2048696C66736D6574686F64652C207769726420616C732043616C6C6261636B2D4D6574686F64652066C3BC722064656E204368616E67652D4576656E742076657277656E6465740D0A202066756E6374696F6E';
wwv_flow_api.g_varchar2_table(35) := '206368616E676543616C6C6261636B2865297B0D0A20202020617065782E64656275672E6C6F6728604576656E7420C2BB247B652E747970657DC2AB2072616973656420617420247B652E7461726765742E69647D60293B0D0A202020207363742E6578';
wwv_flow_api.g_varchar2_table(36) := '65637574652865293B0D0A20207D3B0D0A20200D0A20200D0A20202F2F2042696E6465742065696E656E206B6F6E6B726574656E204576656E7420616E2065696E20456C656D656E740D0A202066756E6374696F6E2062696E644576656E74286974656D';
wwv_flow_api.g_varchar2_table(37) := '2C206576656E74297B0D0A20202020766172202474686973203D2024286023247B6974656D7D60293B0D0A097661722064617461203D207B27616A61784964656E746966696572273A7363742E616A61784964656E7469666965722C2770616765497465';
wwv_flow_api.g_varchar2_table(38) := '6D73273A7363742E706167654974656D737D3B0D0A202020200D0A202020206966202824746869732E6C656E677468203E2030297B0D0A2020202020202F2F20456C656D656E742069737420617566205365697465206175636820766F7268616E64656E';
wwv_flow_api.g_varchar2_table(39) := '20286BC3B66E6E746520647572636820436F6E646974696F6E206665686C656E290D0A202020202020766172206576656E744C697374203D20242E5F646174612824746869732E6765742830292C20276576656E747327293B0D0A0D0A20202020202069';
wwv_flow_api.g_varchar2_table(40) := '6620286576656E744C697374203D3D20756E646566696E6564207C7C206576656E744C6973745B6576656E745D203D3D20756E646566696E6564297B0D0A20202020202020202F2F20456C656D656E7420686174206E6F6368206B65696E656E20656E74';
wwv_flow_api.g_varchar2_table(41) := '737072656368656E64656E204576656E742C2062696E64656E0D0A202020202020202024746869730D0A20202020202020202E6F6E286576656E742C20646174612C206368616E676543616C6C6261636B293B0D0A20202020202020206966286576656E';
wwv_flow_api.g_varchar2_table(42) := '74203D3D20435F42494E445F4556454E54297B0D0A202020202020202020202F2F204348414E47452D4576656E747320736F6C6C656E20626569204150455852454652455348206E696368742061757367656CC3B673742077657264656E2C2070617573';
wwv_flow_api.g_varchar2_table(43) := '696572656E0D0A2020202020202020202024746869730D0A202020202020202020202E6F6E28435F415045585F4245464F52455F524546524553482C2066756E6374696F6E2865297B0D0A202020202020202020202020242874686973292E6F66662843';
wwv_flow_api.g_varchar2_table(44) := '5F42494E445F4556454E54293B0D0A202020202020202020202020617065782E64656275672E6C6F6728604576656E7420C2BB247B435F42494E445F4556454E547DC2AB2070617573656420617420247B6974656D7D60293B0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(45) := '207D290D0A202020202020202020202E6F6E28435F415045585F41465445525F524546524553482C2066756E6374696F6E2865297B0D0A202020202020202020202020242874686973292E6F6E28435F42494E445F4556454E542C20646174612C206368';
wwv_flow_api.g_varchar2_table(46) := '616E676543616C6C6261636B293B0D0A202020202020202020202020617065782E64656275672E6C6F6728604576656E7420C2BB247B435F42494E445F4556454E547DC2AB2072652D65737461626C697368656420617420247B6974656D7D60293B0D0A';
wwv_flow_api.g_varchar2_table(47) := '202020202020202020207D293B0D0A20202020202020207D3B0D0A2020202020207D3B0D0A202020207D3B0D0A20207D3B0D0A0D0A0D0A20202F2F2042696E64657420616E20616C6C652053656974656E656C656D656E746520617573205343542E4249';
wwv_flow_api.g_varchar2_table(48) := '4E445F4954454D5320616E2064656E204348414E47452D4576656E742C0D0A20202F2F20756D2064696520566572617262656974756E672064657320506C7567696E73206175737A756CC3B673656E0D0A20202F2F20416C6C652072656C6576616E7465';
wwv_flow_api.g_varchar2_table(49) := '6E20456C656D656E74652077657264656E20696E20706167654974656D732068696E7465726C6567742C20756D206265696D204175736CC3B673656E20456C656D656E7477657274650D0A20202F2F20616E2064696520446174656E62616E6B207A7520';
wwv_flow_api.g_varchar2_table(50) := '73656E64656E2E0D0A202066756E6374696F6E2062696E644576656E74732829207B0D0A20202020242E65616368287363742E62696E644974656D732C2066756E6374696F6E28297B0D0A20202020202062696E644576656E7428746869732E69642C20';
wwv_flow_api.g_varchar2_table(51) := '746869732E6576656E74293B0D0A202020207D293B0D0A20207D3B0D0A20200D0A20200D0A20202F2F204D6574686F64652066696E6465742065696E206B6F6E6B726574657320456C656D656E7420696E2065696E656D204A534F4E2D41727261792075';
wwv_flow_api.g_varchar2_table(52) := '6E64206C6965666572742064657373656E2057657274207A7572C3BC636B0D0A20202F2F20537472756B74757220646573204A534F4E2D4172726172793A205B7B226964223A223C49443E222C2276616C7565223A223C576572743E227D2C207B226964';
wwv_flow_api.g_varchar2_table(53) := '223A223C49443E222C2276616C7565223A223C576572743E227D5D0D0A20202F2F20446965204D6574686F6465206E696D6D7420616E2C206461737320226964222065696E646575746967206973742E0D0A202066756E6374696F6E2066696E64497465';
wwv_flow_api.g_varchar2_table(54) := '6D56616C7565286974656D297B0D0A202020202F2F2046696E646520494420696E206C6173744974656D56616C7565730D0A2020202076617220726573756C74203D20242E67726570287363742E6C6173744974656D56616C7565732C2066756E637469';
wwv_flow_api.g_varchar2_table(55) := '6F6E2865297B200D0A20202020202072657475726E20652E6964203D3D206974656D3B200D0A202020207D293B0D0A202020200D0A202020202F2F204C6965666572652056414C55450D0A20202020696628726573756C742E6C656E677468297B0D0A20';
wwv_flow_api.g_varchar2_table(56) := '202020202072657475726E20726573756C745B305D2E76616C75653B0D0A202020207D0D0A20207D3B0D0A20200D0A20200D0A20202F2F204D6574686F6465207A7572204B6F6E76657274696572756E672065696E6572206865786164657A696D616C65';
wwv_flow_api.g_varchar2_table(57) := '6E204461727374656C6C756E6720696E2065696E656E20546578740D0A20202F2F20576972642076657277656E6465742C20756D2062656C696562696765205465787420706572204A534F4E20C3BC6265726D697474656C6E207A75206BC3B66E6E656E';
wwv_flow_api.g_varchar2_table(58) := '2C206F686E652061756677C3A46E6469676573204573636170696E670D0A20202F2F2064757263687A75666872656E2E20496E2064657220446174656E62616E6B2077697264206465722054657874206D697474656C732075746C5F7261772E63617374';
wwv_flow_api.g_varchar2_table(59) := '5F746F5F726177283C544558543E292065727A657567742E0D0A202066756E6374696F6E20686578546F4368617228726177537472696E6729207B0D0A2020202076617220636F6465203D2027273B0D0A2020202076617220686578537472696E673B0D';
wwv_flow_api.g_varchar2_table(60) := '0A2020202069662028726177537472696E67297B7D0D0A202020202020686578537472696E67203D20726177537472696E672E746F537472696E6728293B0D0A202020202020666F7220287661722069203D20303B2069203C20686578537472696E672E';
wwv_flow_api.g_varchar2_table(61) := '6C656E6774683B2069202B3D2032297B0D0A2020202020202020636F6465202B3D20537472696E672E66726F6D43686172436F6465287061727365496E7428686578537472696E672E73756273747228692C2032292C20313629293B0D0A202020202020';
wwv_flow_api.g_varchar2_table(62) := '7D3B0D0A2020202072657475726E20636F64653B0D0A20207D0D0A20200D0A20200D0A20202F2F204D6574686F6465207A75722045726D6974746C756E672064657220494420646573206175736CC3B673656E64656E20456C656D656E74732E0D0A2020';
wwv_flow_api.g_varchar2_table(63) := '66756E6374696F6E2067657454726967676572696E67456C656D656E742865297B0D0A202020202F2F2046616C6C7320506167654C6F61642C20776972642022646F63756D656E74222076657277656E6465740D0A202020207661722074726967676572';
wwv_flow_api.g_varchar2_table(64) := '696E67456C656D656E74203D20435F4E4F5F54524947474552494E475F4954454D0D0A202020200D0A2020202069662028747970656F6620652E74617267657420213D2027756E646566696E656427297B0D0A20202020202074726967676572696E6745';
wwv_flow_api.g_varchar2_table(65) := '6C656D656E74203D20652E7461726765742E69643B0D0A2020202020206966202874726967676572696E67456C656D656E74203D3D20272729207B0D0A20202020202020202F2F2045696E6967652042726F777365722073656E64656E20616363657373';
wwv_flow_api.g_varchar2_table(66) := '4B65792D7370616E20616E737461747420536368616C74666CC3A463686520616C7320747269676765726E64657320456C656D656E740D0A20202020202020202F2F20496E2064696573656E2046C3A46C6C656E20706172656E742D456C656D656E7420';
wwv_flow_api.g_varchar2_table(67) := '616E737072656368656E20756E6420494420766F6E20646F7274206C6573656E0D0A202020202020202074726967676572696E67456C656D656E74203D20652E7461726765742E706172656E74456C656D656E742E69643B0D0A2020202020207D3B0D0A';
wwv_flow_api.g_varchar2_table(68) := '2020202020202474726967676572696E67456C656D656E74203D202428272327202B2074726967676572696E67456C656D656E74293B0D0A2020202020200D0A2020202020206966282474726967676572696E67456C656D656E742E6174747228277479';
wwv_flow_api.g_varchar2_table(69) := '70652729203D3D2027726164696F27297B0D0A20202020202020202F2F20526164696F2D427574746F6E7320686162656E206968726520494420696D20706172656E742D4669656C647365740D0A202020202020202074726967676572696E67456C656D';
wwv_flow_api.g_varchar2_table(70) := '656E74203D202474726967676572696E67456C656D656E742E706172656E747328276669656C6473657427292E617474722827696427293B0D0A2020202020207D0D0A202020202020617065782E64656275672E6C6F67286054726967676572696E6720';
wwv_flow_api.g_varchar2_table(71) := '656C656D656E743A20247B74726967676572696E67456C656D656E747D60293B0D0A202020207D0D0A2020202072657475726E2074726967676572696E67456C656D656E743B0D0A20207D3B0D0A20200D0A20200D0A20202F2F204D6574686F6465207A';
wwv_flow_api.g_varchar2_table(72) := '756D2041757366C3BC6872656E2064657320C3BC626572676562656E656E20436F64657320756E6420616E7363686C6965C39F656E64656D20456E746665726E656E0D0A20202F2F204E696D6D742064656E20436F646520656E74676567656E20756E64';
wwv_flow_api.g_varchar2_table(73) := '2066C3BC677420657320616C7320446F6B756D656E742D467261676D656E742065696E2E0D0A20202F2F20446965732066C3BC6872742064656E20656E7468616C74656E656E204A6176615372636970742D436F646520646972656B74206175732C2073';
wwv_flow_api.g_varchar2_table(74) := '6F2064617373206461732065696E676566C3BC677465200D0A20202F2F20456C656D656E7420616E7363686C6965C39F656E6420646972656B74207769656465722067656CC3B6736368742077657264656E206B616E6E0D0A202066756E6374696F6E20';
wwv_flow_api.g_varchar2_table(75) := '65786563757465436F646528636F6465297B0D0A2020202069662028636F646529207B0D0A202020202020636F6E736F6C652E6C6F672827526573706F6E73652072656365697665643A205C6E27202B202428636F6465292E746578742829293B0D0A20';
wwv_flow_api.g_varchar2_table(76) := '2020202020242827626F647927292E617070656E6428636F6465293B0D0A2020202020202428272327202B202428636F6465292E61747472282769642729292E72656D6F766528293B0D0A202020207D3B0D0A20207D3B0D0A20200D0A20200D0A20202F';
wwv_flow_api.g_varchar2_table(77) := '2A0D0A20202020496D706C656D656E74696572756E672064657220506C7567696E2D46756E6B74696F6E616C6974C3A4740D0A2020202A2F0D0A2020200D0A20202F2F2046756E6B74696F6E656E2C206469652064757263682053637269707420617573';
wwv_flow_api.g_varchar2_table(78) := '20526573706F6E7365206175666765727566656E2077657264656E2E0D0A20207363742E73657452756C654E616D65203D2066756E6374696F6E2872756C654E616D65297B0D0A20202020617065782E64656275672E6C6F67286052756C652075736564';
wwv_flow_api.g_varchar2_table(79) := '3A20247B72756C654E616D657D60293B0D0A202020202F2F20544F444F3A2056657277656E6465746520526567656C206175662053656974656E656C656D656E74206B6F70696572656E3F204576656E7475656C6C207A7573C3A4747A6C696368657220';
wwv_flow_api.g_varchar2_table(80) := '506172616D657465722066C3BC722064696573656E205A7765636B0D0A20207D3B0D0A20200D0A20200D0A20202F2F207365744974656D56616C7565732073796E6368726F6E697369657274206765C3A46E646572746520456C656D656E747765727465';
wwv_flow_api.g_varchar2_table(81) := '206175732064656D2053657373696F6E20537461746520617566206465722053656974652E0D0A20207363742E7365744974656D56616C756573203D2066756E6374696F6E28706167654974656D73297B0D0A202020202F2F20456C656D656E74652075';
wwv_flow_api.g_varchar2_table(82) := '6E642069687265205765727465207A7769736368656E73706569636865726E2066C3BC72205265666572656E7A20617573206173796E6368726F6E656E20417566727566656E0D0A202020207363742E6C6173744974656D56616C756573203D20706167';
wwv_flow_api.g_varchar2_table(83) := '654974656D733B0D0A202020202F2F20456E746E65686D6520646965206E6575656E20456C656D656E74776572746520756E64207365747A652073696520617566206465722053656974650D0A20202020242E6561636828706167654974656D732C2066';
wwv_flow_api.g_varchar2_table(84) := '756E6374696F6E28297B0D0A2020202020206966202828746869732E76616C7565207C7C2027464F4F272920213D2028247628746869732E696429207C7C2027464F4F2729297B0D0A20202020202020202F2F20456C656D656E74776572742077697264';
wwv_flow_api.g_varchar2_table(85) := '2067657365747A742E204C65747A74657220506172616D6574657220756E7465726472C3BC636B74206368616E67652D4576656E740D0A20202020202020207363742E7365744974656D56616C756528746869732E69642C20746869732E76616C756529';
wwv_flow_api.g_varchar2_table(86) := '3B0D0A2020202020202020617065782E64656275672E6C6F6728604974656D2022247B746869732E69647D222073657420746F2022247B746869732E76616C75657D2260293B0D0A2020202020207D3B0D0A202020207D293B0D0A20207D3B0D0A20200D';
wwv_flow_api.g_varchar2_table(87) := '0A20200D0A20207363742E7365744974656D56616C7565203D2066756E6374696F6E286974656D2C2076616C7565297B0D0A09617065782E6974656D286974656D292E73657456616C75652876616C75652C2076616C75652C2074727565293B0D0A2020';
wwv_flow_api.g_varchar2_table(88) := '7D3B0D0A20200D0A20200D0A20202F2F205772617070657220756D207363742E417065784A530D0A20207363742E7365744572726F7273203D2066756E6374696F6E286572726F724C69737429207B0D0A20202020617065782E64656275672E6C6F6728';
wwv_flow_api.g_varchar2_table(89) := '604D61696E7461696E696E67206572726F724C69737460293B0D0A202020207363742E417065784A532E6D61696E7461696E4572726F7273286572726F724C697374293B0D0A20207D3B0D0A20200D0A20200D0A20207363742E7375626D6974203D2066';
wwv_flow_api.g_varchar2_table(90) := '756E6374696F6E28726571756573742C206D657373616765297B0D0A20202020617065782E64656275672E6C6F6728605375626D6974207265636F676E697A656460293B0D0A202020207363742E417065784A532E7375626D6974506167652872657175';
wwv_flow_api.g_varchar2_table(91) := '6573742C206D657373616765293B0D0A20207D3B0D0A20200D0A20200D0A20207363742E7365744D616E6461746F7279203D2066756E6374696F6E286974656D2C206D616E6461746F7279297B0D0A20202020696620286D616E6461746F727920262620';
wwv_flow_api.g_varchar2_table(92) := '242E696E4172726179286974656D2C207363742E706167654974656D7329203D3D202D31297B0D0A20202020202062696E644576656E74286974656D2C20435F42494E445F4556454E54293B0D0A2020202020207363742E706167654974656D732E7075';
wwv_flow_api.g_varchar2_table(93) := '7368286974656D293B0D0A092020617065782E64656275672E6C6F672860456C656D656E7420247B6974656D7D20616464656420746F207761746368206C69737460293B0D0A202020207D0D0A202020207363742E417065784A532E7365744669656C64';
wwv_flow_api.g_varchar2_table(94) := '4D616E6461746F7279286974656D2C206D616E6461746F7279293B0D0A20207D0D0A20200D0A20200D0A20207363742E6E6F74696679203D2066756E6374696F6E286D657373616765297B0D0A202020207363742E417065784A532E7365744E6F746966';
wwv_flow_api.g_varchar2_table(95) := '69636174696F6E286D657373616765293B0D0A20207D3B0D0A20200D0A20200D0A20207363742E72656672657368203D2066756E6374696F6E286974656D297B0D0A2020202024286023247B6974656D7D60290D0A202020202E6F6E6528435F41504558';
wwv_flow_api.g_varchar2_table(96) := '5F41465445525F524546524553482C2066756E6374696F6E2865297B0D0A0909242874686973292E6F6E28435F42494E445F4556454E542C206368616E676543616C6C6261636B293B0D0A097D290D0A092E6F666628435F42494E445F4556454E54290D';
wwv_flow_api.g_varchar2_table(97) := '0A092E7472696767657228435F415045585F52454652455348293B0D0A202020207363742E656E61626C65286974656D293B0D0A20207D3B0D0A20200D0A20200D0A20202F2F204C6F6B616C6520416374696F6E547970652D4D6574686F64656E0D0A20';
wwv_flow_api.g_varchar2_table(98) := '207363742E72656672657368416E6453657456616C7565203D2066756E6374696F6E286974656D297B0D0A092F2F20456C656D656E747765727420766F722064656D20526566726573682073706569636865726E20756E6420616E7363686C6965C39F65';
wwv_flow_api.g_varchar2_table(99) := '6E64207365747A656E0D0A20202020766172206974656D56616C7565203D20617267756D656E74735B315D207C7C2066696E644974656D56616C7565286974656D293B0D0A2020202024286023247B6974656D7D60290D0A202020202E6F6E6528435F41';
wwv_flow_api.g_varchar2_table(100) := '5045585F41465445525F524546524553482C2066756E6374696F6E2865297B0D0A09097363742E7365744974656D56616C7565286974656D2C206974656D56616C7565293B0D0A097D290D0A202020202E7472696767657228435F415045585F52454652';
wwv_flow_api.g_varchar2_table(101) := '455348293B0D0A202020207363742E656E61626C65286974656D293B0D0A20207D3B0D0A20200D0A20200D0A20207363742E64697361626C65203D2066756E6374696F6E286974656D297B0D0A202020202474686973203D2024286023247B6974656D7D';
wwv_flow_api.g_varchar2_table(102) := '60293B0D0A202020206966202824746869732E6973282773656C6563742729297B0D0A2020202020202F2F2053656C6563742D4C697374652C206465616B7469766965726520616C6C652045696E7472C3A46765206175C39F65722064656D20676577C3';
wwv_flow_api.g_varchar2_table(103) := 'A4686C74656E0D0A20202020202024286023247B6974656D7D3A6E6F74283A73656C65637465642960292E70726F70282764697361626C6564272C2074727565293B0D0A202020207D0D0A20202020656C7365206966202824746869732E697328276275';
wwv_flow_api.g_varchar2_table(104) := '74746F6E2729297B0D0A2020202020202F2F20427574746F6E2C207769726420C2BB6E6F726D616CC2AB206465616B746976696572740D0A202020202020617065782E6974656D286974656D292E64697361626C6528293B0D0A202020207D0D0A202020';
wwv_flow_api.g_varchar2_table(105) := '20656C7365206966202824746869732E69732827696E7075742729297B0D0A2020202020202F2F204E6F726D616C657320456C656D656E742C206E69636874206465616B746976696572656E2C20646120616E736F6E7374656E2053657373696F6E7374';
wwv_flow_api.g_varchar2_table(106) := '617465206E6963687420676566C3BC6C6C7420776972642E0D0A2020202020202F2F20537461747464657373656E20726561646F6E6C7920756E64204353532D4B6C61737365207365747A656E2C20736F206461737320657320776965206465616B7469';
wwv_flow_api.g_varchar2_table(107) := '76696572742061757373696568740D0A20202020202024746869732E70726F702827726561646F6E6C79272C2074727565292E616464436C6173732827617065785F64697361626C656427293B0D0A202020207D3B0D0A20202020617065782E6974656D';
wwv_flow_api.g_varchar2_table(108) := '286974656D292E73686F7728293B0D0A20207D3B0D0A20200D0A20200D0A20207363742E656E61626C65203D2066756E6374696F6E286974656D297B0D0A202020202474686973203D2024286023247B6974656D7D60293B0D0A20202020696620282474';
wwv_flow_api.g_varchar2_table(109) := '6869732E6973282773656C6563742729297B0D0A2020202020202F2F2053656C6563742D4C697374652C206465616B7469766965726520616C6C652045696E7472C3A46765206175C39F65722064656D20676577C3A4686C74656E0D0A20202020202024';
wwv_flow_api.g_varchar2_table(110) := '286023247B6974656D7D3A6E6F74283A73656C65637465642960292E70726F70282764697361626C6564272C2066616C7365293B0D0A202020207D0D0A20202020656C7365206966202824746869732E69732827627574746F6E2729297B0D0A20202020';
wwv_flow_api.g_varchar2_table(111) := '20202F2F20427574746F6E2C207769726420C2BB6E6F726D616CC2AB20616B746976696572740D0A202020202020617065782E6974656D286974656D292E656E61626C6528293B0D0A202020207D0D0A20202020656C7365206966202824746869732E69';
wwv_flow_api.g_varchar2_table(112) := '732827696E7075742729297B0D0A2020202020202F2F204E6F726D616C65732045696E67616265656C656D656E7420776172206E69636874206465616B746976696572742C20736F6E6465726E20726561646F6E6C792E205A7572C3BC636B7365747A65';
wwv_flow_api.g_varchar2_table(113) := '6E0D0A20202020202024746869732E70726F702827726561646F6E6C79272C2066616C7365292E72656D6F7665436C6173732827617065785F64697361626C656427293B0D0A202020207D3B0D0A20202020617065782E6974656D286974656D292E7368';
wwv_flow_api.g_varchar2_table(114) := '6F7728293B0D0A20207D3B0D0A2020200D0A20200D0A20202F2F20506C7567696E2D46756E6B74696F6E616C6974C3A4740D0A20207363742E65786563757465203D2066756E6374696F6E2865297B0D0A09696628652E64617461297B0D0A2020202073';
wwv_flow_api.g_varchar2_table(115) := '65727665722E706C7567696E280D0A09092020652E646174612E616A61784964656E7469666965722C0D0A090920207B0D0A09090927783031273A67657454726967676572696E67456C656D656E742865292C0D0A0909092F2F204B6F70696572652061';
wwv_flow_api.g_varchar2_table(116) := '6C6C652072656C6576616E74656E2053656974656E656C656D656E746520696E2064656E2053657373696F6E53746174650D0A09090927706167654974656D73273A652E646174612E706167654974656D730D0A090920207D2C0D0A090920207B0D0A09';
wwv_flow_api.g_varchar2_table(117) := '0909276461746154797065273A2768746D6C272C0D0A0909092773756363657373273A65786563757465436F64650D0A090920207D0D0A0909293B0D0A097D0D0A20207D3B0D0A20200D0A20200D0A20207363742E696E6974203D2066756E6374696F6E';
wwv_flow_api.g_varchar2_table(118) := '286D65297B0D0A202020202F2F2042696E6465206175736CC3B673656E6465204576656E747320616E20456C656D656E74652C2064696520C3BC62657220417474726962757420303120C3BC626572676562656E2077657264656E0D0A20202020736374';
wwv_flow_api.g_varchar2_table(119) := '2E62696E644974656D73203D20242E70617273654A534F4E286D652E616374696F6E2E61747472696275746530312E7265706C616365282F7E2F672C2027222729293B0D0A202020207363742E706167654974656D73203D205B5D3B0D0A202020206966';
wwv_flow_api.g_varchar2_table(120) := '20286D652E616374696F6E2E617474726962757465303229207B0D0A2020202020207363742E706167654974656D73203D206D652E616374696F6E2E61747472696275746530322E73706C697428272C27293B0D0A202020207D3B0D0A202020200D0A20';
wwv_flow_api.g_varchar2_table(121) := '2020202F2F20526567697374726965726520415045582D4A617661536372697074204F626A656B740D0A202020207363742E417065784A53203D206576616C286D652E616374696F6E2E6174747269627574653033293B0D0A202020207363742E616A61';
wwv_flow_api.g_varchar2_table(122) := '784964656E746966696572203D206D652E616374696F6E2E616A61784964656E7469666965723B0D0A202020200D0A202020202F2F20426572656974652045696E7361747A2064657320506C7567696E7320766F720D0A2020202062696E644576656E74';
wwv_flow_api.g_varchar2_table(123) := '7328293B0D0A20202020617065782E64656275672E6C6F67282753435420696E697469616C697A656427293B0D0A202020200D0A202020202F2F20496E697469616C6973696572756E6773636F64652061757366C3BC6872656E0D0A2020202065786563';
wwv_flow_api.g_varchar2_table(124) := '757465436F646528686578546F43686172286D652E616374696F6E2E617474726962757465303429293B0D0A20207D0D0A20200D0A7D292864652E636F6E6465732E706C7567696E2E7363742C20617065782E6A51756572792C20617065782E73657276';
wwv_flow_api.g_varchar2_table(125) := '6572293B0D0A0D0A0D0A2F2F205363686E6974747374656C6C65207A756D20415045582D506C7567696E2D4D656368616E69736D75732C20646965206175732065696E656D206D6972206E696368742062656B616E6E74656E204772756E640D0A2F2F20';
wwv_flow_api.g_varchar2_table(126) := '5363687769657269676B656974656E206D6974206465722056657277656E64756E672065696E6573204E616D656E737261756D6F626A656B747320686162656E0D0A66756E6374696F6E2064655F636F6E6465735F706C7567696E5F73637428297B0D0A';
wwv_flow_api.g_varchar2_table(127) := '202064652E636F6E6465732E706C7567696E2E7363742E696E69742874686973293B0D0A7D0D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(20853056244279798)
,p_plugin_id=>wwv_flow_api.id(151130082189393034)
,p_file_name=>'sct.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E7363742D6572726F72207B0D0A2020636F6C6F723A7265643B0D0A7D0D0A0D0A2E7363742D64697361626C65647B0D0A2020636F6C6F723A677265793B0D0A7D0D0A0D0A2E7363742D64747B0D0A2020626F726465722D746F703A6772657920736F6C';
wwv_flow_api.g_varchar2_table(2) := '6964207468696E3B0D0A2020666F6E742D7765696768743A626F6C643B0D0A2020666F6E742D73697A653A312E32656D3B0D0A202070616464696E672D746F703A203370783B0D0A202070616464696E672D626F74746F6D3A203370783B0D0A20206D61';
wwv_flow_api.g_varchar2_table(3) := '7267696E2D746F703A313870783B0D0A7D0D0A0D0A2E7363742D6361726F7573656C2D6861734572726F727B0D0A20206261636B67726F756E643A72676261283235352C20302C20302C20302E33290D0A7D0D0A0D0A64747B0D0A2020666F6E742D7765';
wwv_flow_api.g_varchar2_table(4) := '696768743A626F6C643B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(20853458951280657)
,p_plugin_id=>wwv_flow_api.id(151130082189393034)
,p_file_name=>'sct.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2F204E616D6573706163650D0A766172206465203D206465207C7C207B7D3B0D0A64652E636F6E646573203D2064652E636F6E646573207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E203D2064652E636F6E6465732E706C7567696E20';
wwv_flow_api.g_varchar2_table(2) := '7C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E2E736374203D2064652E636F6E6465732E706C7567696E2E736374207C7C207B7D3B0D0A64652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F30203D207B7D3B0D0A';
wwv_flow_api.g_varchar2_table(3) := '64652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F31203D207B7D3B0D0A0D0A2F2A210D0A202A2048696C66736D6574686F64656E207A7572204461727374656C6C756E672064657220506C7567696E2D46756E6B74696F6E61';
wwv_flow_api.g_varchar2_table(4) := '6C6974C3A474206175662064657220415045582D4F626572666CC3A46368650D0A202A2F0D0A2F2A2A204066696C654F766572766965770D0A202A204461207369636820696E206469657365722044617465692064657220436F646520626566696E6465';
wwv_flow_api.g_varchar2_table(5) := '742C20646572206D697420646572204F626572666CC3A463686520766F6E204150455820696E7465726167696572742C0D0A202A20626573746568742065696E6520416268C3A46E6769676B65697420766F6E206465722076657277656E646574656E20';
wwv_flow_api.g_varchar2_table(6) := '415045582D56657273696F6E2E0D0A202A2044696573652056657273696F6E206F7269656E7469657274207369636820616D2056657268616C74656E206465722056657273696F6E20352E302C205468656D652034322E20536F6C6C74652065696E6520';
wwv_flow_api.g_varchar2_table(7) := '6E65756572652056657273696F6E2076657277656E6465742077657264656E2C0D0A202A206F6465722065696E205374796C6547756964652065696E67657365747A742077657264656E2C206465722065696E206572776569746572746573206F646572';
wwv_flow_api.g_varchar2_table(8) := '206765C3A46E6465727465732056657268616C74656E206572666F72646572742C206B616E6E206469657320696D706C656D656E74696572740D0A202A2077657264656E2C20696E64656D2065696E6520616E67657061737374652056657273696F6E20';
wwv_flow_api.g_varchar2_table(9) := '6469657365722044617465692076657277656E64657420756E6420C3BC6265722065696E656E20656E74737072656368656E642062656E616E6E74656E204E616D656E737261756D207A7572200D0A202A2056657266C3BC67756E672067657374656C6C';
wwv_flow_api.g_varchar2_table(10) := '7420776972642E20446965736572206B616E6E2064656D20506C7567696E20616C7320436F6D706F6E656E742D506172616D6574657220C3BC626572676562656E2077657264656E2C207374616E646172646DC3A4C39F6967206973742065730D0A202A';
wwv_flow_api.g_varchar2_table(11) := '2064652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F302E0D0A202A0D0A202A20416267656C65697465746520496D706C656D656E74696572756E67656E206DC3BC7373656E20666F6C67656E64652046756E6B74696F6E656E';
wwv_flow_api.g_varchar2_table(12) := '20696D706C656D656E74696572656E3A0D0A202A202D207375626D69745061676528726571756573742C206D657373616765290D0A202A2020204D6574686F6465207072C3BC66742C206F62204665686C65726D656C64756E67656E2061756620646572';
wwv_flow_api.g_varchar2_table(13) := '20536569746520616E67657A656967742077657264656E20756E642077697266742065696E65204665686C65726D656C64756E672C20616E736F6E7374656E0D0A202A202020776972642064696520536569746520C3BC62657220617065782E7375626D';
wwv_flow_api.g_varchar2_table(14) := '6974287265717565737429206162676573636869636B740D0A202A202D207365744669656C644D616E6461746F7279286974656D2C206D616E6461746F7279290D0A202A202020446965204D6574686F64652073746174746574204954454D206D697420';
wwv_flow_api.g_varchar2_table(15) := '64656E204B6C617373656E2065696E65732050666C6963687466656C646573206175732C2066616C6C73204D414E4441544F52592074727565206973742C20616E736F6E7374656E0D0A202A202020656E746665726E7420646965204D6574686F646520';
wwv_flow_api.g_varchar2_table(16) := '646965204B6C617373656E0D0A202A202D206D61696E7461696E4572726F7273286572726F724C697374290D0A202A202020446965204D6574686F646520696D706C656D656E74696572742064696520416E7A6569676520766F6E204665686C65726D65';
wwv_flow_api.g_varchar2_table(17) := '6C64756E67656E2061756620646572204F626572666CC3A46368652E0D0A202A202020446965204665686C65726461727374656C6C756E6720756E64206469652042656E61636872696368746967756E672073696E6420696E204150455820696E206465';
wwv_flow_api.g_varchar2_table(18) := '6E2052656E6465722D50726F7A6573732064657220536569746520696E74656772696572740D0A202A202020756E64206DC3BC7373656E2C2077656E6E207369652064757263682064617320506C7567696E2076657277656E6465742077657264656E20';
wwv_flow_api.g_varchar2_table(19) := '736F6C6C656E2C2068696572206E616368676562696C6465742077657264656E2E0D0A202A202020446965204D6574686F646520657268C3A46C742065696E204A534F4E2D4F626A656B74206D6974204665686C65726E2C206469652061756667657472';
wwv_flow_api.g_varchar2_table(20) := '6574656E2073696E6420756E642064617267657374656C6C742077657264656E206DC3BC7373656E2E0D0A202A202020446965736573204A534F4E2D4F626A656B74207769726420696E20666F6C67656E64656D20466F726D617420C3BC626572676562';
wwv_flow_api.g_varchar2_table(21) := '656E3A0D0A202A20202020207B22636F756E74223A302C202F2F20416E7A61686C20646572204665686C65722C2064696520617566676574726574656E2073696E640D0A202A2020202020202020226572726F72446570656E64656E74427574746F6E73';
wwv_flow_api.g_varchar2_table(22) := '223A22222C202F2F204C6973746520766F6E2053656974656E656C656D656E74656E20286E6F726D616C6572776569736520536368616C74666CC3A46368656E292C20646965206465616B746976696572740D0A202A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(23) := '202020202020202020202020202020202020202020202F2F2077657264656E20736F6C6C656E2C2077656E6E2077656E69677374656E732065696E204665686C6572206175662064657220536569746520616E67657A6569677420776972640D0A202A20';
wwv_flow_api.g_varchar2_table(24) := '2020202020202022666972696E674974656D73223A22222C20202020202020202020202F2F204C6973746520766F6E20456C656D656E74656E2C206469652064757263682064696520616B7475656C6C6520526567656C20626574726F6666656E207369';
wwv_flow_api.g_varchar2_table(25) := '6E642E20566F6E2064696573656E20456C656D656E74656E0D0A202A2020202020202020202020202020202020202020202020202020202020202020202020202F2F206DC3BC7373656E206576656E7475656C6C20766F7268616E64656E65204665686C';
wwv_flow_api.g_varchar2_table(26) := '65726D656C64756E67656E20656E746665726E742077657264656E2E0D0A202A2020202020202020226572726F7273223A5B2020202020202020202020202020202020202F2F204C697374652064657220617566676574726574656E656E204665686C65';
wwv_flow_api.g_varchar2_table(27) := '720D0A202A202020202020202020207B226974656D223A22222C2020202020202020202020202020202F2F2049442064657320456C656D656E74732C206461732064656E204665686C657220657268C3A46C742C206F64657220444F43554D454E542C20';
wwv_flow_api.g_varchar2_table(28) := '0D0A202A2020202020202020202020202020202020202020202020202020202020202020202020202F2F20756D20616E7A757A656967656E2C20646173732065696E2067656E6572656C6C6572204665686C657220766F726C696567740D0A202A202020';
wwv_flow_api.g_varchar2_table(29) := '2020202020202020226D657373616765223A22222C2020202020202020202020202F2F204665686C65726D656C64756E670D0A202A2020202020202020202020226164646974696F6E616C496E666F223A22222020202020202F2F206F7074696F6E616C';
wwv_flow_api.g_varchar2_table(30) := '65205A757361747A696E666F726D6174696F6E656E2C207A2E422E2043616C6C537461636B206574632E0D0A202A202020202020202020207D0D0A202A20202020202020205D0D0A202A20202020207D0D0A202A202020446965204D6574686F64652065';
wwv_flow_api.g_varchar2_table(31) := '6E746665726E74207A756EC3A46368737420616C6C65204665686C65726D656C64756E67656E2064657220456C656D656E74652061757320464952494E4749544D455320756E642066C3BC677420616E7363686C6965C39F656E642064696520C3BC6265';
wwv_flow_api.g_varchar2_table(32) := '72676562656E656E204665686C65722065696E2E0D0A202A202D207365744E6F74696669636174696F6E286D657373616765290D0A202A202020446965204D6574686F6465207A656967742065696E652042656E61636872696368746967756E67206175';
wwv_flow_api.g_varchar2_table(33) := '6620646572204F626572666CC3A46368652E20576972642061756620646572204F626572666CC3A463686520626572656974732065696E65204E616368726963687420616E67657A656967742C200D0A202A2020207769726420646965736520766F7261';
wwv_flow_api.g_varchar2_table(34) := '6220656E746665726E742E2042656E61636872696368746967756E67656E20756E64204665686C65726D656C64756E67656E206DC3BC7373656E2064617261756668696E2067657072C3BC66742077657264656E2C206F62207369652061756368206265';
wwv_flow_api.g_varchar2_table(35) := '69206D6F64616C656E0D0A202A2020204469616C6F67656E206B6F7272656B742066756E6B74696F6E696572656E0D0A202A202D20636C6561724E6F74696669636174696F6E0D0A202A202020446965204D65746F646520656E746665726E742065696E';
wwv_flow_api.g_varchar2_table(36) := '652042656E61636872696368746967756E6720766F6E20646572204F626572666CC3A46368650D0A202A2F0D0A200D0A202F2F2056657273696F6E20352E302C205468656D652034320D0A2866756E6374696F6E28736374297B0D0A2020202F2F204150';
wwv_flow_api.g_varchar2_table(37) := '45582D4665686C6572626568616E646C756E670D0A202076617220435F415045585F4552524F525F434C415353203D2027617065782D706167652D6974656D2D6572726F72273B0D0A202076617220435F415045585F4552524F525F434C4153535F5345';
wwv_flow_api.g_varchar2_table(38) := '4C203D20602E247B435F415045585F4552524F525F434C4153537D2C202E444F43554D454E54603B0D0A20200D0A202076617220435F4D4553534147455F5449544C455F53454C203D20272E742D416C6572742D7469746C65273B202020200D0A202076';
wwv_flow_api.g_varchar2_table(39) := '617220435F4552524F525F434C4153535F53454C203D2020272E742D426F64792D616C657274273B0D0A202076617220435F4552524F525F554C5F53454C203D2060247B435F4552524F525F434C4153535F53454C7D20756C2E68746D6C6462556C4572';
wwv_flow_api.g_varchar2_table(40) := '72603B0D0A202076617220435F4552524F525F524547494F4E5F504F534954494F4E5F53454C203D20272E742D426F64792D636F6E74656E74273B0D0A202076617220435F4552524F525F4449414C4F475F504F534954494F4E5F53454C203D20272E74';
wwv_flow_api.g_varchar2_table(41) := '2D4469616C6F672D626F6479273B0D0A20200D0A202076617220435F4341524F5553454C5F53454C203D20272E612D526567696F6E2D6361726F7573656C4974656D273B0D0A202076617220435F4341524F5553454C5F4552524F525F434C415353203D';
wwv_flow_api.g_varchar2_table(42) := '20277363742D6361726F7573656C2D6861734572726F72273B0D0A20200D0A202076617220435F415045585F4552524F525F49445F53454C203D202723745F416C6572745F4E6F74696669636174696F6E273B0D0A202076617220435F504147455F4552';
wwv_flow_api.g_varchar2_table(43) := '524F525F54454D504C415445203D20603C64697620636C6173733D22742D426F64792D616C657274223E0D0A20203C64697620636C6173733D22742D416C65727420742D416C6572742D2D64656661756C7449636F6E7320742D416C6572742D2D776172';
wwv_flow_api.g_varchar2_table(44) := '6E696E6720742D416C6572742D2D686F72697A6F6E74616C20742D416C6572742D2D7061676520742D416C6572742D2D636F6C6F7242472069732D76697369626C65222069643D22745F416C6572745F4E6F74696669636174696F6E2220726F6C653D22';
wwv_flow_api.g_varchar2_table(45) := '616C657274223E0D0A202020203C64697620636C6173733D22742D416C6572742D77726170223E0D0A2020202020203C64697620636C6173733D22742D416C6572742D69636F6E223E0D0A20202020202020203C7370616E20636C6173733D22742D4963';
wwv_flow_api.g_varchar2_table(46) := '6F6E223E3C2F7370616E3E0D0A2020202020203C2F6469763E0D0A2020202020203C64697620636C6173733D22742D416C6572742D636F6E74656E74223E0D0A20202020202020203C64697620636C6173733D22742D416C6572742D686561646572223E';
wwv_flow_api.g_varchar2_table(47) := '0D0A202020202020202020203C683220636C6173733D22742D416C6572742D7469746C65223E3C2F68323E0D0A20202020202020203C2F6469763E0D0A20202020202020203C64697620636C6173733D22742D416C6572742D626F6479223E0D0A202020';
wwv_flow_api.g_varchar2_table(48) := '202020202020203C756C20636C6173733D2268746D6C6462556C457272223E3C2F756C3E0D0A20202020202020203C2F6469763E0D0A2020202020203C2F6469763E0D0A2020202020203C64697620636C6173733D22742D416C6572742D627574746F6E';
wwv_flow_api.g_varchar2_table(49) := '73223E0D0A20202020202020203C627574746F6E20636C6173733D22742D427574746F6E20742D427574746F6E2D2D6E6F554920742D427574746F6E2D2D69636F6E20742D427574746F6E2D2D636C6F7365416C6572742220747970653D22627574746F';
wwv_flow_api.g_varchar2_table(50) := '6E22207469746C653D225363686C6965C39F656E223E3C7370616E20636C6173733D22742D49636F6E2069636F6E2D636C6F7365223E3C2F7370616E3E3C2F627574746F6E3E0D0A2020202020203C2F6469763E0D0A202020203C2F6469763E0D0A2020';
wwv_flow_api.g_varchar2_table(51) := '3C2F6469763E0D0A3C2F6469763E603B0D0A20200D0A20202F2F205374616E646172642041504558204665686C65726D656C64756E67206265696D20456C656D656E740D0A202076617220435F454C454D454E545F4552524F525F54454D504C41544520';
wwv_flow_api.g_varchar2_table(52) := '3D20603C7370616E20636C6173733D22742D466F726D2D6572726F72223E247B746869732E6D6573736167657D3C2F7370616E3E603B0D0A202076617220435F454C454D454E545F4552524F525F53454C203D2027202E742D466F726D2D6572726F7227';
wwv_flow_api.g_varchar2_table(53) := '3B0D0A0D0A20202F2F2042656E61636872696368746967756E67656E0D0A202076617220435F415045585F4E4F54494649434154494F4E5F49445F53454C203D202723745F416C6572745F53756363657373273B0D0A202076617220435F504147455F4E';
wwv_flow_api.g_varchar2_table(54) := '4F54494649434154494F4E5F54454D504C415445203D20603C64697620636C6173733D22742D426F64792D616C657274223E0D0A20203C6469762069643D22745F416C6572745F537563636573732220636C6173733D22742D416C65727420742D416C65';
wwv_flow_api.g_varchar2_table(55) := '72742D2D64656661756C7449636F6E7320742D416C6572742D2D7375636365737320742D416C6572742D2D686F72697A6F6E74616C20742D416C6572742D2D7061676520742D416C6572742D2D636F6C6F7242472069732D76697369626C652220726F6C';
wwv_flow_api.g_varchar2_table(56) := '653D22616C657274223E0D0A202020203C64697620636C6173733D22742D416C6572742D77726170223E0D0A2020202020203C64697620636C6173733D22742D416C6572742D69636F6E223E0D0A20202020202020203C7370616E20636C6173733D2274';
wwv_flow_api.g_varchar2_table(57) := '2D49636F6E223E3C2F7370616E3E0D0A2020202020203C2F6469763E0D0A2020202020203C64697620636C6173733D22742D416C6572742D636F6E74656E74223E0D0A20202020202020203C64697620636C6173733D22742D416C6572742D6865616465';
wwv_flow_api.g_varchar2_table(58) := '72223E0D0A202020202020202020203C683220636C6173733D22742D416C6572742D7469746C65223E3C2F68323E0D0A20202020202020203C2F6469763E0D0A2020202020203C2F6469763E0D0A20202020202020203C64697620636C6173733D22742D';
wwv_flow_api.g_varchar2_table(59) := '416C6572742D626F6479223E3C2F6469763E0D0A2020202020203C64697620636C6173733D22742D416C6572742D627574746F6E73223E0D0A20202020202020203C627574746F6E20636C6173733D22742D427574746F6E20742D427574746F6E2D2D6E';
wwv_flow_api.g_varchar2_table(60) := '6F554920742D427574746F6E2D2D69636F6E20742D427574746F6E2D2D636C6F7365416C6572742220747970653D22627574746F6E22207469746C653D225363686C6965C39F656E223E3C7370616E20636C6173733D22742D49636F6E2069636F6E2D63';
wwv_flow_api.g_varchar2_table(61) := '6C6F7365223E3C2F7370616E3E3C2F627574746F6E3E0D0A2020202020203C2F6469763E0D0A202020203C2F6469763E0D0A20203C2F6469763E0D0A3C2F6469763E603B0D0A20200D0A20202F2F2050666C6963687466656C6465720D0A202076617220';
wwv_flow_api.g_varchar2_table(62) := '435F52455155495245445F5350414E5F53454C203D20277370616E2E742D466F726D2D7265717569726564273B0D0A202076617220435F4649454C445F52455155495245445F54454D504C415445203D20273C7370616E20636C6173733D22742D466F72';
wwv_flow_api.g_varchar2_table(63) := '6D2D7265717569726564223E3C7370616E20636C6173733D22612D49636F6E2069636F6E2D617374657269736B223E3C2F7370616E3E3C2F7370616E3E273B0D0A2020766172206572726F72436F756E743B0D0A0D0A20202F2F2048696C667366756E6B';
wwv_flow_api.g_varchar2_table(64) := '74696F6E656E0D0A202066756E6374696F6E207365744D6573736167652829207B0D0A202020206572726F72436F756E74203D202428435F415045585F4552524F525F434C4153535F53454C292E6C656E6774683B0D0A20202020617065782E64656275';
wwv_flow_api.g_varchar2_table(65) := '672E6C6F672860416E7A61686C204665686C65723A20247B6572726F72436F756E747D60293B0D0A20202020246D6573736167655469746C65203D202428435F4D4553534147455F5449544C455F53454C293B0D0A2020200D0A20202020737769746368';
wwv_flow_api.g_varchar2_table(66) := '20286572726F72436F756E74297B0D0A09202020206361736520303A0D0A2020202020202020246D6573736167655469746C652E7465787428604B65696E65204665686C657260293B0D0A2020202020202020627265616B3B0D0A092020200D0A092020';
wwv_flow_api.g_varchar2_table(67) := '20206361736520313A0D0A2020202020202020246D6573736167655469746C652E7465787428604573206973742031204665686C657220617566676574726574656E60293B0D0A2020202020202020627265616B3B0D0A092020200D0A09202020206465';
wwv_flow_api.g_varchar2_table(68) := '6661756C743A0D0A202020202020246D6573736167655469746C652E74657874286045732073696E6420247B6572726F72436F756E747D204665686C657220617566676574726574656E60293B0D0A202020207D3B0D0A20207D3B0D0A20200D0A20200D';
wwv_flow_api.g_varchar2_table(69) := '0A20202F2F2048696C667366756E6B74696F6E207A756D2042657265696E6967656E2064657220536569746520766F6E204665686C65726D656C64756E67656E0D0A202066756E6374696F6E2072656D6F76654572726F7273286572726F724C69737429';
wwv_flow_api.g_varchar2_table(70) := '207B0D0A2020202076617220666972696E674974656D73203D206572726F724C6973742E666972696E674974656D732E73706C697428272C27293B0D0A202020200D0A20202020242E6561636828666972696E674974656D732C2066756E6374696F6E28';
wwv_flow_api.g_varchar2_table(71) := '297B0D0A20202020202024286023247B746869737D247B435F415045585F4552524F525F434C4153535F53454C7D60290D0A2020202020202E72656D6F7665436C61737328435F415045585F4552524F525F434C415353290D0A2020202020202E736962';
wwv_flow_api.g_varchar2_table(72) := '6C696E677328277370616E27290D0A2020202020202E72656D6F766528293B0D0A0D0A2020202020206572726F72436F756E74203D202428435F415045585F4552524F525F434C4153535F53454C292E6C656E6774683B0D0A2020202020206966202865';
wwv_flow_api.g_varchar2_table(73) := '72726F72436F756E74203D3D2030297B0D0A20202020202020202428435F4552524F525F434C4153535F53454C292E72656D6F766528293B0D0A2020202020207D0D0A202020202020656C73657B0D0A2020202020202020242860247B435F4552524F52';
wwv_flow_api.g_varchar2_table(74) := '5F434C4153535F53454C7D202E247B746869737D60292E72656D6F766528293B0D0A2020202020207D0D0A2020202020200D0A2020202020202F2F204CC3B673636865204665686C6572206175732052656769737465726B617274656E2D526569746572';
wwv_flow_api.g_varchar2_table(75) := '6E2C2066616C6C73206B65696E65204665686C657220656E7468616C74656E2073696E640D0A202020202020766172206361726F7573656C4944203D2024286023247B746869737D60292E636C6F7365737428435F4341524F5553454C5F53454C292E61';
wwv_flow_api.g_varchar2_table(76) := '7474722827696427293B0D0A20202020202069662028286361726F7573656C494429202626202824286023247B6361726F7573656C49447D20247B435F415045585F4552524F525F434C4153535F53454C7D60292E6C656E677468203D3D20302929207B';
wwv_flow_api.g_varchar2_table(77) := '0D0A2020202020202020242860612E612D526567696F6E2D6361726F7573656C4C696E6B5B687265663D2223247B6361726F7573656C49447D225D60292E72656D6F7665436C61737328435F4341524F5553454C5F4552524F525F434C415353293B0D0A';
wwv_flow_api.g_varchar2_table(78) := '2020202020207D3B0D0A202020207D293B0D0A20207D3B0D0A0D0A20200D0A20202F2F20446965204D6574686F6465207365744572726F7273207769726420766F6E20526573706F6E7365206175666765727566656E20756E6420646172662064616865';
wwv_flow_api.g_varchar2_table(79) := '72206E6963687420756D62656E616E6E74206F64657220656E746665726E742077657264656E0D0A20202F2A2A0D0A2020202A20446965204D6574686F646520626568616E64656C7420616C6C652045696E7A656C6665686C657220617573206572726F';
wwv_flow_api.g_varchar2_table(80) := '724C6973742C2062657265696E6967742064696520626573746568656E6465204665686C65726C697374650D0A2020202A20756E642066C3BC677420646965206E6575656E204665686C65722068696E7A752E205A7573C3A4747A6C696368207A757220';
wwv_flow_api.g_varchar2_table(81) := '415045582D4772756E6466756E6B74696F6E616C6974C3A4742077657264656E204665686C65722061756368200D0A2020202A20696E2052656769737465726B617274656E7265697465726E20616E67657A656967742C2077656E6E2064657220466568';
wwv_flow_api.g_varchar2_table(82) := '6C65722073696368206175662064657220656E74737072656368656E64656E2052656769737465726B6172746520626566696E6465742E0D0A2020202A2F0D0A202066756E6374696F6E207365744572726F7273286572726F724C69737429207B0D0A20';
wwv_flow_api.g_varchar2_table(83) := '2020200D0A20202020696620286572726F724C6973742E636F756E74203E2030297B0D0A202020202020617065782E64656275672E6C6F672860416E7A61686C204665686C657220506C7567496E3A20247B6572726F724C6973742E636F756E747D6029';
wwv_flow_api.g_varchar2_table(84) := '3B0D0A092020200D0A20202020202069662028242860247B435F4552524F525F434C4153535F53454C7D20247B435F415045585F4552524F525F49445F53454C7D60292E6C656E677468203D3D2030297B0D0A20202020202020202F2F20457320697374';
wwv_flow_api.g_varchar2_table(85) := '206B65696E65204665686C6572726567696F6E206175662064657220536569746520766F7268616E64656E2C20616E7A656967656E0D0A2020202020202020696620282428435F4552524F525F4449414C4F475F504F534954494F4E5F53454C292E6C65';
wwv_flow_api.g_varchar2_table(86) := '6E677468297B200D0A202020202020202020202F2F20457320776972642065696E65206D6F64616C6520536569746520616E67657A656967740D0A202020202020202020202428435F4552524F525F4449414C4F475F504F534954494F4E5F53454C292E';
wwv_flow_api.g_varchar2_table(87) := '70726570656E6428435F504147455F4552524F525F54454D504C415445293B0D0A20202020202020207D0D0A2020202020202020656C73657B0D0A202020202020202020202428435F4552524F525F524547494F4E5F504F534954494F4E5F53454C292E';
wwv_flow_api.g_varchar2_table(88) := '70726570656E6428435F504147455F4552524F525F54454D504C415445293B0D0A20202020202020207D0D0A2020202020207D0D0A2020202020200D0A2020202020202F2F20416C6C652045696E7A656C6665686C657220626568616E64656C6E0D0A20';
wwv_flow_api.g_varchar2_table(89) := '2020202020242E65616368286572726F724C6973742E6572726F72732C2066756E6374696F6E2829207B0D0A2020202020202020766172206974656D4944203D20746869732E6974656D3B0D0A202020202020202076617220246974656D203D20242860';
wwv_flow_api.g_varchar2_table(90) := '23247B746869732E6974656D7D60293B0D0A2020202020202020766172206974656D4C6162656C203D2024286023247B6974656D49447D5F4C4142454C60292E7465787428293B0D0A2020202020202020766172206C696E6B5461726765743B0D0A2020';
wwv_flow_api.g_varchar2_table(91) := '202020202020766172206C696E6B546578743B0D0A20202020202020200D0A20202020202020202F2F20415045582D4665686C65726B6C6173736520756E64202D6D656C64756E6720616E2064617320456C656D656E742068C3A46E67656E0D0A202020';
wwv_flow_api.g_varchar2_table(92) := '2020202020246974656D0D0A20202020202020202E616464436C61737328435F415045585F4552524F525F434C415353290D0A20202020202020202E7369626C696E677328277370616E27292E72656D6F766528293B0D0A202020202020202024697465';
wwv_flow_api.g_varchar2_table(93) := '6D2E706172656E7428292E617070656E6428603C7370616E20636C6173733D27742D466F726D2D6572726F72273E247B746869732E6D6573736167657D3C2F7370616E3E60293B0D0A20202020202020200D0A20202020202020202F2F204665686C6572';
wwv_flow_api.g_varchar2_table(94) := '726567696F6E20616B7475616C6973696572656E0D0A20202020202020202F2F204665686C65726D656C64756E6720696E204665686C6572726567696F6E20657268C3A46C74204C696E6B20617566206461732046656C64202847656865207A75204665';
wwv_flow_api.g_varchar2_table(95) := '686C65722920736F776965204944207A756D2073656C656B746976656E204CC3B6736368656E0D0A20202020202020206C696E6B546172676574203D20606A6176617363726970743A20617065782E6974656D2827247B6974656D49447D27292E736574';
wwv_flow_api.g_varchar2_table(96) := '466F63757328293B766F69642830293B603B0D0A20202020202020206C696E6B54657874203D206047656865207A75204665686C65723A203C7370616E20636C6173733D27656B2D6974656D4C6162656C54657874273E247B6974656D4C6162656C7D3C';
wwv_flow_api.g_varchar2_table(97) := '2F7370616E3E603B0D0A20202020202020200D0A20202020202020202F2F205465696C2065696E6573204361726F757373656C733F2044616E6E204C696E6B20C3BC626572617262656974656E0D0A202020202020202076617220246361726F7573656C';
wwv_flow_api.g_varchar2_table(98) := '203D20246974656D2E636C6F7365737428435F4341524F5553454C5F53454C293B0D0A202020202020202069662028246361726F7573656C2E6C656E677468297B0D0A20202020202020202020766172206361726F7573656C4964203D20246361726F75';
wwv_flow_api.g_varchar2_table(99) := '73656C2E617474722827696427293B0D0A20202020202020202020766172206361726F7573656C4E616D65203D20246361726F7573656C2E6368696C6472656E28276469765B646174612D6C6162656C5D27292E6461746128276C6162656C27293B0D0A';
wwv_flow_api.g_varchar2_table(100) := '20202020202020202020242860612E612D526567696F6E2D6361726F7573656C4C696E6B5B687265663D2223247B6361726F7573656C49447D225D60292E616464436C61737328435F4341524F5553454C5F4552524F525F434C415353293B0D0A202020';
wwv_flow_api.g_varchar2_table(101) := '202020202020206C696E6B5461726765742E7265706C61636528276A6176617363726970743A20272C20606A6176617363726970743A20242822612E612D526567696F6E2D6361726F7573656C4C696E6B5B687265663D2723247B6361726F7573656C49';
wwv_flow_api.g_varchar2_table(102) := '647D275D22292E636C69636B28293B60293B0D0A202020202020202020206C696E6B54657874202B3D206020696D2052656769737465723A20247B6361726F7573656C4E616D657D603B0D0A20202020202020207D0D0A20202020202020200D0A202020';
wwv_flow_api.g_varchar2_table(103) := '20202020202F2F204665686C657220616C73204C4920696E204665686C6572726567696F6E2065696E66C3BC67656E0D0A20202020202020202428435F4552524F525F554C5F53454C292E617070656E6428603C6C6920636C6173733D2768746D6C6462';
wwv_flow_api.g_varchar2_table(104) := '53746445727220247B6974656D49447D273E247B746869732E6D6573736167657D20283C6120687265663D247B6C696E6B5461726765747D3E247B6C696E6B546578747D3C2F613E293C2F6C693E60293B0D0A09202020207D293B0D0A202020207D3B0D';
wwv_flow_api.g_varchar2_table(105) := '0A20207D3B20200D0A0D0A20202F2A2A0D0A2020202A20446965204D6574686F6465207072C3BC66742C206F622064617320506C7567696E20616268C3A46E6769676520456C656D656E74652076657277616C74657420756E6420737465756572742064';
wwv_flow_api.g_varchar2_table(106) := '6572656E20416B7469766974C3A47420616268C3A46E676967206461766F6E2C0D0A2020202A206F622061756620646572205365697465204665686C657220616E67657A656967742077657264656E206F646572206E696368742E0D0A2020202A2F0D0A';
wwv_flow_api.g_varchar2_table(107) := '202066756E6374696F6E206D61696E7461696E446570656E64656E74456C656D656E7473286572726F724C697374297B0D0A20202020696620286572726F724C6973742E6572726F72446570656E64656E74427574746F6E7320213D206E756C6C202626';
wwv_flow_api.g_varchar2_table(108) := '206572726F724C6973742E6572726F72446570656E64656E74427574746F6E7320213D202727297B0D0A202020202020766172206572726F72446570656E64656E74427574746F6E73203D206572726F724C6973742E6572726F72446570656E64656E74';
wwv_flow_api.g_varchar2_table(109) := '427574746F6E732E73706C697428272C27293B0D0A202020202020696620282428435F415045585F4552524F525F434C4153535F53454C292E6C656E677468203D3D2030297B0D0A2020202020202020242E65616368286572726F72446570656E64656E';
wwv_flow_api.g_varchar2_table(110) := '74427574746F6E732C2066756E6374696F6E2829207B0D0A20202020202020202020617065782E6974656D2874686973292E656E61626C6528293B0D0A20202020202020207D293B0D0A2020202020207D0D0A202020202020656C7365207B0D0A202020';
wwv_flow_api.g_varchar2_table(111) := '2020202020242E65616368286572726F72446570656E64656E74427574746F6E732C2066756E6374696F6E2829207B0D0A20202020202020202020617065782E6974656D2874686973292E64697361626C6528293B0D0A20202020202020207D293B0D0A';
wwv_flow_api.g_varchar2_table(112) := '2020202020207D3B0D0A202020207D3B0D0A20207D3B0D0A0D0A20200D0A20202F2A2A200D0A2020202A204D6574686F64652073656E646574206469652053656974652061622C2066616C6C73206B65696E65204665686C657220617566206465722053';
wwv_flow_api.g_varchar2_table(113) := '6569746520676566756E64656E2077657264656E2E0D0A2020202A2F0D0A20207363742E7375626D697450616765203D2066756E6374696F6E28726571756573742C206D657373616765297B0D0A20202020696620282428435F415045585F4552524F52';
wwv_flow_api.g_varchar2_table(114) := '5F434C4153535F53454C292E6C656E677468203D3D203029207B0D0A202020202020617065782E7375626D69742872657175657374293B0D0A202020207D0D0A20202020656C73657B0D0A202020202020616C657274286D657373616765293B0D0A2020';
wwv_flow_api.g_varchar2_table(115) := '20207D0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574686F6465207A757220537465756572756E6720646572204461727374656C6C756E6720766F6E2050666C69636874656C656D656E74656E0D0A2020202A2F0D0A2020';
wwv_flow_api.g_varchar2_table(116) := '7363742E7365744669656C644D616E6461746F7279203D2066756E6374696F6E286974656D2C206D616E6461746F7279297B0D0A2020202076617220246D616E6461746F72794974656D203D2024286023247B6974656D7D5F4C4142454C60293B0D0A20';
wwv_flow_api.g_varchar2_table(117) := '2020202F2F206576746C2E20766F7268616E64656E65204D61726B696572756E6720656E746665726E656E0D0A20202020246D616E6461746F72794974656D2E7369626C696E677328435F52455155495245445F5350414E5F53454C292E72656D6F7665';
wwv_flow_api.g_varchar2_table(118) := '28293B0D0A202020200D0A202020206966286D616E6461746F7279297B0D0A202020202020246D616E6461746F72794974656D2E706172656E7428292E617070656E6428435F4649454C445F52455155495245445F54454D504C415445293B0D0A202020';
wwv_flow_api.g_varchar2_table(119) := '207D0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574686F64652C20756D204665686C65722061756620646572205365697465207A752076657277616C74656E2E0D0A2020202A2F0D0A20207363742E6D61696E7461696E45';
wwv_flow_api.g_varchar2_table(120) := '72726F7273203D2066756E6374696F6E286572726F724C697374297B0D0A20202020696620286572726F724C6973742E666972696E674974656D7320213D202727207C7C206572726F724C6973742E666972696E674974656D7320213D202727297B2020';
wwv_flow_api.g_varchar2_table(121) := '202020200D0A20202020202072656D6F76654572726F7273286572726F724C697374293B0D0A2020202020207365744572726F7273286572726F724C697374293B0D0A2020202020207365744D65737361676528293B0D0A202020207D0D0A2020202065';
wwv_flow_api.g_varchar2_table(122) := '6C7365207B0D0A202020202020696620282428435F4552524F525F434C4153535F53454C292E6C656E677468203E2030297B0D0A20202020202020202F2F206265696D2053656974656C6164656E2C206576656E7475656C6C20696E20646572204D656C';
wwv_flow_api.g_varchar2_table(123) := '64756E6773726567696F6E20766F7268616E64656E65204665686C6572206D697420756E736572656E204B6C617373656E20766572736568656E0D0A20202020202020202F2F206BC3B66E6E656E206E7572204665686C657220656E7468616C74656E20';
wwv_flow_api.g_varchar2_table(124) := '7365696E2C20646965206175732064657220415045582D53656974656E766572617262656974756E6720726573756C74696572656E0D0A20202020202020202F2F205665726D65726B6520696E2064696573656E204665686C65726E2064696520494420';
wwv_flow_api.g_varchar2_table(125) := '646573207265666572656E7A69657274656E20456C656D656E747320756D2073656C656B746976656E204CC3B6736368656E20C3BC626572204A6176615363726970740D0A2020202020202020242860247B435F4552524F525F434C4153535F53454C7D';
wwv_flow_api.g_varchar2_table(126) := '206C692E68746D6C6462537464457272206160292E656163682866756E6374696F6E28297B0D0A20202020202020202020766172206974656D4C696E6B203D20242874686973292E6174747228276872656627293B0D0A20202020202020202020766172';
wwv_flow_api.g_varchar2_table(127) := '206974656D4E616D65203D206974656D4C696E6B2E6D617463682827617065782E6974656D282E2A292E736574466F63757327295B315D2E7265706C616365282F28275C285C29292F672C202727293B0D0A20202020202020202020242874686973292E';
wwv_flow_api.g_varchar2_table(128) := '636C6F7365737428276C6927292E616464436C617373286974656D4E616D65293B0D0A20202020202020207D293B0D0A2020202020207D3B0D0A202020207D3B0D0A202020202F2F20496E206A6564656D2046616C6C206665686C6572616268C3A46E67';
wwv_flow_api.g_varchar2_table(129) := '69676520456C656D656E746520616B7475616C6973696572656E0D0A202020206D61696E7461696E446570656E64656E74456C656D656E7473286572726F724C697374293B0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574';
wwv_flow_api.g_varchar2_table(130) := '686F6465207A757220416E7A656967652065696E6572204E61636872696368742061756620646572204F626572666CC3A46368650D0A2020202A2F0D0A20207363742E7365744E6F74696669636174696F6E203D2066756E6374696F6E286D6573736167';
wwv_flow_api.g_varchar2_table(131) := '65297B0D0A202020207363742E636C6561724E6F74696669636174696F6E3B0D0A202020202069662028242860247B435F4552524F525F434C4153535F53454C7D20247B435F415045585F4552524F525F49445F53454C7D60292E6C656E677468203D3D';
wwv_flow_api.g_varchar2_table(132) := '2030297B0D0A2020202020202F2F20457320697374206B65696E65204665686C6572726567696F6E206175662064657220536569746520766F7268616E64656E2C20616E7A656967656E0D0A202020202020696620282428435F4552524F525F4449414C';
wwv_flow_api.g_varchar2_table(133) := '4F475F504F534954494F4E5F53454C292E6C656E677468297B200D0A20202020202020202F2F20457320776972642065696E65206D6F64616C6520536569746520616E67657A656967740D0A20202020202020202428435F4552524F525F4449414C4F47';
wwv_flow_api.g_varchar2_table(134) := '5F504F534954494F4E5F53454C292E70726570656E6428435F504147455F4E4F54494649434154494F4E5F54454D504C415445293B0D0A2020202020207D0D0A202020202020656C73657B0D0A20202020202020202428435F4552524F525F524547494F';
wwv_flow_api.g_varchar2_table(135) := '4E5F504F534954494F4E5F53454C292E70726570656E6428435F504147455F4E4F54494649434154494F4E5F54454D504C415445293B0D0A2020202020207D0D0A202020207D3B0D0A202020202428435F4D4553534147455F5449544C455F53454C292E';
wwv_flow_api.g_varchar2_table(136) := '74657874286D657373616765293B202020200D0A202020202428272E742D427574746F6E2D2D636C6F7365416C65727427292E6F6E2827636C69636B272C207363742E636C6561724E6F74696669636174696F6E293B0D0A20207D3B0D0A20200D0A2020';
wwv_flow_api.g_varchar2_table(137) := '0D0A20202F2A2A0D0A2020202A204D6574686F6465207A756D20456E746665726E656E2065696E65722042656E61636872696368746967756E672061756620646572204F7074696F6E0D0A2020202A2F0D0A20207363742E636C6561724E6F7469666963';
wwv_flow_api.g_varchar2_table(138) := '6174696F6E203D2066756E6374696F6E28297B0D0A20202020242860247B435F4552524F525F434C4153535F53454C7D20247B435F415045585F4E4F54494649434154494F4E5F49445F53454C7D60292E706172656E7428292E72656D6F766528293B20';
wwv_flow_api.g_varchar2_table(139) := '202020200D0A20207D3B0D0A7D292864652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F30293B0D0A0D0A0D0A0D0A0D0A0D0A202F2F2056657273696F6E20352E312C205468656D652034320D0A2866756E6374696F6E287363';
wwv_flow_api.g_varchar2_table(140) := '742C206D7367297B0D0A0D0A202076617220435F415045585F4552524F525F434C4153535F53454C203D20276469762E612D4E6F74696669636174696F6E2D2D6572726F72273B0D0A0D0A20202F2F20446965204D6574686F6465207365744572726F72';
wwv_flow_api.g_varchar2_table(141) := '73207769726420766F6E20526573706F6E7365206175666765727566656E20756E642064617266206461686572206E6963687420756D62656E616E6E74206F64657220656E746665726E742077657264656E0D0A20202F2A2A0D0A2020202A2044696520';
wwv_flow_api.g_varchar2_table(142) := '4D6574686F646520626568616E64656C7420616C6C652045696E7A656C6665686C657220617573206572726F724C6973742C2062657265696E6967742064696520626573746568656E6465204665686C65726C697374650D0A2020202A20756E642066C3';
wwv_flow_api.g_varchar2_table(143) := 'BC677420646965206E6575656E204665686C65722068696E7A752E0D0A2020202A2F0D0A202066756E6374696F6E207365744572726F7273286572726F724C69737429207B0D0A0D0A202020202F2F20416C6C652045696E7A656C6665686C6572206265';
wwv_flow_api.g_varchar2_table(144) := '68616E64656C6E20756E642061756620617065782E6D6573736167652E6572726F724F626A65637420616262696C64656E0D0A20202020617065782E64656275672E6C6F672860416E7A61686C204665686C657220506C7567496E3A20247B6572726F72';
wwv_flow_api.g_varchar2_table(145) := '4C6973742E636F756E747D60293B0D0A096D73672E636C6561724572726F727328293B0D0A090D0A09696620286572726F724C6973742E6572726F72732E636F756E74203E2030297B0D0A09096D73672E73686F774572726F7273286572726F724C6973';
wwv_flow_api.g_varchar2_table(146) := '742E6572726F7273293B0D0A097D0D0A20207D3B0D0A0D0A20202F2A2A0D0A2020202A20446965204D6574686F6465207072C3BC66742C206F622064617320506C7567696E20616268C3A46E6769676520456C656D656E74652076657277616C74657420';
wwv_flow_api.g_varchar2_table(147) := '756E64207374657565727420646572656E20416B7469766974C3A47420616268C3A46E676967206461766F6E2C0D0A2020202A206F622061756620646572205365697465204665686C657220616E67657A656967742077657264656E206F646572206E69';
wwv_flow_api.g_varchar2_table(148) := '6368742E0D0A2020202A2F0D0A202066756E6374696F6E206D61696E7461696E446570656E64656E74456C656D656E7473286572726F724C697374297B0D0A20202020696620286572726F724C6973742E6572726F72446570656E64656E74427574746F';
wwv_flow_api.g_varchar2_table(149) := '6E7320213D206E756C6C202626206572726F724C6973742E6572726F72446570656E64656E74427574746F6E7320213D202727297B0D0A202020202020766172206572726F72446570656E64656E74427574746F6E73203D206572726F724C6973742E65';
wwv_flow_api.g_varchar2_table(150) := '72726F72446570656E64656E74427574746F6E732E73706C697428272C27293B0D0A202020202020696620282428435F415045585F4552524F525F434C4153535F53454C292E6C656E677468203D3D2030297B0D0A2020202020202020242E6561636828';
wwv_flow_api.g_varchar2_table(151) := '6572726F72446570656E64656E74427574746F6E732C2066756E6374696F6E2829207B0D0A20202020202020202020617065782E6974656D2874686973292E656E61626C6528293B0D0A20202020202020207D293B0D0A2020202020207D0D0A20202020';
wwv_flow_api.g_varchar2_table(152) := '2020656C7365207B0D0A2020202020202020242E65616368286572726F72446570656E64656E74427574746F6E732C2066756E6374696F6E2829207B0D0A20202020202020202020617065782E6974656D2874686973292E64697361626C6528293B0D0A';
wwv_flow_api.g_varchar2_table(153) := '20202020202020207D293B0D0A2020202020207D3B0D0A202020207D3B0D0A20207D3B0D0A0D0A20200D0A20202F2A2A200D0A2020202A204D6574686F64652073656E646574206469652053656974652061622C2066616C6C73206B65696E6520466568';
wwv_flow_api.g_varchar2_table(154) := '6C6572206175662064657220536569746520676566756E64656E2077657264656E2E0D0A2020202A2F0D0A20207363742E7375626D697450616765203D2066756E6374696F6E28726571756573742C206D657373616765297B0D0A0D0A20202020696620';
wwv_flow_api.g_varchar2_table(155) := '282428435F415045585F4552524F525F434C4153535F53454C292E6C656E677468203D3D203029207B0D0A202020202020617065782E706167652E7375626D6974287B0D0A2020202020202020227265717565737422203A20726571756573742C0D0A20';
wwv_flow_api.g_varchar2_table(156) := '202020202020202273686F775761697422203A20747275650D0A2020202020207D293B0D0A202020207D0D0A20202020656C73657B0D0A2020202020206D73672E616C657274286D657373616765293B0D0A202020207D0D0A20207D3B0D0A20200D0A20';
wwv_flow_api.g_varchar2_table(157) := '200D0A20202F2A2A0D0A2020202A204D6574686F6465207A757220537465756572756E6720646572204461727374656C6C756E6720766F6E2050666C69636874656C656D656E74656E0D0A2020202A2F0D0A20207363742E7365744669656C644D616E64';
wwv_flow_api.g_varchar2_table(158) := '61746F7279203D2066756E6374696F6E286974656D2C206D616E6461746F7279297B0D0A0D0A2020202076617220246D616E6461746F72794974656D203D2024286023247B6974656D7D5F434F4E5441494E455260293B0D0A2020202076617220435F52';
wwv_flow_api.g_varchar2_table(159) := '455155495245445F434C415353203D202769732D7265717569726564273B0D0A0D0A202020202F2F206576746C2E20766F7268616E64656E65204D61726B696572756E6720656E746665726E656E0D0A20202020246D616E6461746F72794974656D2E72';
wwv_flow_api.g_varchar2_table(160) := '656D6F7665436C61737328435F52455155495245445F434C415353293B0D0A202020200D0A202020206966286D616E6461746F7279297B0D0A202020202020246D616E6461746F72794974656D2E616464436C61737328435F52455155495245445F434C';
wwv_flow_api.g_varchar2_table(161) := '415353293B0D0A202020207D0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574686F64652C20756D204665686C65722061756620646572205365697465207A752076657277616C74656E2E0D0A2020202A2F0D0A2020736374';
wwv_flow_api.g_varchar2_table(162) := '2E6D61696E7461696E4572726F7273203D2066756E6374696F6E286572726F724C697374297B0D0A202020206D73672E636C6561724572726F727328290D0A096966286572726F724C6973742E636F756E74203E2030297B0D0A20202020202020206D73';
wwv_flow_api.g_varchar2_table(163) := '672E73686F774572726F7273286572726F724C6973742E6572726F7273293B0D0A097D0D0A202020202F2F20496E206A6564656D2046616C6C206665686C6572616268C3A46E6769676520456C656D656E746520616B7475616C6973696572656E0D0A20';
wwv_flow_api.g_varchar2_table(164) := '2020202F2F206D61696E7461696E446570656E64656E74456C656D656E7473286572726F724C697374293B0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574686F6465207A757220416E7A656967652065696E6572204E6163';
wwv_flow_api.g_varchar2_table(165) := '6872696368742061756620646572204F626572666CC3A46368650D0A2020202A2F0D0A20207363742E7365744E6F74696669636174696F6E203D2066756E6374696F6E286D657373616765297B0D0A202020206D73672E68696465506167655375636365';
wwv_flow_api.g_varchar2_table(166) := '737328293B0D0A202020206D73672E73686F775061676553756363657373286D657373616765293B0D0A20207D3B0D0A20200D0A20200D0A20202F2A2A0D0A2020202A204D6574686F6465207A756D20456E746665726E656E2065696E65722042656E61';
wwv_flow_api.g_varchar2_table(167) := '636872696368746967756E672061756620646572204F7074696F6E0D0A2020202A2F0D0A20207363742E636C6561724E6F74696669636174696F6E203D2066756E6374696F6E28297B0D0A202020206D73672E6869646550616765537563636573732829';
wwv_flow_api.g_varchar2_table(168) := '3B0D0A20207D3B0D0A0D0A7D292864652E636F6E6465732E706C7567696E2E7363742E617065785F34325F355F312C20617065782E6D657373616765293B0D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(20853819784281273)
,p_plugin_id=>wwv_flow_api.id(151130082189393034)
,p_file_name=>'sctApex.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/user_interfaces
begin
wwv_flow_api.create_user_interface(
 p_id=>wwv_flow_api.id(134941020914603572)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ALIAS.:HOME:&SESSION.'
,p_login_url=>'f?p=&APP_ALIAS.:LOGIN_DESKTOP:&SESSION.'
,p_theme_style_by_user_pref=>false
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_api.id(134898851143603502)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_api.id(134934648048603547)
,p_nav_list_template_options=>'#DEFAULT#'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(134940898891603572)
,p_nav_bar_list_template_id=>wwv_flow_api.id(134932220581603545)
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00000
begin
wwv_flow_api.create_page(
 p_id=>0
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Globale Seite - Desktop'
,p_step_title=>'Globale Seite - Desktop'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20180903092023'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12819213968525192)
,p_plug_name=>'Hidden Fields'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_api.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>unistr('\00DCbersicht der Regelgruppen')
,p_alias=>'ADMIN_SGR'
,p_step_title=>unistr('\00DCbersicht der Regelgruppen')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'Home'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181119094307'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(134942854484603608)
,p_plug_name=>'Breadcrumbs'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134918352376603531)
,p_plug_display_sequence=>40
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(134942349375603603)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(134936284759603553)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(135147901714072381)
,p_plug_name=>unistr('Regel\00FCbersicht')
,p_region_name=>'R1_RULE_OVERVIEW'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(134915058825603530)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select "SRU_ID",',
'       "SGR_ID",',
'       "SRU_NAME",',
'       "SRU_CONDITION",',
'       "SRU_FIRING_ITEMS",',
'       "SRU_SORT_SEQ",',
'       "SRU_ACTION",',
'       "SRU_ACTIVE"',
'  from "SCT_UI_MAIN_RULES"'))
,p_plug_source_type=>'NATIVE_IG'
,p_master_region_id=>wwv_flow_api.id(135201789287412339)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4923375385999703)
,p_name=>'SRU_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRU_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Regelname'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>264
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4923470258999704)
,p_name=>'SRU_CONDITION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRU_CONDITION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Bedingung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4923581862999705)
,p_name=>'SRU_FIRING_ITEMS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRU_FIRING_ITEMS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Ausl\00F6sende Elemente')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4923677962999706)
,p_name=>'SRU_SORT_SEQ'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRU_SORT_SEQ'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Seq.'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>30
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4923786107999707)
,p_name=>'SRU_ACTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRU_ACTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Aktionen'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'&SRU_ACTION.'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4923889367999708)
,p_name=>'SRU_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRU_ACTIVE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'aktiv'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_01=>'<i class="fa &SRU_ACTIVE."/>'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4924007211999710)
,p_name=>'SGR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SGR_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>'&nbsp;'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:EDIT_SRU:&SESSION.::&DEBUG.:RP:P5_SRU_ID,P5_SRU_SGR_ID:&SRU_ID.,&SGR_ID.'
,p_link_text=>'<i class=" fa fa-pencil"/>'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_parent_column_id=>wwv_flow_api.id(3697232277984338)
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4924164385999711)
,p_name=>'SRU_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRU_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Sru Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>90
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(3697972951984345)
,p_internal_uid=>3697972951984345
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_no_data_found_message=>unistr('Die Regelgruppe enth\00E4lt keine Aktionen')
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(4929335006009042)
,p_interactive_grid_id=>wwv_flow_api.id(3697972951984345)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(4929457309009043)
,p_report_id=>wwv_flow_api.id(4929335006009042)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4932900414009053)
,p_view_id=>wwv_flow_api.id(4929457309009043)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(4923375385999703)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>272
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4933490134009054)
,p_view_id=>wwv_flow_api.id(4929457309009043)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(4923470258999704)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4933958755009056)
,p_view_id=>wwv_flow_api.id(4929457309009043)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(4923581862999705)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4934480387009057)
,p_view_id=>wwv_flow_api.id(4929457309009043)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(4923677962999706)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>55
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4934934373009059)
,p_view_id=>wwv_flow_api.id(4929457309009043)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(4923786107999707)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4935434353009060)
,p_view_id=>wwv_flow_api.id(4929457309009043)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(4923889367999708)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4952030037060971)
,p_view_id=>wwv_flow_api.id(4929457309009043)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(4924007211999710)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4961068423184459)
,p_view_id=>wwv_flow_api.id(4929457309009043)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(4924164385999711)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(135201789287412339)
,p_plug_name=>'Regelgruppen'
,p_region_name=>'R1_RULE_GROUP'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(134915058825603530)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select "SGR_ID", ',
'"SGR_NAME",',
'"SGR_DESCRIPTION",',
'"PAGE_ID",',
'"APPLICATION_NAME",',
'"PAGE_NAME",',
'"SRU_AMOUNT",',
'"SGR_ACTIVE"',
'from "#OWNER#"."SCT_UI_MAIN_GROUPS" '))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(3697232277984338)
,p_name=>'SGR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SGR_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>'&nbsp;'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:EDIT_SGR:&SESSION.::&DEBUG.:RP:P6_SGR_ID:&SGR_ID.'
,p_link_text=>'<i class="fa fa-pencil"/>'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(3697368823984339)
,p_name=>'SGR_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SGR_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Regelgruppe'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(3697421416984340)
,p_name=>'SGR_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SGR_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Beschreibung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>800
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(3697551075984341)
,p_name=>'APPLICATION_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APPLICATION_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Anwendung'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>298
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(3697633854984342)
,p_name=>'PAGE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAGE_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Anwendungsseite'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>298
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(3697762165984343)
,p_name=>'SRU_AMOUNT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRU_AMOUNT'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Anz. Einzelregeln'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(3697881741984344)
,p_name=>'SGR_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SGR_ACTIVE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'aktiv'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_01=>'<i class="fa &SGR_ACTIVE."/>'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4924349760999713)
,p_name=>'PAGE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PAGE_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Page Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(3697140869984337)
,p_internal_uid=>3697140869984337
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(4915106064970404)
,p_interactive_grid_id=>wwv_flow_api.id(3697140869984337)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(4915221932970404)
,p_report_id=>wwv_flow_api.id(4915106064970404)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(3164434038411)
,p_view_id=>wwv_flow_api.id(4915221932970404)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(4924349760999713)
,p_is_visible=>false
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4915788624970407)
,p_view_id=>wwv_flow_api.id(4915221932970404)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(3697232277984338)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4916265221970410)
,p_view_id=>wwv_flow_api.id(4915221932970404)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(3697368823984339)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>176
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4916717442970414)
,p_view_id=>wwv_flow_api.id(4915221932970404)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(3697421416984340)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>561
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4917296093970415)
,p_view_id=>wwv_flow_api.id(4915221932970404)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(3697551075984341)
,p_is_visible=>false
,p_is_frozen=>false
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4917760310970417)
,p_view_id=>wwv_flow_api.id(4915221932970404)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(3697633854984342)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>323
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4918285347970418)
,p_view_id=>wwv_flow_api.id(4915221932970404)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(3697762165984343)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>118
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4918755986970421)
,p_view_id=>wwv_flow_api.id(4915221932970404)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(3697881741984344)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>50
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(82279021147205537)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(135201789287412339)
,p_button_name=>'COPY_SGR'
,p_button_static_id=>'B1_COPY_RULE_GROUP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Regelgruppe kopieren'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:COPY_SGR:&SESSION.::&DEBUG.:4::'
,p_button_css_classes=>'sct-ui-with-sgr'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(42106747982631692)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(135201789287412339)
,p_button_name=>'EXPORT_SGR'
,p_button_static_id=>'B1_EXPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Regelgruppe(n) exportieren'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EXPORT_SGR:&SESSION.::&DEBUG.:8::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135205648455412358)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(135201789287412339)
,p_button_name=>'CREATE_SGR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Regelgruppe erzeugen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_SGR:&SESSION.::&DEBUG.:6:P6_SGR_APP_ID:&P1_SGR_APP_ID.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135152446873072391)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(135147901714072381)
,p_button_name=>'CREATE_SRU'
,p_button_static_id=>'B1_CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Regel erzeugen'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_SRU:&SESSION.::&DEBUG.:5:P5_SRU_SGR_ID:&P1_SGR_ID.'
,p_button_css_classes=>'sct-ui-with-sgr'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(82377345589804047)
,p_name=>'P1_SGR_APP_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(135201789287412339)
,p_prompt=>'Anwendung filtern'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SGR_APPLICATIONS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_sgr_applications',
' order by r'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Alle Anwendungen -'
,p_cHeight=>1
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(134935482425603550)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(82377779398809103)
,p_name=>'P1_SGR_PAGE_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(135201789287412339)
,p_prompt=>'Anwendungsseite filtern'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SGR_APPLICATION_PAGES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_sgr_app_pages',
' where sgr_app_id = :P1_SGR_APP_ID',
' order by r'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Alle Anwendungsseiten -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(134935482425603550)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135156079892084347)
,p_name=>'P1_SGR_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(12819213968525192)
,p_format_mask=>'fm999G999G990'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135204739490412356)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(135201789287412339)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135205257167412358)
,p_event_id=>wwv_flow_api.id(135204739490412356)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(135201789287412339)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135206070069412358)
,p_name=>'Create Button - Dialog Closed'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(135205648455412358)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135206559479412358)
,p_event_id=>wwv_flow_api.id(135206070069412358)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(135201789287412339)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135237314618682652)
,p_name=>'Edit Rule - Dialog Closed'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(135147901714072381)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135237733813682652)
,p_event_id=>wwv_flow_api.id(135237314618682652)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(135147901714072381)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135276920333096844)
,p_event_id=>wwv_flow_api.id(135237314618682652)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(135201789287412339)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135449091432547902)
,p_name=>'SCT_ADMIN_MAIN'
,p_event_sequence=>50
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20862404898522092)
,p_event_id=>wwv_flow_api.id(135449091432547902)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.CONDES.PLUGIN.SCT'
,p_attribute_01=>'SCT_ADMIN_MAIN'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4924765485999717)
,p_name=>'Neu'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(135147901714072381)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4924804769999718)
,p_event_id=>wwv_flow_api.id(4924765485999717)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Hallo Welt'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4924957672999719)
,p_name=>'Header Detailreport aktualisieren'
,p_event_sequence=>70
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(135201789287412339)
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|interactivegridselectionchange'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4925030211999720)
,p_event_id=>wwv_flow_api.id(4924957672999719)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var C_PARENT_ID = ''R1_RULE_GROUP'',',
'    C_PARENT_SELECTOR = `#${C_PARENT_ID} .a-MediaBlock`,',
'    C_CHILD_ID = ''R1_RULE_OVERVIEW'',',
'    C_CHILD_SELECTOR = `#${C_CHILD_ID} .t-Region-title`,',
'    C_HEADER_COLUM = 2,',
'    C_ID_COLUMN = 0,',
'    row = apex.region(''R1_RULE_GROUP'').widget().interactiveGrid(''getSelectedRecords'')[0];',
'',
unistr('// \00DCberschrift f\00FCr Detailanzeige aktualisieren'),
unistr('$(C_CHILD_SELECTOR).html(`Regel\00FCbersicht \00BB${row[C_HEADER_COLUM]}\00AB`);'),
'',
unistr('// Gew\00E4hlte Regelgruppe persistieren'),
'apex.item(''P1_SGR_ID'').setValue(row[C_ID_COLUMN]);',
'',
'// Filterbank ausblenden',
'$(C_PARENT_SELECTOR).hide();'))
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Aktionstypen'
,p_alias=>'ADMIN_SAT'
,p_step_title=>'Aktionstypen'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181003093508'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(135303704030646302)
,p_plug_name=>'Aktionstypen'
,p_region_name=>'R2_ACTION_TYPE'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134914494121603530)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select "ROW_ID", ',
'       "SAT_ID",',
'       "SAT_NAME",',
'       "SAT_DESCRIPTION",',
'       "SAT_PL_SQL",',
'       "SAT_JS"',
'  from SCT_UI_ACTION_TYPE',
'  ',
''))
,p_plug_source_type=>'NATIVE_IR'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(135304134779646302)
,p_name=>'Aktionstypen'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:EDIT_SAT:&SESSION.::&DEBUG.::P3_ROWID:#ROW_ID#'
,p_detail_link_text=>'<i class="fa fa-pencil"/>'
,p_owner=>'DOAG_ADMIN'
,p_internal_uid=>15696352290420053
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(135304633682646306)
,p_db_column_name=>'SAT_ID'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Eindeutiger Name'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(135304999558646306)
,p_db_column_name=>'SAT_NAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Bezeichnung'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(135305385156646306)
,p_db_column_name=>'SAT_PL_SQL'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'PL/SQL-Code'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(135305848512646308)
,p_db_column_name=>'SAT_JS'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'JavaScript-Code'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(135391885448859027)
,p_db_column_name=>'ROW_ID'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Row Id'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(20854644271341657)
,p_db_column_name=>'SAT_DESCRIPTION'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Hilfstext'
,p_allow_sorting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'CLOB'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(135309825313649163)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'157021'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'SAT_ID:SAT_NAME:SAT_PL_SQL:SAT_JS:ROW_ID:SAT_DESCRIPTION'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(135308589641646309)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134918352376603531)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(134942349375603603)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(134936284759603553)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135307129276646308)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(135303704030646302)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Aktionstyp erstellen'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_SAT:&SESSION.::&DEBUG.:3::'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135306259764646308)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(135303704030646302)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135306758249646308)
,p_event_id=>wwv_flow_api.id(135306259764646308)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(135303704030646302)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135307498887646308)
,p_name=>'Create Button - Dialog Closed'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(135307129276646308)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135308055853646309)
,p_event_id=>wwv_flow_api.id(135307498887646308)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(135303704030646302)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135526365798581852)
,p_name=>'Adjust Vertical Alignment'
,p_event_sequence=>30
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135527239145581855)
,p_event_id=>wwv_flow_api.id(135526365798581852)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#ACTION_TYPE td'').attr(''style'', ''vertical-align:top'')'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(20857525751350360)
,p_name=>'Hide Control Panel'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(135303704030646302)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20857983507350365)
,p_event_id=>wwv_flow_api.id(20857525751350360)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#R2_ACTION_TYPE_control_panel'
,p_attribute_01=>'N'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20858396289350365)
,p_event_id=>wwv_flow_api.id(20857525751350360)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#R2_ACTION_TYPE td'').attr(''style'', ''vertical-align:top'')'
,p_stop_execution_on_error=>'Y'
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_api.create_page(
 p_id=>3
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Aktionstyp bearbeiten'
,p_alias=>'EDIT_SAT'
,p_page_mode=>'MODAL'
,p_step_title=>'Aktionstyp bearbeiten'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'800'
,p_dialog_width=>'1000'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181003095211'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(135294247495646181)
,p_plug_name=>'Aktionstyp bearbeiten'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(135294817128646183)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134911385607603528)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13488242137394899)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(135294817128646183)
,p_button_name=>'HELP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(134935911270603552)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:HELP:&SESSION.::&DEBUG.:RP:P99_TARGET_PAGE:&APP_PAGE_ALIAS.'
,p_icon_css_classes=>'fa fa-question'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135295261322646183)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(135294817128646183)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135294761201646183)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(135294817128646183)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135294594855646183)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(135294817128646183)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135294551666646183)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(135294817128646183)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(20851155562084395)
,p_name=>'P3_SAT_DESCRIPTION'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>Names des Aktionstyps</h2>',
'<p>Beschreibung des Aktionstyps</p>',
'<p><em>Parameter 1</em>:<br>Beschreibung</p>',
'<p><em>Parameter 2</em>:<br>Beschreibung</p>',
'<p><em>Sonstiges/Verwendung</em>:<br>Beschreibung</p>',
''))
,p_prompt=>'Beschreibung'
,p_source=>'SAT_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_cSize=>80
,p_cMaxlength=>4000
,p_cHeight=>9
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_02=>'Intermediate'
,p_attribute_03=>'Y'
,p_attribute_04=>'moonocolor'
,p_attribute_05=>'top'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(22594321396204894)
,p_name=>'P3_SAT_DEFAULT_ATTRIBUTE_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Standard-Attribut 1'
,p_source=>'SAT_DEFAULT_ATTRIBUTE_1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Geben Sie einen PL/SQL-Ausdruck ein, der verwendet werden soll, falls f\00FCr das entsprechende Attribut kein Wert \00FCbergeben wird.<br>Beispiele:<ul><li>''SUBMIT''</li><li>pit.get_message_text(''MY_MESSAGE'')</li></ul>')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(22594431849204895)
,p_name=>'P3_SAT_DEFAULT_ATTRIBUTE_2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Standard-Attribut 2'
,p_source=>'SAT_DEFAULT_ATTRIBUTE_2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Geben Sie einen PL/SQL-Ausdruck ein, der verwendet werden soll, falls f\00FCr das entsprechende Attribut kein Wert \00FCbergeben wird.<br>Beispiele:<ul><li>''SUBMIT''</li><li>pit.get_message_text(''MY_MESSAGE'')</li></ul>')
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(22594529075204896)
,p_name=>'P3_SAT_CHECK_ATTRIBUTE_1'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Testausdruck Attribut 1'
,p_source=>'SAT_CHECK_ATTRIBUTE_1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Ausdruck, um das Attribut zu testen. Der Attributwert kann \00FCber den Ersetzungsanker #VALUE# referenziert werden.<br>Beispiele:<ul><li>#VALUE# is not null</li><li>#VALUE# in (10, 20, 30)</li><li>pit.assert_not_null(#VALUE#)</li></ul><p>Bevorzugt sollt')
||'en PIT-Tests verwendet werden, da die dort erzeugten Fehlermeldungen in den Tests ausgegeben werden.</p>'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(22594685779204897)
,p_name=>'P3_SAT_CHECK_ATTRIBUTE_2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Testausdruck Attribut 2'
,p_source=>'SAT_CHECK_ATTRIBUTE_2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Ausdruck, um das Attribut zu testen. Der Attributwert kann \00FCber den Ersetzungsanker #VALUE# referenziert werden.<br>Beispiele:<ul><li>#VALUE# is not null</li><li>#VALUE# in (10, 20, 30)</li><li>pit.assert_not_null(#VALUE#)</li></ul><p>Bevorzugt sollt')
||'en PIT-Tests verwendet werden, da die dort erzeugten Fehlermeldungen in den Tests ausgegeben werden.</p>'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(31054880184795146)
,p_name=>'P3_SAT_RAISE_RECURSIVE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>unistr('Rekursiv ausf\00FChren')
,p_source=>'SAT_RAISE_RECURSIVE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Legt fest, ob dieser Aktionstyp auch rekursiv ausgel\00F6st werden soll. <br>Normalerweise ist dies der Fall. \00C4ndern Sie dies nur, wenn durch Rekursionen mit diesem Aktionstyp ein falsches Verhalten ausgel\00F6st wird.')
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135297654808646264)
,p_name=>'P3_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(12819213968525192)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135298082041646280)
,p_name=>'P3_SAT_ID'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Eindeutiger Name'
,p_source=>'SAT_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>80
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935572924603550)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Technische ID des Aktionstyps.<br>Legen Sie einen eindeutigen Namen fest.'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135298468844646281)
,p_name=>'P3_SAT_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Bezeichnung'
,p_source=>'SAT_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>200
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Klartextbezeichnung<br>Diese Bezeichnung wird in den Einzelregeln angezeigt.'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135298838080646281)
,p_name=>'P3_SAT_PL_SQL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'PL/SQL-Code'
,p_source=>'SAT_PL_SQL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>80
,p_cMaxlength=>800
,p_cHeight=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_help_text=>unistr('PL/SQL-Fragment, das ausgef\00FChrt werden soll.<br>Der Code wird durch begin .. end umschlossen, ben\00F6tigt aber ein abschlie\00DFendes Semikolon.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135299257353646281)
,p_name=>'P3_SAT_JS'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(135294247495646181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'JavaScript-Code'
,p_source=>'SAT_JS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>800
,p_cHeight=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_help_text=>unistr('JavaScript, der ausgef\00FChrt werden soll. Ben\00F6tigt ein abschlie\00DFendes Semikolon, da nicht gesichert ist, dass Absatzzeichen korrekt erhalten werden.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135295340016646183)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(135295261322646183)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135296136894646184)
,p_event_id=>wwv_flow_api.id(135295340016646183)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(135301151460646284)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from SCT_ACTION_TYPE'
,p_attribute_02=>'SCT_ACTION_TYPE'
,p_attribute_03=>'P3_ROWID'
,p_attribute_04=>'ROWID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(135301570451646284)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of SCT_ACTION_TYPE'
,p_attribute_02=>'SCT_ACTION_TYPE'
,p_attribute_03=>'P3_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(135301901437646284)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(135294761201646183)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(135302328534646284)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
end;
/
prompt --application/pages/page_00004
begin
wwv_flow_api.create_page(
 p_id=>4
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Regelgruppe kopieren'
,p_alias=>'COPY_SGR'
,p_page_mode=>'MODAL'
,p_step_title=>'Regelgruppe kopieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181119095252'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18874391024600971)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134911385607603528)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(82282485125221583)
,p_plug_name=>'Regelgruppe kopieren'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(134915058825603530)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13487915122393460)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(18874391024600971)
,p_button_name=>'HELP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(134935911270603552)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:HELP:&SESSION.::&DEBUG.:RP:P99_TARGET_PAGE:&APP_PAGE_ALIAS.'
,p_icon_css_classes=>'fa fa-question'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(42100617463488369)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18874391024600971)
,p_button_name=>'COPY'
,p_button_static_id=>'B4_COPY'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Kopieren'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(18874662985600974)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(18874391024600971)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(42117127974270375)
,p_name=>'P4_SGR_OVERWRITE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(82282485125221583)
,p_item_default=>'1'
,p_prompt=>unistr('\00DCberschreiben')
,p_display_as=>'NATIVE_YES_NO'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Wenn dieser Parameter gesetzt ist, wird eine Regelgruppe mit gleichem Namen in der Zielanwendung \00FCberschrieben.<br>Andernfalls wird ein Fehler geworfen, wenn die Regelgruppe in der Zielanwendung existiert.')
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(82282937048230385)
,p_name=>'P4_SGR_APP_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(82282485125221583)
,p_prompt=>'von Anwendung'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct application_name || '' ('' || application_id || '')'' d,',
'       application_id r',
'  from apex_applications app',
'  join sct_rule_group sgr',
'    on app.application_id = sgr.sgr_app_id',
' where application_id != :APP_ID',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Quellanwendung -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Quellanwendung, aus der eine Regelgruppe kopiert werden soll.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(82283241868230386)
,p_name=>'P4_SGR_PAGE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(82282485125221583)
,p_prompt=>'von Seite'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct page_name || '' ('' || page_id || '')'' d,',
'       page_id r',
'  from apex_application_pages app',
'  join sct_rule_group sgr',
'    on app.page_id = sgr.sgr_page_id',
' where application_id = :P4_SGR_APP_ID',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Quellseite -'
,p_cSize=>30
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Anwendungsseite der Quellanwendung, auf die sich die zu kopierende Regelgruppe bezieht'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(82283700785230386)
,p_name=>'P4_SGR_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(82282485125221583)
,p_prompt=>'Regelgruppe'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sgr_name d, sgr_id r',
'  from sct_rule_group',
' where sgr_app_id = :P4_SGR_APP_ID',
'   and sgr_page_id = :P4_SGR_PAGE_ID'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Regelgruppenname -'
,p_cSize=>30
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Name der Regelgruppe, die kopiert werden soll.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(82284079375230386)
,p_name=>'P4_SGR_APP_TO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(82282485125221583)
,p_prompt=>'zu Anwendung'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_APPLICATIONS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_applications',
' order by r'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Zielanwendung -'
,p_cSize=>30
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Zielanwendung, in die die Regelgruppe kopiert werden soll.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(82284489454230387)
,p_name=>'P4_SGR_PAGE_TO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(82282485125221583)
,p_prompt=>'zu Seite'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select page_name || '' ('' || page_id || '')'' d,',
'       page_id r',
'  from apex_application_pages',
' where application_id = :P4_SGR_APP_TO',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Zielseite -'
,p_cSize=>30
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Seite der Zielanwendung, f\00FCr die die Regelgruppe kopiert werden soll.<br>Stellen Sie sicher, dass alle angesprochenen Seitenelemente auf dieser Seite existieren, um Erstellungsfehler zu vermeiden.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(42120412372309610)
,p_validation_name=>'Regelgruppe existiert nicht'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sgr_id',
'  from sct_rule_group ',
' where sgr_app_id = :P4_SGR_APP_TO',
'   and sgr_page_id = :P4_SGR_PAGE_TO',
'   and sgr_id = :P4_SGR_ID'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>unistr('Die Regelgruppe existiert in der Zielanwendung.<br>Bitte w\00E4hlen Sie <i>\00DCberschreiben = Ja</i>, um die bestehende Regelgruppe in der Zielanwendung zu \00FCberschreiben.')
,p_validation_condition=>'P4_SGR_OVERWRITE'
,p_validation_condition2=>'0'
,p_validation_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(42122981570464333)
,p_name=>'SCT_COPY_RULEGROUP'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(42123399413464333)
,p_event_id=>wwv_flow_api.id(42122981570464333)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.CONDES.PLUGIN.SCT'
,p_attribute_01=>'SCT_COPY_RULEGROUP'
,p_attribute_02=>'B4_COPY'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(18874652307600973)
,p_name=>'Dialog abbrechen'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(18874662985600974)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(18874497806600972)
,p_event_id=>wwv_flow_api.id(18874652307600973)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(82287401149254901)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Copy RULE_GROUP'
,p_process_sql_clob=>'sct_ui_pkg.copy_rule_group;'
,p_process_error_message=>'Fehler beim Kopieren der Regelgruppe:<br>#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Regelgruppe erfolgreich kopiert.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(42105497286611157)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(42106238251618621)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'close dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_api.create_page(
 p_id=>5
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Regel bearbeiten'
,p_alias=>'EDIT_SRU'
,p_page_mode=>'MODAL'
,p_step_title=>'Regel bearbeiten'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'600'
,p_dialog_width=>'1024'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181119091008'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(8035219889249190)
,p_plug_name=>'Regelaktionen'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134915058825603530)
,p_plug_display_sequence=>25
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id,',
'       sra_sgr_id,',
'       sra_sru_id,',
'       sra_spi_id,',
'       sra_sat_id,',
'       sra_attribute,',
'       sra_attribute_2,',
'       sra_comment,',
'       sra_sort_seq,',
'       sra_on_error,',
'       sra_raise_recursive,',
'       sra_active,',
'       sra_has_error',
'  from sct_ui_edit_sru_action'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4924435045999714)
,p_name=>'ROW_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROW_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>'&nbsp;'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>10
,p_value_alignment=>'LEFT'
,p_link_target=>'f?p=&APP_ID.:EDIT_SRA:&SESSION.::&DEBUG.:RP:P11_ROWID,P11_SRA_SGR_ID,P11_SRA_SRU_ID:&ROW_ID.,&SRA_SGR_ID.,&SRA_SRU_ID.'
,p_link_text=>'<i class="fa fa-pencil"/>'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(4924557283999715)
,p_name=>'SRA_HAS_ERROR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_HAS_ERROR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Sra Has Error'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>130
,p_value_alignment=>'LEFT'
,p_attribute_01=>'<i class="fa &SRA_HAS_ERROR."/>'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8035582660249193)
,p_name=>'SRA_SGR_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_SGR_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>20
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8035680648249194)
,p_name=>'SRA_SRU_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_SRU_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8035726211249195)
,p_name=>'SRA_SPI_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_SPI_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Seitenelement'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8035857320249196)
,p_name=>'SRA_SAT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_SAT_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Aktion'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8035969625249197)
,p_name=>'SRA_ON_ERROR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_ON_ERROR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Fehlerhandler'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>100
,p_value_alignment=>'RIGHT'
,p_attribute_01=>'<i class="fa &SRA_ON_ERROR."/>'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8036033408249198)
,p_name=>'SRA_ATTRIBUTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_ATTRIBUTE'
,p_data_type=>'CLOB'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Attribut 1'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>32767
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8036204812249199)
,p_name=>'SRA_ATTRIBUTE_2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_ATTRIBUTE_2'
,p_data_type=>'CLOB'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Attribut 2'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>32767
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8036305704249200)
,p_name=>'SRA_COMMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_COMMENT'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Kommentar'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>800
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8036370487249201)
,p_name=>'SRA_RAISE_RECURSIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_RAISE_RECURSIVE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'Rekursiv'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>110
,p_value_alignment=>'RIGHT'
,p_attribute_01=>'<i class="fa &SRA_RAISE_RECURSIVE."/>'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8036447385249202)
,p_name=>'SRA_SORT_SEQ'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_SORT_SEQ'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Seq.'
,p_label=>'Sequenz'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>40
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(8036547338249203)
,p_name=>'SRA_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SRA_ACTIVE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading=>'aktiv'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>120
,p_value_alignment=>'RIGHT'
,p_attribute_01=>'<i class="fa &SRA_ACTIVE."/>'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(8035365831249191)
,p_internal_uid=>3693646431984302
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(8041056438254865)
,p_interactive_grid_id=>wwv_flow_api.id(8035365831249191)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(8041196569254865)
,p_report_id=>wwv_flow_api.id(8041056438254865)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4973106879374615)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(4924435045999714)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(4973653507374617)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(4924557283999715)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8042158764254873)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(8035582660249193)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8042674631254874)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(8035680648249194)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8043182990254876)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(8035726211249195)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>217
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8043643199254878)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(8035857320249196)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>230
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8044169749254878)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(8035969625249197)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8044659249254879)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(8036033408249198)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8045127148254881)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(8036204812249199)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>122
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8045675754254882)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(8036305704249200)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>257
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8046181609254884)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(8036370487249201)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>71
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8046633488254885)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(8036447385249202)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>44
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(8047176164254887)
,p_view_id=>wwv_flow_api.id(8041196569254865)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(8036547338249203)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>47
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(134978818907430820)
,p_plug_name=>'Regel bearbeiten'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(134979549807430822)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134911385607603528)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3696826359984334)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(8035219889249190)
,p_button_name=>'CREATE_SRA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Aktion erstellen'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_SRA:&SESSION.::&DEBUG.:RP,EDIT_SRA:P11_ROWID,P11_SRA_SGR_ID,P11_SRA_SRU_ID:,&P5_SRU_SGR_ID.,&P5_SRU_ID.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12818260576525182)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(134979549807430822)
,p_button_name=>'HELP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(134935911270603552)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:HELP:&SESSION.::&DEBUG.:RP:P99_TARGET_PAGE:&APP_PAGE_ALIAS.'
,p_icon_css_classes=>'fa fa-question'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(134979903731430824)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(134979549807430822)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(134979447146430822)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(134979549807430822)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>unistr('Regel l\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P5_SRU_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(134979299278430822)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(134979549807430822)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P5_SRU_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(134979238255430822)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(134979549807430822)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erzeugen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P5_SRU_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(119707001591012595)
,p_name=>'P5_SRU_ACTIVE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(134978818907430820)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>'Aktiv'
,p_source=>'SRU_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(134982744461430919)
,p_name=>'P5_SRU_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(12819213968525192)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'999990'
,p_source=>'SRU_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(134983063220430920)
,p_name=>'P5_SRU_SGR_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(12819213968525192)
,p_use_cache_before_default=>'NO'
,p_item_default=>':P1_SGR_ID;'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_format_mask=>'999990'
,p_source=>'SRU_SGR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(134983398316430920)
,p_name=>'P5_SRU_NAME'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(134978818907430820)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name'
,p_source=>'SRU_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>200
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
unistr('  Name der Regel. Verwendent Sie einen sprechenden Namen, der Ihnen anzeigt, was diese Regel pr\00FCfen soll.'),
'</p>'))
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(134983807918430920)
,p_name=>'P5_SRU_CONDITION'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(134978818907430820)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Bedingung'
,p_source=>'SRU_CONDITION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>40
,p_cMaxlength=>255
,p_cHeight=>2
,p_field_template=>wwv_flow_api.id(134935572924603550)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>',
'  Bedingung',
'</h2>',
'<p>',
unistr('  Geben Sie eine Bedingung in SQL-Syntax, \00E4hnlich einer WHERE-Klausel, ein. Zur Filterung stehen alle Seitenelemente als Spalte zur Verf\00FCgung, allerdings ohne das Pr\00E4fix "Pn_". Geben Sie kein Semikolon ein.'),
'</p>',
'<p>',
'  Beispiel: <pre>gueltig_ab != gueltig_bis</pre>',
'</p>'))
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135092696921607614)
,p_name=>'P5_SRU_SORT_SEQ'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(134978818907430820)
,p_use_cache_before_default=>'NO'
,p_item_default=>'sct_ui_pkg.get_sru_sort_seq(:P5_SRU_SGR_ID);'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Sequenz'
,p_source=>'SRU_SORT_SEQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>10
,p_colspan=>5
,p_field_template=>wwv_flow_api.id(134935572924603550)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'  Mit der Sequenznummer wird die Reihenfolge der Auswertung der Regeln gesteuert.',
'</p>',
'<p>',
unistr('  Grunds\00E4tzlich wird nur die erste, passende Regel ausgef\00FChrt, um ungewollte Seiteneffekte zu vermeiden.<br>'),
unistr('  Stellen Sie daher sicher, dass die speziellste Regel zuerst und die allgemeineren Regeln sp\00E4ter ausgef\00FChrt werden.'),
'</p>',
'<p>',
unistr('  Sie k\00F6nnen die Sequenznummern jederzeit ver\00E4ndern, um die Reihenfolge anzupassen. Ein Klick auf die Schaltfl\00E4che <i>Regelgruppe neu nummerieren</i> auf der Berichtseite stellt alle Regeln in der gew\00FCnschten Reihenfolge auf Sequenznummern in 10er-Sc')
||'hritten ein.',
'</p>'))
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12818820130525188)
,p_validation_name=>'Validate EDIT_SRU'
,p_validation_sequence=>10
,p_validation=>'return sct_ui_pkg.validate_edit_sru;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_always_execute=>'Y'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(134979997421430824)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(134979903731430824)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(134980807248430825)
,p_event_id=>wwv_flow_api.id(134979997421430824)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3696901691984335)
,p_name=>'Dialog AKTION_ERSTELLEN geschlossen'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(8035219889249190)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3697039470984336)
,p_event_id=>wwv_flow_api.id(3696901691984335)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(8035219889249190)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(134986271521430924)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EDIT_SRU'
,p_process_sql_clob=>'sct_ui_pkg.process_edit_sru;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(134986655328430924)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(134979447146430822)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(134987070897430924)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(134985794855430924)
,p_process_sequence=>70
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from SCT_UI_EDIT_SRU'
,p_attribute_02=>'SCT_UI_EDIT_SRU'
,p_attribute_03=>'P5_SRU_ID'
,p_attribute_04=>'SRU_ID'
,p_process_when=>'P5_SRU_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
end;
/
prompt --application/pages/page_00006
begin
wwv_flow_api.create_page(
 p_id=>6
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Regelgruppe bearbeiten'
,p_alias=>'EDIT_SGR'
,p_page_mode=>'MODAL'
,p_step_title=>'Regelgruppe bearbeiten'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'800'
,p_dialog_width=>'1200'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181111131935'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(135193603579412295)
,p_plug_name=>'Statusgruppe bearbeiten'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12817193330525172)
,p_plug_name=>'APEX-Aktionen'
,p_parent_plug_id=>wwv_flow_api.id(135193603579412295)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134915058825603530)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select row_id, saa_label, sty_display_name',
'  from sct_ui_edit_group_apex_action',
' where saa_sgr_id = :P6_SGR_ID'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12817800532525178)
,p_name=>'SAA_LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SAA_LABEL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Aktion'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12817963231525179)
,p_name=>'STY_DISPLAY_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STY_DISPLAY_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Aktionstyp'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12817984663525180)
,p_name=>'ROW_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROW_ID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:EDIT_SAA:&SESSION.::&DEBUG.:RP:P9_ROW_ID:&ROW_ID.'
,p_link_text=>'<i class="fa fa-pencil">'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(12817721356525177)
,p_internal_uid=>2812942237075424
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_max_row_count=>100000
,p_show_nulls_as=>'-'
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_no_data_found_message=>'Keine APEX-Aktionen angelegt.'
,p_show_toolbar=>false
,p_toolbar_buttons=>null
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(13464719407241367)
,p_interactive_grid_id=>wwv_flow_api.id(12817721356525177)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(13464828826241368)
,p_report_id=>wwv_flow_api.id(13464719407241367)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13465279736241374)
,p_view_id=>wwv_flow_api.id(13464828826241368)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(12817800532525178)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13465809669241379)
,p_view_id=>wwv_flow_api.id(13464828826241368)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(12817963231525179)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(13467637503251809)
,p_view_id=>wwv_flow_api.id(13464828826241368)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(12817984663525180)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12818128325525181)
,p_plug_name=>'linke Spalte'
,p_parent_plug_id=>wwv_flow_api.id(135193603579412295)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12819942868525199)
,p_plug_name=>'rechte Spalte'
,p_parent_plug_id=>wwv_flow_api.id(135193603579412295)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(135194356258412295)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134911385607603528)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13488684642398695)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(135194356258412295)
,p_button_name=>'HELP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(134935911270603552)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:HELP:&SESSION.::&DEBUG.:RP:P99_TARGET_PAGE:&APP_PAGE_ALIAS.'
,p_icon_css_classes=>'fa fa-question'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135194704547412297)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(135194356258412295)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12818315343525183)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(12817193330525172)
,p_button_name=>'CREATE_SAA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935734070603550)
,p_button_image_alt=>'Create Saa'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_redirect_url=>'f?p=&APP_ID.:EDIT_SAA:&SESSION.::&DEBUG.:RP:P9_SAA_SGR_ID:P6_SGR_ID'
,p_icon_css_classes=>'fa fa-plus'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135194227790412295)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(135194356258412295)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P6_SGR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135194146817412295)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(135194356258412295)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Speichern'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P6_SGR_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(135194025693412295)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(135194356258412295)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Anlegen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P6_SGR_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12818769541525187)
,p_name=>'P6_SGR_WITH_RECURSION'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(12819942868525199)
,p_use_cache_before_default=>'NO'
,p_item_default=>'Y'
,p_prompt=>unistr('Regel rekursiv ausf\00FChren')
,p_source=>'SGR_WITH_RECURSION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_colspan=>5
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12820078347525200)
,p_name=>'P6_SGR_ID_BAC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(12819213968525192)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(122326165516227165)
,p_name=>'P6_SGR_ACTIVE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(12819942868525199)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>'aktiv'
,p_source=>'SGR_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Flag, das anzeigt, ob die Regelgruppe aktuell verwendet wird oder nicht.'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135197120471412300)
,p_name=>'P6_SGR_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(135193603579412295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Interne ID'
,p_source=>'SGR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135197556537412317)
,p_name=>'P6_SGR_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(12818128325525181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Name der Statusgruppe'
,p_source=>'SGR_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(134935572924603550)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Name der Regelgruppe.<br>Dieser Name muss innerhalb der Anwendung eindeutig sein.'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135197944010412319)
,p_name=>'P6_SGR_DESCRIPTION'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(12818128325525181)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Beschreibung'
,p_source=>'SGR_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>200
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Kurze Beschreibung der Regelgruppe'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135198375079412319)
,p_name=>'P6_SGR_APP_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(12819942868525199)
,p_use_cache_before_default=>'NO'
,p_prompt=>'APEX-Anwendung'
,p_source=>'SGR_APP_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_APPLICATIONS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_applications',
' order by r'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- APEX-Anwendung w\00E4hlen -')
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(134935572924603550)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Referenz auf die Anwendung, in der diese Regelgruppe verwendet wird.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(135198730448412319)
,p_name=>'P6_SGR_PAGE_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(12819942868525199)
,p_use_cache_before_default=>'NO'
,p_prompt=>'APEX-Anwendungsseite'
,p_source=>'SGR_PAGE_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_APPLICATION_PAGES'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_app_pages',
' where application_id = :P6_SGR_APP_ID',
' order by d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Anwendungsseite w\00E4hlen -')
,p_lov_cascade_parent_items=>'P6_SGR_APP_ID'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(134935572924603550)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Referenz auf die Anwendungsseite, die diese Regelgruppe verwendet.<br>Auf dieser Seite muss ein SCT-Plugin mit der Angabe des Regelgruppennamens vorhanden sein, damit die Kommunikation funktioniert.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(12820129530525201)
,p_computation_sequence=>10
,p_computation_item=>'P6_SGR_ID_BAC'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'FUNCTION_BODY'
,p_computation=>'return coalesce(:P6_SGR_ID, sct_seq.nextval);'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(12820253000525202)
,p_computation_sequence=>20
,p_computation_item=>'P6_SGR_ID'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'ITEM_VALUE'
,p_computation=>'P6_SGR_ID_BAC'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12818660086525186)
,p_validation_name=>'Validate EDIT_SGR'
,p_validation_sequence=>10
,p_validation=>'return sct_ui_pkg.validate_edit_sgr;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_validation_condition=>'SAVE:CREATE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135194793439412297)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(135194704547412297)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(135195665080412299)
,p_event_id=>wwv_flow_api.id(135194793439412297)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12818970790525189)
,p_name=>'Refresh APEX_ACTIONS'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(12818315343525183)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12819007033525190)
,p_event_id=>wwv_flow_api.id(12818970790525189)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12817193330525172)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(135199936465412322)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from SCT_RULE_GROUP'
,p_attribute_02=>'SCT_RULE_GROUP'
,p_attribute_03=>'P6_SGR_ID'
,p_attribute_04=>'SGR_ID'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(135200755003412324)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EDIT_SGR'
,p_process_sql_clob=>'sct_ui_pkg.process_edit_sgr;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(135201133725412324)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(135194227790412295)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(135201491008412324)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_api.create_page(
 p_id=>7
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Hilfe - Aktionstypen'
,p_alias=>'HELP_SAT'
,p_page_mode=>'NON_MODAL'
,p_step_title=>'Hilfe - Aktionstypen'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20180903101542'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20849577874926306)
,p_plug_name=>'Hilfe - Aktionstypen'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>'sct_ui_pkg.get_action_type_help;'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
end;
/
prompt --application/pages/page_00008
begin
wwv_flow_api.create_page(
 p_id=>8
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Regelgruppe exportieren'
,p_alias=>'EXPORT_SGR'
,p_page_mode=>'MODAL'
,p_step_title=>'Regelgruppe exportieren'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>unistr('F\00FCr diese Seite ist keine Hilfe verf\00FCgbar.')
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181007140810'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(42108438759136967)
,p_plug_name=>'Regelgruppe exportieren'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(42109202260136967)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134911385607603528)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13489276005401099)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(42109202260136967)
,p_button_name=>'HELP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(134935911270603552)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:HELP:&SESSION.::&DEBUG.:RP:P99_TARGET_PAGE:&APP_PAGE_ALIAS.'
,p_icon_css_classes=>'fa fa-question'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(42108798867136967)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(42109202260136967)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(42108879907136967)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(42109202260136967)
,p_button_name=>'EXPORT'
,p_button_static_id=>'B8_EXPORT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Regelgruppe(n) exportieren'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_grid_new_grid=>false
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(42114142102155302)
,p_name=>'P8_SGR_APP_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(42108438759136967)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Anwendung'
,p_source=>'SGR_APP_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SGR_APPLICATIONS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_sgr_applications',
' order by r'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Anwendung w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'sct-observe'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Referenz auf die Anwendung, aus der die Regelgruppe exportiert werden soll. Enth&auml;lt den Eintrag <em>Alle Anwendungen</em>, um alle Regelgruppen aller Anwendungen zu exportieren.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(42114390284162888)
,p_name=>'P8_SGR_PAGE_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(42108438759136967)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Anwendungsseite'
,p_source=>'SGR_PAGE_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select page_name || '' ('' || page_id || '')'' d, page_id r',
'  from apex_application_pages app',
'  join sct_rule_group sgr',
'    on app.application_id = sgr.sgr_app_id',
'   and app.page_id = sgr.sgr_page_id',
' where sgr.sgr_app_id = :P8_SGR_APP_ID',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Seite w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'sct-observe'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Referenz auf die Anwendungsseite, die die zu exportierende Regelgruppe enth&auml;lt.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(42114684720173669)
,p_name=>'P8_SGR_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(42108438759136967)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Regelgruppe'
,p_source=>'SGR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sgr_name d, sgr_id r',
'  from sct_rule_group',
' where sgr_app_id = :P8_SGR_APP_ID',
'   and sgr_page_id = :P8_SGR_PAGE_ID'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Regelgruppe w\00E4hlen')
,p_cHeight=>1
,p_tag_css_classes=>'sct-observe'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Regelgruppe, die exportiert werden soll'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(42116375347209102)
,p_name=>'P8_EXPORT_TYPE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(42108438759136967)
,p_prompt=>'Typ des Epxorts'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_EXPORT_TYPE'
,p_lov=>'.'||wwv_flow_api.id(42115289147202742)||'.'
,p_cHeight=>1
,p_tag_css_classes=>'sct-observe'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Art des Exports:<dl><dt>Alle Regelgruppen einer Anwendung</dt><dd>Exportiert alle Regelgruppen einer oder aller Anwendungen</dd><dt>Eine Regelgruppe w&auml;hlen</dt><dd>Exportiert eine einzelne Regelgruppe</dd></dl>'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(42109898823136967)
,p_name=>'Dialog abbrechen'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(42108798867136967)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(42110426976136967)
,p_event_id=>wwv_flow_api.id(42109898823136967)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(42397086146093989)
,p_name=>'SCT_ADMIN_EXPORT_RULE'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(42397504640093991)
,p_event_id=>wwv_flow_api.id(42397086146093989)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.CONDES.PLUGIN.SCT'
,p_attribute_01=>'SCT_ADMIN_EXPORT_RULE'
,p_attribute_02=>'B8_EXPORT'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(42112442424136972)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(20884016245429952)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row of SCT_RULE_GROUP'
,p_attribute_02=>'SCT_RULE_GROUP'
,p_attribute_03=>'P1_SGR_ID'
,p_attribute_04=>'SGR_ID'
,p_process_when=>'P1_SGR_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(42393510302546989)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'process export'
,p_process_sql_clob=>'sct_ui_pkg.export_rule_group;'
,p_process_error_message=>'Fehler beim Export der Regelgruppe:<br>#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00009
begin
wwv_flow_api.create_page(
 p_id=>9
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'APEX-Aktion editieren'
,p_alias=>'EDIT_SAA'
,p_page_mode=>'MODAL'
,p_step_title=>'APEX-Aktion editieren'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181111132712'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(13435411991126542)
,p_plug_name=>'EDIT_SAA'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(13436141660126545)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134911385607603528)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13489536340402301)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(13436141660126545)
,p_button_name=>'HELP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(134935911270603552)
,p_button_image_alt=>'Hilfe'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:HELP:&SESSION.::&DEBUG.:RP:P99_TARGET_PAGE:&APP_PAGE_ALIAS.'
,p_icon_css_classes=>'fa fa-question'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13436541105126545)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(13436141660126545)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13435993487126545)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(13436141660126545)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P9_ROW_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13435960061126545)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(13436141660126545)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\00C4nderungen anwenden')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P9_ROW_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(13435796908126545)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(13436141660126545)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P9_ROW_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_grid=>false
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13438952616126559)
,p_name=>'P9_ROW_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Row Id'
,p_source=>'ROW_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13439300519126570)
,p_name=>'P9_SAA_SGR_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_source=>'SAA_SGR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13439743483126573)
,p_name=>'P9_SAA_STY_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'APEX Actionstyp'
,p_source=>'SAA_STY_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_APEX_ACTION_TYPE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_apex_action_type',
' order by d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Aktionstyp w\00E4hlen -')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13440178296126573)
,p_name=>'P9_SAA_NAME'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Eindeutiger Name'
,p_source=>'SAA_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(134935572924603550)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13440576701126573)
,p_name=>'P9_SAA_LABEL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Bezeichnung'
,p_source=>'SAA_LABEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13440946740126573)
,p_name=>'P9_SAA_CONTEXT_LABEL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Kontext-Bezeichnung'
,p_source=>'SAA_CONTEXT_LABEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>800
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13441366045126573)
,p_name=>'P9_SAA_ICON'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Icon'
,p_source=>'SAA_ICON'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13441712673126574)
,p_name=>'P9_SAA_ICON_TYPE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_item_default=>'fa'
,p_prompt=>'Iconklasse'
,p_source=>'SAA_ICON_TYPE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13442101077126574)
,p_name=>'P9_SAA_TITLE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'title-Attribut'
,p_source=>'SAA_TITLE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>800
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13442549378126574)
,p_name=>'P9_SAA_SHORTCUT'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Tastaturk\00FCrzel')
,p_source=>'SAA_SHORTCUT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13442949486126574)
,p_name=>'P9_SAA_INITIALLY_DISABLED'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Initial deaktiv'
,p_source=>'SAA_INITIALLY_DISABLED'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13443295642126574)
,p_name=>'P9_SAA_INITIALLY_HIDDEN'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Initial ausgeblendet'
,p_source=>'SAA_INITIALLY_HIDDEN'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APPLICATION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13443747925126574)
,p_name=>'P9_SAA_HREF'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Link'
,p_source=>'SAA_HREF'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>800
,p_tag_css_classes=>'saa-sct-action'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13444133303126574)
,p_name=>'P9_SAA_HREF_NOOP'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Link NOOP'
,p_source=>'SAA_HREF_NOOP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>800
,p_tag_css_classes=>'saa-sct-action'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13444509700126576)
,p_name=>'P9_SAA_ACTION'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Befehl'
,p_source=>'SAA_ACTION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>800
,p_tag_css_classes=>'saa-sct-action'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13444914231126576)
,p_name=>'P9_SAA_ACTION_NOOP'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Befehl NOOP'
,p_source=>'SAA_ACTION_NOOP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>800
,p_tag_css_classes=>'saa-sct-action'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13445295447126576)
,p_name=>'P9_SAA_ON_LABEL'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Aktiv-Label'
,p_source=>'SAA_ON_LABEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_tag_css_classes=>'sct-saa-toggle'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13445679400126576)
,p_name=>'P9_SAA_OFF_LABEL'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Deaktiv-Label'
,p_source=>'SAA_OFF_LABEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_tag_css_classes=>'sct-saa-toggle'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13446153827126576)
,p_name=>'P9_SAA_GET'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Get-Methode'
,p_source=>'SAA_GET'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_tag_css_classes=>'sct-saa-radio sct-saa-toggle'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13446572332126578)
,p_name=>'P9_SAA_SET'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Set-Methode'
,p_source=>'SAA_SET'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_tag_css_classes=>'sct-saa-radio sct-saa-toggle'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13446882139126578)
,p_name=>'P9_SAA_CHOICES'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Werteliste'
,p_source=>'SAA_CHOICES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_tag_css_classes=>'sct-saa-radio'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13447292457126578)
,p_name=>'P9_SAA_LABEL_CLASSES'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Label CSS'
,p_source=>'SAA_LABEL_CLASSES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_tag_css_classes=>'sct-saa-radio'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13447722294126578)
,p_name=>'P9_SAA_LABEL_START_CLASSES'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Start Label CSS'
,p_source=>'SAA_LABEL_START_CLASSES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_tag_css_classes=>'sct-saa-radio'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13448084887126578)
,p_name=>'P9_SAA_LABEL_END_CLASSES'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Ende Label CSS'
,p_source=>'SAA_LABEL_END_CLASSES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_tag_css_classes=>'sct-saa-radio'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13448509034126578)
,p_name=>'P9_SAA_ITEM_WRAP_CLASS'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(13435411991126542)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Element CSS'
,p_source=>'SAA_ITEM_WRAP_CLASS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_tag_css_classes=>'sct-saa-radio'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12819793138525198)
,p_validation_name=>'Validate EDIT_SAA'
,p_validation_sequence=>10
,p_validation=>'return sct_ui_pkg.validate_edit_saa;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13436627343126545)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(13436541105126545)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13437409544126546)
,p_event_id=>wwv_flow_api.id(13436627343126545)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12818474949525184)
,p_name=>'SCT Regel'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12818523313525185)
,p_event_id=>wwv_flow_api.id(12818474949525184)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.CONDES.PLUGIN.SCT'
,p_attribute_01=>'EDIT_SAA'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(13449291993126581)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from SCT_UI_EDIT_SAA'
,p_attribute_02=>'SCT_UI_EDIT_SAA'
,p_attribute_03=>'P9_ROW_ID'
,p_attribute_04=>'ROW_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(13449726354126581)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EDIT_SAA'
,p_process_sql_clob=>'sct_ui_pkg.process_edit_saa;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Aktion wurde verarbeitet.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(13450133983126581)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(13435993487126545)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(13450567189126581)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Startseite'
,p_alias=>'HOME'
,p_step_title=>'Startseite'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20180903104919'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12819280373525193)
,p_plug_name=>'Anwendungsbereiche'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--displaySubtitle:t-Cards--featured force-fa-lg:t-Cards--displayIcons:t-Cards--3cols:t-Cards--animColorFill'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(14533494841582546)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(134928734507603542)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14529653986552563)
,p_plug_name=>'Navigationspfad'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134918352376603531)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(134942349375603603)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(134936284759603553)
);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_api.create_page(
 p_id=>11
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Aktion administrieren'
,p_alias=>'EDIT_SRA'
,p_page_mode=>'MODAL'
,p_step_title=>'Regelaktion administrieren'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181119142926'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4877440170001328)
,p_plug_name=>'EDIT_SRA'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4878161066001329)
,p_plug_name=>unistr('Schaltfl\00E4chen')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134911385607603528)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4878595544001329)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(4878161066001329)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4878074109001329)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(4878161066001329)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_image_alt=>unistr('L\00F6schen')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P11_SRA_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4877947039001329)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(4878161066001329)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('\00C4nderungen anwenden')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P11_SRA_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4877804625001329)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(4878161066001329)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Erstellen'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P11_SRA_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4880993675001351)
,p_name=>'P11_SRA_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_source=>'SRA_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4881293833001360)
,p_name=>'P11_SRA_SGR_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_source=>'SRA_SGR_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4881647756001364)
,p_name=>'P11_SRA_SRU_ID'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Sra Sru Id'
,p_source=>'SRA_SRU_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(134935572924603550)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4882076129001364)
,p_name=>'P11_SRA_SPI_ID'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Seitenelement'
,p_source=>'SRA_SPI_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_APPLICATION_ITEMS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_sgr_page_items',
' where sgr_id = :P5_SRU_SGR_ID',
' order by d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Element w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4882448462001364)
,p_name=>'P11_SRA_SAT_ID'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Aktionstyp'
,p_source=>'SRA_SAT_ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ACTION_TYPE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_list_action_type',
' order by d'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>unistr('- Aktion w\00E4hlen')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4882816140001365)
,p_name=>'P11_SRA_ON_ERROR'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_item_default=>'sct_ui_pkg.get_false;'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Fehlerhandler'
,p_source=>'SRA_ON_ERROR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'LOV_YES_NO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_yes_no',
' order by d'))
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4883221737001365)
,p_name=>'P11_SRA_ATTRIBUTE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Attribut 1'
,p_source=>'SRA_ATTRIBUTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4883622736001365)
,p_name=>'P11_SRA_ATTRIBUTE_2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Attribut 2'
,p_source=>'SRA_ATTRIBUTE_2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>255
,p_cHeight=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4884077758001365)
,p_name=>'P11_SRA_COMMENT'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Entwicklerkommentar'
,p_source=>'SRA_COMMENT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>800
,p_cHeight=>2
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4884482919001367)
,p_name=>'P11_SRA_RAISE_RECURSIVE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_item_default=>'sct_ui_pkg.get_true;'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Rekursion erlauben'
,p_source=>'SRA_RAISE_RECURSIVE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'LOV_YES_NO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_yes_no',
' order by d'))
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4884822480001367)
,p_name=>'P11_SRA_SORT_SEQ'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_item_default=>'sct_ui_pkg.get_sra_sort_seq(:P11_SRA_SGR_ID, :P11_SRA_SRU_ID);'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Sequenz'
,p_format_mask=>'999990'
,p_source=>'SRA_SORT_SEQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>3
,p_cMaxlength=>4
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4885248842001367)
,p_name=>'P11_SRA_ACTIVE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(4877440170001328)
,p_use_cache_before_default=>'NO'
,p_item_default=>'sct_ui_pkg.get_true;'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Aktiv'
,p_source=>'SRA_ACTIVE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'LOV_YES_NO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select d, r',
'  from sct_ui_lov_yes_no',
' order by d'))
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(4924624117999716)
,p_validation_name=>'Validate EDIT_SRA'
,p_validation_sequence=>10
,p_validation=>'return sct_ui_pkg.validate_edit_sra;'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'FOO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4878651177001329)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(4878595544001329)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4879431874001331)
,p_event_id=>wwv_flow_api.id(4878651177001329)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(4890075064001370)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from SCT_UI_EDIT_SRA'
,p_attribute_02=>'SCT_UI_EDIT_SRA'
,p_attribute_03=>'P11_SRA_ID'
,p_attribute_04=>'ROW_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(4890419231001370)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process EDIT_SRA'
,p_process_sql_clob=>'sct_ui_pkg.process_edit_sra;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Aktion wurde verarbeitet.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(4890862637001370)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(4878074109001329)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(4891212006001371)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
end;
/
prompt --application/pages/page_00099
begin
wwv_flow_api.create_page(
 p_id=>99
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Hilfe'
,p_alias=>'HELP'
,p_page_mode=>'NON_MODAL'
,p_step_title=>'Hilfe'
,p_step_sub_title=>'Hilfe'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// Generic settings',
'$(''.t-Dialog-body'').attr(''style'', ''padding:0px;'');',
'',
'// Flag out unwanted WebSheet regions',
'var opts = {',
'  "SideColumn":false,',
'  "PageHeader":false',
'};',
'',
'',
'$(''iframe'').on(''load'',',
'  function(){',
'    var defaults = {',
'      "SideColumn":true,',
'      "SideColumnSelector":".ebaSideCol",',
'      "PageHeader":true,',
'      "PageHeaderSelector":".ebaFrameHeader"',
'    };',
'    var settings = $.extend({}, defaults, opts);',
'    ',
'    Object.keys(settings).forEach(function(key){',
'      showItem = settings[key];',
'      selector = settings[key + ''Selector''];',
'      if (!showItem){',
'        $(''iframe'')[0].contentWindow.$(selector).hide();',
'      };',
'    });',
'  }',
');'))
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'800'
,p_dialog_width=>'800'
,p_last_updated_by=>'BUCH_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20181104151849'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(22134991755211247)
,p_plug_name=>'Hilfe'
,p_region_name=>'helpFrame'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(134906982190603525)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_URL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'ws?p=&APP_HELP_WS.:&P99_TARGET_PAGE.'
,p_attribute_02=>'IFRAME'
,p_attribute_03=>'style="height: calc(100vh - 3px); width:100%"'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13475403061288918)
,p_name=>'P99_TARGET_PAGE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(22134991755211247)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_api.create_page(
 p_id=>101
,p_user_interface_id=>wwv_flow_api.id(134941020914603572)
,p_name=>'Login Page'
,p_alias=>'LOGIN_DESKTOP'
,p_step_title=>'SCT-Test - Log In'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(134900816039603516)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
,p_last_updated_by=>'SIEBEN'
,p_last_upd_yyyymmddhh24miss=>'20160913132653'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(134941547016603599)
,p_plug_name=>'Log In'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(134915058825603530)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(134941865855603602)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(134941547016603599)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(134935871722603552)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Log In'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_alignment=>'LEFT'
,p_grid_new_grid=>false
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(134941615404603602)
,p_name=>'P101_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(134941547016603599)
,p_prompt=>'Username'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(134941749578603602)
,p_name=>'P101_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(134941547016603599)
,p_prompt=>'Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(134935294002603549)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(134942058097603603)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P101_USERNAME) );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(134941976579603603)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P101_USERNAME,',
'    p_password => :P101_PASSWORD );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(134942229621603603)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(134942146237603603)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>':P101_USERNAME := apex_authentication.get_login_username_cookie;'
);
end;
/
prompt --application/deployment/definition
begin
null;
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
