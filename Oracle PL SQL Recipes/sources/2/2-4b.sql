DECLARE
   CURSOR emp_cur IS
   SELECT first_name, last_name, email
   FROM employees
   WHERE employee_id = 100;
    
   emp_rec     emp_cur%ROWTYPE;
BEGIN
  OPEN emp_cur;
  FETCH emp_cur INTO emp_rec;
  IF EMP_CUR%FOUND THEN
    CLOSE emp_cur;
    DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || emp_rec.last_name ||
                                           '''s email is ' || emp_rec.email);
  ELSE
    DBMS_OUTPUT.PUT_LINE('No employee matches the provided ID number');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee matches the last name provided');
END;
/