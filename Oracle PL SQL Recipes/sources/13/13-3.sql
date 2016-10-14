CREATE OR REPLACE PROCEDURE sync_hr_data AS

CURSOR	driver IS
SELECT	*
FROM	employees@hr_data;

TYPE	recs_type IS TABLE OF driver%ROWTYPE INDEX BY BINARY_INTEGER;
recs	recs_type;

BEGIN

   OPEN driver;
   FETCH driver BULK COLLECT INTO recs;
   CLOSE driver;

   FORALL i IN 1..recs.COUNT
      UPDATE	employees
      SET	first_name	= recs(i).first_name
      WHERE	employee_id	= recs(i).employee_id;

END sync_hr_data;
/

EXEC DBMS_PROFILER.START_PROFILER ('Test2', 'Testing Two');
EXEC sync_hr_data;
EXEC DBMS_PROFILER.FLUSH_DATA;
EXEC DBMS_PROFILER.STOP_PROFILER;

COL line# FORMAT 999
COL hundreth FORMAT A6
COL text FORMAT a50

SELECT	d.line#,
	TO_CHAR (d.total_time/10000000, '999.00') hundreths,
	s.text
FROM	user_source		s,
	plsql_profiler_data	d,
	plsql_profiler_units	u,
	plsql_profiler_runs	r
WHERE	r.run_comment		= 'Test2'
AND	u.runid			= r.runid
AND	u.unit_owner		= r.run_owner
AND	d.runid			= r.runid
AND	d.unit_number		= u.unit_number
AND	s.name			= u.unit_name
AND	s.line			= d.line#
ORDER BY d.line#;