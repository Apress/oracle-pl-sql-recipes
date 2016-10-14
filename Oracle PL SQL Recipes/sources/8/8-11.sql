CREATE OR REPLACE PROCEDURE execute_clob(sql_text CLOB) AS
  sql_string    CLOB;
  cur_var       BINARY_INTEGER;
  ret_var       INTEGER;
  return_value  VARCHAR2(100);
BEGIN
  sql_string := sql_text;
  cur_var := DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(cur_var, sql_string, DBMS_SQL.NATIVE);
  ret_var := DBMS_SQL.EXECUTE(cur_var);
  DBMS_SQL.CLOSE_CURSOR(cur_var);
END;
/