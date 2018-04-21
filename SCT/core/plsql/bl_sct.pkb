create or replace package body bl_sct 
as

  /* Weitere Konstanten siehe SCT_CONST */
  C_PKG constant varchar2(30 byte) := $$PLSQL_UNIT;
  C_PARAM_GROUP constant varchar2(30 byte) := 'SCT';
  
  /* Globale Variablen */
  -- Fehlerstack
  type error_stack_t is table of apex_error.t_error index by binary_integer;
  
  -- Element-Stack
  type item_stack_t is table of number index by varchar2(50);
  
  -- Ausgabe-Atack
  type javascript_stack_t is table of varchar2(32767) index by binary_integer;
  
  -- Rekursionsstack
  -- Der Rekursionsstack speichert die Seitenelemente, die durch die Regeln geaendert wurden,
  -- um anschließend auch fuer diese Elemente die Regelpruefung aufzurufen.
  type recursive_stack_t is table of number index by sct_page_item.spi_id%type;
  
  type param_rec is record(
    id number,                              -- Interne ID des Records, falls n Instanzen aufgerufen werden
    sgr_id sct_rule_group.sgr_id%type,      -- ID der Regelgruppe
    allow_group_recursion boolean,          -- Flag, das anzeigt, ob Rekursion fuer diese Regelgruppe erlaubt ist
    allow_recursion boolean,                -- Flag, das anzeigt, ob aktuell Rekursion erlaubt ist
    recursive_stack recursive_stack_t,      -- Liste der rekursiven Elemente, die geprueft werden sollen
    recursive_level number,                 -- Aktuelle Ebene der Rekursion, die bearbeitet wird
    bind_items item_stack_t,                -- Liste der Elemente, deren Events gebunden werden
    page_items item_stack_t,                -- Liste der Elemente, deren Wert sich im Session State veraendert hat
    error_stack error_stack_t,              -- Liste der Fehler, die bislang aufgelaufen sind
    error_dependent_buttons varchar2(2000), -- Liste der Buttons, die im Fehlerfall deaktiviert werden
    firing_item sct_page_item.spi_id%type,  -- Element das die Bearbeitung ausloest (oder DOCUMENT)
    firing_items item_stack_t,              -- Liste der Elemente, die mit FIRING_ITEM durch Regeln verbunden sind
    js_stack javascript_stack_t,            -- Ausgabestack fuer alle JavaScript-Elemente (inkl. Kommentare)
    stop_flag boolean,                      -- Wenn dieses Flag gesetzt wird, stoppt die Weiterverarbeitung der Regel
    now pls_integer,                        -- Zeitstempel dieser Regelgruppe, wird zum Stoppen der Ausfuehrungsdauer verwendet
    with_comments boolean                   -- */
  );
  
  g_param param_rec;
  
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

  g_stop_flag boolean;
  g_firing_item varchar2(30 byte);
  g_has_errors boolean;
  g_comment_level number;
  g_recursion_limit binary_integer;
  g_recursion_loop_is_error boolean;
  
  g_dynamic_javascript varchar2(32767);
  

  /* Hilfsfunktionen */
  procedure register_error(
    p_item in sct_page_item.spi_id%type,
    p_message in pit_message.pms_name%type,
    p_msg_args in msg_args)
  as
  begin
    null;
  end register_error;
  
  
  /* Stackverwaltung, legt ein Seitenelement auf den Elementestack
   * %param p_stack Stack, auf den das Element gelegt werden soll
   * %param p_item_name Name des Seitenelements, das auf den Stack gelegt werden soll
   * %usage Wird verwendet, um Elementlisten fuer Seitenelemente zu pflegen
   */
  procedure push_item(
    p_stack in out nocopy item_stack_t,
    p_item_name in sct_page_item.spi_id%type)
  as
  begin
    if not p_stack.exists(p_item_name) then
      p_stack(p_item_name) := 1;
    end if;
  end push_item;
  
  
  /* Stackverwaltung, legt ein feuerndes Element auf den Elementestack
   * %param p_item_name Name des Seitenelements, das auf den Stack gelegt werden soll
   * %usage Wird verwendet, um Elementlisten fuer aufrufende Elemente zu pflegen
   */
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
  
  
  procedure push_js_stack(
    p_text in varchar2)
  as    
    c_delimiter constant varchar2(10) := sct_const.c_cr || '  ';
  begin
    if p_text is not null then
      g_param.js_stack(g_param.js_stack.count + 1) := c_delimiter || p_text;
    end if;
  end push_js_stack;
  
  
  function stack_to_clob
    return clob
  as
    l_chunk varchar2(32767);
    l_clob clob;
  begin
    l_clob := sct_const.C_JS_ACTION_START;
    for i in g_param.js_stack.first .. g_param.js_stack.last loop
      if length(l_chunk || g_param.js_stack(i)) < 32767 then
        l_chunk := l_chunk || g_param.js_stack(i);
      else
        dbms_lob.append(l_clob, l_chunk || g_param.js_stack(i));
        l_chunk := null;
      end if;
    end loop;
    dbms_lob.append(l_clob, l_chunk || replace(sct_const.C_JS_ACTION_END, '#JS_FILE#', sct_const.c_js_namespace));
    return l_clob;
  end stack_to_clob;

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
    -- lokale Konstanten
    C_NUMBER_ITEM constant sct_page_item_type.sit_id%type := 'NUMBER_ITEM';
    C_DATE_ITEM constant sct_page_item_type.sit_id%type := 'DATE_ITEM';
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
          l_number_val := to_number(v(g_param.firing_item), replace(l_spi_conversion, 'G'));
          
          -- Konvertierung erfolgreich, setze formatierten String in Session State
          set_session_state(g_param.firing_item, to_char(l_number_val, l_spi_conversion), sct_const.c_true, null);
        exception
          when msg.SCT_INVALID_FORMAT_ERR then
            register_error(g_param.firing_item, msg.SCT_EXPECTED_FORMAT, msg_args(l_spi_conversion));
          when others then
            register_error(g_param.firing_item, msg.SCT_GENERIC_ERROR, msg_args(substr(sqlerrm, instr(sqlerrm, ':', 1) + 2)));
        end;
      when C_DATE_ITEM then
        begin
          -- Konvertiere in Datum
          l_date_val := to_date(v(g_param.firing_item), l_spi_conversion, 'G');
          -- Konvertierung erfolgreich, setze formatierten String in Session State
          set_session_state(g_param.firing_item, to_char(l_date_val, l_spi_conversion), sct_const.c_true, null);
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
  
  
  /* Hilfsprozedur zum Zusammenfuehren einer Liste von Werten des Item-Stacks in eine
   * Liste, getrennt durch SCT_CONST.C_DELIMITER
   * %param p_list Liste der Werte, die zusammenfuehrt werden sollen
   * %return Zeichenkette mit den zusammengefuehrten Elementen
   * %usage Wird verwendet, um eine Liste von Werten zur Uebergabe an die JSON-Antwort
   *        zu generieren.
   */
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
  
  
  function get_json_from_items
    return varchar2
  as
    l_json varchar2(32767);
    l_item varchar2(50);
  begin
    pit.enter_optional('get_json_from_items', C_PKG);
    
    push_js_stack(' ');
    notify(msg.SCT_STANDARD_JS, msg_args('FOO'));
    l_item := g_param.page_items.first;
    while l_item is not null loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(sct_const.c_page_json_element, char_table(
          '#ID#', l_item,
          '#VALUE#', htf.escape_sc(v(l_item)))),
        sct_const.c_delimiter, sct_const.C_YES);
      l_item := g_param.page_items.next(l_item);
    end loop;
    
    l_json := utl_text.bulk_replace(
                sct_const.c_set_item_json_template, char_table(
                  '#JS_FILE#', sct_const.c_js_namespace,
                  '#JSON#', l_json));
    
    pit.leave_optional;
    return l_json;
  end get_json_from_items;
  
  
  /* Hilfsfunktion zum Zusammenstellen aller registrierter Fehlermeldungen zu einem
   * JSON-Objekt, das als Teil der Antwort an den Browser gesendet wird.
   * %return Zeichenkette im Format JSON mit allen aufgetretenen Fehlermeldungen
   * %usage Wird verwendet, um fuer die Antwort des Plugins eine Fehlerliste zu erstellen
   */
  function get_json_from_errors
    return varchar2
  as
    l_json varchar2(32767);
    l_location varchar2(50 char);
  begin
    pit.enter_optional('get_json_from_errors', C_PKG);
    for i in 1 .. g_param.error_stack.count loop
      if g_param.error_stack(i).page_item_name = sct_const.c_no_firing_item then
        l_location := '"page"';
      else
        l_location := '["inline","page"]';
      end if;
      utl_text.append(
        l_json,
        utl_text.bulk_replace(sct_const.c_error_json_element, char_table(
          '#ITEM#', g_param.error_stack(i).page_item_name,
          '#MESSAGE#', htf.escape_sc(g_param.error_stack(i).message),
          '#LOCATION#', l_location,
          '#INFO#', htf.escape_sc(g_param.error_stack(i).additional_info))),
        sct_const.c_delimiter, sct_const.C_YES);
    end loop;
    l_json := utl_text.bulk_replace(sct_const.c_error_json_template, char_table(
                '#JS_FILE#', sct_const.c_js_namespace,
                '#COUNT#', g_param.error_stack.count,
                '#DEPENDENT_BUTTONS#', g_param.error_dependent_buttons,
                '#FIRING_ITEMS#', join_list(g_param.firing_items),
                '#ERRORS#', l_json));
                
    pit.leave_optional;
    return l_json;
  end get_json_from_errors;
  
  
  /* Hilfsfunktion ermittelt den Standard-Meldungstext, wenn ein verpflichtendes Feld
   * nicht ausgefuellt wurde, falls dieser nicht ueberschrieben wurde
   * %param p_spi_id ID des Seitenelements
   * %param p_spi_mandatory_message Optional in der Regel festgelegte Meldung bei
   *        leeren Elementen
   * %return Fehlermeldung fuer verpflichtendes Element
   * %usage Stellt sicher, dass ein Meldungstext fuer ein verpflichtendes Element
   *        ausgegeben wird, wenn dieses leer ist. Ist keine Meldung definiert, wird
   *        eine Standardmeldung fuer dieses Element ausgegeben.
   */
  function get_mandatory_message(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2)
    return varchar2
  as
    l_mandatory_message sct_page_item.spi_mandatory_message%type;
  begin
    if p_spi_mandatory_message is null and p_spi_id != sct_const.c_no_firing_item then
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
  
  
  procedure push_error(
    l_error in apex_error.t_error)
  as
  begin
    g_param.error_stack(g_param.error_stack.count + 1) := l_error;
    bl_sct.set_error_flag;
  end push_error;
  
  
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
  
  
  procedure execute_pl_sql_code(
    l_rule in out nocopy rule_rec)
  as
  begin
    if l_rule.pl_sql is not null then
      l_rule.pl_sql := utl_text.bulk_replace(sct_const.c_plsql_template, char_table(
                         '#PLSQL#', rtrim(l_rule.pl_sql, ';'),
                         '#ATTRIBUTE#', l_rule.sra_attribute,
                         '#ATTRIBUTE_2#', l_rule.sra_attribute_2,
                         '#ALLOW_RECURSION#', check_recursion(l_rule),
                         '#ITEM_VALUE#', sct_const.c_plsql_item_value_template,
                         '#ITEM#', l_rule.item,
                         '#CR#', sct_const.c_cr));
      execute immediate l_rule.pl_sql;
    end if;
  end execute_pl_sql_code;
  

  function get_firing_items(
    p_firing_item in varchar2)
    return varchar2
  as
    l_firing_items varchar2(32767);
  begin
    pit.enter_mandatory('get_firing_items', C_PKG);
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
  
  
  /* Initialisierungsmethode des Packages */
  procedure initialize
  as
  begin
    g_recursion_loop_is_error := param.get_boolean('RAISE_RECURSION_LOOP', C_PARAM_GROUP);
    g_recursion_limit := param.get_integer('RECURSION_LIMIT', C_PARAM_GROUP);
  end initialize;
    
  
  /* Hilfsprozedur zum Registrieren von Elemente, die durch das Plugin im Session State
   * geaendert wurden. Diese Elemente werden anschliessend in der Antwort im Browser
   * auf den aktuellen Wert gesetzt.
   * %param p_item Name des Elements, das als geandert registriert werden soll
   * %param p_allow_recursion Flag, das anzeigt, ob die Veraenderung dieses Elements
   *        die Regelberechnung rekursiv ausloesen soll
   * %usage Wird verwendet, um zu registrieren, dass ein Seitenelement durch SCT im
   *        Sessionstatus veraendert wurde. Dadurch wird der aktualisierte Elementwert
   *        in die JSON-Antwort aufgenommen und auf der Oberflaeche aktualisiert
   */
  procedure register_item(
    p_item in varchar2,
    p_allow_recursion in number default sct_const.c_true)
  as
    l_has_rule number;
  begin
    pit.enter_mandatory('register_item', C_PKG);
    -- Vermerke, dass p_item an den Browser gesendet werden muss
    push_item(g_param.page_items, p_item);
    
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
              notify(msg.SCT_RECURSION_LOOP, msg_args(p_item, to_char(g_param.recursive_level - 1)));
            end if;
          end if;
        else
          register_error(p_item, msg.SCT_RECURSION_LIMIT, msg_args(p_item, to_char(g_recursion_limit)));
        end if;
      end if;
    end if;
    pit.leave_mandatory;
  end register_item;
  
  
  /* Methode zum Registrieren einer neuen Rekursion */
  procedure register_recursion(
    p_rule in rule_rec)
  as
    l_origin_msg varchar2(200);
  begin
    if g_comment_level >= 40 and p_rule.is_first_row = sct_const.c_true then
      -- Integriere Kommentar fuer ersten Regelaufruf
      if p_rule.sru_fire_on_page_load = sct_const.c_true then
        l_origin_msg := msg.SCT_INIT_ORIGIN;
      else
        l_origin_msg := msg.SCT_RULE_ORIGIN;
      end if;
      push_js_stack(' '); -- Leerzeile oberhalb einer neuen Rekursion
      notify(l_origin_msg, msg_args(
        to_char(g_param.recursive_level - 1),
        to_char(p_rule.sru_sort_seq), 
        p_rule.sru_name,
        g_firing_item));
    end if;
  end register_recursion;
  

  /* Prozedur stellt JavaScript-Code aus der Regel zusammen und platziert in im 
   * JavaScript-Stack
   * %param p_rule Instanz der Regelabfrage
   */
  procedure prepare_js_code(
    p_rule in rule_rec)
  as
    c_delimiter constant varchar2(10) := sct_const.c_cr || '  ';
  begin
    pit.enter_optional('prepare_js_code', c_pkg);
      
    if p_rule.js is not null then
      -- JavaScript formatieren und auf Stack legen
      push_js_stack(
        utl_text.bulk_replace(p_rule.js, char_table(
          sct_const.c_cr, c_delimiter,
          '#ITEM_VALUE#', sct_const.c_js_item_value_template,
          '#ITEM#', p_rule.item,
          '#SELECTOR#', case p_rule.item when sct_const.c_no_firing_item then p_rule.sra_attribute_2 else p_rule.item end,
          '#ATTRIBUTE#', p_rule.sra_attribute,
          '#ATTRIBUTE_2#', p_rule.sra_attribute_2)));
    end if;
    
  end prepare_js_code;
  
  
  /* Prozedur erzeugt eine Antwort auf eine gegebene Situation im Session State 
   * fuer eine Regelgruppe
   * %param p_sgr_id ID der Regelgruppe, die ausgewertet werden soll
   * %param p_is_recursive Flag, das anzeigt, ob die Regel rekursiv aufgerufen wurde
   * %usage Wird aus dem Plugin SCT aufgerufen, um fuer eine gegebene Seitensituation
   *        (die vorab im Session State hinterlegt wurde) die passende Regel zu
   *        finden und aus dieser Handlungsanweisungen fuer die weitere Bearbeitung
   *        abzuleiten.
   */
  procedure create_action(
    p_is_recursive in number,
    p_elapsed out varchar2) 
  as
    l_rule rule_rec;
    l_action_cur sys_refcursor;

    l_stmt varchar2(32767);
  begin
    pit.enter_mandatory('create_action', C_PKG);
    
    -- Setze Fehlerflag zurueck
    g_has_errors := false;
    
    -- Lade Regel-SQL fuer angeforderte Regelgruppe
    l_stmt := utl_text.bulk_replace(sct_const.c_stmt_template, char_table(
                '#RULE_VIEW#', sct_const.c_view_name_prefix || g_param.sgr_id,
                '#IS_RECURSIVE#', p_is_recursive));

    -- Explizite Cursorkontrolle wegen dynamischen SQLs
    open l_action_cur for l_stmt;
    fetch l_action_cur into l_rule;  -- Hier wird die Regel evaluiert

    while l_action_cur%FOUND loop
      
      register_recursion(l_rule);
      
      -- PL/SQL-Code wird direkt ausgefuehrt
      execute_pl_sql_code(l_rule);
      
      -- Beim ersten Fehlerhandler: Pruefe, ob Fehler aufgetreten sind und fahre mit Fehleraktionen fort
      if l_rule.sra_on_error = sct_const.c_true and g_has_errors then
        notify(msg.SCT_ERROR_HANDLING, msg_args(to_char(l_rule.sru_sort_seq), l_rule.sru_name, g_firing_item));
      else
        -- alle Nicht-Fehler-Handler ausgefuehrt und keine Fehler aufgetreten, Aktion beenden
        null; --exit;
      end if;
      
      -- Aktuelle Aktion verarbeiten
      prepare_js_code(l_rule);
      
      -- Naechste Aktion bearbeiten
      fetch l_action_cur into l_rule;
    end loop;

    close l_action_cur;
     
    -- Stoppe die verstrichene Zeit (kumulativ)    
    p_elapsed := coalesce(dbms_utility.get_time - g_param.now, 0) || 'hsec'; 
    
    pit.leave_mandatory;
  end create_action;
  
  
  /* Funktion wertet die Regel der angeforderten Regelgruppe aus
   * %return HTML-Script mit den Javascript-Anweisungen fuer die clientseitige
   *         Verarbeitung
   * %usage Wird durch das Plugin beim Refresh aufgerufen
   *        - Erstellt einen PL/SQL-Skript, der sofort ausgefuehrt wird
   *        - Erstellt einen JavaScript-Skript, der zurueckgeliefert wird
   *        - Analysiert, ob Regel rekursive Ausfuehrung erfordert und ruft
   *          sich selbst mit den rekursiven Regeln auf
   */
  procedure process_rule
  as
    l_firing_items sct_rule.sru_firing_items%type;
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
    -- Wird benoetigt, um »breadth first« zu arbeiten: Alle Rekursionsaufrufe einer Ebene, danach die naechste Ebene etc.
    g_param.recursive_level := l_actual_recursive_level + 1;
    -- is_recursive wird verwendet, um Aktionen, die nicht rekursiv ausgefuehrt werden sollen, auszusondern
    -- TODO: Das funktioniert so nicht
    -- g_param.allow_recursion := l_actual_recursive_level = sct_const.c_true;
    l_is_recursive := least(l_actual_recursive_level, 1);
    g_dynamic_javascript := null;
    
    -- Iteriere ueber Rekursionsstack
    g_param.firing_item := g_param.recursive_stack.first;
    -- Stelle ausloesendes Element fuer SQL ueber Get-Methode zur Verfuegung
    g_firing_item := g_param.firing_item;
    
    while g_param.firing_item is not null loop
      begin
        --  fuehre alle »Events« auf aktuellem Rekursionslevel aus
        if g_param.recursive_stack(g_param.firing_item) = l_actual_recursive_level then
          -- Speichere Name des Elements zum spaeteren Loeschen des Elements aus dem Rekursionsstack
          l_processed_item := g_param.firing_item;
          l_needs_recursive_call := true;
          
          -- Session State auswerten und neue Aktion berechnen,PL/SQL-Code wird durch den Aufruf bereits ausgefuehrt
          create_action(
            p_is_recursive => l_is_recursive,
            p_elapsed => l_elapsed);     
          
          -- Dynamisch erzeugtes JavaScript dieser Ebene hinzufuegen
          if g_dynamic_javascript is not null then
            push_js_stack(
              utl_text.bulk_replace(sct_const.c_dynamic_js_code_template, char_table(
                '#CODE#', g_dynamic_javascript)));
            g_dynamic_javascript := null;
          end if;
          
          -- Ausgabe erstellen und geaenderte Elemente merken
          push_firing_item(l_firing_items);
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
          register_error(sct_const.c_no_firing_item, substr(sqlerrm, 11), msg_args());
          g_param.recursive_stack.delete;
          exit;
      end;
    end loop;
    
    -- Rekursion, endet, wenn keine weiteren Aktivitaeten registriert wurden
    if l_needs_recursive_call then
      -- Rekursion bearbeiten
      process_rule;
    end if;
    
    pit.leave_mandatory;
  end process_rule;  
  

  /* INTERFACE */
  -- GETTER / SETTER
  function get_stop_flag
    return boolean
  as
  begin
    return g_stop_flag;
  end get_stop_flag;
  
  
  procedure set_stop_flag
  as
  begin
    g_stop_flag := true;
  end set_stop_flag;
  
  
  function get_firing_item
    return varchar2
  as
  begin
    return coalesce(g_firing_item, sct_const.c_no_firing_item);
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
  
  
  function get_comment_level
    return number
  as
  begin
    return greatest(g_comment_level, case when apex_application.g_debug then 40 else 10 end);
  end get_comment_level;
  
  
  procedure set_comment_level(
    p_level in number)
  as
  begin
    g_comment_level := p_level;
  end set_comment_level;
  
  
  function get_error_flag
    return boolean
  as
  begin
    return g_has_errors;
  end get_error_flag;
  
  
  procedure set_error_flag
  as
  begin
    g_has_errors := true;
  end set_error_flag; 

  
  -- Business Logic
  procedure initialize_call(
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_firing_item in sct_page_item.spi_id%type,
    p_error_dependent_items in varchar2)
  as    
    l_stmt varchar2(200 char);
    l_allow_recursion number;
  begin
    pit.enter_optional('initialize_call', C_PKG);
        
    -- Initialisierung der Kollektionen
    g_param.bind_items.delete;
    g_param.page_items.delete;
    g_param.firing_items.delete;
    g_param.error_stack.delete;
    g_param.js_stack.delete;

    -- Aufrufparameter
    g_param.error_dependent_buttons := p_error_dependent_items;
    g_param.firing_item := p_firing_item;
    g_stop_flag := false;
    
    -- Daten zur Regelgruppe lesen
    select sgr_id, coalesce(sgr_with_recursion, 1)
      into g_param.sgr_id, l_allow_recursion
      from sct_rule_group sgr
     where sgr_name = p_sgr_name
       and sgr_app_id = apex_application.g_flow_id;
    
    -- Rekursionsschalter uebernehmen
    g_param.allow_recursion := l_allow_recursion = sct_const.c_true;
    g_param.recursive_level := 1;
    
    -- Pruefe und formatiere das ausloesende Element
    format_firing_item;
    
    pit.leave_optional;
  exception
    when no_data_found then
      register_error(sct_const.c_no_firing_item, msg.SCT_RULE_DOES_NOT_EXIST, msg_args(p_sgr_name));
  end initialize_call;
  
  
  procedure process_initialization_code
  as
    l_initialization_code sct_rule_group.sgr_initialization_code%type;
  begin
    -- Registriere DOCUMENT auf Rekursionebene 1
    g_param.recursive_stack(sct_const.C_NO_FIRING_ITEM) := 1;
    
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
  
  
  function get_page_items
    return varchar2
  as
  begin
    return join_list(g_param.page_items);
  end get_page_items;
  
  
  function get_bind_items
    return varchar2
  as
    -- Liste relevanter Elemente, die einen Event binden sollen
    cursor rule_group_items(p_sgr_id sct_rule_group.sgr_id%type) is
      select distinct spi_id, sit_event, sit_has_value
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
    pit.enter_optional('get_bind_items', C_PKG);
    
    for item in rule_group_items(g_param.sgr_id) loop
      utl_text.append(
        l_json,
        utl_text.bulk_replace(sct_const.c_bind_json_element, char_table(
          '#ID#', item.spi_id,
          '#EVENT#', item.sit_event)),
        sct_const.c_delimiter, sct_const.C_YES);
      -- relevante Elemente mit Session State registrieren, damit beim initialen Aufruf
      -- die aktuellen Seitenwerte dieser Elemente übermittelt werden
      -- (diese Aufgabe uebernimmt anschliessend REGISTER_ITEM)
      if item.sit_has_value = 1 then
        push_item(g_param.page_items, item.spi_id);
      end if;
    end loop;
    
    -- Elemente werden mit '~' als Ersatz fuer '"' erzeugt, da APEX dieses Zeichen
    -- durch eine Escape-Sequenz maskiert. Andernfalls kann in JavaScript daraus 
    -- kein JSON-Objekt mehr erzeugt werden.
    l_json := utl_text.bulk_replace(
                sct_const.c_bind_json_template, char_table(
                  '#JSON#', l_json, 
                  '"', '~',
                  '#JS_FILE#', sct_const.c_js_namespace));
    
    pit.leave_optional;
    return l_json;
  end get_bind_items;
  

  function process_request
    return clob
  as
  begin      
    pit.enter_mandatory('process_request', c_pkg);
    -- Initialisieren
    g_param.now := dbms_utility.get_time;
    g_param.stop_flag := false;    
    
    -- Registriere FIRING_ELEMENT auf Rekursionebene 1
    g_param.recursive_stack(g_param.firing_item) := 1;
    
    -- Bereite Anwort als JS vor
    process_rule;
    push_js_stack(get_json_from_items);
    push_js_stack(get_json_from_errors);
    
    pit.leave_mandatory;
    return stack_to_clob;
  end process_request;
  
  
  procedure terminate_call
  as
  begin
    g_param.bind_items.delete;
    g_param.page_items.delete;
    g_param.firing_items.delete;
    g_param.error_stack.delete;
    g_param := null;
  end terminate_call;


  /* Methoden zur Implementierung von Aktionstypen-Funktionalitaet */
  procedure set_session_state(
    p_item in sct_page_item.spi_id%type,
    p_value in varchar2,
    p_allow_recursion in number default sct_const.c_true,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type default null)
  as
    l_item_list char_table;
  begin
    case
    when p_item != sct_const.c_no_firing_item then
      register_item(p_item, p_allow_recursion);
      apex_util.set_session_state(p_item, p_value);
      notify(msg.SCT_SESSION_STATE_SET, msg_args(p_item, p_value));
    when p_attribute_2 is not null then
      -- Lese alle Elemente, die durch diese Aktion betroffen sind
      l_item_list := bl_sct.get_firing_items(p_item, p_attribute_2);
      if l_item_list.count > 0 then
        for i in l_item_list.first .. l_item_list.last loop
          plugin_sct.set_session_state(l_item_list(i), p_value, p_allow_recursion, null);
        end loop;
      end if;
    else
      null;
    end case;
  end set_session_state;
  
  
  procedure register_mandatory(
    p_spi_id in sct_page_item.spi_id%type,
    p_spi_mandatory_message in varchar2,
    p_is_mandatory in boolean,
    p_attribute_2 in sct_rule_action.sra_attribute_2%type)
  as
    l_is_mandatory sct_page_item.spi_is_mandatory%type;
    l_mandatory_message sct_page_item.spi_mandatory_message%type;
    l_label varchar2(100 char);
    l_item_list char_table;
  begin
    pit.enter_mandatory('register_mandatory', C_PKG);
    pit.assert_not_null(g_param.sgr_id);    
    case
    when p_spi_id != sct_const.c_no_firing_item then
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
    when p_attribute_2 is not null then
      -- Lese alle Elemente, die durch diese Aktion betroffen sind
      l_item_list := bl_sct.get_firing_items(p_spi_id, p_attribute_2);
      if l_item_list is not null then
        for i in l_item_list.first .. l_item_list.last loop
          register_mandatory(
            p_spi_id => l_item_list(i), 
            p_spi_mandatory_message => p_spi_mandatory_message, 
            p_is_mandatory => p_is_mandatory,
            p_attribute_2 => null);
        end loop;
      end if;
    else
      null;
    end case;
  end register_mandatory;
  
  
  procedure check_mandatory(
    p_spi_id sct_page_item.spi_id%type default null)
  as
    cursor mandatory_items(
      p_sgr_id in sct_rule_group.sgr_id%type,
      p_spi_id in sct_page_item.spi_id%type) is
      select spi_id, spi_mandatory_message
        from sct_page_item
       where spi_sgr_id = p_sgr_id
         and (spi_id = p_spi_id or p_spi_id is null) 
         and spi_is_mandatory = sct_const.c_true;
  begin
    for itm in mandatory_items(g_param.sgr_id, p_spi_id) loop
      -- Registriere alle Pflichtfelder, damit eventuelle Fehlermeldungen korrekt entfernt werden
      push_firing_item(itm.spi_id);
      if v(itm.spi_id) is null then
        -- Pflichtfeld hat keinen Sessionstatus, Fehler werfen
        register_error(itm.spi_id, itm.spi_mandatory_message, msg_args());
      end if;
    end loop;
  end check_mandatory;
  
  
  procedure notify(
    p_text in varchar2)
  as
  begin
    if get_comment_level > 10 then
      push_js_stack(sct_const.C_COMMENT || p_text);
    end if;
  end notify;
  
  
  procedure notify(
    p_message in varchar2,
    p_msg_args in msg_args)
  as
    l_msg message_type;
    l_severity number;
  begin
    if get_comment_level > 10 then
      l_msg := pit_pkg.get_message(p_message, null, p_msg_args);
      l_severity := l_msg.severity;
      if get_comment_level >= l_msg.severity then
        if p_msg_args is not null then
          notify(pit.get_message_text(p_message, p_msg_args));
        else
          notify(pit.get_message_text(p_message));
        end if;
      end if;
    end if;
  end notify;
  
  
  procedure execute_javascript(
    p_plsql in varchar2)
  as
    l_result varchar2(32767);
  begin
    bl_sct.execute_javascript(p_plsql);
    execute immediate 'begin :x := ' || replace(p_plsql, ';') || '; end;' using out l_result;
    g_dynamic_javascript := g_dynamic_javascript || sct_const.C_CR || replace(l_result, 'javascript:');
  end execute_javascript;
  
  
  procedure register_error(
    p_error apex_error.t_error)
  as
    l_message message_type;
    l_error apex_error.t_error;  -- APEX-Fehler-Record
    l_sqlcode number := sqlcode;
    l_sqlerrm varchar2(2000) := substr(sqlerrm, instr(sqlerrm, ':', 1) + 2);
  begin
    pit.enter_mandatory('register_error', C_PKG);
    
    push_firing_item(p_error.page_item_name);
    
    if l_message.message_text is not null then
      l_error.message := l_message.message_text;
      l_error.page_item_name := l_message.affected_id;
      l_error.additional_info := replace(l_message.backtrace, chr(10), '<br/>');
      push_error(l_error);
    end if;
  end register_error;
  
begin
  initialize;
end bl_sct;
/
