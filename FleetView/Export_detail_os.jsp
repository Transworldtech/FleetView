<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"deatail_os_report.xls";
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
date1=session.getAttribute("data1").toString();
	date2=session.getAttribute("data2").toString();
	vehcode=request.getParameter("vid");
	vehregno=request.getParameter("vehno");
	 tbname="t_veh"+vehcode+"_overspeed";
	//out.print(tbname);
%>
<table border="0" gbcolor="white" width="100%">
<tr><td>
<table width="100%" align="center">
<tr>
<td align="center">
<%
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:3.8
	</font>
	</div>
	<font size="3"><b>Overspeed Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:4.8
	</font>
	</div>
	<font size="3"><b>Overspeed Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:5.8
	</font>
	</div>
	<font size="3"><b>Overspeed Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:6.8
	</font>
	</div>
	<font size="3"><b>Overspeed Report</b></font>
	<%
}
%>

</td>
</tr>
<tr><td align="center">
 <b><font size="3">OVERSPEED ANALYSIS REPORT for Vehicle  <%=vehregno %> From Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To Date :<%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);%>
</font></b>
<div class="bodyText" align="right">
<%=fleetview.PrintDate() %>
</div>
</td></tr>

</table>
<P></P>
<table border="1" width="100%" class="sortable">
<tr>
<th>Sr.</th>
<th>From Date-Time</th>
<th>To Date-Time</th>
<th>Speed </th>
<th>Duration</th>
<th>Location</th>

</tr>
<%	
try{		
	//out.print(data1+"  "+ data2+"  "+ vehcode+"  "+ vehregno);
	conn = fleetview.ReturnConnection1();
	con1 = fleetview.ReturnConnection();
	st=conn.createStatement();
	stmt1=con1.createStatement();

	int i=1;
    String sql="select * from "+tbname+" where ToDate<='"+date2+"' and ToDate>='"+date1+"'";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		%>
		<tr>
		<td><%=i %></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("FromDate")) %> <%=rst.getString("FromTime") %></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("ToDate")) %> <%=rst.getString("ToTime") %></td>
		<td><div align="right"><%=rst.getString("Speed") %></div></td>
		<td><div align="right"><%=rst.getString("Duration") %></div></td>
		<td><div align="left"><%=fleetview.ShowLocationOnlyByDateTime(vehcode,rst.getString("FromDate"),rst.getString("FromTime")) %></div></td>
		
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
<%@ include file="footerprintnew.jsp" %>