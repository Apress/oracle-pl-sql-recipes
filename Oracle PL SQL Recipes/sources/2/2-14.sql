<<duplicate_emp_qry>>
DECLARE
  CURSOR emp_cur IS
  SELECT *
  FROM   employees
  ORDER BY employee_id;

  emp_count		number := 0;
  total_count		number := 0;

BEGIN
  DBMS_OUTPUT.PUT_LINE('You will see each duplicated employee listed more ');
  DBMS_OUTPUT.PUT_LINE('than once in the list below.  This will allow you to ');
  DBMS_OUTPUT.PUT_LINE('review the list and ensure that indeed...there are more ');
  DBMS_OUTPUT.PUT_LINE('than one of these employee records in the table.');

  DBMS_OUTPUT.PUT_LINE('Duplicated Employees: ');

-- Loop through each player in the table
  FOR emp_rec IN  emp_cur LOOP

-- Select the number of records in the table that have the same ID as the current record
     SELECT count(*)
     INTO emp_count
     FROM employees
     WHERE employee_id = emp_rec.employee_id;

-- If the count is greater than one then a duplicate has been found, so print it out.
     IF emp_count > 1 THEN
        DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id || ' - ' || emp_rec.first_name ||
                   ' ' || emp_rec.last_name || ' - ' || emp_count);
	total_count := total_count + 1;
     END IF;

  END LOOP;
END;
/