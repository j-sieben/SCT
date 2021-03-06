create or replace package plugin_sct
  authid definer
as

  /** Package PLUGIN_SCT to maintain State Charts as a dynamic action plugin
   * @author Juergen Sieben, ConDeS GmbH
   * @usage  Used to implement the plugin logic of SCT.
   * @headcom
   */

  /* Standard PLUGIN interface */
  /** Render method */
  function render(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_render_result;


  /** AJAX method */
  function ajax(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_dynamic_action_ajax_result;

end plugin_sct;
/