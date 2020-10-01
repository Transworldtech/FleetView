<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import=" java.text.*" errorPage="" %>
<%!
Connection getDattabase;
Statement getStatement;
 %>
<%
try{
Class.forName("org.gjt.mm.mysql.Driver");
 getDattabase= DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
 getStatement=getDattabase.createStatement();
}catch(Exception e)
{
	out.print("Exception "+e);
}
%>
