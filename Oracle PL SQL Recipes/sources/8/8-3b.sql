CREATE OR REPLACE PROCEDURE new_employee(first IN VARCHAR2,
					 last	IN VARCHAR2,
					 email	IN VARCHAR2,
					 phone  IN VARCHAR2,
					 hired  IN DATE,
					 job    IN VARCHAR2,
		                         dept	IN NUMBER DEFAULT 0) AS
  v_sql		VARCHAR2(1000);

  cursor_var	NUMBER := DBMS_SQL.OPEN_CURSOR;
  rows_compelete NUMBER := 0;
  next_emp        NUMBER := employee_seq.nextval;
BEGIN
  

  IF dept != 0 THEN
    v_sql := 'INSERT INTO EMPLOYEES ( ' ||
	     'employee_id, first_name, last_name, email, ' ||
	     'phone_number, hire_date, job_id, department_id) ' ||
             'VALUES( ' ||
	     ':id, :first, :last, :email, :phone, :hired, ' ||
	     ':job_id, :dept)';

    
  ELSE
    v_sql := 'INSERT INTO EMPLOYEES ( ' ||
	     'employee_id, first_name, last_name, email, ' ||
	     'phone_number, hire_date, job_id) ' ||
             'VALUES( ' ||
	     ':id, :first, :last, :email, :phone, :hired, ' ||
	     ':job_id)';



  END IF;
  DBMS_SQL.PARSE(cursor_var, v_sql, DBMS_SQL.NATIVE);
  DBMS_SQL.BIND_VARIABLE(cursor_var, 1, ':id', next_emp);
  DBMS_SQL.BIND_VARIABLE(cursor_var, 2, ':first', first);
  DBMS_SQL.BIND_VARIABLE(cursor_var, 3, ':last', last);
  DBMS_SQL.BIND_VARIABLE(cursor_var, 4, ':email', email);
  DBMS_SQL.BIND_VARIABLE(cursor_var, 5, ':phone', phone);
  DBMS_SQL.BIND_VARIABLE(cursor_var, 6, ':hired');
  DBMS_SQL.BIND_VARIABLE(cursor_var, 7, ':job', job);
  IF dept != 0 then
    DBMS_SQL.BIND_VARIABLE(cursor_var, 8, ':dept', dept);
  END IF;
  rows_complete := DBMS_SQL.EXECUTE(cursor_var);
  DBMS_SQL.CLOSE_CURSOR(cursor_var);
  DBMS_OUTPUT.PUT_LINE('The employee has been successfully entered');
END;
/
  