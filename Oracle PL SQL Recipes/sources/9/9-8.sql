CREATE OR REPLACE FUNCTION calculate_salary_hours(salary  IN NUMBER,
                                                  hours   IN NUMBER DEFAULT 1)
RETURN NUMBER AS
BEGIN
  RETURN salary/hours;
END;
 

DECLARE
  DIVISOR_IS_ZERO  EXCEPTION;
  PRAGMA EXCEPTION_INIT(DIVISOR_IS_ZERO, -1476);
  per_hour      NUMBER;
BEGIN
  SELECT calculate_salary_hours(0,0)
  INTO per_hour
  FROM DUAL;
EXCEPTION WHEN DIVISOR_IS_ZERO THEN
  DBMS_OUTPUT.PUT_LINE('You cannot pass a zero for the number of hours');
END;
/