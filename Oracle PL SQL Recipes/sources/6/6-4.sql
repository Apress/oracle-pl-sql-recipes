CREATE OR REPLACE PROCEDURE obtain_emp_hire_date(emp_id IN NUMBER)
 AS
 emp_hire_date    employees.hire_date%TYPE;
 emp_first             employees.first_name%TYPE;
 emp_last       employees.last_name%TYPE;
BEGIN
  SELECT hire_date, first_name, last_name
  INTO emp_hire_date, emp_first, emp_last
  FROM employees
  WHERE employee_id = emp_id;

  DBMS_OUTPUT.PUT_LINE(emp_first || ' ' || emp_last ||
        ' was hired on: ' ||
        TO_CHAR(emp_hire_date, 'DAY MONTH DDTH YYYY'));
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee found for the given ID');
END;
/