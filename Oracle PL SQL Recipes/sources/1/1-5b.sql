DECLARE
  emp_count   NUMBER;
BEGIN
  SELECT count(*)
  INTO emp_count
  FROM employees
  WHERE department_id = &&department_id;
  
  DBMS_OUTPUT.PUT_LINE('The employee count is: ' || emp_count ||
        ' for the department with an ID of: ' || &department_id);
END;
/