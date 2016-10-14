CREATE OR REPLACE PROCEDURE create_attr_table(table_name    VARCHAR2) AS
  BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || table_name ||
                                           '(ATTRIBUTE_ID     NUMBER PRIMARY KEY,
                                             ATTRIBUTE_NAME  VARCHAR2(150) NOT NULL,
                                             ATTRIBUTE_VALUE VARCHAR2(150))';
  END create_attr_table;
/