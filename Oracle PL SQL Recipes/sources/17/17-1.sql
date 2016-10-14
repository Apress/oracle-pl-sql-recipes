CREATE OR REPLACE
FUNCTION CALC_QUARTER_HOUR(HOURS IN NUMBER) RETURN NUMBER AS
  CALCULATED_HOURS NUMBER := 0;
BEGIN

   -- if HOURS is greater than one, then calculate the decimal portion
  -- based upon quarterly hours
 IF HOURS > 1 THEN
  -- calculate the modulus of the HOURS variable and compare it to
  DBMS_OUTPUT.Put_LINE('The value passed in was greater than one hour...');
  -- fractional values
    IF MOD(HOURS, 1) <=.125 THEN
       DBMS_OUTPUT.Put_LINE('The decimal portion < .125');
       CALCULATED_HOURS := substr(to_char(HOURS),0,1);
    ELSIF MOD(HOURS, 1) > .125 AND MOD(HOURS,1) <= .375 THEN
       DBMS_OUTPUT.Put_LINE('The decimal portion <= .375');
       CALCULATED_HOURS := substr(to_char(HOURS),0,1) + MOD(.25,1);
    ELSIF MOD(HOURS, 1) > .375 AND MOD(HOURS,1) <= .625 THEN
       DBMS_OUTPUT.Put_LINE('The decimal portion <= .625');
       CALCULATED_HOURS := substr(to_char(HOURS),0,1) + MOD(.50,1);
    ELSIF MOD(HOURS, 1) > .63 AND MOD(HOURS,1) <= .825 THEN
       DBMS_OUTPUT.Put_LINE('The decimal portion <= .825');
       CALCULATED_HOURS := SUBSTR(TO_CHAR(HOURS),0,1) + MOD(.75,1);
    ELSIF MOD(HOURS, 1) > .825 AND MOD(HOURS,1) <= .999 THEN
       DBMS_OUTPUT.Put_LINE('The decimal portion <= .999');
       CALCULATED_HOURS := (substr(to_char(HOURS),0,1) + 1) + MOD(.00,1);
    ELSE
       DBMS_OUTPUT.Put_LINE('The hours passed in will use standard rounding');
       CALCULATED_HOURS := ROUND(HOURS,1);

    END IF;

  ELSE
    -- if HOURS is less than one, then calculate the entire value
    DBMS_OUTPUT.Put_LINE('Less than 1 hour was passed in...');
    -- based upon quarterly hours
    IF HOURS > 0 AND HOURS <=.375 THEN
        DBMS_OUTPUT.Put_LINE('The decimal portion < .125');
        CALCULATED_HOURS := .25;
    ELSIF HOURS > .375 AND HOURS <= .625 THEN
        DBMS_OUTPUT.Put_LINE('The decimal portion <= .625');
        CALCULATED_HOURS := .5;
    ELSIF HOURS > .625 AND HOURS <= .825 THEN
        DBMS_OUTPUT.Put_LINE('The decimal portion <= .825');
        CALCULATED_HOURS := .75;
    ELSIF HOURS > .825 AND HOURS <= .999 THEN
        DBMS_OUTPUT.Put_LINE('The decimal portion <= .999');
        CALCULATED_HOURS := 1;
    ELSE
        DBMS_OUTPUT.Put_LINE('The hours passed in will use standard rounding');
        CALCULATED_HOURS := ROUND(HOURS,1);
    END IF;

  END IF;

  RETURN CALCULATED_HOURS;

END CALC_QUARTER_HOUR;
/