BEGIN
  FOR idx IN 1..10 LOOP
    IF MOD(idx,2) != 0 THEN
      DBMS_OUTPUT.PUT_LINE('The current index is: ' || idx);
    END IF;
  END LOOP;
END;
/