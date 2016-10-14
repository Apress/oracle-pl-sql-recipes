DECLARE
  last_day  VARCHAR2(20);
BEGIN
  select LAST_DAY(sysdate)
  INTO last_day
  FROM DUAL;
  DBMS_OUTPUT.PUT_LINE(last_day);
END;
/