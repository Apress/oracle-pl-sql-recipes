CREATE OR REPLACE PROCEDURE salary_increase(emp_id IN NUMBER,
                                            pct_increase IN NUMBER) AS
  
  salary                employees.salary%TYPE;
  max_salary            jobs.max_salary%TYPE;
  INVALID_INCREASE      EXCEPTION;
  
  
BEGIN

  SELECT salary, max_salary
  INTO salary, max_salary
  FROM employees, jobs
  WHERE employee_id = emp_id
  AND jobs.job_id = employees.employee_id;

  
  IF (salary + (salary * pct_increase)) <= max_salary THEN
    UPDATE employees
    SET salary = (salary + (salary * pct_increase))
    WHERE employee_id = emp_id;
    
    DBMS_OUTPUT.PUT_LINE('SUCCESSFUL SALARY INCREASE FOR EMPLOYEE #: ' ||
          emp_id ||
          '.  NEW SALARY = ' || salary + (salary * pct_increase));
         
  ELSE
    RAISE INVALID_INCREASE;
  END IF;
  

  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('UNSUCCESSFUL INCREASE, NO EMPLOYEE RECORD FOUND ' ||
                  'FOR THE GIVEN ID');
                  
  WHEN INVALID_INCREASE THEN
    DBMS_OUTPUT.PUT_LINE('UNSUCCESSFUL INCREASE.  YOU CANNOT INCREASE THE ' ||
                  'EMPLOYEE SALARY BY ' || pct_increase ||
                  'PERCENT...PLEASE ENTER ' ||
                  'A SMALLER INCREASE AMOUNT TO TRY AGAIN');


  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('UNSUCCESSFUL INCREASE.  AN UNCKNOWN ERROR HAS '||
                  'OCCURRED, ' ||
                  'PLEASE TRY AGAIN OR CONTACT ADMINISTRATOR' || pct_increase);

END;
/