<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"_driver_wise_trip_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn,conn1;
Statement st, st1, st2;
String sql, sql1, sql2,data1,data2,drivername,drivercode,showdate1,showdate,namecode;

%>
<%
try{
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn1.createStatement();
	st2=conn1.createStatement();




%>
<table border="0" width="90%" bgcolor="white" align="center">
<tr><td>
<!-- code start here -->
<%
String dd=request.getQueryString();
if(dd==null)
{
%>
<table class="stats">
<tr><td>
<center class='bodyText'><b>Please select the dates to display the Driver wise trip report</b></center>
</td><tr>
</table>
<%
}
else
{
data1=request.getParameter("data");
data2=request.getParameter("data1");
drivername=request.getParameter("driver");
namecode=request.getParameter("driver");
StringTokenizer stk = new StringTokenizer(drivername,",");
drivername=stk.nextToken();
drivercode=stk.nextToken();
%>
<table class="stats">
<tr><th colspan="4"><b>Trip report for Driver <%=drivername%> (<%=drivercode%>) from date <%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
showdate = formatter2.format(ShowDate);
out.print(showdate);
%> to <%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
showdate1 = formatter1.format(ShowDate1);
out.print(showdate1);
%>. <div align="right">
Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div> </b></th></tr>
<tr>
<td class="hed">Trip Id</td>
<td class="hed">Start Date</td>
<td class="hed">Origin</td>
<td class="hed">Destination</td>
</tr>
<%
sql="select Distinct(Jcode) as Jcode,Transporter from t_driver_ds where DCode='"+drivercode+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"' and Jcode<>'-'";
ResultSet rst1=st1.executeQuery(sql);
while(rst1.next())
{
%>
<tr>
<td class="bodyText"><div align="right"><%=rst1.getString("Jcode")%></div></td>
<%
sql="select * from t_alljddata where TripId='"+rst1.getString("Jcode")+"'";
ResultSet rst2= st.executeQuery(sql);
if(rst2.next())
{
%>
<td class="bodyText"><div align="right"><%=rst2.getString("StartDate")%></div></td>
<td class="bodyText"><div align="right"><%=rst2.getString("StartPlace")%></div></td>
<td class="bodyText"><div align="right"><%=rst2.getString("EndPlace")%></div></td>
<%
}
else
{
%>
<td class="bodyText"><div align="right">-</div></td>
<td class="bodyText"><div align="right">-</div></td>
<td class="bodyText"><div align="right">-</div></td>
<%
}
%>
</tr>
<%
}

%>
</table>

<%
}
}
catch(Exception e)
{
	out.print("Exception -->" +e);
}
finally
{
	conn.close();
	conn1.close();
}
%>
<!-- code end here -->
</td></tr>

</table>
