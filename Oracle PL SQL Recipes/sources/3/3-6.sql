DECLARE
  CURSOR emp_cur IS
  SELECT *
  FROM employees 
  WHERE job_id = 'ST_MAN';
  emp_rec employees%ROWTYPE;
BEGIN
  FOR emp_rec IN emp_cur LOOP
    DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || emp_rec.last_name ||
        ' - ' || emp_rec.email);
  END LOOP;
END;
/