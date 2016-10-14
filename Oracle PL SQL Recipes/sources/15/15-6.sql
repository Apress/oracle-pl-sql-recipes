CREATE OR REPLACE PROCEDURE employee_reports AS
  CURSOR emp_cur IS
  SELECT first_name, last_name, email
  FROM employees
  WHERE department_id = 50;

  emp_rec    emp_cur%ROWTYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Employees from Shipping Department');
  DBMS_OUTPUT.PUT_LINE('----------------------------------');
  FOR emp_rec IN emp_cur LOOP
    DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || 
                         emp_rec.last_name || ' ' ||
                         emp_rec.email);
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('==========================================');
  DBMS_OUTPUT.PUT_LINE('Employees from IT Department');
  DBMS_OUTPUT.PUT_LINE('----------------------------');
  get_it_emps;
END;
/