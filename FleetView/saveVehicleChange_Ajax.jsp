<%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
	String VehChange=request.getParameter("VehChange");
	String ModelChange=request.getParameter("ModelChange");
	String oldModel=request.getParameter("oldModel");
	String newModel=request.getParameter("newModel");
	String DriverChange=request.getParameter("DriverChange");
	String BrifId=request.getParameter("BrifId");
	
	System.out.println(" VehChange "+VehChange+" ModelChange "+ModelChange+" oldModel "+oldModel+" newModel "+newModel+" DriverChange "+DriverChange+" BrifId "+BrifId);
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=con1.createStatement();
	
try{	
	String str="update  db_gps.t_briefing set VehChange='"+VehChange+"' ,ModelChange='"+ModelChange+"' ,oldModel='"+oldModel+"',newModel='"+newModel+"',DriverEngChange='"+DriverChange+"' where Briefid='"+BrifId+"'" ;
	System.out.println(" Ajax db query "+str);
	stmt1.executeUpdate(str);
	out.println("true");
}catch(Exception e)
{
	out.println("false");
	System.out.println("Exception  "+e.getMessage());
}
	
	
%>
