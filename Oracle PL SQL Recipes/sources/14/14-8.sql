CREATE OR REPLACE PACKAGE multi AS

   PROCEDURE page1;
   PROCEDURE page2 (var1 varchar2);
   PROCEDURE page3 (var1 varchar2, var2 varchar2);
   PROCEDURE process (var1 varchar2, var2 varchar2, var3 varchar2);

END multi;
/

CREATE OR REPLACE PACKAGE BODY multi AS

PROCEDURE page1 IS

begin

   htp.formOpen ('multi.page2', 'POST');
   htp.p ('Enter First Value:');
   htp.formText ('var1', 10, 10);
   htp.formSubmit;
   htp.formClose;

END page1;

PROCEDURE page2 (var1 VARCHAR2) IS

begin

   htp.formOpen ('multi.page3', 'POST');
   htp.formHidden ('var1', var1);
   htp.p ('Enter Second Value:');
   htp.formText ('var2', 10, 10);
   htp.formSubmit;
   htp.formClose;

END page2;

PROCEDURE page3 (var1 VARCHAR2, var2 VARCHAR2) IS

begin

   htp.formOpen ('multi.process', 'POST');
   htp.formHidden ('var1', var1);
   htp.formHidden ('var2', var2);
   htp.p ('Enter Third Value:');
   htp.formText ('var3', 10, 10);
   htp.formSubmit;
   htp.formClose;

END page3;

PROCEDURE process (var1 varchar2, var2 varchar2, var3 varchar2) is

BEGIN

  htp.p ('The three variables entered are...');
  htp.br;

  htp.p ('1=' || var1);
  htp.br;
  htp.p ('2=' || var2);
  htp.br;
  htp.p ('3=' || var3);

END process;

END multi;
/