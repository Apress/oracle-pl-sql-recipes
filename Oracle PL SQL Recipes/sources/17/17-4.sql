CREATE OR REPLACE FUNCTION factorial (fact INTEGER) RETURN INTEGER is

BEGIN

   IF fact < 0 THEN RETURN NULL;
   ELSIF fact = 0 THEN RETURN 1;
   ELSIF fact = 1 THEN RETURN fact;
   ELSE RETURN fact * factorial (fact-1);
   END IF;

END factorial;
/

CREATE OR REPLACE PACKAGE ut_factorial IS

   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;
   PROCEDURE ut_factorial;

END ut_factorial;
/

CREATE OR REPLACE PACKAGE BODY ut_factorial IS

PROCEDURE ut_setup IS
BEGIN
   NULL;
END ut_setup;

PROCEDURE ut_teardown IS
BEGIN
   NULL;
END ut_teardown;

PROCEDURE ut_factorial IS
BEGIN
   utAssert.isnull ('is NULL test', factorial(-1));
   utAssert.eqQuery ('0! Test', 'select factorial(0) from dual', 'select 1 from dual');
   utAssert.eqQuery ('1! Test', 'select factorial(1) from dual', 'select 1 from dual');
   utAssert.eqQuery ('N! Test', 'select FACTORIAL(5) from dual', 'select 120 from dual');
END ut_factorial;

END ut_factorial;
/