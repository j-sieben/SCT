@init.sql

alter session set current_schema=&INSTALL_USER.;


create or replace type char_table as table of varchar2(4000);
/
show errors

create or replace package utl_text
  authid definer
as
  function not_empty(
    p_text in varchar2)
    return boolean;
    
  function append(
    p_text in varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N')
    return varchar2;
  
  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N');
    
  function concatenate(
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true)
    return varchar2;
    
  procedure concatenate(
    p_text in out nocopy varchar2,
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true);
    
    
  procedure bulk_replace(
    p_text in out nocopy varchar2,
    p_chunks in char_table);
    
  function bulk_replace(
    p_text in varchar2,
    p_chunks in char_table)
    return varchar2;
    
  function string_to_table(
    p_string in varchar2,
    p_delimiter in varchar2 default ':')
    return char_table
    pipelined;
    
end utl_text;
/
show errors

create or replace package body utl_text
as

  function not_empty(
    p_text in varchar2)
    return boolean
  as
  begin
    return length(trim(p_text)) > 0;
  end not_empty;
  

  function append(
    p_text in varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N')
    return varchar2
  as
    l_result varchar2(32767);
  begin
    if not_empty(p_chunk) then
      if p_before = 'Y' then
        l_result := p_text || case when p_text is not null then p_delimiter end || p_chunk;
      else
        l_result := p_text || p_chunk || p_delimiter;
      end if;
    end if;
    return l_result;
  end append;
 
 
  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N')
  as
  begin
    p_text := append(p_text, p_chunk, p_delimiter, p_before);
  end append;
  
  
  function concatenate(
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true)
    return varchar2
  as
    l_result varchar2(32767);
  begin
    for i in p_chunks.first .. p_chunks.last loop
      if (not_empty(p_chunks(i)) and p_ignore_nulls) or (not(p_ignore_nulls)) then
        append(
          p_text => l_result, 
          p_chunk => p_chunks(i),
          p_delimiter => p_delimiter
        );
      end if;
    end loop;
    return trim(p_delimiter from l_result);
  end concatenate;
  
  
  procedure concatenate(
    p_text in out nocopy varchar2,
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true)
  as
  begin
    p_text := concatenate(p_chunks, p_delimiter, p_ignore_nulls);
  end concatenate;
  
  
  procedure bulk_replace(
    p_text in out nocopy varchar2,
    p_chunks in char_table)
  as
  begin
    for i in p_chunks.first .. p_chunks.last loop
      if mod(i, 2) = 1 then
        p_text := replace(p_text, p_chunks(i), p_chunks(i+1));
      end if;
    end loop;
  end bulk_replace;
  
  
  function bulk_replace(
    p_text in varchar2,
    p_chunks in char_table)
    return varchar2
  as
    l_result varchar2(32767);
  begin
    l_result := p_text;
    bulk_replace(l_result, p_chunks);
    return l_result;
  end bulk_replace;  
  
    
  function string_to_table(
    p_string in varchar2,
    p_delimiter in varchar2 default ':')
    return char_table
    pipelined
  as
    l_chunk varchar2(32767);
    l_delimiter varchar2(30);
  begin
    l_delimiter := '\' || p_delimiter;
    for i in 1 .. regexp_count(p_string, l_delimiter) + 1 loop
      l_chunk := regexp_substr(p_string, '[^' || l_delimiter || ']+', 1, i);
      pipe row (l_chunk);
    end loop;
    return;
  end string_to_table;

end utl_text;
/

show errors
