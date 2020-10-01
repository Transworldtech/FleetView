<%@ include file="Connections/conn.jsp" %> 
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%!
Connection conn,conn1;
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



<table border="1" width="100%">
<tr><th class="hed">Rapid Dcceleration Report For <%=hvrno %> From <%=session.getAttribute("HisShowDate").toString()%> <%=fff%> to <%=session.getAttribute("HisShowDate1").toString()%> <%=ttt%>
</th></tr>

<tr><td>

<table width="100%" border="1" class="sortable">
<tr><th>Date </th><th>Time</th><th>From Speed</th><th>To Speed</th><th>Location</th></tr>
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

	Statement st1=conn1.createStatement();
	fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);


String sql="SELECT * FROM t_veh"+ rvehid+"_rd where concat(TheDate,' ',TheTime)>='"+ date1+" "+fff+"' and  concat(TheDate,' ',TheTime)<='"+ date2+" "+ttt+"' order by TheDate desc,TheTime desc";
ResultSet rst1=st1.executeQuery(sql);
while(rst1.next())
{
if (rst1.getInt("FromSpeed")<120)
	{
	%>
<tr>
	<td class="bodyText" style="text-align: left"><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%></td>
	<td class="bodyText" style="text-align: right"><%=rst1.getString("TheTime") %></td>
	<td class="bodyText" style="text-align: right"><%=rst1.getString("FromSpeed") %></td>
	<td class="bodyText" style="text-align: right"><%=rst1.getString("ToSpeed") %></td>
	<td align="left" class="bodyText"><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(rvehid,rst1.getString("TheDate"),rst1.getString("TheTime")) %></div></td>
</tr>
	<%
	
}
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
