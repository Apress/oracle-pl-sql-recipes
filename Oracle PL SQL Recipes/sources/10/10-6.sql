SET SERVEROUT ON SIZE 1000000

DECLARE

TYPE    person_type IS RECORD (
                employee_id     employees.employee_id%TYPE,
                first_name      employees.first_name%TYPE,
                last_name       employees.last_name%TYPE);

  -- a collection of people
TYPE    direct_reports_type IS TABLE OF person_type INDEX BY BINARY_INTEGER; 

  -- the main record definition, which contains a collection of records
TYPE    rec_type IS RECORD (
                mgr             person_type,
                emps            direct_reports_type);

TYPE    recs_type IS TABLE OF rec_type INDEX BY BINARY_INTEGER;
recs    recs_type;

CURSOR  mgr_cursor IS  -- finds all managers
SELECT  employee_id, first_name, last_name
FROM    employees
WHERE   employee_id IN
        (       SELECT  distinct manager_id
                FROM    employees)
ORDER BY last_name, first_name;

CURSOR  emp_cursor (mgr_id integer) IS  -- finds all direct reports for a manager
SELECT  employee_id, first_name, last_name
FROM    employees
WHERE   manager_id = mgr_id
ORDER BY last_name, first_name;

  -- temporary collection of records to hold the managers.
TYPE            mgr_recs_type IS TABLE OF emp_cursor%ROWTYPE
                                INDEX BY BINARY_INTEGER;
mgr_recs        mgr_recs_type;

BEGIN

   OPEN mgr_cursor;
   FETCH mgr_cursor BULK COLLECT INTO mgr_recs;
   CLOSE mgr_cursor;

   FOR i IN 1..mgr_recs.COUNT LOOP
      recs(i).mgr := mgr_recs(i);  -- move the manager record into the final structure

        -- moves direct reports directly into the final structure
      OPEN emp_cursor (recs(i).mgr.employee_id);
      FETCH emp_cursor BULK COLLECT INTO recs(i).emps;
      CLOSE emp_cursor;
   END LOOP;

        -- travers the data structure to display the manager and direct reports
        -- note the use of dot notation within the data structure
   FOR i IN 1..recs.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE ('Manager: ' || recs(i).mgr.last_name);
      FOR j IN 1..recs(i).emps.count LOOP
         DBMS_OUTPUT.PUT_LINE ('***   Employee: ' || recs(i).emps(j).last_name);
      END LOOP;
   END LOOP;

END; 
/