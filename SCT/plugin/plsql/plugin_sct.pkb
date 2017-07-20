create or replace package body bl_sct 
as

  /* Weitere Konstanten siehe SCT_CONST */
  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;
  
  
  type rule_rec is record(
    sru_id sct_rule.sru_id%type,
    sru_sort_seq sct_rule.sru_sort_seq%type,
    sru_name sct_rule.sru_name%type,
    sru_firing_items sct_rule.sru_firing_items%type,
    sru_fire_on_page_load sct_rule.sru_fire_on_page_load%type,
    item sct_page_item.spi_id%type,
    pl_sql sct_action_type.sat_pl_sql%type,
    js sct_action_type.sat_js%type,
    sra_attribute sct_rule_action.sra_attribute%type,
    sra_attribute_2 sct_rule_action.sra_attribute_2%type,
    sra_on_error sct_rule_action.sra_on_error%type,
    is_first_row number
  );
  
  
  type action_rec is record(
    comment varchar2(32767),
    js_code varchar2(32767),
    plsql_code varchar2(32767));


  /* Globale Variablen */
  g_firing_item varchar2(30 byte);
  g_with_comments boolean;
  g_has_errors boolean;
  g_action_rec action_rec;
  

  /* Hilfsfunktionen */
  /* Hole Meldungstext von PIT zur Integration als Kommentar in die Ausgabe
   * %param p_msg Message-ID
   * %param p_msg_args Optionale Message-Parameter
   * %return Meldungstext, angereichert um Parameter, in der entsprechenden Sprache
   * %usage Wird verwendet, um im Debug-Modus mehr Informationen ueber SCT auszugeben
   */
  function get_comment(
    p_msg pit_message.pms_name%type,
    p_msg_args msg_args default null)
    return varchar2
  as
  begin
    if g_with_comments then
      return pit.get_message_text(p_msg, p_msg_args);
    else
      return null;
    end if;
  end get_comment;
  
  
  function check_recursion(
    p_rule in rule_rec)
    return varchar2
  as
  begin
    case when p_rule.item = sct_const.c_no_firing_item 
          and p_rule.sru_fire_on_page_load = sct_const.c_true
      then return sct_const.c_false;
      else return sct_const.c_true;
    end case;
  end check_recursion;
  
  
  procedure prepare_js_code(
    p_code in out nocopy varchar2,
    p_rule in rule_rec,
    p_origin in varchar2 default null)
  as
    c_delimiter constant varchar2(10) := sct_const.c_cr || '  ';
  begin
    -- Nicht in BULK_REPLACE integrieren wg. Limit 4000 Byte
    p_code := p_code || replace(sct_const.c_js_template, '#CODE#', c_delimiter || replace(p_rule.js, sct_const.c_cr, c_delimiter));
    utl_text.bulk_replace(p_code, char_table(
      '#JS_FILE#', sct_const.c_js_namespace,
      '#ITEM_VALUE#', sct_const.c_js_item_value_template,
      '#ITEM#', p_rule.item,
      '#SELECTOR#', case p_rule.item when sct_const.c_no_firing_item then p_rule.sra_attribute_2 else p_rule.item end,
      '#ATTRIBUTE#', p_rule.sra_attribute,
      '#ATTRIBUTE_2#', p_rule.sra_attribute_2));
  end prepare_js_code;
  

  function get_firing_items(
    p_firing_item in varchar2)
    return varchar2
  as
    l_firing_items varchar2(32767);
  begin
    pit.enter_mandatory('get_firing_items', c_pkg);
    select listagg(coalesce(spi_id, p_firing_item), sct_const.c_delimiter) within group (order by spi_id)
      into l_firing_items
      from (select distinct spi_id
              from sct_rule sru
              join sct_page_item spi
                on instr(sct_const.c_delimiter || sru.sru_firing_items || sct_const.c_delimiter, sct_const.c_delimiter || spi.spi_id || sct_const.c_delimiter) > 0
             where instr(sct_const.c_delimiter || sru.sru_firing_items || sct_const.c_delimiter, sct_const.c_delimiter || p_firing_item || sct_const.c_delimiter) > 0);
    pit.leave_mandatory;
    return l_firing_items;
  exception
    when no_data_found then
      pit.leave_mandatory;
      return p_firing_item;
  end get_firing_items;
  
  
  procedure initialize
  as
  begin
    null;
  end;
  

  /* INTERFACE */
  function get_firing_item
    return varchar2
  as
  begin
    return g_firing_item;
  end get_firing_item;
  
  
  function get_firing_items(
    p_spi_id in sct_page_item.spi_id%type,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type)
    return char_table
  as
    l_item_list char_table;
  begin
    case 
    when p_spi_id = sct_const.c_no_firing_item and trim(p_attribute_2) like '.%' then
      -- Attribut enthaelt CSS-Klassenausdruck, Seitenelemente mit dieser Klasse suchen
        with params as(
             select v('APP_ID') application_id,
                    v('APP_PAGE_ID') page_id
               from dual)
      select /*+ NO_MERGE (params) */
             cast(collect(item_name) as char_table)
        into l_item_list
        from apex_application_page_items
     natural join params
       where html_form_element_css_classes is not null
         and regexp_instr(p_attribute_2, '\.' || html_form_element_css_classes || '(,|$)') > 0;
         
    when p_spi_id = sct_const.c_no_firing_item and trim(p_attribute_2) like '#%' then
      -- Attribut ist Array von IDs, Seitenelemente mit dieser Klasse suchen
        with params as(
             select v('APP_ID') application_id,
                    v('APP_PAGE_ID') page_id
               from dual)
      select /*+ NO_MERGE (params) */
             cast(collect(item_name) as char_table)
        into l_item_list
        from apex_application_page_items
     natural join params
       where regexp_instr(p_attribute_2, '#' || item_name || '(,|$)') > 0;
       
    else
      l_item_list := null;
    end case;
    return l_item_list;
  end get_firing_items;
  
  
  function get_with_comments
    return boolean
  as
  begin
    return g_with_comments or wwv_flow.g_debug;
  end get_with_comments;
  
    
  procedure set_with_comments(
    p_with_comment in boolean)
  as
  begin
    g_with_comments := p_with_comment;
  end set_with_comments;  
  
  
  procedure set_error_flag
  as
  begin
    g_has_errors := true;
  end set_error_flag;  


  procedure create_action(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_firing_item in sct_page_item.spi_id%type,
    p_is_recursive in number,    
    p_firing_items out nocopy varchar2,
    p_plsql_action out nocopy varchar2,
    p_js_action out nocopy varchar2) 
  as
    l_rule rule_rec;
    l_action_cur sys_refcursor;

    l_stmt varchar2(32767);
    l_plsql_code varchar2(32767);
    l_js_code varchar2(32767);
    l_js_chunk varchar2(32767);
    l_current_rule number := 0;
    l_origin_msg varchar2(200);
    l_length number;
    c_delimiter constant varchar2(10) := sct_const.c_cr || '  ';
  begin
    pit.enter_mandatory(
      p_action => 'create_action',
      p_module => c_pkg,
      p_params => msg_params(
                    msg_param('p_sgr_id', to_char(p_sgr_id)),
                    msg_param('p_firing_item', p_firing_item)
                    ));
    
    -- Stelle ausloesendes Element fuer SQL ueber Get-Methode zur Verfuegung
    g_firing_item := p_firing_item;
    -- Setze Fehlerflag zurueck
    g_has_errors := false;

    l_stmt := utl_text.bulk_replace(sct_const.c_stmt_template, char_table(
                '#RULE_VIEW#', sct_const.c_view_name_prefix || p_sgr_id,
                '#IS_RECURSIVE#', p_is_recursive));
    pit.verbose(msg.allg_pass_information, msg_args('Regel-SQL: ' || l_stmt));

    -- Explizite Cursorkontrolle wegen dynamischen SQLs
    open l_action_cur for l_stmt;
    fetch l_action_cur into l_rule;  -- Hier wird die Regel evaluiert

    while l_action_cur%FOUND loop
      case when l_rule.sra_on_error = sct_const.c_true and not g_has_errors then
        if l_plsql_code is not null then
          -- Beim ersten Fehlerhandler: Fuehre alle serverseitigen Aktionen aus, 
          -- Fehler werden in ERROR_STACK und Meldungen in p_param.notification_stack gesammelt
          -- Uebernehme PL/SQL bzw. JS-Codes in entsprechende Ausgabeparameter
          l_plsql_code := replace(replace(sct_const.c_plsql_action_template, 
                             '#CODE#', coalesce(l_plsql_code, sct_const.C_NULL)), 
                             '#CR#', sct_const.c_cr);
          execute immediate l_plsql_code;
          -- Setze PLSQL_CODE auf null, um bei weiteren Iterationen die Aktionen nicht erneut auszufuehren
          l_plsql_code := null;
        end if;
        if g_has_errors then
          -- Fehler aufgetreten, fahre mit Fehlerhandling fort
          l_js_code := l_js_code 
                    || c_delimiter
                    || get_comment(msg.SCT_ERROR_HANDLING, msg_args(to_char(l_rule.sru_sort_seq), l_rule.sru_name, g_firing_item, sct_const.c_cr));
        else 
          exit;
        end if;
      else
        null;
      end case;
      
      -- Baue PL/SQL-Code zusammen
      if l_rule.pl_sql is not null then
        l_plsql_code := utl_text.bulk_replace(l_plsql_code || sct_const.c_plsql_template, char_table(
          '#PLSQL#', l_rule.pl_sql,
          '#ATTRIBUTE#', l_rule.sra_attribute,
          '#ATTRIBUTE_2#', l_rule.sra_attribute_2,
          '#ALLOW_RECURSION#', check_recursion(l_rule),
          '#ITEM_VALUE#', sct_const.c_plsql_item_value_template,
          '#ITEM#', l_rule.item,
          '#CR#', sct_const.c_cr));
        l_plsql_code := l_plsql_code || sct_const.c_cr || '  ';
      end if;
      
      -- Baue JavaScript-Code zusammen
      if l_rule.is_first_row = sct_const.c_true then
        if l_current_rule > 0 then 
          l_js_code := l_js_code || l_js_chunk;
          l_js_chunk := null;
        else
          l_current_rule := l_rule.sru_sort_seq;
        end if;
        --if g_with_comments then
          if l_rule.sru_fire_on_page_load = sct_const.c_true then
            l_origin_msg := msg.SCT_INIT_ORIGIN;
          else
            l_origin_msg := msg.SCT_RULE_ORIGIN;
          end if;
          l_js_code := l_js_code 
                    || c_delimiter 
                    || pit.get_message_text(l_origin_msg, msg_args(to_char(l_rule.sru_sort_seq), l_rule.sru_name, g_firing_item, sct_const.c_cr));
             --       || get_comment(l_origin_msg, 
             --            msg_args(to_char(l_rule.sru_sort_seq), l_rule.sru_name, g_firing_item, sct_const.c_cr));
        --end if;
      end if;
      
      prepare_js_code(l_js_chunk, l_rule);
      
      fetch l_action_cur into l_rule;
    end loop;

    close l_action_cur;

    -- Uebernehme PL/SQL bzw. JS-Codes in entsprechende Ausgabeparameter
    if l_plsql_code is not null then
      l_plsql_code := replace(replace(sct_const.c_plsql_action_template, 
                        '#CODE#', coalesce(l_plsql_code, sct_const.C_NULL)), 
                        '#CR#', sct_const.c_cr);
      execute immediate l_plsql_code;
    end if;
    
    -- Nicht in BULK_REPLACE integrieren wg. Limit 4000 Byte
    l_js_code := l_js_code || coalesce(l_js_chunk, get_comment(msg.SCT_NO_JAVASCRIPT, msg_args(p_firing_item, sct_const.c_cr)));
    p_js_action := replace(sct_const.c_js_template, '#CODE#', l_js_code);

    utl_text.bulk_replace(p_js_action, char_table(
      '#SRU_SORT_SEQ#', case when l_rule.sru_sort_seq is not null then 'RULE_' || l_rule.sru_sort_seq else 'NO_RULE_FOUND' end,
      '#SRU_NAME#', l_rule.sru_name,
      '#FIRING_ITEM#', p_firing_item));

    -- Ermittle durch die Regel betroffene Seitenelemente als FIRING_ITEMS
    p_firing_items := get_firing_items(p_firing_item);
    pit.leave_mandatory;
  end create_action;

begin
  initialize;
end bl_sct;
/
