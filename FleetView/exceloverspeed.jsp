<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"over_speed.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<table border="0" width="100%"><tr><td>
<table border="0" width="100%">
<tr><td colspan="2" align="center">

<%
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:3.2
	</font>
	</div>
	<font size="3"><b>Overspeed Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:4.2
	</font>
	</div>
	<font size="3"><b>Overspeed Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:5.2
	</font>
	</div>
	<font size="3"><b>Overspeed Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:6.2
	</font>
	</div>
	<font size="3"><b>Overspeed Report</b></font>
	<%
}
%>
</td></tr>
<tr>
<td colspan="2" align="center">
<font size="3"><b>
SPEED ANALYSIS for Vehicle <%=session.getAttribute("vehno") %> On Date :
<%=new SimpleDateFormat("dd-MMM-yyyy").format( new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd")))%> OverSpeed Limit is >= <%=session.getAttribute("overspeed").toString() %></b></font>
<div class="bodyText" align="right">
<%=fleetview.PrintDate() %>
</div>
</td></tr>
</table>
<P></P>
<table border="1" width="100%" bgcolor="#F5FFFA" class="sortable">
<tr>
<th>Sr.</th>
<th>From Date-Time</th>
<th>To Date-Time</th>
<th>Speed in KMPH</th>
<th>Duration in Seconds</th>
<th>Location</th>
</tr>
<%!
Connection conn;
%>
<%
	String data1,data2,vid,vehno,dd;
	data1=session.getAttribute("data1").toString();
	data2=session.getAttribute("data2").toString();
	vid=session.getAttribute("vid").toString();
	vehno=session.getAttribute("vehno").toString();
	dd=request.getParameter("dd").toString();
	String tbname="t_veh"+vid+"_overspeed";
	try{
	conn = fleetview.ReturnConnection1();
	Statement st=conn.createStatement();
	String sql="select * from "+tbname+" where VehCode='"+vid+"' and FromDate='"+dd+"'";
	ResultSet rst=st.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
		%>
	<tr>
	<td><%=i %></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format( new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd")))%> <%=rst.getString("FromTime") %></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format( new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd")))%> <%=rst.getString("ToTime") %></td>
	<td><div align="right"><%=rst.getString(6) %></div></td>
	<td><div align="right"><%=rst.getString(7) %></div></td>
	<td><div align="left"><%=fleetview.ShowLocationOnlyByDateTime(vid,dd,rst.getString("FromTime")) %></div></td>
	</tr>
		<%
		i++;
	}
	}catch(Exception e)
	{
		System.out.print("Exception"+e);
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
</td></tr></table>

</jsp:useBean>
        <%@ include file="footernew.jsp" %>