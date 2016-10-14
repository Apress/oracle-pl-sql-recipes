DECLARE
  value_one   NUMBER := &value_one;
  value_two   NUMBER := &value_two;
BEGIN
  IF value_one > value_two THEN
    DBMS_OUTPUT.PUT_LINE('value_one is greater than value_two');
  END IF;
END;
/