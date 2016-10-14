CREATE OR REPLACE PACKAGE emp_rpt AS

   PROCEDURE html;
   PROCEDURE rpt (emp_id VARCHAR2);

END emp_rpt;
/

CREATE OR REPLACE PACKAGE BODY emp_rpt AS

PROCEDURE html IS

BEGIN

   common.header ('Employee Report');
   htp.formOpen ('emp_rpt.rpt', 'POST');
   htp.p ('Employee ID:');
   htp.formText ('emp_id', 6, 6);
   htp.formSubmit;
   htp.formClose;
   common.footer;  -- See recipe 14-2 for the common package.


END html;

PROCEDURE show_row (label VARCHAR2, value VARCHAR2) IS

BEGIN

   htp.tableRowOpen ('LEFT', 'TOP');
   htp.tableHeader (label, 'RIGHT');
   htp.tableData (value);
   htp.tableRowClose;

END show_row;

PROCEDURE rpt (emp_id VARCHAR2) IS

CURSOR	driver IS
SELECT	*
FROM	employees
WHERE	employee_id = emp_id;

rec		driver%ROWTYPE;
rec_found	BOOLEAN;

BEGIN

   common.header ('Employee Report');
 
   OPEN driver;
   FETCH driver INTO rec;
   rec_found := driver%FOUND;
   CLOSE driver;

   IF rec_found THEN
      htp.tableOpen;
      show_row ('Employee ID', rec.employee_id);
      show_row ('First Name', rec.first_name);
      show_row ('Last Name', rec.last_name);
      show_row ('Email', rec.email);
      show_row ('Phone', rec.phone_number);
      show_row ('Hire Date', rec.hire_date);
      show_row ('Salary', rec.salary);
      show_row ('Commission %', rec.commission_pct);
      htp.tableClose;
   ELSE
      htp.header (3, 'No such employee ID ' || emp_id);
   END IF;

   common.footer; -- See recipe 14-2 for the common package.

EXCEPTION
   WHEN OTHERS THEN
   htp.header (3, 'Invalid employee ID. Click your browser''s back button and try again.');
   common.footer;

END rpt;

END emp_rpt;
/