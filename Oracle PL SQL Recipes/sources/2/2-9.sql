DECLARE
  CURSOR emp_sal_cur IS
  SELECT *
  FROM employees
  WHERE department_id = 60
  FOR UPDATE;

  emp_sal_rec  emp_sal_cur%ROWTYPE;

 BEGIN
    FOR emp_sal_rec IN emp_sal_cur LOOP
      DBMS_OUTPUT.PUT_LINE('Old Salary: ' || emp_sal_rec.last_name ||
                  ' - ' || emp_sal_rec.salary);
      
      UPDATE employees
      SET salary = salary + (salary * .025)
      WHERE CURRENT OF emp_sal_cur;

    END LOOP;
    
    -- Display the updated salaries
    FOR emp_sal_rec IN emp_sal_cur LOOP
      DBMS_OUTPUT.PUT_LINE('New Salary: ' || emp_sal_rec.last_name ||
                  ' - ' || emp_sal_rec.salary);
    END LOOP;
END; 
/