CREATE OR REPLACE PACKAGE BODY JAVA_UTILS AS

    PROCEDURE send_mail(subject VARCHAR2,
                        recipient VARCHAR2,
                        message VARCHAR2)
    AS LANGUAGE JAVA
    NAME 'JavaUtils.sendMail(java.lang.String, java.lang.String, java.lang.String)';
    
    
    PROCEDURE list_schemas
    AS LANGUAGE JAVA
    NAME 'JavaUtils.listDatabaseSchemas()';
    
END;
/