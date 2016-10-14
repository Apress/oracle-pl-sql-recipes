DECLARE

  -- Query all programmers who make more than 4000
  -- as they will be moved to the new 'Web Development' department
  CURSOR new_dept_cur IS
  SELECT *
  FROM employees
  WHERE job_id = 'IT_PROG'
  AND salary > 4000
  FOR UPDATE;

  new_dept_rec		new_dept_cur%ROWTYPE;
  current_department    departments.department_id%TYPE;

BEGIN

  -- Create a new department
  INSERT INTO departments values('
   DEPARTMENTS_SEQ.nextval,     -- Department ID (sequence value)
   'Web Development',           -- Department Title
   103,  			-- Manager ID
   1700);                       -- Location ID

  -- Obtain the current department ID…the new department ID
  SELECT DEPARTMENTS_SEQ.currval 
  INTO current_department
  FROM DUAL;

  -- Update all employees returned by the cursor
  FOR new_dept_rec IN new_dept_cur LOOP

    UPDATE employees
    SET department = current_department
    WHERE CURRENT OF new_dept_cur;

  END LOOP;
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('The transaction has been successfully completed.');

EXCEPTION
  -- Handles all errors
   WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE
       ('The transaction has been rolled back due to errors, please try again.');
     ROLLBACK;


END;
