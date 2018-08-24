
merge into sct_apex_action_type t
using (select 'ACTION' sty_id, 'Aktion' sty_display_name, 'JavaScript oder PL/SQL-Befehl, alternativ Verweis' sty_description from dual union all
       select 'TOGGLE', 'Schalter', 'Wahlschalter (JA|NEIN}' from dual union all
       select 'RADIO_GROUP', 'Aktion', 'Auswahlliste, Optionsfelder' from dual) s
   on (t.sty_id = s.sty_id)
 when matched then update set
      sty_display_name = s.sty_display_name,
      sty_description = s.sty_description
 when not matched then insert(sty_id, sty_display_name, sty_description)
      values (s.sty_id, s.sty_display_name, s.sty_description);
      
commit;