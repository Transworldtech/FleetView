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
    ResultSet rs3=null;
    String sql=""; String sql1="";
    String fuelserch = request.getParameter("fuelserch");
    //String usertypevalue=session.getAttribute("usertypevalue").toString();
    String owner=session.getAttribute("usertypevalue").toString();
    String user=session.getAttribute("mainuser").toString();
	
    String TripID ="";
	System.out.println("olduser   "+fuelserch);
	String buffer="";
	buffer="<div style='height: 150px; width: 235px; overflow: auto;'><table border='0' align='center'  style='height:150px;  width: 235px; display:block;  background-color: rgb(229, 237, 246);'>";
	
	%>
	
	<%
 //sql="select UserName,Email from db_gps.t_userdetails where Transporter like '%"+usertypevalue+"%' and UserName like '%"+fuelserch+"%' limit 20";
	
	sql="select * from db_gps.t_startedjourney where TripID like '%"+fuelserch+"%' and (GPName='"+owner+"' or OwnerName='"+owner+"') and (JStatus='Running' or JStatus='tobeclosed') ";
	//out.println("sql"+sql);
    //sql="select Distinct(VehicleRegNumber) from t_vehicledetails where OwnerName='"+fuelserch+"' order by VehicleRegNumber asc";
	   rs2=stmt2.executeQuery(sql);
	   //out.println("found");
	   if (!rs2.next()) {
		    out.println("No records found");
		    buffer +="<tr><td align='left'><a href='#' >No Records found</a></td></tr>";
		    rs2.beforeFirst();
		} else 
		{
			//out.println("found here");
			//sql1="select * from db_gps.t_startedjourney where TripID like '%"+fuelserch+"%' ";
			rs3=stmt2.executeQuery(sql);
	   while(rs3.next())
   	   {
		   
		   
		   TripID=rs3.getString("TripID");
		   TripID=TripID.trim();
		   //out.println("here");
      	   buffer +="<tr><td><a href='#' onClick=setname('"+TripID+"'); >"+TripID+"</a></td></tr>"; 
	 }
	 }%>
   <%  
   buffer +="</table></div>";
   System.out.println("buffer:-"+buffer);
     out.println(buffer);
%>

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