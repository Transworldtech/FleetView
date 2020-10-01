<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st11;
String sql,sql1;

%>

<table border="0" width="100%" align="center">
<tr><td>
<%

try
{
	
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

//conn = fleetview.ReturnConnection();
//conn1 = fleetview.ReturnConnection1();
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
st3=conn1.createStatement();
st11=conn.createStatement();
%>
<table border="0" width="100%" align="center">
<tr><td align="center" colspan="10">
<font  size="3"><B>Non Tanker Drivers Report From 15-May-2010 To 15-Aug-2010</B></font>
<div class="bodyText" align="right">
Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div> 
</td>
</tr>
</table>
<table border="1" class="sortable" width="100%">

<tr>
<th>Sr.</th>
<th>DriverID</th>
<th>DriverName</th>
<th>Transporter</th>
<th>TripCount</th>
<th>KmTravelled</th>
<th>RA Count</th>
<th>RD Count</th>
<th>OS Count</th>
<th>OS Duration</th>
<th>Rating</th>
</tr>
<%
String drivernm="",transporter="";
int driverid=0,racnt=0,rdcnt=0,km=0,osduration=0,i=1,oscnt=0,tripcnt=0;
double rating=0.0;
sql="select DriverID as driverid,DriverName,OwnerName,count(DriverId) as Tripcnt,sum(KmTravelled) as km,sum(OSCount) as oscnt,sum(OSDuration) as osduration,sum(RACount) as racnt,sum(RDCount) as rdcnt,format(((((sum(RACount)+sum(RDCount))/sum(KmTravelled))*100)+(((sum(OSDuration)/10)/sum(KmTravelled))*100) ),2) as rating from t_completedjourney where StartDate between '2010-05-15 00:00:00' and '2010-08-15 23:59:59' and gpname='castrol' and tripcategory in ('primary','secondary') group by driverid order by rating asc,km desc";
ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
	driverid=rst.getInt("driverid");
	transporter=rst.getString("OwnerName");
	drivernm=rst.getString("DriverName");
	 tripcnt=rst.getInt("tripcnt");
	racnt=rst.getInt("racnt");
	rdcnt=rst.getInt("rdcnt");
	km=rst.getInt("km");
	oscnt=rst.getInt("oscnt");
	osduration=rst.getInt("osduration");
	rating=rst.getDouble("rating");
	if(km>0)
	{
	%>
	<tr>
	<td style="text-align: right"><%=i%></td>
	<td style="text-align: right"><%=driverid%></td>
	<td style="text-align: left"><%=drivernm%></td>
	<td style="text-align: left"><%=transporter%></td>
	<td style="text-align: left"><%=tripcnt %></td>
	<td style="text-align: right"><%=km%></td>
	<td style="text-align: right"><%=racnt%></td>
	<td style="text-align: right"><%=rdcnt%></td>
	<td style="text-align: right"><%=oscnt%></td>
	<td style="text-align: right"><%=osduration%></td>
	<%
if(km>0)
{
%>
	<td style="text-align: right"><%=rating%></td>
<%
}
else
{
%>
<td style="text-align: right">NA</td>
<%
}
%>
	</tr>
	
	<%
	i++;
	}
}
%>
</table> 
<%
}
	catch(Exception e)
	{
		//e.printStackTrace();
		out.println("Exception:"+e);
	}
	finally
	{
		conn.close();
		conn1.close();
	}

%>
</td></tr>
</table>

<%@ include file="footernew.jsp" %>


