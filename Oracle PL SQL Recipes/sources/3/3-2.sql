DECLARE  employee	      employees%ROWTYPE;  emp_count	      number := 0;BEGIN  SELECT count(*)  INTO emp_count  FROM employees  WHERE employee_id = 100;  IF emp_count > 0  THEN    SELECT *    INTO employee    FROM employees    WHERE employee_id = 100;

    IF employee.manager_id IS NOT NULL THEN      DBMS_OUTPUT.PUT_LINE(employee.first_name || ' ' || employee.last_name || 
            ' has an assigned manager.');
    ELSE
      DBMS_OUTPUT.PUT_LINE(employee.first_name || ' ' || employee.last_name || 
            ' does not have an assigned manager.');
    END IF;  ELSE    DBMS_OUTPUT.PUT_LINE('The given employee ID does not match any records, '||
                ' please try again');  END IF;EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Try another employee ID.');END;/