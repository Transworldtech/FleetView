<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" import="moreservlets.listeners.*" errorPage="" %>

<%!
String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
String MM_dbConn_USERNAME="fleetview";
String MM_dbConn_PASSWORD="1@flv";
//String MM_dbConn_STRING="jdbc:mysql://203.199.134.128/db_gps";
//String MM_dbConn_STRING1="jdbc:mysql://203.199.134.128/db_gpsExceptions";
//String SiteRoot="http://203.199.134.128:8080/AVL/";

String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
String MM_dbConn_STRING1="jdbc:mysql://localhost/db_gpsExceptions";
String SiteRoot="http://localhost:8080/AVL/";
%>
<%

try{
 String abc=session.getAttribute("user").toString(); 
	
}catch(Exception ee)
	{
		response.sendRedirect("index.html");
		return;
	}
%>