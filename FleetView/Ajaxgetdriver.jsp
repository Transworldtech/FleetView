
<%@ include file="Connections/conn.jsp" %>


<%!
Connection con1;
%>

<%
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";
String getdriverid=request.getParameter("drivid");

sql1="select DriverName from t_drivers where DriverId='"+getdriverid+"'  ";
//out.println(sql1);
rs1=stmt1.executeQuery(sql1);

while(rs1.next())
{
  out.print(rs1.getString("DriverName"));
}


} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>





