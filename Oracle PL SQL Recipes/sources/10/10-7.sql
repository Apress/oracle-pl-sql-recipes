SET SERVEROUT ON SIZE 1000000

DECLARE

CURSOR  driver IS
SELECT  employee_id, first_name, last_name, salary
FROM    employees
ORDER BY last_name, first_name;

TYPE    emps_type IS TABLE OF driver%ROWTYPE;
recs    emps_type;

   PROCEDURE print_paycheck (emp_recs emps_type) IS

   BEGIN

      FOR i IN 1..emp_recs.COUNT LOOP
         DBMS_OUTPUT.PUT ('Pay to the order of: ');
         DBMS_OUTPUT.PUT (emp_recs(i).first_name || ' ' || emp_recs(i).last_name);
         DBMS_OUTPUT.PUT_LINE (' $' || to_char (emp_recs(i).salary, 'FM999,990.00'));
      END LOOP;

   END; 

BEGIN

   OPEN driver;
   FETCH driver BULK COLLECT INTO recs;
   CLOSE driver;

   print_paycheck (recs);

END; 
/