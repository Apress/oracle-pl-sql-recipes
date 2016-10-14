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

  utAssert.isnull (
  'NULL value',
  CALC_QUARTER_HOUR(
    HOURS => NULL
  )
  );
  
  utAssert.eqquery(
  'Check that .10 rounds down',
  'select calc_quarter_hour(6.10) from dual',
  'select 6 from dual'
  );

  utAssert.eqquery(
  'Check that .15 rounds up',
  'select calc_quarter_hour(6.15) from dual',
  'select 6.25 from dual'
  );
  
  utAssert.eqquery(
  'Check that .35 rounds down',
  'select calc_quarter_hour(6.35) from dual',
  'select 6.25 from dual'
  );
  
  utAssert.eqquery(
  'Check that .40 rounds up',
  'select calc_quarter_hour(6.40) from dual',
  'select 6.5 from dual'
  );
  
  utAssert.eqquery(
  'Check that .65 rounds up',
  'select calc_quarter_hour(6.65) from dual',
  'select 6.75 from dual'
  );
  
  utAssert.eqquery(
  'Check that .83 rounds down',
  'select calc_quarter_hour(6.83) from dual',
  'select 7 from dual'
  );
  
  utAssert.eqquery(
  'Check that .92 rounds up',
  'select calc_quarter_hour(6.92) from dual',
  'select 7 from dual'
  );
  
  
END ut_calc_quarter_hour;

END ut_calc_quarter_hour;

/