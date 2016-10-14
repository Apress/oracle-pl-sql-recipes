DECLARE
  CURSOR emp_cur IS
  SELECT *
  FROM employees 
  WHERE department_id = 90;
  emp_rec employees%ROWTYPE;
BEGIN
  OPEN emp_cur;
  LOOP
  FETCH emp_cur into emp_rec;
  IF emp_cur%FOUND THEN
    DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || emp_rec.last_name ||
        ' - ' || emp_rec.email);
  ELSE
    EXIT;
   END IF;
  END LOOP;
  CLOSE emp_cur;
END;
/