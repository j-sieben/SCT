create or replace package body sct_admin
as

  C_PKG constant sct_util.ora_name_type := $$PLSQL_UNIT;
  C_SCT constant utl_text_templates.uttm_type%type := 'SCT';
  C_FRAME constant sct_util.ora_name_type := 'FRAME';
  C_DEFAULT constant sct_util.ora_name_type := 'DEFAULT';
  
  C_REGEX_ITEM constant varchar2(50 byte) := q'~(^|[ '\(])#ITEM#([ ',=<^>\)]|$)~';
  C_REGEX_CSS constant varchar2(50 byte) := q'~'.+'~';
  
  /* Globale Variablen */
  g_offset binary_integer;
  
  -- PL/SQL-Tabelle zum Mappen alter IDs auf neue. Wird beim Kopieren von Regelgruppen verwendet
  type id_map_t is table of binary_integer index by binary_integer;
  g_id_map id_map_t;
  
  
  /* Method to generate initialization code that copies initial page item values to the session state
   * %param  p_sgr_id  Rule group ID
   * %return Anonymous PL/SQL block that copies the actual session state values into the session state
   * %usage  Is used to copy initial values into the session state during page rendering. This is required to assure that
   *         any rule that is based on certain session state values is processed at initialization time
   */
  function create_initialization_code(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    l_initialization_code varchar2(32767);
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
      with params as (
           -- Get common values, depending on whether the page contains a DML_FETCH_ROW process
           select sgr.sgr_id, sct_util.C_CR cr,
                  uttm.uttm_name, uttm.uttm_mode, uttm.uttm_text template, 
                  app.attribute_02, app.attribute_03, app.attribute_04, app.application_id, app.page_id
             from apex_application_page_proc app
             join sct_rule_group sgr
               on app.application_id = sgr.sgr_app_id
              and app.page_id = sgr.sgr_page_id
            cross join utl_text_templates uttm
            where app.process_type_code = 'DML_FETCH_ROW'
              and uttm_type = C_SCT
              and uttm_name like 'INITIALIZE%'
              and sgr.sgr_id = p_sgr_id)
    select utl_text.generate_text(cursor(
             select template,
                    cr,
                    -- select statement to select the actual page values from the table referenced by the DML_FETCH_ROW process
                    utl_text.generate_text(cursor(
                      select p.template, p.attribute_02, p.attribute_03, p.attribute_04
                        from params p
                       where p.uttm_mode = case p.attribute_04 when 'ROWID' then p.attribute_04 else 'DEFAULT' end
                         and p.uttm_name = 'INITIALIZE_COLUMN'), ',' || sct_util.C_CR) sql_stmt,
                    -- generate sct_util.set_session_state calls for any page element
                    utl_text.generate_text(cursor(         
                      select p.template, sit.sit_init_template, spi.spi_conversion,
                             api.item_name, api.item_source
                        from params p
                        join apex_application_page_items api
                          on p.application_id = api.application_id
                         and p.page_id = api.page_id
                        join sct_page_item spi
                          on p.sgr_id = spi.spi_sgr_id
                         and api.item_name = spi.spi_id
                        join sct_page_item_type sit
                          on spi.spi_sit_id = sit.sit_id
                       where api.item_source_type = 'Database Column'
                         and spi.spi_is_required = sct_util.C_TRUE
                         and p.uttm_name = 'INITIALIZE_COL_VAL'), sct_util.C_CR) item_stmt
               from dual)) resultat
      into l_initialization_code
      from params
     where uttm_name = 'INITIALIZE';
     
    pit.leave_optional(p_params => msg_params(msg_param('Initialization Code', l_initialization_code)));
    return l_initialization_code;
  exception
    when no_data_found then 
      pit.leave_optional(p_params => msg_params(msg_param('Initialization Code', 'NULL')));
      return null;
  end create_initialization_code;
  
  
  /* Method to harmonize table SCT_PAGE_ITEM against APEX Data Dictionary
   * %param  p_sgr_id         Rule group ID
   * %param [p_new_condition] If a new rule is created, the new rule condition must be obeyed as well
   * %usage  If a rule group changes, all rules and page elements are checked against each other.
   *         The resulting values are used as the basis for a single rule.
   *         Additionally, this method is called if a new rule is created to check whether the condition
   *         is syntactically plausible. Therefore, the new condition (which is not stored in the tables yet)
   *         must be added to idnetify any new page items referenced within this rule.
   *         Attention: Method removes non existing page items from the table and deletes any rule actions 
   *                    attached to these page items!
   */
  procedure harmonize_sct_page_item(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_new_condition in sct_rule.sru_condition%type default null)
  as
    l_initialization_code sct_rule_group.sgr_initialization_code%type;
    l_is_true utl_text.flag_type := utl_text.C_TRUE;
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
      -- Step 1: remove REQUIRED flags
      update sct_page_item
         set spi_is_required = sct_util.C_FALSE,
              -- mark any element as erroneus, will be cleared later on
             spi_has_error = sct_util.C_TRUE
       where spi_sgr_id = p_sgr_id;
       
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('REQUIRED flags set'));
      
      -- Step 2: Merge APEX page items into SCT_PAGE_ITEMS
      merge into sct_page_item t
      using (select spi_sgr_id,
                    spi_sit_id,
                    spi_sty_id,
                    spi_id,
                    spi_label,
                    spi_conversion,
                    spi_item_default,
                    spi_css,
                    sct_util.C_FALSE spi_has_error
               from sct_bl_page_targets
              where spi_sgr_id = p_sgr_id) s
         on (t.spi_id = s.spi_id and t.spi_sgr_id = s.spi_sgr_id)
       when matched then update set
            t.spi_sit_id = s.spi_sit_id,
            t.spi_sty_id = s.spi_sty_id,
            t.spi_label = s.spi_label,
            t.spi_conversion = s.spi_conversion,
            t.spi_item_default = s.spi_item_default,
            t.spi_css = s.spi_css,
            t.spi_has_error = s.spi_has_error
       when not matched then insert(spi_id, spi_sit_id, spi_sty_id, spi_label, spi_sgr_id, spi_conversion, spi_item_default, spi_css)
            values(s.spi_id, s.spi_sit_id, s.spi_sty_id, s.spi_label, s.spi_sgr_id, s.spi_conversion, s.spi_item_default, s.spi_css);
            
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('APEX items merged into SCT_PAGE_ITEMS'));
      
      -- Step 3: mark page items referenced in a single rule as relevant
      merge into sct_page_item t
      using (select distinct spi_sgr_id, spi_id
               from (select sgr.sgr_id spi_sgr_id, i.column_value spi_id
                       from sct_rule sru
                       join sct_rule_group sgr
                         on sru.sru_sgr_id = sgr.sgr_id
                      cross join table(utl_text.string_to_table(sru.sru_firing_items, ',')) i
                      where sgr_id = p_sgr_id
                      union all
                     -- Match newly created condition against SCT_PAGE_ITEM to find new firing items
                     select spi_sgr_id, spi_id
                       from sct_page_item spi
                      where (regexp_instr(upper(p_new_condition), replace(C_REGEX_ITEM, '#ITEM#', spi.spi_id)) > 0
                         or instr(spi.spi_css, replace(regexp_substr(p_new_condition, C_REGEX_CSS), '''', '|')) > 0)
                        and spi_sgr_id = p_sgr_id)) s
         on (t.spi_id = s.spi_id 
         and t.spi_sgr_id = s.spi_sgr_id)
       when matched then update set
            t.spi_is_required = sct_util.C_TRUE;
            
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('Relevant items marked'));
      
      -- Step 4: remove elements which are
      -- - irrelevant and
      -- - erroneus (fi not existing anymore) and
      -- - not referenced by rule actions
      delete from sct_page_item
       where spi_sgr_id = p_sgr_id
         and spi_is_required = sct_util.C_FALSE
         and spi_has_error = sct_util.C_TRUE
         and spi_id not in (
             select sra_spi_id
               from sct_rule_action
              where sra_sgr_id = p_sgr_id);
            
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('Irrelevant, erroneous and not referenced items removed'));
              
      -- Mark errors in SCT_RULE and SCT_RULE_ACTION
      -- Reset all error flags for rule to FALSE
      update sct_rule
         set sru_has_error = sct_util.C_FALSE
       where sru_sgr_id = p_sgr_id;
      
      -- Mark rules that reference items with error flag 
      merge into sct_rule t
      using (select distinct sru.sru_id
               from sct_page_item spi
               join sct_rule sru
                 on utl_text.contains(sru_firing_items, spi_id) = l_is_true
              where spi_sgr_id = p_sgr_id
                and spi_has_error = sct_util.C_TRUE) s
         on (t.sru_id = s.sru_id)
       when matched then update set
            t.sru_has_error = sct_util.C_TRUE;
      
      -- Reset all error flags for rule actions to FALSE
      update sct_rule_action
         set sra_has_error = sct_util.C_FALSE
       where sra_sgr_id = p_sgr_id;
      
      -- Mark rule actions that reference items with error flag
      merge into sct_rule_action t
      using (select spi_sgr_id sra_sgr_id, spi_id sra_spi_id
               from sct_page_item
              where spi_sgr_id = p_sgr_id
                and spi_has_error = sct_util.C_TRUE) s
         on (t.sra_sgr_id = s.sra_sgr_id 
         and t.sra_spi_id = s.sra_spi_id)
       when matched then update set
            t.sra_has_error = sct_util.C_TRUE;
            
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('Errors marked'));
             
      -- create initialization code and persist at SCT_RULE_GROUP for fast page initialization
      l_initialization_code := create_initialization_code(p_sgr_id);
      
      update sct_rule_group
         set sgr_initialization_code = l_initialization_code
       where sgr_id = p_sgr_id;
            
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('Initialization code generated and saved'));
       
    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.SCT_INITIALZE_SGR_FAILED, msg_args(to_char(p_sgr_id), sqlerrm));
  end harmonize_sct_page_item;
  

  /* Helper to harmonize page items which are referenced by a rule at table SCT_RULE
   * %param  p_sgr_id  Rule group ID
   * %usage  Method extracts page item names from a rule condition using regex C_REGEX_ITEM
   *         Used to validate a rule condition and further application logic
   */
  procedure harmonize_firing_items(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_detailed(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
    merge into sct_rule t
    using (select sru.sru_id,
                  listagg(spi.spi_id, ',') within group (order by spi.spi_id) sru_firing_items
             from sct_page_item spi
             join sct_rule sru
               on spi.spi_sgr_id = sru.sru_sgr_id
              and (regexp_instr(upper(sru.sru_condition), replace(C_REGEX_ITEM, '#ITEM#', spi.spi_id)) > 0
               or instr(spi.spi_css, replace(regexp_substr(sru.sru_condition, C_REGEX_CSS), '''', '|')) > 0)
            where spi.spi_sgr_id = p_sgr_id
              and sru.sru_active = sct_util.C_TRUE
            group by sru.sru_id) s
       on (t.sru_id = s.sru_id)
     when matched then update set
          t.sru_firing_items = s.sru_firing_items;
          
    pit.leave_detailed;
  end harmonize_firing_items;


  /* Helper to remove rule group views which remain at the database after removing a rule group
   * %usage Is called upon rule group changes to perform sct rule group view housekeeping
   */
  procedure delete_pending_rule_views
  as
    cursor pending_view_cur is
      select view_name
        from user_views
       where view_name like C_VIEW_NAME_PREFIX || '%'
         and view_name not in (
             select C_VIEW_NAME_PREFIX || sgr_id
               from sct_rule_group);
  begin
    pit.enter_detailed;
    
    for vw in pending_view_cur loop
      execute immediate 'drop view ' || vw.view_name;
      pit.verbose(msg.SCT_RULE_VIEW_DELETED, msg_args(vw.view_name));
    end loop;
    
    pit.leave_detailed;
  end delete_pending_rule_views;


  /* Method to generate a rule group view
   * %param  p_sgr_id  Rule group ID
   * %usage  Creates a rule group view
   */
  procedure create_rule_view(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
    l_stmt clob;
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'RULE_VIEW';
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
    delete_pending_rule_views;

    -- generate view SQL
      with params as(
           select uttm_text template, uttm_log_text log_template,
                  uttm_name, uttm_mode, p_sgr_id sgr_id
             from utl_text_templates
            where uttm_type = C_SCT
              and uttm_name = C_UTTM_NAME)
    select utl_text.generate_text(cursor(
             select template, log_template, C_VIEW_NAME_PREFIX prefix,
                    sgr_id,
                    -- Spaltenliste im SessionState
                    utl_text.generate_text(cursor(
                      select sit_col_template template, 
                             replace(spi_conversion, 'G') conversion, 
                             spi_id item,
                             sit_event
                        from sct_page_item_type sit
                        left join (
                               select *
                                 from sct_page_item
                                where spi_sgr_id = p_sgr_id) spi
                          on sit.sit_id = spi.spi_sit_id
                       where sct_util.C_TRUE in (spi_is_required, sit_include_in_view)
                         and sit_col_template is not null
                      order by sit_include_in_view desc, spi_id), ',' || sct_util.C_CR, 14) column_list,
                    coalesce(
                      utl_text.generate_text(cursor(
                        select template, sru_id, sru_name, sru_condition, sru_firing_items,
                               row_number() over (order by sru_id) sort_seq
                          from sct_rule
                         cross join params
                         where sru_sgr_id in (0, p_sgr_id)
                           and sru_active = sct_util.C_TRUE
                           and uttm_mode = 'WHERE_CLAUSE'
                         order by sru_id), sct_util.C_CR || '           or '),
                      to_clob('null is null')) where_clause
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = C_FRAME;
     
    -- create view
    execute immediate l_stmt;

    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.SCT_VIEW_CREATION, msg_args(sqlerrm, l_stmt));
  end create_rule_view;
  
  
  /* Helper to resequence rules and rule actions
   * %param  p_sgr_id  Rule group ID
   * %usage  Is called automatically upon change of a rule group to resequence all entries in steps of 10
   */
  procedure resequence_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
    -- resequence rules
    merge into sct_rule t
    using (select sru_id, sru_sgr_id,
                  row_number() over (partition by sru_sgr_id order by sru_sort_seq) * 10 sru_sort_seq
             from sct_rule
            where sru_sgr_id = p_sgr_id
              and sru_sgr_id > 0) s
       on (t.sru_id = s.sru_id and t.sru_sgr_id = s.sru_sgr_id)
     when matched then update set
          t.sru_sort_seq = s.sru_sort_seq;

    -- resequence rule actions
    merge into sct_rule_action t
    using (select rowid row_id,
                  row_number() over (partition by sra_sru_id order by sra_on_error, sra_sort_seq) * 10 sra_sort_seq
             from sct_rule_action
            where sra_sgr_id = p_sgr_id) s
       on (t.rowid = s.row_id)
     when matched then update set
          t.sra_sort_seq = s.sra_sort_seq;

    -- Is called outside the request-response-cycle, so commit explicitly
    commit;
    
    pit.leave_optional;
  end resequence_rule_group;
  
  
  procedure prepare_rule_group_import(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(
      msg_param('p_sgr_app_id', to_char(p_sgr_app_id)),
      msg_param('p_sgr_page_id', to_char(p_sgr_page_id)),
      msg_param('p_sgr_name', p_sgr_name)));
      
    -- Recursively delete any existing rulegroup with same APP_ID, PAGE_ID and NAME
    delete from sct_rule_group
     where sgr_app_id = p_sgr_app_id
       and sgr_page_id = p_sgr_page_id
       and sgr_name = p_sgr_name;
       
    pit.leave_mandatory;
  end prepare_rule_group_import;
  
  
  /* Initialisierungsmethode */
  procedure initialize
  as
  begin
    g_offset := 0;
  end;


  /* INTERFACE */
  -- Getter and Setter
  function map_id(
    p_id in number)
    return number
  as
    l_new_id binary_integer;
  begin
    pit.enter_mandatory;
    
    if p_id is null then
      g_id_map.delete;
    else
      if not g_id_map.exists(p_id) then
        g_id_map(p_id) := sct_seq.nextval;
      end if;
      l_new_id := g_id_map(p_id);
    end if;
    
    pit.leave_mandatory(p_params => msg_params(msg_param('Return', to_char(l_new_id))));
    return l_new_id;
  end map_id;
  

  /* Public DDL methods */  
  procedure merge_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_sgr_description in sct_rule_group.sgr_description%type,
    p_sgr_with_recursion in sct_rule_group.sgr_with_recursion%type,
    p_sgr_active in sct_rule_group.sgr_active%type default sct_util.C_TRUE)
  as
    l_sgr_id sct_rule_group.sgr_id%type;
  begin
    pit.enter_mandatory(p_params => msg_params(
      msg_param('p_sgr_app_id', to_char(p_sgr_app_id)),
      msg_param('p_sgr_page_id', to_char(p_sgr_page_id)),
      msg_param('p_sgr_id', to_char(p_sgr_id)),
      msg_param('p_sgr_name', p_sgr_name),
      msg_param('p_sgr_description', p_sgr_description),
      msg_param('p_sgr_with_recursion', to_char(p_sgr_with_recursion)),
      msg_param('p_sgr_active', to_char(p_sgr_active))));
    
    l_sgr_id := coalesce(p_sgr_id, sct_seq.nextval);
    
    merge into sct_rule_group t
    using (select l_sgr_id sgr_id,
                  upper(p_sgr_name) sgr_name,
                  utl_text.unwrap_string(p_sgr_description) sgr_description,
                  p_sgr_app_id + g_offset sgr_app_id,
                  p_sgr_page_id sgr_page_id,
                  sct_util.get_boolean(p_sgr_with_recursion) sgr_with_recursion,
                  sct_util.get_boolean(p_sgr_active) sgr_active
             from dual) s
       on (t.sgr_id = s.sgr_id and t.sgr_app_id = s.sgr_app_id)
     when matched then update set
          t.sgr_name = s.sgr_name,
          t.sgr_description = s.sgr_description,
          t.sgr_page_id = s.sgr_page_id,
          t.sgr_with_recursion = s.sgr_with_recursion,
          t.sgr_active = s.sgr_active
     when not matched then insert(sgr_id, sgr_name, sgr_description, sgr_app_id, sgr_page_id, sgr_with_recursion, sgr_active)
          values(s.sgr_id, s.sgr_name, s.sgr_description, s.sgr_app_id, s.sgr_page_id, s.sgr_with_recursion, s.sgr_active);

    harmonize_sct_page_item(l_sgr_id);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SCT_MERGE_RULE_GROUP, msg_args(to_char(l_sgr_id)));
  end merge_rule_group;


  procedure merge_rule_group(
    p_row in out nocopy sct_rule_group%rowtype)
  as
  begin
    merge_rule_group(
      p_sgr_app_id => p_row.sgr_app_id,
      p_sgr_page_id => p_row.sgr_page_id,
      p_sgr_id => p_row.sgr_id,
      p_sgr_name => p_row.sgr_name,
      p_sgr_description => p_row.sgr_description,
      p_sgr_with_recursion => p_row.sgr_with_recursion,
      p_sgr_active => p_row.sgr_active);
  end merge_rule_group;
  

  procedure delete_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory;
    begin
      execute immediate 'drop view ' || C_VIEW_NAME_PREFIX || p_sgr_id;
    exception
      when others then
        null;
    end;
    delete from sct_rule_group
     where sgr_id = p_sgr_id;
    pit.leave_mandatory;
  end delete_rule_group;
  
  
  procedure delete_rule_group(
    p_row in out nocopy sct_rule_group%rowtype)
  as
  begin
    delete_rule_group(p_row.sgr_id);
  end delete_rule_group;


  procedure propagate_rule_change(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
    harmonize_firing_items(p_sgr_id);
    harmonize_sct_page_item(p_sgr_id);
    create_rule_view(p_sgr_id);
    resequence_rule_group(p_sgr_id);
    
    pit.leave_mandatory;
  end propagate_rule_change;
  
  
  function validate_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return varchar2
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'VALIDATE_RULE_GROUP_EXPORT';
    l_error_list clob;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
    harmonize_sct_page_item(p_sgr_id);
    
      with params as (
           select uttm_mode, uttm_text template,
                  sgr_id, sgr_name, sgr_app_id
             from sct_rule_group
            cross join utl_text_templates
            where sgr_id = p_sgr_id
              and uttm_type = C_SCT
              and uttm_name = C_UTTM_NAME
              and exists(
                  select null
                    from sct_page_item
                   where spi_sgr_id = sgr_id
                     and spi_has_error = sct_util.C_TRUE))
    select utl_text.generate_text(cursor(
             select template, sgr_name,
                    utl_text.generate_text(cursor(
                      select p.template, p.sgr_app_id, spi.spi_id
                        from sct_page_item spi
                        join sct_page_item_type sit
                          on spi.spi_sit_id = sit.sit_id
                        join params p
                          on spi.spi_sgr_id = p.sgr_id
                       where spi.spi_has_error = sct_util.C_TRUE
                    )) error_list
               from dual
           )) resultat
      into l_error_list
      from params
     where uttm_mode = C_DEFAULT;

    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_error_list)));
    return l_error_list;
  end validate_rule_group;


  procedure copy_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_app_id_to in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id_to in sct_rule_group.sgr_page_id%type)
  as
    l_foo number;
    l_sgr_id sct_rule_group.sgr_id%type;
    l_sgr_name sct_rule_group.sgr_name%type;
    l_stmt clob;
  begin
    pit.enter_mandatory(p_params => msg_params(
      msg_param('p_sgr_id', to_char(p_sgr_id)),
      msg_param('p_sgr_app_id_to', to_char(p_sgr_app_id_to)),
      msg_param('p_sgr_page_id_to', to_char(p_sgr_page_id_to))));
      
    -- Check whether source rule group exists
    pit.assert_exists(
      'select sgr_id ' ||
      '  from sct_rule_group ' ||
      ' where sgr_id = ' || p_sgr_id,
      msg.SCT_RULE_DOES_NOT_EXIST,
      msg_args(to_char(p_sgr_id)));

    -- Check whether target page exists
    pit.assert_exists(
      'select null ' ||
      '  from apex_application_pages ' ||
      ' where application_id = ' || p_sgr_app_id_to ||
      '   and page_id = ' || p_sgr_page_id_to,
      msg.SCT_PAGE_DOES_NOT_EXIST,
      msg_args(to_char(p_sgr_app_id_to)));
      
    -- Check whether source page and target page are different
    pit.assert_not_exists(
      'select null ' ||
      '  from sct_rule_group ' ||
      ' where application_id = ' || p_sgr_app_id_to ||
      '   and page_id = ' || p_sgr_page_id_to ||
      '   and sgr_id = ' || p_sgr_id,
      msg.SCT_TARGET_EQUALS_SOURCE,
      msg_args(to_char(p_sgr_id), to_char(p_sgr_app_id_to), to_char(p_sgr_page_id_to)));

    -- Initialize
    select sgr_name
      into l_sgr_name
      from sct_rule_group
     where sgr_id = p_sgr_id;
     
    prepare_rule_group_import(
      p_sgr_app_id => p_sgr_app_id_to,
      p_sgr_page_id => p_sgr_page_id_to,
      p_sgr_name => l_sgr_name);
      
    l_stmt := export_rule_group(
                p_sgr_id => p_sgr_id,
                p_sgr_app_id_map_to => p_sgr_app_id_to,
                p_sgr_page_id_map_to => p_sgr_page_id_to);
    execute immediate l_stmt;
    
    pit.leave_mandatory;
  end copy_rule_group;
  
  
  function export_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type default null,
    p_sgr_id in sct_rule_group.sgr_id%type default null,
    p_sgr_app_id_map_to in sct_rule_group.sgr_app_id%type default null,
    p_sgr_page_id_map_to in sct_rule_group.sgr_id%type default null)
    return clob
  as
    cursor rule_group_cur(p_sgr_app_id in sct_rule_group.sgr_app_id%type) is
      select sgr_id, sgr_app_id
        from sct_rule_group
       where sgr_app_id = p_sgr_app_id
          or p_sgr_app_id is null;
    l_stmt clob;
    C_SGR_DELIMITER constant varchar2(20) := sct_util.C_CR || sct_util.C_CR || sct_util.C_CR;
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'EXPORT_RULE_GROUP';
  begin
    pit.enter_mandatory(
      p_params => msg_params(
                    msg_param('p_sgr_app_id', to_char(p_sgr_app_id)),
                    msg_param('p_sgr_id', to_char(p_sgr_id))));
                    
    dbms_lob.createTemporary(l_stmt, false, dbms_lob.call);

    -- Create and append script for each rule group
    if p_sgr_id is null then
      for sgr in rule_group_cur(p_sgr_app_id) loop
        dbms_lob.append(l_stmt, export_rule_group(p_sgr_id => sgr.sgr_id));
      end loop;
    else
      -- Create export script based on UTL_TEXT export templates
      utl_text.set_secondary_anchor_char('&');
        with params as (
             select uttm_mode, uttm_text template, 
                    sgr.sgr_id, sgr.sgr_name, sgr.sgr_description,
                    coalesce(p_sgr_app_id_map_to, sgr_app_id) sgr_app_id,
                    coalesce(p_sgr_page_id_map_to, sgr_page_id) sgr_page_id,
                    sct_util.to_bool(sgr_active) sgr_active, 
                    sct_util.to_bool(sgr_with_recursion) sgr_with_recursion
               from utl_text_templates
              cross join sct_rule_group sgr
              where uttm_type = C_SCT
                and uttm_name = C_UTTM_NAME
                and sgr_id = p_sgr_id)
      select utl_text.generate_text(cursor(
               select template, sgr_id, sgr_name, sgr_description, 
                      sgr_app_id, sgr_page_id, sgr_active, sgr_with_recursion,
                      -- apex_actions
                      utl_text.generate_text(cursor(
                        select p.template, saa_id, saa_sgr_id, saa_sty_id, saa_name, saa_label, saa_context_label,
                               saa_icon, saa_icon_type, saa_title, saa_shortcut, 
                               sct_util.to_bool(saa_initially_disabled) saa_initially_disabled,
                               sct_util.to_bool(saa_initially_hidden) saa_initially_hidden,
                               saa_href, saa_action, saa_on_label, saa_off_label, saa_get, saa_set, saa_choices,
                               saa_label_classes, saa_label_start_classes, saa_label_end_classes, saa_item_wrap_class,
                               -- apex_action_items
                               utl_text.generate_text(cursor(
                                 select p.template, sai_saa_id, sai_spi_sgr_id, sai_spi_id,
                                        sct_util.to_bool(sai_active) sai_active
                                   from sct_apex_action_item sai
                                   join params p
                                     on p.uttm_mode = 'APEX_ACTION_ITEM'
                                  where sai_saa_id = saa.saa_id
                               )) apex_action_items
                          from sct_apex_action saa
                          join params p
                            on p.uttm_mode = 'APEX_ACTION_' || saa.saa_sty_id
                         where saa_sgr_id = sgr_id
                      )) apex_actions,
                      -- rules
                      utl_text.generate_text(cursor(
                        select p.template, sru_id, sru_sgr_id, sru_name, sru_condition, sru_sort_seq,
                               sru_firing_items, sct_util.to_bool(sru_active) sru_active,
                               sct_util.to_bool(sru_fire_on_page_load) sru_fire_on_page_load,
                               -- rule actions
                               utl_text.generate_text(cursor(
                                 select p.template, sra_id, sra_sgr_id, sra_sru_id, sra_spi_id, sra_sat_id,
                                        sct_util.to_bool(sra_on_error) sra_on_error,
                                        sra_param_1, sra_param_2, sra_param_3, sra_comment, sra_sort_seq, 
                                        sct_util.to_bool(sra_raise_recursive) sra_raise_recursive,
                                        sct_util.to_bool(sra_active) sra_active
                                   from sct_rule_action a
                                  cross join params p
                                  where uttm_mode = 'RULE_ACTION'
                                    and sra_sru_id = r.sru_id
                               )) rule_actions
                          from sct_rule r
                          join params p
                            on r.sru_sgr_id = p.sgr_id
                         where p.uttm_mode = 'RULE'
                      )) rules
                 from dual)) resultat
        into l_stmt
        from params p
       where uttm_mode = C_DEFAULT;    
    end if;
    
    pit.leave_mandatory(p_params => msg_params(msg_param('Return', substr(l_stmt, 1, 4000))));
    return l_stmt;
  end export_rule_group;


  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_alias in varchar2)
  as
    l_ws_id number;
    l_app_id number;
  begin
    pit.enter_mandatory(p_params => msg_params(
      msg_param('p_workspace', p_workspace),
      msg_param('p_app_alias', p_app_alias)));
    
    select workspace_id, application_id
      into l_ws_id, l_app_id
      from apex_applications
     where alias = p_app_alias
       and workspace = p_workspace;

    apex_application_install.set_workspace_id(l_ws_id);
    apex_application_install.set_application_id(l_app_id + g_offset);
    
    pit.leave_mandatory;
  exception
    when no_data_found then
      pit.warn(msg.SCT_NO_RULE_GROUP_FOUND, msg_args(p_workspace, p_app_alias)); 
      pit.leave_mandatory;
  end prepare_rule_group_import;


  procedure prepare_rule_group_import(
    p_workspace in varchar2,
    p_app_id in sct_rule_group.sgr_app_id%type)
  as
    l_ws_id number;
  begin
    pit.enter_mandatory(p_params => msg_params(
      msg_param('p_workspace', p_workspace),
      msg_param('p_app_id', to_char(p_app_id))));
    
    select workspace_id
      into l_ws_id
      from apex_applications
     where application_id = p_app_id
       and workspace = p_workspace;

    apex_application_install.set_workspace_id(l_ws_id);
    apex_application_install.set_application_id(p_app_id + g_offset);

    pit.leave_mandatory;
  end prepare_rule_group_import;
  
    
  procedure merge_apex_action_type(
    p_sty_id in sct_apex_action_type.sty_id%type,
    p_sty_name in pit_translatable_item.pti_name%type,
    p_sty_description in pit_translatable_item.pti_description%type,
    p_sty_active in sct_apex_action_type.sty_active%type) 
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    -- maintain translatable item
    l_pti_id := 'STY_' || p_sty_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_SCT,
      p_pti_name => p_sty_name,
      p_pti_description => utl_text.unwrap_string(p_sty_description));
      
    -- store local data
    merge into sct_apex_action_type t
    using (select p_sty_id sty_id,
                  l_pti_id sty_pti_id,
                  C_SCT sty_pmg_name,
                  sct_util.get_boolean(p_sty_active) sty_active
             from dual) s
       on (t.sty_id = s.sty_id)
     when matched then update set
            t.sty_active = s.sty_active
     when not matched then insert(t.sty_id, t.sty_pti_id, t.sty_pmg_name, t.sty_active)
          values(s.sty_id, s.sty_pti_id, s.sty_pmg_name, s.sty_active);
  end merge_apex_action_type;
  
    
  procedure merge_apex_action_type(
    p_row in out nocopy sct_apex_action_type_v%rowtype)
  as
  begin
    merge_apex_action_type(
      p_sty_id => p_row.sty_id,
      p_sty_name => p_row.sty_name,
      p_sty_description => p_row.sty_description,
      p_sty_active => p_row.sty_active);
  end merge_apex_action_type;
  
  
  procedure delete_apex_action_type(
    p_sty_id in sct_apex_action_type.sty_id%type)
  as
  begin
    delete from sct_apex_action_type
     where sty_id = p_sty_id;
  end delete_apex_action_type;
  
  
  procedure delete_apex_action_type(
    p_row in out nocopy sct_apex_action_type_v%rowtype)
  as
  begin
    delete_apex_action_type(p_row.sty_id);
  end delete_apex_action_type;
  
  
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
    p_saa_item_wrap_class in sct_apex_action.saa_item_wrap_class%type default null)   
  as    
    l_row sct_apex_action%rowtype;  
  begin   
    l_row.saa_id := p_saa_id;
    l_row.saa_sgr_id := p_saa_sgr_id;
    l_row.saa_name := p_saa_name;
    l_row.saa_sty_id := p_saa_sty_id;
    l_row.saa_label := p_saa_label;
    l_row.saa_context_label := p_saa_context_label;
    l_row.saa_icon := p_saa_icon;
    l_row.saa_icon_type := p_saa_icon_type;
    l_row.saa_title := p_saa_title;
    l_row.saa_shortcut := p_saa_shortcut;
    l_row.saa_initially_disabled := p_saa_initially_disabled;
    l_row.saa_initially_hidden := p_saa_initially_hidden;
    l_row.saa_href := p_saa_href;
    l_row.saa_action := p_saa_action;
    l_row.saa_on_label := p_saa_on_label;
    l_row.saa_off_label := p_saa_off_label;
    l_row.saa_get := p_saa_get;
    l_row.saa_set := p_saa_set;
    l_row.saa_choices := p_saa_choices;
    l_row.saa_label_classes := p_saa_label_classes;
    l_row.saa_label_start_classes := p_saa_label_start_classes;
    l_row.saa_label_end_classes := p_saa_label_end_classes;
    l_row.saa_item_wrap_class := p_saa_item_wrap_class;    
    
    merge_apex_action(l_row); 
    
  end merge_apex_action;
  
  
  procedure merge_apex_action(   
    p_row in out nocopy sct_apex_action%rowtype)  
  as  
  begin
    pit.enter_mandatory;
    
    merge into sct_apex_action t    
    using (select p_row.saa_id saa_id,
                  p_row.saa_sgr_id saa_sgr_id,
                  p_row.saa_name saa_name,
                  p_row.saa_sty_id saa_sty_id,
                  p_row.saa_label saa_label,
                  p_row.saa_context_label saa_context_label,
                  p_row.saa_icon saa_icon,
                  p_row.saa_icon_type saa_icon_type,
                  p_row.saa_title saa_title,
                  p_row.saa_shortcut saa_shortcut,
                  sct_util.get_boolean(p_row.saa_initially_disabled) saa_initially_disabled,
                  sct_util.get_boolean(p_row.saa_initially_hidden) saa_initially_hidden,
                  p_row.saa_href saa_href,
                  p_row.saa_action saa_action,
                  p_row.saa_on_label saa_on_label,
                  p_row.saa_off_label saa_off_label,
                  p_row.saa_get saa_get,
                  p_row.saa_set saa_set,
                  p_row.saa_choices saa_choices,
                  p_row.saa_label_classes saa_label_classes,
                  p_row.saa_label_start_classes saa_label_start_classes,
                  p_row.saa_label_end_classes saa_label_end_classes,
                  p_row.saa_item_wrap_class saa_item_wrap_class
             from dual) s       
       on (t.saa_id = s.saa_id)    
     when matched then update set
            t.saa_name = s.saa_name,
            t.saa_sty_id = s.saa_sty_id,  
            t.saa_label = s.saa_label,
            t.saa_context_label = s.saa_context_label,
            t.saa_icon = s.saa_icon,
            t.saa_icon_type = s.saa_icon_type,
            t.saa_title = s.saa_title,
            t.saa_shortcut = s.saa_shortcut,
            t.saa_initially_disabled = s.saa_initially_disabled,
            t.saa_initially_hidden = s.saa_initially_hidden,
            t.saa_href = s.saa_href,
            t.saa_action = s.saa_action,
            t.saa_get = s.saa_get,
            t.saa_set = s.saa_set,
            t.saa_on_label = s.saa_on_label,
            t.saa_off_label = s.saa_off_label,
            t.saa_choices = s.saa_choices,
            t.saa_label_classes = s.saa_label_classes,
            t.saa_label_start_classes = s.saa_label_start_classes,
            t.saa_label_end_classes = s.saa_label_end_classes,
            t.saa_item_wrap_class = s.saa_item_wrap_class 
     when not matched then insert(            
            t.saa_id, t.saa_sgr_id, t.saa_name, t.saa_sty_id, t.saa_label, t.saa_context_label, t.saa_icon, t.saa_icon_type, t.saa_title, 
            t.saa_shortcut, t.saa_initially_disabled, t.saa_initially_hidden, t.saa_href, t.saa_action,  
            t.saa_get, t.saa_set, t.saa_on_label, t.saa_off_label, t.saa_choices, t.saa_label_classes, t.saa_label_start_classes, 
            t.saa_label_end_classes, t.saa_item_wrap_class)          
          values(            
            s.saa_id, s.saa_sgr_id, s.saa_name, s.saa_sty_id, s.saa_label, s.saa_context_label, s.saa_icon, s.saa_icon_type, s.saa_title, 
            s.saa_shortcut, s.saa_initially_disabled, s.saa_initially_hidden, s.saa_href, s.saa_action, 
            s.saa_get, s.saa_set, s.saa_on_label, s.saa_off_label, s.saa_choices, s.saa_label_classes, s.saa_label_start_classes, 
            s.saa_label_end_classes, s.saa_item_wrap_class);  
    
    pit.leave_mandatory;
  end merge_apex_action;
  

  procedure delete_apex_action(    
    p_saa_id in sct_apex_action.saa_id%type)  
  as  
  begin
    pit.enter_mandatory;
    
    delete from sct_apex_action  
     where saa_id = p_saa_id;
       
    pit.leave_mandatory;
  end delete_apex_action;
  

  procedure delete_apex_action(    
    p_row in out nocopy sct_apex_action%rowtype)  
  as  
  begin
    pit.enter_mandatory;
    
    delete_apex_action( p_row.saa_id);
       
    pit.leave_mandatory;
  end delete_apex_action;  
  
  
  procedure merge_apex_action_item(
    p_sai_saa_id     in sct_apex_action_item.sai_saa_id%type,
    p_sai_spi_sgr_id in sct_apex_action_item.sai_spi_sgr_id%type,
    p_sai_spi_id     in sct_apex_action_item.sai_spi_id%type,
    p_sai_active     in sct_apex_action_item.sai_active%type)
  as
  begin
    merge into sct_apex_action_item t
    using (select p_sai_saa_id sai_saa_id,
                  p_sai_spi_sgr_id sai_spi_sgr_id,
                  p_sai_spi_id sai_spi_id,
                  sct_util.get_boolean(p_sai_active) sai_active
             from dual) s
       on (t.sai_saa_id = s.sai_saa_id
       and t.sai_spi_sgr_id = s.sai_spi_sgr_id
       and t.sai_spi_id = s.sai_spi_id)
     when matched then update set
            t.sai_active = s.sai_active
     when not matched then insert(
            t.sai_saa_id, t.sai_spi_sgr_id, t.sai_spi_id, t.sai_active)
          values(
            s.sai_saa_id, s.sai_spi_sgr_id, s.sai_spi_id, s.sai_active);
  end merge_apex_action_item;


  procedure merge_apex_action_item(
    p_row sct_apex_action_item%rowtype)
  as
  begin
    merge_apex_action_item(
      p_sai_saa_id => p_row.sai_saa_id,
      p_sai_spi_sgr_id => p_row.sai_spi_sgr_id,
      p_sai_spi_id => p_row.sai_spi_id,
      p_sai_active => p_row.sai_active);
  end merge_apex_action_item;
  
  
  procedure delete_apex_action_item(
    p_saa_id in sct_apex_action.saa_id%type)
  as
  begin
    delete from sct_apex_action_item
     where sai_saa_id = p_saa_id;
  end delete_apex_action_item;


  procedure delete_apex_action_item(
    p_row sct_apex_action_item%rowtype)
  as
  begin
    delete_apex_action_item(p_row.sai_saa_id);
  end delete_apex_action_item;


  procedure merge_rule(
    p_sru_id in sct_rule.sru_id%type default null,
    p_sru_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_name in sct_rule.sru_name%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_sru_fire_on_page_load in sct_rule.sru_fire_on_page_load%type,
    p_sru_sort_seq in sct_rule.sru_sort_seq%type,
    p_sru_active in sct_rule.sru_active%type default sct_util.C_TRUE)
  as
  begin
    pit.enter_mandatory;
    
    merge into sct_rule t
    using (select p_sru_id sru_id,
                  p_sru_sgr_id sru_sgr_id,
                  p_sru_name sru_name,
                  p_sru_condition sru_condition,
                  p_sru_fire_on_page_load sru_fire_on_page_load,
                  p_sru_sort_seq sru_sort_seq,
                  sct_util.get_boolean(p_sru_active) sru_active
             from dual) s
       on (t.sru_id = s.sru_id
       and t.sru_sgr_id = s.sru_sgr_id)
     when matched then update set
          t.sru_name = s.sru_name,
          t.sru_condition = s.sru_condition,
          t.sru_fire_on_page_load = s.sru_fire_on_page_load,
          t.sru_sort_seq = s.sru_sort_seq,
          t.sru_active = s.sru_active
     when not matched then insert(sru_id, sru_sgr_id, sru_name, sru_condition, sru_fire_on_page_load, sru_sort_seq, sru_active)
          values (s.sru_id, s.sru_sgr_id, s.sru_name, s.sru_condition, s.sru_fire_on_page_load, s.sru_sort_seq, s.sru_active);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SCT_MERGE_RULE, msg_args(p_sru_name));
  end merge_rule;
  
  
  procedure merge_rule(
    p_row in out nocopy sct_rule%rowtype)
  as
  begin
    merge_rule(
      p_sru_id => p_row.sru_id,
      p_sru_sgr_id => p_row.sru_sgr_id,
      p_sru_name => p_row.sru_name,
      p_sru_condition => p_row.sru_condition,
      p_sru_fire_on_page_load => p_row.sru_fire_on_page_load,
      p_sru_sort_seq => p_row.sru_sort_seq,
      p_sru_active => p_row.sru_active);
  end merge_rule;
  

  procedure delete_rule(
    p_sru_id in sct_rule.sru_id%type)
  as
  begin
    pit.enter_mandatory;
    
    delete from sct_rule
     where sru_id = p_sru_id;
     
    pit.leave_mandatory;
  end delete_rule;
  

  procedure delete_rule(
    p_row in out nocopy sct_rule%rowtype)
  as
  begin
    delete_rule(p_row.sru_id);
  end delete_rule;


  procedure validate_rule(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2)
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'RULE_VALIDATION';
    l_data_cols varchar2(32767);
    l_stmt varchar2(32767);
    l_ctx pls_integer;
  begin
    pit.enter_mandatory;
    
    harmonize_sct_page_item(p_sgr_id, p_sru_condition);
    
    -- create validation statement
      with params as(
           select uttm_text template, 
                  p_sgr_id sgr_id, 
                  p_sru_condition condition
             from utl_text_templates
            where uttm_type = C_SCT
              and uttm_name = C_UTTM_NAME
              and uttm_mode = 'DEFAULT')
    select utl_text.generate_text(cursor(
             select p.template, p.condition,
                    utl_text.generate_text(cursor(
                      select sit_col_template template, 
                             replace(spi_conversion, 'G') conversion, 
                             spi_id item,
                             sit_event
                        from sct_page_item_type sit
                        left join (
                               select *
                                 from sct_page_item
                                where spi_sgr_id = p_sgr_id) spi
                          on sit.sit_id = spi.spi_sit_id
                       where sct_util.C_TRUE in (spi_is_required, sit_include_in_view)
                         and sit_col_template is not null
                      order by sit_include_in_view desc, spi_id), ',' || sct_util.C_CR, 14) column_list
               from dual)) resultat
      into l_stmt
      from params p;
      
    -- perform validation
    l_ctx := dbms_sql.open_cursor;
    dbms_sql.parse(l_ctx, l_stmt, dbms_sql.native);
    dbms_sql.close_cursor(l_ctx);
    
    pit.leave_mandatory;
  exception
    when others then
      -- Return error statement. Will create an error on the page
      p_error := substr(sqlerrm, 12);
      pit.sql_exception;
  end validate_rule;
  
  
  procedure resequence_rule(
    p_sru_id in sct_rule.sru_id%type)
  as
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_sru_id', to_char(p_sru_id))));

    -- resequence rule actions
    merge into sct_rule_action t
    using (select rowid row_id,
                  row_number() over (partition by sra_sru_id order by sra_on_error, sra_sort_seq) * 10 sra_sort_seq
             from sct_rule_action
            where sra_sru_id = p_sru_id) s
       on (t.rowid = s.row_id)
     when matched then update set
          t.sra_sort_seq = s.sra_sort_seq;

    -- Is called outside the request-response-cycle, so commit explicitly
    commit;
    
    pit.leave_optional;
  end resequence_rule;
  
  
  procedure merge_action_type_group(
    p_stg_id in sct_action_type_group.stg_id%type,
    p_stg_name in pit_translatable_item.pti_name%type,
    p_stg_description in pit_translatable_item.pti_description%type,
    p_stg_active in sct_action_type_group.stg_active%type default sct_util.C_TRUE)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    -- maintain translatable item
    l_pti_id := 'STG_' || p_stg_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_SCT,
      p_pti_name => p_stg_name,
      p_pti_description => utl_text.unwrap_string(p_stg_description));
      
    -- store local data
    merge into sct_action_type_group t
    using (select p_stg_id stg_id,
                  l_pti_id stg_pti_id,
                  C_SCT stg_pmg_name,
                  sct_util.get_boolean(p_stg_active) stg_active
             from dual) s
       on (t.stg_id = s.stg_id)
     when matched then update set
          t.stg_active = s.stg_active
     when not matched then insert(stg_id, stg_pti_id, stg_pmg_name, stg_active)
          values(s.stg_id, s.stg_pti_id, s.stg_pmg_name, s.stg_active);
        
    pit.leave_mandatory;
  end merge_action_type_group;  
  
    
  procedure merge_action_type_group(
    p_row in out nocopy sct_action_type_group_v%rowtype)
  as
  begin
    merge_action_type_group(
      p_stg_id => p_row.stg_id,
      p_stg_name => p_row.stg_name,
      p_stg_description => p_row.stg_description,
      p_stg_active => p_row.stg_active);      
  end merge_action_type_group;
  
  
  procedure delete_action_type_group(
    p_stg_id in sct_action_type_group.stg_id%type)
  as
  begin
    delete from sct_action_type_group
     where stg_id = p_stg_id;
  end delete_action_type_group;
  
  
  procedure delete_action_type_group(
    p_row in out nocopy sct_action_type_group_v%rowtype)
  as
  begin
    delete_action_type_group(p_row.stg_id);
  end delete_action_type_group;
  
  
  procedure merge_action_param_type(
    p_spt_id in sct_action_param_type.spt_id%type,
    p_spt_name in pit_translatable_item.pti_name%type,
    p_spt_description in pit_translatable_item.pti_description%type,
    p_spt_active in sct_action_param_type.spt_active%type default SCT_UTIL.C_TRUE)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    -- maintain translatable item
    l_pti_id := 'SPT_' || p_spt_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_SCT,
      p_pti_name => p_spt_name,
      p_pti_description => utl_text.unwrap_string(p_spt_description));
      
    -- store local data
    merge into sct_action_param_type t
    using (select p_spt_id spt_id,
                  l_pti_id spt_pti_id,
                  C_SCT spt_pmg_name,
                  sct_util.get_boolean(p_spt_active) spt_active
             from dual) s
       on (t.spt_id = s.spt_id)
     when matched then update set
          t.spt_active = s.spt_active
     when not matched then insert(spt_id, spt_pti_id, spt_pmg_name, spt_active)
          values(s.spt_id, s.spt_pti_id, s.spt_pmg_name, s.spt_active);
  end merge_action_param_type;
  
    
  procedure merge_action_param_type(
    p_row in out nocopy sct_action_param_type_v%rowtype)
  as
  begin
    merge_action_param_type(
      p_spt_id => p_row.spt_id,
      p_spt_name => p_row.spt_name,
      p_spt_description => p_row.spt_description,
      p_spt_active => p_row.spt_active);      
  end merge_action_param_type;
  
    
  procedure delete_action_param_type(
    p_spt_id in sct_action_param_type.spt_id%type)
  as
  begin
    delete from sct_action_param_type
     where spt_id = p_spt_id;
  end delete_action_param_type;
  
    
  procedure delete_action_param_type(
    p_row in sct_action_param_type_v%rowtype)
  as
  begin
    delete_action_param_type(p_row.spt_id);
  end delete_action_param_type;
  
  
  procedure merge_action_item_focus(
    p_sif_id in sct_action_item_focus.sif_id%type,
    p_sif_name in pit_translatable_item.pti_name%type,
    p_sif_description in pit_translatable_item.pti_description%type,
    p_sif_active in sct_action_item_focus.sif_active%type default sct_util.C_TRUE)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    -- maintain translatable item
    l_pti_id := 'SIF_' || p_sif_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_SCT,
      p_pti_name => p_sif_name,
      p_pti_description => utl_text.unwrap_string(p_sif_description));
      
    -- store local data
    merge into sct_action_item_focus t
    using (select p_sif_id sif_id,
                  l_pti_id sif_pti_id,
                  C_SCT sif_pmg_name,
                  sct_util.get_boolean(p_sif_active) sif_active
             from dual) s
       on (t.sif_id = s.sif_id)
     when matched then update set
          t.sif_active = s.sif_active
     when not matched then insert(sif_id, sif_pti_id, sif_pmg_name, sif_active)
          values(s.sif_id, s.sif_pti_id, s.sif_pmg_name, s.sif_active);
  end merge_action_item_focus;
    
    
  procedure merge_action_item_focus(
    p_row in out nocopy sct_action_item_focus_v%rowtype)
  as
  begin
    merge_action_item_focus(
      p_sif_id => p_row.sif_id,
      p_sif_name => p_row.sif_name,
      p_sif_description => p_row.sif_description,
      p_sif_active => p_row.sif_active);      
  end merge_action_item_focus;
  
  
  procedure delete_action_item_focus(
    p_sif_id in sct_action_item_focus.sif_id%type)
  as
  begin
    delete from sct_action_item_focus
     where sif_id = p_sif_id;
  end delete_action_item_focus;
  
  
  procedure delete_action_item_focus(
    p_row in out nocopy sct_action_item_focus_v%rowtype)
  as
  begin
    delete_action_item_focus(p_row.sif_id);
  end delete_action_item_focus;


  procedure merge_action_type(
    p_sat_id in sct_action_type.sat_id%type,
    p_sat_stg_id in sct_action_type_group.stg_id%type,
    p_sat_sif_id in sct_action_item_focus.sif_id%type,
    p_sat_name in pit_translatable_item.pti_name%type,
    p_sat_description in pit_translatable_item.pti_description%type default null,
    p_sat_pl_sql in sct_action_type.sat_pl_sql%type,
    p_sat_js in sct_action_type.sat_js%type,
    p_sat_is_editable in sct_action_type.sat_is_editable%type default sct_util.C_TRUE,
    p_sat_raise_recursive in sct_action_type.sat_raise_recursive%type default sct_util.C_TRUE)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    pit.enter_mandatory;
    
    -- maintain translatable item
    l_pti_id := 'SAT_' || p_sat_id;
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_SCT,
      p_pti_name => p_sat_name,
      p_pti_description => utl_text.unwrap_string(p_sat_description));
      
    -- store local data
    merge into sct_action_type t
    using (select p_sat_id sat_id,
                  p_sat_stg_id sat_stg_id,
                  p_sat_sif_id sat_sif_id,
                  l_pti_id sat_pti_id,
                  C_SCT sat_pmg_name,
                  utl_text.unwrap_string(p_sat_pl_sql) sat_pl_sql,
                  utl_text.unwrap_string(p_sat_js) sat_js,
                  sct_util.get_boolean(p_sat_is_editable) sat_is_editable,
                  sct_util.get_boolean(p_sat_raise_recursive) sat_raise_recursive
             from dual) s
       on (t.sat_id = s.sat_id)
     when matched then update set
          t.sat_stg_id = s.sat_stg_id,
          t.sat_sif_id = s.sat_sif_id,
          t.sat_pl_sql = s.sat_pl_sql,
          t.sat_js = s.sat_js,
          t.sat_is_editable = s.sat_is_editable,
          t.sat_raise_recursive = s.sat_raise_recursive
     when not matched then insert(
            sat_id, sat_stg_id, sat_sif_id, sat_pti_id, sat_pmg_name, sat_pl_sql, sat_js, 
            sat_is_editable, sat_raise_recursive)
          values (
            s.sat_id, s.sat_stg_id, s.sat_sif_id, s.sat_pti_id, s.sat_pmg_name, s.sat_pl_sql, s.sat_js, 
            s.sat_is_editable, s.sat_raise_recursive);
            
    pit.leave_mandatory;
  end merge_action_type;
  
    
  procedure merge_action_type(
    p_row in sct_action_type_v%rowtype)
  as
  begin
    merge_action_type(
      p_sat_id => p_row.sat_id,
      p_sat_stg_id => p_row.sat_stg_id,
      p_sat_sif_id => p_row.sat_sif_id,
      p_sat_name => p_row.sat_name,
      p_sat_description => p_row.sat_description,
      p_sat_pl_sql => p_row.sat_pl_sql,
      p_sat_js => p_row.sat_js,
      p_sat_is_editable => p_row.sat_is_editable,
      p_sat_raise_recursive => p_row.sat_raise_recursive);
  end merge_action_type;
    
    
  procedure delete_action_type(
    p_sat_id in sct_action_type.sat_id%type)
  as
  begin
    delete from sct_action_type
     where sat_id = p_sat_id;
  end delete_action_type;
    
    
  procedure delete_action_type(
    p_row in sct_action_type_v%rowtype)
  as
  begin
    delete_action_type(p_row.sat_id);
  end delete_action_type;
  
  
  function export_action_types(
    p_sat_is_editable in sct_action_type.sat_is_editable%type default sct_util.C_TRUE)
    return clob
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'EXPORT_ACTION_TYPE';
    C_WRAP_START constant varchar2(5) := 'q''{';
    C_WRAP_END constant varchar2(5) := '}''';
    C_STMT constant varchar2(32767) := q'#
         with params as (
                select uttm_mode, uttm_text template, null sat_is_editable
                  from utl_text_templates
                 where uttm_type = 'SCT'
                   and uttm_name = 'EXPORT_ACTION_TYPE')
       select p.template, 
              sat.sat_id, sat.sat_stg_id, sat.sat_sif_id, sat.sat_name, 
              utl_text.wrap_string(sat.sat_description, 'q''{', '}''') sat_description,
              utl_text.wrap_string(sat.sat_pl_sql, 'q''{', '}''') sat_pl_sql,
              utl_text.wrap_string(sat.sat_js, 'q''{', '}''') sat_js,
              sct_util.to_bool(sat.sat_is_editable) sat_is_editable, 
              sct_util.to_bool(sat.sat_raise_recursive) sat_raise_recursive,
              -- rule action_params
              utl_text.generate_text(cursor(
                select p.template, ap.sap_sat_id, ap.sap_spt_id, ap.sap_sort_seq, 
                       sct_util.to_bool(ap.sap_mandatory) sap_mandatory, 
                       sct_util.to_bool(ap.sap_active) sap_active,
                       utl_text.wrap_string(ap.sap_default, 'q''{', '}''') sap_default,
                       utl_text.wrap_string(ap.sap_description, 'q''{', '}''') sap_description,
                       sap_display_name
                  from sct_action_parameter_v ap
                 cross join params p
                 where uttm_mode = 'ACTION_PARAMS'
                   and ap.sap_sat_id = sat.sat_id
              )) rule_action_params
         from sct_action_type_v sat
        cross join params p
        where (sat.sat_is_editable = p.sat_is_editable
           or p.sat_is_editable is null)
          and p.uttm_mode = 'ACTION_TYPE'#';
    l_action_param_types clob;
    l_action_item_focus clob;
    l_action_type_groups clob;
    l_action_type_list clob_table;
    l_action_types clob;
    l_cur sys_refcursor;
    l_stmt clob;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_sat_is_editable', to_char(p_sat_is_editable))));
    
    select utl_text.generate_text(cursor(
            select p.uttm_text template, 
                   spt.spt_id, spt.spt_name, sct_util.to_bool(spt.spt_active) spt_active, 
                   utl_text.wrap_string(spt.spt_description, C_WRAP_START, C_WRAP_END) spt_description
              from sct_action_param_type_v spt
             where decode(p_sat_is_editable, 'N', 1, null, 1, 0) = 1
          ))
      into l_action_param_types
      from utl_text_templates p
     where uttm_type = C_SCT
       and uttm_name = C_UTTM_NAME
       and uttm_mode = 'PARAM_TYPE';
    
    select utl_text.generate_text(cursor(
            select p.uttm_text template, 
                   sif.sif_id, sif.sif_name, sct_util.to_bool(sif.sif_active) sif_active, 
                   utl_text.wrap_string(sif.sif_description, C_WRAP_START, C_WRAP_END) sif_description
              from sct_action_item_focus_v sif
             where decode(p_sat_is_editable, 'N', 1, null, 1, 0) = 1
          ))
      into l_action_item_focus
      from utl_text_templates p
     where uttm_type = C_SCT
       and uttm_name = C_UTTM_NAME
       and uttm_mode = 'ITEM_FOCUS';
    
    select utl_text.generate_text(cursor(
            select p.uttm_text template, 
                   stg.stg_id, stg.stg_name, sct_util.to_bool(stg.stg_active) stg_active, 
                   utl_text.wrap_string(stg.stg_description, C_WRAP_START, C_WRAP_END) stg_description
              from sct_action_type_group_v stg
             where decode(p_sat_is_editable, 'N', 1, null, 1, 0) = 1
          ))
      into l_action_type_groups
      from utl_text_templates p
     where uttm_type = C_SCT
       and uttm_name = C_UTTM_NAME
       and uttm_mode = 'ACTION_TYPE_GROUP';
       
    -- Collect action types. Different API for performance and size reasons
    dbms_lob.createtemporary(l_action_types, false, dbms_lob.call);
    open l_cur for c_stmt;
    utl_text.generate_text_table(l_cur, l_action_type_list);
      
    for i in 1 .. l_action_type_list.count loop
      dbms_lob.append(l_action_types, l_action_type_list(i));
    end loop;
    
    -- create export statement
    select utl_text.generate_text(cursor(
             select uttm_text template,
                    l_action_param_types action_param_types,
                    l_action_item_focus action_item_focus,
                    l_action_type_groups action_type_groups,
                    l_action_types action_types
               from dual
           )) resultat
      into l_stmt
      from utl_text_templates
     where uttm_type = C_SCT
       and uttm_name = C_UTTM_NAME
       and uttm_mode = C_FRAME;
    
    pit.leave_mandatory(p_params => msg_params(msg_param('Return', substr(l_stmt, 1, 4000))));
    return l_stmt;
  end export_action_types;
  
  
  procedure merge_action_parameter(
    p_sap_sat_id in sct_action_parameter.sap_sat_id%type,
    p_sap_spt_id in sct_action_parameter.sap_spt_id%type,
    p_sap_sort_seq in sct_action_parameter.sap_sort_seq%type,
    p_sap_default in sct_action_parameter.sap_default%type,
    p_sap_description in pit_translatable_item.pti_description%type,
    p_sap_display_name in pit_translatable_item.pti_name%type,
    p_sap_mandatory in sct_action_parameter.sap_mandatory%type,
    p_sap_active in sct_action_parameter.sap_active%type default sct_util.C_TRUE)
  as
    l_pti_id pit_translatable_item.pti_id%type;
  begin
    -- maintain translatable item
    select 'SAP_' || standard_hash(p_sap_sat_id || p_sap_spt_id || p_sap_sort_seq, 'MD5')
      into l_pti_id
      from dual;
      
    pit_admin.merge_translatable_item(
      p_pti_id => l_pti_id,
      p_pti_pml_name => null,
      p_pti_pmg_name => C_SCT,
      p_pti_name => p_sap_display_name,
      p_pti_description => utl_text.unwrap_string(p_sap_description));
      
    -- store local data
    merge into sct_action_parameter t
    using (select p_sap_sat_id sap_sat_id,
                  p_sap_spt_id sap_spt_id,
                  p_sap_sort_seq sap_sort_seq,
                  p_sap_default sap_default,
                  l_pti_id sap_pti_id,
                  C_SCT sap_pmg_name,
                  p_sap_mandatory sap_mandatory,
                  sct_util.get_boolean(p_sap_active) sap_active
             from dual) s
       on (t.sap_sat_id = s.sap_sat_id
      and t.sap_spt_id = s.sap_spt_id
      and t.sap_sort_seq = s.sap_sort_seq)
     when matched then update set
          t.sap_pti_id = s.sap_pti_id,
          t.sap_default = s.sap_default,
          t.sap_mandatory = s.sap_mandatory,
          t.sap_active = s.sap_active
     when not matched then insert(sap_sat_id, sap_spt_id, sap_sort_seq, sap_default, sap_pti_id, sap_pmg_name, sap_mandatory, sap_active)
          values(s.sap_sat_id, s.sap_spt_id, s.sap_sort_seq, s.sap_default, s.sap_pti_id, s.sap_pmg_name, s.sap_mandatory, s.sap_active);
  end merge_action_parameter;
    
    
  procedure merge_action_parameter(
    p_row in out nocopy sct_action_parameter_v%rowtype)
  as
  begin
    merge_action_parameter(
      p_sap_sat_id => p_row.sap_sat_id,
      p_sap_spt_id => p_row.sap_spt_id,
      p_sap_sort_seq => p_row.sap_sort_seq,
      p_sap_default => p_row.sap_default,
      p_sap_description => p_row.sap_description,
      p_sap_display_name => p_row.sap_display_name,
      p_sap_mandatory => p_row.sap_mandatory,
      p_sap_active => p_row.sap_active);      
  end merge_action_parameter;
  
  
  procedure delete_action_parameter(
    p_row in sct_action_parameter_v%rowtype)
  as
  begin
    delete from sct_action_parameter
     where sap_sat_id = p_row.sap_sat_id
       and sap_spt_id = p_row.sap_spt_id
       and sap_sort_seq = p_row.sap_sort_seq;
  end delete_action_parameter;


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
    p_sra_comment in sct_rule_action.sra_comment%type default null)
  as
  begin
    pit.enter_mandatory;
    
    merge into sct_rule_action t
    using (select p_sra_id sra_id,
                  p_sra_sru_id sra_sru_id,
                  p_sra_sgr_id sra_sgr_id,
                  p_sra_spi_id sra_spi_id,
                  p_sra_sat_id sra_sat_id,
                  p_sra_param_1 sra_param_1,
                  p_sra_param_2 sra_param_2,
                  p_sra_param_3 sra_param_3,
                  p_sra_sort_seq sra_sort_seq,
                  sct_util.get_boolean(p_sra_on_error) sra_on_error,
                  sct_util.get_boolean(p_sra_raise_recursive) sra_raise_recursive,
                  sct_util.get_boolean(p_sra_active) sra_active,
                  p_sra_comment sra_comment
             from dual) s
       on (t.sra_id = s.sra_id)
     when matched then update set
          t.sra_spi_id = s.sra_spi_id, 
          t.sra_sat_id = s.sra_sat_id,
          t.sra_param_1 = s.sra_param_1,
          t.sra_param_2 = s.sra_param_2,
          t.sra_sort_seq = s.sra_sort_seq,
          t.sra_raise_recursive = s.sra_raise_recursive,
          t.sra_active = s.sra_active,
          t.sra_comment = s.sra_comment
     when not matched then insert (
            sra_id, sra_sru_id, sra_sgr_id, sra_spi_id, sra_sat_id, sra_param_1, sra_param_2, sra_param_3, 
            sra_sort_seq, sra_on_error, sra_raise_recursive, sra_active, sra_comment)
          values(
            s.sra_id, s.sra_sru_id, s.sra_sgr_id, s.sra_spi_id, s.sra_sat_id, s.sra_param_1, s.sra_param_2, s.sra_param_3, 
            s.sra_sort_seq, s.sra_on_error, s.sra_raise_recursive, s.sra_active, s.sra_comment);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.stop(msg.SCT_MERGE_RULE_ACTION, msg_args(to_char(p_sra_sru_id), to_char( p_sra_spi_id)));
  end merge_rule_action;
  
  
  procedure merge_rule_action(
    p_row in out nocopy sct_rule_action%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    merge_rule_action(
      p_sra_id => p_row.sra_id,
      p_sra_sru_id => p_row.sra_sru_id,
      p_sra_sgr_id => p_row.sra_sgr_id,
      p_sra_spi_id => p_row.sra_spi_id,
      p_sra_sat_id => p_row.sra_sat_id,
      p_sra_param_1 => p_row.sra_param_1,
      p_sra_param_2 => p_row.sra_param_2,
      p_sra_param_3 => p_row.sra_param_3,
      p_sra_sort_seq => p_row.sra_sort_seq,
      p_sra_on_error => p_row.sra_on_error,
      p_sra_raise_recursive => p_row.sra_raise_recursive,
      p_sra_active => p_row.sra_active,
      p_sra_comment => p_row.sra_comment);
      
    pit.leave_mandatory;
  end merge_rule_action;
  
  
  procedure delete_rule_action(
    p_sra_id in sct_rule_action.sra_id%type)
  as
  begin
    pit.enter_mandatory;
    
    delete from sct_rule_action
     where sra_id = p_sra_id;
       
    pit.leave_mandatory;
  end delete_rule_action;
  
  
  procedure delete_rule_action(
    p_row in out nocopy sct_rule_action%rowtype)
  as
  begin
    delete_rule_action(
      p_sra_id => p_row.sra_id);
  end delete_rule_action;
  
  
  procedure add_translation(
    p_table_shortcut in varchar2,
    p_item_id in varchar2,
    p_pml_name pit_message_language.pml_name%type,
    p_name in pit_translatable_item.pti_name%type,
    p_display_name in pit_translatable_item.pti_display_name%type,
    p_description in pit_translatable_item.pti_description%type)
  as
  begin
    pit_admin.merge_translatable_item(
      p_pti_id => p_table_shortcut || '_' || p_item_id,
      p_pti_pml_name => p_pml_name,
      p_pti_pmg_name => C_SCT,
      p_pti_name => p_name,
      p_pti_display_name => p_display_name,
      p_pti_description => p_description);
  end add_translation;

begin
  initialize;
end sct_admin;
/
