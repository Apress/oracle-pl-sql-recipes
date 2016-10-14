SET SERVEROUT ON

DECLARE

TYPE    dow_type IS VARRAY(7) OF VARCHAR2(3);
dow     dow_type := dow_type ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');

BEGIN

   FOR i IN 1..dow.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE (dow(i));
   END LOOP;

END;
/