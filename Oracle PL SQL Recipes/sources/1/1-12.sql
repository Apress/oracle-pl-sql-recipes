DECLARE
  dept_name    departments.department_name%TYPE;
  dept_id      NUMBER(6) := &department_id;
BEGIN
  SELECT department_name
  INTO dept_name 
  FROM departments
  WHERE department_id = dept_id;
  DBMS_OUTPUT.PUT_LINE('The department with the given ID is: ' || dept_name);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No department for the given ID');
END;
/