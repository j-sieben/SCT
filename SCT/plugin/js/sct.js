// Namespace
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.sct = {};


/*!
  Plugin zur Steuerung komplexer APEX-Formulare
 */
/**
 * @fileOverview
 * Das Plugin delegiert die Berechnung des Status von Formularelementen einer APEX-Seite an die Datenbank.
 * Hierzu spricht es in der Datenbank eine Regelgruppe an, die Regeln enthält. Diese Regeln berechnen
 * den Status der Anwendungselemente der aktuellen Seite, basierend auf dem momentanen Sessionstatus.
 *
 * Das Plugin benötigt nur wenige Parameter:
 * ajaxIdentifier: APEX-generierter Identifier
 * bindItems: Liste von Seitenelementen, an die an Events gebunden wird. Die Liste wird durch die Datenbank
 *            berechnet (basierend auf den Einzelregeln) und als JSON-Objekt geliefert. Zu jedem Seitenelement
 *            wird die ID und der Event angegeben, der gebunden werden soll.
 * pageItems: Liste von Seitenelementen, deren aktueller Elementwert beim Auslösen eines Events auf einem
 *            gebundenen Element ausgelesen und an die Datenbank geschickt werden soll.
 *            Die Liste wird von der Datenbank berechnet und bei der Initialisierung vermerkt
 * ApexJS:    Objekt, das die Visualisierung von Pluginfunktionen auf der Oberfläche kapselt.
 *            Dieser Parameter wird als Application-Parameter des Plugins verwaltet und gestattet es, die JavaScript-
 *            Library, die für die Darstellung verwendet wird, einzustellen.
 *            Die konkrete Implementierung kann durch differierende Anforderungen, geänderte Templates oder sonstige
 *            Gründe nicht generisch definiert werden. Standardmäßig wird de.condes.plugin.sct.apex_42_5_0 verwendet.
 *            Details zu einer Überschreibung dieser Datei findet sich in der Dokumentation der Datei sctApex.js
 *            - submit
 *                Sendet die Seite ab, nachdem sichergestellt wurde, dass alle Pflichtfelder Werte enthalten
 *            - setMandatory
 *                Macht ein Seitenelement zum Pflicht- oder optionalen Feld, basierend auf einem booleschen Parameter
 *            - notify
 *                Zeigt eine Erfolgsmeldung
 *            - setErrors
 *                Zeigt Fehlermeldungen auf der Seite. Falls eine Fehlerregion existiert, werden die Fehlermeldungen
 *                hinzugefügt, anonsten wird eine Fehlerregion erstellt
 *            Wird eine eigene Implementierung vorgenommen, empfiehlt es sich, von der existierenden sctApex.js abzuleiten.
 *
 * Das Plugin wird auf der Seite als Dynamic Action zum Zeitpunkt PAGE_LOAD eingebunden.
 * Beim Einfügen wird der Name der referenzierten Regelgruppe angegeben sowie optional eine Liste von Seitenelementen,
 * die deaktiviert werden sollen, wenn ein Fehler auf der Seite angezeigt wird.
 * Weitere administrative Arbeit ist nicht erforderlich
 */
(function(sct, $, server){

  var
  eventData = {'ajaxIdentifier':sct.ajaxIdentifier,'pageItems':sct.pageItems},
  triggeringElement = {'id':'','$element':{},'$button':{},'isClick':false},
  C_BIND_EVENT = 'change',
  C_CLICK_EVENT = 'click',
  C_APEX_REFRESH = 'apexrefresh',
  C_DISABLED_CSS = 'apex_disabled';
  C_APEX_BEFORE_REFRESH = 'apexbeforerefresh',
  C_APEX_AFTER_REFRESH = 'apexafterrefresh',
  C_NO_TRIGGERING_ITEM = 'DOCUMENT',
  C_BUTTON = 'button',
  C_APEX_BUTTON = 't-Button';

  sct.ajaxIdentifier = {};
  sct.lastItemValues = {};
  

  /*
    Private Hilfsmethoden
   */
  // Hilfsmethode deaktiviert die geklickte Schaltflaeche, um Doppelklick zu verhindern
  function lockButton(){
    if (triggeringElement.isClick){
      apex.item(triggeringElement.id).disable();
      // Eventuell vorhandene weitere Events (Doppelklick etc.) aus Queue entfernen
      $('body').clearQueue();
    };
  };
  
  
  // Hilfsmethode, wird als Callback-Methode für den Change-Event verwendet
  function changeCallback(e){
    getTriggeringElement(e);
    
    // Anforderung in Queue legen, um mehrere Events der Reihe nach abzuarbeiten
    $('body').queue(function(){
      sct.execute(e);
    });
  };
  
  
  // Hilfsmethode, wird verwendet, um vor dem Absenden des Events einen Bestätigungsdialog zu zeigen
  function confirmCallback(e){
    getTriggeringElement(e);
    
    // Anforderung in Queue legen, um mehrere Events der Reihe nach abzuarbeiten
    $('body').queue(function(){
      // Schaltflaeche
      lockButton();
      // Eigentliches Callback wird an positive Antwort auf Bestaetigung gebunden
      sct.ApexJS.confirmRequest(e, changeCallback);
    });
  };


  // Hilfsfunktion fügt Element der Liste der Seitenelemente hinzu, deren Werte beim Auslösen von SCT
  // an den Server gesendet werden müssen
  function addPageItem(itemName){
    if($.inArray(itemName, sct.pageItems) === -1){
      sct.pageItems.push(itemName);
    };
  };


  // Bindet einen konkreten Event an ein Element
  function bindEvent(item, event){
    var $this = $(`#${item}`);

    if ($this.length > 0){
      // Element ist auf Seite auch vorhanden (könnte durch Condition fehlen)
      var eventList = $._data($this.get(0), 'events');

      if (eventList == undefined || eventList[event] == undefined){
        // Element hat noch keinen entsprechenden Event, binden
        $this
        .on(event, eventData, changeCallback);
        if(event == C_BIND_EVENT){
          // CHANGE-Events sollen bei APEXREFRESH nicht ausgelöst werden, pausieren
          $this
          .on(C_APEX_BEFORE_REFRESH, function(e){
            $(this).off(C_BIND_EVENT);
            apex.debug.log(`Event "${C_BIND_EVENT}" paused at ${item}`);
          })
          .on(C_APEX_AFTER_REFRESH, function(e){
            $(this).on(C_BIND_EVENT, eventData, changeCallback);
            apex.debug.log(`Event "${C_BIND_EVENT}" re-established at ${item}`);
          });
        };
      };
    };
  };


  // Bindet an alle Seitenelemente aus SCT.BIND_ITEMS an den CHANGE-Event,
  // um die Verarbeitung des Plugins auszulösen
  // Alle relevanten Elemente werden in pageItems hinterlegt, um beim Auslösen Elementwerte
  // an die Datenbank zu senden.
  function bindEvents() {
    $.each(sct.bindItems, function(){
      bindEvent(this.id, this.event);
      if(this.event == C_BIND_EVENT){
        addPageItem(this.id);
      }
    });
  };


  // Hilfsfunktion ermittelt die Liste von Elementen, deren aktuelle Werte bei jedem Event
  // in den SessionState kopiert werden. Es kann eine (Liste von) CSS-Klassen oder Element-IDs
  // übergeben werden
  function bindObserverElements(selector){
    var selectorList;
    if (selector) {
      selectorList = selector.split(',');
      $.each(selectorList, function(idx, element){
        if(this.substring(0,1) == '.'){
          $(element).each(function(idx, element){
            addPageItem($(element).attr('id'));
          });
        }
        else{
          if($.inArray(element, sct.pageItems) === -1){
            sct.pageItems.push(element);
          };
        };
      });
    };
  }


  // Methode findet ein konkretes Element in einem JSON-Array und liefert dessen Wert zurück
  // Struktur des JSON-Arrary: [{"id":"<ID>","value":"<Wert>"}, {"id":"<ID>","value":"<Wert>"}]
  // Die Methode nimmt an, dass "id" eindeutig ist.
  function findItemValue(item){
    // Finde ID in lastItemValues
    var result = $.grep(sct.lastItemValues, function(e){
      return e.id == item;
    });

    // Liefere VALUE
    if(result.length > 0){
      return result[0].value;
    }
  };


  // Methode zur Konvertierung einer hexadezimalen Darstellung in einen Text
  // Wird verwendet, um beliebige Text per JSON übermitteln zu können, ohne aufwändiges Escaping
  // durchzuführen. In der Datenbank wird der Text mittels utl_raw.cast_to_raw(<TEXT>) erzeugt.
  function hexToChar(rawString) {
    var code = '';
    var hexString;
    if (rawString){}
      hexString = rawString.toString();
      for (var i = 0; i < hexString.length; i += 2){
        code += String.fromCharCode(parseInt(hexString.substr(i, 2), 16));
      };
    return code;
  }


  // Methode zur Ermittlung der ID des auslösenden Elements.
  function getTriggeringElement(e){
    // Falls PageLoad, wird "document" verwendet
    triggeringElement.id = C_NO_TRIGGERING_ITEM;
    triggeringElement.isClick = e.type == C_CLICK_EVENT;

    if (typeof e.target != 'undefined'){
		//TODO: Ursache dafür finden, dass target.id für Buttons manchmal leer ist. WA: currentTarget.id nutzten
      triggeringElement.id = e.target.id != '' ? e.target.id : e.currentTarget.id;
      if (triggeringElement.id == '') {
        // Einige Browser senden accessKey-span anstatt Schaltfläche als triggerndes Element
        // In diesen Fällen parent-Element ansprechen und ID von dort lesen
        triggeringElement.id = e.target.parentElement.id;
      };
      triggeringElement.$element = $(`#${triggeringElement.id}`);

      if(triggeringElement.$element.attr('type') == 'radio' || triggeringElement.$element.attr('type') == 'checkbox'){
        // Radio-Buttons haben ihre ID im parent-Fieldset
        triggeringElement.id = triggeringElement.$element.parents('fieldset').attr('id');
        triggeringElement.$element = $(`#${triggeringElement.id}`);
      }
       apex.debug.log(`Event "${e.type}" raised at Triggering element "${triggeringElement.id}"`);
    }
    
    if(triggeringElement.isClick){
      triggeringElement.$button = $(`#${triggeringElement.id}`);
      // Je nach Art der Auslösung des CLICK-Events (mit Maus oder durch Code)
      // wird ein unterschiedliches Objekt angesprochen. Dies wird hier behandelt.
      if (!triggeringElement.$button.hasClass(C_APEX_BUTTON)){
        triggeringElement.$button = $(`#${triggeringElement.id}`).parent(C_BUTTON);
      };
    };
  };


  // Methode zum Ausführen des übergebenen Codes und anschließendem Entfernen
  // Nimmt den Code entgegen und fügt es als Dokument-Fragment ein.
  // Dies führt den enthaltenen JavaSrcipt-Code direkt aus, so dass das eingefügte
  // Element anschließend direkt wieder gelöscht werden kann
  function executeCode(code){
    if (code) {
      console.log('Response received: \n' + $(code).text());
      $('body').append(code);
      $('#' + $(code).attr('id')).remove();
    };
    $('body').dequeue();
  };


  // Hilfsmethode zur Ausführung des Callbacks auf
  // - dem identifizierten Element
  // - dem jQuery-Selektor
  function forEach(item, callback){
    if(!($.isArray(item) || item.search(/[\.# :\[\]]+/) >= 0)){
      // übergebenes ITEM ist Elementname, um # erweitern
      item = `#${item}`;
    }
    $(item).each(callback);
  };


  /*
    Implementierung der Plugin-Funktionalität
   */


  // Funktionen, die durch Script aus Response aufgerufen werden.
  sct.setRuleName = function(ruleName){
    apex.debug.log(`Rule used: ${ruleName}`);
    // TODO: Verwendete Regel auf Seitenelement kopieren? Eventuell zusätzlicher Parameter für diesen Zweck
  };


  // setItemValues synchronisiert geänderte Elementwerte aus dem Session State auf der Seite.
  sct.setItemValues = function(pageItems){
    // Elemente und ihre Werte zwischenspeichern für Referenz aus asynchronen Aufrufen
    sct.lastItemValues = pageItems;
    // Entnehme die neuen Elementwerte und setze sie auf der Seite
    $.each(pageItems, function(){
      if ((this.value || 'FOO') != ($v(this.id) || 'FOO')){
        // Elementwert wird gesetzt. Letzter Parameter unterdrückt change-Event
        apex.item(this.id).setValue(this.value, this.value, true);
        apex.debug.log(`Item "${this.id}" set to "${this.value}"`);
      };
    });
  };


  sct.setItemValue = function(item, value){
    forEach(item, function(){
        var itemId = $(this).attr('id');
        apex.item(itemId).setValue(value, value, true);
      });
  };


  // Wrapper um sct.ApexJS
  sct.setErrors = function(errorList) {
    if(errorList.errors.length > 0){
      // Werden Fehler gemeldet, sollen alle eventuell weiteren Events unterdrueckt werden
      $('body').clearQueue();
    };
    sct.ApexJS.maintainErrors(errorList);
  };
  
  
  // Bindet einen Confirmation-Handler an eine Schaltfläche
  sct.bindConfirmation = function(item, message, title){
    var $this = $(`#${item}`);

    if ($this.length > 0){
      // Element ist auf Seite auch vorhanden (könnte durch Condition fehlen)
      var eventList = $._data($this.get(0), 'events');
      if (eventList[C_CLICK_EVENT]){
        $this.off(C_CLICK_EVENT);
      };
      // Click-Event mit Confirmation-Handler binden
      $this.on(C_CLICK_EVENT, {'ajaxIdentifier':sct.ajaxIdentifier,'pageItems':sct.pageItems,'message':message,'title':title}, confirmCallback);
    };
  };


  sct.submit = function(request, message){
    sct.ApexJS.submitPage(request, message);
  };


  sct.setMandatory = function(item, mandatory){
    forEach(item, function(){
      var itemId = $(this).attr('id').replace('_CONTAINER','');
      if (mandatory){
        bindEvent(itemId, C_BIND_EVENT);
        sct.pageItems.push(itemId);
      }
      sct.ApexJS.setFieldMandatory(itemId, mandatory);
    });
  };


  sct.notify = function(message){
    sct.ApexJS.setNotification(message);
  };


  sct.refresh = function(item){
    $this = $(`#${item}`);
    $this.trigger(C_APEX_REFRESH);
    sct.enable(item);
  };


  // Lokale ActionType-Methoden
  sct.refreshAndSetValue = function(item){
    var itemValue = arguments[1] || findItemValue(item);
    $(`#${item}`)
    .one(C_APEX_AFTER_REFRESH, function(e){
          $(this).off(C_BIND_EVENT);
          $s(item, itemValue);
          $(this).on(C_BIND_EVENT, eventData, changeCallback);
        })
    .trigger(C_APEX_REFRESH);
    sct.enable(item);
  };


  sct.disable = function(item){
    forEach(item, function(){
      var itemId = $(this).attr('id');
      sct.ApexJS.disableElement(itemId);
      // Sonderfall: click-Event, waehrend der Cursor in Eingabefeld stand:
      // Eventfolge change - click. Hat change-Event ein disable zur Folge, 
      // muss der click-Event aus der Queue entfernt werden, damit er nicht
      // ausgefuehrt wird.
      $('body').clearQueue();
    });
  };


  sct.enable = function(item){
    forEach(item, function (){
      var itemId = $(this).attr('id');
      sct.ApexJS.enableElement(itemId);
    });
  };


  sct.show = function(item){
    forEach(item, function(){
      var $this = $(this);
      var itemId = $this.attr('id');
      apex.item(itemId).show();
    });
  };


  sct.hide = function(item){
    forEach(item, function(){
      var $this = $(this);
      var itemId = $this.attr('id');
      apex.item(itemId).hide();
    });
  };


  // Plugin-Funktionalität
  sct.execute = function(e){
    
    // Falls click-Event, zugehoerige Schatlflaeche sperren
    lockButton();
    console.log('Behandle Event ' + e.type);
    server.plugin(
      sct.ajaxIdentifier,
      {
        'x01':triggeringElement.id,
        // Kopiere alle relevanten Seitenelemente in den SessionState
        'pageItems':sct.pageItems
      },
      {
        'dataType':'html',
        'success':function(data){
          if(triggeringElement.isClick){
            apex.item(triggeringElement.id).enable();
          }
          executeCode(data);
        }
      }
    );
  };


  sct.init = function(me){
    // me.action enthält folgende Parameter:
    // me.action.attribute_01: JSON-Liste aller Elemente, die einen Eventhandler benötigen, sowie den zu bindenden Event;
    // me.action.attribute_02: Liste der Elemente, deren Elementwert sich durch SCT im SessionState geändert hat mit den aktuellen Werten
    // me.action.attribute_03: Namensraumobjekt der JavaScript-Datei, die für die Darstellung von SCT auf der Seite verantwortlich ist (SCT_APEX_...)
    // me.action.attribute_04: JavaScript-Instanz, mit Aktionen, die auf der Seite ausgeführt werden sollen
    // me.action.attribute_05: Liste mit Elementnamen oder CSS-Klassenselektoren, deren Elementwerte bei jedem Ereignis in den SessionState kopiert werden sollen
    // Binde auslösende Events an Elemente, die über Attribut 01 übergeben werden
    sct.bindItems = $.parseJSON(me.action.attribute01.replace(/~/g, '"'));
    sct.pageItems = [];
    if (me.action.attribute02) {
      sct.pageItems = me.action.attribute02.split(',');
    };

    bindObserverElements(me.action.attribute05);

    // Registriere APEX-JavaScript Objekt
    sct.ApexJS = eval(me.action.attribute03);
    sct.ajaxIdentifier = me.action.ajaxIdentifier;

    // Bereite Einsatz des Plugins vor
    bindEvents();
    apex.debug.log('SCT initialized');

    // Initialisierungscode ausführen
    executeCode(hexToChar(me.action.attribute04));
  }

})(de.condes.plugin.sct, apex.jQuery, apex.server);


// Schnittstelle zum APEX-Plugin-Mechanismus, die aus einem mir nicht bekannten Grund
// Schwierigkeiten mit der Verwendung eines Namensraumobjekts haben
function de_condes_plugin_sct(){
  de.condes.plugin.sct.init(this);
}
