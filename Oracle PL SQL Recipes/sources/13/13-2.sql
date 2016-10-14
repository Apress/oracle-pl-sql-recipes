CREATE OR REPLACE PROCEDURE sync_hr_data AS

CURSOR	driver IS
SELECT	*
FROM	employees@hr_data;

BEGIN

   FOR recs IN driver LOOP
      UPDATE	employees
      SET	first_name	= recs.first_name
      WHERE	employee_id	= recs.employee_id;
   END LOOP;

END sync_hr_data;
/

EXEC DBMS_PROFILER.START_PROFILER ('Test1', 'Testing One');
EXEC sync_hr_data;
EXEC DBMS_PROFILER.FLUSH_DATA;
EXEC DBMS_PROFILER.STOP_PROFILER;

COL line# FORMAT 999
COL hundreth FORMAT a6
COL text FORMAT a50

SELECT	d.line#,
	to_char (d.total_time/10000000, '999.00') hundreths,
	s.text
FROM	user_source		s,
	plsql_profiler_data	d,
	plsql_profiler_units	u,
	plsql_profiler_runs	r
WHERE	r.run_comment		= 'Test1' -- run_comment matches the text in START_PROFILER
AND	u.runid			= r.runid
AND	u.unit_owner		= r.run_owner
AND	d.runid			= r.runid
AND	d.unit_number		= u.unit_number
AND	s.name			= u.unit_name
AND	s.line			= d.line#
ORDER BY d.line#;