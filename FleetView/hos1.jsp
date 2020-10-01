
<%@ include file="Connections/conn.jsp" %>

<%!
Connection conn, conn1;
String date1,date2,mode,rvehid,hvrno;
%>
<%

date1=session.getAttribute("hdate1").toString();
date2=session.getAttribute("hdate2").toString();
mode=session.getAttribute("mode").toString();
rvehid=session.getAttribute("hvid").toString();
hvrno=session.getAttribute("hvrno").toString();

String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString();
%>
<%! String dd,aa; %>

<table border="1" width="100%">
<tr><td>
<table border="0" width="100%" background="images/background1.bmp"><tr><td align="center"><a href="MainformMap2.jsp<%=ll %>">Map</a></td><td align="center"><a href="historypiechart.jsp">Pie Chart</a></td><td align="center"><a href="historybarchart.jsp">Bar Chart</a></td></tr></table>
</td></tr>
<tr><td>

<table border="1" width="100%" class="stats">
<tr><td class="hed">Over Speed Report For <%=hvrno %> From date <%=session.getAttribute("HisShowDate").toString()%> to <%=session.getAttribute("HisShowDate1").toString()%> 

</td></tr>

<tr><td>

<table width="100%" border="1" class="stats">
<tr><td class="hed">Date </td><td class="hed">Time</td><td class="hed">Speed</td><td class="hed">Distance travaled in Km</td><td class="hed">Location</td></tr>
<%
try{
	Class.forName("org.gjt.mm.mysql.Driver"); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement st1=conn.createStatement();


String sql="SELECT * FROM t_veh"+ rvehid+" where TheFieldDataDate>='"+ date1+"' and  TheFieldDataDate<='"+ date2 +"' and TheFiledTextFileName='OS' order by TheFieldDataDate desc,TheFieldDataTime desc";
ResultSet rst1=st1.executeQuery(sql);
while(rst1.next())
{
	%>
<tr>
	<td class="bodyText"><%=rst1.getString("TheFieldDataDate") %></td>
	<td class="bodyText"><%=rst1.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst1.getString("Speed") %></td>
	
	<td class="bodyText"><%=rst1.getString("Distance") %></td>
	<td class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject") %></div></td>
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
</td></tr>


</table>
