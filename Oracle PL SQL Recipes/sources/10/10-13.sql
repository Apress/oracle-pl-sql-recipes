SET SERVEROUT ON

DECLARE

TYPE    ntype   IS TABLE OF NUMBER INDEX BY VARCHAR2(5);
nlist   ntype;
idx     VARCHAR2(5);
total   integer := 0;

BEGIN

   nlist('North') := 100;
   nlist('South') := 125;
   nlist('East')  := 75;
   nlist('West')  := 75;

   idx := nlist.FIRST;
   LOOP
      EXIT WHEN idx is null;
      DBMS_OUTPUT.PUT_LINE (idx || ' = ' || nlist(idx) );
      total := total + nlist(idx);
      idx   := nlist.NEXT(idx);
   END LOOP;

   DBMS_OUTPUT.PUT_LINE ('Total: ' || total);

END; 
/