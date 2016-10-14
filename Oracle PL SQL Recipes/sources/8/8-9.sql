CREATE OR REPLACE PROCEDURE modify_table(tab_name   VARCHAR2,
                                  tab_info  VARCHAR2) AS
  sql_text    VARCHAR2(1000);
BEGIN
  sql_text := 'ALTER TABLE ' || tab_name || 
              ' MODIFY ' || tab_info;
  DBMS_OUTPUT.PUT_LINE(sql_text);
  EXECUTE IMMEDIATE sql_text;
  DBMS_OUTPUT.PUT_LINE('Table successfully altered…');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error has occurred, table not modified');
END;
/