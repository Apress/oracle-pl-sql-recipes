SET SERVEROUT ON

DECLARE

CURSOR  driver IS
SELECT  last_name
FROM    employees;

TYPE    rec_type IS TABLE OF driver%ROWTYPE INDEX BY BINARY_INTEGER;
recs    rec_type;
j       INTEGER;

BEGIN

   OPEN driver;
   FETCH driver BULK COLLECT INTO recs;
   CLOSE driver;

   DBMS_RANDOM.INITIALIZE(TO_NUMBER (TO_CHAR (SYSDATE, 'SSSSS') ) );

   FOR i IN 1..3 LOOP
--      Randomly select an employee
      j := MOD (ABS (DBMS_RANDOM.RANDom), recs.COUNT) + 1;
      DBMS_OUTPUT.PUT_LINE (recs(j).last_name);

--      Move all employees up one postion in the collection
      FOR k IN j+1..recs.COUNT LOOP
         recs(k-1) := recs(k);
      END LOOP;

--      Remove the last element in the collection
--      so the random number generator has the correct count.
      recs.DELETE(recs.COUNT);
   END LOOP;

   DBMS_RANDOM.TERMINATE;

END;
/