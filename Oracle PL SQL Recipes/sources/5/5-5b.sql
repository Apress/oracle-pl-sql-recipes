CREATE OR REPLACE PROCEDURE send_email(to_address IN VARCHAR2,
 					       Subject IN VARCHAR2,
					       Message IN VARCHAR2) AS
BEGIN
   UTL_MAIL.send(sender => 'me@address.com',
            recipients => to_address,
               subject => subject,
               message => message,
             mime_type => 'text; charset=us-ascii');
END;
/