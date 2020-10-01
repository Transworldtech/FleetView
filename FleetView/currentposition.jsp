<%@page import="com.transworld.fleetview.framework.VehiclePositionData"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
		import="com.transworld.fleetview.framework.VehiclePositionsViewData"
		import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.Utilities"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataResults" %>

<%@ include file="headernew.jsp"%>	

<%@page import="org.apache.poi.hssf.record.formula.functions.False"%><link href="css/currentPositions.css" rel="stylesheet" type="text/css"></link>

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

function showhide1()
{
	//alert("onclick hide trip button value is 1: ");
	var cnt=document.getElementById("cnt").value;
	var tda, tdb,tdc,tdd,tde,eta,vio;
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
			eta=document.getElementById("eta"+i);
			eta.style.display='none';
            vio = document.getElementById("tdvio"+i);
            vio.style.display = 'none';
			
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

		//document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'printcurrentposition.jsp?tdx=hide\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';
		//document.getElementById("excel").innerHTML='<a href="excelcorrentposition.jsp?&tdx=hide" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	//	document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'GenericPrint.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition=HideTripInfoHideFuelInfo\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';
	//	document.getElementById("excel").innerHTML='<a href="GenericExportExcel.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition=HideTripInfoHideFuelInfo title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
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
			eta=document.getElementById("eta"+i);
			eta.style.display='';
			vio = document.getElementById("tdvio"+i);
	        vio.style.display = 'none';
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
		//document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'printcurrentposition.jsp?tdx=show\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';	
		//document.getElementById("excel").innerHTML='<a href="excelcorrentposition.jsp?&tdx=show"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
		
	//	document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'GenericPrint.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition=ShowTripInfoHideFuelInfo\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';	
	//	document.getElementById("excel").innerHTML='<a href="GenericExportExcel.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition=ShowTripInfoHideFuelInfo"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	}
}

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

//*********************Code for Hide Fuel INfo Button***********************************************************
function showhide2()
{
	var cnt=document.getElementById("cnt").value;
	var tdp, tdm,tdf,tdl,tdy,tdr,tdn;
	var tds=document.getElementById("tds").value;
//	var tdx=document.getgetElementById("tdx").value;

	if(tds=="Hide Fuel Info")
	{
		for(i=0;i<=cnt;i++)
		{	
			tdp=document.getElementById("tdp"+i);
			tdp.style.display='none';
			tdm=document.getElementById("tdm"+i);
			tdm.style.display='none';
			tdf=document.getElementById("tdf"+i);
			tdf.style.display='none';
			tdl=document.getElementById("tdl"+i);
			tdl.style.display='none';
			tdy=document.getElementById("tdy"+i);
			tdy.style.display='none';
			tdr=document.getElementById("tdr"+i);
			tdr.style.display='none';
			tdn=document.getElementById("tdn"+i);
			tdn.style.display='none';
			document.getElementById("tds").value="Show Fuel Info";
		}
	/*	if(tdx=="Hide Trip Info" && tds==" Hide Fuel Info")
		{
			condition="ShowTripInfoShowFuelInfo";
		}
		if(tdx=="Show Trip Info" && tds==" Hide Fuel Info")
		{
			condition="HideTripInfoShowFuelInfo";
		}*/

	//	document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'printcurrentposition.jsp?tdx=hidefuel\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';
	//	document.getElementById("excel").innerHTML='<a href="excelcorrentposition.jsp?&tdx=hidefuel" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	//	document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'GenericPrint.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition=ShowTripInfoHideFuelInfo\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';			
	//	document.getElementById("excel").innerHTML='<a href=GenericExportExcel.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition=ShowTripInfoHideFuelInfo title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	}
	else
	{
		for(i=0;i<=cnt;i++)
		{	
			tdp=document.getElementById("tdp"+i);
			tdp.style.display='';
			tdm=document.getElementById("tdm"+i);
			tdm.style.display='';
			tdf=document.getElementById("tdf"+i);
			tdf.style.display='';
			tdl=document.getElementById("tdl"+i);
			tdl.style.display='';
			tdy=document.getElementById("tdy"+i);
			tdy.style.display='';
			tdr=document.getElementById("tdr"+i);
			tdr.style.display='';
			tdn=document.getElementById("tdn"+i);
			tdn.style.display='';
			document.getElementById("tds").value="Hide Fuel Info";
		}
	/*	if(tdx=="Hide Trip Info" && tds==" Hide Fuel Info")
		{
			condition="ShowTripInfoShowFuelInfo";
		}
		if(tdx=="Show Trip Info" && tds==" Hide Fuel Info")
		{
			condition="HideTripInfoShowFuelInfo";
		}*/

	//	document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'printcurrentposition.jsp?tdx=showfuel\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';		
	//	document.getElementById("excel").innerHTML='<a href="excelcorrentposition.jsp?&tdx=showfuel" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	//	document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'GenericPrint.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition=ShowTripInfoShowFuelInfo\');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>';		
	//	document.getElementById("excel").innerHTML='<a href=GenericExportExcel.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition=ShowTripInfoShowFuelInfo title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	}
}

function showPrint()
{
	//alert("in print");
	var tds=document.getElementById("tds").value;
	//alert("after show fuel :"+tds);
	var tdx=document.getElementById("tdx").value;
	//alert("after hide trip :"+tdx);

	if(tdx=="Show Trip Info" && tds=="Show Fuel Info")
	{
		condition="HideTripInfoHideFuelInfo";
	}
	if(tdx=="Hide Trip Info" && tds=="Show Fuel Info")
	{
		condition="ShowTripInfoHideFuelInfo";
	}
	
	if(tdx=="Hide Trip Info" && tds=="Hide Fuel Info")
	{
		condition="ShowTripInfoShowFuelInfo";
	}
	if(tdx=="Show Trip Info" && tds=="Hide Fuel Info")
	{
		condition="HideTripInfoShowFuelInfo";
	}
	window.open("GenericPrint.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition="+condition);

}


function showExcel()
{
	//alert("in excel");
	var tds=document.getElementById("tds").value;
	//alert("in show fuel");
	var tdx=document.getElementById("tdx").value;
	//alert("in trip");


	if(tdx=="Show Trip Info" && tds=="Show Fuel Info")
	{
		
		valex=11;
	}
	if(tdx=="Hide Trip Info" && tds=="Show Fuel Info")
	{
		
		valex=1;
	}
	
	if(tdx=="Hide Trip Info" && tds=="Hide Fuel Info")
	{
		
		valex=12;
	}
	if(tdx=="Show Trip Info" && tds=="Hide Fuel Info")
	{
		
		valex=0;
	}
	

	window.open("exportcurrentpos.jsp?&sessiondata=VehiclePositionsViewData&key=ALL&condition="+valex);
}



//*************************************End of Hide Fuel INfo Button**********************************************

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

	if(document.searchhi.txtsearch.value == "" || document.searchhi.txtsearch.value == " ")
	{
		alert("Please Enter the value in searchbox");
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
<%!

	private String getFromDate() {
	
		String fromdate = "";
		final String sdate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd").format(
							new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate1));
		} catch (Exception e) {
			try{
				fromdate = new SimpleDateFormat("yyyy-MM-dd").format(
								new SimpleDateFormat("yyyy-MM-dd").parse(sdate1));
			}catch(Exception e1){
			}
		}
		return fromdate;
	}

	private String getToDate() {

		String todate = "";
		final String sdate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd").format(
						new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate1));
		} catch (Exception e) {
			try{
				todate = new SimpleDateFormat("yyyy-MM-dd").format(
							new SimpleDateFormat("yyyy-MM-dd").parse(sdate1));
			}catch(Exception e1){				
			}
		}
		return todate;
	}

	private String getFromTimeHrs() {
		return "00";
	}

	private String getFromTimeMins() {
		return "00";
	}

	private String getToTimeHrs() {
		return "23";
	}

	private String getToTimeMins() {
		return "59";
	}

	private String getTripStartDate(final String datetime) {
		String fromdate="";
		//System.out.println("datetime--------->"+datetime);
		if("-".equalsIgnoreCase(datetime)){
			return datetime;
		}
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd").format(
						new SimpleDateFormat("dd-MMM-yyyy").parse(datetime));
		} catch (Exception e) {
			try{
				fromdate = new SimpleDateFormat("yyyy-MM-dd").format(
							new SimpleDateFormat("dd-MMM-yyyy").parse(datetime));
			}catch(Exception e1){
				e1.printStackTrace();
			}
		}
		return fromdate;
	}

	private String getTripEndDate(final String datetime) {
		String todate = "";
		if("-".equalsIgnoreCase(datetime)){
			return datetime;
		}
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		} catch (Exception e) {
		}
		return todate;
	}

	private String getTripStartTimeHrs(final String datetime) {
		String ftime1 = "00";
		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime);
			ftime1 = new SimpleDateFormat("HH").format(dt);
		} catch (Exception e) {
		}
		return ftime1;
	}

	private String getTripStartTimeMins(final String datetime) {
		String ftime2 = "00";
		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime);
			ftime2 = new SimpleDateFormat("mm").format(dt);
		} catch (Exception e) {
		}
		return ftime2;
	}

	private String getTripStartTimesec(final String datetime) {
		String ftime3 = "00";
		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime);
			ftime3 = new SimpleDateFormat("ss").format(dt);
		} catch (Exception e) {
		}
		return ftime3;
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

	private String getTripEndTimesec(final String datetime) {
		String ttime1 = "59";
		try {
			ttime1 = new SimpleDateFormat("ss").format(new java.util.Date());
		} catch (Exception e) {
		}
		return ttime1;
	}
	
	private boolean isOSTodayZero(String osToday) {
		try{
			if (Integer.parseInt(osToday) > 0) {
				return true;
			}
		}catch(Exception e) {
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

	}
%>
<%! 
Connection conn=null, conn1=null;
	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null;
%>
<%
	session.setAttribute("reportno","Report No:1.0");
	final String userTypeValue = session.getAttribute("usertypevalue").toString();
	System.out.println(">>>>>>>>>++ " +userTypeValue);
	final String typeOfUser = session.getAttribute("TypeofUser").toString();
	final String distanceFormat = session.getAttribute("distformat").toString();

final String typeOfUser1 = session.getAttribute("mainuser").toString();
	final String fuelFormat = session.getAttribute("fuelformat").toString();
	final String commaSeparatedVehicleList = session.getAttribute("VehList").toString();
	final int disConnected = Integer.parseInt(session.getAttribute("desconnected").toString());
	final String fromPage="currentPosition";
	String key="All";
	String requestParamSearchVeh = request.getParameter("searchveh");
	if (null == requestParamSearchVeh) {
		requestParamSearchVeh = "";
	}
	
	VehiclePositionsViewDataResults viewData = null;
	int numRecords = 0;
	try{
	
		final List<VehiclePositionData> list = vehicleDao.getVehiclePositions(
				typeOfUser, userTypeValue, commaSeparatedVehicleList, session.getId());
	
		 viewData = vehiclePositionsViewDataProvider.getVehiclePositionsView(
				 list, distanceFormat, disConnected, fuelFormat,
				 vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage));
		 numRecords = viewData.getCount();
		 
		 session.setAttribute("VehiclePositionsViewData", viewData);
		 
	} catch(Exception e){
		e.printStackTrace();
	}
	try
	{
		conn = fleetview.ReturnConnection();
		//conn1 = fleetview.ReturnConnection1();
		st1=conn.createStatement();
		st2=conn.createStatement();
		st3=conn.createStatement();
		st4=conn.createStatement();
		st5=conn.createStatement();
		st6=conn.createStatement();
		st7=conn.createStatement();
		st8=conn.createStatement();
		st9=conn.createStatement();
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
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="notactive.jsp">InActive</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
			
		
		<input type="button" value="Hide Trip Info" onclick="showhide1();" class="formElement" id="tdx" name="tdx" style="border: thin;border-style: solid;">&nbsp;&nbsp;
		<input type="button" value="Show Fuel Info" onclick="showhide2();" class="formElement" id="tds" name="tds" style="border: thin;border-style: solid;">		
			&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			
			<!--<td bgcolor="#FFFFFF" id="print"><a href="#"
			onclick="javascript:window.open('printcurrentposition.jsp?&tdx=show');"
			title="Print Current Position Report"><img src="images/print.jpg"
			width="15px" height="15px"></a>&nbsp; &nbsp;</td>-->
			<!--<td bgcolor="#FFFFFF" id="excel"><a
			href="excelcorrentposition.jsp?&tdx=show" title="Export to Excel"><img
			src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;</td>-->
			
			<td bgcolor="#FFFFFF" id="print">
			<a id ="print" href="#" onclick="showPrint();" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;</td>
			<td bgcolor="#FFFFFF" id="excel">
			<a id="excel" href="#" onclick="showExcel();" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;</td>
		  <td bgcolor="#FFFFFF"><%=Utilities.printDate()%></td>
		</tr>
	</table>	

	<table width="100%" border="1" align="center" class="sortable">
		<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Veh.</b></th>	
			<th> <b>Veh Type.</b></th>	
			<th> <b>Group</b></th>		
			<th> <b>Updated</b></th>
			<th> <b>Transporter</b></th>
			<th id="tdd0"> <b>Trip Id</b></th>
			<th id ="tdvio0"> <b>Trip Violation</b></th>
			<th id="tde0"><b>Driver Name(Code)</b></th>
			<th id="tda0"><b>Trip Origin</b></th>
			<th id="tdb0"><b>Start Date</b></th>
			<th id="tdc0"><b>Trip Destination</b></th>
			<th id="eta0"> <b>ETA</b></th>
			
			
			<th> <b>Location</b></th>
			<th> <b>Ignition</b></th>
			<th> <b>Speed</b></th>
			<th> <b>Stopped Since<br>(HH:mm)</b></th>
			<th> <b>OS Today</b></th>
			<th> <b>RA Today</b></th>
			<th> <b>RD Today</b></th>
			<th> <b>Distance Today</b></th>
			<th> <b>Distance This Month</b></th>
			<th id="tdp0" style="display: none;"> <b>Previous Day Avg.</b></th>
			<th id="tdm0" style="display: none;"> <b>Avg. This Month</b></th>
			<th id="tdf0" style="display: none;"> <b>Fuel</b></th>
			<th id="tdl0" style="display: none;"> <b>Fuel Alert</b></th>
			<th id="tdy0" style="display: none;"> <b>Yesterday's Fuel Added</b></th>
			<th id="tdr0" style="display: none;"> <b>Day Shift Driver</b></th>
			<th id="tdn0" style="display: none;"> <b>Night Shift Driver</b></th>
<%
if(userTypeValue.equals("Croda Chemicals (India) Private Limited"))
		
{
	%>
	        <th><b>Engine Temp</b></th>
			<th><b>Product Temp</b></th>
			<th><b>RPM</b></th>
			<th><b>Driver Name</b></th>
			<th><b>Key Status</b></th>
	<%
	
}


else if (vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage)) {
%>
			<th><b>Sen1</b></th>
			<th><b>Sen2</b></th>
			<th><b>Sen3</b></th>
			<th><b>Sen4</b></th>
			<th><b>Engine Status</b></th>
<%
	}
else{}
System.out.println("hii");
%>
<th> <b>Battery charging</b></th>
<th> <b>Battery Date</b></th>

		</tr>	
<%
	try {
		for (int counter = 0; counter < numRecords; counter++) {
			final VehiclePositionsViewData currentRecord = viewData.getVehiclePositionViewDataAtIndex(counter);
			int i = counter+1;
		
%>	
		<tr>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=i%></td>
			<%
			if(currentRecord.isDataBlocked() || currentRecord.isDeviceInActive())
			{
				%>
				<td WIDTH="6%" style="text-align:left;<%=currentRecord.getBgColor()%>">
				<font size="2"><%=currentRecord.getVehicleRegistrationNo()%></font>
				</td>
				<%
			}
			else
			{
			%>
			<td WIDTH="6%" style="text-align:left;<%=currentRecord.getBgColor()%>">
			
			<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><font size="2"><%=currentRecord.getVehicleRegistrationNo()%></font></a>
			
				<div class="popup" id="popup<%=i%>">
				<table border="1" bgcolor="#9db5e5" cellpadding="1px" cellspacing="1px">
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
				<td> <a href="SensorRepo.jsp?a=<%=currentRecord.getVehicleCode()%>&b=<%=currentRecord.getVehicleRegistrationNo()%>" onclick="toggleDetails(<%=i%>,false);">Sensor Report </a>
				</td>
		   	</tr>
		   	<tr>
				<td> 
				<a href="ShowCustomReportonTWMap.jsp?tripid=null&vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getFromDate()%>&data1=<%=getToDate()%>&ftime1=<%=getFromTimeHrs()%>&ftime2=<%=getFromTimeMins()%>&ttime1=<%=getToTimeHrs()%>&ttime2=<%=getToTimeMins()%>" onclick="toggleDetails(<%=i%>,false);">Today's Journey On Map </a>
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
		   	
		   	<%
		   	if(userTypeValue == "Rajlaxmi" || userTypeValue.equalsIgnoreCase("Rajlaxmi") || userTypeValue == "RK Transport" || userTypeValue.equalsIgnoreCase("RK Transport"))
		   	{
		   		%>
			   	<tr>
				<td> <a href="detail_custom_report_bk.jsp?vehcode=<%=currentRecord.getVehicleCode()%>" onclick="toggleDetails(<%=i%>,false);">Custom Detail Report - Backup</a>
				</td>
		   	</tr>	   	
			   	<%
		   	}
		   	if(typeOfUser1=="suman_mishra@praxair.com" ||  typeOfUser1.equalsIgnoreCase("suman_mishra@praxair.com"))
		   	{
		   	%>
		   	<tr>
				<td> <a href="repunit.jsp?vid=<%=currentRecord.getVehicleCode()%>" onclick="toggleDetails(<%=i%>,false);">Unit Replace </a>
				</td>
		   	</tr>		   	
		   	<%
		   	}
		   	
		   	
	if (vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage)) 
	         {
%>
		   	 <tr>
				<td> <a href="tempdetailreport.jsp?vehcode=<%=currentRecord.getVehicleCode()%>" onclick="toggleDetails(<%=i%>,false);">Temperature Report </a>
				</td>
		   	</tr>
		   	<%
		   	
		   	}%>
		   	
		   	<tr>
				<td> <a href="javascript: flase;" onclick="window.open('CameraInspectionForm.jsp?vehcode=<%=currentRecord.getVehicleCode()%>','mywindow','width=700, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes,left=50, top=50 ');  javascript:toggleDetails1(<%=i%>,false);">Camera Inspection </a>				
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="javascript:toggleDetails(<%=i%>,false);">Close </a>
				</td>
		   	</tr>
	   		</table>
				</div>						
			</td>		
			
			<%
			}
			%>	
			<%
			   String vehtype="";
			try
			{
			   String SqlVehType="Select vehtype from db_gps.t_vehicledetails where VehicleRegNumber='"+currentRecord.getVehicleRegistrationNo()+"'";
			   ResultSet rst=st1.executeQuery(SqlVehType);
			   if(rst.next())
			   {
				   vehtype=rst.getString("vehtype");
			   }
			   else
			   {
				   vehtype="-";
			   }
			}
			catch(Exception e)
			{
				System.out.print(e);
			}
			%>
			<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=vehtype%></td>
			<%
String grpname="",firstgpname="";
try
{
String sql="select * from db_gps.t_group where VehCode='"+currentRecord.getVehicleCode()+"' and SepReport='yes' and Active='yes' order by gpname  ";
ResultSet rsgrp=st9.executeQuery(sql);
System.out.println("querry-------------------------------->  " +sql);
boolean ff=false;
//boolean dd=false;
while(rsgrp.next())
{
	if(ff==false)
	{
		grpname=rsgrp.getString("GPName").trim();
	firstgpname=rsgrp.getString("GPName").trim();
	ff=true;
	}
	else{
		grpname+=",\n"+rsgrp.getString("GPName").trim();
	}
//grpname=rsgrp.getString("GPName");
}
}catch(Exception e)
{
	System.out.println("GPName------catch-------------------------->  " +grpname);
	System.out.println("First------------catch-------------------->  " +firstgpname);
	grpname = "-";
	firstgpname = "-";
}
	System.out.println("GPName-------------------------------->  " +grpname);
	System.out.println("First-------------------------------->  " +firstgpname);

%>
	<td title="<%=grpname %>"  style="text-align:left;<%=currentRecord.getBgColor()%>"><%=firstgpname%></td>	
	
			
			
			<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getLastUpdatedDateTime()%></td>
			<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getTransporter()%></td>
<%
	
			if ((currentRecord.isTripDataAvailable())) {
				
				String briefid = "",rid = "",plannedstatus = "No",Tripid="";
				String tridriver="",triorigin="",tridest="",tristart="";
				boolean flag = false;
				try
				{
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
				
				sql1 = "select Tripid from db_gps.t_startedjourney where  Tripid = '"+currentRecord.getTripID()+"' and (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"' OR Vendor='"+session.getAttribute("usertypevalue").toString()+"') ";
				rs1 = st1.executeQuery(sql1);
				if(rs1.next())
				{
					Tripid=currentRecord.getTripID();
				}
				else{
				Tripid="-";
				}
				}
				catch(Exception e)
				{
					briefid = "";
					rid = "";
					plannedstatus = "No";
				}
				
				
%>
			<td WIDTH="6%" id="tdd<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>">
			<% if(Tripid.equals("-")){%>
			<font size="2">
				<%=Tripid%></font>
			<% }
			else{%>
				<a href="javascript:toggleDetails1(<%=i%>,true);" title="Click To See the Reports"><font size="2">
				<%=Tripid%></font></a><% }%>
				<div class="popup" id="popupx<%=i%>">
					<table border="1" bgcolor="white">
		   				<tr>  
						<td> 
							<a href="ActAndPlanJrnyCompOnMap.jsp?tripid=<%=currentRecord.getTripID()%>
										&vehcode=<%=currentRecord.getVehicleCode()%>
										&data=<%=getTripStartDate(currentRecord.getTripStartDateTime())%>
										&data1=<%=getTripEndDate(currentRecord.getTripStartDateTime())%>
										&ftime1=<%=getTripStartTimeHrs(currentRecord.getTripStartDateTime())%>
										&ftime2=<%=getTripStartTimeMins(currentRecord.getTripStartDateTime())%>
										&ftime3=<%=getTripStartTimesec(currentRecord.getTripStartDateTime())%>
										&ttime1=<%=getTripEndTimeHrs(currentRecord.getTripStartDateTime())%>
										&ttime2=<%=getTripEndTimeMins(currentRecord.getTripStartDateTime())%>
										&ttime3=<%=getTripEndTimesec(currentRecord.getTripStartDateTime())%>
										&pg=st&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>
										&driverid=<%=currentRecord.getDriverCode() %>" onclick="toggleDetails1(<%=i%>,false);">Show Trip on Map </a>
						</td>
		   				</tr>
		   			
<%



				if (currentRecord.isTripEditable()) {
%>		   				
		   				<tr>
				   			<td>				   									 
				   			<a href="edittrip.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>
				   							&ReportDateTime=<%=currentRecord.getReportDateTime()%>
				   							&strloc=<%=currentRecord.getTripOrigin()%>
				   							&strdate=<%=getTripStartDate(currentRecord.getTripStartDateTime())%>
				   							&StartTime=<%=currentRecord.getTripStartTime() %>
				   							&ETA=<%=currentRecord.getEstimatedTimeOfArrival()%>
				   							&endp=<%=currentRecord.getTripDestination()%>
				   							&driverid=<%=currentRecord.getDriverCode()%>
				   							&drivern=<%=currentRecord.getDriverName()%>
				   							&tripid=<%=currentRecord.getTripID()%>" onclick="toggleDetails1(<%=i%>,false);">Edit Trip </a>
							</td>
						</tr>
						<tr>
						<td> 
						<a href="javascript:toggleDetails1(<%=i%>,true);" onclick="javascript:window.open ('CancelTrip.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>&tripid=<%=currentRecord.getTripID()%>','win3','scrollbars=1,resizeable=0,width=500,height=500');";>Cancel Trip</a>
		  				</td>
		   				</tr>
		   				
<%
				}
String pageflag="currentposition";
%>
						<tr>
						<td>
						<a href="javascript: flase;" onClick="window.open ('endtrip.jsp?tripid=<%=currentRecord.getTripID()%>&vehcode=<%=currentRecord.getVehicleCode()%>&vehno=<%=currentRecord.getVehicleRegistrationNo()%>&pageflag=<%=pageflag%>', 'win1', 'width=850, height=550, location=0, menubar=0, scrollbars=yes, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">End Trip </a>
						
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
				<%
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			Calendar now123=Calendar.getInstance();
			
			String sysdate22 = dateFormat.format(now123.getTime());
			System.out.println(">>>>>>>>>>>>>>>n "+sysdate22);
			String tripstartdate ="";
String sysdate223="";
			
			sysdate223=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sysdate22));
			
			
			int racount=0,rdcount=0,cdcount=0,ndcount=0,stopcount=0,Runhrcount=0,Diccount=0,oscount=0,osdur=0,sum=0;

			if(currentRecord.getTripStartDateTime().equals("-"))
			{
				tripstartdate = "-";
			}
			else
			{
				tripstartdate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(currentRecord.getTripStartDateTime()));
			}

			try{
				
				
				
				
				if(tripstartdate.equals("-"))
				{
					%>
					<td id="tdvio<%=i%>"  style="text-align:right;<%=currentRecord.getBgColor()%>"> 0</td>
					<%
					
				}
				
				else{
					
					try
					{
					String sql2="select count( * ) as racount from db_gpsExceptions.t_vehall_ra where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND TheDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND TheDatetime <= '"+sysdate22+"'"; 
					ResultSet rs2=st9.executeQuery(sql2);
					//System.out.println(">>>>>>>rrrrrrrrr1" +sql2);
					if(rs2.next())
					{
						racount=rs2.getInt("racount");
					}
					
					String sql3="select count( * ) as rdcount from db_gpsExceptions.t_vehall_rd where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND TheDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND TheDatetime <= '"+sysdate22+"'"; 
					ResultSet rs3=st3.executeQuery(sql3);
					//System.out.println(">>>>>>>rrrrrrrr2" +sql3);
					if(rs3.next())
					{
						rdcount=rs3.getInt("rdcount");
					}
					
					
					
					String sql5="select count( * ) as cdcount from db_gpsExceptions.t_vehall_crcopy where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND FromDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND FromDatetime <= '"+sysdate22+"'"; 
					ResultSet rs5=st5.executeQuery(sql5);
					//System.out.println(">>>>>>>rrrrrrr3" +sql5);
					if(rs5.next())
					{
						cdcount=rs5.getInt("cdcount");
					}
					
					
					
					
					
					String sql6="select count( * ) as ndcount from db_gpsExceptions.t_vehall_nd where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND FromDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND FromDatetime <= '"+sysdate22+"'"; 
					ResultSet rs6=st6.executeQuery(sql6);
					//System.out.println(">>>>>>>rrrrrrrrr4" +sql6);
					if(rs6.next())
					{
						ndcount=rs6.getInt("ndcount");
					}
					
					
					String sql7="select count( * ) as oscount from db_gpsExceptions.t_vehall_overspeed where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND FromDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND FromDatetime <= '"+sysdate22+"'"; 
					ResultSet rs7=st7.executeQuery(sql7);
					//System.out.println(">>>>>>>rrrrrrrrr5" +sql7);
					if(rs7.next())
					{
						oscount=rs7.getInt("oscount");
					}
					
					String sqlDic="select count( * ) as Diccount from db_gps.t_disconnectionData where vehicleCode='"+currentRecord.getVehicleCode()+"' AND Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"'  and OffTimeFrom<='"+sysdate22+"') or (OffTimeTo >='"+tripstartdate+" "+currentRecord.getTripStartTime()+"'  and OffTimeTo<='"+sysdate22+"') or (OffTimeFrom <='"+tripstartdate+" "+currentRecord.getTripStartTime()+"' and OffTimeTo >='"+sysdate22+"')) "; 
					ResultSet rsdic=st7.executeQuery(sqlDic);
					//System.out.println(">>>>>>>rrrrrrrrr7" +sqlDic);
					if(rsdic.next())
					{
						Diccount=rsdic.getInt("Diccount");
					}
					
					
					String sqlRunhr="select count( * ) as Runhrcount from db_gpsExceptions.t_vehall_ds where vehcode ='"+currentRecord.getVehicleCode()+"' and RDuration > '10:00:00' and violationstatus='Open' AND thedate >= '"+tripstartdate+"' AND thedate <= '"+sysdate223+"'"; 
					ResultSet rsRun=st4.executeQuery(sqlRunhr);
					//System.out.println(">>>>>>>rrrrrrrrr8" +sqlRunhr);
					if(rsRun.next())
					{
						Runhrcount=rsRun.getInt("Runhrcount");
					}
					String sql1 = "select Tripid from db_gps.t_startedjourney where  Tripid = '"+currentRecord.getTripID()+"' and (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"' OR Vendor='"+session.getAttribute("usertypevalue").toString()+"') ";
					ResultSet rs1 = st1.executeQuery(sql1);
					if(rs1.next())
					{
						sum=racount+rdcount+cdcount+ndcount+oscount+Diccount+Runhrcount;
						tridriver=currentRecord.getDriverNameCode();
						triorigin=currentRecord.getTripOrigin();
						tristart=currentRecord.getTripStartDateTime();
						tridest=currentRecord.getTripDestination();
					}
					else{
						sum=0;
						tridriver="-";triorigin="-";tridest="-";tristart="-";
					}
						
					}
					catch(Exception e)
					{
						sum = 0;
					}
				%>
				
				

				
				<td  id="tdvio<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>"><a href="#" onclick="javascript:window.open('brief_report_7days.jsp?&vid=<%=currentRecord.getVehicleCode() %>&vehRegNo=<%=currentRecord.getVehicleRegistrationNo() %>&Transporter=<%=currentRecord.getTransporter()%>&SD=<%=tripstartdate %> <%=currentRecord.getTripStartTime() %> &ED=<%=sysdate22 %>')"><%=sum %> </a></td>
				<%
					
				}
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
			
			
			
			%>
			
			
			
			<td id="tde<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>">
				<%=tridriver%>
			</td>
			<td id="tda<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>">			
				<%=triorigin%>
			</td>
			<td id="tdb<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>">
				<%=tristart%>
			</td>
			<td id="tdc<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>">
				<%=tridest%>
			</td>
			
<%
			String ETA="";

			try
			{
					String sqlETA="select * from db_gps.t_startedjourney where TripID='"+currentRecord.getTripID()+"' and (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"' OR Vendor='"+session.getAttribute("usertypevalue").toString()+"')";
					System.out.println("ETA is " +sqlETA);
					ResultSet rseta=st3.executeQuery(sqlETA);
					System.out.println("ETA is " +sqlETA);

					if(rseta.next())
					{
						ETA=rseta.getString("ETA");
					}
					System.out.println("ETA    "+ETA);

					if(ETA == null || ETA.equalsIgnoreCase("NULL") || ETA.equalsIgnoreCase("") || ETA.equalsIgnoreCase("-"))	      
					{
						ETA="NA";
  					 }
					else
					{
						ETA=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA));
					}

			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
%>
<td id="eta<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>"><%=ETA %></td>
<%
				} else {
%>
			<td WIDTH="8%" id="tdd<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>">
				<a href="TripStart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord.getTripID()%></a></td>
				
					<td id="tdvio<%=i%>"  style="text-align:right;<%=currentRecord.getBgColor()%>"> 0</td>
				
				<td id="tde<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>">
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getDriverNameCode()%></a>-->
					<%=currentRecord.getDriverNameCode()%>
				</td>
				<td id="tda<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>">			
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getTripOrigin()%></a>-->
					<%=currentRecord.getTripOrigin()%>
				</td>
				<td id="tdb<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>">
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getTripStartDateTime()%></a>-->
					<%=currentRecord.getTripStartDateTime()%>
				</td>
				<td id="tdc<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>">
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getTripDestination()%></a>-->
					<%=currentRecord.getTripDestination()%>
				</td>
				<td id="eta<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>">NA</td>
<%
				}
%>









			<td style="text-align:left; <%=currentRecord.getBgColor()%>">
<%
				if(currentRecord.isDataBlocked() || currentRecord.isDeviceInActive())
				{
%>
					<%=currentRecord.getLocationWithDeviceStatus() %>
<%				}
				else{
%>
			<a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=currentRecord.getLatitude()%>&long=<%=currentRecord.getLongitude()%>&discription=<%=currentRecord.getCurrentLocation()%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=currentRecord.getCurrentLocation()%> </a><%=currentRecord.getLocationWithDeviceStatus() %>
<%
				} 
%>
			
			</td>
			
			
			
			<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getIngnitionInfo()%></td>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=currentRecord.getSpeed()%></td>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=currentRecord.getStoppedSince()%></td>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>">
<%
				if (isOSTodayZero(currentRecord.getOSToday())) {
%>
				<a href="newos.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&fromdate=<%=new SimpleDateFormat("yyyy-MM-dd")
										.format(new java.util.Date())%>&todate=<%=new SimpleDateFormat("yyyy-MM-dd")
										.format(new java.util.Date())%>"><%=currentRecord.getOSToday()%></a>
<%
				} else {
%>
			<%=currentRecord.getOSToday()%>
<%
				}
%>
			</td>
 			<td style="text-align:right;<%=currentRecord.getBgColor()%>">
<%
				if (isOSTodayZero(currentRecord.getRAToday())) {
%>
				<a href="detail_ra.jsp?vid=<%=currentRecord.getVehicleCode()%>&vehno=<%=currentRecord.getVehicleRegistrationNo() %>&dd=<%=new SimpleDateFormat("yyyy-MM-dd")
										.format(new java.util.Date())%>&pageType=RapidAcceleration"><%=currentRecord.getRAToday()%></a>
<%
				} else {
%>
			<%=currentRecord.getRAToday()%>
<%
				}
%>
			</td>
			
			
			
									<td style="text-align:right;<%=currentRecord.getBgColor()%>">
<%
				if (isOSTodayZero(currentRecord.getRDToday())) {
%>
				<a href="detail_rd.jsp?vid=<%=currentRecord.getVehicleCode()%>&vehno=<%=currentRecord.getVehicleRegistrationNo() %>&dd=<%=new SimpleDateFormat("yyyy-MM-dd")
										.format(new java.util.Date())%>&pageType=RapidDecceleration"><%=currentRecord.getRDToday()%></a>
<%
				} else {
%>
			<%=currentRecord.getRDToday()%>
<%
				}
%>
			</td>
		
			
			
			
			
			<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=currentRecord.getDistanceToday()%></td>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=currentRecord.getDistanceThisMonth()%></td>
			<td id="tdp<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;"><%=currentRecord.getLastDayAVG()%></td>
			<td id="tdm<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;"><%=currentRecord.getLastMonthAVG()%></td>
			<td id="tdf<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>;display:none;"><%=currentRecord.getFuelLevel()%></td>
<%
				if ("FUELFLOW".equalsIgnoreCase(currentRecord.getUnitDescription())) {
%>
			<td id="tdl<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;"><a href="showfuelalert.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getfuelAlert_AddedTodayDate()%>&data1=<%=getfuelAlert_AddedTodayDate()%>"><%=currentRecord.getFuelAlert()%></a></td>
			<td id="tdy<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;"><a href="showfueladd.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getfuelAlert_AddedPreviousDate()%>&data1=<%=getfuelAlert_AddedPreviousDate()%>"><%=currentRecord.getFuelAdded()%></a></td>
<%
				} else {
%>
			<td id="tdl<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;"><%=currentRecord.getFuelAlert()%></td>
			<td id="tdy<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;"><%=currentRecord.getFuelAdded()%></td>
<% 
				}
%>
			<td id="tdr<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>;display:none;"><%=currentRecord.getDayShiftDriver()%></td>
			<td id="tdn<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>;display:none;"><%=currentRecord.getNightShiftDriver()%></td>
<%
			if (vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage)) {
				
				//System.out.println((!(currentRecord.isDeviceInActive()) &&  (currentRecord.getSensor1().equals("xxxx"))));
				
				if(!(currentRecord.isDeviceInActive()) &&  (currentRecord.getSensor1().equals("xxxx")) && (userTypeValue.equals("Croda Chemicals (India) Private Limited")))
				{			
				
					String sensor = currentRecord.getSensor1();
					try
					{
						String sqlsen1 = "select sen1,Thefielddatadatetime from db_gps.t_veh"+currentRecord.getVehicleCode()+" where thefielddatadatetime < '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(currentRecord.getLastUpdatedDateTime())) +"' and sen1 <> '-' and sen1 <> ' '  and Thefiledtextfilename = 'SI' order by thefielddatadatetime desc limit 1";
						ResultSet rssen1 = st1.executeQuery(sqlsen1);
						System.out.println("sensor1   "+sqlsen1);
						if(rssen1.next())
						{
				
							sensor = rssen1.getDouble("sen1")+"<br>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rssen1.getString("thefielddatadatetime")));
						}
						else
						{
				
							sensor = currentRecord.getSensor1();
						}
					}
					catch(Exception e)
					{
						e.printStackTrace();
						System.out.println("sensor1 catch   ");
						sensor = currentRecord.getSensor1();
					}
					System.out.println("sensor1 value   "+sensor);
					%>
						<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=sensor%></td>
						<%
					
				}
				else
				{
					%>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor1()%></td>
					<%
				}
				
				if(!(currentRecord.isDeviceInActive()) &&  (currentRecord.getSensor2().equals("xxxx")) && (userTypeValue.equals("Croda Chemicals (India) Private Limited")))
				{	
					
					String sensor = currentRecord.getSensor2();
					try
					{
						String sqlsen1 = "select sen2,Thefielddatadatetime from db_gps.t_veh"+currentRecord.getVehicleCode()+" where thefielddatadatetime < '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(currentRecord.getLastUpdatedDateTime())) +"' and sen2 <> '-' and sen2 <> ' '  and Thefiledtextfilename = 'SI' order by thefielddatadatetime desc limit 1";
						ResultSet rssen1 = st1.executeQuery(sqlsen1);
				
						if(rssen1.next())
						{
				
							sensor = rssen1.getDouble("sen2")+"<br>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rssen1.getString("thefielddatadatetime")));
						}
						else
						{
				
							sensor = currentRecord.getSensor2();
						}
					}
					catch(Exception e)
					{
						e.printStackTrace();
				
						sensor = currentRecord.getSensor2();
					}
					System.out.println("sensor2 value   "+sensor);
						%>
						<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=sensor%></td>
						<%
				}
				else
				{
					%>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor2()%></td>
					<%
				}
%>
<!--<td style="< %=currentRecord.getBgColor()%>">< %=currentRecord.getSensor1()%></td>-->
<!--	<td style="< %=currentRecord.getBgColor()%>">< %=currentRecord.getSensor2()%></td>-->
			
			<%
			if(userTypeValue.equals("Croda Chemicals (India) Private Limited"))
			{
				
				String sensor3 = currentRecord.getSensor3(),sensor4 = currentRecord.getSensor4();
				try
				{
					String sqlsen1 = "select sen3,sen4 from db_gps.t_onlinedata where VehicleCode = '"+currentRecord.getVehicleCode()+"' ";
					ResultSet rssen1 = st1.executeQuery(sqlsen1);
					if(rssen1.next())
					{
						try
						{
							if(rssen1.getString("sen3").equals("-") || rssen1.getString("sen3").equals(" "))
							{
								sensor3 = "xxxx";
							}
							else
							{
								sensor3 = rssen1.getString("sen3");
							}
						}
						catch(Exception e)
						{
							sensor3 = "xxxx";
						}
						
						try
						{
						if(rssen1.getString("sen4").equals("-") || rssen1.getString("sen4").equals(" ") || rssen1.getString("sen4").length() <= 2)
						{
							sensor4 = "xxxx";
						}
						else
						{
							String sk  = rssen1.getString("sen4").replace("\n","");
							sk = sk.substring(0,3);
							
							String sqlsk = "select DriverName from db_gps.t_drivers where SmartKey="+sk+" ";
				
							ResultSet rssk = st2.executeQuery(sqlsk);
							if(rssk.next())
							{
								sensor4 = rssk.getString("DriverName");
								System.out.println(" in sensor4 if ");
							}
							else
							{
								sensor4 = "xxxx";
								System.out.println(" in sensor4 else ");
							}
						}        
						}catch(Exception e)
						{
							sensor4 = "xxxx";
						}
					}
					else
					{
						sensor3 = currentRecord.getSensor3();
						sensor4 = currentRecord.getSensor4();
						
				
					}
				}
				catch(Exception e)
				{
					sensor3 = currentRecord.getSensor3();
					sensor4 = currentRecord.getSensor4();
					
				
				}
			
					%>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=sensor3%></td>			
					<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=sensor4%>
					<% System.out.println(" sensor4 "+sensor4); %></td>			
					<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getEnginestatus()%></td>									
		<%
			}
			else
			{
							
				// This is for tempsensor for goa
				if(("TEMPSENSOR".equalsIgnoreCase(currentRecord.getUnitDescription())))
				{
					
					String query = "SELECT sen1, sen2, TRIM(LEADING '0' FROM sen3) as  sen3, TRIM(LEADING '0' FROM sen4) as  sen4 FROM db_gps.t_onlinedata where   replace(sen1,'$','-') and sen1<>' ' and sen1<>'-' and  sen2<>' ' and sen2<>'-' and sen3<>' ' and sen3<>'-' and sen4<>' ' and sen4<>'-' and  (sen1<>'085.000' and sen2<>'085.000' and sen3<>'085.000' and sen4<>'085.000') and  SUBSTRING(sen1, 1, 1)='0' and SUBSTRING(sen2, 1, 1)='0' and SUBSTRING(sen3, 1, 1)='0'  and SUBSTRING(sen4, 1, 1)='0' and VehicleCode = ?   ";	
					PreparedStatement preparedStatement = conn.prepareStatement(query);
					preparedStatement.setString(1, currentRecord.getVehicleCode());
					ResultSet rssen1 = preparedStatement.executeQuery();
					//ResultSet rssen1 = st1.executeQuery(query);
			         if (rssen1.next()) 
			       	{
				%>
							
						<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=rssen1.getString("sen3")%></td>
						<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=rssen1.getString("sen4")%></td>
						<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getEnginestatus()%></td>
				<%
			       	}
			         else
			         {
			    %>
			    		<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor3()%></td>
						<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor4()%></td>
						<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getEnginestatus()%></td>		
			    
			    <%     	 
			         }
			         
			         
			         
				
				}		
				else
				{	
		
	%>	
					
				<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor3()%></td>
				<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor4()%></td>
				<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getEnginestatus()%></td>							
	
	<%
				}		
			
			}
		
			
			}
%>
<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=currentRecord.getBatterystatus()%></td>
<td style="text-align:right;<%=currentRecord.getBgColor()%>"><%=currentRecord.getBatterydate()%></td>

	
		</tr>
<%
		}
	} catch (Exception e) {
			out.println("<tr><td colspan=23>");
			out.println("Exception :" + e.getMessage());
			out.println("Cause : " + e.getCause());
			out.println("</td></tr>");
			//System.out.println("online time==");
			e.printStackTrace();
	}
	finally{
		try{
		conn.close();
		conn1.close();
		}catch(Exception e)
		{
			
		}
		try{
		fleetview.closeConnection();
		}catch(Exception e)
		{
			
		}
		try{
		fleetview.closeConnection1();
		}catch(Exception e)
		{
			
		}
	}
	
	
%>
	</table>
</body>

<%@ include file="footernew.jsp" %>