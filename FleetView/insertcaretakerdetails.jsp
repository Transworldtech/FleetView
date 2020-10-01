<%@page import="java.util.Date"%><%@ include file="Connections/conn.jsp" %>
<%@ page buffer="16kb" %>
<%!
Connection con1;
%>
<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
String user=session.getValue("user").toString();
System.out.println("user-->"+user);
/*****GETTING PARAMETER FROM ENTRY FORM PAGE****/
String vehno=request.getParameter("vehno");
String address=request.getParameter("address");
String calender=request.getParameter("calender");
String contact=request.getParameter("contact");
String name=request.getParameter("name");
System.out.println("name-->"+name);
	String sql1="insert into t_caretakerdetails(vehno,name,address,DOB,contact,entby) values ('"+vehno+"','"+name+"','"+address+"','"+calender+"','"+contact+"','"+user+"')";
	stmt2.executeUpdate(sql1);
	String abcd=sql1.replace("'","#");
	abcd=abcd.replace(",","$");
	stmt2.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	response.sendRedirect("caretakerdetails.jsp?inserted=yes");
	return; 

} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
} 
%>