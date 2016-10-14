<<obtain_user_info>>
DECLARE
  username     varchar2(100);
  ip_address    varchar2(100);
BEGIN
  SELECT SYS_CONTEXT('USERENV','SESSION_USER'), SYS_CONTEXT('USERENV','IP_ADDRESS')
  INTO username, ip_address
  FROM DUAL;

  DBMS_OUTPUT.PUT_LINE('The connected user is: ' || username || ', and the IP address is ' ||
                                                      ip_address);
END;
/