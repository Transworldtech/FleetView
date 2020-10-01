<%@ include file="header.jsp" %>
<table border="1" width="100%" bgcolor="white">
<tr>
<td>
<!-- code start here -->
<%!
Connection conn;
Statement st, st1;
String sql,sql1,sql2,vehregno, transporter, vehcode,data1,data2,Pname;

%>
<%
try
{
	java.util.Date NewDate =new java.util.Date();
	Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
	data2 = NewFormatter.format(NewDate);
	long dateMillis = NewDate.getTime();
	long dayInMillis = 1000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	data1 = NewFormatter.format(NewDate);
	vehregno=request.getParameter("vehregno");
	transporter=request.getParameter("tranporter");
	Pname=request.getParameter("location");

	Class.forName("org.gjt.mm.mysql.Driver");
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	sql="select vehiclecode from t_vehicledetails where OwnerName='"+transporter+"' and vehicleRegNumber='"+vehregno+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehcode=rst.getString("VehicleCode");

	}
	sql="select * from t_veh"+vehcode+" where TheFiledTextFileName='SI' and TheFieldDataDate >='"+data1+"' and TheFieldDataDate <='"+data2+"' and TheFieldSubject like '%"+Pname+"%' order by concat(TheFieldDataDate,TheFieldDataTime) desc";
	ResultSet rst1=st.executeQuery(sql);
%>
<table class="stats">
<tr><th colspan="3">
<div align="left"><a href="javascript:history.go(-1);"><font color="white">Back</font></a></div>
Detail Report For Vehicle <%=vehregno%>, Transporter <%=transporter%>
From date <%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
out.print(showdate);
%> 00:00:00 to <% Format fmt1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt1 = fmt1.format(new java.util.Date());
 out.print(sdt1); %> <div  align="right">
<a href="#" onclick="javascript:window.open('print_show_detail_report.jsp?vehregno=<%=vehregno%>&tranporter=<%=transporter%>&location=<%=Pname%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_show_detail_report.jsp?vehregno=<%=vehregno%>&tranporter=<%=transporter%>&location=<%=Pname%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;

Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></th></tr>
<tr>
<td class="hed">Date</td>
<td class="hed">Time</td>
<td class="hed">Location</td>
</tr>
<%
	while(rst1.next())
	{
	%>
	<tr>
	<td class="bodyText"><%
String sdta = formatter.format(rst1.getDate("TheFieldDataDate"));
 out.print(sdta);
%></td>
	<td class="bodyText"><%=rst1.getString("TheFieldDataTime")%></td>
	<td class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject")%></div></td>
	</tr>
	
	<%
	}
%>
</table>
<%
}
catch(Exception e)
{
	out.print("Exception -->"+e);
}
finally
{
	conn.close();
}
%>
<!-- code end here -->
</td>
</tr>
</table>
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
