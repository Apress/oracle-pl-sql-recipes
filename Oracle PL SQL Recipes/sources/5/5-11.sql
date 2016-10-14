CREATE or REPLACE TRIGGER populate_hire_dateBEFORE INSERT    ON employees    FOR EACH ROW
FOLLOWS verify_emp_salaryDECLAREBEGIN    :new.hire_date := sysdate;END;

CREATE OR REPLACE TRIGGER verify_emp_salary
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
  v_min_sal	jobs.min_salary%TYPE;
  v_max_sal     jobs.max_salary%TYPE;
BEGIN
  SELECT min_salary, max_salary
  INTO v_min_sal, v_max_sal
  FROM JOBS
  WHERE JOB_ID = :new.JOB_ID;

  IF :new.salary > v_max_sal THEN
    RAISE_APPLICATION_ERROR(-20901,
       'You cannot give a salary greater than the max in this category');
  ELSIF :new.salary < v_min_sal THEN
    RAISE_APPLICATION_ERROR(-20902,
       'You cannot give a salary less than the min in this category');
  END IF;
END;/