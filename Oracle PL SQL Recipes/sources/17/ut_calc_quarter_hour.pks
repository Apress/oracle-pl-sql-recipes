CREATE OR REPLACE PACKAGE ut_calc_quarter_hour
IS
  PROCEDURE ut_setup;
  PROCEDURE ut_teardown;

  PROCEDURE ut_calc_quarter_hour;
END ut_calc_quarter_hour;
/