CREATE OR REPLACE PACKAGE JAVA_UTILS AS
    PROCEDURE send_mail(subject VARCHAR2,
                        recipient VARCHAR2,
                        message VARCHAR2);
                      
    PROCEDURE list_schemas;
    
END;
/