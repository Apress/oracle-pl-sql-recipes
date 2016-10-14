CREATE OR REPLACE PACKAGE empData AS

type    emps_type is table of employees%ROWTYPE INDEX BY BINARY_INTEGER;

FUNCTION get_emp_data RETURN emps_type;

END empData;
/

CREATE OR REPLACE PACKAGE BODY empData as

FUNCTION get_emp_data RETURN emps_type is

cursor  driver is
select  *
from    employees
order by last_name, first_name;

recs    emps_type;

begin

   open driver;
   FETCH driver BULK COLLECT INTO recs;
   close driver;

   return recs;

end get_emp_data;

end empData;
/

declare

emp_recs empData.emps_type;

begin

   emp_recs := empData.get_emp_data;
   dbms_output.put_line ('Employee Records: ' || emp_recs.COUNT);

END; 
/