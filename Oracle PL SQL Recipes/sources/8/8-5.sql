CREATE OR REPLACE PROCEDURE delete_employee(emp_value IN VARCHAR2) AS

  is_number      NUMBER := 0;
  valid_flag        BOOLEAN := FALSE;
  sql_stmt          VARCHAR2(1000);
  emp_count     NUMBER := 0;
BEGIN
  sql_stmt := 'DELETE FROM EMPLOYEES ';

  -- DETERMINE IF emp_value IS NUMERIC, IF SO THEN QUERY
  -- DATABASE TO FIND OCCURRENCES OF MATCHING EMPLOYEE_ID
  IF LENGTH(TRIM(TRANSLATE(emp_value, ' +-.0123456789', ' '))) IS NULL THEN
    SELECT COUNT(*)
    INTO emp_count
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = emp_value;

    IF emp_count > 0 THEN
      sql_stmt := sql_stmt || 'WHERE EMPLOYEE_ID = :emp_val';
      valid_flag := TRUE;
    END IF;
  ELSE
    SELECT COUNT(*)
    INTO emp_count
    FROM EMPLOYEES
    WHERE EMAIL = upper(emp_value);

    IF emp_count > 0 THEN
      sql_stmt := sql_stmt || 'WHERE EMAIL = :emp_val';
      valid_flag := TRUE;
    ELSE 
      valid_flag := FALSE;
    END IF;
  END IF;

  IF valid_flag = TRUE THEN

    EXECUTE IMMEDIATE sql_stmt
    USING emp_value;

    DBMS_OUTPUT.PUT_LINE('Employee has been deleted');
  ELSE
    DBMS_OUTPUT.PUT_LINE('No matching employee found, please try again');
  END IF;

END;
/