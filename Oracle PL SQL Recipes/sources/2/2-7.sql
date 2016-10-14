DECLARE
  CURSOR emp_cur IS
  SELECT first_name, last_name, phone_number
  FROM employees;

  emp_rec	employees%ROWTYPE;

BEGIN
  FOR emp_rec IN emp_cur LOOP
    IF emp_rec.phone_number IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE(RPAD(emp_rec.first_name || ' ' || emp_rec.last_name, 35,'.') ||
                                   emp_rec.phone_number);
    ELSE
        DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || emp_rec.last_name ||
                                ' does not have a phone number.');
    END IF;
  END LOOP;
END;
/