create or replace editionable view sct_ui_lov_yes_no 
as 
select 'Ja' d, sct_util.c_true r from dual union all
select 'Nein', sct_util.c_false r from dual;
