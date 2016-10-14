DECLARE
  emp_count    NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO emp_count   -- Local variable
  FROM EMPLOYEES;
END;
/