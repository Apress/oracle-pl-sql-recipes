CREATE OR REPLACE PROCEDURE log_error_messages(error_code  IN NUMBER,
                                                message    IN VARCHAR2) AS
BEGIN
  -- WRITE ERROR MESSAGE HERE
  DBMS_OUTPUT.PUT_LINE(message);
  DBMS_OUTPUT.PUT_LINE('WRITING ERROR MESSAGE TO DATABASE');
END;


CREATE OR REPLACE PROCEDURE obtain_emp_detail(emp_info IN VARCHAR2) IS
  emp_qry 	VARCHAR2(500);
  emp_first	employees.first_name%TYPE;
  emp_last      employees.last_name%TYPE;
  email		employees.email%TYPE;

  valid_id_count	NUMBER := 0;
  valid_flag		BOOLEAN := TRUE;
  temp_emp_info		VARCHAR2(50);


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
          emp_qry := emp_qry || 'WHERE EMPLOYEE_ID = :id';
      ELSE
          valid_flag := FALSE;
      END IF;
    END IF;
  
    IF valid_flag = TRUE THEN
      EXECUTE IMMEDIATE emp_qry
      INTO emp_first, emp_last, email
      USING temp_emp_info;
  
      DBMS_OUTPUT.PUT_LINE(emp_first || ' ' || emp_last || ' - ' || email);
    ELSE 
      DBMS_OUTPUT.PUT_LINE('THE INFORMATION YOU HAVE USED DOES ' ||
                           'NOT MATCH ANY EMPLOYEE RECORD');
    END IF;
  
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        
        DBMS_OUTPUT.PUT_LINE('THE INFORMATION YOU HAVE USED DOES ' ||
                           'NOT MATCH ANY EMPLOYEE RECORD');
        log_error_messages(SQLCODE, DBMS_UTILITY.FORMAT_ERROR_STACK);
        
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('AN UNEXPECTED ERROR HAS OCCURRED, PLEASE ' ||
                           'TRY AGAIN');
        log_error_messages(SQLCODE, DBMS_UTILITY.FORMAT_ERROR_STACK);


 END;
/
  