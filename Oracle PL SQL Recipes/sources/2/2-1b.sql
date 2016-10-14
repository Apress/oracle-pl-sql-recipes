DECLARE

  CURSOR emp_cursor IS
  SELECT first_name, last_name, email
  FROM employees
  WHERE employee_id = &emp_id;

  first   	VARCHAR2(20);
  last  	VARCHAR2(25);
  email 	VARCHAR2(25);

BEGIN
  OPEN emp_cursor;
  FETCH emp_cursor INTO first, last, email;
  IF emp_cursor%NOTFOUND THEN
    RAISE NO_DATA_FOUND;
  ELSE
      -- Perform second fetch to see if more than one row is returned
    FETCH emp_cursor INTO first, last, email;
    IF emp_cursor%FOUND THEN
      RAISE TOO_MANY_ROWS;
    ELSE
      DBMS_OUTPUT.PUT_LINE(
     'Employee Information for ID: ' || first || ' ' || last || ' - ' || email);
    END IF;
  END IF;

  CLOSE emp_cursor;

     
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee matches the given ID');
 WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('More than one employee matches the given ID');
END;
/