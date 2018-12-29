var sct = sct || {};

(function(sct){
  sct.HideIRControlPanel(id){
    $(`#${id}_control_panel`).hide();
    $(`#${id}`).attr('style', 'vertical-align:top');
  };
})(sct);