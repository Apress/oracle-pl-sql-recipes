CREATE OR REPLACE FUNCTION get_emp_job_title(emp_id IN NUMBER)
RETURN VARCHAR2 AS LANGUAGE JAVA
NAME 'Employees.getEmpJobTitle(int) return String'
;
/