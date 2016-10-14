CREATE OR REPLACE PROCEDURE update_employees(id   IN employees.employee_id%TYPE,
                                            first IN employees.first_name%TYPE,
                                            last  IN employees.last_name%TYPE,
                                            email IN employees.email%TYPE,
                                            phone IN employees.phone_number%TYPE,
                                            job   IN employees.job_id%TYPE,
                                            salary IN employees.salary%TYPE,
                                            commission_pct IN employees.commission_pct%TYPE,
                                            manager_id IN employees.manager_id%TYPE,
                                            department_id IN employees.department_id%TYPE)
 AS

  
  emp_upd_rec   employees%ROWTYPE;
  
  sql_string    VARCHAR2(1000);
  
  set_count     NUMBER := 0;
BEGIN

  SELECT *
  INTO emp_upd_rec
  FROM employees
  WHERE employee_id = id;
  
  sql_string := 'UPDATE EMPLOYEES SET ';
  
  IF first != emp_upd_rec.first_name THEN
    IF set_count > 0 THEN
      sql_string := sql_string ||', FIRST_NAME =' || first || '''';
    ELSE
      sql_string := sql_string || ' FIRST_NAME =' || first || '''';
      set_count := set_count + 1;
    END IF;
  END IF;
  
  IF last != emp_upd_rec.last_name THEN
    IF set_count > 0 THEN
      sql_string := sql_string ||', LAST_NAME =''' || last || '''';
    ELSE
      sql_string := sql_string ||' LAST_NAME =''' ||  last || '''';
      set_count := set_count + 1;
    END IF;
  END IF;
  
  IF upper(email) != emp_upd_rec.email THEN
    IF set_count > 0 THEN
      sql_string := sql_string ||', EMAIL =''' || upper(email) || '''';
    ELSE
      sql_string := sql_string ||' EMAIL =''' || upper(email) || '''';
      set_count := set_count + 1;
    END IF;
  END IF;
  
  IF upper(phone) != emp_upd_rec.phone_number THEN
    IF set_count > 0 THEN
      sql_string := sql_string ||', PHONE_NUMBER =''' ||
        upper(phone) || '''';
    ELSE
      sql_string := sql_string ||' PHONE_NUMBER =''' ||
        upper(phone) || '''';
      set_count := set_count + 1;
    END IF;
  END IF;
  
  IF job != emp_upd_rec.job_id THEN
    IF set_count > 0 THEN
      sql_string := sql_string ||', JOB_ID =''' || job || '''';
    ELSE
      sql_string := sql_string ||' JOB_ID =''' || job || '''';
      set_count := set_count + 1;
    END IF;
  END IF;
  
  IF salary != emp_upd_rec.salary THEN
    IF set_count > 0 THEN
      sql_string := sql_string ||', SALARY =' || salary;
    ELSE
      sql_string := sql_string ||' SALARY =' || salary;
      set_count := set_count + 1;
    END IF;
  END IF;
  
  IF commission_pct != emp_upd_rec.commission_pct THEN
    IF set_count > 0 THEN
      sql_string := sql_string ||', COMMISSION_PCT =' ||
               commission_pct;
    ELSE
      sql_string := sql_string ||' COMMISSION_PCT =' ||
               commission_pct;
      set_count := set_count + 1;
    END IF;
  END IF;
  
  IF manager_id != emp_upd_rec.manager_id THEN
    IF set_count > 0 THEN
      sql_string := sql_string ||', MANAGER_ID =' ||
        manager_id;
    ELSE
      sql_string := sql_string ||' MANAGER_ID =' ||
        manager_id;
      set_count := set_count + 1;
    END IF;
  END IF;
  
   IF department_id != emp_upd_rec.department_id THEN
    IF set_count > 0 THEN
      sql_string := sql_string ||', DEPARTMENT_ID =' ||
        department_id;
    ELSE
      sql_string := sql_string ||' DEPARTMENT_ID =' ||
        department_id;
      set_count := set_count + 1;
    END IF;
  END IF;
  
  sql_string := sql_string || ' WHERE employee_id = ' || id;
     
  IF set_count > 0 THEN
    EXECUTE IMMEDIATE sql_string;
  ELSE
    DBMS_OUTPUT.PUT_LINE('No update needed, ' ||
        'all fields match original values');
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No matching employee found');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Data entry error has occurred, ' ||
                'please check values and try again' || sql_string);
END;
/