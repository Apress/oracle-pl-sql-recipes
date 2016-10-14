CREATE TYPE Employee AS OBJECT (
emp_id NUMBER(6),
first VARCHAR2(20),
last  VARCHAR2(25),
email VARCHAR2(25),
job VARCHAR2(10),
dept NUMBER(4)
);

CREATE OR REPLACE FUNCTION get_emp_department (emp Employee) RETURN VARCHAR2 AS
LANGUAGE JAVA
NAME 'Employees.getEmpDepartment(oracle.sql.STRUCT) return java.lang.String';

DECLARE
  CURSOR emp_cur IS
  SELECT * FROM EMPLOYEES;
  
  emp_rec    emp_cur%ROWTYPE;
  emp        Employee;
BEGIN
  FOR emp_rec IN emp_cur LOOP
    emp := Employee(emp_rec.employee_id,
                    emp_rec.first_name,
                    emp_rec.last_name,
                    emp_rec.email,
                    emp_rec.job_id,
                    emp_rec.department_id);
    DBMS_OUTPUT.PUT_LINE(emp.first || ' ' || emp.last || ' - ' ||
            get_emp_department(emp));
  END LOOP;
END;
/
