<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Connections/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try{
Class.forName(MM_dbConn_DRIVER);
Connection con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(); 
Statement stquery=con1.createStatement(); 
%>
<%
 
String commfor=request.getParameter("commfor");
String srno=request.getParameter("srno");
String commaction=request.getParameter("commaction");
out.print(commaction);
if(commaction.equals("edit"))
{
	String comm=request.getParameter("comm");
	String sql="update tr_briefingcom set comment='"+comm+"' where srno='"+srno+"'";
	
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	
/*****************************/
	
	stmt1.executeUpdate(sql);
	response.sendRedirect("addrivbrfngcmtn.jsp?edited=successfull&commentfor="+commfor);
}
else if(commaction.equals("delete"))
{
 String	sql="delete from t_briefingcom  where srno='"+srno+"'";
 
 /*Query to insert query in db_gps.t_sqlquery table*/
	String abcd1=sql.replace("'","#");
	abcd1=abcd1.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
	
/*****************************/
 
 stmt1.executeUpdate(sql);
 response.sendRedirect("addrivbrfngcmtn.jsp?deleted=successfull&commentfor="+commfor);
}
}catch(Exception ex)
{
 out.print("Exception------->"+ex);	
}
%>
</body>
</html>