<%@page import="com.transworld.fleetview.framework.VehiclePositionData"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
		import="com.transworld.fleetview.framework.VehiclePositionsViewData"
		import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.Utilities"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataResults"%>

<%@ include file="headernew.jsp"%>
<%!String condtn="ShowTripInfo"; %>
<link href="css/currentPositions.css" rel="stylesheet" type="text/css"></link>

<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>

<jsp:useBean id="vehiclePositionsViewDataProvider" 
			 type="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
			 scope="application"></jsp:useBean>			 

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page"></jsp:useBean>	 
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<%!Connection conn=null, conn1=null;
	Statement st1=null;
%>
<script type="text/javascript">

function loadSearchHighlight()
{
	SearchHighlight();
	document.searchhi.h.value = searchhi_string;
	if( location.hash.length > 1 ) location.hash = location.hash;     
}
</script>

<body onLoad="javaScript:loadSearchHighlight();">

<script type="text/javascript">

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

function toggleDetails1(id, show)
{	
	var popupx = document.getElementById("popupx"+id);
	if (show) {
		popupx.style.visibility = "visible";
		popupx.setfocus();
	} else {
		popupx.style.visibility = "hidden";
	}
}

function article(programName,width,height)
{
	var temp = "menubar=yes,toolbar=no,location=no,status=yes,scrollbars=yes,resizable=yes,width="+width+",height="+height; 
	displayWindow=window.open(programName,"displayWindow",temp) ;
}

function fun(aa)
{
	document.searchform.h.value=aa.value;
}

//////////////////////////////


function showhide1()
{
	//alert("onclick hide trip button value is 1: ");
	var cnt=document.getElementById("cnt").value;
	var tda, tdb,tdc,tdd,tde;
	var tdx=document.getElementById("tdx").value;
	//var tds=document.getgetElementById("tds").value;
	var condition="";
	//alert("onclick hide trip button value is 2: "+ tdx);
	if(tdx=="Hide Trip Info")
	{
		//alert("onclick hide trip button value is (if): "+ tdx);
		for(i=0;i<=cnt;i++)
		{	
			tda=document.getElementById("tda"+i);
			tda.style.display='none';
			tdb=document.getElementById("tdb"+i);
			tdb.style.display='none';
			tdc=document.getElementById("tdc"+i);
			tdc.style.display='none';
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='none';
			tde=document.getElementById("tde"+i);
			tde.style.display='none';
			document.getElementById("tdx").value="Show Trip Info";
		}
		/*if(tdx=="Show Trip Info" && tds==" Show Fuel Info")
		{
			condition="HideTripInfoHideFuelInfo";
		}
		if(tdx=="Hide Trip Info" && tds==" Show Fuel Info")
		{
			condition="ShowTripInfoHideFuelInfo";
		}*/

	//	document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'printdisconnected.jsp?tdx=hide\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';
	//	document.getElementById("excel").innerHTML='<a href="exceldisconnected.jsp?&tdx=hide" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
		
		//document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'GenericPrint.jsp?&sessiondata=VehiclePositionsViewData&key=Device Disconnected&condition=HideTripInfo\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';
		//document.getElementById("excel").innerHTML='<a href="GenericExportExcel.jsp?&sessiondata=VehiclePositionsViewData&key=Device Disconnected&condition=HideTripInfo title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	}
	else
	{
		for(i=0;i<=cnt;i++)
		{	
			tda=document.getElementById("tda"+i);
			tda.style.display='';
			tdb=document.getElementById("tdb"+i);
			tdb.style.display='';
			tdc=document.getElementById("tdc"+i);
			tdc.style.display='';
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='';
			tde=document.getElementById("tde"+i);
			tde.style.display='';
			document.getElementById("tdx").value="Hide Trip Info";
		}
		/*if(tdx=="Show Trip Info" && tds==" Show Fuel Info")
		{
			condition="HideTripInfoHideFuelInfo";
		}
		if(tdx=="Hide Trip Info" && tds==" Show Fuel Info")
		{
			condition="ShowTripInfoHideFuelInfo";
		}*/

	//	document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'printdisconnected.jsp?tdx=show\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';	
	//	document.getElementById("excel").innerHTML='<a href="exceldisconnected.jsp?&tdx=show"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
		//document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'GenericPrint.jsp?&sessiondata=VehiclePositionsViewData&key=Device Disconnected&condition=ShowTripInfo\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';	
		//document.getElementById("excel").innerHTML='<a href="GenericExportExcel.jsp?&sessiondata=VehiclePositionsViewData&key=Device Disconnected&condition=ShowTripInfo"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	}
}

/////////////////////////////////


function showPrint()
{
	//alert("in print");
	//var tds=document.getElementById("tds").value;
	//alert("after show fuel :"+tds);
	var tdx=document.getElementById("tdx").value;
	//alert("after hide trip :"+tdx);
	if(tdx=="Show Trip Info")
	{
		condition="HideTripInfo";
	}
	if(tdx=="Hide Trip Info")
	{
		condition="ShowTripInfo";
	}
	
	window.open("GenericPrint.jsp?&sessiondata=VehiclePositionsViewData&key=Device Disconnected&condition="+condition);
	
}

function showExcel()
{
	//var tds=document.getElementById("tds").value;
	var tdx=document.getElementById("tdx").value;
	if(tdx=="Show Trip Info")
	{
		condition="HideTripInfo";
	}
	if(tdx=="Hide Trip Info")
	{
		condition="ShowTripInfo";
	}
	window.open("GenericExportExcel.jsp?&sessiondata=VehiclePositionsViewData&key=Device Disconnected&condition="+condition);
	
}
//////////////////////////////


function enablesearch()
{
	if(document.getElementById("search").style.display=='none')
	{
		document.getElementById("search").style.display='block';
	}
	else
	{
		document.getElementById("search").style.display='none';
	}
}



//---------------------------- validation for Search through vehicle or driver-------------
function validaterdb()
{
	var rdb=document.searchhi.rdbsearch.length;
	var i=0;
	var flag=false;
	for(i=0;i<rdb;i++)
	{
		if(document.searchhi.rdbsearch[i].checked)
		{
			flag=true;
		}				
	} 
	if(flag==false)
	{
		alert("Please Select one option");
		return false; 
	}			
	return true;
}

//----------------------------------------------------------------------


</script>

<jsp:include page="CurrentPositionSearchLink.jsp" />

	<table border="0" width="100%" align="center"> 
 	
	<tr></tr>
	</table>
<%!private String getFromDate() {

		String fromdate = "";
		final String sdate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new java.util.Date());
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(sdate1));
		} catch (Exception e) {
			try {
				fromdate = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("yyyy-MM-dd")
								.parse(sdate1));
			} catch (Exception e1) {
			}
		}
		return fromdate;
	}

	private String getToDate() {

		String todate = "";
		final String sdate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new java.util.Date());
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(sdate1));
		} catch (Exception e) {
			try {
				todate = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("yyyy-MM-dd")
								.parse(sdate1));
			} catch (Exception e1) {
			}
		}
		return todate;
	}

	private int getFromTimeHrs() {
		return 0;
	}

	private int getFromTimeMins() {
		return 0;
	}

	private int getToTimeHrs() {
		return 23;
	}

	private int getToTimeMins() {
		return 59;
	}

	private String getTripStartDate(final String datetime) {
		String fromdate = "";
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(datetime));
		} catch (Exception e) {
			try {
				fromdate = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("yyyy-MM-dd")
								.parse(datetime));
			} catch (Exception e1) {
			}
		}
		return fromdate;
	}

	private String getTripEndDate(final String datetime) {
		String todate = "";
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new java.util.Date());
		} catch (Exception e) {
		}
		return todate;
	}

	private String getTripStartTimeHrs(final String datetime) {
		String ftime1 = "00";
		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(datetime);
			ftime1 = new SimpleDateFormat("HH").format(dt);
		} catch (Exception e) {
		}
		return ftime1;
	}

	private String getTripStartTimeMins(final String datetime) {
		String ftime2 = "00";
		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(datetime);
			ftime2 = new SimpleDateFormat("mm").format(dt);
		} catch (Exception e) {
		}
		return ftime2;
	}

	private String getTripEndTimeHrs(final String datetime) {
		String ttime1 = "23";
		try {
			ttime1 = new SimpleDateFormat("HH").format(new java.util.Date());
		} catch (Exception e) {
		}
		return ttime1;
	}

	private String getTripEndTimeMins(final String datetime) {
		String ttime1 = "59";
		try {
			ttime1 = new SimpleDateFormat("mm").format(new java.util.Date());
		} catch (Exception e) {
		}
		return ttime1;
	}

	private boolean isOSTodayZero(String osToday) {
		try {
			if (Integer.parseInt(osToday) > 0) {
				return true;
			}
		} catch (Exception e) {
		}
		return false;
	}

	private String getfuelAlert_AddedTodayDate() {
		String today = "", prevDay = "";
		Calendar cal;
		DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
		cal = Calendar.getInstance();
		today = dateFormat.format(cal.getTime());
		return today;

	}

	private String getfuelAlert_AddedPreviousDate() {
		String today = "", prevDay = "";
		Calendar cal;
		DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");

		cal = Calendar.getInstance();
		today = dateFormat.format(cal.getTime());

		cal.add(Calendar.DATE, -1);
		prevDay = dateFormat.format(cal.getTime());

		return prevDay;

	}%>
<%
	final String userTypeValue = session.getAttribute("usertypevalue")
			.toString();
	final String typeOfUser = session.getAttribute("TypeofUser")
			.toString();
	final String distanceFormat = session.getAttribute("distformat")
			.toString();
	final String fuelFormat = session.getAttribute("fuelformat")
			.toString();
	final String commaSeparatedVehicleList = session.getAttribute(
			"VehList").toString();
	final int disConnected = Integer.parseInt(session.getAttribute(
			"desconnected").toString());
	final String fromPage="currentPosition";
	String requestParamSearchVeh = request.getParameter("searchveh");
	if (null == requestParamSearchVeh) {
		requestParamSearchVeh = "";
	}

	@SuppressWarnings("unchecked")
	final VehiclePositionsViewDataResults viewData = 
		(VehiclePositionsViewDataResults) session.getAttribute("VehiclePositionsViewData");
	int numRecords = 0;
	try{
		 numRecords = viewData.getCount();
	} catch(Exception e){
		e.printStackTrace();
	}	
	
	try
	{
		conn = fleetview.ReturnConnection();
		//conn1 = fleetview.ReturnConnection1();
		st1=conn.createStatement();
	
	}
	catch(Exception e)
	{
		System.out.println(">>>>>>>>>>>>>>>>>>>>Exceptions:"+e);
	}
	
%>


<jsp:include page="SubUserView.jsp">
	<jsp:param name="username" value="<%=requestParamSearchVeh%>"/>
</jsp:include>

	<form name="CountOfRecordsForm">
		<input type="hidden" name= "cnt" id="cnt" value=<%=numRecords%>></input>
	</form>

<table width="100%" align="center">
	<tr>
		<td align="center">
		<!-- <div align="left"><font size="3">Report No:1.3</font></div>-->
		<div><font size="3"><b> Device Disconnected Vehicle
		</b></font></div></td>
		
		
	</tr>
</table>
<table border="0" width="100%" align="center"> 
		<tr bgcolor="#F0E68C">
			<td class="sorttable_nosort" width="15%">
				<b>Color Code Indications :&nbsp;&nbsp;<a href="currentposition.jsp"><span>Full Fleet</span></a>
				</b>
			</td>
			<td bgcolor="#CCFFCC" class="sorttable_nosort"><b><a href="moving.jsp">Moving</a></b></td>
			<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b><a href="stopped.jsp">Stop</a></b></td>
			<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="activeTrips.jsp">ActiveTrips</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
			
			<td bgcolor="#DCDCDC" class="sorttable_nosort"><b><a href="disconnected.jsp">Disconnected</a></b></td>
			<td bgcolor="#BDEDFF" class="sorttable_nosort"><b><a href="removed.jsp">Removed</a></b></td>
			<td bgcolor="#EEC5C8" class="sorttable_nosort" ><b><a href="deactivate.jsp">Deactivated</a></b></td>
			<td bgcolor="#D4C0F0" class="sorttable_nosort" ><b><a href="missing.jsp">Missing</a></b></td>
					<td bgcolor="#FFC475" class="sorttable_nosort"><b><a href="maindisconnected.jsp">Mains Disconnection</a></b></td>
			
			<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="notactive.jsp">Not Active</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="Hide Trip Info" onclick="showhide1();" class="formElement" id="tdx" name="tdx" >
			</td>
			
			<td bgcolor="#FFFFFF" id="print">
			
			<!--<a href="#"
			onclick="javascript:window.open('printdisconnected.jsp?tdx=show');"
			title="Print Report"><img src="images/print.jpg" width="15px"
			height="15px"></a>-->
			
			<a id ="print" href="#" onclick="showPrint();" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;</td>
				
			<td bgcolor="#FFFFFF" id="excel">
			<!--<a href="exceldisconnected.jsp?tdx=show"
			title="Export to Excel"><img src="images/excel.jpg" width="15px"
			height="15px"></a>-->
			<a id="excel" href="#" onclick="showExcel();" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;</td>
			<td bgcolor="#FFFFFF"><%=Utilities.printDate()%></td>
		</tr>
	</table>	

	<table width="100%" border="1" align="center" class="sortable">
		<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Vehicle Reg.No.</th>
			<th class="hed"> Updated</th>
			<th class="hed" id="tdd0"> Trip Id</th>
			<th class="hed" id="tde0"> Driver Name(Code)</th>
			<th class="hed" id="tda0"> Trip Origin</th>
			<th class="hed" id="tdb0"> Start Date</th>
			<th class="hed" id="tdc0"> Trip Destination</th>
			<th class="hed" > Location - Click To View On Map.</th>
			<th class="hed"> Fuel</th>
			<th class="hed"> Fuel Alert</th>
<%
	if (vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage)) {
%>
			<th><b>Sen1</b></th>
			<th><b>Sen2</b></th>
			<th><b>Sen3</b></th>
			<th><b>Sen4</b></th>
<%
	}
%>
		</tr>	
<%
		try {
			int i = 1;
			String bgcolor="background-color:#FFFFCC";
			for (int counter = 0; counter < numRecords; counter++) 
			{
				final VehiclePositionsViewData currentRecord = viewData.getVehiclePositionViewDataAtIndex(counter);
				if(currentRecord.getFinalDeviceStatus().contains("Device Disconnected")||currentRecord.getFinalDeviceStatus().contains("Device Removed"))
				{
					continue;
				}
				if("0".equalsIgnoreCase(currentRecord.getSpeed()) && bgcolor.equals(currentRecord.getBgColor())) {
	%>	
		<tr>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=i%></td>
			<td style="text-align:left;<%=currentRecord.getBgColor()%>">
<%
	if (currentRecord.isDataBlocked()) {
%>
		<%=currentRecord.getVehicleRegistrationNo()%>
<%
	} else {
%>
			
			<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><font size="2"><%=currentRecord.getVehicleRegistrationNo()%></font></a>
			
				<div class="popup" id="popup<%=i%>">
				<table border="1" bgcolor="white">
		   	<tr>  
				<td> <a href="veh_Violation_report.jsp?vid=<%=currentRecord.getVehicleCode()%>&rpttime=24hr" onclick="toggleDetails(<%=i%>,false);">Report For Last 24 Hours </a>
				</td>
		   	</tr>
		   	<tr>
		   	<td> <a href="veh_Violation_report.jsp?vid=<%=currentRecord.getVehicleCode()%>&rpttime=48hr" onclick="toggleDetails(<%=i%>,false);">Report For Last 48 Hours </a>
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="veh_Violation_report.jsp?vid=<%=currentRecord.getVehicleCode()%>&rpttime=7day" onclick="toggleDetails(<%=i%>,false);">Report For Last 7 Days </a>
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="veh_Violation_report.jsp?vid=<%=currentRecord.getVehicleCode()%>&rpttime=15day" onclick="toggleDetails(<%=i%>,false);">Report For Last 15 Days </a>
				</td>
		   	</tr>
		   	<tr>
				<td> 
				<a href="ShowCustomReportonTWMap.jsp?tripid=''&vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getFromDate()%>&data1=<%=getToDate()%>&ftime1=<%=getFromTimeHrs()%>&ftime2=<%=getFromTimeMins()%>&ttime1=<%=getToTimeHrs()%>&ttime2=<%=getToTimeMins()%>" onclick="toggleDetails(<%=i%>,false);">Last 24 Hours Journey On Map </a>
		  		</td>
		   	</tr>
		   	<tr>
				<td> <a href="hourly_detail_report.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&h1=no" onclick="toggleDetails(<%=i%>,false);">Hourly Report </a>
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="detail_custom_report.jsp?vehcode=<%=currentRecord.getVehicleCode()%>" onclick="toggleDetails(<%=i%>,false);">Custom Detail Report </a>
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="javascript:toggleDetails(<%=i%>,false);">Close </a>
				</td>
		   	</tr>
	   		</table>
				</div>	
<%
		}
	%>					
			</td>			
			<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getLastUpdatedDateTime()%></td>
			
<%
				if ((currentRecord.isTripDataAvailable())) {
					
					String briefid = "",rid = "",plannedstatus = "No";
					boolean flag = false;
					String sql1 = "select * from db_gps.t_briefing where tripid = '"+currentRecord.getTripID()+"'";
					ResultSet rs1 = st1.executeQuery(sql1);
					if(rs1.next())
					{
						briefid = rs1.getString("Briefid");
					}

					sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+currentRecord.getTripID()+"' and briefid = '"+briefid+"' and driverid = '"+currentRecord.getDriverCode()+"'  order by advancedtrackid asc ,row asc limit 1 ";
					rs1 = st1.executeQuery(sql1);
					if(rs1.next())
					{
						rid = rs1.getString("advancedrouteid");
						plannedstatus = "Yes";
						flag = true;
					}
			%>
			<td id="tdd<%=i%>" style="<%=currentRecord.getBgColor()%>">
				<a href="javascript:toggleDetails1(<%=i%>,true);" title="Click To See the Reports"><font size="2">
				<%=currentRecord.getTripID()%></font></a>
				<div class="popup" id="popupx<%=i%>">
					<table border="1" bgcolor="white">
		   				<tr>  
						<td> 
							<a href="ActAndPlanJrnyCompOnMap.jsp?tripid=<%=currentRecord.getTripID()%>
										&vehcode=<%=currentRecord.getVehicleCode()%>
										&data=<%=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(currentRecord.getTripStartDateTime())) %>
										&data1=<%=getTripEndDate(currentRecord.getTripStartDateTime())%>
										&ftime1=<%=getTripStartTimeHrs(currentRecord.getTripStartDateTime())%>
										&ftime2=<%=getTripStartTimeMins(currentRecord.getTripStartDateTime())%>
										&ttime1=<%=getTripEndTimeHrs(currentRecord.getTripStartDateTime())%>
										&ttime2=<%=getTripEndTimeMins(currentRecord.getTripStartDateTime())%>
										&pg=st&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>
										&driverid=<%=currentRecord.getDriverCode() %>" onclick="toggleDetails1(<%=i%>,false);">Show Trip on Map </a>
						</td>
		   				</tr>
<%
	if (currentRecord.isTripEditable()) {
%>		   				
		   				<tr>
				   			<td><a href="edittrip.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>
				   							&ReportDateTime=<%=currentRecord.getReportDateTime()%>
				   							&strloc=<%=currentRecord.getTripOrigin()%>
				   							&strdate=<%=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(currentRecord.getTripStartDateTime())) %>
				   							&StartTime=<%=currentRecord.getTripStartTime() %>
				   							&ETA=<%=currentRecord.getEstimatedTimeOfArrival()%>
				   							&endp=<%=currentRecord.getTripDestination()%>
				   							&driverid=<%=currentRecord.getDriverCode()%>
				   							&drivern=<%=currentRecord.getDriverName()%>
				   							&tripid=<%=currentRecord.getTripID()%>" onclick="toggleDetails1(<%=i%>,false);">Edit Trip </a>
				   			</td>
						</tr>
<%
	}
%>
						<tr>
						<td>
				<a href="javascript: flase;" onClick="window.open ('endtrip.jsp?tripid=<%=currentRecord.getTripID()%>&vehcode=<%=currentRecord.getVehicleCode()%>&vehno=<%=currentRecord.getVehicleRegistrationNo()%>','win1', 'width=400, height=250, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');javascript:toggleDetails1(<%=i%>,false);">End Trip </a>

						</td>
		   				</tr>
			  			<tr>
						<td> 
							<a href="javascript:toggleDetails1(<%=i%>,false);">Close </a>
						</td>
		   				</tr>
		   			</table>
		   		</div>
			</td>
			<td id="tde<%=i%>" style="<%=currentRecord.getBgColor()%>">
				<%=currentRecord.getDriverNameCode()%>
			</td>
			<td id="tda<%=i%>" style="<%=currentRecord.getBgColor()%>">			
				<%=currentRecord.getTripOrigin()%>
			</td>
			<td id="tdb<%=i%>" style="<%=currentRecord.getBgColor()%>">
				<%=currentRecord
													.getTripStartDateTime()%>
			</td>
			<td id="tdc<%=i%>" style="<%=currentRecord.getBgColor()%>">
				<%=currentRecord.getTripDestination()%>
			</td>
<%
	} else {
%>
			<td id="tdd<%=i%>" style="<%=currentRecord.getBgColor()%>">
				<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>">
				<%=currentRecord.getTripID()%></a></td>
				<td id="tde<%=i%>" style="<%=currentRecord.getBgColor()%>">
					<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord.getDriverNameCode()%></a>
				</td>
				<td id="tda<%=i%>" style="<%=currentRecord.getBgColor()%>">			
					<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord.getTripOrigin()%></a>
				</td>
				<td id="tdb<%=i%>" style="<%=currentRecord.getBgColor()%>">
					<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord
													.getTripStartDateTime()%></a>
				</td>
				<td id="tdc<%=i%>" style="<%=currentRecord.getBgColor()%>">
					<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord.getTripDestination()%></a>
				</td>
<%
	}
%>
			<td style="text-align:left; <%=currentRecord.getBgColor()%>">
<%
	if (currentRecord.isDataBlocked()|| currentRecord.isDeviceInActive()) {
%>
					<%=currentRecord.getLocationWithDeviceStatus()%>
<%
	} else {
%>
						<a href="shownewmap.jsp?lat=<%=currentRecord.getLatitude()%>&long=<%=currentRecord.getLongitude()%>&discription=<%=currentRecord.getCurrentLocation()%>" onclick="popWin=open('shownewmap.jsp?lat=<%=currentRecord.getLatitude()%>&long=<%=currentRecord.getLongitude()%>&discription=<%=currentRecord.getCurrentLocation()%>', 'myWin','width=500, height=500'); popWin.focus(); return false">

					<%=currentRecord.getCurrentLocation()%></a><%=currentRecord.getLocationWithDeviceStatus() %>
<%
	}
%>
			
			</td>
		
			<td id="tdf<%=i%>" style="<%=currentRecord.getBgColor()%>;"><%=currentRecord.getFuelLevel()%></td>
<%
	if ("FUELFLOW".equalsIgnoreCase(currentRecord
						.getUnitDescription())) {
%>
			<td id="tdl<%=i%>" style="<%=currentRecord.getBgColor()%>;"><a href="showfuelalert.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getfuelAlert_AddedTodayDate()%>&data1=<%=getfuelAlert_AddedTodayDate()%>"><%=currentRecord.getFuelAlert()%></a></td>
			
<%
				} else {
			%>
			<td id="tdl<%=i%>" style="<%=currentRecord.getBgColor()%>;"><%=currentRecord.getFuelAlert()%></td>
			
<%
				}
							if (vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage)) {
			%>
			<td style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor1()%></td>
			<td style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor2()%></td>
			<td style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor3()%></td>
			<td style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor4()%></td>			
<%
				}
			%>
		</tr>
<%
		i++;
		}
					
		}
	} catch (Exception e) {
		out.println("<tr><td colspan=23>");
		out.println("Exception :" + e.getMessage());
		out.println("Cause : " + e.getCause());
		out.println("</td></tr>");
		e.printStackTrace();
	}
%>
	</table>
</body>

<%@ include file="footernew.jsp" %>