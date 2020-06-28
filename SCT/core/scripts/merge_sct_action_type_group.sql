set define off
set sqlblanklines on

begin

  sct_admin.merge_action_type_group(
    p_stg_id => 'BUTTON',
    p_stg_name => 'Schaltlfäche',
    p_stg_description => q'{Aktionen für Schaltflächen}',
    p_stg_active => sct_util.C_TRUE);

  sct_admin.merge_action_type_group(
    p_stg_id => 'ITEM',
    p_stg_name => 'Seitenelemente',
    p_stg_description => q'{Aktionen für Eingabefelder}',
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

  sct_admin.merge_action_type_group(
    p_stg_id => 'IG',
    p_stg_name => 'Interactive Grid',
    p_stg_description => q'{Aktionen für das Interaktive Grid}',
    p_stg_active => sct_util.C_TRUE);

  commit;
end;
/

set define on
set sqlblanklines off