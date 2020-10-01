<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<%!
Connection conn;
Statement st;
%>
<%
try{
	Class.forName("org.gjt.mm.mysql.Driver");
	conn= DriverManager.getConnection("jdbc:mysql://localhost/db_gps","root","");
	st=conn.createStatement();
String sql="select * from t_veh406 where TheFieldDataDate >='2008-05-01' and TheFieldDataDate<='2008-05-03'";
ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
out.print("hi <br>");
}
}catch(Exception e)
{
	out.print("Exception"+ e);

}
finally
{
conn.close();
}
%>
