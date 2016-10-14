-- Returns a date string formatted per the style
-- that is passed into it.  The possible style strings
-- are as follows:
--   LONG => The spelled out date
--   SHORT => The abbreviated date
--   STD or blank => The standard date format mm/dd/yyyy
--   DASH => The standard format with dashes mm-dd-yyyy
CREATE OR REPLACE FUNCTION FORMAT_DATE(in_date IN DATE,
                                       style IN VARCHAR2)
 RETURN VARCHAR2 AS
 formatted_date 	VARCHAR2(100);
BEGIN
  CASE style
    WHEN 'LONG' THEN 
  	formatted_date := TO_CHAR(in_date, 'DAY MONTH DDTH YYYY');
    WHEN 'SHORT' THEN
        formatted_date := TO_CHAR(in_date, 'DY MON DDTH YYYY');
    WHEN 'DASH' THEN
        formatted_date := TO_CHAR(in_date, 'MM-DD-YYYY');
    ELSE
        formatted_date := TO_CHAR(in_date, 'MM/DD/YYYY');
  END CASE;
  RETURN formatted_date;
END;
/