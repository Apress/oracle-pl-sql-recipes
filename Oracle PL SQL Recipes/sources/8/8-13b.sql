DECLARE
  sql_string	CLOB;
  ref_cur       SYS_REFCURSOR;
  cursor_var    BINARY_INTEGER;
  cols_var	BINARY_INTEGER;
  desc_var	DBMS_SQL.DESC_TAB;
  v_job_id	NUMBER;
  v_job_title   VARCHAR2(25);
  salary	NUMBER(6) := &salary;
  return_val    NUMBER;

BEGIN
  -- Formulate query
  sql_string := 'SELECT * FROM JOBS ' ||
		'WHERE MAX_SALARY >= :sal';
  -- Open REF CURSOR
  OPEN ref_cur FOR sql_string USING salary;
  
  cursor_var := DBMS_SQL.TO_CURSOR_NUMBER(ref_cur);
  DBMS_SQL.DESCRIBE_COLUMNS(cursor_var, cols_var, desc_var);
  DBMS_SQL.CLOSE_CURSOR(cursor_var);
  
  FOR x IN 1 .. cols_var LOOP
    DBMS_OUTPUT.PUT_LINE(desc_var(x).col_name || ' - ' ||
			 CASE desc_var(x).col_type
 			   WHEN 1 THEN 'VARCHAR2'
			   WHEN 2 THEN 'NUMBER'
                           ELSE 'OTHER'
			 END);
  END LOOP;
END;
/