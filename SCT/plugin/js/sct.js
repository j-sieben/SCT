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
  C_BIND_EVENT = 'change',
  C_CLICK_EVENT = 'click',
  C_APEX_REFRESH = 'apexrefresh',
  C_APEX_BEFORE_REFRESH = 'apexbeforerefresh',
  C_APEX_AFTER_REFRESH = 'apexafterrefresh',
  C_NO_TRIGGERING_ITEM = 'DOCUMENT';

  sct.ajaxIdentifier = {};
  sct.lastItemValues = {};


  /*
    Private Hilfsmethoden
   */

  // Hilfsmethode, wird als Callback-Methode für den Change-Event verwendet
  function changeCallback(e){
    apex.debug.log(`Event »${e.type}« raised at ${e.target}`);
    sct.execute(e);
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
        .on(event, {'ajaxIdentifier':sct.ajaxIdentifier,'pageItems':sct.pageItems}, changeCallback);
        if(event == C_BIND_EVENT){
          // CHANGE-Events sollen bei APEXREFRESH nicht ausgelöst werden, pausieren
          $this
          .on(C_APEX_BEFORE_REFRESH, function(e){
            $(this).off(C_BIND_EVENT);
            apex.debug.log(`Event »${C_BIND_EVENT}« paused at ${item}`);
          })
          .on(C_APEX_AFTER_REFRESH, function(e){
            $(this).on(C_BIND_EVENT, {'ajaxIdentifier':sct.ajaxIdentifier,'pageItems':sct.pageItems}, changeCallback);
            apex.debug.log(`Event »${C_BIND_EVENT}« re-established at ${item}`);
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
    });
  };


  // Methode findet ein konkretes Element in einem JSON-Array und liefert dessen Wert zurück
  // Struktur des JSON-Arrary: [{"id":"<ID>","value":"<Wert>"}, {"id":"<ID>","value":"<Wert>"}]
  // Die Methode nimmt an, dass "id" eindeutig ist.
  function findItemValue(item){
    // Finde ID in lastItemValues
    var result = $.grep(sct.lastItemValues, function(e){
      return e.id == item;
    });

    // Liefere VALUE
    if(result){
      return result[0].value;
    }
  };


  // Methode zur Konvertierung einer hexadezimalen Darstellung in einen Text
  // Wird verwendet, um beliebige Text per JSON übermitteln zu können, ohne aufwändiges Escaping
  // durchzufhren. In der Datenbank wird der Text mittels utl_raw.cast_to_raw(<TEXT>) erzeugt.
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
    var triggeringElement = C_NO_TRIGGERING_ITEM

    if (typeof e.target != 'undefined'){
      triggeringElement = e.target.id;
      if (triggeringElement == '') {
        // Einige Browser senden accessKey-span anstatt Schaltfläche als triggerndes Element
        // In diesen Fällen parent-Element ansprechen und ID von dort lesen
        triggeringElement = e.target.parentElement.id;
      };
      $triggeringElement = $('#' + triggeringElement);

      if($triggeringElement.attr('type') == 'radio'){
        // Radio-Buttons haben ihre ID im parent-Fieldset
        triggeringElement = $triggeringElement.parents('fieldset').attr('id');
      }
      apex.debug.log(`Triggering element: ${triggeringElement}`);
    }
    return triggeringElement;
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
  };
  
   
  // Hilfsmethode zur Ausführung des Callbacks auf
  // - dem identifizierten Element
  // - dem jQuery-Selektor
  function forEach(item, callback){
    if(!($.isArray(item) || item.search(/[\.# :\[\]]+/) >= 0)){
      // Übergebenes ITEM ist Elementname, um # erweitern
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
    sct.ApexJS.maintainErrors(errorList);
  };


  sct.submit = function(request, message){
    sct.ApexJS.submitPage(request, message);
  };


  sct.setMandatory = function(item, mandatory){
    forEach(item, function(){
      var itemId = $(this).attr('id');
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
          $(this).on(C_BIND_EVENT, {'ajaxIdentifier':sct.ajaxIdentifier,'pageItems':sct.pageItems}, changeCallback);
        })
    .trigger(C_APEX_REFRESH);
    sct.enable(item);
  };


  sct.disable = function(item){
    forEach(item, function(){
      var itemId = $(this).attr('id');
      sct.ApexJS.disableElement(itemId);
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
    server.plugin(
      e.data.ajaxIdentifier,
      {
        'x01':getTriggeringElement(e),
        // Kopiere alle relevanten Seitenelemente in den SessionState
        'pageItems':e.data.pageItems
      },
      {
        'dataType':'html',
        'success':executeCode
      }
    );
  };


  sct.init = function(me){
    // Binde auslösende Events an Elemente, die über Attribut 01 übergeben werden
    sct.bindItems = $.parseJSON(me.action.attribute01.replace(/~/g, '"'));
    sct.pageItems = [];
    if (me.action.attribute02) {
      sct.pageItems = me.action.attribute02.split(',');
    };

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
