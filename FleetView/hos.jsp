
<%@ include file="Connections/conn.jsp" %> 
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
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

//String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString();

String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString()+"&fromtime1="+session.getAttribute("fromtime1").toString()+"&fromtime2="+session.getAttribute("fromtime2").toString()+"&totime1="+session.getAttribute("totime1").toString()+"&totime2="+session.getAttribute("totime2").toString();
%>
<%! String dd,aa; %>


<table border="1" width="100%" >
<tr><th>Over Speed Report For <%=hvrno %> From <%=session.getAttribute("HisShowDate").toString()%> to <%=session.getAttribute("HisShowDate1").toString()%> 

</th></tr>

<tr><td>

<table width="100%" border="1"  class="sortable">
<tr><th>Date </th><th>Time</th><th>Speed</th><th>Duration In Second</th><th>Location</th></tr>
<%
try{
	Class.forName("org.gjt.mm.mysql.Driver"); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement st1=conn1.createStatement();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);


String sql="SELECT * FROM t_veh"+ rvehid+"_overspeed where concat(FromDate,' ',FromTime)>='"+ date1+" "+fff+"' and  concat(ToDate,' ',ToTime)<='"+ date2+" "+ttt+"' order by FromDate desc,FromTime desc";
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
</td>
	<td class="bodyText" style="text-align: right"><%=rst1.getString("FromTime") %></td>
	<td class="bodyText" style="text-align: right"><%=rst1.getString("Speed") %></td>
	
	<td class="bodyText" style="text-align: right"><%=rst1.getString("Duration") %></td>
	<td class="bodyText" style="text-align: left"><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(rvehid,rst1.getString("FromDate"),rst1.getString("FromTime")) %></div></td>
	
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

<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>

<P></P>
</body>
</html>
