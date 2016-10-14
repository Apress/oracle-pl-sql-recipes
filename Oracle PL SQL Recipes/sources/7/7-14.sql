DECLARE
  CURSOR emp_cur IS
  SELECT *
  FROM employees;

  emp_rec       emp_cur%ROWTYPE;

  position     NUMBER := 0;
  counter        NUMBER := 0;
  intl_count     NUMBER := 0;
BEGIN
  FOR emp_rec IN emp_cur LOOP
  position := REGEXP_INSTR(emp_rec.phone_number,
  '([[:digit:]]{3})\.([[:digit:]]{3})\.([[:digit:]]{4})');
  
  IF position > 0 THEN
    counter := counter + 1;
  ELSE
    intl_count := intl_count + 1;
  END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Numbers within USA: ' || counter);
  DBMS_OUTPUT.PUT_LINE('International Numbers: ' || intl_count);

END;
/