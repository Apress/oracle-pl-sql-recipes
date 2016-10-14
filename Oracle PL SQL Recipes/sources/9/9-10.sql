ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:ALL';

CREATE OR REPLACE FUNCTION calculate_salary_hours(salary  IN NUMBER,
                                                  hours   IN NUMBER DEFAULT 1)
RETURN NUMBER AS
BEGIN
  RETURN salary/hours;
END;
/

SHOW ERRORS;

