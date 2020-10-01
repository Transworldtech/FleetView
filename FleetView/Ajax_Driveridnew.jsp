<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    <%@ include file="Connections/conn.jsp" %>

<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>

   
<%
try{
Class.forName(MM_dbConn_DRIVER); 
Connection conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD); 
Statement st=conn1.createStatement();
String driverid1=request.getParameter("driverid");
if(driverid1==""||driverid1==null)
{
	
}
else
{
String username=(String)session.getAttribute("usertypevalue");
String sqlck="select * from db_gps.t_drivers where Owner='"+username+"' and DriverID='"+driverid1+"'";
System.out.println("***    "+sqlck);
ResultSet rsck = st.executeQuery(sqlck);
if(rsck.next())
{
	 //System.out.println("Driverid exist");
     out.println("DriverId Already Exists");
     

 }

}
conn1.close();
}
catch(Exception e){e.printStackTrace();}


%>