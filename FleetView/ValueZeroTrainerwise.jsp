<%@ include file="headernew.jsp" %>
	
<script language="javascript">  
function gotoPrint(divName)  
{  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId, frmFldId)
{  
	      var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId);  
          oFld.value = obj.innerHTML;  
          
          document.valuezerodata.action ="excel.jsp";
          document.forms["valuezerodata"].submit();	
 }  

	function getvalue()
	{
		var category1=document.getElementById("category").value;
		document.getElementById("category").value=category;
		
	}
	
	</script>
<script LANGUAGE="JavaScript1.2" SRC="js/graph.js"></script>
<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st11;
String sql,sql1;

%>
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


String sqlgetdate="Select * from db_gps.t_valueZeroContestTrainerwise order by Updateddatetime desc limit 1";
ResultSet rstgetdate=st.executeQuery(sqlgetdate);
if(rstgetdate.next())
{
	dateTo=rstgetdate.getString("Updateddatetime");
	
}
//System.out.println("====================Value Zero Contest=================");
String category="";
if(null==request.getQueryString()){
	category="All";
}
else{
	category=request.getParameter("category");
}
String exportFileName=session.getAttribute("user").toString()+"_valuezerodata.xls";

%>
<html><body>
<form name="valuezerocontestform" action="" method="get">
<table border="0" width="700" align="center">
<tr>
<td>
<div align ="center"><B>Category:</B>
<select name="category" style="" onchange="getvalue()">
 			<option value="all" <% if(category.equals("all")){ %>Selected<% } %>>All</option>
		    <option value="briefing" <% if(category.equals("briefing")){ %>Selected<% } %>>Briefing</option>
			<option value="debriefing" <% if(category.equals("debriefing")){ %>Selected<% } %>>DeBriefing</option>
			<!--<option value="tanker" < % if(category.equals("tanker")){ %>Selected< % } %>>Tanker</option>-->
	

</select>
<input type="hidden" name="transporter" id="transporter"
					value="<%=session.getAttribute("usertypevalue").toString()%>">
				&nbsp;&nbsp;<input type="submit" name="submit" id="submit"
					value="Submit">
</div>
</td>
</tr>
</table>
</form>

<%

if(category.equalsIgnoreCase("briefing")){
	sql="Select * from db_gps.t_valueZeroContestTrainerwise where Updateddatetime like '%"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo))+"%'  and type ='briefing' order by totalCastrolKm desc ";
}
if(category.equalsIgnoreCase("debriefing")){
	sql="Select * from db_gps.t_valueZeroContestTrainerwise where Updateddatetime like '%"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo))+"%'  and type ='debriefing' order by totalCastrolKm desc ";
}
if(category.equalsIgnoreCase("All")){
	sql="Select * from db_gps.t_valueZeroContestTrainerwise where Updateddatetime like '%"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo))+"%'  and type in('briefing','debriefing') order by type asc, totalCastrolKm desc ";
}
System.out.println("Value Zero trainerwise sql==>"+sql);
ResultSet rstgetdata=st.executeQuery(sql);

%>
<form id="valuezerodata" name="valuezerodata" action="" method="post">
<div id="table1">
<table border="1" width="100%" align="center">
<tr><td align="center" colspan="15">
<font size="3"><B>Value Zero TrainerWise Report From 15-Aug-2011 To 23-Nov-2011<%//=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTo)) %></B></font>
<div class="bodyText" align="right">

    <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
    <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName %>" /> 
	
	<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
    <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
    <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
    <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>

Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div> 
</td>
</tr>
</table>
<table id="mytable" border="1" width="100%" align="center" class="sortable">
<tr>
<th>Sr.</th>
<%
	if(category.equalsIgnoreCase("All")){
%>
<th>Type</th>
<%
	} 
%>
<th>TrainerName</th>
<%
	if(category.equalsIgnoreCase("briefing")){
%>
<th>Total Briefing</th>
<th>Total Trip briefing</th>
<th>Unique driver briefing</th>
<th>Unique transporter briefing</th>
<%
	} 
%>
<%
	if(category.equalsIgnoreCase("debriefing")){
%>
<th>Total DeBriefing</th>
<th>Total Trip DeBriefing</th>
<th>Unique driver DeBriefing</th>
<th>Unique transporter DeBriefing</th>
<%
	} 
%>
<%
	if(category.equalsIgnoreCase("All")){
%>
<th>Total Briefing/DeBriefing</th>
<th>Total Trip briefing/DeBriefing</th>
<th>Unique driver briefing/DeBriefing</th>
<th>Unique transporter briefing/DeBriefing</th>
<%
	} 
%>
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
</tr>
<%

System.out.println("category==>"+category);
String type="",trainerName="",driverId="",driverName="",transporter="",tripCategory="",tripId="",startCode="",endCode="",tripRating="",vehicleCode="",vehcode="",vehicleRegistrationNumber="",tripStartDateTime="",tripEndDateTime="",ratingWithTotalCastrolKm="",ratingWithActualCastrolKm="",ratingWithosGreaterThan65dur="";
double tripFixedKm=0,totalCastrolKm=0,actualCastrolKm=0;
double totalMissingKm=0,MissingKm=0;
double tripDisconnectionKm=0;
int ndCount=0,ndKms=0,cdCount=0,tripDisconnectionCount=0,totalCastrolTrips=0;
int ndPreAuthorised=0;
int totalBriefingCount=0,totalDebriefingCount=0;
int tripBriefingCount=0,incidentCount=0,tripdeBriefingCount=0,runDurationGreaterthan10hrscount=0;
int raCount=0,rdCount=0,osDuration=0,OScount=0,vehCount=0,transporterCount=0,categoryCount=0,osCntGreaterThan65=0,osGreaterThan65cnt=0,zoneOsCount=0,osGreaterThan65dur=0;;
int count=0,totaltripbriefingcount=0,totaldriverbriefing=0,totaltransporterbreifing=0;

while(rstgetdata.next())
{
	count++;
	type=rstgetdata.getString("type");
	trainerName=rstgetdata.getString("trainername");
	totaltripbriefingcount=rstgetdata.getInt("totalBriefingCount");
	tripBriefingCount=rstgetdata.getInt("totaltripbriefingcount");
	totaldriverbriefing=rstgetdata.getInt("totaldriverbriefingcount");
	totaltransporterbreifing=rstgetdata.getInt("totaltransporterbriefingcount");
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
	%>
	<tr>
	<td><%=count%></td>
<%
	if(category.equalsIgnoreCase("All")){
%>
	<td><%=type%></td>
<%
	} 
%>
	<td><%=trainerName%></td>
	<td><%=totaltripbriefingcount%></td>
	<td><%=tripBriefingCount%></td>
	<td><%=totaldriverbriefing%></td>
	<td><%=totaltransporterbreifing%></td>
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
	
	</tr>
	
	<%
		
   }

%>

</table>

<%
}
	catch(Exception e)
	{
		e.printStackTrace();
		//out.println("Exception:"+e);
	}
	finally
	{
		conn.close();
		conn1.close();
	}
//}
%>
<%@ include file="footernew.jsp" %>
</table>
</div>
</form>
</body>
</html>


