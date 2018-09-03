// Namespace
var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.sct = de.condes.plugin.sct || {};
de.condes.plugin.sct.apex_42_5_0 = {};
de.condes.plugin.sct.apex_42_5_1 = {};

/*!
 * Hilfsmethoden zur Darstellung der Plugin-Funktionalität auf der APEX-Oberfläche
 */
/** @fileOverview
 * Da sich in dieser Datei der Code befindet, der mit der Oberfläche von APEX interagiert,
 * besteht eine Abhängigkeit von der verwendeten APEX-Version.
 * Diese Version orientiert sich am Verhalten der Version 5.0, Theme 42. Sollte eine neuere Version verwendet werden,
 * oder ein StyleGuide eingesetzt werden, der ein erweitertes oder geändertes Verhalten erfordert, kann dies implementiert
 * werden, indem eine angepasste Version dieser Datei verwendet und über einen entsprechend benannten Namensraum zur 
 * Verfügung gestellt wird. Dieser kann dem Plugin als Component-Parameter übergeben werden, standardmäßig ist es
 * de.condes.plugin.sct.apex_42_5_0.
 *
 * Abgeleitete Implementierungen müssen folgende Funktionen implementieren:
 * - submitPage(request, message)
 *   Methode prüft, ob Fehlermeldungen auf der Seite angezeigt werden und wirft eine Fehlermeldung, ansonsten
 *   wird die Seite über apex.submit(request) abgeschickt
 * - setFieldMandatory(item, mandatory)
 *   Die Methode stattet ITEM mit den Klassen eines Pflichtfeldes aus, falls MANDATORY true ist, ansonsten
 *   entfernt die Methode die Klassen
 * - maintainErrors(errorList)
 *   Die Methode implementiert die Anzeige von Fehlermeldungen auf der Oberfläche.
 *   Die Fehlerdarstellung und die Benachrichtigung sind in APEX in den Render-Prozess der Seite integriert
 *   und müssen, wenn sie durch das Plugin verwendet werden sollen, hier nachgebildet werden.
 *   Die Methode erhält ein JSON-Objekt mit Fehlern, die aufgetreten sind und dargestellt werden müssen.
 *   Dieses JSON-Objekt wird in folgendem Format übergeben:
 *     {"count":0, // Anzahl der Fehler, die aufgetreten sind
 *        "errorDependentButtons":"", // Liste von Seitenelementen (normalerweise Schaltflächen), die deaktiviert
 *                                    // werden sollen, wenn wenigstens ein Fehler auf der Seite angezeigt wird
 *        "firingItems":"",           // Liste von Elementen, die durch die aktuelle Regel betroffen sind. Von diesen Elementen
 *                                    // müssen eventuell vorhandene Fehlermeldungen entfernt werden.
 *        "errors":[                  // Liste der aufgetretenen Fehler
 *          {"item":"",               // ID des Elements, das den Fehler erhält, oder DOCUMENT, 
 *                                    // um anzuzeigen, dass ein genereller Fehler vorliegt
 *           "message":"",            // Fehlermeldung
 *           "additionalInfo":""      // optionale Zusatzinformationen, z.B. CallStack etc.
 *          }
 *        ]
 *     }
 *   Die Methode entfernt zunächst alle Fehlermeldungen der Elemente aus FIRINGITMES und fügt anschließend die übergebenen Fehler ein.
 * - setNotification(message)
 *   Die Methode zeigt eine Benachrichtigung auf der Oberfläche. Wird auf der Oberfläche bereits eine Nachricht angezeigt, 
 *   wird diese vorab entfernt. Benachrichtigungen und Fehlermeldungen müssen daraufhin geprüft werden, ob sie auch bei modalen
 *   Dialogen korrekt funktionieren
 * - clearNotification
 *   Die Metode entfernt eine Benachrichtigung von der Oberfläche
 */
 
 // Version 5.0, Theme 42
(function(sct){
   // APEX-Fehlerbehandlung
  var C_APEX_ERROR_CLASS = 'apex-page-item-error';
  var C_APEX_ERROR_CLASS_SEL = `.${C_APEX_ERROR_CLASS}, .DOCUMENT`;
  
  var C_MESSAGE_TITLE_SEL = '.t-Alert-title';    
  var C_ERROR_CLASS_SEL =  '.t-Body-alert';
  var C_ERROR_UL_SEL = `${C_ERROR_CLASS_SEL} ul.htmldbUlErr`;
  var C_ERROR_REGION_POSITION_SEL = '.t-Body-content';
  var C_ERROR_DIALOG_POSITION_SEL = '.t-Dialog-body';
  
  var C_CAROUSEL_SEL = '.a-Region-carouselItem';
  var C_CAROUSEL_ERROR_CLASS = 'sct-carousel-hasError';
  
  var C_APEX_ERROR_ID_SEL = '#t_Alert_Notification';
  var C_PAGE_ERROR_TEMPLATE = `<div class="t-Body-alert">
  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG is-visible" id="t_Alert_Notification" role="alert">
    <div class="t-Alert-wrap">
      <div class="t-Alert-icon">
        <span class="t-Icon"></span>
      </div>
      <div class="t-Alert-content">
        <div class="t-Alert-header">
          <h2 class="t-Alert-title"></h2>
        </div>
        <div class="t-Alert-body">
          <ul class="htmldbUlErr"></ul>
        </div>
      </div>
      <div class="t-Alert-buttons">
        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="Schließen"><span class="t-Icon icon-close"></span></button>
      </div>
    </div>
  </div>
</div>`;
  
  // Standard APEX Fehlermeldung beim Element
  var C_ELEMENT_ERROR_TEMPLATE = `<span class="t-Form-error">${this.message}</span>`;
  var C_ELEMENT_ERROR_SEL = ' .t-Form-error';

  // Benachrichtigungen
  var C_APEX_NOTIFICATION_ID_SEL = '#t_Alert_Success';
  var C_PAGE_NOTIFICATION_TEMPLATE = `<div class="t-Body-alert">
  <div id="t_Alert_Success" class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG is-visible" role="alert">
    <div class="t-Alert-wrap">
      <div class="t-Alert-icon">
        <span class="t-Icon"></span>
      </div>
      <div class="t-Alert-content">
        <div class="t-Alert-header">
          <h2 class="t-Alert-title"></h2>
        </div>
      </div>
        <div class="t-Alert-body"></div>
      <div class="t-Alert-buttons">
        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="Schließen"><span class="t-Icon icon-close"></span></button>
      </div>
    </div>
  </div>
</div>`;
  
  // Pflichtfelder
  var C_REQUIRED_SPAN_SEL = 'span.t-Form-required';
  var C_FIELD_REQUIRED_TEMPLATE = '<span class="t-Form-required"><span class="a-Icon icon-asterisk"></span></span>';
  var errorCount;

  // Hilfsfunktionen
  function setMessage() {
    errorCount = $(C_APEX_ERROR_CLASS_SEL).length;
    apex.debug.log(`Anzahl Fehler: ${errorCount}`);
    $messageTitle = $(C_MESSAGE_TITLE_SEL);
   
    switch (errorCount){
	    case 0:
        $messageTitle.text(`Keine Fehler`);
        break;
	   
	    case 1:
        $messageTitle.text(`Es ist 1 Fehler aufgetreten`);
        break;
	   
	    default:
      $messageTitle.text(`Es sind ${errorCount} Fehler aufgetreten`);
    };
  };
  
  
  // Hilfsfunktion zum Bereinigen der Seite von Fehlermeldungen
  function removeErrors(errorList) {
    var firingItems = errorList.firingItems.split(',');
    
    $.each(firingItems, function(){
      $(`#${this}${C_APEX_ERROR_CLASS_SEL}`)
      .removeClass(C_APEX_ERROR_CLASS)
      .siblings('span')
      .remove();

      errorCount = $(C_APEX_ERROR_CLASS_SEL).length;
      if (errorCount == 0){
        $(C_ERROR_CLASS_SEL).remove();
      }
      else{
        $(`${C_ERROR_CLASS_SEL} .${this}`).remove();
      }
      
      // Lösche Fehler aus Registerkarten-Reitern, falls keine Fehler enthalten sind
      var carouselID = $(`#${this}`).closest(C_CAROUSEL_SEL).attr('id');
      if ((carouselID) && ($(`#${carouselID} ${C_APEX_ERROR_CLASS_SEL}`).length == 0)) {
        $(`a.a-Region-carouselLink[href="#${carouselID}"]`).removeClass(C_CAROUSEL_ERROR_CLASS);
      };
    });
  };

  
  // Die Methode setErrors wird von Response aufgerufen und darf daher nicht umbenannt oder entfernt werden
  /**
   * Die Methode behandelt alle Einzelfehler aus errorList, bereinigt die bestehende Fehlerliste
   * und fügt die neuen Fehler hinzu. Zusätzlich zur APEX-Grundfunktionalität werden Fehler auch 
   * in Registerkartenreitern angezeigt, wenn der Fehler sich auf der entsprechenden Registerkarte befindet.
   */
  function setErrors(errorList) {
    
    if (errorList.count > 0){
      apex.debug.log(`Anzahl Fehler PlugIn: ${errorList.count}`);
	   
      if ($(`${C_ERROR_CLASS_SEL} ${C_APEX_ERROR_ID_SEL}`).length == 0){
        // Es ist keine Fehlerregion auf der Seite vorhanden, anzeigen
        if ($(C_ERROR_DIALOG_POSITION_SEL).length){ 
          // Es wird eine modale Seite angezeigt
          $(C_ERROR_DIALOG_POSITION_SEL).prepend(C_PAGE_ERROR_TEMPLATE);
        }
        else{
          $(C_ERROR_REGION_POSITION_SEL).prepend(C_PAGE_ERROR_TEMPLATE);
        }
      }
      
      // Alle Einzelfehler behandeln
      $.each(errorList.errors, function() {
        var itemID = this.item;
        var $item = $(`#${this.item}`);
        var itemLabel = $(`#${itemID}_LABEL`).text();
        var linkTarget;
        var linkText;
        
        // APEX-Fehlerklasse und -meldung an das Element hängen
        $item
        .addClass(C_APEX_ERROR_CLASS)
        .siblings('span').remove();
        $item.parent().append(`<span class='t-Form-error'>${this.message}</span>`);
        
        // Fehlerregion aktualisieren
        // Fehlermeldung in Fehlerregion erhält Link auf das Feld (Gehe zu Fehler) sowie ID zum selektiven Löschen
        linkTarget = `javascript: apex.item('${itemID}').setFocus();void(0);`;
        linkText = `Gehe zu Fehler: <span class='ek-itemLabelText'>${itemLabel}</span>`;
        
        // Teil eines Caroussels? Dann Link überarbeiten
        var $carousel = $item.closest(C_CAROUSEL_SEL);
        if ($carousel.length){
          var carouselId = $carousel.attr('id');
          var carouselName = $carousel.children('div[data-label]').data('label');
          $(`a.a-Region-carouselLink[href="#${carouselID}"]`).addClass(C_CAROUSEL_ERROR_CLASS);
          linkTarget.replace('javascript: ', `javascript: $("a.a-Region-carouselLink[href='#${carouselId}']").click();`);
          linkText += ` im Register: ${carouselName}`;
        }
        
        // Fehler als LI in Fehlerregion einfügen
        $(C_ERROR_UL_SEL).append(`<li class='htmldbStdErr ${itemID}'>${this.message} (<a href=${linkTarget}>${linkText}</a>)</li>`);
	    });
    };
  };  

  /**
   * Die Methode prüft, ob das Plugin abhängige Elemente verwaltet und steuert deren Aktivität abhängig davon,
   * ob auf der Seite Fehler angezeigt werden oder nicht.
   */
  function maintainDependentElements(errorList){
    if (errorList.errorDependentButtons != null && errorList.errorDependentButtons != ''){
      var errorDependentButtons = errorList.errorDependentButtons.split(',');
      if ($(C_APEX_ERROR_CLASS_SEL).length == 0){
        $.each(errorDependentButtons, function() {
          apex.item(this).enable();
        });
      }
      else {
        $.each(errorDependentButtons, function() {
          apex.item(this).disable();
        });
      };
    };
  };

  
  /** 
   * Methode sendet die Seite ab, falls keine Fehler auf der Seite gefunden werden.
   */
  sct.submitPage = function(request, message){
    if ($(C_APEX_ERROR_CLASS_SEL).length == 0) {
      apex.submit(request);
    }
    else{
      alert(message);
    }
  };
  
  
  /**
   * Methode zur Steuerung der Darstellung von Pflichtelementen
   */
  sct.setFieldMandatory = function(item, mandatory){
    var $mandatoryItem = $(`#${item}_LABEL`);
    // evtl. vorhandene Markierung entfernen
    $mandatoryItem.siblings(C_REQUIRED_SPAN_SEL).remove();
    
    if(mandatory){
      $mandatoryItem.parent().append(C_FIELD_REQUIRED_TEMPLATE);
    }
  };
  
  
  /**
   * Methode, um Fehler auf der Seite zu verwalten.
   */
  sct.maintainErrors = function(errorList){
    if (errorList.firingItems != '' || errorList.firingItems != ''){      
      removeErrors(errorList);
      setErrors(errorList);
      setMessage();
    }
    else {
      if ($(C_ERROR_CLASS_SEL).length > 0){
        // beim Seiteladen, eventuell in der Meldungsregion vorhandene Fehler mit unseren Klassen versehen
        // können nur Fehler enthalten sein, die aus der APEX-Seitenverarbeitung resultieren
        // Vermerke in diesen Fehlern die ID des referenzierten Elements um selektiven Löschen über JavaScript
        $(`${C_ERROR_CLASS_SEL} li.htmldbStdErr a`).each(function(){
          var itemLink = $(this).attr('href');
          var itemName = itemLink.match('apex.item(.*).setFocus')[1].replace(/('\(\))/g, '');
          $(this).closest('li').addClass(itemName);
        });
      };
    };
    // In jedem Fall fehlerabhängige Elemente aktualisieren
    maintainDependentElements(errorList);
  };
  
  
  /**
   * Methode zur Anzeige einer Nachricht auf der Oberfläche
   */
  sct.setNotification = function(message){
    sct.clearNotification;
     if ($(`${C_ERROR_CLASS_SEL} ${C_APEX_ERROR_ID_SEL}`).length == 0){
      // Es ist keine Fehlerregion auf der Seite vorhanden, anzeigen
      if ($(C_ERROR_DIALOG_POSITION_SEL).length){ 
        // Es wird eine modale Seite angezeigt
        $(C_ERROR_DIALOG_POSITION_SEL).prepend(C_PAGE_NOTIFICATION_TEMPLATE);
      }
      else{
        $(C_ERROR_REGION_POSITION_SEL).prepend(C_PAGE_NOTIFICATION_TEMPLATE);
      }
    };
    $(C_MESSAGE_TITLE_SEL).text(message);    
    $('.t-Button--closeAlert').on('click', sct.clearNotification);
  };
  
  
  /**
   * Methode zur Darstellung einer Bestätigungsnachricht auf der Seite
   */
  sct.confirmRequest = function(e, callback){
    apex.dialog.confirm(e.data.message,e.data.title).then(function (answer) {
      if(answer == "true"){
         callback(e);
      };
    });
  };
  
  
  sct.disableElement = function (item){
    // Normales Element, nicht deaktivieren, da ansonsten Sessionstate nicht gefüllt wird.
    // Stattdessen readonly und CSS-Klasse setzen, so dass es wie deaktiviert aussieht
    $('#item').prop('readonly', true).addClass('sct-disabled');
    
      $this = $(item);
      var itemId = $this.attr('id');
      if ($this.is('select')){
        // Select-Liste, deaktiviere alle Einträge außer dem gewählten
        $(`#${itemId}:not(:selected)`).prop('disabled', false);
      }
      else if ($this.is('button')){
        // Button, wird »normal« aktiviert
        apex.item(itemId).enable();
      }
      else if ($this.is('input')){
        sct.ApexJS.enableElement(itemId);
      };
      apex.item(itemId).show();
  };
  
  
  sct.enableElement = function (item){
    // Normales Element, nicht deaktivieren, da ansonsten Sessionstate nicht gefüllt wird.
    // Stattdessen readonly und CSS-Klasse setzen, so dass es wie deaktiviert aussieht
    $('#item').prop('readonly', false).removeClass('sct-disabled');
    
      $this = $(item);
      var itemId = $this.attr('id');
      if ($this.is('select')){
        // Select-Liste, deaktiviere alle Einträge außer dem gewählten
        $(`#${itemId}:not(:selected)`).prop('disabled', false);
      }
      else if ($this.is('button')){
        // Button, wird »normal« aktiviert
        apex.item(itemId).enable();
      }
      else if ($this.is('input')){
        sct.ApexJS.enableElement(itemId);
      };
      apex.item(itemId).show();
      
      /** TODO Erweiterung integrieren:
      
	// wenn es sich bei dem Seitenelement um ein Datumsfeld handelt, dann auch die Schaltflaeche
	// zur Datumsauswahl aktivieren
	if (itemId.hasClass("hasDatepicker")) {
		itemId.parent().find("button").prop('readonly', false).removeClass(C_APEX_DISABLED_CLASS);
	}

	// wenn es sich bei dem Seitenelement um ein Farbfeld handelt, dann auch die Schaltflaeche
	// zur Farbauswahl aktivieren
	else if (itemId.hasClass("color_picker")) {
		$('#' + pItem + '_fieldset').prop('readonly', false).removeClass(C_APEX_DISABLED_CLASS);
	}

	// wenn es sich bei dem Seitenelement um eine Popup-Liste handelt, dann auch die Schaltflaeche
	// zur Auswahl der Listeneintraege aktivieren
	else if (itemId.hasClass("popup_lov")) {
		itemId.closest('#' + pItem + '_fieldset').find('.a-Button--popupLOV')
		   .prop('readonly', false).removeClass(C_APEX_DISABLED_CLASS);
	};
  */
  };
  
  
  /**
   * Methode zum Entfernen einer Benachrichtigung auf der Option
   */
  sct.clearNotification = function(){
    $(`${C_ERROR_CLASS_SEL} ${C_APEX_NOTIFICATION_ID_SEL}`).parent().remove();     
  };
})(de.condes.plugin.sct.apex_42_5_0);





 // Version 5.1, Theme 42
(function(sct, msg){

  var C_APEX_ERROR_CLASS_SEL = 'div.a-Notification--error';

  // Die Methode setErrors wird von Response aufgerufen und darf daher nicht umbenannt oder entfernt werden
  /**
   * Die Methode behandelt alle Einzelfehler aus errorList, bereinigt die bestehende Fehlerliste
   * und fügt die neuen Fehler hinzu.
   */
  function setErrors(errorList) {

    // Alle Einzelfehler behandeln und auf apex.message.errorObject abbilden
    apex.debug.log(`Anzahl Fehler PlugIn: ${errorList.count}`);
    msg.clearErrors();
	
    if (errorList.errors.count > 0){
      msg.showErrors(errorList.errors);
    }
  };

  /**
   * Die Methode prüft, ob das Plugin abhängige Elemente verwaltet und steuert deren Aktivität abhängig davon,
   * ob auf der Seite Fehler angezeigt werden oder nicht.
   */
  function maintainDependentElements(errorList){
    if (errorList.errorDependentButtons != null && errorList.errorDependentButtons != ''){
      var errorDependentButtons = errorList.errorDependentButtons.split(',');
      if ($(C_APEX_ERROR_CLASS_SEL).length == 0){
        $.each(errorDependentButtons, function() {
          apex.item(this).enable();
        });
      }
      else {
        $.each(errorDependentButtons, function() {
          apex.item(this).disable();
        });
      };
    };
  };

  
  /** 
   * Methode sendet die Seite ab, falls keine Fehler auf der Seite gefunden werden.
   */
  sct.submitPage = function(request, message){

    if ($(C_APEX_ERROR_CLASS_SEL).length == 0) {
      apex.page.submit({
        "request" : request,
        "showWait" : true
      });
    }
    else{
      msg.alert(message);
    }
  };
  
  
  /**
   * Methode zur Steuerung der Darstellung von Pflichtelementen
   */
  sct.setFieldMandatory = function(item, mandatory){

    var $mandatoryItem = $(`#${item}_CONTAINER`);
    var C_REQUIRED_CLASS = 'is-required';

    // evtl. vorhandene Markierung entfernen
    $mandatoryItem.removeClass(C_REQUIRED_CLASS);
    
    if(mandatory){
      $mandatoryItem.addClass(C_REQUIRED_CLASS);
    }
  };
  
  
  /**
   * Methode, um Fehler auf der Seite zu verwalten.
   */
  sct.maintainErrors = function(errorList){
    msg.clearErrors()
    if(errorList.count > 0){
      msg.showErrors(errorList.errors);
    }
    // In jedem Fall fehlerabhängige Elemente aktualisieren
    // maintainDependentElements(errorList);
  };
  
  
  /**
   * Methode zur Anzeige einer Nachricht auf der Oberfläche
   */
  sct.setNotification = function(message){
    msg.hidePageSuccess();
    msg.showPageSuccess(message);
  };
  
  
  /**
   * Methode zum Entfernen einer Benachrichtigung auf der Option
   */
  sct.clearNotification = function(){
    msg.hidePageSuccess();
  };

})(de.condes.plugin.sct.apex_42_5_1, apex.message);
