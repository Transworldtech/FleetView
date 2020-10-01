 <%@ include file="headerprintnew.jsp" %>
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
date1=session.getAttribute("data1").toString();
	date2=session.getAttribute("data2").toString();
	vehcode=request.getParameter("vid");
	vehregno=request.getParameter("vehno");
	 tbname="t_veh"+vehcode+"_ra";
	//out.print(tbname);
%>
<table border="0" gbcolor="white" width="100%">
<tr><td align="center">
<%
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:3.9
	</font>
	</div>
	<font size="3"><b>Rapid Acceleration Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:4.9
	</font>
	</div>
	<font size="3"><b>Rapid Acceleration Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:5.9
	</font>
	</div>
	<font size="3"><b>Rapid Acceleration Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:6.9
	</font>
	</div>
	<font size="3"><b>Rapid Acceleration Report</b></font>
	<%
}
%>

</td></tr>
<tr>
<td align="center">
<font size="3">
 <b>RAPID ACCELERATION REPORT for Vehicle <%=vehregno %> From Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To Date :<%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);
%>
</b></font>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>
<%=fleetview.PrintDate() %>
</div>
</td>
</tr>
<tr>
<td>
<table class="sortable">
<tr>
<th>Sr.</th>
<th>Date </th>
<th>Time </th>
<th>From Speed</th>
<th>To Speed</th>
<th>Location </th>
</tr>

<%
	
try{	
	
	
	
	//out.print(data1+"  "+ data2+"  "+ vehcode+"  "+ vehregno);
	
	conn = fleetview.ReturnConnection1();
	con1 = fleetview.ReturnConnection();
	st=conn.createStatement();
	stmt1=con1.createStatement();
	int i=1;

       sql="select * from "+tbname+" where TheDate  >= '"+date1+"' AND TheDate<= '"+date2+"'";
	//out.print(sql+"<br>");
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	%>
	<tr>
	<td><%=i %></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate")) %></td>
	<td><%=rst.getString("TheTime") %></td>
	<td><div align="right"><%=rst.getString("FromSpeed") %></div></td>
	<td><div align="right"><%=rst.getString("ToSpeed") %></div></td>
	<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vehcode,rst.getString("TheDate"),rst.getString("TheTime")) %></div></td>
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
</td>
</tr>
</table>

<%

%>
</jsp:useBean>
 <%@ include file="footerprintnew.jsp" %>