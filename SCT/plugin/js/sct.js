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
 * initCode:  Nach der Initialisierung werden die Initialisierungsregeln berechnet und der resultierende JavaScript-Code
 *            +ber diesen Parameter ausgeliefert.
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
   
  C_BIND_EVENT = 'change';
  C_CLICK_EVENT = 'click';
  C_APEX_REFRESH = 'apexrefresh';
  C_APEX_BEFORE_REFRESH = 'apexbeforerefresh';
  C_APEX_AFTER_REFRESH = 'apexafterrefresh';
  C_NO_TRIGGERING_ITEM = 'DOCUMENT';
  
  sct.ajaxIdentifier = {};
  
  /*
    Funktionen, die durch Script aus Response aufgerufen werden.
   */  
  // Die Methode setItemValues wird von Response aufgerufen und darf daher nicht umbenannt oder entfernt werden
  sct.setRuleName = function(ruleName){
    apex.debug.log(`Rule used: ${ruleName}`);
    // TODO: Verwendete Regel auf Seitenelement kopieren? Eventuell zusätzlicher Parameter für diesen Zweck
  };
  
  
  // setItemValues synchronisiert geänderte Elementwerte aus dem Session State auf der Seite.
  // Die Methode setItemValues wird von Response aufgerufen und darf daher nicht umbenannt oder entfernt werden
  sct.setItemValues = function(pageItems){
    // Entnehme die neuen Elementwerte und setze sie auf der Seite
    $.each(pageItems, function(){
      if ((this.value || 'FOO') != ($v(this.id) || 'FOO')){
        apex.item(this.id).setValue(this.value, this.value, true);
        apex.debug.log(`Item "${this.id}" set to "${this.value}"`);
      };
    });
  };
 

  // Die Methode setErrors wird von Response aufgerufen und darf daher nicht umbenannt oder entfernt werden
  // Spezifisch für die aktuelle Version der Anwendung. Muss wahrscheinlich überarbeitet werden,
  // wenn der neue StyleGuide eingesetzt wird
  sct.setErrors = function(errorList) {
    sct.ApexJS.maintainErrors(errorList);
  };

   
  /* 
    Private Hilfsmethoden 
   */
  // Bindet einen konkreten Event an ein Element
  function bindEvent(item, event){
    var $this = $(`#${item}`);
    var eventList = $._data($this.get(0), 'events');

    if (eventList == undefined || eventList[event] == undefined){
      // Element hat noch keinen entsprechenden Event, binden
      $this
      .on(event, function(e){
        sct.execute(e, sct.ajaxIdentifier, sct.pageItems);
        apex.debug.log(`Event »${event}« raised at ${item}`);
      });
      if(event == C_BIND_EVENT){
        // CHANGE-Events sollen bei APEXREFRESH nicht ausgelöst werden, pausieren
        $this
        .on(C_APEX_BEFORE_REFRESH, function(e){
          $(this).off(C_BIND_EVENT);
          apex.debug.log(`Event »${C_BIND_EVENT}« paused at ${item}`);
        })
        .on(C_APEX_AFTER_REFRESH, function(e){
          $(this).on(C_BIND_EVENT, function(e){
            sct.execute(e, sct.ajaxIdentifier, sct.pageItems);
          });
          apex.debug.log(`Event »${C_BIND_EVENT}« re-established at ${item}`);
        });
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
  
  
  /*
    Implementierung der Plugin-Funktionalität
   */
  sct.submit = function(request, message){
    sct.ApexJS.submitPage(request, message);
  };
  
  
  sct.setMandatory = function(item, mandatory){
    if (mandatory){
      bindEvent(item, C_BIND_EVENT);
      sct.pageItems.push(item);
    }
    sct.ApexJS.setFieldMandatory(item, mandatory);
  }
  
  
  sct.notify = function(message){
    sct.ApexJS.setNotification(message);
  };
  
  
  sct.refreshAndSetValue = function(item){
    var itemValue = arguments[1] || $v(item);
    $(`#${item}`)
    .one(C_APEX_AFTER_REFRESH, function(e){
          $s(item, itemValue);
        })
    .trigger(C_APEX_REFRESH);    
  };
   
   
  sct.execute = function(e){
    var callback = function(data){
      // Nimmt das Ergebnis entgegen und fügt es als Dokument-Fragment ein.
      // Dies führt den enthaltenen JavaSrcipt-Code direkt aus, so dass das eingefügte 
      // Element anschließend direkt wieder gelöscht werden kann
      if (data) {
        apex.debug.log('Response received');
        $('body').append(data);
        $('#' + $(data).attr('id')).remove();
      };
    };
    
    // ID des auslösenden Elements. Falls PageLoad, wird "document" verwendet
    var triggeringElement = C_NO_TRIGGERING_ITEM
    if (typeof e.target != 'undefined'){
      triggeringElement = e.target.id;
      if (triggeringElement == '') {
        // Einige Browser senden accessKey-San anstatt Schaltfläche als triggerndes Element
        // In diesen Fällen parent-Element ansprechen und ID von dort lesen
        triggeringElement = e.target.parentElement.id;
      };
      $triggeringElement = $('#' + triggeringElement)
      if($triggeringElement.attr('type') == 'radio'){
        triggeringElement = $triggeringElement.parents('fieldset').attr('id');
      }
      apex.debug.log(`Triggering element: ${triggeringElement}`);
    }
    
    server.plugin(
      sct.ajaxIdentifier,
      {
        'x01':triggeringElement,
        // Kopiere alle relevanten Seitenelemente in den SessionState
        'pageItems':sct.pageItems
      },
      {
        'dataType':'html',
        'success':callback
      }
    );
  };
  
  
  function hexToChar(hexx) {
    var hex = hexx.toString();//force conversion
    var str = '';
    for (var i = 0; i < hex.length; i += 2)
        str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
    return str;
  }
  
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
    if (me.action.attribute04){
      apex.debug.log('Initialization code received');
      sct.initCode = hexToChar(me.action.attribute04);
      $('body').append(sct.initCode);
      $('#' + $(sct.initCode).attr('id')).remove();
    };
  }
  
})(de.condes.plugin.sct, apex.jQuery, apex.server);


// Schnittstelle zum APEX-Plugin-Mechanismus, die aus einem mir nicht bekannten Grund
// Schwierigkeiten mit der Verwendung eines Namensraumobjekts haben
function de_condes_plugin_sct(){
  de.condes.plugin.sct.init(this);
}