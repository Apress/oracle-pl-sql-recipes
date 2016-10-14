DECLARE             
   first	VARCHAR2(20);
   last         VARCHAR2(25);
 BEGIN
  SELECT first_name, last_name
  INTO first, last
  FROM employees
  WHERE email = 'VJONES';
  DBMS_OUTPUT.PUT_LINE('The following employee matches your query:');
  DBMS_OUTPUT.PUT_LINE(first || ' ' || last);
 END;
 /
