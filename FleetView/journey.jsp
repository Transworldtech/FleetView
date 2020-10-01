<%@ include file="header.jsp" %>


<%!
Connection conn, conn1;
Statement st,st1;
String sql,vehlist,enddate;
%>
<%
java.util.Date today=new java.util.Date();
Format xxx = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
enddate = xxx.format(today);
vehlist=session.getAttribute("VehList").toString();
try{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
sql="select * from t_startedjourney where Vehid in "+vehlist+" order by StartDate desc";
ResultSet rst=st.executeQuery(sql);
%>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<table class="stats">
<tr><td class="hed"><div class="bodyText"><b>Trip ID</b></div></td>
<td class="hed"><div class="bodyText"><b>Vehicle Reg. No</b></div></td><td class="hed"><div class="bodyText"><b>Start Date</b></div></td><td class="hed"><div class="bodyText"><b>Start Location</b></div></td><td class="hed"><div class="bodyText"><b>End Location</b></div></td><td class="hed"><div class="bodyText"><b>Driver Name</b></div></td><td class="hed"><div class="bodyText"><b>Owner Name</b></div></td></tr>
<%
while(rst.next())
{

	%>

<tr><td class="bodyText"><!--<a href="startedtrip.jsp?tripid=<%=rst.getString("TripID")%>&vehcode=<%=rst.getString("VehId")%>&sdate=<%=rst.getString("StartDate")+" 00:00:00"%>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=rst.getString("OwnerName")%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("endplace")%>&enddate=<%=enddate%>&pg=st">--><%=rst.getString("TripID")%> <!-- </a>--></td>
<td class="bodyText"><div align="left"><%=rst.getString("VehRegNo")%></div> </td>
<td class="bodyText"><%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
out.print(showdate);
%> </td><td class="bodyText"><div align="left"><%=rst.getString("StartPlace")%> </div></td><td class="bodyText"><div align="left"><%=rst.getString("EndPlace")%> </div></td><td class="bodyText"><div align="left"><%=rst.getString("DriverName")%></div> </td><td class="bodyText"><div align="left"><%=rst.getString("OwnerName")%> </div></td></tr>
	<%
}
%>
</table>
</td>
</tr>
</table>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
}
%>


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
