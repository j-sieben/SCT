create or replace package body plugin_sct 
as
  
  -- Record zur Aufnahme der Plugin-Attribute
  type param_rec is record(
    sgr_id sct_rule_group.sgr_id%type,    -- ID der Regelgruppe
    firing_item varchar2(50 char),        -- Element das die Bearbeitung auslöst (oder DOCUMENT)
    error_dependent_buttons varchar2(50), -- Liste der Buttons, die im Fehlerfall deaktiviert werden
    bind_items varchar2(32767),           -- Liste der Elemente, deren Events gebunden werden
    page_items varchar2(32767),           -- Liste der Elemente, deren Wert sich im Session State veraendert hat
    firing_items varchar2(32767));        -- Liste der Elemente, die mit FIRING_ITEM durch Regeln verbunden sind
  g_param param_rec;
  
  -- Fehlerstack
  type error_stack is table of apex_error.t_error index by binary_integer;
  g_error_stack error_stack;
  
  -- Rekursionsstack
  type recursive_stack is table of number index by varchar2(50 char);
  g_recursive_stack recursive_stack;
  g_recursive_level number;
  c_recursive_limit constant number := 10;
  
  
  /* Hilfsprozedur zum Umkopieren der Attribute auf einen globalen Record
   * %param p_dynamic_action Uebergebene Attribute des Plugins
   * %usage wird vor dem Rendern und Refresh aufgerufen
   */
  procedure read_settings(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_is_render in boolean default true)
  as
    c_radio_group constant varchar2(30) := 'NATIVE_RADIOGROUP';
  begin
    
    select sgr_id
      into g_param.sgr_id
      from sct_rule_group
     where upper(sct_rule_group.sgr_name) = upper(p_dynamic_action.attribute_01)
       and sgr_app_id = (select v('APP_ID') from dual);

    -- Aufrufparameter
    g_param.error_dependent_buttons := p_dynamic_action.attribute_02;
    g_param.firing_item := apex_application.g_x01;        
        
    -- Initialisierung
    g_param.page_items := null;
    g_param.firing_items := null;

    g_error_stack.delete;
    g_recursive_stack.delete;
    g_recursive_level := 1;
  exception
    when no_data_found then
      raise_application_error(-20000, 'Die Regelgruppe ' || p_dynamic_action.attribute_01 || ' existiert nicht' || apex_application.g_x01);
  end read_settings;
  
  
  /* Hilfsfunktion zur Erzeugung eines JSON-Objekts fuer die relevanten Elemente
   * der Regelgruppe
   * %return JSON-Instanz mit ID und Event fuer alle relevanten Seitenelemente
   * %usage Wird aufgerufen, wenn das Plugin initialisiert wird.
   *        Ermittelt alle relevanten Elemente der Regelgruppe, die einen Event
   *        binden sollen und erstellen aus der Liste eine JSON-Instanz, die durch
   *        das Pugin zur Initialisierung ausgefuehrt wird.
   */
  function get_json_from_bind_items
    return varchar2
  as
    -- Liste relevanter Elemente, die einen Event binden sollen
    cursor rule_group_items(p_sgr_id sct_rule_group.sgr_id%type) is
      select spi_id, sit_event, sit_has_value
        from sct_page_item spi
        join sct_page_item_type sit
          on spi.spi_sit_id = sit.sit_id
        join sct_rule_group sgr
          on spi.spi_sgr_id = sgr.sgr_id
       where sit.sit_event is not null
         and spi.spi_is_required = sct_const.c_true
         and sgr.sgr_active = sct_const.c_true
         and sgr.sgr_id = p_sgr_id;
    l_json varchar2(32767);
  begin
    for item in rule_group_items(g_param.sgr_id) loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(sct_const.c_bind_json_element, char_table(
          '#ID#', item.spi_id,
          '#EVENT#', item.sit_event)),
        sct_const.c_delimiter, 'Y');
      -- relevante Elemente mit Session State registrieren, damit beim initialen Aufruf
      -- die aktuellen Seitenwerte dieser Elemente übermittelt werden
      -- (diese Aufgabe uebernimmt anschliessend REGISTER_ITEM)
      if item.sit_has_value = 1 then
        utl_text.merge(g_param.page_items, item.spi_id, sct_const.c_delimiter);
      end if;
    end loop;
    
    -- Elemente werden mit '~' als Ersatz fuer '"' erzeugt, da APEX dieses Zeichen
    -- durch eine Escape-Sequenz maskiert. Andernfalls kann in JavaScript daraus 
    -- kein JSON-Objekt mehr erzeugt werden.
    return utl_text.bulk_replace(sct_const.c_bind_json_template, char_table('#JSON#', l_json, '"', '~'));
  end get_json_from_bind_items;
  
  
  /* Hilfsfunktion zum Auslesen alle geaenderten Seitenelemente im Session State.
   * %return JSON-Instanz aller Elemente und Elementwerte, die im Session State
   *         veraendert wurden
   * %usage Die Funktion izeriert ueber alle Elemente, die waehrend der Aktualisierung
   *        durch REGISTER_ITEM vermerkt wurden und stellt sie mit aktuellem Elementwert
   *        zu einer JSON-Instanz zusammen, die als Teil der Antwort gesendet wird.
   *        Die Funktion wird bei jedem Refresh aufgerufen
   */
  function get_json_from_items
    return varchar2
  as
    l_json varchar2(32767);
    l_items apex_application_global.vc_arr2;
  begin
    l_items := apex_util.string_to_table(trim(sct_const.c_delimiter from g_param.page_items), sct_const.c_delimiter);
    for i in 1 .. l_items.count loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(sct_const.c_page_json_element, char_table(
          '#ID#', l_items(i),
          '#VALUE#', htf.escape_sc(v(l_items(i))))),
        sct_const.c_delimiter, 'Y');
    end loop;
    return replace(sct_const.c_bind_json_template, '#JSON#', l_json);
  end get_json_from_items;
  
  
  /* Hilfsfunktion zum Zusammenstellen aller registrierter Fehlermeldungen zu einem
   * JSON-Objekt, das als Teil der Antwort an den Browser gesendet wird.
   */
  function get_json_from_errors
    return varchar2
  as
    l_json varchar2(32767);
  begin
    for i in 1 .. g_error_stack.count loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(sct_const.c_error_json_element, char_table(
          '#ITEM#', g_error_stack(i).page_item_name,
          '#MESSAGE#', htf.escape_sc(g_error_stack(i).message),
          '#INFO#', htf.escape_sc(g_error_stack(i).additional_info))),
        sct_const.c_delimiter, 'Y');
    end loop;
    l_json := utl_text.bulk_replace(sct_const.c_error_json_template, char_table(
                '#COUNT#', g_error_stack.count,
                '#DEPENDENT_BUTTONS#', g_param.error_dependent_buttons,
                '#ERRORS#', l_json));
    return l_json;
  end get_json_from_errors;
  
  
  /* Funktion wertet die Regel der angeforderten Regelgruppe aus
   * %return HTML-Script mit den Javascript-Anweisungen fuer die clientseitige
   *         Verarbeitung
   * %usage Wird durch das Plugin beim Refresh aufgerufen
   *        - Erstellt einen PL/SQL-Skript, der sofort ausgefuehrt wird
   *        - Erstellt einen JavaScript-Skript, der zurueckgeliefert wird
   *        - Analysiert, ob Regel rekursive Ausfuehrung erfordert und ruft
   *          sich selbst mit den rekursiven Regeln auf
   */
  function process_rule
    return varchar2
  as
    l_firing_items sct_rule.sru_firing_items%type;
    l_plsql_action varchar2(32767);
    l_js_action varchar2(32767);
    l_has_events boolean := false;
    l_old_level number := g_recursive_level;
  begin
    g_param.firing_item := g_recursive_stack.first;
    while g_param.firing_item is not null loop
      if g_recursive_stack(g_param.firing_item) = l_old_level then
        l_has_events := true;
        g_recursive_level := g_recursive_level + 1;
        
        -- Session State auswerten und neue Aktion berechnen
        begin
          sct_admin.create_action(
            p_sgr_id => g_param.sgr_id,
            p_firing_item => g_param.firing_item,
            p_is_recursive => case g_recursive_level when 1 then sct_const.c_false else sct_const.c_true end,
            p_firing_items => l_firing_items,
            p_plsql_action => l_plsql_action,
            p_js_action => l_js_action);
          
          -- Rekursionsebene setzen und Firing Items vermerken
          l_js_action := replace(l_js_action, '#RECURSION#', l_old_level);
          utl_text.merge(g_param.firing_items, l_firing_items, sct_const.c_delimiter);
        exception
          when others then
            register_error(g_param.firing_item, 'Fehler bei Pluginverarbeitung: ' || sqlerrm);
        end;
        
        -- Fuehre alle serverseitigen Aktionen aus. 
        -- Fehler werden in G_ERROR_STACK gesammelt
        if l_plsql_action is not null then
          execute immediate l_plsql_action;
        end if;
        
      end if;
      g_param.firing_item := g_recursive_stack.next(g_param.firing_item);
    end loop;
    
    -- Rekursion, endet, wenn keine weiteren Aktivitaeten registriert wurden
    if l_has_events then
      l_js_action := l_js_action || process_rule;
    end if;
    
    return l_js_action;
  end process_rule;  
    
  
  /* Hilfsprozedur zum Registrieren von Elemente, die durch das Plugin im Session State
   * geaendert wurden. Diese Elemente werden anschliessend in der Antwort im Browser
   * auf den aktuellen Wert gesetzt.
   */
  procedure register_item(
    p_item in varchar2)
  as
    l_has_rule number;
  begin
    -- Vermerke, dass p_item an den Browser gesendet werden muss
    utl_text.merge(g_param.page_items, p_item, sct_const.c_delimiter);
    
    -- Ermittle, ob p_item in Regeln referenziert wird. Falls ja, rekursiven Aufruf speichern
    select count(*)
      into l_has_rule
      from dual
     where exists(
           select 1
             from sct_page_item
            where -- Element ist relevant
                 spi_id = p_item   
             and spi_is_required = 1
                 -- und ruft sich nicht selbst auf
             and p_item != g_param.firing_item);
       
    if l_has_rule > 0 then
      if g_recursive_level <= c_recursive_limit then
        if not g_recursive_stack.exists(p_item) then
          -- Element wurde rekursiv noch nicht aufgerufen, vermerken
          g_recursive_stack(p_item) := g_recursive_level;
        else
          register_error(p_item, 'Element hat rekursive Schleife erzeugt und wurde daher ignoriert.');
        end if;
      else
        register_error(p_item, 'Element hat Rekursionstiefe von ' || c_recursive_limit || ' ueberschritten.');
      end if;
    end if;
  end register_item;
  
  
  /* INTERFACE */
  procedure register_error(
    p_spi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null)
  as
    l_error apex_error.t_error;
  begin
    if p_error_msg is not null then
      l_error.page_item_name := p_spi_id;
      l_error.message := p_error_msg;
      l_error.additional_info := replace(dbms_utility.format_error_backtrace, chr(10), '<br/>');
      g_error_stack(g_error_stack.count + 1) := l_error;
    end if;
  end register_error;
  
  
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean)
  as
    l_is_mandatory sct_page_item.spi_is_mandatory%type;
    l_mandatory_message sct_page_item.spi_mandatory_message%type;
  begin
    if p_is_mandatory then 
      l_is_mandatory := sct_const.c_true;
      l_mandatory_message := coalesce(p_spi_mandatory_message, p_spi_id || ' ist ein Pflichtfeld. Bitte geben Sie eine Information ein.');
    else 
      l_is_mandatory := sct_const.c_false;
      l_mandatory_message := null;
    end if;
    
    update sct_page_item
       set spi_is_mandatory = l_is_mandatory,
           spi_mandatory_message = l_mandatory_message
     where spi_sgr_id = g_param.sgr_id
       and spi_id = p_spi_id;
  end register_mandatory;
  
  
  procedure check_mandatory(
    p_firing_item in sct_page_item.spi_id%type)
  as
    l_message sct_page_item.spi_mandatory_message%type;
  begin
    -- Die Abfrage registriert eine Fehlermeldung, wenn
    -- - Das Element aktuell Pflichtfeld ist
    -- - Das Element keinen Wert im Session State besitzt
    select spi_mandatory_message
      into l_message
      from sct_page_item
     where spi_id = p_firing_item
       and spi_is_mandatory = sct_const.c_true
       and (select v(p_firing_item) from dual) is null;
    register_error(p_firing_item, l_message);
  exception
    when no_data_found then
      -- Keine Pflichtfelder mit Fehlern auf der Seite, ignorieren
      null;
  end check_mandatory;
  
  
  procedure submit_page
  as
    cursor mandatory_items is
      select spi_id
        from sct_page_item
       where spi_is_mandatory = sct_const.c_true
         and spi_sgr_id = g_param.sgr_id;
  begin
    for itm in mandatory_items loop
      check_mandatory(itm.spi_id);
    end loop;
  end submit_page;
  
  
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2)
  as
  begin
    register_item(p_item);
    apex_util.set_session_state(p_item, p_value);
  end set_session_state;
  
    
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in date)
  as
  begin
    register_item(p_item);
    apex_util.set_session_state(p_item, p_value);
  end set_session_state;
  
    
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in number)
  as
  begin
    register_item(p_item);
    apex_util.set_session_state(p_item, p_value);
  end set_session_state;
  
  
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
    
    l_result.javascript_function := sct_const.c_js_function;
    l_result.ajax_identifier := apex_plugin.get_ajax_identifier; 
    -- Methode GET_JSON_FROM_BIND_ITEMS registriert beim Initialisieren auch PAGE_ITEMS
    l_result.attribute_01 := get_json_from_bind_items;
    l_result.attribute_02 := g_param.page_items;
    
    return l_result;
  end render;
  

  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result
  as
    l_result apex_plugin.t_dynamic_action_ajax_result;
    l_js_action varchar2(32767);
    l_firing_item sct_page_item.spi_id%type;
  begin
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    -- Initialisieren
    read_settings(p_dynamic_action);    
    
    -- Registriere FIRING_ELEMENT auf Rekursionebene 1
    l_firing_item := g_param.firing_item;
    g_recursive_stack(g_param.firing_item) := g_recursive_level;
    
    -- Bereite Anwort als JS vor
    l_js_action := coalesce(process_rule, sct_const.c_no_js_action);
    l_js_action := utl_text.bulk_replace(sct_const.c_js_action_template, char_table(
      '~', sct_const.c_cr,
      '#ITEM_JSON#', get_json_from_items,
      '#ERROR_JSON#', get_json_from_errors,
      '#FIRING_ITEMS#', g_param.firing_items,
      '#JS_FILE#', sct_const.c_js_namespace,
      '#CODE#', l_js_action));
    htp.p(l_js_action);
    return l_result;
  end ajax;
end plugin_sct;
/