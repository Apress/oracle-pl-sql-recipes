DECLARE
  new_date    DATE;
BEGIN
  new_date := ADD_MONTHS(sysdate,-2);
  DBMS_OUTPUT.PUT_LINE('The newly calculated date is: ' || new_date);
END;
/