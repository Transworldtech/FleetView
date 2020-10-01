<%@ include file="header.jsp" %>
<%!
Connection conn;
Statement st,st1;
String sql;
%>
<table border="1" width="100%" align="center" >
<tr><td>
<table border="1" width="100%" bgcolor="white" class="stats">
<tr><td colspan="6" align="center"><font color="black" size="2">Vehicles Not Active In <%=session.getAttribute("user").toString()%> Trips. </font></td></tr>
<tr>
<td><b>Sr.</b></td>
<td><b>VehRegNo.</b></td>
<td><b>Transporter</b></td>
<td><b>Updated</b></td>
<td><b>Last Trip Date</b></td>
<td><b>Location</b></td>
</tr>
<%
try
{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	sql="select * from t_onlinedata where VehicleCode in "+session.getAttribute("NAVehList").toString()+" order By TheDate desc";
	ResultSet rst=st.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
	%>
	<tr>
	<td><%=i%></td>
	<td><%=rst.getString("VehicleRegNo")%></td>
	<td><%=rst.getString("Transporter")%></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))%> <%=rst.getString("TheTime")%></td>
	<td>
	<%
	sql="select * from t_group where GPName='"+session.getAttribute("user").toString()+"' and VehCode='"+rst.getString("VehicleCode")+"'";	
	ResultSet rst1=st1.executeQuery(sql);
	if(rst1.next())
	{
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("LastTripDate")));
	}
	%>	
	</td>
	<td><div align="left"><%=rst.getString("Location")%></div></td>
	</tr>	
	<%
	i++;
	}
}
catch(Exception e)
{
	out.print("Exception -->"+e);
}
finally
{

}
%>
</table>

</td></tr>
</table>

<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>