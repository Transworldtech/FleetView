<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>

<%@ include file="Connections/dbConn.jsp" %>
<%
try{
String logindate=session.getAttribute("logindate").toString();
String logintime=session.getAttribute("logintime").toString();
String user=session.getAttribute("user").toString();

    java.util.Date now = new java.util.Date();
    String logoutdate=""+(now.getYear()+1900)+"-"+(1+now.getMonth())+"-"+now.getDate();
    String logouttime=""+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
String sql="update t_loguseractivity set LogOutTime='"+logouttime+"', LogOutDate='"+logoutdate+"' where RecordDate='"+logindate+"' and RecordTime='"+logintime+"' and Comments='"+user+"'";
Class.forName(MM_dbConn_DRIVER); 
Connection con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement s = con.createStatement();
	Statement stquery = con.createStatement();
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	
	int i=s.executeUpdate(sql);
}catch(Exception e)
{
	out.print("Exception "+e);
}

session.invalidate();
response.sendRedirect("user.jsp");

%>
<%@ include file="footernew.jsp" %>
<script language="javascript">
if(true)
window.close();
</script>
