create or replace force view ui_sct_lov_page_items as
select runid, run_timestamp, owner, type, method, is_valid, link_target, has_details
  from (select r.runid, r.run_timestamp, i.type, i.owner, 
               coalesce(c.method, i.module || '.' || i.function) method,
               case when r.run_comment like 'ORA-%' then '<i class="fa fa-times"/>' else '<i class="fa fa-check"/>' end is_valid,
               case when r.run_comment like 'ORA-%' then 'RUN_ERROR' else 'ANALYSIS' end link_target,
               case when a.runid is not null then '<i class="fa fa-check"/>' else '<i class="fa fa-times"/>' end has_details,
               row_number() over (partition by r.runid order by i.symbolid) rang
          from dbmshp_runs r
          left join (
               select *
                 from dbmshp_function_info
                where owner is not null) i 
            on r.runid = i.runid
          left join dbmshp_all_functions a
            on i.runid = a.runid
          left join dbmshp_run_code c
            on r.runid = c.runid)
 where rang = 1;
