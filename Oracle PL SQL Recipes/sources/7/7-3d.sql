DECLARE
  new_date    DATE;
BEGIN
  new_date := ADD_MONTHS(to_date('08/31/2010','MM/DD/YYYY'),1);
  DBMS_OUTPUT.PUT_LINE('The last day of next month is: ' || new_date);
END;
/