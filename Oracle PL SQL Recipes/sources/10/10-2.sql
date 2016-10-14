SET SERVEROUT ON

DECLARE

TYPE    num_type IS TABLE OF number INDEX BY BINARY_INTEGER;
nums    num_type;
total   number;

BEGIN

   nums(1) := 127.56;
   nums(2) := 56.79;
   nums(3) := 295.34;

   -- call subroutine to process numbers;
   -- total := total_table (nums);
END; 
/