package com.fleetview.beans;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Connectionclass {
	Connection con;
	Statement stmt,ps;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public  static Connection getConnection() {

		try
		{
			
			String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
			String MM_dbConn_USERNAME="fleetview";
			String MM_dbConn_PASSWORD="1@flv";
			String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps?zeroDateTimeBehavior=convertToNull";
			Class.forName(MM_dbConn_DRIVER);
			return(DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD));
		
			
			
		}
			   
     catch ( ClassNotFoundException cnfex )           

     {
           cnfex.printStackTrace();
     }

     

     catch ( Exception excp )

     {
           excp.printStackTrace();
         
     
		
	}   
	return null; 
	}
		
	
		
		// TODO Auto-generated constructor stub
	}


