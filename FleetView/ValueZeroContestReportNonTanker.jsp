<%@ include file="headernew.jsp" %>
	
<!--<script language="javascript">
 /* function validate()
  {
	  var myDate = new Date(document.getElementById("data1").value);
	  
  if(document.getElementById("data1").value=="")
  {
  
  alert("Please select the from date");
  return false;
  }
  if(document.getElementById("data2").value=="")
  {
    alert("Please select the to date");
  return false;
  }
  return true;
  //return datevalidate();
  
  }
  function datevalidate()
{ var date1=document.getElementById("data1").value;
var date2=document.getElementById("data2").value;
var dm1,dd1,dy1,dm2,dd2,dy2;
dy1=date1.substring(0,4);
dy2=date2.substring(0,4);
dm1=date1.substring(5,7);
dm2=date2.substring(5,7);
dd1=date1.substring(8,10);
dd2=date2.substring(8,10);
var date=new Date();
var month=date.getMonth()+1;
var day=date.getDate();
var year=date.getFullYear();



if(dy1>year || dy2>year)
{
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}
else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
{
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}

if(dm1==month){
if(dd1>day || dd2>day)
{
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}
}
if(dy1>dy2)
{
alert("From date year is should not be greater than to date year");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}

else if(year==dy1 && year==dy2) if(dm1>dm2)
{
alert("From date month is should not be greater than to date month");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}
if(dm1==dm2) {
if(dd1 > dd2)
{
alert("From date is should not be greater than to date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}
}
return true;
}
*/
  </script>-->
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

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st11;
String sql,sql1;

%>
<%
/*String fromdate="",todate="",transporter="",datenew1="",datenew2="";
if(!(null==request.getQueryString()))
{
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
transporter=request.getParameter("transporter");
datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
}
else
{
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew2=datenew1;

}
*/
%>
<table border="0" width="100%" align="center">
<!--<tr><td align="center">
<div align="center">
<font size="3"><B>Tanker Driver Report From 15-May-2010 To 15-Aug-2010</B></font></div>
</td></tr>-->
<tr><td>
<!--<table border="0" width="500" align="center">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<tr><td> <b>From&nbsp;&nbsp;</b>
<input type="text" id="data1" name="data1" value="< %=datenew1%>"  size="15" readonly/>
  </td><td align="left">
<input type="button" name="From Date" value="From Date" id="trigger" >
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }
  );
</script>
</td>
<td>
<b>To&nbsp;&nbsp;</b>
<input type="text" id="data2" name="data2" value="< %=datenew2%>" size="15" readonly/></td><td align="left">
<input type="button" name="To Date" value="To Date" id="trigger1">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }
  );
</script>
</td>

<td>
<input type="hidden" name="transporter" id="transporter" value="< %=session.getAttribute("usertypevalue").toString()%>">
<input type="submit" name="submit" id="submit" value="submit"></td>
</tr>
</table>-->

</td></tr>
<tr><td>
<%
//if(!(null==request.getQueryString()))
//{
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
String dateTo="";
String sqlgetdate="Select * from db_gps.t_valueZeroContestData order by Updateddatetime desc limit 1";
ResultSet rstgetdate=st.executeQuery(sqlgetdate);
if(rstgetdate.next())
{
	dateTo=rstgetdate.getString("Updateddatetime");
}
%>
<table border="0" width="100%" align="center">
<tr><td align="center">
<font  size="3"><B>Value Zero Contest Driver Report From 15-Aug-2011 To <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo)) %></B></font>
<div class="bodyText" align="right">
 <a href="excel_ValueZeroContestNonTanker.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_ValueZeroContestNonTanker.jsp');" title="Print ValueZeroContest Report"><img src="images/print.jpg" width="15px" height="15px"></a>
	 &nbsp;&nbsp;&nbsp;
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
<th>Category</th>
<th>Castrol Trip</th>
<th>Total Kms</th>
<th>VehicleCnt</th>
<th>CategoryCnt</th>
<th>TransporterCnt</th>
<th>RA</th>
<th>RD</th>
<th>OS>65</th>
<th>OSDuration>65</th>
<th>Rating</th>
<th>Trip Disconnection</th>
<th>Disconnection Km</th>
<th>ND</th>
<th>ND Kms</th>
<th>ND SMS preauthorization</th>
<th>CD</th>
<th>RunDuration>10hrs</th>
<th>Incident count</th>
<th>Total Briefing</th>
<th>Trip Briefing</th>
<th>Total Debriefing</th>
<th>Trip Debriefing</th>
</tr>
<%
String driverId="",driverName="",transporter="",tripCategory="",tripId="",startCode="",endCode="",tripRating="",vehicleCode="",vehcode="",vehicleRegistrationNumber="",tripStartDateTime="",tripEndDateTime="",ratingWithTotalCastrolKm="",ratingWithActualCastrolKm="",ratingWithosGreaterThan65dur="";
double tripFixedKm=0,totalCastrolKm=0,actualCastrolKm=0;
double totalMissingKm=0,MissingKm=0;
double tripDisconnectionKm=0;
int ndCount=0,ndKms=0,cdCount=0,tripDisconnectionCount=0,totalCastrolTrips=0;
int ndPreAuthorised=0;
int totalBriefingCount=0,totalDebriefingCount=0;
int tripBriefingCount=0,incidentCount=0,tripdeBriefingCount=0,runDurationGreaterthan10hrscount=0;
int raCount=0,rdCount=0,osDuration=0,OScount=0,vehCount=0,transporterCount=0,categoryCount=0,osCntGreaterThan65=0,osGreaterThan65cnt=0,zoneOsCount=0,osGreaterThan65dur=0;;
int count=0;
sql="Select * from db_gps.t_valueZeroContestData where Updateddatetime like '%"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo))+"%'  and tripCategory in('Primary','Secondary') order by totalCastrolKm desc ";
ResultSet rstgetdata=st.executeQuery(sql);
while(rstgetdata.next())
{
	count++;
	driverId=rstgetdata.getString("driverId");
	driverName=rstgetdata.getString("driverName");
	transporter=rstgetdata.getString("transporter");
	tripCategory=rstgetdata.getString("tripCategory");
	totalCastrolTrips=rstgetdata.getInt("totalCastrolTrips");
	totalCastrolKm=rstgetdata.getDouble("totalCastrolKm");
	vehCount=rstgetdata.getInt("vehCount");
	transporterCount=rstgetdata.getInt("transporterCount");
	categoryCount=rstgetdata.getInt("categoryCount");
	raCount=rstgetdata.getInt("raCount");
	rdCount=rstgetdata.getInt("rdCount");
	//OScount=rstgetdata.getInt("OScount");
	//osDuartion=rstgetdata.getInt("osDuartion");
	ratingWithTotalCastrolKm=rstgetdata.getString("ratingWithTotalCastrolKm");
	osGreaterThan65cnt=rstgetdata.getInt("osGreaterThan65cnt");
	osGreaterThan65dur=rstgetdata.getInt("osGreaterThan65dur");
	ratingWithosGreaterThan65dur=rstgetdata.getString("ratingWithosGreaterThan65dur");
	tripDisconnectionCount=rstgetdata.getInt("tripDisconnectionCount");
	tripDisconnectionKm=rstgetdata.getDouble("tripDisconnectionKm");
	ndCount=rstgetdata.getInt("ndCount");
	ndKms=rstgetdata.getInt("ndKms");
	ndPreAuthorised=rstgetdata.getInt("ndPreAuthorised");
	cdCount=rstgetdata.getInt("cdCount");
	runDurationGreaterthan10hrscount=rstgetdata.getInt("runDurationGreaterthan10hrscount");
	incidentCount=rstgetdata.getInt("incidentCount");
	totalBriefingCount=rstgetdata.getInt("totalBriefingCount");
	tripBriefingCount=rstgetdata.getInt("tripBriefingCount");
	totalDebriefingCount=rstgetdata.getInt("totalDebriefingCount");
	tripdeBriefingCount=rstgetdata.getInt("tripdeBriefingCount");
   
   			
	%>
	<tr>
	<td><%=count%></td>
	<td><%=driverId%></td>
	<td><%=driverName%></td>
	<td><%=transporter%></td>
	<td><%=tripCategory %></td>
	<td><%=totalCastrolTrips %></td>
	<td><%=totalCastrolKm%></td>
	<td><%=vehCount%></td>
	<td><%=transporterCount%></td>
	<td><%=categoryCount%></td>
	<td><%=raCount%></td>
	<td><%=rdCount%></td>
	<td><%=osGreaterThan65cnt%></td>
	<td><%=osGreaterThan65dur%></td>
	<td><%=ratingWithosGreaterThan65dur%></td>
	<td><%=tripDisconnectionCount%></td>
	<td><%=tripDisconnectionKm%></td>
	<td><%=ndCount%></td>
	<td><%=ndKms%></td>
	<td><%=ndPreAuthorised%></td>
	<td><%=cdCount%></td>
	<td><%=runDurationGreaterthan10hrscount%></td>
	<td><%=incidentCount%></td>
	<td><%=totalBriefingCount%></td>
	<td><%=tripBriefingCount%></td>
	<td><%=totalDebriefingCount%></td>
	<td><%=tripdeBriefingCount%></td>
	</tr>
	<%
		
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
//}
%>

</table> 


</td></tr>
</table>

<%@ include file="footernew.jsp" %>


