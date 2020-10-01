<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%-- <%@ include file="header.jsp" %> --%>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
    
    
    Class.forName(MM_dbConn_DRIVER);
//	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    Statement stmt1=con1.createStatement();
    Statement stmt2=con1.createStatement();
    ResultSet rs2=null;
    String sql=""; 
    String OwnerName = request.getParameter("owner");
	String vehno ="";
	//System.out.println("username   "+username);
	%>
	<select name="vehcles" id="vehcles">
	<option value="Select">Select</option>
	<%
    sql="select Distinct(VehicleRegNumber) from t_vehicledetails where OwnerName='"+OwnerName+"' order by VehicleRegNumber asc";
	   rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   {
		   %>
		   <option value="<%=rs2.getString("VehicleRegNumber")%>"><%=rs2.getString("VehicleRegNumber")%></option>
		   <%
      		vehno+=rs2.getString("VehicleRegNumber"); 
	 } 
    System.out.println("vehno:-"+vehno);
//     out.println(vehno);
%>
</select>
<%

} 
catch(Exception e)
	{
		out.println(e);
	}

finally
{
con1.close();
}
%>