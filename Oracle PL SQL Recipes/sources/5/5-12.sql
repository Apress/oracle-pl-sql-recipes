CREATE OR REPLACE TRIGGER emp_table_auditing
  FOR INSERT OR UPDATE ON employees
    COMPOUND TRIGGER
  -- Global variable section
  table_upd_count	NUMBER := 0;
  table_id_start	employees.employee_id%TYPE;

  AFTER EACH ROW IS
  BEGIN
    SELECT MAX(employee_id)
    INTO table_id_start
    FROM employees;

    IF INSERTING THEN
     
      INSERT INTO update_access_log VALUES(
        update_access_seq.nextval,
        SYS_CONTEXT('USERENV','SESSION_USER'),
        sysdate,
        NULL,
        :new.salary,
        'EMPLOYEES - INSERT',
        'SALARY');
      table_upd_count := table_upd_count + 1;

    ELSIF UPDATING THEN
      IF :old.salary != :new.salary THEN        INSERT INTO update_access_log VALUES(
          update_access_seq.nextval,
          SYS_CONTEXT('USERENV','SESSION_USER'),
          sysdate,
          :old.salary,
          :new.salary,
          'EMPLOYEES - UPDATE',
          'SALARY');
        table_upd_count := table_upd_count + 1;
      END IF;
    END IF;   
  END AFTER EACH ROW;

  AFTER STATEMENT IS
    v_subject		VARCHAR2(100) := 'Employee Table Update';
    v_message		VARCHAR2(2000);
  BEGIN
        
    v_message := 'There have been ' || table_upd_count ||
     ' changes made to the employee table starting with ID #' ||
     table_id_start;

    SEND_EMAIL('DBA-GROUP@my_company.com',
               v_subject,
               v_message);
  END AFTER STATEMENT;

END emp_table_auditing;
