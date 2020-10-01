<%@ include file="header.jsp" %>
<%!
Connection conn, conn1;
Statement st,st1;
String sql,sdate,edate;
%>
<%
try{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
sql="select * from t_completedjourney order by StartDate desc";
ResultSet rst=st.executeQuery(sql);
%>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<table class="stats">
<tr>
<td class="hed"><div class="bodyText"><b>Trip ID</b></div></td>
<td class="hed"><div class="bodyText"><b>Vehicle Reg. No</b></div></td>
<td class="hed"><div class="bodyText"><b>Start Date</div></b></td>
<td class="hed"><div class="bodyText"><b>End Date</div></b></td>
<td class="hed"><div class="bodyText"><b>Start Place</div></b></td>
<td class="hed"><div class="bodyText"><b>End Place</div></b></td>
<td class="hed"><div class="bodyText"><b>Distance</div></b></td>
<td class="hed"><div class="bodyText"><b>Avg. Speed</div></b></td>
<td class="hed"><div class="bodyText"><b>Duration</div></b></td>
<td class="hed"><div class="bodyText"><b>Driver Name</div></b></td>
<td class="hed"><div class="bodyText"><b>Owner Name</div></b></td>
</tr>
<%
while(rst.next())
{
%>
<tr>
<td class="bodyText"><div align="left">
<a href="startedtrip.jsp?tripid=<%=rst.getString("TripID")%>&vehcode=<%=rst.getString("VehId")%>&sdate=<%=rst.getString("StartDate")%>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=rst.getString("OwnerName")%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("endplace")%>&enddate=<%=rst.getString("EndDate")%>&pg=cm"><%=rst.getString("TripID")%> </a>
</div></td>
<td class="bodyText"><div align="left"><%=rst.getString("VehRegNo")%></div></td>
<td class="bodyText"><div align="left"><%
java.util.Date sd1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
Format fmt1 = new SimpleDateFormat("dd-MMM-yyyy");
String sh1 = fmt1.format(sd1);
 out.print(sh1);%></div></td>
<td class="bodyText"><div align="left"><%
java.util.Date sd2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
Format fmt2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sh2 = fmt2.format(sd2);
 out.print(sh2);%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("StartPlace")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("EndPlace")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("KmTravelled")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("AvgRunningSpeed")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("RunningDuration")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("DriverName")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("OwnerName")%></div></td>
</tr>

<%
}
%>
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
