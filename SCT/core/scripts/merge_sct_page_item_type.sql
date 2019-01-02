
delete from sct_page_item_type;

merge into sct_page_item_type s
using (select 'ITEM' sit_id,
              'Element' sit_name,
              sct_util.get_true sit_has_value,
              'change' sit_event,
              q'~plugin_sct.get_char('#ITEM#') #ITEM#~' sit_col_template,
              q'~itm.#ITEM#~' sit_init_template,
              sct_util.get_false sit_include_in_view
         from dual
        union all 
       select 'NUMBER_ITEM', 'Element (Zahl)', sct_util.get_true, 'change', q'~plugin_sct.get_number('#ITEM#',replace( '#CONVERSION#', 'G')) #ITEM#~', q'~to_char(itm.#ITEM#, '#CONVERSION#')~', sct_util.get_false from dual union all
       select 'DATE_ITEM', 'Element (Datum)', sct_util.get_true, 'change', q'~plugin_sct.get_date('#ITEM#', '#CONVERSION#') #ITEM#~', q'~to_char(to_date(itm.#ITEM#), '#CONVERSION#')~', sct_util.get_false from dual union all
       select 'APP_ITEM', 'Anwendungselement', sct_util.get_true, 'change', q'~v('#ITEM#') #ITEM#~', 'itm.#ITEM#', sct_util.get_false from dual union all
       select 'BUTTON', 'Schaltfläche', sct_util.get_false, 'click', q'~case plugin_sct.get_firing_item when '#ITEM#' then 1 else 0 end #ITEM#~', null, sct_util.get_false from dual union all
       select 'REGION', 'Region', sct_util.get_false, null, q'~null #ITEM#~', null, sct_util.get_false from dual union all
       select 'DOCUMENT', 'Dokument', sct_util.get_false, null, q'~null #ITEM#~', null, sct_util.get_false from dual union all
       select 'DIALOG_CLOSED', 'Dialog geschlossen', sct_util.get_false, 'apexafterclosedialog', q'~case plugin_sct.get_event when '#SIT_EVENT#' then plugin_sct.get_firing_item end dialog_closed~', null, sct_util.get_true from dual union all
       select 'AFTER_REFRESH', 'Nach Refresh', sct_util.get_false, 'apexafterrefresh', q'~case plugin_sct.get_event when '#SIT_EVENT#' then plugin_sct.get_firing_item end after_refresh~', null, sct_util.get_true from dual union all
       select 'ENTER_KEY', 'Enter-Taste', sct_util.get_false, 'enter', q'~case plugin_sct.get_event when '#SIT_EVENT#' then plugin_sct.get_firing_item end enter_key~', null, sct_util.get_true from dual union all
       select 'DOUBLE_CLICK', 'Doppelklick', sct_util.get_false, 'dblclick', q'~case plugin_sct.get_event when '#SIT_EVENT#' then plugin_sct.get_firing_item end double_click~', null, sct_util.get_true from dual union all
       select 'FIRING_ITEM', 'Firing Item', sct_util.get_false, null, q'~plugin_sct.get_firing_item firing_item~', null, sct_util.get_true from dual union all
       select 'INITIALIZING', 'Initialize Flag', sct_util.get_false, null, q'~case plugin_sct.get_firing_item when 'DOCUMENT' then 1 else 0 end initializing~', null, sct_util.get_true from dual union all
       select 'ALL', 'Alle', sct_util.get_false, null, null, null, sct_util.get_false from dual) v
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
