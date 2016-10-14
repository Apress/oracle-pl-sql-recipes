CREATE OR REPLACE PROCEDURE log_job_history (emp_id	        IN employees.employee_id%TYPE,
					    Job_id	        IN jobs.job_id%TYPE,
					    Department_id      IN employees.department_id%TYPE,
                                            employee_start     IN DATE) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO job_history
    VALUES (emp_id,
    employee_start,
    sysdate,
    job_id,
    department_id);
    COMMIT;
END;
/