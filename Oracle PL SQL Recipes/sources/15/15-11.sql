CREATE OR REPLACE PACKAGE EMP_PKG AS

    PROCEDURE get_it_emps;
    PROCEDURE get_it_emps_by_dept(dept_id IN NUMBER);
    PROCEDURE emp_audit(emp_id NUMBER);
    
    FUNCTION get_emp_job_title(emp_id IN NUMBER) RETURN VARCHAR2;
    FUNCTION get_emp_department (emp Employee) RETURN VARCHAR2;

END;

CREATE PACKAGE BODY EMP_PKG AS

    PROCEDURE get_it_emps
    AS LANGUAGE JAVA
    NAME 'Employees.getItEmps()';
    
    PROCEDURE get_it_emps_by_dept(dept_id IN NUMBER)
    AS LANGUAGE JAVA
    NAME 'Employees.getItEmpsByDept(int)';
    
    PROCEDURE emp_audit(emp_id NUMBER)
    AS LANGUAGE JAVA
    NAME 'Employees.employeeAudit(int)';
    
    FUNCTION get_emp_job_title(emp_id IN NUMBER) RETURN VARCHAR2
    AS LANGUAGE JAVA
    NAME 'Employees.getEmpJobTitle(int) return String';
    
    FUNCTION get_emp_department (emp Employee) RETURN VARCHAR2
    AS LANGUAGE JAVA
    NAME 'Employees.getEmpDepartment(oracle.sql.STRUCT) return java.lang.String';


END;


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
            emp_pkg.get_emp_department(emp));
  END LOOP;
END;
/
