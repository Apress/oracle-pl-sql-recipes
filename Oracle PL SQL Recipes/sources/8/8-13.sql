DECLARE
  sql_string	CLOB;
  cur_var	BINARY_INTEGER := DBMS_SQL.OPEN_CURSOR;
  ref_cur       SYS_REFCURSOR;
  return_value  BINARY_INTEGER;
  cur_rec	jobs%ROWTYPE;
  salary	NUMBER := &salary;
BEGIN
  -- Formulate query
  sql_string := 'SELECT * FROM JOBS ' ||
		'WHERE MAX_SALARY >= :sal';
  -- Parse SQL
  DBMS_SQL.PARSE(cur_var, sql_string, DBMS_SQL.NATIVE);

  -- Bind variable(s)
  DBMS_SQL.BIND_VARIABLE(cur_var, 'sal', salary);
  
  -- Execute query and convert to REF CURSOR

  return_value := DBMS_SQL.EXECUTE(cur_var);
  ref_cur := DBMS_SQL.TO_REFCURSOR(cur_var);
  DBMS_OUTPUT.PUT_LINE('Jobs that have a maximum salary over ' || salary);
  LOOP
    FETCH ref_cur INTO cur_rec;
    DBMS_OUTPUT.PUT_LINE(cur_rec.job_id || ' - ' || cur_rec.job_title);
    EXIT WHEN ref_cur%NOTFOUND;
  END LOOP;

  CLOSE ref_cur;

END;
/