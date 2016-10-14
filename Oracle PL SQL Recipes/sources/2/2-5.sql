SET SERVEROUTPUT ON;
BEGIN
  FOR emp IN
  (
    SELECT first_name, last_name, email
    FROM employees
    WHERE commission_pct is not NULL
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE(emp.first_name || ' ' || emp.last_name || ' - ' || emp.email);
  END LOOP;
END;
/