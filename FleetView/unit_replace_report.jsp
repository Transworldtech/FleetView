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

</head>

<body background="images/green_grad_bot.jpg" onload="focusChild();">

<form name="unitreplacerpt" action="" method="post" onSubmit="return validate();">

<%!
Connection conn,conn1;
Statement st,st1;
String fromdate, todate,sql,sql1,vehcode,vehregno,date1,date2;
%>
<%
fromdate=request.getParameter("fromdate");
todate=request.getParameter("todate");

//System.out.println("fromdate::>>"+fromdate);
//System.out.println("todate::>>"+todate);
vehcode=request.getParameter("vehcode");
vehregno=request.getParameter("vehregno");
//System.out.println("vehcode11::>>"+vehcode);
date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("fromdate")));
date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("todate")));
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
		%>
		<table border="0" align="center">
		<tr><td>
		<font  size="3"><B>Unit Replacement Report for Vehicle <%=vehregno%> </B></font>
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
<table border="1" width="100%" class="stats">
<%
int i=1;
java.util.Date instDateTime=null;
String instdatetime;
sql="Select VehRegNo,OwnerName,OldUnitID,NewUnitID,InstDate,InstTime,InstBy,InstPlace,EntBy,EntDate from t_unitreplacement where VehCode='"+vehcode+"' and concat(InstDate,' ',InstTime) Between '"+fromdate+"' AND '"+todate+"'";
//System.out.println(sql);
ResultSet rst=st.executeQuery(sql);
if(rst.next())
{
	
%>
<tr>
	<td><b>Old Unit ID :</b></td><td><%=rst.getString("OldUnitID")%></td>
</tr>
<tr>
	<td><b>New Unit Id :</b></td><td><%=rst.getString("NewUnitID")%></td>
</tr>
<tr>
	<td><b>Transporter :</b></td><td><%=rst.getString("OwnerName")%></td>
</tr>

<tr>
<td><b>Install DateTime :</b></td>

<% 
instDateTime=new SimpleDateFormat("yyyy-MM-ddHH:mm:ss").parse(rst.getString("InstDate")+""+rst.getString("InstTime"));
    instdatetime=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss a").format(instDateTime);
%>

	<td><%=instdatetime%></td></tr>
<tr>
	<td><b>Installed By :</b></td><td><%=rst.getString("InstBy")%></td>
</tr>
<tr>
	<td><b>Install Place :</b></td><td><%=rst.getString("InstPlace")%></td>
	</tr>
<tr>
	<td><b>Entered By :</b></td><td><%=rst.getString("EntBy")%></td>
</tr>
<tr>
	<td><b>Special Comments :</b></td>
	<td>
	<%
	sql1="Select SpComment from t_techspecialrep where EntDateTime<='"+instDateTime+"' order by EntDateTime desc limit 1";
	ResultSet rst1=st1.executeQuery(sql1);
	if(rst1.next())
	{
		out.print(rst1.getString("SpComment"));
	}
	else
	{
		out.print("-");
	}
	%>
	</td>
</tr>

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
	conn1.close();
	}
	catch(Exception e){}
}
}
%>

