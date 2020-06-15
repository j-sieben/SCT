create or replace package body ataf
is

  C_YES constant char(1 byte) := 'Y';
  C_NO constant char(1 byte) := 'N';
  
  cursor selenium_script_cur(
    p_test_case_id in number, 
    p_test_spec_id in number, 
    p_spec_case_id in number,
    p_domain in varchar2, 
    p_selenium_version in number,
    p_test_name in ataf_project.project_name%type default null, 
    p_test_case in ataf_test_case.test_case%type default null)
    is
      with params as (
           select p_test_case_id case_id, 
                  p_test_spec_id test_spec_id, 
                  p_spec_case_id spec_case_id, 
                  p_domain domain, 
                  p_selenium_version selenium_version,
                  p_test_name test_name,
                  p_test_case test_case
             from dual), 
         complete_specification as (
          -- Called from Test
           select sc.test_case_id, 
                  sc.sort_order, 
                  case sc.data_id when 0 then ad.data_id else sc.data_id end data_id, 
                  ad.data_group_id data_group_id, 
                  sc.data_group_id spec_group_id
             from ataf_spec_case sc
             join ataf_test_case tc 
               on sc.test_case_id = tc.test_case_id
             left join ataf_data ad 
               on tc.test_data_id = ad.test_data_id
              and (sc.data_group_id = ad.data_group_id
               or sc.data_group_id is null)
              and (sc.data_id = ad.data_id 
               or sc.data_id = 0)
             join params p
               on sc.test_spec_id = p.test_spec_id
            where sc.test_case_id = sc.test_case_id
              and p.spec_case_id is null 
              and p.case_id is null
           -- Called from Test Specification
           union all
           select sc.test_case_id, 
                  sc.sort_order, 
                  case sc.data_id when 0 then ad.data_id else sc.data_id end data_id, 
                  ad.data_group_id data_group_id, 
                  sc.data_group_id spec_group_id
             from ataf_spec_case sc
             join ataf_test_case tc 
               on sc.test_case_id = tc.test_case_id
             join params p
               on sc.spec_case_id = p.spec_case_id
             left join ataf_data ad 
               on tc.test_data_id = ad.test_data_id
              and (sc.data_group_id = ad.data_group_id 
               or sc.data_group_id is null)
              and (sc.data_id = ad.data_id 
               or sc.data_id = 0)
           -- Called from Test Case
           union all
           select cas.test_case_id, 
                  0 sort_order, 
                  null data_id, 
                  null, 
                  dat.default_data_group_id data_group_id
             from ataf_test_case cas
             join params p
               on cas.test_case_id = p.case_id
             left join ataf_test_data dat 
               on cas.test_data_id = dat.test_data_id
            where p.test_spec_id is null
         ),
         templates as(
           select uttm_text template, uttm_name, uttm_mode
             from utl_text_templates
            where uttm_type = 'ATAF'
              and uttm_name IN ('SELENIUM_TARGET', 'SELENIUM_VALUE'))
  select -- Data Groups --
         spec.spec_group_id spec_group_id, 
         spec.data_group_id case_group_id, 
         tcv.data_group_id cond_group_id, 
         tdv.data_group_id data_group_id, 
         tcv.test_case, 
         -- Command --
         sel.selenium_command 
         || case when tcv.and_wait = C_YES and sel.selenium_command in ('click', 'clickAt', 'type', 'select') then 'AndWait' end command, 
         sel.item_attribute, 
         -- Target
         to_char(utl_text.generate_text(cursor(
           select template, 
                  --Selenium paramters
                  sel.item_attribute, sel.location, tcv.dom_id, sel.target, 
                  -- Test Condition parameters
                  tcv.id, tcv.dom_id, tcv.name, tcv.label, coalesce(tcv.data_item_value, tdv.data_item_value) data_item_value, 
                  tcv.page_title, tcv.page_title, tcv.element_type, tcv.application_id, tcv.page_id, tcv.row_number, tcv.region_id, 
                  tcv.region_name, tcv.outcome_page_id, tcv.outcome_page_title, p.domain
             from templates
            where uttm_name = 'SELENIUM_TARGET'
              and uttm_mode = case when sel.item_attribute in ('DOM ID', 'Name', 'Label', 'Data') then sel.item_attribute else 'Default' end
         ))) target, 
         -- Value
         to_char(utl_text.generate_text(cursor(
           select template, tcv.name, coalesce(tcv.data_item_value, tdv.data_item_value) data_item_value, tcv.label, to_char(p.test_spec_id) test_spec_id
             from templates
            where uttm_name = 'SELENIUM_VALUE'
              and uttm_mode = sel.data_yn
         ))) value
    from ataf_test_condition_full_v tcv
   cross join params p
    join ataf_selenium sel 
      on tcv.action_id = sel.action_id
     and tcv.theme_number = sel.theme_number
     and sel.selenium_version = p.selenium_version
    join complete_specification spec
      on tcv.test_case_id = spec.test_case_id
      -- If the test case (tcv.data_group_id) has no group then do nothing
      -- else match to spec group first then data group
     and coalesce(tcv.data_group_id, -1) = nvl2(tcv.data_group_id, coalesce(spec.spec_group_id, spec.data_group_id, 0), -1)
    left join ataf_full_test_data_v tdv 
      on tcv.test_data_id = tdv.test_data_id
     and tcv.data_attribute = tdv.attribute
     and decode(tdv.data_id, spec.data_id, 1, 0) = 1
   order by spec.sort_order, spec.data_id, tcv.con_sort_order, sel.sort_order;
   
  
  function compress_int(
    p_n in integer)
    return varchar2
  is
    l_result varchar2(30 byte);
    l_quotient integer;
    l_remainder integer;
    l_digit char(1 byte);
  begin
    l_result := '';
    l_quotient := p_n;
    while l_quotient > 0 loop
      l_remainder := mod(l_quotient, 10 + 26);
      l_quotient := floor(l_quotient   / (10 + 26));
      if l_remainder < 26 then
        l_digit := chr(ascii('A') + l_remainder);
      else
        l_digit := chr(ascii('0') + l_remainder - 26);
      end if;
      l_result := l_digit || l_result;
    end loop ;
    
    l_result := lpad(l_result, 4, 'A');
    
    return l_result;
  end compress_int;
  
  
  function get_test_case_id(
    p_test_spec_id in number, 
    p_spec_case_id in number)
    return ataf_test_case.test_case_id%type
  as
    l_test_case_id ataf_test_case.test_case_id%type;
  begin
    if p_test_spec_id is not null then
      select tc.test_case_id
        into l_test_case_id
        from ataf_test_case tc
        join ataf_spec_case sc on tc.test_case_id = sc.test_case_id
        join ataf_test_spec ts on sc.test_spec_id = ts.test_spec_id
       where ts.test_spec_id = p_test_spec_id;
    else
      select tc.test_case_id
        into l_test_case_id
        from ataf_test_case tc
        join ataf_spec_case sc on tc.test_case_id = sc.test_case_id
       where sc.spec_case_id = p_spec_case_id;
    end if;
    return l_test_case_id;
  end get_test_case_id;
  
  
  procedure get_test_details(
    p_test_case_id in ataf_test_case.test_case_id%type,
    p_test_name out ataf_test_case.test_case%type,
    p_application_id out number,
    p_theme_number out number)
  as
  begin
    select tc.test_case, p.application_id, aat.theme_number
      into p_test_name, p_application_id, p_theme_number
      from ataf_test_case tc
      join ataf_project p on tc.project_id = p.project_id
      join apex_application_themes aat on p.application_id = aat.application_id
     where tc.test_case_id = p_test_case_id
       and aat.is_current = 'Yes'
       and aat.ui_type_name = 'DESKTOP';
  end get_test_details;
  
  
  procedure print_test(
    p_test_case_id in ataf_test_case.test_case_id%type,
    p_test_spec_id in ataf_test_spec.test_spec_id%type,
    p_spec_case_id in ataf_spec_case.spec_case_id%type, 
    p_domain in varchar2, 
    p_display in varchar2, 
    p_ws_name out apex_application_global.vc_arr2, 
    p_ws_value out apex_application_global.vc_arr2, 
    p_selenium_version in number)
  as
    l_test_case_id ataf_test_case.test_case_id%type;
    l_test_name ataf_project.project_name%type;
    l_test_case_old ataf_test_case.test_case%type;
    l_application_id number;
    l_theme_number number;
  begin
    l_test_case_id := coalesce(p_test_case_id, get_test_case_id(p_test_spec_id, p_spec_case_id));
    
    get_test_details(
      p_test_case_id => l_test_case_id, 
      p_test_name => l_test_name,
      p_application_id => l_application_id,
      p_theme_number => l_theme_number);
  
    for i in selenium_script_cur(
               p_test_case_id => p_test_case_id, 
               p_test_spec_id => p_test_spec_id, 
               p_spec_case_id => p_spec_case_id,
               p_domain => p_domain, 
               p_selenium_version => p_selenium_version,
               p_test_name => l_test_name, 
               p_test_case => l_test_case_id) 
    loop
      -- Add comment to the start of a new Test Case
      if l_test_case_old is null or l_test_case_old != i.test_case then
        htp.p('<!--Test Case: ' || apex_escape.html(i.test_case) || '-->');
      end if;
      -- Group Logic that ensures cond gp = data g
      if i.case_group_id + i.cond_group_id is null
         or (coalesce(i.case_group_id, 0) = coalesce(i.cond_group_id, 0)) then
          htp.p('<tr>');
          htp.p('<td>'||apex_escape.html(i.command)||'</td>');
          htp.p('<td>'||apex_escape.html(i.target)||'</td>');
          htp.p('<td>'||apex_escape.html(i.value)||'</td>');
          htp.p('</tr>');
      end if;
    end loop;
    htp.p('</tbody></table>');
  end print_test;
  

  procedure test(
    p_test_case_id in ataf_test_case.test_case_id%type,
    p_test_spec_id in ataf_test_spec.test_spec_id%type,
    p_spec_case_id in ataf_spec_case.spec_case_id%type, 
    p_domain in varchar2, 
    p_display in varchar2, 
    p_ws_name out apex_application_global.vc_arr2, 
    p_ws_value out apex_application_global.vc_arr2, 
    p_selenium_version in number)
  is
    l_test_case_id ataf_test_case.test_case_id%type;
    l_test_name ataf_project.project_name%type;
    l_test_case_old ataf_test_case.test_case%type;
    l_application_id number;
    l_theme_number number;
    l_test_serial number := 0;
    x number := 0;
  begin
  
    for i in selenium_script_cur(
               p_test_spec_id => p_test_spec_id, 
               p_test_case_id => p_test_case_id, 
               p_spec_case_id => p_spec_case_id,
               p_domain => p_domain, 
               p_selenium_version => p_selenium_version) 
    loop
      -- Group Logic that ensure cond gp = data g
      if i.case_group_id + i.cond_group_id is null
         or (coalesce(i.case_group_id, 0) = coalesce(i.cond_group_id, 0)) then
        --   set web service values
        l_test_serial := l_test_serial + 1;
  
        p_ws_name(x+1)  := 'steps[][cmd]';
        p_ws_name(x+2)  := 'steps[][locator]';
        p_ws_name(x+3)  := 'steps[][value]';
        p_ws_name(x+4)  := 'steps[][order]';
        p_ws_value(x+1) := i.command;
        p_ws_value(x+2) := i.target;
        p_ws_value(x+3) := i.value;
        p_ws_value(x+4) := l_test_serial;
  
        x:=x+4;
      end if;
      l_test_case_old := i.test_case;
    end loop;
  end test;
  
  
  function return_cols 
    return varchar2
  is
    l_columns varchar2(4000);
  begin
    select '::Group:Row Name:'||listagg(data_item_name, ':') within group (order by data_attribute)
      into l_columns
      from ataf_data_item
     where test_data_id = (select nv('TEST_DATA_ID') from dual);
    return l_columns;
  exception when NO_DATA_FOUND then
    return null;
  end return_cols;
  
  
  function random_data (
    p_attribute in number,
    p_test_data_id in number)
    return varchar
  is
    lv_val ataf_data.attribute_1%type;
  begin
    select decode(p_attribute,
             0, attribute_1,
             1, attribute_2,
             2, attribute_3,
             3, attribute_4,
             4, attribute_5,
             5, attribute_6,
             6, attribute_7,
             7, attribute_8,
             8, attribute_9,
             9, attribute_10,
             10, attribute_11,
             11, attribute_12,
             12, attribute_13,
             13, attribute_14,
             14, attribute_15,
             15, attribute_16,
             16, attribute_17,
             17, attribute_18,
             18, attribute_19,
             19, attribute_20) val
      into lv_val
      from ataf_data
     where test_data_id = p_test_data_id
     order by dbms_random.value
     fetch first 1 row only;
    return lv_val;
  end random_data;
  
end ataf;
/