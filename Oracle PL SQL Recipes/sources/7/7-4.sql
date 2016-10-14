CREATE OR REPLACE FUNCTION calculate_date_years (in_date DATE,
                                    in_years NUMBER)
RETURN DATE AS
  new_date    DATE;
BEGIN
  IF in_date is NULL OR in_years is NULL THEN
    RAISE NO_DATA_FOUND;
  END IF;
  new_date := ADD_MONTHS(in_date, 12 * in_years);
  RETURN new_date;
END;
/