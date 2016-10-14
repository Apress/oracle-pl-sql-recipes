CREATE OR REPLACE TRIGGER job_salary_update
AFTER UPDATE
    ON jobs
FOR EACH ROW
DECLARE

  CURSOR emp_cur IS
  SELECT * FROM employees 
  WHERE job_id = :new.job_id
  AND salary < :new.min_salary FOR UPDATE;

  emp_rec  emp_cur%ROWTYPE;

BEGIN

    FOR emp_rec IN emp_cur LOOP
        UPDATE employees
        SET salary = :new.min_salary
        WHERE CURRENT OF emp_cur;
    END LOOP;

END;
/