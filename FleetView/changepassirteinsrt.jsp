<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>

<%! 
Connection con1;
%>

<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=con1.createStatement();
	Statement stquery=con1.createStatement();
	
	ResultSet rs1=null;
	String sql1="";
	String pass="", user="";

	user=request.getParameter("user");
	pass=request.getParameter("newpass");
		
	sql1="update t_security set Password='"+pass+"' where Username='"+ user +"' ";
	//System.out.println("sql1--->"+sql1);
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql1.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	
	stmt1.executeUpdate(sql1);
	
	response.sendRedirect("changepasswordforIRTE.jsp?changed=yes");
	return;

}catch(Exception e)
{
	out.print("Exception -->"+e);

}
finally
{
	con1.close();
}
%>