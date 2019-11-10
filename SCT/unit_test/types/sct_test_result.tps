create or replace type sct_test_result 
  authid definer
as object(
  rule_list sct_test_list,
  constructor function sct_test_result(
    self in out nocopy sct_test_result)
    return self as result,
  constructor function sct_test_result(
    self in out nocopy sct_test_result,
    p_rule_list in sct_test_list)
    return self as result
);
/
