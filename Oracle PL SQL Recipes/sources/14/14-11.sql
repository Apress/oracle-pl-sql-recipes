CREATE OR REPLACE PROCEDURE gen_xml (sql_stmt VARCHAR2) IS

string		VARCHAR2(4000);
ipos		INTEGER;
offset		INTEGER;
n		INTEGER := 1;

qryctx		dbms_xmlgen.ctxhandle;
result		CLOB;

BEGIN

   qryctx := dbms_xmlgen.newcontext (sql_stmt);
   result := dbms_xmlgen.getxml (qryctx);
   dbms_xmlgen.closecontext (qryctx);

   owa_util.mime_header ('text/xml', true);
   LOOP
      EXIT WHEN result IS NULL;
      ipos := dbms_lob.instr (result, CHR(10), 1, n);
      EXIT WHEN ipos = 0;

      string := dbms_lob.substr (result, ipos-offset, offset);
      htp.p (string);

      offset	:= ipos + 1;
      n		:= n + 1;
   END LOOP;

   IF result IS NULL THEN
      htp.p ('<ROWSET>');
      htp.p ('</ROWSET>');
   END IF;

END gen_xml;
/