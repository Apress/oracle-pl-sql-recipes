CREATE OR REPLACE FUNCTION CALC_QUARTER_HOUR(HOURS IN NUMBER) RETURN NUMBER AS   CALCULATED_HOURS NUMBER := 0;BEGIN    -- if HOURS is greater than one, then calculate the decimal portion  -- based upon quarterly hours  IF HOURS > 1 THEN  -- calculate the modulus of the HOURS variable and compare it to   -- fractional values    IF MOD(HOURS, 1) <=.125 THEN       CALCULATED_HOURS := substr(to_char(HOURS),0,1);    ELSIF MOD(HOURS, 1) > .125 AND MOD(HOURS,1) <= .375 THEN       CALCULATED_HOURS := substr(to_char(HOURS),0,1) + MOD(.25,1);    ELSIF MOD(HOURS, 1) > .375 AND MOD(HOURS,1) <= .625 THEN       CALCULATED_HOURS := substr(to_char(HOURS),0,1) + MOD(.50,1);    ELSIF MOD(HOURS, 1) > .63 AND MOD(HOURS,1) <= .825 THEN       CALCULATED_HOURS := substr(to_char(HOURS),0,1) + MOD(.75,1);    ELSE       CALCULATED_HOURS := ROUND(HOURS,1);          END IF;      ELSE    -- if HOURS is less than one, then calculate the entire value    -- based upon quarterly hours    IF HOURS > 0 AND HOURS <=.375 THEN        CALCULATED_HOURS := .25;    ELSIF HOURS > .375 AND HOURS <= .625 THEN        CALCULATED_HOURS := .5;    ELSIF HOURS > .625 AND HOURS <= .825 THEN        CALCULATED_HOURS := .75;    ELSE        CALCULATED_HOURS := ROUND(HOURS,1);    END IF;      END IF;    RETURN CALCULATED_HOURS;

EXCEPTION
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('VALUE ERROR RAISED, TRY AGAIN');
    RETURN -1;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('UNK ERROR RAISED, TRY AGAIN');
    RETURN -1;END CALC_QUARTER_HOUR;/