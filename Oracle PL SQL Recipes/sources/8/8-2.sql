DECLARE
  emp_qry 	VARCHAR2(500);
  TYPE		cur_type IS REF CURSOR;
  cur		cur_type;
  emp_first	employees.first_name%TYPE;
  emp_last      employees.last_name%TYPE;
  email		employees.email%TYPE;

  dept_id	employees.department_id%TYPE := &department_id;

BEGIN
  -- DEPARTMENT_ID WILL NOT UNIQUELY DEFINE ANY ONE EMPLOYEE

  emp_qry := 'SELECT FIRST_NAME, LAST_NAME, EMAIL FROM EMPLOYEES ' ||
             ' WHERE DEPARTMENT_ID = :id';

  OPEN cur FOR emp_qry USING dept_id;
  LOOP
    FETCH cur INTO emp_first, emp_last, email;
    DBMS_OUTPUT.PUT_LINE(emp_first || ' ' || emp_last || ' - ' || email);
    EXIT WHEN cur%NOTFOUND;
  END LOOP;
  CLOSE cur;

END;
/
  