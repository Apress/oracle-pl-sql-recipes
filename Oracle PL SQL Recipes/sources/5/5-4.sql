CREATE OR REPLACE VIEW EMP_JOB_VIEW AS
  SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.LAST_NAME,
         EMP.EMAIL, JOB.JOB_TITLE,
         DEPT.DEPARTMENT_NAME
  FROM EMPLOYEES EMP,
       JOBS JOB,
       DEPARTMENTS DEPT
  WHERE JOB.JOB_ID = EMP.JOB_ID
  AND DEPT.DEPARTMENT_ID = EMP.DEPARTMENT_ID
  ORDER BY EMP.LAST_NAME;
       
CREATE OR REPLACE TRIGGER UPDATE_EMP_VIEW
INSTEAD OF UPDATE ON EMP_JOB_VIEW
REFERENCING NEW AS NEW
FOR EACH ROW
DECLARE
  emp_rec		employees%ROWTYPE;

  title			jobs.job_title%TYPE;
  dept_name 		departments.department_name%TYPE;
BEGIN

    SELECT *
    INTO emp_rec
    FROM employees
    WHERE employee_id = :new.employee_id;

    UPDATE jobs
    SET job_title = :new.job_title
    WHERE job_id = emp_rec.job_id;

    UPDATE departments
    SET department_name = :new.department_name
    WHERE department_id = emp_rec.department_id;
    
    UPDATE employees
    SET email = :new.email,
    first_name = :new.first_name,
    last_name = :new.last_name
    WHERE employee_id = :new.employee_id;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No matching record exists');

END;
/