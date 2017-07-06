create or replace package body plugin_sct 
as
  -- Fehlerstack
  type error_stack_t is table of apex_error.t_error index by binary_integer;
  
  type item_stack_t is table of number index by varchar2(50);
  
  -- Rekursionsstack
  -- Der Rekursionsstack speichert die Seitenelemente, die durch die Regeln geaendert wurden,
  -- um anschlie�end auch fuer diese Elemente die Regelpruefung aufzurufen.
  type recursive_stack_t is table of number index by sct_page_item.spi_id%type;
  
  -- Record zur Aufnahme der Plugin-Attribute
  type param_rec is record(
    id number,                              -- Interne ID des Records, falls n Instanzen aufgerufen werden
    sgr_id sct_rule_group.sgr_id%type,      -- ID der Regelgruppe
    firing_item sct_page_item.spi_id%type,  -- Element das die Bearbeitung ausloest (oder DOCUMENT)
    error_dependent_buttons varchar2(2000), -- Liste der Buttons, die im Fehlerfall deaktiviert werden
    bind_items item_stack_t,                -- Liste der Elemente, deren Events gebunden werden
    page_items item_stack_t,                -- Liste der Elemente, deren Wert sich im Session State veraendert hat
    firing_items item_stack_t,              -- Liste der Elemente, die mit FIRING_ITEM durch Regeln verbunden sind
    error_stack error_stack_t,              -- Liste der Fehler, die bislang aufgelaufen sind
    recursive_stack recursive_stack_t,      -- Liste der rekursiven Elemente, die geprueft werden sollen
    recursive_level number,                 -- Aktuelle Ebene der Rekursion, die bearbeitet wird
    allow_recursion boolean,                -- Flag, das anzeigt, ob Rekursion fuer diese Regelgruppe erlaubt ist
    notification_stack varchar2(32767),     -- Liste der Benachrichtigungen, die ausgegebenen werden sollen
    stop_flag boolean,                      -- Wenn dieses Flag gesetzt wird, stoppt die Weiterverarbeitung der Regel
    now pls_integer                         -- Zeitstempel dieser Regelgruppe, wird zum Stoppen der Ausfuehrungsdauer verwendet
  );
  
  g_param param_rec;
  
  g_recursion_limit binary_integer;
  g_recursion_loop_is_error boolean;
  
  /* Package-Konstanten */
  C_PKG constant varchar2(30 byte) := $$PLSQL_UNIT;
  C_PARAM_GROUP constant varchar2(30 byte) := 'SCT';
  
  /* TODO: Vereinheitlichen BOOL as Zahl oder CHAR */
  C_YES constant char(1 byte) := 'Y';
  C_NUMBER_ITEM constant sct_page_item_type.sit_id%type := 'NUMBER_ITEM';
  C_DATE_ITEM constant sct_page_item_type.sit_id%type := 'DATE_ITEM';
  C_NUMBER_CONVERSION_TEMPLATE constant varchar2(200 byte) := q'~begin :x := to_number(v('#ITEM#'), '#CONVERSION#'); end;~';
  C_DATE_CONVERSION_TEMPLATE constant varchar2(200 byte) := q'~begin :x := to_date(v('#ITEM#'), '#CONVERSION#'); end;~';
  
  C_BIND_JSON_TEMPLATE constant varchar2(100) := '[#JSON#]';
  C_BIND_JSON_ELEMENT constant varchar2(100) := '{"id":"#ID#","event":"#EVENT#"}';
  C_PAGE_JSON_ELEMENT constant varchar2(100) := '{"id":"#ID#","value":"#VALUE#"}';
  C_ERROR_JSON_TEMPLATE constant varchar2(200) := q'^{"count":#COUNT#,"errorDependentButtons":"#DEPENDENT_BUTTONS#","firingItems":"#FIRING_ITEMS#","errors":[#ERRORS#]}^';
  C_ERROR_JSON_ELEMENT constant varchar2(200) := q'^{"type":"error","item":"#ITEM#","message":"#MESSAGE#","location":#LOCATION#,"additionalInfo":"#INFO#","unsafe":"false"}^';
  
  C_JS_ACTION_TEMPLATE constant varchar2(300) := q'^<script>~(function(sct){~  sct.setItemValues(#ITEM_JSON#);~  sct.setErrors(#ERROR_JSON#);#CODE#~})(#JS_FILE#);~</script>^';  
  
  /* Hilfsprozedur zum Einfuegen von Kommentaren, falls Seite sich im Debug-Modus befindet
   * %param p_msg Meldung, die als Kommentar ausgegeben werden soll
   * %param p_msg_args Optionale Meldungsparameter
   * %usage Wird verwendet, um die Antwort im Normalbetrieb schlank zu halten
   */
  function get_comment(
    p_msg pit_message.pms_name%type,
    p_msg_args msg_args default null)
    return varchar2
  as
  begin
    if wwv_flow.g_debug then
      return pit.get_message_text(p_msg, p_msg_args);
    else
      return null;
    end if;
  end get_comment;
  
  
  /* Hilfsprozedur zum Formatieren von ausloesenden Elementen.
   * %usage Die Methode analysiert, ob das ausloesende Element eine Formatmaske
   *        hinterlegt hat. Falls ja,
   *        - wird das Element testweise konvertiert, um Fehler abzufangen
   *        - wird das konvertierte Element mit der Formatierung in eine Zeichen-
   *          kette konvertiert und im Session State gespeichert, um auf der 
   *          Oberflaeche formatiert angezeigt zu werden.
   */
  procedure format_firing_item
  as
    l_spi_sit_id sct_page_item.spi_sit_id%type;
    l_spi_conversion sct_page_item.spi_conversion%type;
    l_number_val number;
    l_date_val date;
  begin
    pit.enter_optional('format_firing_item', C_PKG);
    
    -- Sollte fuer das ausloesende Element eine Formatierungsvorlage existieren,
    -- wird diese hier angewendet und geprueft
    select spi_sit_id, spi_conversion
      into l_spi_sit_id, l_spi_conversion
      from sct_page_item
     where spi_sgr_id = g_param.sgr_id
       and spi_id = g_param.firing_item
       and spi_conversion is not null;
    
    case l_spi_sit_id
      when C_NUMBER_ITEM then
        begin
          -- Konvertiere in Zahl
          execute immediate 
            utl_text.bulk_replace(
              C_NUMBER_CONVERSION_TEMPLATE, char_table(
                '#CONVERSION#', l_spi_conversion,
                '#ITEM#', g_param.firing_item))
            using out l_number_val;
          -- Konvertierung erfolgreich, setze formatierten String in Session State
          set_session_state(g_param.firing_item, to_char(l_number_val, l_spi_conversion), sct_const.c_true);
        exception
          when msg.SCT_INVALID_FORMAT_ERR then
            register_error(g_param.firing_item, msg.SCT_EXPECTED_FORMAT, msg_args(l_spi_conversion));
          when others then
            register_error(g_param.firing_item, msg.SCT_GENERIC_ERROR, msg_args(substr(sqlerrm, instr(sqlerrm, ':', 1) + 2)));
        end;
      when C_DATE_ITEM then
        begin
          -- Konvertiere in Datum
          execute immediate 
            utl_text.bulk_replace(
              C_DATE_CONVERSION_TEMPLATE, char_table(
                '#CONVERSION#', l_spi_conversion,
                '#ITEM#', g_param.firing_item))
            using out l_date_val;
          -- Konvertierung erfolgreich, setze formatierten String in Session State
          set_session_state(g_param.firing_item, to_char(l_date_val, l_spi_conversion), sct_const.c_true);
        exception
          when INVALID_NUMBER then
            register_error(
              g_param.firing_item, 
              msg.SCT_INVALID_NUMBER, 
              msg_args(l_spi_conversion));
          when others then
            register_error(
              g_param.firing_item, 
              msg.SCT_GENERIC_ERROR, 
              msg_args(substr(sqlerrm, instr(sqlerrm, ':', 1) + 2)));
        end;
      else
        pit.stop(msg.SCT_UNEXPECTED_CONV_TYPE, msg_args(l_spi_sit_id));
    end case;
    pit.leave_optional;
  exception
    when no_data_found then
      -- Keine Formatmaske gefunden, ignorieren
      pit.leave_optional;
  end format_firing_item;
  
  
  procedure push_page_item(
    p_item_name in sct_page_item.spi_id%type)
  as
  begin
    if not g_param.page_items.exists(p_item_name) then
      g_param.page_items(p_item_name) := 1;
    end if;
  end push_page_item;
  
  
  procedure push_bind_item(
    p_item_name in sct_page_item.spi_id%type)
  as
  begin
    if not g_param.bind_items.exists(p_item_name) then
      g_param.bind_items(p_item_name) := 1;
    end if;
  end push_bind_item;
  
  
  procedure push_firing_item(
    p_item_name in varchar2)
  as
    l_item varchar2(1000 char);
  begin
    if p_item_name is not null then
      for i in 1 .. regexp_count(p_item_name, sct_const.c_delimiter) + 1 loop
        l_item := regexp_substr(p_item_name, '[^\' || sct_const.c_delimiter || ']+', 1, i);
        if l_item is not null and not g_param.firing_items.exists(l_item) then
          g_param.firing_items(l_item) := 1;
        end if;
      end loop;
    end if;
  end push_firing_item;
  
  
  function join_list(
    p_list in item_stack_t)
    return varchar2
  as
    l_item varchar2(50);
    l_result varchar2(32767);
  begin
    l_item := p_list.first;
    while l_item is not null loop
      l_result := l_result || sct_const.c_delimiter || l_item;
      l_item := p_list.next(l_item);
    end loop;
    return trim(sct_const.c_delimiter from l_result);
  end join_list;
  
  
  /* Hilfsprozedur zum Umkopieren der Attribute auf einen globalen Record
   * %param p_dynamic_action Uebergebene Attribute des Plugins
   * %usage Wird vor dem Rendern und Refresh aufgerufen, um an zentraler Stelle
   *        die APEX-Parameter auf lokale Variablen zu kopieren
   */
  procedure read_settings(
    p_dynamic_action in apex_plugin.t_dynamic_action)
  as
    l_stmt varchar2(200 char);
    l_allow_recursion number;
  begin
    pit.enter_optional('read_settings', C_PKG);

    -- Aufrufparameter
    g_param.error_dependent_buttons := p_dynamic_action.attribute_02;
    g_param.firing_item := apex_application.g_x01;
    
    -- Daten zur Regelgruppe lesen
    select sgr_id, coalesce(sgr_with_recursion, 1)
      into g_param.sgr_id, l_allow_recursion
      from sct_rule_group
     where sct_rule_group.sgr_name = upper(p_dynamic_action.attribute_01)
       and sgr_app_id = apex_application.g_flow_id;
    
    -- Rekursionsschalter uebernehmen
    g_param.allow_recursion := l_allow_recursion = sct_const.c_true;
        
    -- Initialisierung der Kollektionen
    g_param.bind_items.delete;
    g_param.page_items.delete;
    g_param.firing_items.delete;
    g_param.error_stack.delete;
    g_param.recursive_level := 1;
    
    -- Pruefe und formatiere das ausloesende Element
    format_firing_item;
    pit.leave_optional;
  exception
    when no_data_found then
      register_error('DOCUMENT', msg.SCT_RULE_DOES_NOT_EXIST, msg_args(p_dynamic_action.attribute_01));
  end read_settings;
  
  
  /* Hilfsfunktion zur Erzeugung eines JSON-Objekts fuer die relevanten Elemente
   * der Regelgruppe
   * %return JSON-Instanz mit ID und Event fuer alle relevanten Seitenelemente
   * %usage Wird aufgerufen, wenn das Plugin initialisiert wird.
   *        Ermittelt alle relevanten Elemente der Regelgruppe, die einen Event
   *        binden sollen und erstellt aus der Liste eine JSON-Instanz, die durch
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
    pit.enter_optional('get_json_from_bind_items', C_PKG);
    
    for item in rule_group_items(g_param.sgr_id) loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(c_bind_json_element, char_table(
          '#ID#', item.spi_id,
          '#EVENT#', item.sit_event)),
        sct_const.c_delimiter, C_YES);
      -- relevante Elemente mit Session State registrieren, damit beim initialen Aufruf
      -- die aktuellen Seitenwerte dieser Elemente �bermittelt werden
      -- (diese Aufgabe uebernimmt anschliessend REGISTER_ITEM)
      if item.sit_has_value = 1 then
        push_page_item(item.spi_id);
      end if;
    end loop;
    
    -- Elemente werden mit '~' als Ersatz fuer '"' erzeugt, da APEX dieses Zeichen
    -- durch eine Escape-Sequenz maskiert. Andernfalls kann in JavaScript daraus 
    -- kein JSON-Objekt mehr erzeugt werden.
    l_json := utl_text.bulk_replace(c_bind_json_template, char_table('#JSON#', l_json, '"', '~'));
    
    pit.leave_optional;
    return l_json;
  end get_json_from_bind_items;
  
  
  /* Hilfsfunktion zum Auslesen aller geaenderter Seitenelemente im Session State.
   * %return JSON-Instanz aller Elemente und Elementwerte, die im Session State
   *         veraendert wurden
   * %usage Die Funktion iteriert ueber alle Elemente, die waehrend der Aktualisierung
   *        durch REGISTER_ITEM vermerkt wurden und stellt sie mit aktuellem Elementwert
   *        zu einer JSON-Instanz zusammen, die als Teil der Antwort gesendet wird.
   *        Die Funktion wird bei jedem Refresh aufgerufen
   */
  function get_json_from_items
    return varchar2
  as
    l_json varchar2(32767);
    l_item varchar2(50);
  begin
    pit.enter_optional('get_json_from_items', C_PKG);
    
    l_item := g_param.page_items.first;
    while l_item is not null loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(c_page_json_element, char_table(
          '#ID#', l_item,
          '#VALUE#', htf.escape_sc(v(l_item)))),
        sct_const.c_delimiter, C_YES);
      l_item := g_param.page_items.next(l_item);
    end loop;
    
    l_json := replace(c_bind_json_template, '#JSON#', l_json);
    
    pit.leave_optional;
    return l_json;
  end get_json_from_items;
  
  
  /* Hilfsfunktion zum Zusammenstellen aller registrierter Fehlermeldungen zu einem
   * JSON-Objekt, das als Teil der Antwort an den Browser gesendet wird.
   */
  function get_json_from_errors
    return varchar2
  as
    l_json varchar2(32767);
    l_location varchar2(50 char);
  begin
    pit.enter_optional('get_json_from_errors', C_PKG);
    for i in 1 .. g_param.error_stack.count loop
      if g_param.error_stack(i).page_item_name = 'DOCUMENT' then
        l_location := '"page"';
      else
        l_location := '["inline","page"]';
      end if;
      utl_text.append(
        l_json,
        utl_text.bulk_replace(c_error_json_element, char_table(
          '#ITEM#', g_param.error_stack(i).page_item_name,
          '#MESSAGE#', htf.escape_sc(g_param.error_stack(i).message),
          '#LOCATION#', l_location,
          '#INFO#', htf.escape_sc(g_param.error_stack(i).additional_info))),
        sct_const.c_delimiter, C_YES);
    end loop;
    l_json := utl_text.bulk_replace(c_error_json_template, char_table(
                '#COUNT#', g_param.error_stack.count,
                '#DEPENDENT_BUTTONS#', g_param.error_dependent_buttons,
                '#ERRORS#', l_json));
                
    pit.leave_optional;
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
    l_js_action_chunk varchar2(32767);
    l_js_action varchar2(32767);
    l_needs_recursive_call boolean := false;
    l_processed_item sct_page_item.spi_id%type;
    l_elapsed VARCHAR2(1000);
    
    l_is_recursive number(1,0);
    l_actual_recursive_level binary_integer;
  begin
    pit.enter_mandatory('process_rule', C_PKG);
    
    -- Initialisierung
    l_actual_recursive_level := g_param.recursive_level;
    -- Inkrementiert Rekursionslevel, damit zukuenftige Eintraege auf eigenem Level liegen
    -- Wird benoetigt, um �breadth first� zu arbeiten: Alle Rekursionsaufrufe einer Ebene, danach die naechste Ebene etc.
    g_param.recursive_level := l_actual_recursive_level + 1;
    
    -- is_recursive wird verwendet, um Aktionen, die nicht rekursiv ausgefuehrt werden sollen, auszusondern
    l_is_recursive := case l_actual_recursive_level when 1 then sct_const.c_false else sct_const.c_true end;
    
    -- Iteriere ueber Rekursionsstack
    g_param.firing_item := g_param.recursive_stack.first;

    while g_param.firing_item is not null loop
      begin
        --  fuehre alle �Events� auf aktuellem Rekursionslevel aus
        if g_param.recursive_stack(g_param.firing_item) = l_actual_recursive_level then
          -- Speichere Name des Elements zum spaeteren Loeschen des Elements aus dem Rekursionsstack
          l_processed_item := g_param.firing_item;
          l_needs_recursive_call := true;
          -- Meldungensstack initialisieren
          g_param.notification_stack := null;
          
          -- Session State auswerten und neue Aktion berechnen
          sct_admin.create_action(
            p_sgr_id => g_param.sgr_id,
            p_firing_item => g_param.firing_item,
            p_is_recursive => l_is_recursive,
            p_firing_items => l_firing_items,
            p_plsql_action => l_plsql_action,
            p_js_action => l_js_action_chunk);     
          
          -- Fuehre alle serverseitigen Aktionen aus, 
          -- Fehler werden in ERROR_STACK und Meldungen in p_param.notification_stack gesammelt
          if l_plsql_action is not null then
            execute immediate l_plsql_action;
          end if;
          
          if wwv_flow.g_debug then
            l_elapsed := (dbms_utility.get_time - g_param.now) || 'hsec';  --  Das berechnet die verstrichene Zeit, allerdings kumulativ, also jeweils die Zeit von G_NOW an gerechnet
            -- JavaScript dieser Rekursionsebene erstellen 
            l_js_action_chunk := utl_text.bulk_replace(l_js_action_chunk, char_table(
                                  '#RECURSION#', l_actual_recursive_level,
                                  '#TIME#', l_elapsed, -- hier wird die Zeit eingefuegt
                                  '#NOTIFICATION#', g_param.notification_stack,
                                  '#CR#', sct_const.C_CR));
          end if;
          -- Ausgabe erstellen und geaenderte Elemente merken
          push_firing_item(l_firing_items);
          utl_text.append(l_js_action, l_js_action_chunk);
          
        end if;
  
        -- Naechstes Element verarbeiten
        g_param.firing_item := g_param.recursive_stack.next(g_param.firing_item);
        
        case when g_param.stop_flag then
          g_param.recursive_stack.delete;
          exit;
        when l_processed_item is not null then
          -- verarbeitetes Element aus Rekursionsstack entfernen
          g_param.recursive_stack.delete(l_processed_item);
        end case;
        
      exception
        when others then
          register_error('DOCUMENT', substr(sqlerrm, 11, 100), ''); --'Ein Fehler ist auf der Seite aufgetreten', '');
          g_param.recursive_stack.delete;
          exit;
      end;
    end loop;
    
    -- Rekursion, endet, wenn keine weiteren Aktivitaeten registriert wurden
    if l_needs_recursive_call then
      -- Javascript um rekursiv erzeugtes JavaScript erweitern
      l_js_action := l_js_action || process_rule;
    end if;
    
    pit.leave_mandatory;
    return l_js_action;
  end process_rule;  
    
  
  /* Hilfsprozedur zum Registrieren von Elemente, die durch das Plugin im Session State
   * geaendert wurden. Diese Elemente werden anschliessend in der Antwort im Browser
   * auf den aktuellen Wert gesetzt.
   */
  procedure register_item(
    p_item in varchar2,
    p_allow_recursion in number)
  as
    l_has_rule number;
  begin
    pit.enter_mandatory('register_item', C_PKG);
    -- Vermerke, dass p_item an den Browser gesendet werden muss
    push_page_item(p_item);
    
    if p_allow_recursion = sct_const.c_true then
      -- Ermittle, ob p_item in Regeln referenziert wird. Falls ja, rekursiven Aufruf speichern
      select count(*)
        into l_has_rule
        from dual
       where exists(
             select 1
               from sct_page_item
              where spi_id = p_item     
                -- Element ist relevant  
                and spi_is_required = sct_const.c_true
                -- und ruft sich nicht selbst auf
                and p_item != coalesce(g_param.firing_item, 'FOO'));
                
      if l_has_rule > 0 then   
        if g_param.recursive_level <= g_recursion_limit then
          if not g_param.recursive_stack.exists(p_item) then
            -- Element wurde rekursiv noch nicht aufgerufen, vermerken
            g_param.recursive_stack(p_item) := g_param.recursive_level;
          else
            -- Schleife in Rekursion
            if g_recursion_loop_is_error then
              register_error(p_item, msg.SCT_RECURSION_LOOP, msg_args(p_item, to_char(g_param.recursive_level)));
            else
              register_notification(msg.SCT_RECURSION_LOOP, msg_args(p_item, to_char(g_param.recursive_level)));
            end if;
          end if;
        else
          register_error(p_item, msg.SCT_RECURSION_LIMIT, msg_args(p_item, to_char(g_recursion_limit)));
        end if;
      end if;
    end if;
    pit.leave_mandatory;
  end register_item;
  
  
  /* Hilfsfunktion ermittelt den Standard-Meldungstext, wenn ein verpflichtendes Feld
   * nicht ausgefuellt wurde, falls dieser nicht ueberschrieben wurde
   */
  function get_mandatory_message(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2)
    return varchar2
  as
    l_mandatory_message sct_page_item.spi_mandatory_message%type;
  begin
    if p_spi_mandatory_message is null then
      select pit.get_message_text(msg.SCT_ITEM_IS_MANDATORY, msg_args(label))
        into l_mandatory_message
        from apex_application_page_items aai
        join sct_rule_group sgr
          on aai.application_id = sgr.sgr_app_id 
         and page_id = sgr.sgr_page_id
         and item_name = p_spi_id
       where sgr.sgr_id = g_param.sgr_id;
    else
      l_mandatory_message := p_spi_mandatory_message;
    end if;
    return l_mandatory_message;
  end get_mandatory_message;

  
  /* Methode fuehrt Initialisierungscode aus falls in Regelgruppe vorhanden
   */
  procedure process_initialization_code
  as
    l_initialization_code sct_rule_group.sgr_initialization_code%type;
  begin
    select sgr_initialization_code
      into l_initialization_code
      from sct_rule_group
     where sgr_id = g_param.sgr_id;
  
    if l_initialization_code is not null then
      execute immediate l_initialization_code;
    end if;
  exception
    when no_data_found then
      null;
  end process_initialization_code;
  

  function process_request
    return varchar2
  as
    l_js_action varchar2(32767);
    l_js_script varchar2(32767);
    l_json_items varchar2(32767);
    l_json_errors varchar2(32767);
  begin      
      -- Bereite Anwort als JS vor
      l_js_action := coalesce(process_rule, get_comment(msg.SCT_NO_JAVASCRIPT, msg_args('0')));
      l_json_items := get_json_from_items;
      l_json_errors := get_json_from_errors;
      l_js_script := utl_text.bulk_replace(C_JS_ACTION_TEMPLATE, char_table(
        '~', sct_const.c_cr,
        '#ITEM_JSON#', l_json_items,
        '#ERROR_JSON#',  l_json_errors,
        '#FIRING_ITEMS#', join_list(g_param.firing_items),
        '#JS_FILE#', sct_const.c_js_namespace));
      l_js_script := replace(l_js_script, '#CODE#', l_js_action);
    return l_js_script;
  end process_request;
  
  
  procedure initialize
  as
  begin
    g_recursion_loop_is_error := param.get_boolean('RAISE_RECURSION_LOOP', C_PARAM_GROUP);
    g_recursion_limit := param.get_integer('RECURSION_LIMIT', C_PARAM_GROUP);
  end initialize;
  
  
  /* INTERFACE */
  procedure stop_rule
  as
  begin
    pit.enter_mandatory('stop_rule', C_PKG);
    
    g_param.stop_flag := true;
    
    pit.leave_mandatory;
  end stop_rule;
  
  
  procedure register_error(
    p_spi_id in varchar2,
    p_error_msg in varchar2,
    p_internal_error in varchar2 default null)
  as
    l_error apex_error.t_error;  -- APEX-Fehler-Record
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, instr(sqlerrm, ':', 1) + 2);
  begin
    pit.enter_mandatory('register_error', C_PKG);
    
    push_firing_item(p_spi_id);
    l_error.message := p_error_msg;
    
    if l_error.message is not null then
      l_error.page_item_name := p_spi_id;
      l_error.additional_info := coalesce(p_internal_error, replace(dbms_utility.format_error_backtrace, chr(10), '<br/>'));
      g_param.error_stack(g_param.error_stack.count + 1) := l_error;
    end if;
    
    pit.leave_mandatory;
  end register_error;
  
  
  procedure register_error(
    p_spi_id in varchar2,
    p_message_name in varchar2,
    p_arg_list in msg_args default null)
  as
    l_message message_type;
    l_error apex_error.t_error;  -- APEX-Fehler-Record
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, instr(sqlerrm, ':', 1) + 2);
  begin
    pit.enter_mandatory('register_error', C_PKG);
    
    push_firing_item(p_spi_id);
    l_message := message_type(
                   p_message_name => p_message_name,
                   p_message_language => null,
                   p_affected_id => p_spi_id,
                   p_session_id => null,
                   p_user_name => v('APP_USER'),
                   p_arg_list => p_arg_list);
    
    if l_message.message_text is not null then
      l_error.message := l_message.message_text;
      l_error.page_item_name := l_message.affected_id;
      l_error.additional_info := replace(l_message.backtrace, chr(10), '<br/>');
      g_param.error_stack(g_param.error_stack.count + 1) := l_error;
    end if;
    
    pit.leave_mandatory;
  end register_error;
  
  
  procedure register_notification(
    p_text in varchar2)
  as
    c_comment constant varchar2(10) := sct_const.C_CR || '  // ';
  begin
    pit.enter_mandatory('register_notification', C_PKG);
    
    utl_text.append(g_param.notification_stack, C_COMMENT || p_text);
    
    pit.leave_mandatory;
  end register_notification;
  
  
  procedure register_notification(
    p_message_name in varchar2,
    p_arg_list in msg_args)
  as
  begin
    register_notification(pit.get_message_text(p_message_name, p_arg_list));
  end register_notification;
  
  
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean)
  as
    l_is_mandatory sct_page_item.spi_is_mandatory%type;
    l_mandatory_message sct_page_item.spi_mandatory_message%type;
    l_label varchar2(100 char);
  begin
    pit.enter_mandatory('register_mandatory', C_PKG);
    pit.assert_not_null(g_param.sgr_id);
    
    if p_is_mandatory then 
      l_is_mandatory := sct_const.C_TRUE;
      l_mandatory_message := get_mandatory_message(p_spi_id, p_spi_mandatory_message);
    else 
      l_is_mandatory := sct_const.C_FALSE;
      l_mandatory_message := null;
    end if;
    
    update sct_page_item
       set spi_is_required = greatest(spi_is_required, l_is_mandatory),
           spi_is_mandatory = l_is_mandatory,
           spi_mandatory_message = l_mandatory_message
     where spi_sgr_id = g_param.sgr_id
       and spi_id = p_spi_id;
    if sql%rowcount = 0 then
      raise msg.SCT_ITEM_DOES_NOT_EXIST_ERR;
    end if;
    
    pit.leave_mandatory;
  end register_mandatory;
  
  
  procedure check_mandatory(
    p_firing_item in sct_page_item.spi_id%type)
  as
    l_message sct_page_item.spi_mandatory_message%type;
  begin
    pit.enter_mandatory('check_mandatory', C_PKG);
    
    -- Die Abfrage registriert eine Fehlermeldung, wenn
    -- - Das Element aktuell Pflichtfeld ist
    -- - Das Element keinen Wert im Session State besitzt
    select spi_mandatory_message
      into l_message
      from sct_page_item
     where spi_id = p_firing_item
       and spi_sgr_id = g_param.sgr_id
       and spi_is_mandatory = sct_const.c_true
       and (select v(p_firing_item) from dual) is null;
    register_error(p_firing_item, l_message, '');
    
    pit.leave_mandatory;
  exception
    when no_data_found then
      -- Pflichtfeld hat einen Wert, registrieren um eventuelle Fehlermeldung zu entfernen
       push_firing_item(p_firing_item);
      pit.leave_mandatory;
    when too_many_rows then 
      htp.p(sqlerrm);
  end check_mandatory;
  
  
  procedure submit_page
  as
    cursor mandatory_items(p_sgr_id in sct_rule_group.sgr_id%type) is
      select spi_id, spi_mandatory_message
        from sct_page_item
       where spi_sgr_id = p_sgr_id
         and spi_is_mandatory = sct_const.c_true;
  begin
    pit.enter_mandatory('submit_page', C_PKG);
    
    for itm in mandatory_items(g_param.sgr_id) loop
      -- Registriere alle Pflichtfelder, damit eventuelle Fehlermeldungen korrekt entfernt werden
      push_firing_item(itm.spi_id);
      if v(itm.spi_id) is null then
        -- Pflichtfeld hat keinen Sessionstatus, Fehler werfen
        register_error(itm.spi_id, itm.spi_mandatory_message, '');
      end if;
    end loop;
    
    pit.leave_mandatory;
  end submit_page;
  
  
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in number default sct_const.c_true)
  as
  begin
    pit.enter_mandatory('set_session_state', C_PKG);

    register_item(p_item, p_allow_recursion);
    apex_util.set_session_state(p_item, p_value);
    register_notification(msg.SCT_SESSION_STATE_SET, msg_args(p_item, p_value));
    
    pit.leave_mandatory;
  end set_session_state;
  
    
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in date,
    p_allow_recursion in number default sct_const.c_true)
  as
  begin
    pit.enter_mandatory('set_session_state', C_PKG);
    
    register_item(p_item, p_allow_recursion);
    apex_util.set_session_state(p_item, p_value);
    register_notification(msg.SCT_SESSION_STATE_SET, msg_args(p_item, to_char(p_value)));
    
    pit.leave_mandatory;
  end set_session_state;
  
    
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in number,
    p_allow_recursion in number default sct_const.c_true)
  as
  begin
    pit.enter_mandatory('set_session_state', C_PKG);
    
    register_item(p_item, p_allow_recursion);
    apex_util.set_session_state(p_item, p_value);
    register_notification(msg.SCT_SESSION_STATE_SET, msg_args(p_item, to_char(p_value)));
    
    pit.leave_mandatory;
  end set_session_state;
  
  
  procedure set_session_state_or_error(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_error in varchar2,
    p_allow_recursion in number default sct_const.c_true)
  as
  begin
    pit.enter_mandatory('set_session_state_or_error', C_PKG);
    
    if p_error is not null then
      register_error(p_item, p_error, '');
    else
      set_session_state(p_item, p_value, p_allow_recursion);
    end if;
    
    pit.leave_mandatory;
  end set_session_state_or_error;


  procedure set_value_from_stmt(
    p_item in sct_page_item.spi_id%type,
    p_stmt in varchar2)
  as
    c_stmt constant varchar2(200) := 'select to_char(value) from (#STMT#)';
    l_stmt varchar2(32767);
    l_result varchar2(4000);
  begin
    pit.enter_mandatory('set_value_from_stmt', C_PKG);
    
    l_stmt := replace(c_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_result;
    set_session_state(p_item, l_result, sct_const.c_true);
    
    pit.leave_mandatory;
  exception
    when others then
      register_notification(msg.SCT_NO_DATA_FOR_ITEM, msg_args(p_item));
      set_session_state(p_item, '', sct_const.c_true);
      pit.leave_mandatory;
  end set_value_from_stmt;
    
    
  procedure set_list_from_stmt(
    p_item in sct_page_item.spi_id%type,
    p_stmt in varchar2)
  as
    c_stmt constant varchar2(200) := q'~select listagg(value, ':') within group (order by value) from (#STMT#)~';
    l_stmt varchar2(32767);
    l_result varchar2(4000);
  begin
    pit.enter_mandatory('set_list_from_stmt', C_PKG);
    
    l_stmt := replace(c_stmt, '#STMT#', p_stmt);
    execute immediate l_stmt into l_result;
    set_session_state(p_item, l_result, sct_const.c_true);
    
    pit.leave_mandatory;
  end set_list_from_stmt;
  
  
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result
  as
    l_result apex_plugin.t_dynamic_action_render_result;
  begin
    pit.enter_mandatory('render', C_PKG);
    g_param.now := dbms_utility.get_time;
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    read_settings(p_dynamic_action);
    -- Registriere DOCUMENT auf Rekursionebene 1
    g_param.recursive_stack(sct_const.C_NO_FIRING_ITEM) := 1;
    
    l_result.javascript_function := sct_const.c_js_function;
    l_result.ajax_identifier := apex_plugin.get_ajax_identifier; 
    
    process_initialization_code;
    
    -- Methode GET_JSON_FROM_BIND_ITEMS registriert beim Initialisieren auch PAGE_ITEMS
    l_result.attribute_01 := get_json_from_bind_items;
    l_result.attribute_02 := join_list(g_param.page_items);
    l_result.attribute_03 := p_plugin.attribute_01;
    l_result.attribute_04 := utl_raw.cast_to_raw(process_request);
    
    g_param := null;
    pit.leave_mandatory;
    return l_result;
  end render;
  

  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result
  as
    l_result apex_plugin.t_dynamic_action_ajax_result;
  begin
    pit.enter_mandatory('ajax', C_PKG);
    
    if wwv_flow.g_debug then
      apex_plugin_util.debug_dynamic_action(
        p_plugin => p_plugin,
        p_dynamic_action => p_dynamic_action);
    end if;
    
    -- Initialisieren
    read_settings(p_dynamic_action);
    g_param.now := dbms_utility.get_time;
    g_param.stop_flag := false;
    
    -- Registriere FIRING_ELEMENT auf Rekursionebene 1
    g_param.recursive_stack(g_param.firing_item) := 1;
    
    -- Returniere Ergebnis der Regelpruefung
    htp.p(process_request);
    
    g_param := null;
    pit.leave_mandatory;
    return l_result;
  end ajax;
  
begin
  initialize;
end plugin_sct;
/
