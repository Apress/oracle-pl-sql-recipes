BEGIN
  <<outer>> FOR idx1 IN 1 .. 10 LOOP
    <<inner>> FOR idx2 IN 1 .. 10 LOOP
      DBMS_OUTPUT.PUT(idx2);
      EXIT inner WHEN idx2 > idx1 * 2;
      EXIT outer WHEN idx2 = 10;
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
  END LOOP;
  DBMS_OUTPUT.NEW_LINE;
END;
/