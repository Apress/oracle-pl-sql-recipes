DECLARE
  TYPE emp_info IS RECORD(first    employees.first_name%TYPE,
                          last     employees.last_name%TYPE,
                          email   employees.email%TYPE);

  emp_info_rec  emp_info;
BEGIN
  SELECT first_name, last_name, email
  INTO emp_info_rec
  FROM  employees
  WHERE last_name = 'Vargas';

  DBMS_OUTPUT.PUT_LINE('The queried employee''s email address is ' || emp_info_rec.email);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee matches the last name provided');

END;
/