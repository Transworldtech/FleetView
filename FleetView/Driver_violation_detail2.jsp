<%@ include file="headernew.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!

Connection conn1,conn;
Statement st0=null,st=null, st1=null, st2=null,st3=null,st4;
String user;
int count=1;
ResultSet rst1;
String date1="", date2="",showdate1,showdate2,DriverID="";
int total=0;
%>
<% 
Class.forName(MM_dbConn_DRIVER); 
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st1 = conn.createStatement();
st2 = conn.createStatement();
st3 = conn.createStatement();



//String DriverID = request.getParameter("DriverID");
String date1 = request.getParameter("fromdate");
showdate1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
String date2 = request.getParameter("todate");
showdate2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2));
String driver_name = request.getParameter("drivername");
String driverid=request.getParameter("driverid");

%>
<table class="stats">

<th colspan="5" align= "center">Driver <%= driver_name %> 's hours Voilation details from date
	<%= showdate1%> to <%= showdate2%> 
	<div align="right">
			<div align="right">
<img src="images/excel.jpg" width="15px" height="15px"></a><th>
<div align="right">

<tr>		 

	<table width="100%" border="1" align="center">
		<tr align="center">
			<th> <b> Sr. </b></th>
			<th> <b>Vehicle Registration Number</b></th>
			<th> <b>Date</b></th>
			<th> <b>Duration (hh:mm:ss)</b></th>
		</tr>	
		
		<% 
				
		String str = "SELECT * FROM `t_CastrolDrivers6` WHERE TheDte BETWEEN '"+ date1 + "' AND '"+ date2 + "' AND Duration > '10:00:00' and DriverID = '"+driverid+"' order by TheDte desc"; 
		//System.out.println("str--------------------->" + str);
		ResultSet myrst = st1.executeQuery(str); 
		int count =1;
		String abc="";
		while(myrst.next())
		 {
			%>
			
			
			<tr>
			<td> <div align="center"><%=count %></div></td>
			
			<%
					//String sql = "Select VehicleRegNumber from t_vehicledetails where VehicleCode ='" + myrst.getString("VehID") + "'";
					//System.out.println("sql------------------------>" +  sql);
					//ResultSet rst = st2.executeQuery(sql); 
					//if(rst.next())
					//{
					
			%>
			
			<td> <div align="center"><%=myrst.getString("VehRegno") %></div></td>
			<% //} 
			
				abc = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(myrst.getString("TheDte")));
			%>
			<td> <div align="center"><%=abc %></div></td>
			<td> <div align="center"><%=myrst.getString("Duration") %></div></td>
			<%	
			 
			 count++;
		 }//end of  while(rst1.next())
		%>


<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>

</table>

</tr>
<tr>
<td colspan="4"> 


</body>
</html>
</jsp:useBean>