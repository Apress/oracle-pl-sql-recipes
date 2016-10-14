DECLARE
  myValue    NUMBER := 1;
BEGIN
  WHILE myValue < 10 LOOP
      DBMS_OUTPUT.PUT_LINE('The current value is: ' || myValue);
      myValue := myValue * 2;
  END LOOP;
END;
/