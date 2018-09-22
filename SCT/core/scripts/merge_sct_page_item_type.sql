
delete from sct_page_item_type;

merge into sct_page_item_type s
using (select 'ITEM' sit_id,
              'Element' sit_name,
              1 sit_has_value,
              'change' sit_event,
              q'~plugin_sct.get_char('#ITEM#') #ITEM#~' sit_col_template,
              q'~itm.#ITEM#~' sit_init_template
         from dual
        union all 
       select 'NUMBER_ITEM', 'Element (Zahl)', 1, 'change', q'~plugin_sct.get_number('#ITEM#',replace( '#CONVERSION#', 'G')) #ITEM#~', q'~to_char(itm.#ITEM#, '#CONVERSION#')~' from dual union all
       select 'DATE_ITEM', 'Element (Datum)', 1, 'change', q'~plugin_sct.get_date('#ITEM#', '#CONVERSION#') #ITEM#~', q'~to_char(to_date(itm.#ITEM#), '#CONVERSION#')~' from dual union all
       select 'APP_ITEM', 'Anwendungselement', 1, 'change', q'~v('#ITEM#') #ITEM#~', 'itm.#ITEM#' from dual union all
       select 'BUTTON', 'Schaltfläche', 0, 'click', q'~case bl_sct.get_firing_item when '#ITEM#' then 1 else 0 end #ITEM#~', null from dual union all
       select 'REGION', 'Region', 0, null, q'~null #ITEM#~', null from dual union all
       select 'DOCUMENT', 'Dokument', 0, null, q'~null #ITEM#~', null from dual union all
       select 'APEX_ACTION', 'APEX-Aktion', 0, null, q'~null #ITEM#~', null from dual union all
       select 'ALL', 'Alle', 0, null, null, null from dual) v
   on (s.sit_id = v.sit_id)
 when matched then update set
      sit_name = v.sit_name,
      sit_has_value = v.sit_has_value,
      sit_event = v.sit_event,
      sit_col_template = v.sit_col_template,
      sit_init_template = v.sit_init_template
 when not matched then insert(sit_id, sit_name, sit_has_value, sit_event, sit_col_template, sit_init_template)
      values (v.sit_id, v.sit_name, v.sit_has_value, v.sit_event, v.sit_col_template, v.sit_init_template);
  
        
commit;
