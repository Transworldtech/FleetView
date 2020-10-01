<%@ include file="Connections/conn.jsp" %>

<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>

<%!
Connection conn,conn1;
Statement st, st1, st2, st3;
String data1, data2, dcode, dname,transporter;
String sql;
%>
<%
data1=request.getParameter("data1");
data2=request.getParameter("data2");
dcode=request.getParameter("dcode");
dname=request.getParameter("dname");
transporter=request.getParameter("transporter");
%>
<table border="1" bgcolor="white" width="100%" align="center" class="stats">
<tr>
<td>
<table border="0" width="100%" align="center">
<tr><td align="center"><font color="brown" size="2">Exception Report for Driver <%=dname %> ( <%=dcode%> ), Transporter <%=transporter%> from date <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%>.</font>
<div align="right"> <font color="brown" size="1"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></font></div>
</td>
</tr>
<tr><td>
<table border="1" width="100%" align="center" class="sortable">
<tr>
<td>Sr</td>
<td>Date</td>
<td>Vehicle</td>
<td>Trip-ID</td>
<td>OS</td>
<td>RA</td>
<td>RD</td>
<td>CR</td>
<td>DT</td>
<td>ST</td>
<td>RH</td>
<td>ND</td>
<td>Rating</td>
</tr>
<%
try
{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	
	sql="select * from t_driver_ds where dcode='"+dcode+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"' order by TheDate";
	ResultSet rst=st2.executeQuery(sql);
	int i=1;	
	while(rst.next())
	{
	%>
	<tr>
	<td><%=i%></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))%></td>
	<td><%
		sql="select * from t_vehicledetails where vehiclecode='"+rst.getString("VehCode")+"'";	
		ResultSet rst1=st.executeQuery(sql);
		if(rst1.next())
		{
		out.print(rst1.getString("VehicleRegNumber"));
		}
	%></td>
	<td><%=rst.getString("Jcode")%></td>
	<td><%=rst.getString("OSCount")%></td>
	<td><%=rst.getString("RACount")%></td>
	<td><%=rst.getString("RDCount")%></td>
	<td><%=rst.getString("CRCount")%></td>
	<td><%=rst.getString("Distance")%></td>
	<td><%=rst.getString("StopCount")%></td>
	<td><%=rst.getString("RDuration")%></td>
	<td><%=rst.getString("ND")%></td>
	<td><% String rt=rst.getString("Rating");
		if(rt.length() > 5)
		{
			out.print(rt.substring(0,rt.indexOf(".")+3));
		}	
		else
		{
		out.print(rt);
		}
	%></td>
	</tr>	
	<%
	i++;
	}
}catch(Exception e)
{
	out.print("Exceptions--->"+e);
}
finally
{
	conn.close();
	conn1.close();
}
%>
<tr>
<td colspan="13">
<input type="button" name="Print" value="Print" class="formElement" onclick="javascript:window.print();">
</td>
</tr>
</table>
</td></tr>
</table>
</td>
</tr>
</table>
<!-- footer start here -->
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>