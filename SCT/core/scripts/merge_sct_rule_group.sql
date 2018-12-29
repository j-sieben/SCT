
merge into sct_rule_group t
using (select 0	sgr_id,
              'SCT_GLOBAL' sgr_name,
              'Globale Regeln, werden immer angewendet' sgr_description
         from dual) v
   on (t.sgr_id = v.sgr_id)
 when not matched then insert(sgr_id, sgr_name, sgr_description)
      values (v.sgr_id, v.sgr_name, v.sgr_description);
      
commit;