CREATE OR REPLACE PROCEDURE employee_audit AS

CURSOR	driver IS	-- find all employees not in a department
SELECT	employee_id, first_name, last_name
FROM	employees
WHERE	department_id is null
ORDER BY last_name, first_name;

buffer		CLOB := null; -- the email message

BEGIN

   FOR rec IN driver LOOP	-- generate the email message
      buffer := buffer		||
		rec.employee_id || ' '  ||
		rec.last_name	|| ', ' ||
		rec.first_name	|| chr(10);
   END LOOP;

--	Send the email
   IF buffer is not null THEN -- there are employees without a department
      buffer := 'Employees with no Department' || CHR(10) || CHR(10) || buffer;

      UTL_MAIL.SEND (
	SENDER=>'someone@mycompany.com',
	RECIPIENTS=>'audit_list@mycompany.com',
	SUBJECT=>'Employee Audit Results',
	MESSAGE=>buffer);
   END IF;

END;
/