CREATE OR REPLACE PROCEDURE check_password(username IN VARCHAR2) AS
  sql_stmt    VARCHAR2(1000);
  password    VARCHAR2(30);
BEGIN
  sql_stmt := 'SELECT password ' ||
              'FROM user_records ' ||
              'WHERE username = :username';

  EXECUTE sql_stmt
  INTO password
  USING username;

  -- PROCESS PASSWORD
END;
/