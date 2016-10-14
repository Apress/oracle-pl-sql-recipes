CREATE TABLE time_log 
(job_time              TIMESTAMP WITH LOCAL TIME ZONE,
 description          VARCHAR2(2000));

CREATE OR REPLACE FUNCTION find_tz (city IN VARCHAR2) 
RETURN NUMBER IS
  tz          NUMBER := 0;
BEGIN
  IF city = 'CHI' THEN
    tz := -5;
  ELSIF city = 'ORD' THEN
    tz := -4;
  ELSIF city = 'SJ' THEN
    tz := -7;
  END IF;
  RETURN tz;
END;

CREATE OR REPLACE TRIGGER log_job_history
AFTER INSERT ON jobs
FOR EACH ROW
DECLARE
  my_ts	VARCHAR2(25) := to_char(sysdate, 'YYYY-MM-DD HH:MI:SS');
BEGIN
  my_ts := my_ts || ' ' || find_tz('CHI');
  
  INSERT INTO time_log values(
    TO_TIMESTAMP_TZ(my_ts, 'YYYY-MM-DD HH:MI:SS TZH:TZM'),
    'INSERT'
  );

END;
/