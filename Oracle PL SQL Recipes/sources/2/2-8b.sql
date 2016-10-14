DECLARE
  first		employees.first_name%TYPE;
  last		employees.last_name%TYPE;
  new_salary	employees.salary%TYPE;
BEGIN

  UPDATE employees 
  SET salary = salary + (salary * .03)
  WHERE employee_id = 100
  RETURNING first_name, last_name,salary INTO first, last, new_salary;

  DBMS_OUTPUT.PUT_LINE('The employee ' || first || ' ' || last  || ' now has a salary of: ' || new_salary);
END;
/