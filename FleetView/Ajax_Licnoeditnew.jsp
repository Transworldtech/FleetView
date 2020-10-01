<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    <%@ include file="Connections/conn.jsp" %>

<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>

   
<%
try{
Class.forName(MM_dbConn_DRIVER); 
Connection conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD); 
Statement st=conn1.createStatement();
String licno12=request.getParameter("liceno1");
String driverid=request.getParameter("drid");
String own="",dir="";
if(licno12==""||licno12==null)
{
	
}
else
{
String username=(String)session.getAttribute("usertypevalue");
String sqllicno="select * from db_gps.t_drivers where licenseno ='"+licno12+"' and ACTIVESTATUS='Active' and DriverId!='"+driverid+"'" ;
System.out.println("***    "+sqllicno);
ResultSet rsck = st.executeQuery(sqllicno);
if(rsck.next())
{
	 //System.out.println("Driverid exist");
	dir=rsck.getString("DriverName");
	own=rsck.getString("Owner");
	 //System.out.println("Driverid exist");
     out.println("License is Already registered and active with  Transporter "+own+" and  driver " +dir);  

 }

}
conn1.close();
}
catch(Exception e){e.printStackTrace();}


%>