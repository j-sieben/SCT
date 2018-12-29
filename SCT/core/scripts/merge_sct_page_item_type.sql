
delete from sct_page_item_type;

merge into sct_page_item_type s
using (select 'ITEM' sit_id,
              'Element' sit_name,
              'Y' sit_has_value,
              'change' sit_event,
              q'~plugin_sct.get_char('#ITEM#') #ITEM#~' sit_col_template,
              q'~itm.#ITEM#~' sit_init_template,
              'N' sit_include_in_view
         from dual
        union all 
       select 'NUMBER_ITEM', 'Element (Zahl)', 'Y', 'change', q'~plugin_sct.get_number('#ITEM#',replace( '#CONVERSION#', 'G')) #ITEM#~', q'~to_char(itm.#ITEM#, '#CONVERSION#')~', 'N' from dual union all
       select 'DATE_ITEM', 'Element (Datum)', 'Y', 'change', q'~plugin_sct.get_date('#ITEM#', '#CONVERSION#') #ITEM#~', q'~to_char(to_date(itm.#ITEM#), '#CONVERSION#')~', 'N' from dual union all
       select 'APP_ITEM', 'Anwendungselement', 'Y', 'change', q'~v('#ITEM#') #ITEM#~', 'itm.#ITEM#', 'N' from dual union all
       select 'BUTTON', 'Schaltfläche', 'N', 'click', q'~case plugin_sct.get_firing_item when '#ITEM#' then 1 else 0 end #ITEM#~', null, 'N' from dual union all
       select 'REGION', 'Region', 'N', null, q'~null #ITEM#~', null, 'N' from dual union all
       select 'DOCUMENT', 'Dokument', 'N', null, q'~null #ITEM#~', null, 'N' from dual union all
       select 'DIALOG_CLOSED', 'Dialog geschlossen', 'N', 'apexafterclosedialog', q'~case plugin_sct.get_event when '#SIT_EVENT#' then plugin_sct.get_firing_item end dialog_closed~', null, 'Y' from dual union all
       select 'AFTER_REFRESH', 'Nach Refresh', 'N', 'apexafterrefresh', q'~case plugin_sct.get_event when '#SIT_EVENT#' then plugin_sct.get_firing_item end after_refresh~', null, 'Y' from dual union all
       select 'ENTER_KEY', 'Enter-Taste', 'N', 'enter', q'~case plugin_sct.get_event when '#SIT_EVENT#' then plugin_sct.get_firing_item end enter_key~', null, 'Y' from dual union all
       select 'DOUBLE_CLICK', 'Doppelklick', 'N', 'dblclick', q'~case plugin_sct.get_event when '#SIT_EVENT#' then plugin_sct.get_firing_item end double_click~', null, 'Y' from dual union all
       select 'FIRING_ITEM', 'Firing Item', 'N', null, q'~plugin_sct.get_firing_item firing_item~', null, 'Y' from dual union all
       select 'INITIALIZING', 'Initialize Flag', 'N', null, q'~case plugin_sct.get_firing_item when 'DOCUMENT' then 1 else 0 end initializing~', null, 'Y' from dual union all
       select 'ALL', 'Alle', 'N', null, null, null, 'N' from dual) v
   on (s.sit_id = v.sit_id)
 when matched then update set
      sit_name = v.sit_name,
      sit_has_value = v.sit_has_value,
      sit_event = v.sit_event,
      sit_col_template = v.sit_col_template,
      sit_init_template = v.sit_init_template,
      sit_include_in_view = v.sit_include_in_view
 when not matched then insert(sit_id, sit_name, sit_has_value, sit_event, sit_col_template, sit_init_template, sit_include_in_view)
      values (v.sit_id, v.sit_name, v.sit_has_value, v.sit_event, v.sit_col_template, v.sit_init_template, v.sit_include_in_view);
        
commit;
