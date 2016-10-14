DECLARE
  CURSOR emp_cur IS
  SELECT *
  FROM EMPLOYEES;

  emp_rec emp_cur%ROWTYPE;
BEGIN
  FOR emp_rec IN emp_cur LOOP
    DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' ||
         emp_rec.last_name);
    DECLARE
      emp_dept  departments.department_name%TYPE;
    BEGIN
      SELECT department_name
      INTO emp_dept
      FROM departments
      WHERE department_id = emp_rec.department_id;
      DBMS_OUTPUT.PUT_LINE('Department: ' || emp_dept);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPTION IN INNER BLOCK');
    END;
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
   DBMS_OUTPUT.PUT_LINE('EXCEPTION IN OUTER BLOCK');
END;
/