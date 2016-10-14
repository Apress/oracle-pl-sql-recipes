CREATE OR replace PROCEDURE Salary_increase(emp_id       IN NUMBER, 
                                            pct_increase IN NUMBER) 
AS 
  salary       employees.salary%TYPE; 
  max_salary   jobs.max_salary%TYPE; 
  invalid_increase EXCEPTION; 
  error_number NUMBER; 
  error_message   VARCHAR2(150); 
BEGIN 
  SELECT salary, 
         max_salary 
  INTO   salary, max_salary 
  FROM   employees, 
         jobs 
  WHERE  employee_id = emp_id 
         AND jobs.job_id = employees.employee_id; 

  IF ( salary + ( salary * pct_increase ) ) <= max_salary THEN 
    UPDATE employees 
    SET    salary = ( salary + ( salary * pct_increase ) ) 
    WHERE  employee_id = emp_id; 

    dbms_output.Put_line('SUCCESSFUL SALARY INCREASE FOR EMPLOYEE #: ' 
                         || emp_id 
                         || '.  NEW SALARY = ' 
                         || salary + ( salary * pct_increase )); 
  ELSE 
    RAISE invalid_increase; 
  END IF; 
EXCEPTION 
  WHEN no_data_found THEN 
dbms_output.Put_line('UNSUCCESSFUL INCREASE, NO EMPLOYEE RECORD FOUND FOR THE ' 
                     || 'GIVEN ID'); WHEN invalid_increase THEN 
dbms_output.Put_line('UNSUCCESSFUL INCREASE.  YOU CANNOT INCREASE THE EMPLOYEE ' 
                     || 'SALARY BY ' 
                     || pct_increase 
                     || ' PERCENT...PLEASE ENTER ' 
                     || 'A SMALLER INCREASE AMOUNT TO TRY AGAIN'); 
WHEN OTHERS THEN 
           error_number := SQLCODE; 

           error_message := Substr(sqlerrm, 1, 150); 

dbms_output.Put_line('UNSUCCESSFUL INCREASE.  AN UNKNOWN ERROR HAS OCCURRED, ' 
                     || 'PLEASE TRY AGAIN OR CONTACT ADMINISTRATOR' 
                     || ' Error #: ' 
                     || error_number 
                     || ' - ' 
                     || error_message); 
END; 
/