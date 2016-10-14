CREATE OR REPLACE TRIGGER dept_mgr_update
AFTER UPDATE OF manager_id
    ON departments
FOR EACH ROW
DECLARE
  CURSOR emp_cur IS
  SELECT *
  FROM EMPLOYEES
  WHERE manager_id = :old.manager_id
  FOR UPDATE;
BEGIN

  
     FOR emp_rec IN emp_cur LOOP
        UPDATE employees
        SET manager_id = :new.manager_id
        WHERE CURRENT OF emp_cur;
     END LOOP;
  
END;
/