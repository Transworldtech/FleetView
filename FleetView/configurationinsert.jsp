<%@ include file="Connections/conn.jsp" %>
<%@page import="java.text.SimpleDateFormat" %>
<%
Connection con1=null;

try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement(), stmt2=con1.createStatement();

String name,emailid,mobileno,extraemails,category="";

name=request.getParameter("username");
mobileno=request.getParameter("mobilenumber");
emailid=request.getParameter("email");
extraemails=request.getParameter("extraemails");
System.out.println("----------------------------------------------***********************"+request.getParameter("action"));
System.out.println(name+mobileno+emailid+extraemails);
if(session.getAttribute("TypeofUser").toString().equalsIgnoreCase("GROUP"))
{
	category=request.getParameter("category");
}

response.sendRedirect("configuration.jsp?inserted=yes");
}catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	try{
		con1.close();
	}catch(Exception e)
	{}
} 
%>
