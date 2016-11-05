create or replace force view sct_ui_action_type as
select case
         when sat_is_editable = 1 then
           '<a href="' || apex_util.prepare_url( p_url => 'f?p=' || v('APP_ALIAS') || ':EDIT_ACTION_TYPE:' || v('SESSION') || '::NO::P3_ROWID:' || rowid, p_checksum_type => 'SESSION') || '"><i class="fa fa-pencil"></i></a>'/*<img src="/i/menu/pencil2_16x16.gif"></a>'*/
         else ''
       end edit_link,
       rowid row_id,
       sat_id,
       sat_name,
       sat_is_editable,
       replace(sat_pl_sql, chr(13), '<br>') sat_pl_sql,
       replace(sat_js, chr(13), '<br>') sat_js,
       sat_description
  from sct_action_type;
