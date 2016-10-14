CREATE OR REPLACE TRIGGER send_job_alert
  AFTER INSERT ON jobs
  FOR EACH ROW
DECLARE
  to_address		varchar2(50) := 'admin_list@mycompany.com';
  v_subject		varchar2(100) := 'New job created: ' || :new.job_title;
  v_message		varchar2(2000);
BEGIN

  v_message := 'There has been a new job created with an ID of ' || :new.job_id || 
           		' and a title of ' || :new.job_title || '.  The salary range is: ' ||
		:new.min_salary || ' - ' || :new.max_salary;
   -- Initiate the send_email procedure
  SEND_EMAIL(to_address,
                          v_subject,
	            v_message);
              
END;
/