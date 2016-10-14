CREATE OR REPLACE PACKAGE empID IS

   PROCEDURE html;
   PROCEdURE js;

END empID;
/

CREATE OR REPLACE PACKAGE BODY empID IS

PROCEDURE html is

BEGIN

   common.header ('Employee Report'); -- See recipe 14-2 for the common package.
   htp.p ('<SCRIPT LANGUAGE="JavaScript" SRC="'			||
		owa_util.get_cgi_env ('REQUEST_PROTOCOL')	|| '://'	||
		owa_util.get_cgi_env ('HTTP_HOST')		||
		owa_util.get_cgi_env ('SCRIPT_NAME')		|| '/empID.js"></SCRIPT>');

   htp.formOpen ('emp_rpt.rpt', 'POST'); -- See recipe 14-4 for the emp_rpt pacakge.
   htp.p ('Employee ID:');
   htp.formText ('emp_id', 6, 6, cattributes=>'onChange="validateNumber(this.value);"');

   htp.formSubmit;
   htp.formClose;
   common.footer; -- See recipe 14-2 for the common package.


END html;

PROCEDURE js is

BEGIN

   htp.p ('

function validateNumber (theNumber) {

   if ( isNaN (theNumber) ) {
      alert ("You must enter a number for the Employee ID");
      return false; }

   return true;

}');

END js;

END empID;
/