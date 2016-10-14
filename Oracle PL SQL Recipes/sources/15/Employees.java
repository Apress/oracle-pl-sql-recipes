import java.sql.*;
import oracle.jdbc.*;

public class Employees {
  public static void getItEmps(){
      String firstName = null;
      String lastName = null;
      String email = null;
      try {
           Connection conn = DriverManager.
                        getConnection("jdbc:default:connection:");
           String sql = "SELECT FIRST_NAME, LAST_NAME, EMAIL " + 
                        "FROM EMPLOYEES " +
                        "WHERE DEPARTMENT_ID = 60";

           PreparedStatement pstmt = conn.prepareStatement(sql);
           ResultSet rset = pstmt.executeQuery();
           while(rset.next()) {
             firstName = rset.getString(1);
             lastName = rset.getString(2);
             email = rset.getString(3);
             System.out.println(firstName + " " + lastName + " " +
                                email);
           }
           pstmt.close();
           rset.close();
	  } catch (SQLException ex){
		  System.err.println("ERROR: " + ex);
	  }
  }    
      
  public static void getItEmpsByDept(int departmentId){
      String firstName = null;
      String lastName = null;
      String email = null;
      try {
           Connection conn = DriverManager.
                        getConnection("jdbc:default:connection:");
           String sql = "SELECT FIRST_NAME, LAST_NAME, EMAIL " + 
                        "FROM EMPLOYEES " +
                        "WHERE DEPARTMENT_ID = ?";

           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, departmentId);
           ResultSet rset = pstmt.executeQuery();
           while(rset.next()) {
             firstName = rset.getString(1);
             lastName = rset.getString(2);
             email = rset.getString(3);
             System.out.println(firstName + " " + lastName + " " +
                                email);
           }
           pstmt.close();
           rset.close();
	  } catch (SQLException ex){
		  System.err.println("ERROR: " + ex);
          }
  }
  
  public static String getEmpJobTitle(int empId){
      String jobTitle = null;
      try {
           Connection conn = DriverManager.
                        getConnection("jdbc:default:connection:");
           String sql = "SELECT JOB_TITLE " + 
                        "FROM EMPLOYEES EMP, " +
			"JOBS JOBS " +
                        "WHERE EMP.EMPLOYEE_ID = ? " +
			"AND JOBS.JOB_ID = EMP.JOB_ID";

           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, empId);
           ResultSet rset = pstmt.executeQuery();
           while(rset.next()) {
             jobTitle = rset.getString(1);
           }
           pstmt.close();
           rset.close();
	  } catch (SQLException ex){
		  System.err.println("ERROR: " + ex);
		  jobTitle = "N/A";
          }
	  if (jobTitle == null){
	    jobTitle = "N/A";
	  }
	  return jobTitle;
  }
  
public static void generateSalary(int jobId, int empId){
    int jobSalary = 0;
      try {
           Connection conn = DriverManager.
                        getConnection("jdbc:default:connection:");
           String sql = "SELECT MIN_SALARY " +
	                "FROM JOBS " +
                        "WHERE JOB_ID = ? ";

           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, jobId);
           ResultSet rset = pstmt.executeQuery();
           while(rset.next()) {
             jobSalary = rset.getInt(1);
           }
           
           rset.close();
	   
	  String upd = "UPDATE employees " +
	               "SET SALARY = ? " +
		       "WHERE EMPLOYEE_ID = ?";
		       
	  pstmt = conn.prepareStatement(upd);
	  pstmt.setInt(1, jobSalary);
	  pstmt.setInt(2, empId);
	  pstmt.executeUpdate();
	  
	  pstmt.close();
	  
	  } catch (SQLException ex){
		  System.err.println("ERROR: " + ex);
		  jobSalary = 0;
          }
	  
	  
  }
};