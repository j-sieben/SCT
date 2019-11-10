create or replace type body sct_test_result 
as

  constructor function sct_test_result(
    self in out nocopy sct_test_result)
    return self as result as
  begin
    self.rule_list := sct_test_list();
    return;
  end sct_test_result;

  constructor function sct_test_result(
    self in out nocopy sct_test_result,
    p_rule_list in sct_test_list)
    return self as result as
  begin
    self.rule_list := p_rule_list;
    return;
  end sct_test_result;

end;
/
