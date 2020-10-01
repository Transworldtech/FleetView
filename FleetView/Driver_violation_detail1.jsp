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
String date1="", date2="",showdate1,showdate2,DriverID="",firstday="",fromdate="",todate="";
int total=0;
%>
<% 
Class.forName(MM_dbConn_DRIVER); 
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st1 = conn.createStatement();
st2 = conn.createStatement();
st3 = conn.createStatement();

String DriverID = request.getParameter("DriverID");
String date1 = request.getParameter("data1");
showdate1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
String date2 = request.getParameter("data2");
showdate2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2));
String driver_name = request.getParameter("DriverName");

%>
<table class="stats">

<th colspan="5" align= "center">Driver <%= driver_name %>'s hours Voilation details from date
	<%= showdate1%> to <%= showdate2%> 
	<div align="right">
			<div align="right">
<img src="images/excel.jpg" width="15px" height="15px"></a><th>
<div align="right">

<tr>		 

	<table width="100%" border="1" align="center">
		<tr align="center">
			<th> <b> Sr. </b></th>
			<th> <b>Veh. Reg. No</b></th>
			<th> <b>Transporter</b></th>
			<th> <b>From Date</b></th>
			<th> <b>To Date</b></th>
			<th> <b>Distance</b></th>
			<th> <b>Duration (hh:mm:ss)</b></th>
		</tr>	
		
		<% 
		java.util.Date startdate=new java.util.Date();
		java.util.Date sevenday=new java.util.Date();		
		String str = "SELECT * FROM `t_CastrolDrivers6` WHERE TheDte BETWEEN '"+ date1 + "' AND '"+ date2 + "' AND LastWeekRDur > '60:00:00' and DriverID = '"+DriverID+"'"; 
		ResultSet myrst = st1.executeQuery(str); 
		int count =1;
		String abc="";
		String enddate="";
		while(myrst.next())
		 {
			startdate=myrst.getDate("TheDte");
			long todaymils = startdate.getTime();
			long lastseven=60*60*1000*24*6;
			lastseven=todaymils-lastseven;
			sevenday.setTime(lastseven);
			firstday=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
			enddate=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
			todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(myrst.getString("TheDte")));
			%>
			
			
			<tr>
			<td> <div align="center"><%=count %></div></td>
			<td> <div align="center"><%=myrst.getString("VehRegno") %></div></td>
			<td> <div align="center"><%=myrst.getString("Transporter") %></div></td>
			<td> <div align="center"><%=firstday %></div></td>
			<% 
				abc = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(myrst.getString("TheDte")));
			%>
			<td> <div align="center"><%=abc %></div></td>
			<%
			String strdis = "SELECT sum(Distance) as sum FROM `t_CastrolDrivers6` WHERE TheDte BETWEEN '"+startdate+ "' AND '"+ date2 + "' and DriverID = '"+DriverID+"'"; 
			ResultSet myrstdst = st2.executeQuery(strdis); 
			while(myrstdst.next())
			 {
				%>
					<td> <div align="center"><%=myrstdst.getString("sum") %></div></td>
				<%
			 }
			%>
			<td> <div align="center"><a href="Driver_violation_detail2.jsp?fromdate=<%=fromdate %>&todate=<%=todate %>&drivername=<%=driver_name %>&driverid=<%=myrst.getString("DriverID") %>"><%=myrst.getString("LastWeekRDur") %></div></td>
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