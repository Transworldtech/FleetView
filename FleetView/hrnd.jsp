<%@ include file="Connections/conn.jsp" %> 

<%!
Connection conn, conn1;
String date1,date2,mode,rvehid,hvrno,fff,ttt;
%>
<%
fff=session.getAttribute("fff").toString();
ttt=session.getAttribute("ttt").toString();
date1=session.getAttribute("hdate1").toString();
date2=session.getAttribute("hdate2").toString();
mode=session.getAttribute("mode").toString();
rvehid=session.getAttribute("hvid").toString();
hvrno=session.getAttribute("hvrno").toString();

String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString()+"&fromtime1="+session.getAttribute("fromtime1").toString()+"&fromtime2="+session.getAttribute("fromtime2").toString()+"&totime1="+session.getAttribute("totime1").toString()+"&totime2="+session.getAttribute("totime2").toString();
%>
<%! String dd,aa; %>


<table border="1" width="100%">
<tr><th class="hed">Night Driving Report For <%=hvrno %> From <%=session.getAttribute("HisShowDate").toString()%> <%=fff%> to <%=session.getAttribute("HisShowDate1").toString()%> <%=ttt%>
</th></tr>

<tr><td>

<table width="100%" border="1" class="sortable">
<tr><th>From Date-Time</th><th>To Date-Time</th><th>Distance</th><th>Duration</th></tr>
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement st1=conn1.createStatement();


String sql="SELECT * FROM t_veh"+rvehid+"_nd where concat(FromDate,' ',FromTime)>='"+ date1+" "+fff+"' and  concat(ToDate,' ',ToTime)<='"+ date2+" "+ttt+"' order by concat(FromDate,FromTime) asc";
//System.out.println("sql:>>"+sql);
ResultSet rst1=st1.executeQuery(sql);
while(rst1.next())
{
%>
<tr>
<td class="bodyText" style="text-align: left">
<%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("FromDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
out.print(showdate1);
%>
<%=rst1.getString("FromTime") %>
</td>
<td class="bodyText" style="text-align: left">
<%
java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("ToDate"));
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate2 = formatter2.format(ShowDate2);
out.print(showdate2);
%>
<%=rst1.getString("ToTime") %>
</td>
	<td class="bodyText" style="text-align: right"><%=rst1.getString("Distance") %></td>
	<td class="bodyText" style="text-align: right"><%=rst1.getString("Duration") %></td>
</tr>
	<%

}
}catch(Exception e){
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



<P></P>
</body>
</html>
