CREATE OR REPLACE PACKAGE ut_calc_quarter_hour
IS
  PROCEDURE ut_setup;
  PROCEDURE ut_teardown;

  PROCEDURE ut_calc_quarter_hour;
END ut_calc_quarter_hour;
/

CREATE OR REPLACE PACKAGE BODY ut_calc_quarter_hour
IS

PROCEDURE ut_setup IS
BEGIN
  NULL;
END;

PROCEDURE ut_teardown IS
BEGIN
  NULL;
END;

PROCEDURE ut_calc_quarter_hour IS
BEGIN

  -- Perform unit tests here
  NULL;
  
END ut_calc_quarter_hour;

END ut_calc_quarter_hour;
/