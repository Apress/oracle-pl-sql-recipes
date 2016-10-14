CREATE OR REPLACE FUNCTION calculate_days(date_to_change  IN DATE,
                                          number_of_days  IN NUMBER)
RETURN DATE IS
BEGIN
  RETURN date_to_change + number_of_days;
END;
/