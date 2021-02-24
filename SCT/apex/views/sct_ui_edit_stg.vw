create or replace editionable view sct_ui_edit_stg
as 
select stg_id, stg_name, stg_description, stg_active,
       case
         (select count(*)
            from dual
           where exists (
                 select null
                   from sct_action_type
                  where sat_stg_id = stg_id))
         when 1 then 'U'
         else 'UD'
       end allowed_operations
  from sct_action_type_group_v;
