<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<!--<script type="text/javascript">

function toggleDetails(id, show)
{
var popup = document.getElementById("popup"+id);
if (show) {
popup.style.visibility = "visible";
popup.setfocus();

} else {
popup.style.visibility = "hidden";
}
}
</script>-->
<!--<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}
</style>-->
<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st11;
String sql,sql1;

%>

<table border="0" width="100%" align="center">
<tr><td>
<%

	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2); 
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
<font  size="3"><B>Tanker Driver Report From 15-May-2010 To 15-Aug-2010</B></font>
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
<th>Tripcount</th>
<th>KmTravelled</th>
<th>RA Count</th>
<th>RD Count</th>
<th>OS Count</th>
<th>OS Duration</th>
<th>Rating</th>
</tr>
<%
String vehregno="",transporter="",drivernm="",startdate="",driverid1="",startdate1="";
int vehid=0,racnt=0,rdcnt=0,km=0,osduration=0,i=1,j=1,k=1,oscnt=0,driverid=0,tripcnt=0;
double rating=0.0;

sql="select DriverId,DriverName,Transporter,count(DriverId) as Tripcnt,sum(Distance) as Distance,sum(OSCount) as OSCount,sum(RACount) as RACount,sum(RDCount) as RDCount,sum(OSDuration) as OSDuration,format(((((sum(RACount)+sum(RDCount))/sum(Distance))*100)+(((sum(OSDuration)/10)/sum(Distance))*100) ),2) as rating from t_tanker where Distance > 0 group by DriverId order by rating asc,Distance desc";
ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
	
	driverid=rst.getInt("DriverId");
    drivernm=rst.getString("DriverName");
    transporter=rst.getString("Transporter");
    tripcnt=rst.getInt("tripcnt");
    oscnt=rst.getInt("OSCount");
   	racnt=rst.getInt("RACount");
   	rdcnt=rst.getInt("RDCount");
   	km=rst.getInt("Distance");
   	osduration=rst.getInt("OSDuration");
   	rating=rst.getDouble("rating");
   
   			
	%>
	<tr>
	<td><%=j%></td>
	<td><%=driverid%></td>
	<td><%=drivernm%></td>
	<td><%=transporter%></td>
	<td><%=tripcnt %></td>
	<td><%=km%></td>
	<td><%=racnt%></td>
	<td><%=rdcnt%></td>
	<td><%=oscnt%></td>
	<td><%=osduration%></td>
	<%
	if(km>0)
	{
	%>
	<td><%=rating %></td>
	<%
	}
	else
	{
	%>
		<td>NA</td>
	<%
	}
	%>
	</tr>
	<%
	
	j++;
	
    }




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

</table> 


</td></tr>
</table>

<%@ include file="footernew.jsp" %>


