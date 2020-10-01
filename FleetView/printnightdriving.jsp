<%@ include file="headerprintnew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<table border="0" width="100%">
<tr><td>
<table border="0" width="100%">
<tr><td colspan="2" align="center">
<%
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:3.5
	</font>
	</div>
	<font size="3"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:4.5
	</font>
	</div>
	<font size="3"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:5.5
	</font>
	</div>
	<font size="3"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:6.5
	</font>
	</div>
	<font size="3"><b>Night Driving Report</b></font>
	<%
}
%>

</td></tr>
<tr bgcolor=""><td align="center" colspan="2"><font size="3"><b>NIGHT DRIVING for Vehicle <%=session.getAttribute("vehno") %> On Date :<%

java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd"));
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String s = formatter.format(date);
out.print(s);
%> Time <%=session.getAttribute("ndri").toString() %></font></b>

<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
<%=fleetview.PrintDate() %>
</div>
</td></tr>
</table>
<P></P>
<table border="1" width="100%" class="sortable">
<tr>
<th>Sr</th>
<th>Start Date-Time</th>
<th> <b>Start Location - Click To View On Map.</b></th>
<th>End Date-Time</th>
<th> <b>Start Location - Click To View On Map.</b></th>
<th>Distance</th>
<th>Duration</th>
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
	String tbname="t_veh"+vid+"_nd";
	try{
		conn =fleetview.ReturnConnection1();
		Statement st=conn.createStatement();
		String sql="select * from "+tbname+" where VehCode='"+vid+"' and FromDate='"+dd+"'";
		//out.print(sql+"<br>");
		ResultSet rst=st.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
		%>
	<tr>
	<td><%=i %></td>
	<td><%
		java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(2));
		Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
		String showdate1 = formatter1.format(ShowDate1);
		out.print(showdate1+" ");
		%>
		<%=rst.getString(3) %>
	</td>
	<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString("FromDate"),rst.getString("FromTime")) %></div></td>
	<td>
	<%
	java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(4));
	Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate2 = formatter1.format(ShowDate2);
 	out.print(showdate2+" ");
	%>
	<%=rst.getString(5) %>
	</td>
	<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString("ToDate"),rst.getString("ToTime")) %></div></td>
	<td>
	<%=rst.getString("Distance") %>
	<td>
	<%=rst.getString("Duration") %>
	</td>
	</tr>
		<%
	}
	}catch(Exception e)
	{
		System.out.print("Exception"+e);
	}
	finally
	{
		conn.close();
	}
 %>
</table>
</td></tr>
</table>
</
<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>
<%@ include file="footerprintnew.jsp"%>
