CREATE MATERIALIZED VIEW dept_salaries
BUILD IMMEDIATE
AS
SELECT department_id, SUM(salary) total_salary
FROM employees
GROUP BY department_id;

SELECT *
FROM dept_salaries
ORDER BY department_id;

EXEC DBMS_REFRESH.MAKE ('HR_MVs', 'dept_salaries', SYSDATE, 'TRUNC(SYSDATE)+1');

UPDATE employees
SET salary = salary * 1.03;

COMMIT;

SELECT *
FROM dept_salaries
ORDER BY department_id;

EXEC DBMS_REFRESH.REFRESH ('HR_MVs');

SELECT *
FROM dept_salaries
ORDER BY department_id;