CREATE OR REPLACE FUNCTION find_interval_hours(from_date IN DATE,
                     to_date IN DATE)
RETURN NUMBER AS
BEGIN
 RETURN abs(trunc(from_date) - trunc(to_date) )* 24;
END;


CREATE OR REPLACE FUNCTION find_interval_minutes(from_date IN DATE,
                                         to_date IN DATE)
RETURN NUMBER AS
BEGIN
  RETURN (from_date - to_date) * 24 * 60;
END;


CREATE OR REPLACE FUNCTION find_interval_seconds(from_date IN DATE,
                                         to_date IN DATE)
RETURN NUMBER AS
BEGIN
  RETURN (from_date - to_date) * 24 * 60 * 60;
END;
/