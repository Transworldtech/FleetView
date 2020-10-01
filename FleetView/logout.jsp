<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%@ include file="Connections/dbConn.jsp" %>
<%!
Connection con;
%>
<%
try{
String logindate=session.getAttribute("logindate").toString();
String logintime=session.getAttribute("logintime").toString();
String user=session.getAttribute("user").toString();

    java.util.Date now = new java.util.Date();
    String logoutdate=""+(now.getYear()+1900)+"-"+(1+now.getMonth())+"-"+now.getDate();
    String logouttime=""+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
	String sql="update t_loguseractivity set LogOutTime='"+logouttime+"', LogOutDate='"+logoutdate+"' where RecordDate='"+logindate+"' and RecordTime='"+logintime+"' and Comments='"+user+"'";
	String username=session.getAttribute("user").toString().toUpperCase();
	Class.forName(MM_dbConn_DRIVER); 
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement s = con.createStatement();
	Statement stquery = con.createStatement();
	
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	int i=s.executeUpdate(sql);
	String sql1="update t_sessions set ActiveStatus='No' where SessionId='"+session.getId().toString()+"'";
	
	/*Query to insert query in db_gps.t_sqlquery table*/
	/*String abcd1=sql1.replace("'","#");
	abcd1=abcd1.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");*/
	/*****************************/
	
	s.executeUpdate(sql1);
}catch(Exception e)
{
	out.print("Exception "+e);
}finally
{
	con.close();
}

session.invalidate();
response.sendRedirect("index.html");

%>
<%@ include file="footernew.jsp" %>
