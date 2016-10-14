-- Returns the squared sum of two numbers
CREATE OR REPLACE FUNCTION squared (in_num IN NUMBER,
                                    in_num_two IN NUMBER)    RETURN NUMBER ASBEGIN  RETURN (in_num + in_num_two) * (in_num + in_num_two);  
END;