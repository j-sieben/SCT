begin

  sct_admin.merge_action_item_focus(
    p_sif_id => 'ALL',
    p_sif_name => 'Alle Seitenelemente',
    p_sif_description => q'{Alle Seitenelemente der Anwendung}',
    p_sif_active => 'Y');

  sct_admin.merge_action_item_focus(
    p_sif_id => 'DOCUMENT',
    p_sif_name => 'Keine Seitenelemente',
    p_sif_description => q'{Eine Zuordnung zu einem Seitenelement erfolgt nicht}',
    p_sif_active => 'Y');

  sct_admin.merge_action_item_focus(
    p_sif_id => 'ITEM_OR_JQUERY',
    p_sif_name => 'Seitenelement oder jQuery-Selektor',
    p_sif_description => q'{Alle Seitenelemente oder ein jQuery-Selektor}',
    p_sif_active => 'Y');

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE',
    p_sif_name => 'Alle Seitenelemente der aktuellen Seite',
    p_sif_description => q'{Alle Seitenelemente der aktuellen Anwendungsseite}',
    p_sif_active => 'Y');

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_BUTTON',
    p_sif_name => 'Schaltfläcehn der aktuellen Seite',
    p_sif_description => q'{Alle Schaltflächen der aktuellen Anwendungsseite}',
    p_sif_active => 'Y');

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_ITEM',
    p_sif_name => 'Seitenelement',
    p_sif_description => q'{<p>Seitenelement oder Region der aktuellen Seite</p>}',
    p_sif_active => 'Y');

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_ITEM_OR_DOCUMENT',
    p_sif_name => 'Eingabefeld oder Dokument',
    p_sif_description => q'{Alle Eingabefelder oder keine spezifische Angabe}',
    p_sif_active => 'Y');

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_ITEM_OR_JQUERY',
    p_sif_name => 'Eingabefeld oder jQuery-Selektor',
    p_sif_description => q'{Alle Eingabefelder oder ein jQuery-Selektor}',
    p_sif_active => 'Y');

  sct_admin.merge_action_item_focus(
    p_sif_id => 'PAGE_REGION',
    p_sif_name => 'Regionen der aktuellen Seite',
    p_sif_description => q'{Alle Regionen der aktuellen Anwendungsseite}',
    p_sif_active => 'Y');

  sct_admin.merge_action_item_focus(
    p_sif_id => 'REFRESHABLE',
    p_sif_name => 'Seitenelemente, die aktualisiert werden können',
    p_sif_description => q'{Alle Seitenelemente, die aktualisiert werden können}',
    p_sif_active => 'Y');

  commit;
end;
/