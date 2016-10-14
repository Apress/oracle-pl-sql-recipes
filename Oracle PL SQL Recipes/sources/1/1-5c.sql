DECLARE
  dept_id_var  NUMBER(4) := &department_id;
  dept_name    VARCHAR2(30);
  emp_count    NUMBER;
BEGIN
  SELECT count(*)
  INTO emp_count
  FROM employees
  WHERE department_id = dept_id_var;
  
  SELECT department_name
  INTO dept_name
  FROM departments
  WHERE department_id = dept_id_var;
  
  DBMS_OUTPUT.PUT_LINE('There are ' || emp_count || ' employees ' ||
          'in the ' || dept_name || ' department.');
 END;
/