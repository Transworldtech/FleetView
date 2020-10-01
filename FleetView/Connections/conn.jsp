<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" import="moreservlets.listeners.*" errorPage="" %>
<%!
/*
String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
String MM_dbConn_USERNAME="fleetview";
String MM_dbConn_PASSWORD="1@flv";
String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
String MM_dbConn_STRING1="jdbc:mysql://localhost/db_gpsExceptions";
String MM_dbConn_STRING3="jdbc:mysql://localhost/db_CustomerComplaints";
String SiteRoot="http://localhost:8080/AVL/";
*/

String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
String MM_dbConn_USERNAME="fleetview";
String MM_dbConn_PASSWORD="1@flv";
String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
String MM_dbConn_STRING1="jdbc:mysql://localhost/db_gpsExceptions";
String MM_dbConn_STRING3="jdbc:mysql://localhost/db_CustomerComplaints";
String SiteRoot="http://localhost:8080/AVL/";

%>
<%
	try
	{
		String us=session.getAttribute("user").toString();
	}
	catch(Exception e)
	{
		response.sendRedirect("index.html");
		return;
	}
%>
