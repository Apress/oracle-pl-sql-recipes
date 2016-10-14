BEGIN
  FOR idx IN 1..5 LOOP
    DBMS_OUTPUT.PUT_LINE('The current index is: ' || idx*2);
  END LOOP;
END;

/