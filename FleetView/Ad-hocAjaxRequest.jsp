<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%-- <%@ include file="header.jsp" %> --%>
<%@ include file="Connections/conn.jsp" %>
<%@page import="com.fleetview.beans.AdhocAjaxRequest"%>
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
    //ResultSet rs2=null;
    //ResultSet rs3=null;
    String sql=""; String sql1="";
    String fuelserch = request.getParameter("fuelserch");
    //String usertypevalue=session.getAttribute("usertypevalue").toString();
    String owner=session.getAttribute("usertypevalue").toString();
    String user=session.getAttribute("mainuser").toString();
    //AdhocAjaxRequest ar=new AdhocAjaxRequest();
    //String buffer=ar.accept(owner,fuelserch);
    String TripID ="",TripIDnew="";
	System.out.println("olduser   "+fuelserch);
	String buffer="";
	buffer="<div style='height: 150px; width: 235px; overflow: auto;'><table border='0' align='center'  style='height:150px;  width: 235px; display:block;  background-color: rgb(229, 237, 246);'>";
	try{
	sql="select distinct(vehregno) from db_gps.t_fuelissuemaster where vehregno like '%"+fuelserch+"%' and Owner='"+owner+"' ";
	//out.println("sql"+sql);
    java.sql.PreparedStatement ps=con1.prepareStatement(sql);
	 ResultSet  rs2=ps.executeQuery(sql);
	   //out.println("found");
	   if (!rs2.next()) {
		    //out.println("No records found");
		    buffer +="<tr><td align='left'><a href='#' >No Records found</a></td></tr>";
		    rs2.beforeFirst();
		} else 
		{
			//out.println("found here");
			//sql1="select * from db_gps.t_startedjourney where TripID like '%"+fuelserch+"%' ";
			ResultSet rs3=ps.executeQuery(sql);
	   while(rs3.next())
   	   {
		   
		   
		   TripID=rs3.getString("vehregno");
		   TripIDnew=TripID.replace(" ", "#");
		   //out.println("here");
		   
      	   buffer +="<tr><td><a href='#' onClick=setname('"+TripIDnew+"'); >"+TripID+"</a></td></tr>"; 
	  }
	 }
	}catch(Exception e){
		e.printStackTrace();
	}
	   buffer +="</table></div>";

	   out.println(buffer+"</select>");

	   buffer=null;

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