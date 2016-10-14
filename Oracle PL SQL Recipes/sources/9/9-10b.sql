CALL DBMS_WARNING.SET_WARNING_SETTING_STRING('ENABLE:ALL','SESSION');

CREATE OR REPLACE FUNCTION calculate_salary_hours(salary  IN NUMBER,
                                                  hours   IN NUMBER DEFAULT 1)
RETURN NUMBER AS
BEGIN
  RETURN salary/hours;
END;
/

SHOW ERRORS;