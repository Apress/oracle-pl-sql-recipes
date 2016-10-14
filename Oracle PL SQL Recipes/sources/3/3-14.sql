DECLARE
  in_number    number := 0;
BEGIN
    
    in_number := '&input_number';
    IF in_number > 10 THEN
      DBMS_OUTPUT.PUT_LINE('The number you entered is greater than ten');
      GOTO end_msg;
    ELSIF in_number <= 10 and in_number > 0 THEN
      DBMS_OUTPUT.PUT_LINE('The number you entered is less than or equal to ten');
      GOTO end_msg;
    ELSE
      -- Entered a negative number
      GOTO bad_input;
    END IF;

    << bad_input >>
    DBMS_OUTPUT.PUT_LINE('Invalid input.  No negatives allowed.');

    << end_msg >>
    DBMS_OUTPUT.PUT_LINE('Thank you for playing..');

END;     
/