CREATE TABLE EMPLOYEE_AUDIT_LOG (
employee_id     NUMBER,
enter_date      date
);

CREATE OR REPLACE PROCEDURE emp_audit(emp_id NUMBER)
AS LANGUAGE JAVA
NAME 'Employees.employeeAudit(int)';


CREATE OR REPLACE TRIGGER emp_audit_ins
AFTER INSERT ON EMPLOYEES
FOR EACH ROW
CALL emp_audit(:new.employee_id)
/