DECLARE
  CURSOR job_cur IS
  SELECT *
  FROM jobs;

  job_rec       job_cur%ROWTYPE;
  new_job_title jobs.job_title%TYPE;

BEGIN
  FOR job_rec IN job_cur LOOP
    IF REGEXP_INSTR(job_rec.job_title,'Programmer') > 0 THEN
      new_job_title := REGEXP_REPLACE(job_rec.job_title, 'Programmer',
                                    'Developer');

      UPDATE jobs
      SET job_title = new_job_title
      WHERE job_id = job_rec.job_id;
    
      DBMS_OUTPUT.PUT_LINE(job_rec.job_title || ' replaced with ' ||
         new_job_title);
    END IF;
 END LOOP;

END;
/