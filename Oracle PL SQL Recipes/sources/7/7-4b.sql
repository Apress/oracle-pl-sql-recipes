CREATE OR REPLACE FUNCTION calculate_date_years (in_date DATE,
                                              in_years IN NUMBER,
                                              in_months IN NUMBER DEFAULT 0)
RETURN DATE AS
  new_date    DATE;
BEGIN
  IF in_date is NULL OR in_years is NULL THEN
    RAISE NO_DATA_FOUND;
  END IF;
  new_date := ADD_MONTHS(in_date, 12 * in_years);
  -- Additional code to add the number of months to the calculated date
  IF in_months != 0 THEN
    new_date := ADD_MONTHS(new_date, in_months);
  END IF;
  RETURN new_date;
END;
/