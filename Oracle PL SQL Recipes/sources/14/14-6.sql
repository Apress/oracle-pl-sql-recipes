create or replace procedure job_list as

cursor	driver is
select	job_id, job_title
from	jobs
order by job_title;

begin

   common.header ('Job Title');
   htp.formSelectOpen ('id', 'Job Title: ');
   htp.formSelectOption ('', 'SELECTED');

   for rec in driver LOOP
      htp.formSelectOption (rec.job_title, cattributes=>'VALUE="' || rec.job_id || '"');
   end LOOP;

   htp.formSelectClose;
   common.footer;

end job_list;
/