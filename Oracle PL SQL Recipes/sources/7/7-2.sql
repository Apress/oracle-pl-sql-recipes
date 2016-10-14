DECLARE
  ship_date	DATE := SYSDATE + 14;
BEGIN
  DBMS_OUTPUT.PUT_LINE('The shipping date for any products '||
                       'that are ordered today is ' || ship_date);

END;
/