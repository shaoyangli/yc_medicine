package com.kh.util;
import java.sql.DriverManager;
import java.util.Properties;
import java.io.InputStream;
import java.sql.Connection;
@SuppressWarnings("unchecked")
public class DBConnection {
   private static String CONFIG_FILENAME = "config.properties"; //配置文件名,应置于classes目录下
  // private String Driver = "";
   private String url= "";
   private String user="";
   private String password="";
   private Properties prop = null;
   public static  Connection con = null;
   public DBConnection() {

   }

   public boolean openConnect(){
	   try {
		   prop = new Properties();
           InputStream in =
           DBConnection.class.getResourceAsStream("/" + CONFIG_FILENAME);
           prop.load(in);
           String myDriver=prop.getProperty("DataBaseDrivers").trim();
           Class.forName(myDriver).newInstance();  //加载驱动
           url=getDBURL();                         //得到URL
           user = prop.getProperty("DataBaseUser");//用户
           password = prop.getProperty("DataBaseUserPassword");//口令
           con = DriverManager.getConnection(url,user,password);
           return true;
       } catch (Exception e) {
    	   e.printStackTrace();
           return false;
       }
   }
   //===得到url
   public String getDBURL() {
        if (prop.getProperty("DataBaseType").equals("oracle")) {
            return "jdbc:oracle:thin:@" +
                    prop.getProperty("DataBaseServerName") + ":" +
                    prop.getProperty("DataBaseServerPort") + ":" +
                    prop.getProperty("DataBaseName");

     }
        return url;

    }

   /**
    * method to get connection
    * @return Connection
    */
   public static Connection getConnection(){
       return con;
   }
   /**
    * method to close connection
    * @return boolean
    */
   public   void  closeConnection(){
	   if(con!=null){
       try{ 
           con.close();
           
       }catch(Exception e){
    	   System.out.println(e.getMessage());
       
       }
       con=null;
	   }
	  
       
    }
    public static void main(String[] args) throws Exception{
//         DBConnection op = new DBConnection();
//       if(op.openConnect()){
//       System.out.println("sucess");   
//       System.out.println(op.getConnection());
//       }else{System.out.println("333");}
//       if(op.getConnection()!=null){
//    	   System.out.println("============");
//       }
    }
}
