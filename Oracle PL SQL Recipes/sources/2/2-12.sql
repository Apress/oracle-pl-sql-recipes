DECLARE
   daily_atm_total   NUMBER(12,2);
   weekly_atm_total  NUMBER(12,2); 
BEGIN
   COMMIT; -- ends previous transaction
   SET TRANSACTION READ ONLY NAME 'ATM Weekly Summary';
   SELECT SUM (wd_amt) INTO daily_atm_total FROM atm_withdrawals
     WHERE to_char(wd_date, 'MM-DD-YYYY') = to_char(SYSDATE, 'MM-DD-YYYY');
   SELECT SUM (weekly_total) INTO weekly_atm_total FROM atm_withdrawals
     WHERE to_char(wd_date, 'MM-DD-YYYY') = to_char(SYSDATE - 7, 'MM-DD-YYYY');
   DBMS_OUTPUT.PUT_LINE(daily_atm_total || ' - ' || weekly_atm_total); 
   COMMIT; -- ends read-only transaction
   
END;
/