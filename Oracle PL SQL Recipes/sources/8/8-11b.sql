CREATE OR REPLACE PROCEDURE execute_clob_nds(sql_text    IN CLOB) AS
  sql_string    CLOB;

BEGIN
  sql_string := sql_text;
  EXECUTE IMMEDIATE sql_string;
END;
/