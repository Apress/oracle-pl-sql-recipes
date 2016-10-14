CREATE OR REPLACE PROCEDURE obtain_job_info(min_sal  NUMBER DEFAULT 0,
                                            max_sal  NUMBER DEFAULT 0)
AS
  sql_text      VARCHAR2(1000);
  TYPE job_tab IS TABLE OF jobs%ROWTYPE;

  job_list      job_tab;

  job_elem     jobs%ROWTYPE;

  max_sal_temp  NUMBER;

  filter_flag   BOOLEAN := FALSE;
  cursor_var    NUMBER;
  TYPE          cur_type IS REF CURSOR;
  cur           cur_type;
BEGIN
  sql_text := 'SELECT * ' ||
              'FROM JOBS WHERE ' ||
              'min_salary >= :min_sal ' ||
              'and max_salary <= :max_sal';


  
  IF max_sal = 0 THEN
    SELECT max(max_salary)
    INTO max_sal_temp
    FROM JOBS;
  ELSE
    max_sal_temp := max_sal;
  END IF;

  OPEN cur FOR sql_text USING min_sal, max_sal_temp;
  FETCH cur BULK COLLECT INTO job_list;
  CLOSE cur;

  FOR i IN job_list.FIRST .. job_list.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(job_list(i).job_id || ' - ' || job_list(i).job_title);
  END LOOP;

END;
/