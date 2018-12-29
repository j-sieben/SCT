var de = de || {};
de.condes = de.condes || {};
de.condes.plugin = de.condes.plugin || {};
de.condes.plugin.sct = de.condes.plugin.sct || {};
de.condes.plugin.sct.ui = {};

/**
 * @namespace de.condes.plugin.sct.ui
 * @since 5.0
 * @desc
 * <p>IIFE to implement common SCT-UI helper methods to support the SCT administration application</p>
 * @param {Object} sct This code
 */
(function(sct){
  "use strict";

  /** 
   * Method to hide the Interactive Report media bar. You can prevent the action menu from showing but not the filter bar if a report filter/format
   * has been set. This method removes this to streamline the appearance of IR reports.</p>
   * @param {string} id Static ID of the interactive report region
   */
  sct.HideIRControlPanel = function(id){
    $(`#${id}_control_panel`).hide();
    $(`#${id} tr`).attr('style', 'vertical-align:top');
  };
})(de.condes.plugin.sct.ui);