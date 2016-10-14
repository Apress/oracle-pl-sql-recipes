CREATE OR REPLACE PACKAGE synchronize_data IS  PROCEDURE driver;END;

CREATE OR REPLACE PACKAGE BODY synchronize_data IS  PROCEDURE query_remote_data IS    BEGIN      --statements go here
      DBMS_OUTPUT.PUT_LINE('QUERYING REMOTE DATA');    END query_remote_data;   PROCEDURE obtain_new_record_list IS    BEGIN      --statements go here
      DBMS_OUTPUT.PUT_LINE('NEW RECORD LIST');    END obtain_new_record_list;   PROCEDURE obtain_updated_record_list IS    BEGIN      --statements go here
      DBMS_OUTPUT.PUT_LINE('UPDATED RECORD LIST');    END obtain_updated_record_list;   PROCEDURE sync_local_data IS    BEGIN      --statements go here
      DBMS_OUTPUT.PUT_LINE('SYNC LOCAL DATA');    END sync_local_data;     PROCEDURE driver IS  BEGIN    query_remote_data;    obtain_new_record_list;    obtain_updated_record_list;    sync_local_data;  END driver;END synchronize_data;/