create or replace view sct_ui_lov_yes_no as
select 'Ja' d, utl_apex.get_true r from dual union all
select 'Nein', utl_apex.get_false r from dual;
