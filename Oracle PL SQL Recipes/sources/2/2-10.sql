CREATE OR REPLACE PROCEDURE remove_job_history(dept_id IN NUMBER) AS
  CURSOR job_history_cur IS
  SELECT *
  FROM job_history
  WHERE department_id = dept_id
  FOR UPDATE;

  job_history_rec  job_history_cur%ROWTYPE;

 BEGIN
    
    FOR job_history_rec IN job_history_cur LOOP
      
      DELETE FROM job_history
      WHERE CURRENT OF job_history_cur;

      DBMS_OUTPUT.PUT_LINE('Job history removed for department ' ||
                dept_id);
    END LOOP;

END; 
/