DECLARE
  first                  employees.first_name%TYPE;
  last                   employees.last_name%TYPE;
  email                  employees.email%TYPE;
BEGIN
  SELECT first_name, last_name, email
  INTO first, last, email
  FROM employees
  WHERE employee_id = &emp_id;
  DBMS_OUTPUT.PUT_LINE('Employee Information for ID: ' ||
 first || '   ' || last || ' - ' || email);
EXCEPTION 
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No matching employee was found, please try again.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unknown error has occured, please try again.');
END;
/