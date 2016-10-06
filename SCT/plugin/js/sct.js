// Namespace
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.sct = {};


(function(sct, $, server){
   
  C_BIND_EVENT = 'change';
  C_CLICK_EVENT = 'click';
  C_APEX_BEFORE_REFRESH = 'apexbeforerefresh';
  C_APEX_AFTER_REFRESH = 'apexafterrefresh';
  C_NO_TRIGGERING_ITEM = 'DOCUMENT';
  
  sct.ajaxIdentifier = {};
  sct.options = {};
  
  
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
  sct.setErrors = function(fehlerListe) {
    drv.ek.verwalteExterneFehler(fehlerListe);
  };
   
  /* 
    Hilfsmethoden 
   */
  // Bindet an alle Seitenelemente aus SCT.BIND_ITEMS an den CHANGE-Event,
  // um die Verarbeitung des Plugins auszulösen
  // Alle relevanten Elemente werden in pageItems hinterlegt, um beim Auslösen Elementwerte
  // an die Datenbank zu senden.
  sct.bindEvents = function() {
    $.each(sct.bindItems, function(){
      var $this = $('#' + this.id);
      var event = this.event;
      $this
      .on(this.event, function(e){
        sct.execute(e, sct.ajaxIdentifier, sct.pageItems);
        apex.debug.log(`${event} bound to ${this.id}`);
      });
      if($this.event == C_BIND_EVENT){
        $this
        .on(C_APEX_BEFORE_REFRESH, function(e){
          $(this).off(C_BIND_EVENT);
        })
        .on(C_APEX_AFTER_REFRESH, function(e){
          $(this).on(C_BIND_EVENT, function(e){
            sct.execute(e, sct.ajaxIdentifier, sct.pageItems);
          });
        });
      };
    });
  };
  
  
  /*
    Implementierung der Plugin-Funktionalität
   */
  sct.submit = function(request){
    drv.ek.submit(request);
  }
  
  
  sct.setMandatory = function(item, mandatory){
    drv.ek.setMandatory(item, mandatory);
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
      if (e.target.id != '') {
         triggeringElement = e.target.id;
      }
      else {
         // If button has an accesskey, some browsers report that instead of the button itself
         // get parent button's id in this case
         triggeringElement = $(e.target).parents('button').attr('id');
      }
      $triggeringElement = $('#' + triggeringElement)
      if($triggeringElement.attr('type') == 'radio'){
        // Radio groups carry their own id per radio button. We need the fieldset id 
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
  
  
  sct.init = function(me){
    // Binde auslösende Events an Elemente, die über Attribut 01 übergeben werden
    sct.bindItems = $.parseJSON(me.action.attribute01.replace(/~/g, '"'));
    if (me.action.attribute02) {
      sct.pageItems = me.action.attribute02.split(',');
    };
    sct.ajaxIdentifier = me.action.ajaxIdentifier;
    
    // Bereite Einsatz des Plugins vor
    sct.bindEvents();
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
