create or replace view sct_ui_edit_sra as
select seq_id,
       N001 SRA_ID,
       N002 SRA_SGR_ID,
       N003 SRA_SRU_ID,
       C001 SRA_SPI_ID,
       C002 SRA_SAT_ID,
       C003 SRA_PARAM_1,
       C003 SRA_PARAM_LOV_1,
       C003 SRA_PARAM_AREA_1,
       C004 SRA_PARAM_2,
       C004 SRA_PARAM_LOV_2,
       C004 SRA_PARAM_AREA_2,
       C005 SRA_PARAM_3,
       C005 SRA_PARAM_LOV_3,
       C005 SRA_PARAM_AREA_3,
       C006 SRA_COMMENT,
       C007 SRA_ON_ERROR,
       C008 SRA_RAISE_RECURSIVE,
       N004 SRA_SORT_SEQ,
       C009 SRA_ACTIVE,
       C010 SRA_HAS_ERROR
  from apex_collections
 where collection_name = 'SCT_UI_EDIT_SRA';