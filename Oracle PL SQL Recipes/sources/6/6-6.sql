CREATE OR REPLACE PROCEDURE job_history_rpt(in_start_date IN DATE,
                                                                                                   in_end_date IN DATE) AS
  CURSOR job_history_cur IS
  SELECT CAST(hist.start_date AS VARCHAR2(12)) || ' - ' ||
         CAST(hist.end_date AS VARCHAR2(12)) || ': ' ||
         emp.first_name || ' ' || emp.last_name || ' - ' ||
         job_title || ' ' || department_name as details
  FROM jobs jobs,
       job_history hist,
       employees emp,
       departments dept
  WHERE hist.start_date >= in_start_date
  AND hist.end_date <= in_end_date
  AND jobs.job_id = hist.job_id
  AND emp.employee_id = hist.employee_id
  AND dept.department_id = hist.department_id;


  job_history_rec     job_history_cur%ROWTYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('JOB HISTORY REPORT FOR ' ||
    in_start_date || ' to ' || in_end_date); 
  FOR job_history_rec IN job_history_cur LOOP
    DBMS_OUTPUT.PUT_LINE(job_history_rec.details);
  END LOOP;
END;
/