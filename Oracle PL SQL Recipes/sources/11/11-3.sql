EXEC DBMS_SCHEDULER.ADD_JOB_EMAIL_NOTIFICATION (	-
	JOB_NAME=>'nightly_commissions', -
	RECIPIENTS=> 'me@my_company.com,dist_list@my_company.com');