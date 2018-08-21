create or replace force view SCT_UI_EDIT_RULE_ACTION as
select SRA_SGR_ID,
       SRA_SRU_ID,
       SRA_SPI_ID,
       SRA_SAT_ID,
       SRA_SORT_SEQ,
       SRA_ATTRIBUTE,
       SRA_ATTRIBUTE_2,
       SRA_COMMENT,
       SRA_ON_ERROR,
       SRA_RAISE_RECURSIVE,
       SRA_ACTIVE,
       SRA_HAS_ERROR
  from sct_rule_action;