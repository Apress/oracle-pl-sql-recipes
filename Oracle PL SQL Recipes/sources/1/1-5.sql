DECLARE
  emp_count   NUMBER;
BEGIN
  SELECT count(*)
  INTO emp_count
  FROM employees
  WHERE department_id = &department_id;
END;
/