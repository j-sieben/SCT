create or replace editionable view sct_ui_edit_saa
as 
select seq_id,
       n001 saa_id,
       n002 saa_sgr_id,
       c001 saa_sty_id,
       c002 saa_name,
       c003 saa_label,
       c004 saa_context_label,
       c005 saa_icon,
       c006 saa_icon_type,
       c007 saa_title,
       c008 saa_shortcut,
       c009 saa_initially_disabled,
       c010 saa_initially_hidden,
       c011 saa_href,
       c012 saa_action,
       c013 saa_on_label,
       c014 saa_off_label,
       c015 saa_get,
       c016 saa_set,
       c017 saa_choices,
       c018 saa_label_classes,
       c019 saa_label_start_classes,
       c020 saa_label_end_classes,
       c021 saa_item_wrap_class,
       c022 saa_sai_list
  from apex_collections
 where collection_name = 'SCT_UI_EDIT_SAA';

comment on table sct_ui_edit_saa is 'Collection View auf SCT_APEX_ACTION, nicht refaktorisieren, um zeitgleiche Erstellung von Regelgruppe und Seitenaktionen zu ermoeglichen.';