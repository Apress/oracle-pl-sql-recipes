DECLARE
    first   varchar2(20);
    last    varchar2(25);
    emp_last VARCHAR2(25) := '&last_name';
    emp_count NUMBER;
BEGIN
  SELECT count(*)
  INTO emp_count
  FROM employees
  WHERE last_name = emp_last;
  
  IF emp_count > 1 THEN
    DBMS_OUTPUT.PUT_LINE('More than 1 employee exists with that name.');
  ELSE
    SELECT first_name, last_name
    INTO first, last
    FROM employees
    WHERE last_name = emp_last;
    
    DBMS_OUTPUT.PUT_LINE('The matching employee is: ' ||
           first || ' ' || last);
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Please enter a different last name.');
END;
/
