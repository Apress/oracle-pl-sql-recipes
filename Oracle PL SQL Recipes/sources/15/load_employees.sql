CREATE OR REPLACE JAVA SOURCE NAMED "Employees" AS
import java.sql.*;
import java.math.BigDecimal;
import oracle.jdbc.*;
import oracle.sql.*;
import oracle.oracore.*;
import oracle.jdbc2.*;

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
  
  public static void employeeAudit(int empId){
      try {
           Connection conn = DriverManager.
                        getConnection("jdbc:default:connection:");
           String sql = "INSERT INTO EMPLOYEE_AUDIT_LOG VALUES(" +
	                "?, sysdate)";
           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, empId);
           pstmt.executeUpdate();
	   pstmt.close();
	   conn.commit();
	  
	  } catch (SQLException ex){
		  System.err.println("ERROR: " + ex);
          }
	  
	  
  }
  
  public static String getEmpDepartment(oracle.sql.STRUCT emp) {
    
    String deptName = null;
    BigDecimal employeeId = null;
    try {
          Object[] attribs = emp.getAttributes();
	   // Use indexes to grab individual attributes.
	   Object empId = attribs[0];
	   try{
	       employeeId = (BigDecimal) empId;
	   } catch (ClassCastException cce) {
	       System.out.println(cce);
	   }
	   Connection conn = DriverManager.
                        getConnection("jdbc:default:connection:");
           String sql = "SELECT DEPARTMENT_NAME " + 
                        "FROM DEPARTMENTS DEPT, " +
			"EMPLOYEES EMP " +
                        "WHERE EMP.EMPLOYEE_ID = ? " +
			"AND DEPT.DEPARTMENT_ID = EMP.DEPARTMENT_ID";

           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, employeeId.intValue());
           ResultSet rset = pstmt.executeQuery();
           while(rset.next()) {
             deptName = rset.getString(1);
           }
           pstmt.close();
           rset.close();
	  } catch (java.sql.SQLException ex){
		  System.err.println("ERROR: " + ex);
		  deptName = "N/A";
          }
	  if (deptName == null){
	    deptName = "N/A";
	  }
	  return deptName;
  }
    
    
};