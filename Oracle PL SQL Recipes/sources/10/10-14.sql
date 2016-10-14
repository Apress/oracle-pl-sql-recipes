SET SERVEROUT ON

DECLARE

TYPE    vtype   IS VARRAY(5) OF DATE;
vdates  vtype := vtype (sysdate, sysdate+1, sysdate+2, sysdate+3, sysdate+4);

BEGIN

   DBMS_OUTPUT.PUT_LINE ('vdates size is: ' || vdates.COUNT);
   vdates.TRIM;
   DBMS_OUTPUT.PUT_LINE ('vdates size is: ' || vdates.COUNT);
   vdates.TRIM(2);
   DBMS_OUTPUT.PUT_LINE ('vdates size is: ' || vdates.COUNT);

END; 
/