CREATE OR REPLACE PACKAGE input_form AS

   null_array OWA_UTIL.IDENT_ARR;

   PROCEDURE html;
   PROCEDURE submit (emp_id     VARCHAR2,
                     gender     VARCHAR2 DEFAULT NULL,
                     options    OWA_UTIL.IDENT_ARR DEFAULT null_array,
                     comments   varchar2);

END input_form;
/

CREATE OR REPLACE PACKAGE BODY input_form AS

PROCEDURE html IS

type	options_type is varray(3) of varchar2(50);
options	options_type := options_type ('I will attend the Team Meeting',
			'I will attend the social event',
			'I will attend the company tour');

BEGIN

   common.header ('Input Form');
   htp.formOpen ('input_form.submit', 'POST');

   htp.p ('Employee ID: ');
   htp.formText ('emp_id', 9, 9);
   htp.br;

   htp.p ('Gender: ');
   htp.formRadio ('gender', 'M');
   htp.p ('Male');
   htp.formRadio ('gender', 'F');
   htp.p ('Female');
   htp.br;

   FOR i IN 1..10 LOOP
      htp.formCheckBox ('options', i);
      htp.p (options(i));
      htp.br;
   END LOOP;
   htp.br;

   htp.p ('COMMENTS: ');
   htp.formTextArea ('comments', 5, 50);
   htp.br;

   htp.formSubmit;
   htp.formClose;
   common.footer;

END html;

PROCEDURE submit (emp_id     VARCHAR2,
                  gender     VARCHAR2 DEFAULT NULL,
                  options    OWA_UTIL.IDENT_ARR DEFAULT null_array,
                  comments   varchar2) is

BEGIN

   common.header ('Input Results');
   htp.bold ('You entered the following...');
   htp.br;

   htp.p ('Employee ID: ' || emp_id);
   htp.br;
   htp.p ('Gender: ' || gender);
   htp.br;
   htp.p ('Comments: ' || comments);
   htp.br;

   htp.bold ('Options Selected...');
   htp.br;
   FOR i IN 1..options.COUNT LOOP
      htp.p (options(i));
      htp.br;
   END LOOP;

   common.footer;
 
END submit;

END input_form;
/