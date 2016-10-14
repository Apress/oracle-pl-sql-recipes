DECLARE
  CURSOR dept_removal_cur IS
  SELECT *
  FROM employees
  WHERE department_id = 10
  FOR UPDATE;

  dept_removal_rec		dept_removal_cur%ROWTYPE;

BEGIN
   -- Delete all employees from the database who reside in department 10
  FOR dept_removal_rec IN dept_removal_cur LOOP
       DBMS_OUTPUT.PUT_LINE('DELETING RECORD NOW');
    DELETE FROM employees
    WHERE CURRENT OF dept_removal_cur;

    -- Log the termination
    log_job_history(dept_removal_rec.employee_id,
		dept_removal_rec.job_id,
		dept_removal_rec.department_id,
                		dept_removal_rec.hire_date); 
   END LOOP;

  DBMS_OUTPUT.PUT_LINE('The transaction has been successfully completed.');

EXCEPTION
  -- Handles all errors
   WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE
       ('The transaction has been rolled back due to errors, please try again.');

     ROLLBACK;


END;
/