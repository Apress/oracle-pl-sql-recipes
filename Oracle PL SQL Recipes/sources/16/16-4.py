from __future__ import with_statement
from com.ziclix.python.sql import zxJDBC

# for example
jdbc_url = "jdbc:oracle:thin:@your-host:port_number:database"
username = "user"
password = "password"
driver = "oracle.jdbc.driver.OracleDriver"

# obtain a connection using the with-statment
with zxJDBC.connect(jdbc_url, username, password, driver) as conn:
    with conn:
        with conn.cursor() as c:
            c.callproc('increase_wage',[199,.03,10000])
            conn.commit()