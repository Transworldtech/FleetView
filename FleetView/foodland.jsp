<%@ include file="header.jsp" %>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<!--Main code -->
<%!
Connection conn;
Statement st,st1;
ResultSet rst;
String sql,data1,data2;
int cnt=0;
long ms1,ms2;
%>
<%
data1="2008-07-11 00:00:00";
data2="2008-07-12 23:59:59";
try{
	cnt=0;
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
	st=conn.createStatement();
	st1=conn.createStatement();
while(true)
{
sql="SELECT TheFieldDataDate,TheFieldDataTime,TIMEDIFF(concat(TheFieldDataDate,' ',TheFieldDataTime),'"+data1+"') as dt1 from t_veh754 where TIMEDIFF(concat(TheFieldDataDate,' ',TheFieldDataTime),'"+data1+"') like '00:15%' order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc";
	
rst=st.executeQuery(sql);
	
while(rst.next())
	
{
	out.print(data1+"   "+rst.getString(1)+"  "+rst.getString(2)+"  "+rst.getString("dt1")+"<br>");
	
data1=rst.getString(1)+" "+rst.getString(2);

}
cnt++;
if (cnt > 200)
{
	break;
}
}
}catch(Exception e)
{
	out.print("Exception--->"+e);
}
finally
{
	conn.close();
}
%>
</td></tr>
</table>
<!-- footer start here -->
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%" >
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
