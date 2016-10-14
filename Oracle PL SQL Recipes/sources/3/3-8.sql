DECLARE
  CURSOR emp_cur is
  SELECT *
  FROM employees;

  emp_rec       emp_cur%ROWTYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Employees with salary > 15000: ');
  OPEN emp_cur;
  LOOP
    FETCH emp_cur INTO emp_rec;
    EXIT WHEN emp_cur%NOTFOUND;
    IF emp_rec.salary < 15000 THEN
      CONTINUE;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Employee: ' || emp_rec.first_name || ' ' ||
            emp_rec.last_name);
    END IF;

  END LOOP;
  CLOSE emp_cur;

END;
/