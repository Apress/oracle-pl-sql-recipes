BEGIN
  FOR idx IN 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE('The current index is: ' || idx);
  END LOOP;
END;
/
