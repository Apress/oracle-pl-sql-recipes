CREATE OR REPLACE PROCEDURE COUNT_EMAIL_IN_TEXT(text_var     IN VARCHAR2) AS
  counter    NUMBER := 0;
  mail_pattern    VARCHAR2(15) := '\w+@\w+(\.\w+)+';
BEGIN
  counter := REGEXP_COUNT(text_var, mail_pattern);

  IF COUNTER = 1 THEN
    DBMS_OUTPUT.PUT_LINE('This passage provided contains 1 email address');
  ELSIF counter > 1 THEN
    DBMS_OUTPUT.PUT_LINE('This passage provided contains '||
                     counter || ' email addresses');
  ELSE
    DBMS_OUTPUT.PUT_LINE('This passage provided contains ' ||
            'no email addresses');
  END IF;
END;
/