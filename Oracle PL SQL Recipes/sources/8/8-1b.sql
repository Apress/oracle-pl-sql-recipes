CREATE OR REPLACE PROCEDURE obtain_emp_detail(emp_info IN VARCHAR2) IS
  emp_qry 	VARCHAR2(500);
  emp_first	employees.first_name%TYPE := NULL;
  emp_last      employees.last_name%TYPE := NULL;
  email		employees.email%TYPE := NULL;

  valid_id_count	NUMBER := 0;
  valid_flag		BOOLEAN := TRUE;
  temp_emp_info		VARCHAR2(50);

  cursor_name		INTEGER;
  row_ct		INTEGER;

BEGIN
  
  emp_qry := 'SELECT FIRST_NAME, LAST_NAME, EMAIL FROM EMPLOYEES ';
  IF emp_info LIKE '%@%' THEN
    temp_emp_info := substr(emp_info,0,instr(emp_info,'@')-1);
    emp_qry := emp_qry || 'WHERE EMAIL = :emp_info';
  ELSE
    SELECT COUNT(*)
    INTO valid_id_count
    FROM employees
    WHERE employee_id = emp_info;

    IF valid_id_count > 0 THEN
        temp_emp_info := emp_info;
        emp_qry := emp_qry || 'WHERE EMPLOYEE_ID = :emp_info';
    ELSE
        valid_flag := FALSE;
    END IF;
  END IF;

  IF valid_flag = TRUE THEN
    cursor_name := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(cursor_name, emp_qry, DBMS_SQL.NATIVE);
    DBMS_SQL.BIND_VARIABLE(cursor_name, ':emp_info', temp_emp_info);
    DBMS_SQL.DEFINE_COLUMN(cursor_name, 1, emp_first, 20);
    DBMS_SQL.DEFINE_COLUMN(cursor_name, 2, emp_last, 25);
    DBMS_SQL.DEFINE_COLUMN(cursor_name, 3, email, 25);
    row_ct := DBMS_SQL.EXECUTE(cursor_name);

    IF DBMS_SQL.FETCH_ROWS(cursor_name) > 0 THEN
      DBMS_SQL.COLUMN_VALUE (cursor_name, 1, emp_first);
      DBMS_SQL.COLUMN_VALUE (cursor_name, 2, emp_last);
      DBMS_SQL.COLUMN_VALUE (cursor_name, 3, email);
      DBMS_OUTPUT.PUT_LINE(emp_first || ' ' || emp_last || ' - ' || email);
     

    END IF;

    
  ELSE 
    DBMS_OUTPUT.PUT_LINE('THE INFORMATION YOU HAVE USED DOES ' ||
                         'NOT MATCH ANY EMPLOYEE RECORD');
  END IF;
  DBMS_SQL.CLOSE_CURSOR(cursor_name);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('THE INFORMATION YOU HAVE USED DOES ' ||
                         'NOT MATCH ANY EMPLOYEE RECORD');

END;
/
  