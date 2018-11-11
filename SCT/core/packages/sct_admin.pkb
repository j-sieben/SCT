create or replace package body sct_admin
as

  C_PKG constant varchar2(30 byte) := $$PLSQL_UNIT;
  C_UTTM_TYPE constant utl_text_templates.uttm_type%type := 'SCT';

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
           select sgr.sgr_id, C_CR cr,
                  uttm.uttm_name, uttm.uttm_mode, uttm.uttm_text template, 
                  app.attribute_02, app.attribute_03, app.attribute_04, app.application_id, app.page_id
             from apex_application_page_proc app
             join sct_rule_group sgr
               on app.application_id = sgr.sgr_app_id
              and app.page_id = sgr.sgr_page_id
            cross join utl_text_templates uttm
            where app.process_type_code = 'DML_FETCH_ROW'
              and uttm_type = C_UTTM_TYPE
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
                         and p.uttm_name = 'INITIALIZE_COLUMN'), ',' || C_CR) sql_stmt,
                    -- generate utl_apex.set_session_state calls for any page element
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
                         and spi.spi_is_required = C_TRUE
                         and p.uttm_name = 'INITIALIZE_COL_VAL'), C_CR) item_stmt
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
   * %param  p_sgr_id  Rule group ID
   * %usage  If a rule group changes, all rules and page elements are checked against each other.
   *         The resulting values are used as the basis for a single rule.
   *         Attention: Method removes non existing page items from the table and deletes any rule actions 
   *                    attached to these page items!
   */
  procedure harmonize_sct_page_item(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
    l_initialization_code sct_rule_group.sgr_initialization_code%type;
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
      -- Step 1: remove REQUIRED flags
      update sct_page_item
         set spi_is_required = C_FALSE,
              -- mark any element as erroneus, will be cleared later on
             spi_has_error = C_TRUE
       where spi_sgr_id = p_sgr_id;
       
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('REQUIRED flags set'));
      
      -- Step 2: Merge APEX page items into SCT_PAGE_ITEMS
      merge into sct_page_item spi
      using (select sgr_id spi_sgr_id,
                    target_type spi_sit_id,
                    target_name spi_id,
                    spi_conversion,
                    spi_item_default,
                    item_css spi_css,
                    C_FALSE spi_has_error
               from sct_bl_page_targets
              where sgr_id = p_sgr_id) v
         on (spi.spi_id = v.spi_id and spi.spi_sgr_id = v.spi_sgr_id)
       when matched then update set
            spi.spi_sit_id = v.spi_sit_id,
            spi.spi_conversion = v.spi_conversion,
            spi.spi_item_default = v.spi_item_default,
            spi.spi_css = v.spi_css,
            spi.spi_has_error = v.spi_has_error
       when not matched then insert(spi_id, spi_sit_id, spi_sgr_id, spi_conversion, spi_item_default, spi_css)
            values(v.spi_id, v.spi_sit_id, v.spi_sgr_id, v.spi_conversion, v.spi_item_default, v.spi_css);
            
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('APEX items merged into SCT_PAGE_ITEMS'));
      
      -- Step 3: mark page items referenced in a single rule as relevant
      merge into sct_page_item spi
      using (select distinct sgr.sgr_id spi_sgr_id, i.column_value spi_id
               from sct_rule sru
               join sct_rule_group sgr
                 on sru.sru_sgr_id = sgr.sgr_id
              cross join table(utl_text.string_to_table(sru.sru_firing_items, ',')) i
              where sgr_id = p_sgr_id) v
         on (spi.spi_id = v.spi_id 
        and spi.spi_sgr_id = v.spi_sgr_id)
       when matched then update set
            spi.spi_is_required = C_TRUE;
            
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('Relevant items marked'));
      
      -- Step 4: remove elements which are
      -- - irrelevant and
      -- - erroneus (fi not existing anymore) and
      -- - not referenced by rule actions
      delete from sct_page_item spi
       where spi_sgr_id = p_sgr_id
         and spi_is_required = C_FALSE
         and spi_has_error = C_TRUE
         and spi_id not in (
             select sra_spi_id
               from sct_rule_action
              where sra_sgr_id = p_sgr_id);
            
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('Irrelevant, erroneous and not referenced items removed'));
              
      -- Mark errors in SCT_RULE and SCT_RULE_ACTION
      update sct_rule
         set sru_has_error = C_FALSE
       where sru_sgr_id = p_sgr_id;
      
       merge into sct_rule sru
       using (select distinct sru.sru_id
                from sct_page_item spi
                join sct_rule sru
                  on utl_text.contains(sru_firing_items, spi_id) = C_YES
               where spi_sgr_id = p_sgr_id
                 and spi_has_error = C_TRUE) v
          on (sru.sru_id = v.sru_id)
        when matched then update set
             sru_has_error = C_TRUE;
      
      update sct_rule_action
         set sra_has_error = C_FALSE
       where sra_sgr_id = p_sgr_id;
      
       merge into sct_rule_action sra
       using (select spi_sgr_id sra_sgr_id, spi_id sra_spi_id
                from sct_page_item
               where spi_sgr_id = p_sgr_id
                 and spi_has_error = C_TRUE) v
          on (sra.sra_sgr_id = v.sra_sgr_id and sra.sra_spi_id = v.sra_spi_id)
        when matched then update set
             sra_has_error = C_TRUE;
            
      pit.verbose(msg.ALLG_PASS_INFORMATION, msg_args('Errors marked'));
             
      -- create initialization code and persist at SCT_RULE_GROUP for fast page initialization
      l_initialization_code := create_initialization_code(p_sgr_id);
      update sct_rule_group
         set sgr_initialization_code = l_initialization_code
       where sgr_id = p_sgr_id;
       
    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.SCT_INITIALZE_SGR_FAILED, msg_args(to_char(p_sgr_id)));
  end harmonize_sct_page_item;
  

  /* Helper to harmonize page items which are referenced by a rule at table SCT_RULE
   * %param  p_sgr_id  Rule group ID
   * %usage  Method extracts page item names from a rule condition using regex C_REGEX_ITEM
   *         Used to validate a rule condition and further application logic
   */
  procedure harmonize_firing_items(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
    C_REGEX_ITEM constant varchar2(50 byte) := q'~(^|[ '\(])#ITEM#([ ',=<^>\)]|$)~';
    C_REGEX_CSS constant varchar2(50 byte) := q'~'.+'~';
  begin
    pit.enter_detailed(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
    merge into sct_rule sru
    using (select sru.sru_id,
                  listagg(spt.target_name, ',') within group (order by spt.target_name) sru_firing_items
             from sct_bl_page_targets spt
             join sct_rule sru
               on spt.sgr_id = sru.sru_sgr_id
              and (regexp_instr(upper(sru.sru_condition), replace(C_REGEX_ITEM, '#ITEM#', spt.target_name)) > 0
               or instr(item_css, replace(regexp_substr(sru.sru_condition, C_REGEX_CSS), '''', '|')) > 0)
            where spt.sgr_id = p_sgr_id
              and sru.sru_active = C_TRUE
            group by sru.sru_id) v
       on (sru.sru_id = v.sru_id)
     when matched then update set
          sru.sru_firing_items = v.sru_firing_items;
          
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
            where uttm_type = C_UTTM_TYPE
              and uttm_name = C_UTTM_NAME)
    select utl_text.generate_text(cursor(
             select p.template, p.log_template, C_VIEW_NAME_PREFIX prefix, sgr_id,
                    utl_text.generate_text(cursor(
                      select sit_col_template template, replace(spi_conversion, 'G') conversion, spi_id item
                        from sct_page_item spi
                        join sct_page_item_type sit
                          on spi.spi_sit_id = sit.sit_id
                       where spi_sgr_id = p_sgr_id
                         and ((spi_is_required = C_TRUE)
                          or (sit.sit_id = 'DOCUMENT'))
                         and sit_col_template is not null
                       order by spi_id), ',' || C_CR || '              ') column_list,
                    utl_text.generate_text(cursor(
                      select p.template,
                             sru_id, sru_condition 
                        from params p
                        join sct_rule
                          on sru_sgr_id in (0, p.sgr_id)
                       where uttm_mode = 'JOIN_CLAUSE'
                         and sru_active = C_TRUE
                       order by sru_id), C_CR || '           or ') where_clause
               from dual)) resultat
      into l_stmt
      from params p
     where uttm_mode = 'FRAME';
     
    -- create view
    execute immediate l_stmt;

    pit.leave_optional;
  exception
    when others then
      pit.stop(msg.SCT_VIEW_CREATION, msg_args(sqlerrm, l_stmt));
  end create_rule_view;
  
  
  /* Helper to resequence rules and rule acrtions
   * %param  p_sgr_id  Rule group ID
   * %usage  Is called automatically upon change of a rule group to resequence all entries in steps of 10
   */
  procedure resequence_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
  as
  begin
    pit.enter_optional(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));
    
    -- resequence rules
    merge into sct_rule sru
    using (select sru_id, sru_sgr_id,
                  row_number() over (partition by sru_sgr_id order by sru_sort_seq) * 10 sru_sort_seq
             from sct_rule
            where sru_sgr_id = p_sgr_id
              and sru_sgr_id > 0) v
       on (sru.sru_id = v.sru_id and sru.sru_sgr_id = v.sru_sgr_id)
     when matched then update set
          sru_sort_seq = v.sru_sort_seq;

    -- resequence rule actions
    merge into sct_rule_action sra
    using (select rowid row_id,
                  row_number() over (partition by sra_sru_id order by sra_on_error, sra_sort_seq) * 10 sra_sort_seq
             from sct_rule_action
            where sra_sgr_id = p_sgr_id) v
       on (sra.rowid = v.row_id)
     when matched then update set
          sra_sort_seq = v.sra_sort_seq;

    -- Is called outside the request-respons-cycle, so commit explicitly
    commit;
    
    pit.leave_optional;
  end resequence_rule_group;
  
  
  /* Initialisierungsmethode */
  procedure initialize
  as
  begin
    g_offset := 0;
  end;


  /* INTERFACE */
  -- Getter and Setter
  procedure set_app_offset(
    p_offset in binary_integer)
  as
  begin
    g_offset := p_offset;
  end set_app_offset;


  /* Public DDL methods */
  procedure merge_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_page_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_name in sct_rule_group.sgr_name%type,
    p_sgr_description in sct_rule_group.sgr_description%type,
    p_sgr_with_recursion in sct_rule_group.sgr_with_recursion%type,
    p_sgr_active in sct_rule_group.sgr_active%type default C_TRUE)
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
    
    -- If present, delete cascade existing rule group
    delete from sct_rule_group
     where sgr_page_id = p_sgr_page_id
       and sgr_name = p_sgr_name;
       
    merge into sct_rule_group s
    using (select l_sgr_id sgr_id,
                  upper(p_sgr_name) sgr_name,
                  p_sgr_description sgr_description,
                  p_sgr_app_id + g_offset sgr_app_id,
                  p_sgr_page_id sgr_page_id,
                  p_sgr_with_recursion sgr_with_recursion,
                  p_sgr_active sgr_active
             from dual) v
       on (s.sgr_id = v.sgr_id and s.sgr_app_id = v.sgr_app_id)
     when matched then update set
          sgr_name = v.sgr_name,
          sgr_description = v.sgr_description,
          sgr_page_id = v.sgr_page_id,
          sgr_with_recursion = v.sgr_with_recursion,
          sgr_active = v.sgr_active
     when not matched then insert(sgr_id, sgr_name, sgr_description, sgr_app_id, sgr_page_id, sgr_with_recursion, sgr_active)
          values(v.sgr_id, v.sgr_name, v.sgr_description, v.sgr_app_id, v.sgr_page_id, v.sgr_with_recursion, v.sgr_active);

    harmonize_sct_page_item(l_sgr_id);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SCT_MERGE_RULE_GROUP, msg_args(to_char(l_sgr_id)));
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


  procedure copy_rule_group(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type,
    p_sgr_page_id in sct_rule_group.sgr_app_id%type,
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sgr_app_to in sct_rule_group.sgr_app_id%type,
    p_sgr_page_to in sct_rule_group.sgr_page_id%type)
  as
    l_foo number;
    l_sgr_id sct_rule_group.sgr_id%type;
  begin
    pit.enter_mandatory(p_params => msg_params(
      msg_param('p_sgr_app_id', to_char(p_sgr_app_id)),
      msg_param('p_sgr_page_id', to_char(p_sgr_page_id)),
      msg_param('p_sgr_id', to_char(p_sgr_id)),
      msg_param('p_sgr_app_to', to_char(p_sgr_app_to)),
      msg_param('p_sgr_page_to', to_char(p_sgr_page_to))));
      
    -- Pruefe, ob Quellseite existiert
    pit.assert_exists(
      'select null ' ||
      '  from apex_applications ' ||
      ' where application_id = ' || p_sgr_app_id,
      msg.SCT_APP_DOES_NOT_EXIST,
      msg_args(to_char(p_sgr_app_id)));

    -- Pruefe, ob Zielseite existiert
    pit.assert_exists(
      'select null ' ||
      '  from apex_application_pages ' ||
      ' where application_id = ' || p_sgr_app_id ||
      '   and page_id = ' || p_sgr_page_id,
      msg.SCT_PAGE_DOES_NOT_EXIST,
      msg_args(to_char(p_sgr_app_id)));

    -- Initialisierung
    l_foo := map_id(null);
    begin
      select sgr_id
        into l_sgr_id
        from sct_rule_group
       where sgr_app_id = p_sgr_app_id
         and sgr_page_id = p_sgr_page_id
         and sgr_id = p_sgr_id;
    exception
      when no_data_found then
        pit.stop(msg.SCT_RULE_DOES_NOT_EXIST, msg_args(to_char(p_sgr_id)));
    end;

    -- Make sure that rule does not copy over itself to prevent deleting the rule group
    if (p_sgr_app_id != p_sgr_app_to or p_sgr_page_id != p_sgr_page_to) then
      -- Loesche existierende Regelgruppe in Zielanwendung
      delete from sct_rule_group
       where sgr_app_id = p_sgr_app_to
         and sgr_page_id = p_sgr_page_to
         and sgr_name = (select sgr_name
                           from sct_rule_group
                          where sgr_id = p_sgr_id);

      -- Read rule group details
      insert into sct_rule_group(sgr_id, sgr_name, sgr_description, sgr_app_id, sgr_page_id)
      select map_id(sgr_id), sgr_name, sgr_description, p_sgr_app_to, p_sgr_page_to
        from sct_rule_group
       where sgr_id = l_sgr_id;

      insert into sct_rule(sru_id, sru_sgr_id, sru_name, sru_condition, sru_firing_items, sru_sort_seq)
      select map_id(sru_id), map_id(sru_sgr_id), sru_name,
             replace(upper(sru_condition), 'P' || p_sgr_page_id || '_',  'P' || p_sgr_page_to || '_'),
             sru_firing_items,
             sru_sort_seq
        from sct_rule
       where sru_sgr_id = l_sgr_id;

      propagate_rule_change(map_id(l_sgr_id));

     -- Read rule actions
     insert into sct_rule_action(sra_sgr_id, sra_sru_id, sra_spi_id, sra_sat_id, sra_on_error, sra_raise_recursive, 
              sra_attribute, sra_attribute_2, sra_sort_seq, sra_active, sra_comment)
      select map_id(sra_sgr_id), map_id(sra_sru_id), sra_spi_id, sra_sat_id, sra_on_error, sra_raise_recursive,
             replace(upper(sra_attribute), 'P' || p_sgr_page_id || '_',  'P' || p_sgr_page_to || '_'),
             replace(upper(sra_attribute_2), 'P' || p_sgr_page_id || '_',  'P' || p_sgr_page_to || '_'),
             sra_sort_seq, sra_active, sra_comment
        from sct_rule_action
       where sra_sgr_id = l_sgr_id;
       
      -- TODO: Copy apex actions
    end if;
    
    pit.leave_mandatory;
  end copy_rule_group;


  function map_id(
    p_id in number)
    return number
  as
    l_new_id binary_integer;
  begin
    pit.enter_mandatory;
    
    if p_id is null then
      init_map;
    else
      if not g_id_map.exists(p_id) then
        g_id_map(p_id) := sct_seq.nextval;
      end if;
      l_new_id := g_id_map(p_id);
    end if;
    
    pit.leave_mandatory(p_params => msg_params(msg_param('Return', to_char(l_new_id))));
    return l_new_id;
  end map_id;


  procedure init_map
  as
  begin
    pit.enter_mandatory;
    
    g_id_map.delete;
    
    pit.leave_mandatory;
  end init_map;
  
  
  function export_all_rule_groups
    return clob
  as
    cursor rule_group_cur is
      select sgr_id
        from sct_rule_group;
    l_stmt clob;
    c_sgr_delimiter constant varchar2(20) := C_CR || C_CR || C_CR;
  begin
    pit.enter_mandatory;
    dbms_lob.createTemporary(l_stmt, false, dbms_lob.call);

    -- Create and append script for each rule group
    for sgr in rule_group_cur loop
      dbms_lob.append(l_stmt, export_rule_group(sgr.sgr_id));
    end loop;
    
    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_stmt)));
    return l_stmt;
  end export_all_rule_groups;


  function export_rule_groups(
    p_sgr_app_id in sct_rule_group.sgr_app_id%type)
    return clob
  as
    cursor rule_group_cur(p_sgr_app_id in sct_rule_group.sgr_app_id%type) is
      select sgr_id
        from sct_rule_group
       where sgr_app_id = p_sgr_app_id;
    l_stmt clob;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_sgr_app_id', to_char(p_sgr_app_id))));
    dbms_lob.createtemporary(l_stmt, false, dbms_lob.call);

    for sgr in rule_group_cur(p_sgr_app_id) loop
      dbms_lob.append(l_stmt, export_rule_group(sgr.sgr_id));
    end loop;

    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_stmt)));
    return l_stmt;
  end export_rule_groups;


  function export_rule_group(
    p_sgr_id in sct_rule_group.sgr_id%type)
    return clob
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'EXPORT_RULE_GROUP';
    l_stmt clob;
    l_app_id sct_rule_group.sgr_app_id%type;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_sgr_id', to_char(p_sgr_id))));

      with params as (
           select uttm_mode, uttm_text template, 
                  sgr.*
             from utl_text_templates
            cross join sct_rule_group sgr
            where uttm_type = C_UTTM_TYPE
              and uttm_name = C_UTTM_NAME
              and sgr_id = p_sgr_id)
    select utl_text.generate_text(cursor(
             select template, sgr_id, sgr_name, sgr_description, sgr_page_id, sgr_active, sgr_with_recursion,
                    -- apex_actions
                    utl_text.generate_text(cursor(
                      select p.template, saa.*
                        from sct_apex_action saa
                        join params p
                          on p.uttm_mode = 'APEX_ACTION_' || saa.saa_sty_id
                    )) apex_actions,
                    -- rules
                    utl_text.generate_text(cursor(
                      select p.template, r.*,
                             -- rule actions
                             utl_text.generate_text(cursor(
                               select p.template, a.*
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
     where uttm_mode = 'FRAME';

    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_stmt)));
    return l_stmt;
  end export_rule_group;
  
  
  function export_action_types(
    p_sat_is_editable in sct_action_type.sat_is_editable%type default C_TRUE)
    return clob
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'EXPORT_ACTION_TYPE';
    l_stmt clob;
  begin
    pit.enter_mandatory(p_params => msg_params(msg_param('p_sat_is_editable', to_char(p_sat_is_editable))));
    
    -- create export statement
      with params as (
           select uttm_mode, uttm_text template, p_sat_is_editable sat_is_editable
             from utl_text_templates
            where uttm_type = C_UTTM_TYPE
              and uttm_name = C_UTTM_NAME)
    select utl_text.generate_text(cursor(
             select template,
                    utl_text.generate_text(cursor(
                      select p.template, sat.sat_id, sat.sat_name, 
                             utl_text.wrap_string(sat.sat_description, q'^q'°^', q'^°'^') sat_description,
                             utl_text.wrap_string(sat.sat_pl_sql, q'^q'°^', q'^°'^') sat_pl_sql,
                             utl_text.wrap_string(sat.sat_js, q'^q'°^', q'^°'^') sat_js,
                             sat.sat_is_editable, sat.sat_raise_recursive, 
                             sat.sat_default_attribute_1, sat.sat_check_attribute_1,
                             sat.sat_default_attribute_2, sat.sat_check_attribute_2
                        from sct_action_type sat
                       cross join params p
                       where (sat.sat_is_editable = p.sat_is_editable
                          or p.sat_is_editable is null)
                         and p.uttm_mode = 'ACTION_TYPE'
                    )) action_types
               from dual
           )) resultat
      into l_stmt
      from params
     where uttm_mode = 'FRAME';
    
    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_stmt)));
    return l_stmt;
  end export_action_types;


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
              and uttm_type = C_UTTM_TYPE
              and uttm_name = C_UTTM_NAME
              and exists(
                  select null
                    from sct_page_item
                   where spi_sgr_id = sgr_id
                     and spi_has_error = C_TRUE))
    select utl_text.generate_text(cursor(
             select template, sgr_name,
                    utl_text.generate_text(cursor(
                      select p.template, p.sgr_app_id, spi.spi_id
                        from sct_page_item spi
                        join sct_page_item_type sit
                          on spi.spi_sit_id = sit.sit_id
                        join params p
                          on spi.spi_sgr_id = p.sgr_id
                       where spi.spi_has_error = C_TRUE
                    )) error_list
               from dual
           )) resultat
      into l_error_list
      from params
     where uttm_mode = 'FRAME';

    pit.leave_mandatory(p_params => msg_params(msg_param('Return', l_error_list)));
    return l_error_list;
  end validate_rule_group;


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
  

  procedure delete_apex_action(    
    p_row sct_apex_action%rowtype)  
  as  
  begin
    pit.enter_mandatory;
    
    delete from sct_apex_action  
     where saa_sgr_id = p_row.saa_sgr_id
       and saa_name = p_row.saa_name;
       
    pit.leave_mandatory;
  end delete_apex_action;  
  
  
  procedure merge_apex_action(   
    p_row sct_apex_action%rowtype)  
  as  
  begin
    pit.enter_mandatory;
    
    merge into sct_apex_action t    
    using (select p_row.saa_sgr_id saa_sgr_id,
                  p_row.saa_name saa_name,
                  p_row.saa_sty_id saa_sty_id,
                  p_row.saa_label saa_label,
                  p_row.saa_context_label saa_context_label,
                  p_row.saa_icon saa_icon,
                  p_row.saa_icon_type saa_icon_type,
                  p_row.saa_title saa_title,
                  p_row.saa_shortcut saa_shortcut,
                  p_row.saa_initially_disabled saa_initially_disabled,
                  p_row.saa_initially_hidden saa_initially_hidden,
                  p_row.saa_href saa_href,
                  p_row.saa_href_noop saa_href_noop,
                  p_row.saa_action saa_action,
                  p_row.saa_action_noop saa_action_noop,
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
       on (t.saa_sgr_id = s.saa_sgr_id
      and t.saa_name = s.saa_name)    
     when matched then update set               
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
            t.saa_href_noop = s.saa_href_noop,
            t.saa_action = s.saa_action,
            t.saa_action_noop = s.saa_action_noop,
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
            t.saa_sgr_id, t.saa_name, t.saa_sty_id, t.saa_label, t.saa_context_label, t.saa_icon, t.saa_icon_type, t.saa_title, 
            t.saa_shortcut, t.saa_initially_disabled, t.saa_initially_hidden, t.saa_href, t.saa_href_noop, t.saa_action, t.saa_action_noop,  
            t.saa_get, t.saa_set, t.saa_on_label, t.saa_off_label, t.saa_choices, t.saa_label_classes, t.saa_label_start_classes, 
            t.saa_label_end_classes, t.saa_item_wrap_class)          
          values(            
            s.saa_sgr_id, s.saa_name, s.saa_sty_id, s.saa_label, s.saa_context_label, s.saa_icon, s.saa_icon_type, s.saa_title, 
            s.saa_shortcut, s.saa_initially_disabled, s.saa_initially_hidden, s.saa_href, s.saa_href_noop, s.saa_action_noop, 
            s.saa_on_label, s.saa_off_label, s.saa_choices, s.saa_label_classes, s.saa_label_start_classes, 
            s.saa_action, s.saa_get, s.saa_set, s.saa_label_end_classes, s.saa_item_wrap_class);  
    
    pit.leave_mandatory;
  end merge_apex_action;
  
  
  procedure merge_apex_action(    
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
    p_saa_href_noop in sct_apex_action.saa_href_noop%type default null,
    p_saa_action in sct_apex_action.saa_action%type default null,
    p_saa_action_noop in sct_apex_action.saa_action_noop%type default null,
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
    l_row.saa_href_noop := p_saa_href_noop;
    l_row.saa_action := p_saa_action;
    l_row.saa_action_noop := p_saa_action_noop;
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


  procedure merge_rule(
    p_sru_id in sct_rule.sru_id%type default null,
    p_sru_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_name in sct_rule.sru_name%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_sru_fire_on_page_load in sct_rule.sru_fire_on_page_load%type,
    p_sru_sort_seq in sct_rule.sru_sort_seq%type,
    p_sru_active in sct_rule.sru_active%type default C_TRUE)
  as
  begin
    pit.enter_mandatory;
    
    merge into sct_rule sru
    using (select p_sru_id sru_id,
                  p_sru_sgr_id sru_sgr_id,
                  p_sru_name sru_name,
                  p_sru_condition sru_condition,
                  p_sru_fire_on_page_load sru_fire_on_page_load,
                  p_sru_sort_seq sru_sort_seq,
                  p_sru_active sru_active
             from dual) v
       on (sru.sru_id = v.sru_id
       and sru.sru_sgr_id = v.sru_sgr_id)
     when matched then update set
          sru_name = v.sru_name,
          sru_condition = v.sru_condition,
          sru_fire_on_page_load = v.sru_fire_on_page_load,
          sru_sort_seq = v.sru_sort_seq,
          sru_active = v.sru_active
     when not matched then insert(sru_id, sru_sgr_id, sru_name, sru_condition, sru_fire_on_page_load, sru_sort_seq, sru_active)
          values (v.sru_id, v.sru_sgr_id, v.sru_name, v.sru_condition, v.sru_fire_on_page_load, v.sru_sort_seq, v.sru_active);
    
    pit.leave_mandatory;
  exception
    when others then
      pit.sql_exception(msg.SCT_MERGE_RULE, msg_args(p_sru_name));
  end merge_rule;


  procedure delete_rule(
    p_sru_id in sct_rule.sru_id%type default null)
  as
  begin
    pit.enter_mandatory;
    
    delete from sct_rule
     where sru_id = p_sru_id;
     
    pit.leave_mandatory;
  end delete_rule;


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
  exception
    when others then
      pit.leave_mandatory;
  end propagate_rule_change;


  procedure validate_rule(
    p_sgr_id in sct_rule_group.sgr_id%type,
    p_sru_condition in sct_rule.sru_condition%type,
    p_error out nocopy varchar2)
  as
    C_UTTM_NAME constant utl_text_templates.uttm_name%type := 'VALIDATE_RULE';
    l_data_cols varchar2(32767);
    l_stmt varchar2(32767);
    l_ctx pls_integer;
  begin
    pit.enter_mandatory;
    
    harmonize_sct_page_item(p_sgr_id);
    
    -- create validation statement
      with params as(
           select uttm_text template, 
                  p_sgr_id sgr_id, 
                  'CONDITION' condition
             from utl_text_templates
            where uttm_type = C_UTTM_TYPE
              and uttm_name = C_UTTM_NAME
              and uttm_mode = 'DEFAULT')
    select utl_text.generate_text(cursor(
             select p.template, p.condition,
                    utl_text.generate_text(cursor(
                       select sit_col_template template, replace(spi_conversion, 'G') conversion, spi_id item
                         from sct_page_item spi
                         join sct_page_item_type sit
                           on spi.spi_sit_id = sit.sit_id
                        where spi_sgr_id = p.sgr_id
                          and sit_col_template is not null
                        order by spi_id), ',' || C_CR || '              ') column_list
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
      p_error := l_stmt;
      pit.leave_mandatory;
  end validate_rule;


  procedure merge_rule_action(
    p_sra_sru_id in sct_rule.sru_id%type,
    p_sra_sgr_id in sct_rule_group.sgr_id%type,
    p_sra_spi_id in sct_page_item.spi_id%type,
    p_sra_sat_id in sct_action_type.sat_id%type,
    p_sra_attribute in sct_rule_action.sra_attribute%type,
    p_sra_attribute_2 in sct_rule_action.sra_attribute_2%type,
    p_sra_sort_seq in sct_rule_action.sra_sort_seq%type,
    p_sra_on_error in sct_rule_action.sra_on_error%type default C_FALSE,
    p_sra_raise_recursive in sct_rule_action.sra_raise_recursive%type default C_TRUE,
    p_sra_active in sct_rule_action.sra_active%type default C_TRUE,
    p_sra_comment in sct_rule_action.sra_comment%type default null)
  as
  begin
    pit.enter_mandatory;
    
    merge into sct_rule_action sra
    using (select p_sra_sru_id sra_sru_id,
                  p_sra_sgr_id sra_sgr_id,
                  p_sra_spi_id sra_spi_id,
                  p_sra_sat_id sra_sat_id,
                  p_sra_attribute sra_attribute,
                  p_sra_attribute_2 sra_attribute_2,
                  p_sra_sort_seq sra_sort_seq,
                  p_sra_on_error sra_on_error,
                  p_sra_raise_recursive sra_raise_recursive,
                  p_sra_active sra_active,
                  p_sra_comment sra_comment
             from dual) v
       on (sra.sra_sru_id = v.sra_sru_id
      and sra.sra_sgr_id = v.sra_sgr_id
      and sra.sra_spi_id = v.sra_spi_id
      and sra.sra_sat_id = v.sra_sat_id
      and sra.sra_on_error = v.sra_on_error)
     when matched then update set
          sra_attribute = v.sra_attribute,
          sra_attribute_2 = v.sra_attribute_2,
          sra_sort_seq = v.sra_sort_seq,
          sra_raise_recursive = v.sra_raise_recursive,
          sra_active = v.sra_active,
          sra_comment = v.sra_comment
     when not matched then insert (sra_sru_id, sra_sgr_id, sra_spi_id, sra_sat_id, sra_attribute, sra_attribute_2, sra_sort_seq, sra_on_error, sra_raise_recursive, sra_active, sra_comment)
          values(v.sra_sru_id, v.sra_sgr_id, v.sra_spi_id, v.sra_sat_id, v.sra_attribute, v.sra_attribute_2, v.sra_sort_seq, v.sra_on_error, v.sra_raise_recursive, v.sra_active, v.sra_comment);
    
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
      p_sra_sru_id => p_row.sra_sru_id,
      p_sra_sgr_id => p_row.sra_sgr_id,
      p_sra_spi_id => p_row.sra_spi_id,
      p_sra_sat_id => p_row.sra_sat_id,
      p_sra_attribute => p_row.sra_attribute,
      p_sra_attribute_2 => p_row.sra_attribute_2,
      p_sra_sort_seq => p_row.sra_sort_seq,
      p_sra_on_error => p_row.sra_on_error,
      p_sra_raise_recursive => p_row.sra_raise_recursive,
      p_sra_active => p_row.sra_active,
      p_sra_comment => p_row.sra_comment);
      
    pit.leave_mandatory;
  end merge_rule_action;
  
  
  procedure delete_rule_action(
    p_sra_sru_id in sct_rule.sru_id%type,
    p_sra_sgr_id in sct_rule_group.sgr_id%type,
    p_sra_spi_id in sct_page_item.spi_id%type,
    p_sra_sat_id in sct_action_type.sat_id%type,
    p_sra_on_error in sct_rule_action.sra_on_error%type)
  as
  begin
    pit.enter_mandatory;
    
    delete from sct_rule_action
     where sra_sru_id = p_sra_sru_id
       and sra_sgr_id = p_sra_sgr_id
       and sra_spi_id = p_sra_spi_id
       and sra_sat_id = p_sra_sat_id
       and sra_on_error = p_sra_on_error;
       
    pit.leave_mandatory;
  end delete_rule_action;


  procedure merge_action_type(
    p_sat_id in sct_action_type.sat_id%type,
    p_sat_name in sct_action_type.sat_name%type,
    p_sat_description in sct_action_type.sat_description%type default null,
    p_sat_pl_sql in sct_action_type.sat_pl_sql%type,
    p_sat_js in sct_action_type.sat_js%type,
    p_sat_default_attribute_1 sct_action_type.sat_default_attribute_1%type default null,
    p_sat_check_attribute_1 sct_action_type.sat_check_attribute_1%type default null,
    p_sat_default_attribute_2 sct_action_type.sat_default_attribute_2%type default null,
    p_sat_check_attribute_2 sct_action_type.sat_check_attribute_2%type default null,
    p_sat_is_editable in sct_action_type.sat_is_editable%type default C_TRUE,
    p_sat_raise_recursive in sct_action_type.sat_raise_recursive%type default C_TRUE)
  as
  begin
    pit.enter_mandatory;
    
    merge into sct_action_type sat
    using (select p_sat_id sat_id,
                  p_sat_name sat_name,
                  p_sat_description sat_description,
                  p_sat_pl_sql sat_pl_sql,
                  p_sat_js sat_js,
                  p_sat_default_attribute_1 sat_default_attribute_1,
                  p_sat_check_attribute_1 sat_check_attribute_1,
                  p_sat_default_attribute_2 sat_default_attribute_2,
                  p_sat_check_attribute_2 sat_check_attribute_2,
                  p_sat_is_editable sat_is_editable,
                  p_sat_raise_recursive sat_raise_recursive
             from dual) v
       on (sat.sat_id = v.sat_id)
     when matched then update set
          sat_name = v.sat_name,
          sat_description = v.sat_description,
          sat_pl_sql = v.sat_pl_sql,
          sat_js = v.sat_js,
          sat_default_attribute_1 = v.sat_default_attribute_1,
          sat_check_attribute_1 = v.sat_check_attribute_1,
          sat_default_attribute_2 = v.sat_default_attribute_2,
          sat_check_attribute_2 = v.sat_check_attribute_2,
          sat_is_editable = v.sat_is_editable,
          sat_raise_recursive = v.sat_raise_recursive
     when not matched then insert(
            sat_id, sat_name, sat_description, sat_pl_sql, sat_js, 
            sat_default_attribute_1, sat_check_attribute_1, sat_default_attribute_2, sat_check_attribute_2,
            sat_is_editable, sat_raise_recursive)
          values (
            v.sat_id, v.sat_name, v.sat_description, v.sat_pl_sql, v.sat_js, 
            v.sat_default_attribute_1, v.sat_check_attribute_1, v.sat_default_attribute_2, v.sat_check_attribute_2,
            v.sat_is_editable, v.sat_raise_recursive);
            
    pit.leave_mandatory;
  end merge_action_type;
  
  
  procedure delete_apex_action_type(
    p_row in sct_apex_action%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    delete from sct_apex_action
     where saa_sgr_id = p_row.saa_sgr_id
       and saa_name = p_row.saa_name;
       
    pit.leave_mandatory;
  end delete_apex_action_type;
  
    
  procedure merge_apex_action_type(
    p_row in out nocopy sct_apex_action%rowtype)
  as
  begin
    pit.enter_mandatory;
    
    merge into sct_apex_action t
    using (select p_row.saa_sgr_id saa_sgr_id,
                  p_row.saa_sty_id saa_sty_id,
                  p_row.saa_name saa_name,
                  p_row.saa_label saa_label,
                  p_row.saa_context_label saa_context_label,
                  p_row.saa_icon saa_icon,
                  p_row.saa_icon_type saa_icon_type,
                  p_row.saa_title saa_title,
                  p_row.saa_shortcut saa_shortcut,
                  p_row.saa_initially_disabled saa_initially_disabled,
                  p_row.saa_initially_hidden saa_initially_hidden,
                  p_row.saa_href saa_href,
                  p_row.saa_href_noop saa_href_noop,
                  p_row.saa_action saa_action,
                  p_row.saa_action_noop saa_action_noop,
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
       on (t.saa_sgr_id = s.saa_sgr_id
       and t.saa_name = s.saa_name)
     when matched then update set
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
            t.saa_href_noop = s.saa_href_noop,
            t.saa_action = s.saa_action,
            t.saa_action_noop = s.saa_action_noop,
            t.saa_on_label = s.saa_on_label,
            t.saa_off_label = s.saa_off_label,
            t.saa_get = s.saa_get,
            t.saa_set = s.saa_set,
            t.saa_choices = s.saa_choices,
            t.saa_label_classes = s.saa_label_classes,
            t.saa_label_start_classes = s.saa_label_start_classes,
            t.saa_label_end_classes = s.saa_label_end_classes,
            t.saa_item_wrap_class = s.saa_item_wrap_class
     when not matched then insert(
            t.saa_sgr_id, t.saa_sty_id, t.saa_name, t.saa_label, t.saa_context_label, t.saa_icon, t.saa_icon_type, t.saa_title, t.saa_shortcut, t.saa_initially_disabled, t.saa_initially_hidden, t.saa_href, t.saa_href_noop, t.saa_action, t.saa_action_noop, t.saa_on_label, t.saa_off_label, t.saa_get, t.saa_set, t.saa_choices, t.saa_label_classes, t.saa_label_start_classes, t.saa_label_end_classes, t.saa_item_wrap_class)
          values(
            s.saa_sgr_id, s.saa_sty_id, s.saa_name, s.saa_label, s.saa_context_label, s.saa_icon, s.saa_icon_type, s.saa_title, s.saa_shortcut, s.saa_initially_disabled, s.saa_initially_hidden, s.saa_href, s.saa_href_noop, s.saa_action, s.saa_action_noop, s.saa_on_label, s.saa_off_label, s.saa_get, s.saa_set, s.saa_choices, s.saa_label_classes, s.saa_label_start_classes, s.saa_label_end_classes, s.saa_item_wrap_class);
  
    pit.leave_mandatory;
  end merge_apex_action_type;
  
    
  procedure merge_apex_action_type(
    p_saa_sgr_id              in sct_apex_action.saa_sgr_id%type,
    p_saa_sty_id              in sct_apex_action.saa_sty_id%type,
    p_saa_name                in sct_apex_action.saa_name%type,
    p_saa_label               in sct_apex_action.saa_label%type,
    p_saa_context_label       in sct_apex_action.saa_context_label%type,
    p_saa_icon                in sct_apex_action.saa_icon%type,
    p_saa_icon_type           in sct_apex_action.saa_icon_type%type,
    p_saa_title               in sct_apex_action.saa_title%type,
    p_saa_shortcut            in sct_apex_action.saa_shortcut%type,
    p_saa_initially_disabled  in sct_apex_action.saa_initially_disabled%type,
    p_saa_initially_hidden    in sct_apex_action.saa_initially_hidden%type,
    p_saa_href                in sct_apex_action.saa_href%type,
    p_saa_href_noop           in sct_apex_action.saa_href_noop%type,
    p_saa_action              in sct_apex_action.saa_action%type,
    p_saa_action_noop         in sct_apex_action.saa_action_noop%type,
    p_saa_on_label            in sct_apex_action.saa_on_label%type,
    p_saa_off_label           in sct_apex_action.saa_off_label%type,
    p_saa_get                 in sct_apex_action.saa_get%type,
    p_saa_set                 in sct_apex_action.saa_set%type,
    p_saa_choices             in sct_apex_action.saa_choices%type,
    p_saa_label_classes       in sct_apex_action.saa_label_classes%type,
    p_saa_label_start_classes in sct_apex_action.saa_label_start_classes%type,
    p_saa_label_end_classes   in sct_apex_action.saa_label_end_classes%type,
    p_saa_item_wrap_class     in sct_apex_action.saa_item_wrap_class%type) 
  as
    l_row sct_apex_action%rowtype;
  begin
    l_row.saa_sgr_id := p_saa_sgr_id;
    l_row.saa_sty_id := p_saa_sty_id;
    l_row.saa_name := p_saa_name;
    l_row.saa_label := p_saa_label;
    l_row.saa_context_label := p_saa_context_label;
    l_row.saa_icon := p_saa_icon;
    l_row.saa_icon_type := p_saa_icon_type;
    l_row.saa_title := p_saa_title;
    l_row.saa_shortcut := p_saa_shortcut;
    l_row.saa_initially_disabled := p_saa_initially_disabled;
    l_row.saa_initially_hidden := p_saa_initially_hidden;
    l_row.saa_href := p_saa_href;
    l_row.saa_href_noop := p_saa_href_noop;
    l_row.saa_action := p_saa_action;
    l_row.saa_action_noop := p_saa_action_noop;
    l_row.saa_on_label := p_saa_on_label;
    l_row.saa_off_label := p_saa_off_label;
    l_row.saa_get := p_saa_get;
    l_row.saa_set := p_saa_set;
    l_row.saa_choices := p_saa_choices;
    l_row.saa_label_classes := p_saa_label_classes;
    l_row.saa_label_start_classes := p_saa_label_start_classes;
    l_row.saa_label_end_classes := p_saa_label_end_classes;
    l_row.saa_item_wrap_class := p_saa_item_wrap_class;
    
    merge_apex_action_type(l_row);
  end merge_apex_action_type;
  
begin
  initialize;
end sct_admin;
/
