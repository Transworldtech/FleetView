<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<table border="1" width="90%" bgcolor="white" align="center">
<tr><td>
<!-- code start-->
<%!
Connection conn;
Statement st;
String sql,drivername,drivercode,tripid;

%>
<%
tripid=request.getParameter("tripid");
drivername=request.getParameter("drivername");
drivercode=request.getParameter("drivercode");


%>
<table class="stats">
<tr><th><font size="3">Rapid Deceleration Report for Driver <%=drivername+"("+drivercode+")"%> ,TripID :<%=tripid%> <div align="right" >
Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></font></th></tr>
<tr><td>
<table class="stats">
<tr><td rowspan="2" class="hed">Date-TIme</td><td colspan="2" class="hed">Speed</td></tr>
<tr><td class="hed">From Speed</td><td class="hed">To Speed</td></tr>
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	sql="select * from t_driver_rd where jcode='"+tripid+"' and dcode='"+drivercode+"'";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		%>
		<tr>
		<td class="bodyText"><%
		java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate"));
		Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
		String showdate1 = formatter1.format(ShowDate1);
		out.print(showdate1);
		%> <%=rst.getString("TheTime")%></td>
		<td class="bodyText"><%=rst.getString("FromSpeed")%></td>
		<td class="bodyText"><%=rst.getString("ToSpeed")%></td></tr>
		<%
	}
	%>
		</table>
	<%
}
catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
}

%>
<tr><td align="center"><input type="button" name="Print" Value="Print" class="formElement" onclick="javascript:window.print();"></td></tr>
</table>
</td></tr>
<!-- code end -->
</td></tr>
</table>
<!-- footer start here -->
<table border="1" width="90%" bgcolor="white" align="center">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
