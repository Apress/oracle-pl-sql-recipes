CREATE OR REPLACE PACKAGE sorted AS

   PROCEDURE html;
   PROCEDURE rpt (sort_order VARCHAR2);

END sorted;
/

CREATE OR REPLACE PACKAGE BODY sorted AS

PROCEDURE html IS

BEGIN

   common.header ('Sorted Report');
   htp.formOpen ('sorted.rpt', 'POST');
   htp.formSelectOpen ('sort_order', 'Select a Sort Order: ');
   htp.formSelectOption ('Last Name');
   htp.formSelectOption ('Hire Date');
   htp.formSelectOption ('Salary');
   htp.formSelectOption ('Employee ID');
   htp.formSelectClose;
   htp.formSubmit;
   htp.formClose;
   common.footer; 
END html;

PROCEDURE rpt (sort_order VARCHAR2) IS

CURSOR	driver IS
SELECT	*
FROM	employees
ORDER BY DECODE (sort_order,
		'Last Name',   last_name,
		'Hire Date',   TO_CHAR (hire_date, 'YYYYMMDD'),
		'Salary',      TO_CHAR (salary, '00000'),
		'Employee ID', TO_CHAR (employee_id, '00000') );

BEGIN

   common.header ('Sorted Report by '||sort_order); -- See recipe 14-2.
   htp.tableOpen ('BORDER');
   htp.tableRowOpen ('LEFT', 'BOTTOM');
   htp.tableHeader ('Name');
   htp.tableHeader ('Hired');
   htp.tableHeader ('Salary');
   htp.tableHeader ('ID');
   htp.tableRowClose;

   FOR rec IN driver LOOP
      htp.tableRowOpen ('LEFT', 'TOP');
      htp.tableData (rec.last_name);
      htp.tableData (rec.hire_date);
      htp.tableData (rec.salary);
      htp.tableData (rec.employee_id);
      htp.tableRowClose;
   END LOOP;

   htp.tableClose;
   common.footer;

END rpt;

END sorted;
/