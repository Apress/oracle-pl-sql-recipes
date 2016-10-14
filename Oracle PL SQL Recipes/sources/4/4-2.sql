DECLARE
  qtr_hour          NUMBER;
BEGIN
  qtr_hour := calc_quarter_hour(1.3);
  DBMS_OUTPUT.PUT_LINE(qtr_hour);
END;
You can also execute a function as part of an expression. In the following statement, you can see that TOTAL_HOURS is calculated by adding the bill total to the value returned from the function:
DECLARE
  total_hours         NUMBER;
  hours               NUMBER := 8;
BEGIN
  total_hours := hours + calc_quarter_hour(3.2);
  DBMS_OUTPUT.PUT_LINE(total_hours);
END;
/