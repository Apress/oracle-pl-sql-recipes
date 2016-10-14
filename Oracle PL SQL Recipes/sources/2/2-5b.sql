SET SERVEROUTPUT ON;
DECLARE
  CURSOR emp_cur IS
  SELECT first_name, last_name, email
    FROM employees
    WHERE commission_pct is not NULL;

  emp_rec   emp_cur%ROWTYPE;
BEGIN
  FOR emp_rec IN emp_cur LOOP
      DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || emp_rec.last_name || ' - ' || emp_rec.email);
  END LOOP;
END;
/