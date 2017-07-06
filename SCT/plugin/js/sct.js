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
 *            - setNoficitation
 *                Die Methode setzt eine Nachricht auf der Oberfläche.
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
  // Bindet an alle Seitenelemente aus SCT.BIND_ITEMS an den CHANGE-Event,
  // um die Verarbeitung des Plugins auszulösen
  // Alle relevanten Elemente werden in pageItems hinterlegt, um beim Auslösen Elementwerte
  // an die Datenbank zu senden.
  function bindEvents() {
    $.each(sct.bindItems, function(){
      var $this = $('#' + this.id);
      var event = this.event;
      $this
      .on(event, function(e){
        sct.execute(e, sct.ajaxIdentifier, sct.pageItems);
        apex.debug.log(`Event »${event}« raised at ${this.id}`);
      });
      if(event == C_BIND_EVENT){
        $this
        .on(C_APEX_BEFORE_REFRESH, function(e){
          $(this).off(C_BIND_EVENT);
          apex.debug.log(`Event »${C_BIND_EVENT}« paused at ${this.id}`);
        })
        .on(C_APEX_AFTER_REFRESH, function(e){
          $(this).on(C_BIND_EVENT, function(e){
            sct.execute(e, sct.ajaxIdentifier, sct.pageItems);
          });
          apex.debug.log(`Event »${C_BIND_EVENT}« re-established at ${this.id}`);
        });
      };
    });
  };
  
  
  /*
    Implementierung der Plugin-Funktionalität
   */
  sct.submit = function(request, message){
    sct.ApexJS.submitPage(request, message);
  }
  
  
  sct.setMandatory = function(item, mandatory){
    var $Items = $(`#${item}`);
    if (!$items.length){
      $Items = $(item);
    }
    $Items.each(function(){
      sct.ApexJS.setFieldMandatory(this.attr('id'), mandatory);
    })
  }
  
  
  sct.notify = function(message){
    sct.ApexJS.setNotification(message);
  }
   
   
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
      $triggeringElement = $('#' + triggeringElement)
      if($triggeringElement.attr('type') == 'radio'){
        triggeringElement = $triggeringElement.parents('fieldset').attr('id');
      }
      else if (triggeringElement == '') {
        // Einige Browser senden accessKey-San anstatt Schaltfläche als triggerndes Element
        // In diesen Fällen parent-Element ansprechen und ID von dort lesen
        triggeringElement = e.target.parentElement.id;
      };
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
  
  
  sct.init = function(me){
    // Binde auslösende Events an Elemente, die über Attribut 01 übergeben werden
    sct.bindItems = $.parseJSON(me.action.attribute01.replace(/~/g, '"'));
    if (me.action.attribute02) {
      sct.pageItems = me.action.attribute02.split(',');
    };
    sct.ajaxIdentifier = me.action.ajaxIdentifier;
    
    // Registriere APEX-JavaScript Objekt
    sct.ApexJS = eval(me.action.attribute03);
    
    // Bereite Einsatz des Plugins vor
    bindEvents();
    apex.debug.log('SCT initialized');
    
    // Löse beim Seitenladen explizit Verarbeitung des Plugins aus
    apex.debug.log(`Triggering element: document`);
    sct.execute(me);
  }
  
})(de.condes.plugin.sct, apex.jQuery, apex.server);


// Schnittstelle zum APEX-Plugin-Mechanismus, die aus einem mir nicht bekannten Grund
// Schwierigkeiten mit der Verwendung eines Namensraumobjekts haben
function de_condes_plugin_sct(){
  de.condes.plugin.sct.init(this);
}