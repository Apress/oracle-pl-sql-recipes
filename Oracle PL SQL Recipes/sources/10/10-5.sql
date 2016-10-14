SET SERVEROUT ON

DECLARE

CURSOR  driver IS
SELECT  ee.employee_id, ee.first_name, ee.last_name, ee.salary, d.department_name
FROM    departments     d,
        employees       ee
WHERE   d.department_id = ee.department_id;
 
TYPE    total_type IS TABLE OF number INDEX BY departments.department_name%TYPE;
totals  total_type;

dept    departments.department_name%TYPE;

BEGIN

   FOR rec IN driver LOOP
      -- process paycheck
      if NOT totals.EXISTS(rec.department_name) then  -- create element in the array
         totals(rec.department_name) := 0; -- initialize to zero
      end if;

      totals(rec.department_name) := totals(rec.department_name) + nvl (rec.salary, 0);
   END LOOP;

   dept := totals.FIRST;
   LOOP
      EXIT WHEN dept IS NULL;
      DBMS_OUTPUT.PUT_LINE (to_char (totals(dept),  '999,999.00') || ' ' || dept);
      dept := totals.NEXT(dept);
   END LOOP;

END; 
/