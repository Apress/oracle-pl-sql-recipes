CREATE OR REPLACE JAVA SOURCE NAMED "Department" AS
public class Department {
  public static int departmentId = 0; 
  public static String departmentName = null;
  public static int managerId = 0;
  public static int locationId = 0;
  
  public static void setDepartmentId(int departmentId){
    departmentId = departmentId;
  }
  
  public static int getDepartmentId(){
    return departmentId;
  }
  
  public static void setDepartmentName(String departmentName){
    departmentName = departmentName;
  }
  
  public static String getDepartmentName(){
    return departmentName;
  }
  
   public static void setManagerId(int managerId){
    managerId = managerId;
  }
  
  public static int getManagerId(){
    return managerId;
  }
  
  public static void setLocationId(int locationId){
    locationId = locationId;
  }
  
  public static int getLocationId(){
    return locationId;
  }
  
};