CREATE OR REPLACE PROCEDURE descr_emp IS

BEGIN

   common.header ('The Employees Table');

   IF owa_util.tablePrint (
	ctable=>'user_tab_columns',
	cattributes=>'BORDER',
	ccolumns=>'column_name, data_type, data_length, data_precision, nullable',
	cclauses=>'WHERE table_name=''EMPLOYEES'' ORDER BY column_id') then
      NULL;
   END IF;

   common.footer;

END descr_emp;
/