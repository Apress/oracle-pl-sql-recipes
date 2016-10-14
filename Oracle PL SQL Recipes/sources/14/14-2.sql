CREATE OR REPLACE PACKAGE common AS

   PROCEDURE header (title VARCHAR2);
   PROCEDURE footer;

END common;
/

CREATE OR REPLACE PACKAGE BODY common AS

PROCEDURE header (title VARCHAR2) IS

BEGIN

   htp.p ('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" ' ||
          '"http://www.w3.org/TR/REC-html40/loose.dtd">');
   htp.htmlOpen;
   htp.headOpen;
   htp.meta ('Content-Type', null, 'text/html;' ||
              owa_util.get_cgi_env('REQUEST_IANA_CHARSET') );
   htp.meta ('Pragma', null, 'no-cache');
   htp.Title (title);
   htp.headClose;
   htp.bodyOpen;
   htp.header (2, title);

END HEADER;

PROCEDURE footer IS

BEGIN

-- This is a great place to add legal disclaimers, about us, contact us, etc. links
   htp.hr;  -- horizontal line
   htp.anchor ('http://www.mynode.com/legal_statement.html', 'Disclaimer');
   htp.anchor ('http://www.mynode.com/About.html', 'About Us');
   htp.bodyClose;
   htp.htmlClose;

END footer;

END common;
/

create or replace procedure test as
begin
   common.header ('Test Page');
   htp.p ('Hello World!');
   common.footer;
end;
/