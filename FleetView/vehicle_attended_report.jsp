<%@ include file="Connections/conn.jsp" %>

<html>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<head>
<title>Vehicle Tracking System </title>

<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>

<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
</head>

<body background="images/green_grad_bot.jpg" onload="focusChild();">

<form name="vehattended" action="" method="post" onSubmit="return validate();">

<%!
Connection conn,conn1;
Statement st,st1,st2;
String fromdate, todate,sql,sql1,vehcode,vehregno,date1,date2,transporter;
%>
<%
fromdate=request.getParameter("fromdate");
todate=request.getParameter("todate");

//System.out.println("fromdate::>>"+fromdate);
//System.out.println("todate::>>"+todate);
vehcode=request.getParameter("vehcode");
vehregno=request.getParameter("vehregno");
transporter=request.getParameter("transporter");

//System.out.println("vehcode11::>>"+vehcode);
//date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("fromdate")));
//date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("todate")));
//System.out.println("date1::>>"+date1);
%>

<%

if(!(null==request.getQueryString()))
{
	try{
		Class.forName(MM_dbConn_DRIVER);
		conn=DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1=DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		
		st=conn.createStatement();
		st1=conn1.createStatement();
		st2=conn1.createStatement();
		%>
		<table border="0" align="center" class="sortable_entry" width="50%">
		<tr><td>
		<font  size="3"><B>Vehicle Complaint</B></font>
		<!-- <div class="bodyText" align="right">
		<a href="#" onclick="javascript:window.open('print_unit_replace_report.jsp?fromdate=< %=fromdate%>&todate=< %=todate%>&vehcode=< %=vehcode %>&vehregno=< %=vehregno %>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_unit_replace_report.jsp?fromdate=< %=fromdate%>&todate=< %=todate%>&vehcode=< %=vehcode %>&vehregno=< %=vehregno %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : < %=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div> --> 
		</td>
		</tr></table>
		<!-- </table>
		<table border="1" class="sortable" width="100%"> 

<tr>
<th>Sr.</th>
<th>Vehicle</th>
<th>Transporter</th>
<th>Old Unit ID</th>
<th>New Unit Id</th>
<th>Installation DateTime</th>
<th>Installed By</th>
<th>Installed Place</th>
<th>Entered By</th>
<th>Entered Date</th>
</tr>
-->
<br>
<table border="1" width="50%" class="sortable_entry">
<%
int i=1;
java.util.Date instDateTime=null,vehavildate=null;
String instdatetime,vehAvailDate;
String sql2="Select VehicleNo,TdyDate,Complaint,Tno,Action,VehAvaildate from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+vehregno+"'";
//System.out.println(sql);
ResultSet rst=st1.executeQuery(sql2);
if(rst.next())
{
	//System.out.println(rst.getInt("Tno"));
%>
<tr>
	<td><b>Vehicle :</b></td><td><%=rst.getString("VehicleNo")%></td>
</tr>
<tr>
	<td><b>Transporter :</b></td><td><%=transporter%></td>
</tr>
<tr>
<% 
//System.out.println(rst.getString("TdyDate"));
//instDateTime=new SimpleDateFormat("dd-MMM-yyyy").parse(rst.getString("TdyDate"));
//System.out.println(instDateTime);   
instDateTime=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TdyDate"));
    instdatetime=new SimpleDateFormat("dd-MMM-yyyy").format(instDateTime);
%>
	<td><b>Complaint Date :</b></td><td><%=instdatetime%></td>
</tr>

<tr>
<td><b>Technician Name :</b></td>

	<td>
	<%
	String sql22="Select Technicion from  t_callocation1 where Tno='"+rst.getInt("Tno")+"'";
	ResultSet rst22=st2.executeQuery(sql22);
	if(rst22.next())
	{
		out.print(rst22.getString("Technicion"));
	}
	else
	{
		out.print("-");
	}
	%>
	</td></tr>
<tr>
<td><b>Complaint :</b></td>

	<td><%=rst.getString("Complaint")%></td></tr>
	<tr>
<td><b>Action :</b></td>

	<td><%=rst.getString("Action")%></td></tr>
<tr>
<td><b>Vehicle Available Date :</b></td>
<%
vehavildate=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("VehAvaildate"));
vehAvailDate=new SimpleDateFormat("dd-MMM-yyyy").format(vehavildate);
%>
	<td><%=vehAvailDate%></td></tr>
	

</table> 
<%
}
}
catch(Exception e)
{
	e.printStackTrace();
}
finally{
	try
	{
	conn.close();
	}
	catch(Exception e){}
	try
	{
		conn1.close();
	}
	catch(Exception e){}
}
}
%>

