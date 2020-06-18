create or replace package body utl_sct 
as

  procedure handle_bulk_errors(
    p_mapping in char_table default null) 
  as
    type error_code_map_t is table of utl_apex.ora_name_type index by utl_apex.ora_name_type;
    l_error_code_map error_code_map_t;
    l_message_list pit_message_table;
    l_message message_type;
    l_item utl_apex.item_rec;
  begin
    pit.enter_optional;
    l_message_list := pit.get_message_collection;
    
    if l_message_list.count > 0 then
      -- copy p_mapping to pl/sql table to allow for easy access using EXISTS method
      if p_mapping is not null then
        for i in 1 .. p_mapping.count loop
          if mod(i, 2) = 1 then
            l_error_code_map(p_mapping(i)) := p_mapping(i+1);
          end if;
        end loop;
      end if;
      
      for i in 1 .. l_message_list.count loop
        l_message := l_message_list(i);
        if l_message.severity in (pit.level_fatal, pit.level_error) then
          if l_error_code_map.exists(l_message.error_code) then
            utl_apex.get_page_element(l_error_code_map(l_message.error_code), l_item);
          end if;
          sct.register_error(
            p_spi_id => coalesce(l_item.item_name, sct_util.C_NO_FIRING_ITEM),
            p_error_msg => replace(l_message.message_text, '#LABEL#', l_item.item_label),
            p_internal_error => l_message.message_description);
        end if;
      end loop;
    end if;
    
    pit.leave_optional;
  end handle_bulk_errors;

end utl_sct;
/