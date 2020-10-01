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
	Report No:3.4
	</font>
	</div>
	<font size="3"><b>Rapid Deceleration Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:4.4
	</font>
	</div>
	<font size="3"><b>Rapid Deceleration Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:5.4
	</font>
	</div>
	<font size="3"><b>Rapid Deceleration Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:6.4
	</font>
	</div>
	<font size="3"><b>Rapid Deceleration Report</b></font>
	<%
}
%>


</td></tr>
<tr bgcolor=""><td align="center"colspan="2"><font size="3"><b>RAPID DECELERATION for Vehicle <%=session.getAttribute("vehno") %> On Date :
<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd")))%> Variation of Speed >= <%=session.getAttribute("racc").toString() %></b></center>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
<%=fleetview.PrintDate() %>
</div>
	 </td></tr>
</table>
<P></P>
<table border="1" width="100%" bgcolor="#F5FFFA" class="sortable">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed From</th>
<th>Speed To</th>
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
	String tbname="t_veh"+vid+"_rd";
	try{
	
	conn = fleetview.ReturnConnection1();
	Statement st=conn.createStatement();
	String sql="select * from "+tbname+" where VehCode='"+vid+"' and TheDate='"+dd+"'";
	//out.print(sql+"<br>");
	int i=1;
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		%>
	<tr>
	<td><%=i %></td>
	<td><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd")))%> <%=rst.getString(3) %></td>
	<td><%=rst.getString(4) %></td>
	<td><%=rst.getString(5) %></td>
	<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,dd,rst.getString(3)) %></div></td>
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
	}
 %>

</table>
</td></tr></table>

<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>
<%@ include file="footerprintnew.jsp"%>