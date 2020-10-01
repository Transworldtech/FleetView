<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"deatail_nd_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection conn, con1;
Statement st,st1, stmt1;
String date1, date2, vehcode, vehregno,tbname,sql;
%>
<%
date1=request.getParameter("data");
date2=request.getParameter("data1");
vehcode=request.getParameter("vid");
vehregno=request.getParameter("vehno");
	
	 tbname="t_veh"+vehcode+"_nd";
	//out.print(tbname);
%>
<table border="0" gbcolor="white" width="100%">
<tr><td colspan="2" align="center">
<%
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:3.12
	</font>
	</div>
	<font size="3"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:4.12
	</font>
	</div>
	<font size="3"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:5.12
	</font>
	</div>
	<font size="3"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:6.12
	</font>
	</div>
	<font size="3"><b>Night Driving Report</b></font>
	<%
}
%>


</td></tr>
<tr><td align="center"><font size="3">
 <b>NIGHT DRIVING REPORT for Vehicle <%=vehregno %> From Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To Date :<%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);%>
</b></font>
<div align="right">
<%=fleetview.PrintDate() %>
</div>
</td></tr>

<tr><td>
<table class="sortable">
<tr>
<th>Sr</th>
<th>Start Date-Time</th>
<th> <b>Start Location - Click To View On Map.</b></th>
<th>End Date-Time</th>
<th> <b>End Location - Click To View On Map.</b></th>
<th>Distance</th>
<th>Duration</th>
<th>ND Pre-authorized</th>
</tr>
<%
	
try{	
	
	//out.print(data1+"  "+ data2+"  "+ vehcode+"  "+ vehregno);
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stmt1=con1.createStatement();
	int i=1;
	String nextdate="";
	String nd = "SELECT DATE_ADD('"+date2+"', INTERVAL 5 HOUR) as fiveHoursAfterDateTime";
	ResultSet rsnd = st.executeQuery(nd);
	if(rsnd.next())
	{
		nextdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsnd.getString("fiveHoursAfterDateTime")));
	}
	 sql="SELECT "+
	 	" nd.FromDate, nd.FromTime, veh.fromlocation, veh.LatinDec,veh.LonginDec ,nd.ToDate ,nd.ToTime , vehto.tolocation, "+
		" 0 , 0 , 0 , 0, nd.Duration, veh.ZoneColor, nd.Distance, nd.NDPreAuthorised  "+
		" FROM (  "+
		" SELECT  "+
		"  	FromDate, FromTime, ToDate, ToTime, Duration,Distance,NDPreAuthorised "+
		" FROM "+ 
	 	" 	db_gpsExceptions.t_veh"+vehcode+"_nd "+ 
		" WHERE "+ 
		" 	CONCAT( Fromdate,' ',FromTime ) >= '"+date1+"' "+
		" AND CONCAT( Fromdate,' ',FromTime ) <= '"+date2+"' "+
		" )nd "+
		" LEFT OUTER JOIN ( "+ 
		" SELECT "+ 
		" 		TheFieldSubject as fromlocation ,  LatinDec, LonginDec, TheFieldDataDate,  TheFieldDataTime,ZoneDesc AS ZoneColor,TheFieldDataDateTime "+ 
		" FROM "+ 
		" 	db_gps.t_veh"+vehcode+" "+ 
		" WHERE "+ 
		" 	 TheFieldDataDateTime >= '"+date1+"' "+ 
		" AND  TheFieldDataDateTime <= '"+nextdate+"' "+ 
		" )veh "+ 
		" ON ( veh.TheFieldDataDate = nd.Fromdate "+ 
		" AND veh.TheFieldDataTime = nd.FromTime ) "+
		" "+ 
		" LEFT OUTER JOIN  ( "+ 
		" SELECT "+ 
		" 		TheFieldSubject as tolocation ,  LatinDec, LonginDec, TheFieldDataDate,  TheFieldDataTime,ZoneDesc AS ZoneColor,TheFieldDataDateTime "+ 
		" FROM "+ 
		" 	db_gps.t_veh"+vehcode+" "+ 
		" WHERE "+ 
		" 	 TheFieldDataDateTime >= '"+date1+"' "+ 
		" AND  TheFieldDataDateTime <= '"+nextdate+"'  "+
		" )vehto "+ 
		" ON ( vehto.TheFieldDataDate = nd.Todate "+ 
		" AND vehto.TheFieldDataTime = nd.ToTime ) "+
		" GROUP BY "+ 
		" 	CONCAT( Fromdate,' ',FromTime ) "+
		" ORDER BY CONCAT( Fromdate,' ',FromTime )";

	
  // out.println("SqlND===>"+sql);
 		  
 		  ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	%>
		<tr>
	<td style="text-align: right"><%=i %></td>
	<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("FromDate")) %> <%=rst.getString("FromTime") %></td>
	<td><div align="left"><%=rst.getString("fromlocation") %></div></td>
	<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("ToDate")) %> <%=rst.getString("ToTime") %></td>
	<td><div align="left"><%=rst.getString("tolocation") %></div></td>
	<td><div align="right"><%=rst.getString("Distance") %></div></td>
	<td><div align="right"><%=rst.getString("Duration") %></div></td>
	<td><div align="right"><%=rst.getString("NDPreAuthorised") %></div></td>
	</tr>
<%
	i++;
}
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{

	try
	{
	conn.close();
	}
	catch(Exception e){}
	try
	{
	con1.close();
	}
	catch(Exception e){}
	try
	{
	fleetview.closeConnection1();
	}
	catch(Exception e){}
	try
	{
	fleetview.closeConnection();
	}
	catch(Exception e){}
}

%>
</table>
</td></tr></table>
<%

%>
</jsp:useBean>
<%@ include file="footerprintnew.jsp"%>
