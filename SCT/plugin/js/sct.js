// Namespace
var de = de || {}
de.condes = de.condes || {}
de.condes.plugin = de.condes.plugin || {}
de.condes.plugin.sct = {};


(function(sct, $, server){
  
  C_NO_ERROR_CLASS_SEL = '.keinFehlerBereich'
  C_APEX_ERROR_CLASS = 'apex-page-item-error'
  C_APEX_ERROR_CLASS_SEL = `.${C_APEX_ERROR_CLASS}`
  C_ERROR_CLASS_SEL = '.fehlerBereich'
  C_ERROR_LIST_ID = 'fehlerListe'
  C_ERROR_LIST_ID_SEL = `#${C_ERROR_LIST_ID}`
  C_BIND_EVENT = 'change'
  C_APEX_BEFORE_REFRESH = 'apexbeforerefresh'
  C_APEX_AFTER_REFRESH = 'apexafterrefresh'
  C_NO_TRIGGERING_ITEM = 'DOCUMENT'
  
  sct.pageItems = {}
  sct.ajaxIdentifier = {}
  
  
  /*
    Funktionen, die durch Script aus Response aufgerufen werden.
   */  
  // Die Methode setItemValues wird von Response aufgerufen und darf daher nicht umbenannt oder entfernt werden
  sct.setRuleName = (ruleName) => {
    apex.debug.log(`Rule used: ${ruleName}`)
    // TODO: Benutze Regel auf Seitenelement kopieren? Eventuell zusätzlicher Parameter für diesen Zweck
  }
  
  
  // Die Methode setItemValues wird von Response aufgerufen und darf daher nicht umbenannt oder entfernt werden
  sct.setItemValues = (pageItems) => {
    // Entnehme die neuen Elementwerte und setze sie auf der Seite
    $.each(pageItems.item, function(){
      let value = this.value
      let id = this.id
      if ((value || 'FOO') != ($v(id) || 'FOO')){
        apex.item(id).setValue(value, value, true)
        apex.debug.log(`Item "${id}" set to "${value}"`)
      }
    })
  }
  
  
  // Die Methode setErrors wird von Response aufgerufen und darf daher nicht umbenannt oder entfernt werden
  // Spezifisch für die aktuelle Version der Anwendung. Muss wahrscheinlich überarbeitet werden,
  // wenn der neue StyleGuide eingesetzt wird
  sct.setErrors = (data) => {
    let $item
    let $errorList = $('<ul>').attr('id', C_ERROR_LIST_ID)
    
    sct.removeErrors()
    
    function getErrors(amount){
      if (amount != 1){
          return `${amount} errors received`
      }
      else{
          return `${amount} error received`
      }
    }
    
    if (data.count > 0){
       apex.debug.log(getErrors(data.count))
      $.each(data.errors, function() {
        $item = $('#' + this.item)
        $item.addClass(C_APEX_ERROR_CLASS)
        $item.siblings('span').remove()
        $item.parent().append(`<span class='t-Form-error'>${this.message}</span>`)
        $errorList.append($('<li>').html(this.message))
      })
      $(C_NO_ERROR_CLASS_SEL).hide()
      $(C_ERROR_CLASS_SEL).show()
      $(C_ERROR_LIST_ID_SEL).replaceWith($errorList)
    }
  }
  
  
  /* 
    Hilfsmethoden 
   */
  // Hilfsfunktion zum Bereinigen der Seite von Fehlermeldungen
  // Spezifisch für die aktuelle Version der Anwendung. Muss wahrscheinlich überarbeitet werden,
  // wenn der neue StyleGuide eingesetzt wird
  sct.removeErrors = () => {
    $(C_APEX_ERROR_CLASS_SEL)
    .removeClass(C_APEX_ERROR_CLASS)
    .siblings('span')
    .remove()
    $(C_NO_ERROR_CLASS_SEL).show()
    $(C_ERROR_CLASS_SEL).hide()
  }
  
  
  // Bindet an alle Seitenelemente aus SCT.BIND_ITEMS an den CHANGE-Event,
  // um die Verarbeitung des Plugins auszulösen
  sct.bindEvents = () => {
    $.each(sct.bindItems, 
      function(){
        $('#' + this)
        .on(C_BIND_EVENT, function(e){
          sct.execute(e, sct.ajaxIdentifier, sct.pageItems)
        })
        .on(C_APEX_BEFORE_REFRESH, function(e){
          $(this).off(C_BIND_EVENT)
        })
        .on(C_APEX_AFTER_REFRESH, function(e){
          $(this).on(C_BIND_EVENT, function(e){
            sct.execute(e, sct.ajaxIdentifier, sct.pageItems)
          })
        })
    })
    apex.debug.log(`Change event bound to ${sct.bindItems}`)
  }
  
  
  /*
    Implementierung der Plugin-Funktionalität
   */
  sct.execute = (e) => {
    let callback = (data) => {
      // Nimmt das Ergebnis entgegen und fügt es als Dokument-Fragment ein.
      // Dies führt den enthaltenen JavaSrcipt-Code direkt aus, so dass das eingefügte 
      // Element anschließend direkt wieder gelöscht werden kann
      if (data) {
        apex.debug.log('Response received')
        let id = $(data).attr('id')
        sct.removeErrors()
        $('body').append(data)
        $('#' + id).remove()
      }
    }
    
    // ID des auslösenden Elements. Falls PageLoad, wird "document" verwendet
    let triggeringElement = C_NO_TRIGGERING_ITEM
    if (typeof e.target != 'undefined'){
      triggeringElement = e.target.id
      apex.debug.log(`Triggering element: ${triggeringElement}`)
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
    )  
  }
  
  
  sct.init = (me) => {
    // Binde auslösende Events an Elemente, die über Attribut 01 übergeben werden
    sct.bindItems = me.action.attribute01.split(',');
    // Vermerke alle relevanten Elemente der Seite als Übergabeobjekte, um die Werte
    // beim Auslösen mit dem SessionState zu synchronisieren
    if (me.action.attribute02){
      sct.pageItems = [...new Set([...me.action.attribute01.split(','), ...me.action.attribute02.split(',')])];
    }
    else{
      sct.pageItems = me.action.attribute01.split(',');
    }
    sct.ajaxIdentifier = me.action.ajaxIdentifier
    
    // Bereite Einsatz des Plugins vor
    sct.bindEvents()
    apex.debug.log('SCT initialized')
    
    // Löse beim Seitenladen explizit Verarbeitung des Plugins aus
    apex.debug.log(`Triggering element: document`)
    sct.execute(me)
  }
  
})(de.condes.plugin.sct, apex.jQuery, apex.server);


// Schnittstelle zum APEX-Plugin-Mechanismus, die aus einem mir nicht bekannten Grund
// Schwierigkeiten mit der Verwendung eines Namensraumobjekts haben
function de_condes_plugin_sct(){
  de.condes.plugin.sct.init(this)
}