SET SERVEROUT ON

DECLARE

TYPE    vtype   IS VARRAY(3) OF DATE;
TYPE    ctype   IS TABLE OF DATE INDEX BY BINARY_INTEGER;

vdates  vtype := vtype (sysdate);
cdates  ctype;

BEGIN


   DBMS_OUTPUT.PUT_LINE ('vdates size is: ' || vdates.COUNT);
   DBMS_OUTPUT.PUT_LINE ('cdates size is: ' || cdates.COUNT);

   FOR i IN 1..3 LOOP
      cdates(i) := SYSDATE + 1;
   END LOOP;

   DBMS_OUTPUT.PUT_LINE ('cdates size is: ' || cdates.COUNT);

END; 
/