CREATE OR REPLACE FUNCTION calc_hours(time_to_change IN TIMESTAMP,
                     timeval IN NUMBER)
RETURN TIMESTAMP AS
  new_time    TIMESTAMP;
BEGIN
 
  new_time := time_to_change + NUMTODSINTERVAL(timeval,'HOUR');

  RETURN new_time;
END;

CREATE OR REPLACE FUNCTION calc_minutes(time_to_change IN TIMESTAMP,
                     timeval IN NUMBER)
RETURN TIMESTAMP AS
  new_time    TIMESTAMP;
BEGIN
 
  new_time := time_to_change + NUMTODSINTERVAL(timeval,'MINUTE');

  RETURN new_time;
END;

CREATE OR REPLACE FUNCTION calc_seconds(time_to_change IN TIMESTAMP,
                     timeval IN NUMBER)
RETURN TIMESTAMP AS
  new_time    TIMESTAMP;
BEGIN
 
  new_time := time_to_change + NUMTODSINTERVAL(timeval,'SECOND');

  RETURN new_time;
END;

CREATE OR REPLACE FUNCTION calc_days(time_to_change IN TIMESTAMP,
                     timeval IN NUMBER)
RETURN TIMESTAMP as
  new_time  TIMESTAMP;
BEGIN
  new_time := time_to_change + timeval;
  RETURN new_time;
END;
/