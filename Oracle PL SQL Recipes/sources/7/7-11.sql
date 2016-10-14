CREATE OR REPLACE FUNCTION capture_milliseconds(in_time TIMESTAMP) 
RETURN NUMBER IS
  milliseconds	NUMBER;
BEGIN
select sum(
   (extract(hour from in_time))*3600+
   (extract(minute from in_time))*60+
   (extract(second from in_time)))*1000
into MILLISECONDS from dual;
RETURN milliseconds;

END;
/