CREATE OR REPLACE PACKAGE no_copy_test AS

   TYPE rec_type IS TABLE OF all_objects%ROWTYPE INDEX BY BINARY_INTEGER;
   PROCEDURE test;

END no_copy_test;
/

CREATE OR REPLACE PACKAGE BODY no_copy_test AS

PROCEDURE proc1 (rec_list IN OUT rec_type) IS
BEGIN
   FOR i IN 1..rec_list.COUNT LOOP
      rec_list(i) := rec_list(i);
   END LOOP;
END;

PROCEDURE proc2 (rec_list IN OUT NOCOPY  rec_type) IS
BEGIN
   FOR i IN 1..rec_list.COUNT LOOP
      rec_list(i) := rec_list(i);
   END LOOP;
END;

PROCEDURE test IS

CURSOR	driver IS
SELECT	*
FROM	all_objects;

recs		rec_type;
rec_count	integer;

BEGIN

   OPEN driver;
   FETCH DRIVER BULK COLLECT INTO recs;
   CLOSE driver;

   rec_count := recs.COUNT;

   DBMS_OUTPUT.PUT_LINE (systimestamp);
   proc1 (recs); -- parameter passed by value
   DBMS_OUTPUT.PUT_LINE (systimestamp);
   proc2 (recs); -- paramter passed by reference
   DBMS_OUTPUT.PUT_LINE (systimestamp);
END test;

END no_copy_test;
/

set serverout on
EXEC no_copy_test.test;