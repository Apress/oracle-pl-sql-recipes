CREATE OR REPLACE TRIGGER populate_emp_email
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
  email_count          NUMBER := 0;
  success_flag         BOOLEAN := FALSE;
  temp_email           employees.email%TYPE;
  email_idx            NUMBER := 0;
BEGIN
  -- check to see if the email address is in the correct format
  IF :new.email != UPPER(SUBSTR(:new.first_name,0,1) || :new.last_name) THEN
    -- check the database to ensure that the new email address will be unique
    temp_email := UPPER(SUBSTR(:new.first_name,0,1) || :new.last_name);
    WHILE success_flag = FALSE LOOP
        SELECT COUNT(*)
        INTO email_count
        FROM employees
        WHERE email = temp_email;
        
        -- if it is unique then end the loop
        IF email_count = 0 THEN
          success_flag := TRUE;
        -- if not unique, then add the index number to the end and check again
        ELSE
          temp_email := UPPER(SUBSTR(:new.first_name,0,1) || :new.last_name) || email_idx;
        END IF;
        email_idx := email_idx + 1;
    END LOOP;
    :new.email := temp_email;
  END IF;

END;
/