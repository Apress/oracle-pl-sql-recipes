DECLARE
  CURSOR emp_cur IS
  SELECT employee_id, first_name, last_name
  FROM EMPLOYEES
  WHERE HIRE_DATE > TO_DATE('01/01/2000','MM/DD/YYYY');
  
  emp_rec	emp_cur%ROWTYPE;
  emp_string	VARCHAR2(150);
BEGIN
  DBMS_OUTPUT.PUT_LINE('EMPLOYEES HIRED AFTER 01/01/2000');
  DBMS_OUTPUT.PUT_LINE('================================');
  FOR emp_rec IN emp_cur LOOP
        emp_string := emp_rec.first_name || ' ' ||
                      emp_rec.last_name || ' - ' ||
                      'ID #: ' || emp_rec.employee_id;

        DBMS_OUTPUT.PUT_LINE(emp_string);
  END LOOP;
END;
/