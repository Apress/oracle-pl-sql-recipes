CREATE DATABASE LINK hr_data
CONNECT TO hr
IDENTIFIED BY hr_password
USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=node_name)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=hr_service_name)))';

CREATE OR REPLACE PROCEDURE sync_hr_data AS

CURSOR	driver IS
SELECT	*
FROM	employees@hr_data;

TYPE	recs_type IS TABLE OF driver%ROWTYPE INDEX BY BINARY_INTEGER;
recs	recs_type;

BEGIN

   OPEN DRIVER;
   FETCH DRIVER BULK COLLECT INTO recs;
   CLOSE DRIVER;

   FOR i IN 1..recs.COUNT LOOP
      UPDATE employees
      SET	first_name		= recs(i).first_name,
		last_name		= recs(i).last_name,
		email			= recs(i).email,
		phone_number		= recs(i).phone_number,
		hire_date		= recs(i).hire_date,
		job_id			= recs(i).job_id,
		salary			= recs(i).salary,
		commission_pct		= recs(i).commission_pct,
		manager_id		= recs(i).manager_id,
		department_id		= recs(i).department_id
      WHERE	employee_id		= recs(i).employee_id
      AND   (	NVL(first_name,'~')	<> NVL(recs(i).first_name,'~')
	   OR	last_name		<> recs(i).last_name
	   OR	email			<> recs(i).email
	   OR	NVL(phone_number,'~')	<> NVL(recs(i).phone_number,'~')
	   OR	hire_date		<> recs(i).hire_date
	   OR	job_id			<> recs(i).job_id
	   OR	NVL(salary,-1)		<> NVL(recs(i).salary,-1)
	   OR	NVL(commission_pct,-1)	<> NVL(recs(i).commission_pct,-1)
	   OR	NVL(manager_id,-1)	<> NVL(recs(i).manager_id,-1)
	   OR	NVL(department_id,-1)	<> NVL(recs(i).department_id,-1)
	    );

   END LOOP;

-- find all new rows in the HR database since the last refresh
   INSERT INTO employees
   SELECT *
   FROM   employees@hr_data
   WHERE  employee_id NOT IN (
	SELECT	employee_id
	FROM	employees);

END sync_hr_data;
/

EXEC DBMS_SCHEDULER.CREATE_JOB (	-
	JOB_NAME=>'sync_HR_employees',	-
	JOB_TYPE=>'STORED_PROCEDURE',	-
	JOB_ACTION=>'sync_hr_data',	-
	ENABLED=>TRUE,			-
	REPEAT_INTERVAL=>'FREQ=DAILY;INTERVAL=1;BYHOUR=00;BYMINUTE=30');