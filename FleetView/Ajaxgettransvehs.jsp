<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
%>

<%
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement();
ResultSet rs1=null, rs2=null;
String sql1="", sql2="";
String vehicle="";
String gettransp=request.getParameter("transp");

out.println("<select name='vehs'  class='formElement' onChange='showVehExcep(this);' > ");
out.println("<option value='Select'>Select</option> ");

sql1="select * from t_vehicledetails where Ownername='"+gettransp+"' order by VehicleRegNumber asc ";
rs1=stmt1.executeQuery(sql1);
while(rs1.next())
{
   out.println("<option value='"+rs1.getString("VehicleRegNumber")+"'> "+rs1.getString("VehicleRegNumber")+" </option> " );
}
out.print("</select>");

out.print("#");
out.println("<select name='drivers' class='formElement' onChange='showDriverTrips(this);' >");
out.print("<option value='Select'>Select</option> ");

sql2="select distinct(DriverName) as driver from t_completedjourney where Ownername='"+gettransp+"' order by DriverName asc ";
rs2=stmt1.executeQuery(sql2);
while(rs2.next())
{
   out.println("<option value='"+rs2.getString("driver")+"'> "+rs2.getString("driver")+" </option> " );
}
out.print("</select>");



} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>

