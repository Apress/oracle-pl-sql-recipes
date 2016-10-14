DECLARE
  CURSOR emp_cur IS
  SELECT first_name, last_name, phone_number
  FROM employees;

  emp_rec	employees%ROWTYPE;

BEGIN
  FOR emp_rec IN emp_cur LOOP
    IF emp_rec.phone_number IS NOT NULL THEN
      -- CHECK FOR INTERNATIONAL PHONE NUMBERS
      IF length(emp_rec.phone_number) > 12 THEN
        DBMS_OUTPUT.PUT_LINE(RPAD(emp_rec.first_name || ' ' || emp_rec.last_name, 20)||
                         ' - ' || LPAD(emp_rec.phone_number,18));
      ELSE
        DBMS_OUTPUT.PUT_LINE(RPAD(emp_rec.first_name || ' ' || emp_rec.last_name, 20)||
                         ' - ' || LPAD(emp_rec.phone_number,12));
      END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || emp_rec.last_name ||
                                ' does not have a phone number.');
    END IF;
  END LOOP;
END;
/