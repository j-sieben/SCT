create or replace package sct_admin
  authid current_user
as 
  
  /** Package to implement all functionality around maintaining SCT rules
   * @headcom  
   **/
  
  /** Package constants */
  C_VIEW_NAME_PREFIX constant varchar2(25) := 'SCT_RULES_GROUP_';
    
  /** Method to map technical IDs upon import or copying of rule groups
   * @param [p_id] ID to map to a new ID. If NULL, the mapping list is initialized
   * @usage  As it is not know beforhand which ID an entry in a table will get, this method maintains a mapping table
   *         that maps the original ID to the newly created IDs from a sequence.
   *         If the ID passed in is not found in the table, it returns the newly created ID.
   *         If the ID is found in the table, the method returns the mapped ID.
   *         Before an import of a rule group can take place, this method needs to be called with a NULL parameter to
   *         initialize a new mapping table.
   */   
  function map_id(
    p_id in number default null)
    return number;
  
  /** Administration of RULE GROUPS
   * @param  p_sgr_app_id          APEX application id
   * @param  p_sgr_page_id         APEX application page id
   * @param  p_sgr_id              Technical ID of the rule group. Upon script based import this parameter is used as
   *                               a foreign key for rules in order to organize the relationship even if new IDs are created
   * @param  p_sgr_name            Displaytext of the rule group
   * @param  p_sgr_description     Optional description of the rule group
   * @param  p_sgr_with_recursion  Flag to indicate whehter this rule allows recursive calls
   * @param [p_sgr_active]         Flag to indicate, whether this rule group is actually used. Defaults to SCT_UTIL.C_TRUE
   * @usage  Is used to create a rule group.
   */
  procedure merge_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_sgr_description in sct_rule_group.sgr_description%type,
    p_sgr_with_recursion in sct_rule_group.sgr_with_recursion%type,
    p_sgr_active in sct_rule_group.sgr_active%type default sct_util.C_TRUE);
    
  /** Overload with a record to make communication with the UI easier */
  procedure merge_rule_group(
    p_row in out nocopy sct_rule_group%rowtype);
    
    
  /** Method to delete a rule group
   * @param  p_sgr_id  Technical ID of the rule group to delete
   * @usage  Is called from the SCT UI to remove a rule group
   */
  procedure delete_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type);
  
  /** Overlaod with a rowtype record. This sometimes is easier, fi if a composed PK exists or a rowtype record exists anyway */
  procedure delete_rule_group(
    p_row in out nocopy sct_rule_group%rowtype);
    
    
  /** Method to propagate that a rule has changed.
   * @paramn p_sgr_id  ID of the rule group that has changed
   * @usage  Is used to propagate any rule change after a rule has been edited.
   *         Method checks whether rule group is valid, maintains the internal page item mappings and
   *         recreates the rule group view with the conditions of the rule group.
   *         The export script calls this method automatically after a rule group has been imported completely
   */
  procedure propagate_rule_change(
    p_sgr_id in sct_rule_group.sgr_id%type);
  
  
  /** Method to check a rule group
   * @param  p_sgr_id  Rule group ID to check
   * %return Returns an error message if any error has occurred
   * @usage  Is called before a rule group is exported.
   */
  function validate_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2;
    
    
  /** Method to copy a rule group between APEX applications
   * @param  p_sgr_id          Name der Regelgruppe, die kopiert werden soll
   * @param  p_sgr_app_id_to   APEX application id of the application the rule is to be copied to
   * @param  p_sgr_page_id_to  APEX application page id of the application the rule is to be copied to
   * @usage  Is used to copy an existing rule group between APEX applications of the same workspace.
   */
  procedure copy_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_app_id_to in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id_to in sct_rule_group.sgr_page_id%type);
    
    
  /** Method to export one or more rule groups
   * @param [p_sgr_app_id]         APEX application ID of the application of which all rule groups are to be exported
   * @param [p_sgr_id]             Rule group ID of the rule group that is to be exported
   * @param [p_sgr_app_id_map_to]  If a rule group is copied, this parameter defines the target application id
   * @param [p_sgr_page_id_map_to] If a rule group is copied, this parameter defines the target application page id
   * @usage  Based on the parameters passed in this method will export one or more rule groups.
   *         If no parameter is passed in, all existing rule groups are exported.
   *         If parameter P_SGR_APP_ID is passed in and P_SGR_ID is null, all rule groups of the respective APEX application
   *         will be exported.
   *         If parameter P_SGR_ID is passed in and P_SGR_APP_ID is null, only the mentioned rule group is exported.
   *         If parameter P_SGR_ID is not null and P_SGR_APP_ID is not null, P_SGR_APP_ID must point to the application in which
   *         P_SGR_ID exists. Otherwise, no rule group is exported and an exception is thrown.
   */
  function export_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type default null,
    p_sgr_id in sct_rule_group.sgr_id%type default null,
    p_sgr_app_id_map_to in sct_rule_group.sgr_app_id%type default null,
    p_sgr_page_id_map_to in sct_rule_group.sgr_id%type default null)    
    return clob;
    
  
  /** Method to prepare a rule group import
   * @param  p_workspace  Workspace name of the workspace the application is to be installed at
   * @param  p_app_alias  Application alias, used to gather the actual application ID
   * @usage  This method is called before a script based import of a rule group occurs to make sur that the actual
   *         application ID of the referenced application is used. This ID is taken using the application alias
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2);
    
  /** Overload, is used when no application alias is used but the ID of the application is known upon installation time
   */
  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in sct_rule_group.sgr_app_id%type);
    
  /** Another overload */
  procedure prepare_rule_group_import(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type);
    
    
  /** Administration of APEX ACTION TYPES
   * @param  p_sty_id            Technical ID
   * @param  p_sty_display_name  Display name of the action type
   * @param  p_sty_description   Optional description
   */
  procedure merge_apex_action_type(
    p_sty_id in sct_apex_action_type.sty_id%type,
    p_sty_name in pit_translatable_item.pti_name%type,
    p_sty_description in pit_translatable_item.pti_description%type,
    p_sty_active in sct_apex_action_type.sty_active%type);
    
  procedure merge_apex_action_type(
    p_row in out nocopy sct_apex_action_type_v%rowtype);
    
  procedure delete_apex_action_type(
    p_sty_id in sct_apex_action_type.sty_id%type);
    
  procedure delete_apex_action_type(
    p_row in out nocopy sct_apex_action_type_v%rowtype);
    

  /** Administration of APEX ACTIONS
   * @param  p_saa_sgr_id               Reference to a rule group
   * @param  p_saa_name                 APEX action name as referenced by apex.actions as data-<name> attribute.
   * @param  p_saa_sty_id                 Type of Action (ACTION|TOGGLE|RADIO_GROUP),
   * @param  p_saa_label                Display name,
   * @param [p_saa_context_label]       Extended name, is used in select list or on the UI
   * @param [p_saa_icon]                Icon of the action
   * @param [p_saa_icon_type]           Icontype. Standard: fa
   * @param [p_saa_title]               Tooltip of the action
   * @param [p_saa_shortcut]            Shortcut as defined in apex.actions, fi. ALT-A
   * @param [p_saa_href]                (Type ACTION only): HREF attribute of the action. Only one of HREF or ACTION allowed
   * @param [p_saa_action]              (Type ACTION only): JavaScript function that is executed if the action is invoked. Only one of HREF or ACTION allowed
   * @param [p_saa_on_label]            (Type TOGGLE only): Label if apex action is enabled
   * @param [p_saa_off_label]           (Type TOGGLE only): Label if apex action is disabled
   * @param [p_saa_get]                 (Type TOGGLE and RADIO_GROUP only):
   *                                      If TOGGLE: Method that returns true or false
   *                                      If RADIO_GROUP: Method that returns the actual value of the item
   * @param [p_saa_set]                 (Type TOGGLE and RADIO_GROUP only):
   *                                      If TOGGLE: Method that sets the value to TRUE|FALSE
   *                                      If RADIO_GROUP: Method that sets the item value
   * @param [p_saa_choices]             (Type RADIO_GROUP only): List of options
   * @param [p_saa_label_classes]       (Type RADIO_GROUP only): CSS label classes for all entries
   * @param [p_saa_label_start_classes] (Type RADIO_GROUP only): CSS label classes for first entry
   * @param [p_saa_label_end_classes]   (Type RADIO_GROUP only): CSS label classes for last entry
   * @param [p_saa_item_wrap_class]     (Type RADIO_GROUP only): CSS label classes for wrapping elements
   */
  procedure merge_apex_action(
    p_saa_id in sct_apex_action.saa_id%type,
    p_saa_sgr_id in sct_apex_action.saa_sgr_id%type,
    p_saa_sty_id in sct_apex_action.saa_sty_id%type,
    p_saa_name in sct_apex_action.saa_name%type,
    p_saa_label in sct_apex_action.saa_label%type,
    p_saa_context_label in sct_apex_action.saa_context_label%type default null,
    p_saa_icon in sct_apex_action.saa_icon%type default null,
    p_saa_icon_type in sct_apex_action.saa_icon_type%type default 'fa',
    p_saa_title in sct_apex_action.saa_title%type default null,
    p_saa_shortcut in sct_apex_action.saa_shortcut%type default null,
    p_saa_initially_disabled in sct_apex_action.saa_initially_disabled%type default 0,
    p_saa_initially_hidden in sct_apex_action.saa_initially_hidden%type default 0,
    -- ACTION
    p_saa_href in sct_apex_action.saa_href%type default null,
    p_saa_action in sct_apex_action.saa_action%type default null,
    -- TOGGLE
    p_saa_on_label in sct_apex_action.saa_on_label%type default null,
    p_saa_off_label in sct_apex_action.saa_off_label%type default null,
    -- TOGGLE | RADIO_GROUP
    p_saa_get in sct_apex_action.saa_get%type default null,
    p_saa_set in sct_apex_action.saa_set%type default null,
    -- RADIO_GROUP
    p_saa_choices in sct_apex_action.saa_choices%type default null,
    p_saa_label_classes in sct_apex_action.saa_label_classes%type default null,
    p_saa_label_start_classes in sct_apex_action.saa_label_start_classes%type default null,
    p_saa_label_end_classes in sct_apex_action.saa_label_end_classes%type default null,
    p_saa_item_wrap_class in sct_apex_action.saa_item_wrap_class%type default null);  
    
  
  procedure merge_apex_action(    
    p_row in out nocopy sct_apex_action%rowtype);  
    
  procedure delete_apex_action(    
    p_saa_id sct_apex_action.saa_id%type);  
    
  procedure delete_apex_action(    
    p_row in out nocopy sct_apex_action%rowtype);  

  /** Administration of APEX ACTION ITEMS
   * @param  p_sai_saa_id      Reference to a SCT_APEX_ACTION
   * @param  p_sai_spi_sgr_id  ID of the rule group, Reference to SCT_PAGE_ITEM
   * @param  p_sai_spi_id      Page item, Reference to SCT_PAGE_ITEM
   * @param [p_sai_active]     Flag to indicate whether this apex action item is actually used. Defaults to SCT_UTIL.C_TRUE
   */
  procedure merge_apex_action_item(
    p_sai_saa_id     in sct_apex_action_item.sai_saa_id%type,
    p_sai_spi_sgr_id in sct_apex_action_item.sai_spi_sgr_id%type,
    p_sai_spi_id     in sct_apex_action_item.sai_spi_id%type,
    p_sai_active     in sct_apex_action_item.sai_active%type default sct_util.C_TRUE);
    
  procedure merge_apex_action_item(
    p_row sct_apex_action_item%rowtype);

  procedure delete_apex_action_item(
    p_row sct_apex_action_item%rowtype);
        
    
  /** Administration of RULES *
   * @param  p_sru_id         ID of the rule
   * @param  p_sru_sgr_id     ID of the rule group
   * @param  p_sru_name       Name of the rule
   * @param  p_sru_condition  rule condition
   * @param  p_sort_seq       Sort criteria for the rule
   * @param [p_sru_active]    Flag to indicate whether this rule is actually executed. Defaults to SCT_UTIL.C_TRUE
   */
  procedure merge_rule(
    p_sru_id in sct_rule.sru_id%type default null,
    p_sru_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_name in sct_rule.sru_name%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_sru_fire_on_page_load in sct_rule.sru_fire_on_page_load%type,
    p_sru_sort_seq in sct_rule.sru_sort_seq%type,
    p_sru_active in sct_rule.sru_active%type default sct_util.C_TRUE);
    
  procedure merge_rule(
    p_row in out nocopy sct_rule%rowtype);


  procedure delete_rule(
    p_sru_id in sct_rule.sru_id%type);
  
  procedure delete_rule(
    p_row in out nocopy sct_rule%rowtype);
    
    
  /** Method to validate a rule
   * @param  p_sgr_id         ID of the rule group
   * @param  p_sru_condition  rule condition to check
   * @param  p_error          Error message that is returned if the check raises an error
   * @usage  Is used to validate a rule condition
   */
  procedure validate_rule(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2);
    
    
  /** Helper to resequence rules and rule actions
   * @param  p_sru_id  Rule group ID
   * @usage  Is called automatically upon change of a rule to resequence all entries in steps of 10
   */
  procedure resequence_rule(
    p_sru_id in sct_rule.sru_id%type);

 
  /** Administration of ACTION TYPE GROUPS
   * @param  p_stg_id           ID of the action type group
   * @param  p_srg_name         Name of the action type group
   * @param  p_stg_description  Optional description of the action type group
   * @param [p_stg_active]      Flag to indicate whether this action type group is actually in use. Defaults to SCT_UTIL.C_TRUE
   */
  procedure merge_action_type_group(
    p_stg_id in sct_action_type_group.stg_id%type,
    p_stg_name in pit_translatable_item.pti_name%type,
    p_stg_description in pit_translatable_item.pti_description%type,
    p_stg_active in sct_action_type_group.stg_active%type default sct_util.C_TRUE);
    
  procedure merge_action_type_group(
    p_row in out nocopy sct_action_type_group_v%rowtype);
    
    
  procedure delete_action_type_group(
    p_stg_id in sct_action_type_group.stg_id%type);
    
  procedure delete_action_type_group(
    p_row in out nocopy sct_action_type_group_v%rowtype);

 
  /** Administration of ACTION PARAMETER TYPES
   * @param  p_spt_id           ID of the action parameter type
   * @param  p_spt_name         Name of the action parameter type
   * @param  p_spt_description  Optional description
   * @param  p_spt_item_type    Choice of input item type for this parameter type, one of SELECT_LIST|TEXT_AREA|TEXT
   *                            If set to SELECT_LIST, a view of name SCT_PARAM_LOV_<SPT_ID> must be provided to calculate
   *                            the available values. This list may be filtered using SGR_ID.
   * @param [p_spt_active]      Flag to indicate whether this action parameter type is used. Defaults to SCT_UTIL.C_TRUE
   */
  procedure merge_action_param_type(
    p_spt_id in sct_action_param_type.spt_id%type,
    p_spt_name in pit_translatable_item.pti_name%type,
    p_spt_description in pit_translatable_item.pti_description%type,
    p_spt_item_type in sct_action_param_type.spt_item_type%type,
    p_spt_active in sct_action_param_type.spt_active%type default SCT_UTIL.C_TRUE);

  procedure merge_action_param_type(
    p_row in out nocopy sct_action_param_type_v%rowtype);
    

  procedure delete_action_param_type(
    p_spt_id in sct_action_param_type.spt_id%type);
    
  procedure delete_action_param_type(
    p_row in sct_action_param_type_v%rowtype);
    
 
  /** Administration of ACTION ITEM FOCUS */    
  /** Methode zur Erzeugung eines ITEM-Fokus
   * @param  p_sif_id           ID des Aktionstyps
   * @param  p_sif_name         Klartextbezeichnung des Aktions-Parametertyps
   * @param  p_sif_description  Optionale Beschreibung, wird als Hilfstext angezeigt
   * @param [p_sif_active]      Flag, das anzeigt, ob dieser Parametertyp verwendet wird. Defaults to SCT_UTIL.C_TRUE
   * @usage  Wird verwendet, um den ITEM-Focus einer Aktion zu definieren
   */
  procedure merge_action_item_focus(
    p_sif_id in sct_action_item_focus.sif_id%type,
    p_sif_name in pit_translatable_item.pti_name%type,
    p_sif_description in pit_translatable_item.pti_description%type,
    p_sif_actual_page_only in sct_action_item_focus.sif_actual_page_only%type default sct_util.C_TRUE,
    p_sif_item_types in sct_action_item_focus.sif_item_types%type,
    p_sif_active in sct_action_item_focus.sif_active%type default sct_util.C_TRUE);
    
  procedure merge_action_item_focus(
    p_row in out nocopy sct_action_item_focus_v%rowtype);
    
    
  procedure delete_action_item_focus(
    p_sif_id in sct_action_item_focus.sif_id%type);    
    
  procedure delete_action_item_focus(
    p_row in out nocopy sct_action_item_focus_v%rowtype);
           
    
  /** Administration of ACTION TYPES
   * @param  p_sat_id               ID of the action type
   * @param  p_sat_stg_id           Reference to SCT_ACTION_TYPE_GROUP
   * @param  p_sat_sif_id           Reference to SCT_ACTION_ITEM_FOCUS
   * @param  p_sat_name             Name of the action type
   * @param  p_sat_description      Optional description
   * @param  p_sat_pl_sql           PL/SQL code that is to be executed
   * @param  p_sat_js               JavaScript code that is to be executed
   * @param [p_sat_is_editable]     Flag to indicate whether this action type is editable by the end user
   * @param [p_sat_raise_recursive] Flag to indicate whether this action type allow recursive calls of rules
   */
  procedure merge_action_type(
    p_sat_id in sct_action_type.sat_id%type,
    p_sat_stg_id in sct_action_type_group.stg_id%type,
    p_sat_sif_id in sct_action_item_focus.sif_id%type,
    p_sat_name in pit_translatable_item.pti_name%type,
    p_sat_description in pit_translatable_item.pti_description%type default null,
    p_sat_pl_sql in sct_action_type.sat_pl_sql%type,
    p_sat_js in sct_action_type.sat_js%type,
    p_sat_is_editable in sct_action_type.sat_is_editable%type default sct_util.C_TRUE,
    p_sat_raise_recursive in sct_action_type.sat_raise_recursive%type default sct_util.C_TRUE);
    
  procedure merge_action_type(
    p_row in sct_action_type_v%rowtype);
    
  procedure delete_action_type(
    p_sat_id in sct_action_type.sat_id%type);
    
  procedure delete_action_type(
    p_row in sct_action_type_v%rowtype);

  
  /** Method to export an action type
   * @param  p_sat_is_editable  Controls, which SCT rules to export:
   *                            - C_TRUE: User defined action types
   *                            - C_FALSE: Internally defined action types
   *                            - NULL: Both, internally and user defined action types
   * @usage  Creates a CLOB instance with the requested action types for export
   */
  function export_action_types(
    p_sat_is_editable in sct_action_type.sat_is_editable%type default sct_util.C_TRUE)
    return clob;

 
  /** Adminsitration of ACTION PARAMETERS
   * @param  p_sap_sat_id      Reference to SCT_ACTION_TYPE
   * @param  p_sap_spt_id      Reference to SCT_ACTION_PARAMETER_TYPE
   * @param  p_sap_sort_seq    Sort order and restriction of number of parameters
   * @param  p_sap_default     Optional standard value of the parameter
   * @param  p_sap_description Optional description
   * @param  p_sap_mandatory   Flag to indicate whether this action parameter is required
   * @param [p_sap_active]     Flag to indicate whether this action parameter is in use. Defaults to SCT_UTIL.C_TRUE
   */
  procedure merge_action_parameter(
    p_sap_sat_id in sct_action_parameter.sap_sat_id%type,
    p_sap_spt_id in sct_action_parameter.sap_spt_id%type,
    p_sap_sort_seq in sct_action_parameter.sap_sort_seq%type,
    p_sap_default in sct_action_parameter.sap_default%type,
    p_sap_description in pit_translatable_item.pti_description%type,
    p_sap_display_name in pit_translatable_item.pti_name%type,
    p_sap_mandatory in sct_action_parameter.sap_mandatory%type,
    p_sap_active in sct_action_parameter.sap_active%type default sct_util.C_TRUE);
    
  procedure merge_action_parameter(
    p_row in out nocopy sct_action_parameter_v%rowtype);
    
    
  procedure delete_action_parameter(
    p_row in sct_action_parameter_v%rowtype);
    
    
  /** Administration of RULE ACTIONS 
   * @param  p_sra_id               ID of the rule action
   * @param  p_sra_sru_id           Reference to SCT_RULE
   * @param  p_sra_sgr_id           Reference to SCT_RULE_GROUP
   * @param  p_sra_spi_id           Reference to SCT_PAGE_ITEM
   * @param  p_sra_sat_id           Reference to SCT_ACTION_TYPE
   * @param  p_sra_param_1          Optional parameter 1
   * @param  p_sra_param_2          Optional parameter 2
   * @param  p_sra_param_3          Optional parameter 3
   * @param  p_sort_seq             Sort criteria to organize the order of execution
   * @param [p_sra_on_error]        Flag to indicate whether this action is executed as an error handler for that rule. 
   *                                Defaults to SCT_UTIL.C_FALSE
   * @param [p_sra_raise_recursive] Flag to indicate whether this action allows recursive executions of other rules. 
   *                                Defaults to SCT_UTIL.C_TRUE
   * @param [p_sra_active]          Flag to indicate whether this rule action is in use. Defaults to SCT_UTIL.C_TRUE
   * @param [p_sra_comment]         Optional developer comment
   */
  procedure merge_rule_action(
    p_sra_id in sct_rule_action.sra_id%type,
    p_sra_sru_id in sct_rule.sru_id%type,
    p_sra_sgr_id in sct_rule_group.sgr_id%type,
    p_sra_spi_id in sct_page_item.spi_id%type,
    p_sra_sat_id in sct_action_type.sat_id%type,
    p_sra_param_1 in sct_rule_action.sra_param_1%type default null,
    p_sra_param_2 in sct_rule_action.sra_param_2%type default null,
    p_sra_param_3 in sct_rule_action.sra_param_3%type default null,
    p_sra_sort_seq in sct_rule_action.sra_sort_seq%type,
    p_sra_on_error in sct_rule_action.sra_on_error%type default sct_util.C_FALSE,
    p_sra_raise_recursive in sct_rule_action.sra_raise_recursive%type default sct_util.C_TRUE,
    p_sra_active in sct_rule_action.sra_active%type default sct_util.C_TRUE,
    p_sra_comment in sct_rule_action.sra_comment%type default null);
    
  procedure merge_rule_action(
    p_row in out nocopy sct_rule_action%rowtype);
  
  
  procedure delete_rule_action(
    p_sra_id in sct_rule_action.sra_id%type);    
  
  procedure delete_rule_action(
    p_row in out nocopy sct_rule_action%rowtype);
    
    
  /** Method to add translated data 
   * @param  p_table_shortcut  Prefix that is used in the respective table. Will prefix the translated PTI_ID
   * @param  p_item_id         Name of the item for which a translation needs to be added
   * @param  p_pmg_name        Name of the language. One of the Oracle supported language names
   * @param  p_name            Translation for names
   * @param  p_display_name    Translation for display names
   * @param  p_description     Translation for descriptions and help texts
   * @usage  Is used to add translated names and descriptions for existing entries in the tables of SCT
   */
  procedure add_translation(
    p_table_shortcut in varchar2,
    p_item_id in varchar2,
    p_pml_name pit_message_language.pml_name%type,
    p_name in pit_translatable_item.pti_name%type,
    p_display_name in pit_translatable_item.pti_display_name%type,
    p_description in pit_translatable_item.pti_description%type);
    
end sct_admin;
/