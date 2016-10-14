CREATE OR REPLACE TRIGGER send_salary_notice
AFTER UPDATE OF SALARY ON employees
FOR EACH ROW
DISABLE
DECLARE
  v_subject	VARCHAR2(100) := 'Salary Update Has Occurrred';
  v_message     VARCHAR2(2000);
BEGIN
  v_message := 'Your salary has been increased from ' ||
             :old.salary || ' to ' || :new.salary || '.'  ||
             'If you have any questions or complaints, please ' ||
             'do not contact the DBA.';

  SEND_EMAIL(:new.email || '@mycompany.com',
             v_subject,
             v_message);
END;
/
  
