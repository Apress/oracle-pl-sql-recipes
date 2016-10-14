CREATE OR REPLACE PACKAGE ajax IS

   PROCEDURE html;
   PROCEDURE xml (ID INTEGER);

END ajax;
/

CREATE OR REPLACE PACKAGE BODY ajax IS

PROCEDURE html is

CURSOR	driver IS
SELECT	employee_id, last_name
FROM	employees
WHERE	employee_id in
(	SELECT	DISTINCT manager_id
	FROM	employees)
ORDER BY last_name;

BEGIN

   common.header ('Manager/Employee Example'); -- See recipe 14-2 for the common package.
   htp.p ('<SCRIPT LANGUAGE="JavaScript" SRC="'		||
		owa_util.get_cgi_env ('REQUEST_PROTOCOL')	|| '://'	||
		owa_util.get_cgi_env ('HTTP_HOST')		||
'/js/AjaxMgr.js"></SCRIPT>');

   htp.formOpen ('#', 'POST');
   htp.p ('Select a Manager:');
   htp.formSelectOpen ('mgr', cattributes=>'onChange="loadEmployees(this.value);"');
   htp.formSelectOption ('', 'SELECTED');

   FOR rec IN driver LOOP
      htp.formSelectOption (rec.last_name, cattributes=>'VALUE="'||rec.employee_id||'"');
   END LOOP;

   htp.formSelectClose;
   htp.br;

   htp.p ('Select a Subordinate:');
   htp.formSelectOpen ('emp', cattributes=>'ID="emp_list"');
   htp.formSelectClose;
   htp.br;

   htp.formSubmit;
   htp.formClose;
   common.footer;

END html;

PROCEDURE xml (ID INTEGER) IS

BEGIN

-- see recipe 14-11 for more information on the gen_xml procedure.
   gen_xml ('SELECT employee_id, last_name '	||
	   'FROM employees '			||
	   'WHERE manager_id = ' || ID		||
	   ' ORDER by 1');

END xml;

END ajax;
/