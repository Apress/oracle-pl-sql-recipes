CREATE OR REPLACE PROCEDURE run_test(test_id  IN NUMBER DEFAULT 1) AS
  sql_text  VARCHAR2(200);
  cursor_var   NUMBER := DBMS_SQL.OPEN_CURSOR;
  rows       NUMBER;
BEGIN
  sql_text := 'BEGIN ' ||
              '  TEST_PROCEDURE' || test_id || '; ' ||
              'END;';

  DBMS_SQL.PARSE(cursor_var, sql_text, DBMS_SQL.NATIVE);
  rows := DBMS_SQL.EXECUTE(cursor_var);
  DBMS_SQL.CLOSE_CURSOR(cursor_var);

END;
/