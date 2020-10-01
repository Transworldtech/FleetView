<%@ include file="header.jsp" %>

<%!
String userid, password, fname, lname,address, email, phone, mobile, Transporter;
Connection conn;
Statement st;
String sql;
%>
<%
userid=request.getParameter("userid");
password=request.getParameter("password");
fname=request.getParameter("fname");
lname=request.getParameter("lname");
address=request.getParameter("address");
email=request.getParameter("email");
phone=request.getParameter("phone");
mobile=request.getParameter("mobile");
Transporter=session.getAttribute("usertypevalue").toString();
try{ 
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();
	Statement stquery=conn.createStatement();
	sql="insert into t_subuser(UserId, Password, Fname, Lname, Address, Email, Phone, Mobile, Transporter) values('"+userid+"','"+password+"','"+fname+"','"+lname+"','"+address+"','"+email+"','"+phone+"','"+mobile+"','"+Transporter+"')";
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	 /*****************************/
int row=st.executeUpdate(sql);
if(row>0)
{
	out.print("<br>Record Inserted");
	response.sendRedirect("subuser.jsp");
}
}catch(Exception e)
{
	out.print("Exception "+e);
}	
finally
{
	conn.close();
}
%>

<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2007 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
