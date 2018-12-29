create or replace view sct_param_lov_sequence as
select sequence_name d, sequence_name r, null sgr_id
  from user_sequences;