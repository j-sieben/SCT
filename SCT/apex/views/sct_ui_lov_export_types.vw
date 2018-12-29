create or replace view sct_ui_lov_export_types as
select 'Alle Regelgruppen' d, 'ALL_SGR' r, 1 sort_seq from dual union all
select 'Alle Regelgruppen einer Anwendung' d, 'APP' r, 2 sort_seq from dual union all
select 'Eine Regelgruppe' d, 'SGR' r, 3 sort_seq from dual;


