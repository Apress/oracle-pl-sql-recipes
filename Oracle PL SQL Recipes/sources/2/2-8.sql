CREATE OR REPLACE PROCEDURE change_emp_dept(emp_id   IN  NUMBER,
                                            dept_id  IN  NUMBER) AS
  emp_row	employees%ROWTYPE;
  dept		departments.department_name%TYPE;
  rec_count    	number := 0;
BEGIN

  SELECT count(*)
  INTO rec_count
  FROM employees
  WHERE employee_id = emp_id;

  IF rec_count = 1 THEN
    SELECT *
    INTO emp_row
    FROM employees
    WHERE employee_id = emp_id;
    
    IF emp_row.department_id != dept_id THEN

        emp_row.department_id := dept_id;
    
        UPDATE employees SET ROW = emp_row
        WHERE employee_id = emp_id;
    
        SELECT department_name
        INTO dept
        from departments
        WHERE department_id = dept_id;
    
        DBMS_OUTPUT.PUT_LINE('The employee ' || emp_row.first_name || ' ' || 
                             emp_row.last_name  || ' is now in department: ' || dept);
    ELSE
        DBMS_OUTPUT.PUT_LINE('The employee is already in that department...no change');
    END IF;
  ELSIF rec_count > 1 THEN
    DBMS_OUTPUT.PUT_LINE('The employee ID you entered is not unique');
  ELSE
    DBMS_OUTPUT.PUT_LINE('No employee records match the given employee ID');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid employee or department ID, try again');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unsuccessful change, please check ID numbers and try again');
END;
/