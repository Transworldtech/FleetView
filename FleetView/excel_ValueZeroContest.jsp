<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"ValueZeroContest_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
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
String dateTo="";


String sqlgetdate="Select * from db_gps.t_valueZeroContestData order by Updateddatetime desc limit 1";
ResultSet rstgetdate=st.executeQuery(sqlgetdate);
if(rstgetdate.next())
{
	dateTo=rstgetdate.getString("Updateddatetime");
	
}
//System.out.println("====================Value Zero Contest=================");

String category=request.getParameter("category");

%>
<form name="valuezerocontestform" action="" method="get">
<table border="0" width="100%" align="center">
<tr><td align="center">
<font  size="3"><B>Value Zero Contest Driver Report From 15-Aug-2011 To <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo)) %></B></font>
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
<th>TransporterCnt</th>
<th>CategoryCnt</th>
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
<th>Trip briefing</th>
<th>Total debriefing</th>
<th>Trip debriefing</th>
</tr>
<%

System.out.println("category==>"+category);
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

if(category.equalsIgnoreCase("Primary")){
	sql="Select * from db_gps.t_valueZeroContestData where Updateddatetime like '%"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo))+"%'  and tripCategory ='Primary' order by totalCastrolKm desc ";
}
if(category.equalsIgnoreCase("Secondary")){
	sql="Select * from db_gps.t_valueZeroContestData where Updateddatetime like '%"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo))+"%'  and tripCategory ='Secondary' order by totalCastrolKm desc ";
}
if(category.equalsIgnoreCase("Tanker")){
	sql="Select * from db_gps.t_valueZeroContestData where Updateddatetime like '%"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo))+"%'  and tripCategory ='Tanker' order by totalCastrolKm desc ";
}
if(category.equalsIgnoreCase("All")){
	sql="Select * from db_gps.t_valueZeroContestData where Updateddatetime like '%"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo))+"%'  and tripCategory in('Tanker','Primary','Secondary') order by tripCategory asc, totalCastrolKm desc ";
}
System.out.println("Value Zero Contest sql==>"+sql);
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

%>

</table> 


</td></tr>
</table>

<%@ include file="footernew.jsp" %>

