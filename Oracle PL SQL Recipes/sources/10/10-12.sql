SET SERVEROUT ON

DECLARE

TYPE    vtype   IS VARRAY(5) OF DATE;
vdates  vtype := vtype (sysdate, sysdate+1, sysdate+2); -- initialize 3 of the 5 elements

BEGIN

   DBMS_OUTPUT.PUT_LINE ('vdates size is: ' || vdates.COUNT);

   FOR i IN 1..5 LOOP
      if NOT vdates.EXISTS(i) then
         vdates.EXTEND;
         vdates(i) := SYSDATE + i;
      END IF;
   END LOOP;

   DBMS_OUTPUT.PUT_LINE ('vdates size is: ' || vdates.COUNT);

END; 
/