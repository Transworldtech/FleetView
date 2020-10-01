<%@ include file="header.jsp" %>
<table border="1" bgcolor="white" width="100%">
<tr><td>
<!--Main code -->
<%!
Connection conn, conn1;
Statement st,st1,st2,st3,st4;
String transporter, data1, data2, user,selectdate;
String sql,sql1,sql2,sql3;

int oscount, racount,rdcount,crcount,dtcount,ndcount,stcount,rhcount,oscount1, racount1,rdcount1,crcount1,dtcount1,ndcount1,stcount1,rhcount1;
double rating, rating1;
 %>
<%
try
{
oscount1=0;
racount1=0;
rdcount1=0;
crcount1=0;
dtcount1=0;
ndcount1=0;
stcount1=0;
rhcount1=0;
rating1=0;
transporter=request.getParameter("transporter");
data1=request.getParameter("data1");
data2=request.getParameter("data2");
user=session.getAttribute("user").toString();
//out.print(transporter+"<br>"+data1+"<br>"+data2+"<br>"+user);
Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
st2=conn1.createStatement();
st3=conn1.createStatement();
st4=conn1.createStatement();
sql="select Jcode, ND, sum(OSCount) as oscount, sum(RACount) as racount, sum(RDCount) as rdcount, sum(CRCount) as crcount, sum(Distance) as dtcount, sum(StopCount) as stcount, sum(RDuration) as rhcount from t_driver_ds where TheDate>='"+data1+"' and TheDate <='"+data2+"' and Transporter='"+transporter+"' and JCode <> '-' group by JCode ";
ResultSet rst=st2.executeQuery(sql);
%>
<table class="stats">
<tr><th colspan="10">Exception report for Castrol trips for Transporter <%=transporter%> form date <%=data1%> to <%=data2%> .</th></tr>

<tr>
<td class="hed"><div class="bodyText"><b>Journey Code</b></div></td>
<td class="hed"><div class="bodyText"><b>OS</b></div></td>
<td class="hed"><div class="bodyText"><b>RA</b></div></td>
<td class="hed"><div class="bodyText"><b>RD</b></div></td>
<td class="hed"><div class="bodyText"><b>CD</b></div></td>
<td class="hed"><div class="bodyText"><b>DT</b></div></td>
<td class="hed"><div class="bodyText"><b>Stop</b></div></td>
<td class="hed"><div class="bodyText"><b>Run Hrs.</b></div></td>
<td class="hed"><div class="bodyText"><b>ND</b></div></td>
<td class="hed"><div class="bodyText"><b>Rating</b></div></td>
</tr>
<%
while(rst.next())
{
oscount1+=rst.getInt("oscount");
racount1+=rst.getInt("racount");
rdcount1+=rst.getInt("rdcount");
crcount1+=rst.getInt("crcount");
dtcount1+=rst.getInt("dtcount");
stcount1+=rst.getInt("stcount");
rhcount1+=rst.getInt("rhcount");
if(rst.getString("ND").equals("Yes"))
{
ndcount++;
}
%>
<tr>
<td><div class="bodyText"><%=rst.getString("JCode")%></div></td>
<td><div class="bodyText"><%=rst.getString("oscount")%></div></td>
<td><div class="bodyText"><%=rst.getString("racount")%></div></td>
<td><div class="bodyText"><%=rst.getString("rdcount")%></div></td>
<td><div class="bodyText"><%=rst.getString("crcount")%></div></td>
<td><div class="bodyText"><%=rst.getString("dtcount")%></div></td>
<td><div class="bodyText"><%=rst.getString("stcount")%></div></td>
<td><div class="bodyText"><%=rst.getString("rhcount")%></div></td>
<td><div class="bodyText"><%=rst.getString("ND")%></div></td>
<td><div class="bodyText"><%=""%></div></td>
</tr>

<%

}//end of main while.
%>
<tr>
<td class="hed"><div class="bodyText" align="right"><b>Total</b></div></td>
<td class="hed"><div class="bodyText" align="right"><b><%=oscount1%></b></div></td>
<td class="hed"><div class="bodyText" align="right"><b><%=racount1%></b></div></td>
<td class="hed"><div class="bodyText" align="right"><b><%=rdcount1%></b></div></td>
<td class="hed"><div class="bodyText" align="right"><b><%=crcount1%></b></div></td>
<td class="hed"><div class="bodyText" align="right"><b><%=dtcount1%></b></div></td>
<td class="hed"><div class="bodyText" align="right"><b><%=stcount1%></b></div></td>
<td class="hed"><div class="bodyText" align="right"><b><%=rhcount1%></b></div></td>
<td class="hed"><div class="bodyText" align="right"><b><%=ndcount1%></b></div></td>
<td class="hed"><div class="bodyText" align="right"><b>Rating</b></div></td>
</tr>
</table>
<%
}//try
catch(Exception e)
{
out.print("Exception "+e);

}
finally
{
conn.close();
conn1.close();
}
%>
<!--End of Main Code -->
</td></tr>
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
