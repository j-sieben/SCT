create or replace package  ataf
as

  /** Method to generate compressed version of an integer value
   */
  function compress_int(
    p_n in integer)
    return varchar2;
    
  /** Method to print selenium scripts as HTML to the active page
   */
  procedure print_test(
    p_test_case_id in ataf_test_case.test_case_id%type,
    p_test_spec_id in ataf_test_spec.test_spec_id%type,
    p_spec_case_id in ataf_spec_case.spec_case_id%type, 
    p_domain in varchar2, 
    p_display in varchar2, 
    p_ws_name out apex_application_global.vc_arr2, 
    p_ws_value out apex_application_global.vc_arr2, 
    p_selenium_version in number);


  /** Method that generates the selenium scripts. 
   */
  procedure test(
    p_test_case_id in ataf_test_case.test_case_id%type,
    p_test_spec_id in ataf_test_spec.test_spec_id%type,
    p_spec_case_id in ataf_spec_case.spec_case_id%type,
    p_domain in varchar2,
    p_display in varchar2,
    p_ws_name out apex_application_global.vc_arr2,
    p_ws_value out apex_application_global.vc_arr2,
    p_selenium_version in number);


  /** Method returns test data columns
   */
  function return_cols 
    return varchar2;


  /** Method returns a random data item for a specified attribute number
   */
  function random_data(
      p_attribute in number,
      p_test_data_id in number)
      return varchar;

end ataf;
/