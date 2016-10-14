BEGIN
   DBMS_SCHEDULER.CREATE_CHAIN (
	CHAIN_NAME	=> 'Chain1');
END;
/

-- Create/define the program to run in each step
BEGIN
   DBMS_SCHEDULER.CREATE_PROGRAM (
	PROGRAM_NAME	=> 'Program1',  
	PROGRAM_TYPE	=> 'STORED_PROCEDURE',  
	PROGRAM_ACTION	=> 'Procedure1',
	ENABLED		=> true);
END;
/

BEGIN
   DBMS_SCHEDULER.CREATE_PROGRAM (
	PROGRAM_NAME	=> 'Program2',  
	PROGRAM_TYPE	=> 'STORED_PROCEDURE',  
	PROGRAM_ACTION	=> 'Procedure2',
	ENABLED		=> true);
END;
/

BEGIN
   DBMS_SCHEDULER.CREATE_PROGRAM (
	PROGRAM_NAME	=> 'Program3',  
	PROGRAM_TYPE	=> 'STORED_PROCEDURE',  
	PROGRAM_ACTION	=> 'Procedure3',
	ENABLED		=> true);
END;
/

BEGIN
   DBMS_SCHEDULER.CREATE_PROGRAM (
	PROGRAM_NAME	=> 'Program4',  
	PROGRAM_TYPE	=> 'STORED_PROCEDURE',  
	PROGRAM_ACTION	=> 'Procedure4',
	ENABLED		=> true);
END;
/

-- Create each step using a unique name
BEGIN
   DBMS_SCHEDULER.DEFINE_CHAIN_STEP (
	CHAIN_NAME	=> 'Chain1',  
	STEP_NAME	=> 'Step1',  
	PROGRAM_NAME	=> 'Program1');
END;
/

BEGIN
   DBMS_SCHEDULER.DEFINE_CHAIN_STEP (
	CHAIN_NAME	=> 'Chain1',  
	STEP_NAME	=> 'Step2_1',  
	PROGRAM_NAME	=> 'Program2');
END;
/

BEGIN
   DBMS_SCHEDULER.DEFINE_CHAIN_STEP (
	CHAIN_NAME	=> 'Chain1',  
	STEP_NAME	=> 'Step2_2',  
	PROGRAM_NAME	=> 'Program3');
END;
/

BEGIN
   DBMS_SCHEDULER.DEFINE_CHAIN_STEP (
	CHAIN_NAME	=> 'Chain1',  
	STEP_NAME	=> 'Step3',  
	PROGRAM_NAME	=> 'Program4');
END;
/

-- Define the step rules; which step runs first and their order
BEGIN
   DBMS_SCHEDULER.DEFINE_CHAIN_RULE (
	CHAIN_NAME	=> 'Chain1',
	CONDITION	=> 'TRUE',
	ACTION		=> 'START Step1');

END;
/

BEGIN
   DBMS_SCHEDULER.DEFINE_CHAIN_RULE (
	CHAIN_NAME	=> 'Chain1',
	CONDITION	=> 'Step1 COMPLETED',
	ACTION		=> 'START Step2_1, Step2_2');
END;
/

BEGIN
   DBMS_SCHEDULER.DEFINE_CHAIN_RULE (
	CHAIN_NAME	=> 'Chain1',
	CONDITION	=> 'Step2_1 COMPLETED AND Step2_2 COMPLETED',
	ACTION		=> 'START Step3');
END;
/

BEGIN
   DBMS_SCHEDULER.DEFINE_CHAIN_RULE (
	CHAIN_NAME	=> 'Chain1',
	CONDITION	=> 'Step3 COMPLETED',
	ACTION		=> 'END');
END;
/

-- Enable the chain
BEGIN
   DBMS_SCHEDULER.ENABLE ('Chain1');
END;
/

-- Schedule a Job to run the chain every night
BEGIN
   DBMS_SCHEDULE.CREATE_JOB (
	JOB_NAME		=> 'chain1_Job',
	JOB_TYPE		=> 'CHAIN',
	JOB_ACTION		=> 'Chain1',
	REPEAT_INTERVAL		=> 'freq=daily;byhour=3;byminute=0;bysecond=0',
	enabled			=> TRUE);
END;
/