DECLARE
  first   	VARCHAR2(20);
  last  	VARCHAR2(25);
  email 	VARCHAR2(25);
BEGIN
  SELECT first_name, last_name, email
  INTO first, last, email
  FROM employees
  WHERE employee_id = 100;

  DBMS_OUTPUT.PUT_LINE(
     'Employee Information for ID: ' || first || ' ' || last || ' - ' || email);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee matches the given ID');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('More than one employee matches the given ID');
END;
/