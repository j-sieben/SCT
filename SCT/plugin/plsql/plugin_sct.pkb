create or replace package body plugin_sct 
as
 
  c_true constant char(1 byte) := 'Y';
  
  -- Record zur Aufnahme der Plugin-Attribute
  type param_rec is record(
    sgr_id sct_group.sgr_id%type,
    page_items varchar2(4000 byte),
    bind_items varchar2(4000 byte),
    firing_item varchar2(4000 byte));
  g_param param_rec;
  
  -- Fehlerstack
  type error_stack is table of apex_error.t_error index by binary_integer;
  g_error_stack error_stack;
  
  
  /* Hilfsprozedur zum Umkopieren der Attribute auf einen globalen Record
   * %param p_dynamic_action Uebergebene Attribute des Plugins
   * %usage wird vor dem Rendern und Refresh aufgerufen
   */
  procedure read_settings(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_is_render in boolean default true)
  as
  begin
    
    select sgr_id
      into g_param.sgr_id
      from sct_group
     where upper(sct_group.sgr_name) = upper(p_dynamic_action.attribute_01);
    g_param.firing_item := apex_application.g_x01;
    
    if p_is_render then
      -- Ermittle die relevanten Seitenelemente fuer diese Regelruppe
      -- Wird nur zum Renderzeitpunkt benoetigt
      select listagg(spi_id, ',') within group (order by spi_id)
        into g_param.bind_items
        from sct_page_item spi
        join sct_group sgr
          on spi.spi_sgr_id = sgr.sgr_id
       where spi.spi_is_required = 'Y'
         and sgr.sgr_id = g_param.sgr_id;
               
      select listagg(spi_id, ',') within group (order by spi_id) item_list
        into g_param.page_items
        from (select distinct sra_spi_id spi_id
                from sct_rule_action sra
                join sct_action_type sat
                  on sra.sra_sat_id = sat.sat_id
                join sct_group sgr
                  on sra.sra_sgr_id = sgr.sgr_id
               where sat.sat_changes_value = c_true
                 and sgr.sgr_id = g_param.sgr_id);
    end if;
  exception
    when no_data_found then
      raise_application_error(-20000, 'Die Regelgruppe ' || p_dynamic_action.attribute_01 || 'existiert nicht');
  end read_settings;
  
  
  function get_json_from_items
    return varchar2
  as
    l_json varchar2(32767);
    l_items apex_application_global.vc_arr2;
  begin
    l_items := apex_util.string_to_table(g_param.page_items, ',');
    l_json := '{"item":[';
    for i in 1..l_items.count loop
      l_json := l_json || '{'
             || apex_javascript.add_attribute('id', l_items(i), false, true )
             || apex_javascript.add_attribute('value', htf.escape_sc(v(l_items(i))), false, false)
             || '}';
      if ( i < l_items.count ) then
        l_json := l_json || ',';
      end if;
    end loop;    
    l_json := l_json || ']}';
    
    return l_json;
  end get_json_from_items;
  
  
  function get_json_from_errors
    return varchar2
  as
    l_json varchar2(32767);
  begin
    l_json := '{"count":' || g_error_stack.count || ','
           || '"errors":[';
    for i in 1..g_error_stack.count loop
      l_json := l_json || '{'
             || apex_javascript.add_attribute('item', g_error_stack(i).page_item_name, false, true)
             || apex_javascript.add_attribute('message', htf.escape_sc(g_error_stack(i).message), false, true)
             || apex_javascript.add_attribute('additionalInfo', htf.escape_sc(g_error_stack(i).additional_info), false, false)
             || '}';
      if (i < g_error_stack.count) then
        l_json := l_json || ',';
      end if;
    end loop;    
    l_json := l_json || ']}';
    
    return l_json;
  end get_json_from_errors;
  
  
  /* Funktion wertet die Regel der angeforderten Regelgruppe aus
   * %return HTML-Script mit den Javascript-Anweisungen fuer die clientseitige
   *         Verarbeitung
   * %usage Wird durch das Plugin beim Refresh aufgerufen
   */
  function process_rule
    return varchar2
  as
    l_rule_name sct_rule.sru_name%type;
    l_plsql_action varchar2(32767);
    l_js_action varchar2(32767);
  begin
    -- Fehlerstack zuruecksetzen
    g_error_stack.delete;
    
    -- Session State auswerten und neue Aktion berechnen
    sct_admin.create_action(
      p_sgr_id => g_param.sgr_id,
      p_firing_item => g_param.firing_item,
      p_plsql_action => l_plsql_action,
      p_js_action => l_js_action);
    
    -- Fuehre alle serverseitigen Aktionen aus. 
    -- Fehler werden in G_ERROR_STACK gesammelt
    execute immediate l_plsql_action;
    
    -- Bereite Anwort als JS vor
    utl_text.bulk_replace(l_js_action, char_table(
      '#ITEM_JSON#', get_json_from_items,
      '#ERROR_JSON#', get_json_from_errors));
    return l_js_action;
  end process_rule;  
    
  
  /* INTERFACE */
  procedure register_error(
    p_item in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null)
  as
    l_error apex_error.t_error;
  begin
    if p_error_msg is not null then
      l_error.page_item_name := p_item;
      l_error.message := p_error_msg;
      l_error.additional_info := p_internal_error;
      g_error_stack(g_error_stack.count + 1) := l_error;
    end if;
    dbms_output.put_line('Fehlerzaehler: ' || g_error_stack.count);
  end register_error;
  
  
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result
  as
    l_result apex_plugin.t_dynamic_action_render_result;
  begin
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    read_settings(p_dynamic_action);
    
    l_result.javascript_function := sct_admin.get_js_function;
    l_result.ajax_identifier := apex_plugin.get_ajax_identifier;
    l_result.attribute_01 := g_param.bind_items;
    l_result.attribute_02 := g_param.page_items;
    
    return l_result;
  end render;
  

  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result
  as
    l_result apex_plugin.t_dynamic_action_ajax_result;
  begin
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
        
    read_settings(p_dynamic_action);
    
    htp.p(process_rule);
    return l_result;
  end ajax;

end plugin_sct;
/