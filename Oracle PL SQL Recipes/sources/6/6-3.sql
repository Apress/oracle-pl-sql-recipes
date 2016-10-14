CREATE OR REPLACE FUNCTION CALCULATE_BILL(bill_amount IN NUMBER)
 RETURN VARCHAR2 AS
  tax	NUMBER	:= .12;
  tip   NUMBER  := .2;
  total_bill    NUMBER := 0;
BEGIN
  total_bill := bill_amount + (bill_amount * tax);
  total_bill := total_bill + (total_bill * tip);
  return to_char(total_bill, '$999.00');
END;
/
  