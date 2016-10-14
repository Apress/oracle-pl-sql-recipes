DECLARE
  TYPE cur_type IS REF CURSOR;
  cur                cur_type;
  null_value    CHAR(1);
  sql_string     VARCHAR2(150);
  emp_rec       employees%ROWTYPE;
BEGIN
  sql_string := 'SELECT * ' ||
                          'FROM EMPLOYEES ' ||
                       'WHERE MANAGER_ID IS :null_val';

  OPEN cur FOR sql_string USING null_value;
  LOOP
    FETCH cur INTO emp_rec;
    DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ' ' || emp_rec.last_name || 
                                                        ' - ' || emp_rec.email);
    EXIT WHEN cur%NOTFOUND;
  END LOOP;
  CLOSE cur;
 END;
/