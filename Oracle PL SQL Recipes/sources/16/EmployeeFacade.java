import java.sql.*;
import oracle.jdbc.*;

public class EmployeeFacade {
 public static void main(String[] args)
 throws SQLException {
  int ret_code;
  Connection conn = null;
  try {
    //Load Oracle driver
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    //Obtain a connection

    conn = DriverManager.getConnection("jdbc:oracle:thin:@your-host-name:port_number:mydb",
                                       "user", "password");
    int emp_id = 205;
    double increase_pct = .02;
    CallableStatement pstmt = 
    conn.prepareCall("{call increase_wage(?,?)}");
    pstmt.setInt(1, emp_id);
    pstmt.setDouble(2, increase_pct);
    pstmt.executeUpdate();

    pstmt.close();
    conn.close();
    System.out.println("Increase successful");
  } catch (SQLException e) {ret_code = e.getErrorCode(); 
    System.err.println(ret_code + e.getMessage()); conn.close();}
  }
}