BEGIN

DBMS_SHARED_POOL.KEEP (
   Name => 'my_large_procedure', 
   flag => 'P');

END;
/