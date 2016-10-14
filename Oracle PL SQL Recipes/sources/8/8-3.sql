CREATE OR REPLACE PROCEDURE new_employee(first IN VARCHAR2(20),
					 last	IN VARCHAR2(25),
					 email	IN VARCHAR2(25),
					 phone  IN VARCHAR2(20),
					 hired  IN DATE,
					 job    IN VARCHAR2(10),
		                         dept	IN NUMBER(4) DEFAULT 0) AS
  v_sql		VARCHAR2(1000);
BEGIN
  IF dept is not 0 THEN
    v_sql := 'INSERT INTO EMPLOYEES ( ' ||
	     'employee_id, first_name, last_name, email, ' ||
	     'phone_number, hire_date, job_id, department_id ' ||
             'VALUES( ' ||
	     ':id, :first, :last, :email, :phone, :hired, ' ||
	     ':job_id, :dept';

    EXECUTE IMMEDIATE v_sql
    USING first, last, email, phone, hired, job, dept;

  ELSE
    v_sql := 'INSERT INTO EMPLOYEES ( ' ||
	     'employee_id, first_name, last_name, email, ' ||
	     'phone_number, hire_date, job_id ' ||
             'VALUES( ' ||
	     ':id, :first, :last, :email, :phone, :hired, ' ||
	     ':job_id';

    EXECUTE IMMEDIATE v_sql
    USING first, last, email, phone, hired, job;

  END IF;

  DBMS_OUTPUT.PUT_LINE('The employee has been successfully entered');
END;
/