CREATE OR REPLACE PROCEDURE obtain_emp_detail(emp_email IN VARCHAR2) IS
  emp_qry 	VARCHAR2(500);
  emp_first	employees.first_name%TYPE;
  emp_last      employees.last_name%TYPE;
  email		employees.email%TYPE;

  valid_id_count	NUMBER := 0;
  valid_flag		BOOLEAN := TRUE;
  temp_emp_info		VARCHAR2(50);

  BEGIN
    emp_qry := 'SELECT FIRST_NAME, LAST_NAME, EMAIL FROM EMPLOYEES ';
    IF emp_email LIKE '%@%' THEN
      temp_emp_info := substr(emp_email,0,instr(emp_email,'@')-1);
      emp_qry := emp_qry || 'WHERE EMAIL = :emp_email';
    ELSIF emp_email NOT LIKE '%.mycompany.com' THEN
      RAISE_APPLICATION_ERROR(-20001, 'Not a valid email address from ' ||
                            'this company!');
    ELSE
      RAISE_APPLICATION_ERROR(-20002, 'Not a valid email address!');
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
  


END;
/
  