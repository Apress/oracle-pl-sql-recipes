CREATE OR REPLACE PROCEDURE factorial_test as

fact	NUMBER;

BEGIN

   FOR i IN 1..100 LOOP
      fact := factorial(33);
   END LOOP;

END factorial_test;
/

  -- enable display of execution time
SET TIMING ON

  -- run the test
EXEC factorial_test

ALTER PROCEDURE factorial_test COMPILE PLSQL_CODE_TYPE=NATIVE REUSE SETTINGS;

EXEC factorial_test