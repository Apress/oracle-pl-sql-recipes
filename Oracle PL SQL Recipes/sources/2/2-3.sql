DECLARE
  CURSOR emp_cur IS
  SELECT *
  FROM employees 
  WHERE employee_id = &emp_id;
  -- Declaring a local variable using the ROWTYPE attribute
  -- of the employees table
  emp_rec    employees%ROWTYPE;
BEGIN
  OPEN emp_cur;
  FETCH emp_cur INTO emp_rec;
  IF emp_cur%FOUND THEN
 
    DBMS_OUTPUT.PUT_LINE('Employee Information for ID: ' || emp_rec.first_name || '   ' ||
                 emp_rec.last_name || ' - ' || emp_rec.email);
  ELSE
    DBMS_OUTPUT.PUT_LINE('No matching employee for the given ID');
  END IF;
  CLOSE emp_cur;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee matches the given emp ID');
END;
/