SET SERVEROUT ON

DECLARE

TYPE ctype IS TABLE OF DATE INDEX BY BINARY_INTEGER;

cdates ctype;

BEGIN

   FOR i IN 1..3 LOOP
     cdates(i) := sysdate + i;
   END LOOP;

   cdates.DELETE(2);

   FOR i IN 1..3 LOOP
      IF cdates.EXISTS(i) then
         DBMS_OUTPUT.PUT_LINE ('cdates(' || i || ')= ' || cdates(i) );
      END IF;
   END LOOP;

END; 
/