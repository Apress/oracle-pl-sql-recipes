CREATE OR REPLACE FUNCTION first_day_of_month(in_date DATE)
RETURN VARCHAR2 IS
BEGIN
  RETURN to_char(trunc(in_date,'MM'), 'DD-MON-YYYY');
END;
/