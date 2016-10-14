<<dept_block>>
DECLARE
  dept_name    varchar2(30);
BEGIN
  SELECT department_name
  INTO dept_name
  FROM departments
  WHERE department_id = 230;
  DBMS_OUTPUT.PUT_LINE(dept_name);
END dept_block;
/