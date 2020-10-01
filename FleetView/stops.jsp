<%@ include file="headernew.jsp" %>

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
	<!-- <div align="left"><font size="3">
	Report No:3.7
	</font>
	</div>-->
	<font size="3"><b>Stop Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<!-- <div align="left"><font size="3">
	Report No:4.7
	</font>
	</div>-->
	<font size="3"><b>Stop Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<!-- <div align="left"><font size="3">
	Report No:5.7
	</font>
	</div>-->
	<font size="3"><b>Stop Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<!-- <div align="left"><font size="3">
	Report No:6.7
	</font>
	</div>-->
	<font size="3"><b>Stop Report</b></font>
	<%
}
%>
</td></tr>
<tr><td align="center"colspan="2"><font size="3"><b>REPORT OF STOPPAGES for Vehicle <%=session.getAttribute("vehno") %> On Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd"));
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String s = formatter.format(date);
out.print(s);
%>&nbsp; Stop Time <%=session.getAttribute("stop").toString() %>(s) with nearby Place  </b></font>

<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('printstop.jsp?dd=<%=request.getParameter("dd")%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excelstops.jsp?dd=<%=request.getParameter("dd")%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
<%=fleetview.PrintDate() %>
</div>

</td></tr>
</table>
<P></P>
<table border="1" width="100%"class="sortable">
<tr>
<th>Sr.</th>
<th>From Date-Time</th>
<th>To Date-Time</th>
<th>Duration</th>
<th>Location</th>
</tr>
<%!
Connection conn,conn1;
Statement st,st1,st001,st1001;
String sql10,sql1001,sql001;
ResultSet rst10,rst1001,rst001;
%>
<%
	String data1,data2,vid,vehno,dd;
	data1=session.getAttribute("data1").toString();
	data2=session.getAttribute("data2").toString();
	vid=session.getAttribute("vid").toString();
	vehno=session.getAttribute("vehno").toString();
	dd=request.getParameter("dd").toString();
	String tbname="t_veh"+vid+"_stsp";
	try{
		conn = fleetview.ReturnConnection1();
		conn1 =  fleetview.ReturnConnection();
	st=conn.createStatement();
	st1=conn1.createStatement();
	String sql="select * from "+tbname+" where VehCode='"+vid+"' and FromDate='"+dd+"'";
	//out.print(sql+"<br>");
	ResultSet rst=st.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
		%>
		<tr>
		<td style="text-align: right"><%=i %></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("FromDate")) %> <%=rst.getString("FromTime") %></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("ToDate")) %> <%=rst.getString("ToTime") %></td>
		<td><div align="left"><%=rst.getString("Duration") %></div></td>
		<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString("FromDate"),rst.getString("FromTime")) %></div></td>
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
		conn.close();
		conn1.close();
	}




 %>

</table>
</td></tr>
</table>
<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>
<%@ include file="footernew.jsp"%>