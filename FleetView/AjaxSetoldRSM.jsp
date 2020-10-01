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
    Statement stmt3=con1.createStatement();
    Statement stmt4=con1.createStatement();
    ResultSet rs2=null,rs3=null,rs4=null,rs5=null;
    String sql=""; 
    String oldmanagername = request.getParameter("oldmanagername");
    String usertypevalue=session.getAttribute("usertypevalue").toString();
	String newuser ="";
	System.out.println("oldmanagername   "+oldmanagername);
	String buffer="";
	int i=1;
	String FirstName="",LastName="",Name="",rsmhodid="",RSMName="-",Rsmhodid="",RsmName="-";
	//buffer="<div style='height: 150px; width: 235px; overflow: auto;'><table border='0' align='center'  style='height:150px;  width: 345px; display:block;  background-color: rgb(229, 237, 246);'>";
	
	%>
	
	<%
 //sql="select UserName,Email from db_gps.t_userdetails where Transporter like '%"+usertypevalue+"%' and UserName like '%"+oldusername+"%' limit 20";
	int count=0;
	//sql="select UserName,Email from db_gps.t_userdetails where Transporter like '%"+usertypevalue+"%' and UserName like '%"+oldusername+"%' order by UserName asc";
	sql="select hodid from db_gps.t_userdetails where UserName='"+oldmanagername+"' ";
	System.out.println("sql:---"+sql);
	rs2=stmt2.executeQuery(sql);
	if(rs2.next()){
		rsmhodid=rs2.getString("hodid");
	}
	String sql2="select UserName from db_gps.t_userdetails where SrNo='"+rsmhodid+"' ";
	rs3=stmt3.executeQuery(sql2);
	if(rs3.next())
	{
		RSMName=rs3.getString("UserName");
		//Rsmhodid=rs3.getString("hodid");
	}
	//sql="select Distinct(VehicleRegNumber) from t_vehicledetails where OwnerName='"+oldusername+"' order by VehicleRegNumber asc";
	
    /* String sql3="select UserName from db_gps.t_userdetails where hodid='"+Rsmhodid+"' ";
	rs4=stmt1.executeQuery(sql3);
	if(rs4.next())
	{
		RsmName=rs4.getString("UserName");
	}
	//buffer +="</ta ble></div>";
	buffer=MangerName+"#"+RsmName; */
	
    System.out.println("RSMName:-"+RSMName);
     out.println(RSMName);
     //out.println(buffer+"</select>");

    // buffer=null;

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