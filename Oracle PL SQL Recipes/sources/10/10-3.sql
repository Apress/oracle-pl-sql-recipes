SET SERVEROUT ON

DECLARE

TYPE    rec_type IS RECORD (
                last_name       varchar2(25),
                department      varchar2(30),
                salary          number );
rec     rec_type;

begin

   rec.last_name        := 'Juno';
   rec.department       := 'IT';
   rec.salary           := '5000';

END;
/