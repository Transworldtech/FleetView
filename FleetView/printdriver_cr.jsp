<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
Connection conn,conn1;
Statement st, st1, st2, st3;
String data1, data2, dcode, dname,transporter,vehreg;
String sql;
%>
<%
data1=request.getParameter("data1");
dcode=request.getParameter("dcode");
dname=request.getParameter("dname");
vehreg=request.getParameter("vehregno");
transporter=request.getParameter("transporter");
%>
<table border="1" bgcolor="white" width="100%" align="center">
<tr>
<td>
<table border="1" bgcolor="white" width="100%" align="center" class="stats">
<tr>
<td align="center">
<font color="brown" size="2">The Continuous Driving details for driver <%=dname%> ( <%=dcode%> ), Vehicle <%=vehreg%> of transporter <%=transporter%> for date <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%>.</font>
<div align="right">
<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
</td>
</tr>
<tr>
<td>

<table class="sortable" border="0" bgcolor="" width="100%">
<tr>
<td>Sr.</td>
<td>From-Date-Time</td>
<td>To-Date-Time</td>
<td>Duration</td>
<td>Distance</td>
<td>Start-Location</td>
</tr>

<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	sql="select * from t_driver_cr where FromDate='"+data1+"' and dcode='"+dcode+"' order by concat(FromDate,FromTime) asc";
	ResultSet rst=st2.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
	%>
	<tr>
	<td><%=i%></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("FromDate"))%> <%=rst.getString("FromTime")%></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("ToDate"))%> <%=rst.getString("ToTime")%></td>
	<td><%=rst.getString("Duration")%></td>
	<td><%=rst.getString("Distance")%></td>
	<td>
	<div align="left">
	<%
	sql="select * from t_veh"+rst.getString("VehCode")+" where TheFieldDataDate='"+data1+"' and TheFieldDataTime >='"+rst.getString("FromDate")+"' limit 1";	
	ResultSet rst1=st.executeQuery(sql);
	if(rst1.next())
	{
		%>
		<%=rst1.getString("TheFieldSubject")%>
		<%
	}	
	%>	</div>
	</td>
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
</table>

</td>
</tr>
<tr><td align="center"><input type="button" name="Print" value="Print" class="formElement" onclick="javascript:window.print();"></input></td></tr>

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