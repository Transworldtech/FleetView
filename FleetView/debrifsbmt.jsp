<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.DebriefSubmitData"
	import="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
	import="com.transworld.fleetview.framework.DebriefSubmitViewData"
	import="com.transworld.fleetview.framework.DebriefSubmitShowOpenTripsData"
	import="com.transworld.fleetview.framework.DriverDebriefForTrip"
	import="com.fleetview.beans.DisconnectionCount"
	import="com.transworld.fleetview.framework.PeripheralOfUnitDuringTrip"%>
<%@page language="java" %>
<%@ include file="headernew.jsp" %>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>

<jsp:useBean id="debriefSubmitViewDataProvider"
	type="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
	scope="application"></jsp:useBean>
	

<style>
.popup {
	background-color: #98AFC7;
	position: absolute;
	visibility: hidden; 
}
.popupnew { 
	background-color : #98AFC7;
	position: absolute;
	visibility: visible;
}
.popupx { 
	background-color : #98AFC7;
	position: absolute;
	visibility: hidden;
}
</style>

<%!
Connection con1;

int id= 0;
%>

<%
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st=con1.createStatement();
%>
<script src="searchhi.js" type="text/javascript" language="JavaScript"></script>
<body onLoad="JavaScript:loadSearchHighlight();" bgcolor="#FFE4E1">
<script language="JavaScript"><!--
    function loadSearchHighlight()
    {
      SearchHighlight();
      document.searchhi.h.value = searchhi_string;
      if( location.hash.length > 1 ) location.hash = location.hash;
      
    }
    // -->
</script>

<script language="javascript">
var tripp="Yes";
var gps="Yes";
var mb="Yes";
var tripid="";
var sp;
function trim(inputString) {
	   // Removes leading and trailing spaces from the passed string. Also removes
	   // consecutive spaces and replaces it with one space. If something besides
	   // a string is passed in (null, custom object, etc.) then return the input.
	   if (typeof inputString != "string") { return inputString; }
	   var retValue = inputString;
	   var ch = retValue.substring(0, 1);
	   while (ch == " ") { // Check for spaces at the beginning of the string
	      retValue = retValue.substring(1, retValue.length);
	      ch = retValue.substring(0, 1);
	   }
	   ch = retValue.substring(retValue.length-1, retValue.length);
	   while (ch == " ") { // Check for spaces at the end of the string
	      retValue = retValue.substring(0, retValue.length-1);
	      ch = retValue.substring(retValue.length-1, retValue.length);
	   }
	   while (retValue.indexOf("  ") != -1) { // Note that there are two spaces in the string - look for multiple spaces within the string
	      retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ")+1, retValue.length); // Again, there are two spaces in each of the strings
	   }
	   return retValue; // Return the trimmed string back to the user
	} // Ends the "trim" function


function validate()
{
	var tripid=document.dbform.tripid.value;
	var transporter=document.dbform.transporter.value;
	var percGPS=document.dbform.percGPS.value;
	var drvresp=document.dbform.drvresp.value;
	var drvMobNo=document.dbform.drvMobNo.value;
	var stprpt = document.dbform.stprpt;
	
	tripid=tripid.replace(/^\s+|\s+$/g,"");//trim	
	drvMobNo=drvMobNo.replace(/^\s+|\s+$/g,"");
	drvresp=drvresp.replace(/^\s+|\s+$/g,"");
	if(tripp=="Yes")
	{
		if(tripid.length==0)
		{
			alert("please enter trip id");
			return false;
		}
	
	/*	if(isNaN(tripid))
  		{
  			alert("please enter only Numeric trip id");
			return false;
		}
		*/
	}

	var rad_val;
	//alert(VehRegNo);
	for (var i=0; i < stprpt.length; i++)
	   {
	   if (stprpt[i].checked)
	      {
		   rad_val= document.dbform.stprpt[i].value;
		  // alert(rad_val);
	      }
	   }

		if(rad_val=="No" ||rad_val==""){
			alert("please fill stop report");
			return false;
		}
	   
	if(gps=="Yes")
	{
		if(percGPS=="select")
		{
			alert("please Select Data captured percentage");
			return false;
		}
	}
	if(drvresp.length==0)
	{
		alert("please enter Driver Response ");
		return false;
	}
	if(stprpt=="No"){
		alert("please fill the stop report");
		return false;
	}

//------------------------------------------------
	
	var Request;  // The variable that makes Ajax possible!
	var stopReportFilled;
	var tripid1;
	//alert("hi..");
     try{
 	        // Opera 8.0+, Firefox, Safari
 	 	Request = new XMLHttpRequest();
        }  
        catch (e)
        {
 	        // Internet Explorer Browsers
 	        try
                 {
 	        	Request = new ActiveXObject("Msxml2.XMLHTTP");
 	        } 
                 catch (e)
                 {
 		    try
                     {
 		    	Request = new ActiveXObject("Microsoft.XMLHTTP");
 		    } 
                     catch (e)
                     {
 		           // Something went wrong
 	                   alert("Your browser broke!");
 			   return false;
 	            }
 	        }
          }
                
          // Create a function that will receive data sent from the server
            Request.onreadystatechange = function()
            {
            // alert("ajaxRequest.onreadystatechange");
        
     	       if(Request.readyState == 4)
                {
     	    	  
                //   alert("ajaxRequest.readyState");
                      var reslt=Request.responseText;
                  //  alert(reslt);
                      var resnew=reslt.split("#");
						
                      tripid1=resnew[1];
                      stopReportFilled=resnew[0];
                   //  alert(stopReportFilled);
					
					                      
 	       } 
            }
           var queryString = "?tripid="+tripid+"&transporter="+transporter;
 	   ajaxRequest.open("GET", "isStopReportFilled.jsp" + queryString, true);
 	   ajaxRequest.send(null); 

		if(stopReportFilled.indexOf("Yes")==-1)
		{
			//alert("stopReportFilled="+stopReportFilled);
			return false;
		}

//------------------------------------------------
	return true;
}
function showper(ind)
{
	var capt = document.getElementById("captgps");
	
	if(ind==0) 
	{
		capt.style.display = 'none';
		gps="No";
	}
	else
	{
		capt.style.display = '';	
		gps="Yes";
	}
}
function HideandShow1(id)
{
	if(id==1)
	{
		var row12 = document.getElementById("drvMobNo");
		
		document.dbform.drvMobNo.style.visibility="hidden";
		row12.style.visibility="hidden";
		document.dbform.drvMobNo.value="";
		mb="No";
	}
	else
	{
		var row12 = document.getElementById("drvMobNo");
		document.dbform.drvMobNo.style.visibility="visible";
		row12.style.visibility="visible";
		mb="Yes";
	}
}
function toggleDetails(id, show)
{
   
	var popup = document.getElementById("popup"+id);
       	if (show) 
	{
		popup.style.visibility = "visible";
		popup.setfocus();
		
	}
	else
	{
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

function displayRow(ind)
{
	var row = document.getElementById("inputtable");

	if(ind==0) 
		row.style.display = 'none';

	else
		row.style.display = '';

		
}

function showHideTable(id)
{
	
	var tr=document.getElementById("tabl");
	//alert(id);
	
	var cnt=document.getElementById("cnt").value;

		var radList = document.getElementsByName("debrifRadioId");
		
		/*for (var i = 0; i < radList.length; i++) {
			var c=i+1;
			alert(c);
			if(c==id){
				alert(c);
				break;
			}
			else if(radList[i].checked){
				alert("hii");
				 radList[i].checked = false;
			}
		}*/
	//	alert(document.getElementById("debrifRadioId"+id).checked);
		
		if(document.getElementById("debrifRadioId"+id).checked==true)
		{
			var rad=document.getElementById("debrifRadioId"+id);
			var data=rad.value;
		//	alert(data);
			sp=data.split("#");
		}
		
	tr.style.display='';
	//-----------------------------------------------------------------------
	
	  var ajaxRequest;  // The variable that makes Ajax possible!
	  var tripid1="";
      var vehicle="";
     try{
 	        // Opera 8.0+, Firefox, Safari
 	 	ajaxRequest = new XMLHttpRequest();
        }  
        catch (e)
        {
 	        // Internet Explorer Browsers
 	        try
                 {
 	             ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
 	        } 
                 catch (e)
                 {
 		    try
                     {
 		        ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
 		    } 
                     catch (e)
                     {
 		           // Something went wrong
 	                   alert("Your browser broke!");
 			   return false;
 	            }
 	        }
          }
                
          // Create a function that will receive data sent from the server
            ajaxRequest.onreadystatechange = function()
            {
     	       if(ajaxRequest.readyState == 4)
                {
                      var reslt=ajaxRequest.responseText;
                      var resnew=reslt.split("#");

                      tripid1=resnew[0];
                      vehicle=resnew[1];
                      var unitType=resnew[2];
						if(unitType.indexOf("JRM+Buzzer")==-1)
						{
							
							document.getElementById("jrmDevice").style.display='none';
						}
						else{
							document.getElementById("jrmDevice").style.display='';
						}
					                      
 	       } 
            }
           var queryString = "?tripid="+sp[0]+"&startDate="+sp[1]+"&endDate="+sp[2];
 	   ajaxRequest.open("GET", "unitTypeInVehicle.jsp" + queryString, true);
 	   ajaxRequest.send(null); 
	
	//-----------------------------------------------------------------------
	
	document.dbform.tripid.value=sp[0];
//	alert(document.dbform.tripid.value);
	document.dbform.tripid.readonly=true;
	//document.getElementById("debrifRadioId"+id).checked=false;
	
	document.getElementById("ancNo").checked=true;
	
}
function routeDeviation(id)
{
	if(id==0){
		//alert(sp[6]);
		openwindow("briefDebriefCustomDetailReport.jsp?vehcode="+sp[6]+"&startDate="+sp[1]+"&endDate="+sp[2]+"&tripid="+sp[0]+"&transporter="+sp[5]+"&driverid="+sp[7]+"&fromPage=bd&deviationType=RouteDeviation");
	}
}

function routeFeedBack(id)
{
	if(id==0){
		//alert(sp[6]);
		openwindow("briefDebriefCustomDetailReport.jsp?vehcode="+sp[6]+"&startDate="+sp[1]+"&endDate="+sp[2]+"&tripid="+sp[0]+"&transporter="+sp[5]+"&driverid="+sp[7]+"&fromPage=bd&deviationType=RouteFeedback");
	}
}

function zoneFeedBack(id)
{
	if(id==0){
		//alert(sp[6]);
		openwindow("briefDebriefCustomDetailReport.jsp?vehcode="+sp[6]+"&startDate="+sp[1]+"&endDate="+sp[2]+"&tripid="+sp[0]+"&transporter="+sp[5]+"&driverid="+sp[7]+"&fromPage=bd&deviationType=ZoneFeedback");
	}
}

function newwindow2()
{
	//alert(sp[0]+"--"+sp[1]+"--"+sp[2]+"--"+sp[3]+"--"+sp[4]);
	//document.getElementByID("stop").href=
	//alert(sp[5]);
		openwindow("stop.jsp?tripid="+sp[0]+"&startDate="+sp[1]+"&endDate="+sp[2]+"&startPlace="+sp[3]+"&endPlace="+sp[4]+"&transporter="+sp[5]);
	//alert(document.getElementByID("stop").onclick);
	
}

function displayAnchor(ind)
{
	if(ind==0) {
		//alert(sp[5]);
		openwindow("stop.jsp?tripid="+sp[0]+"&startDate="+sp[1]+"&endDate="+sp[2]+"&startPlace="+sp[3]+"&endPlace="+sp[4]+"&transporter="+sp[5]);
	}
	else
		alert("fill the stop report");
}

function openwindow(webadd){
	//alert(webadd);
	window.open(webadd,'jav','width=800,height=800,resizable=yes,scrollbars=1,menubar=0,toolbar=0,statusbar=0');
	//alert("complete");
}
function newwindow1(webadd)
{
//	alert(webad);
	window.open(webadd,'jav','width=800,height=200,resizable=yes');
//	alert("complete");
}
function generateTripId(tripId)
{
	var lastTripId=tripId+"R";
	//alert(lastTripId); 
	var tr=document.getElementById("tabl");

	tr.style.display='';
//	alert(tr.style.display);
	document.dbform.tripid.value=lastTripId;
}

function showHideTable1(id)
{
	
	var tr=document.getElementById("tabl");
	//alert(tr);
	
	var cnt=document.getElementById("cnt1").value;
	//alert(cnt);

	for(i=1;i<=cnt;i++)
	{
		//alert("i="+i);
		if(document.getElementById("debrifRadioId1"+i).checked==true)
		{
			var rad=document.getElementById("debrifRadioId1"+i);
			//alert(rad);
			var data=rad.value;
			//alert(data);
			var sp=data.split("#");
			//alert(sp[0]);
			//alert(sp[1]);
			
		}
	}
	tr.style.display='';
	document.dbform.tripid.value=sp[0];
	document.dbform.tripid.readonly=true;
	document.getElementById("debrifRadioId1"+id).checked=false;
	
}

function displayRow1(ind)
{
	var row1 = document.getElementById("gpstable");
	
	if(ind==0) 
		row1.style.display = 'none';
		
	else
		row1.style.display = '';
		
}
function displayRow2(ind)
{
	var row2 = document.getElementById("documenttable");
	
	if(ind==0) 

		row2.style.display = 'none';
		
	else
		row2.style.display = '';
		
}
function displayRow3(ind)
{
	var row3 = document.getElementById("jrmtable");
	
	if(ind==0) 
		row3.style.display = 'none';
		
	else
		row3.style.display = '';
		
}
function displayRow4(ind)
{
	//alert("true");
	
	var row4 = document.getElementById("routetable");
	//var row5 = document.getElementById("vehiclecom");
	if(ind==0) 
	{	
		displayRow7(0);
		row4.style.display = 'none';
	}	
	else
	{	
		displayRow7(1);
		row4.style.display = '';
	}		
}
function displayRow7(ind)
{
	var row7 = document.getElementById("vehiclecom");
	if(ind==0) 
		row7.style.display = 'none';
	else
		row7.style.display = '';
}
function displayRow5(ind)
{
	var row5 = document.getElementById("mentaltable");
	
	if(ind==0) 
		row5.style.display = 'none';
		
	else
		row5.style.display = '';
		
}
function displayRow6(ind)
{
	var row5 = document.getElementById("jrmtable");
	
	if(ind==0) 
		row5.style.display = 'none';
		
	else
		row5.style.display = '';
		
}
function HideandShow(id)
{
	if(id==1)
	{
		var row12 = document.getElementById("trr");
		var row20=document.getElementById("jrmtable1");
		document.dbform.tripid.style.visibility="hidden";
		row12.style.visibility="hidden";
	//	row20.style.visibility="hidden";
		document.dbform.tripid.value="";
		tripp="No";
	}
	else
	{
		var row12 = document.getElementById("trr");
		var row20=document.getElementById("jrmtable1");
		document.dbform.tripid.style.visibility="visible";
		row12.style.visibility="visible";
	//	row20.style.visibility="visible";
		tripp="Yes";
	}
}
function ShowMap(id)
{
	if(id=="1")
	{	
		document.getElementById("div1").style.display="";
		document.getElementById("div2").style.display="none";
		document.getElementById("div3").style.display="none";
		document.getElementById("div4").style.display="none";
	}
	
	if(id=="2")
	{	
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="";
		document.getElementById("div3").style.display="none";
		document.getElementById("div4").style.display="none";
	}
	
	if(id=="3")
	{	
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="none";
		document.getElementById("div3").style.display="";
		document.getElementById("div4").style.display="none";
	}

	if(id=="4")
	{	
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="none";
		document.getElementById("div3").style.display="none";
		document.getElementById("div4").style.display="";
	}
}

function newwindow(webadd)
{ 
	
	window.open(webadd,'jav','width=400,height=500,resizable=yes');
	
}
function openFeedback(driverid)
{ 
	window.open("incidentFeedbackContestDbrf.jsp?driverid="+driverid,'jav','width=400,height=200,resizable=yes,scrollbars=yes');
}

function openFeedbackVideo()
{ 
	window.open("IncidentFeedbackFormVideo.jsp",'jav1');
}
</script>

<%!
	private String getTripStartDate(final String datetime) {
		String fromdate = "";
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
			.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
					.parse(datetime));
			
		} catch (Exception e) {
			try {
				fromdate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(datetime));
				
			} catch (Exception e1) {
				try{
					fromdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(datetime));
				}
				catch(Exception e2){
					try{
					fromdate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyy-MM-dd")
							.parse(datetime));
					}
					catch(Exception e3){
						
					}
				}
			}
		}
		return fromdate;
	}

	private String getTripEndDate(final String datetime) {
		String todate = "";
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
			.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
					.parse(datetime));
			
		} catch (Exception e) {
			try{
				todate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(datetime));
			}catch(Exception e1){
				try{
					todate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(datetime));
				}
					catch(Exception e2){
						try{
						todate=new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("yyyy-MM-dd")
						.parse(datetime));
						}
						catch(Exception e3){
							
						}
						
					}
			}
		}
		
		return todate;
	}

	private String getTripStartTimeHrs(final String datetime) {
		String ftime1 = "00";
		try {
			ftime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ftime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ftime1 = "00";
			}
		}
		return ftime1;
	}

	private String getTripStartTimeMins(final String datetime) {
		String ftime2 = "00";
		try {
			ftime2 = new SimpleDateFormat("mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ftime2 = new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ftime2 = "00";
			}
		}
		return ftime2;
	}

	private String getTripEndTimeHrs(final String datetime) {
		String ttime1 = "23";
		try {
			ttime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ttime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ttime1 = "23";
			}
		}
		return ttime1;
	}

	private String getTripEndTimeMins(final String datetime) {
		String ttime1 = "59";
		try {
			ttime1 = new SimpleDateFormat("mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ttime1 = new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ttime1 = "59";
			}
		}
		return ttime1;
	}	
	private boolean isNull(final String input){
		return (null == input) || (input.trim().length()< 1) ? true : false; 
	}
	
%>
<form name="hidfrm" method="post" action="">
					<input type="hidden" id=strtDate" value=""></input>
					
					</form>

<form name="dbform" method="post" action="newdebriefinsert.jsp" onSubmit="return validate();">
<table border="1" width="100%" class="stats" bgcolor="white">

<%
	final String trainerName = session.getAttribute("user").toString();
	final String driverID = request.getParameter("driverid");
	final String driverName=request.getParameter("drivername");
	final String trans=request.getParameter("trans");
	int i=0;
	String comment="";
	session.setAttribute("specinstcomm",comment);
	int numRecords = 0; 
	int openTripRecords = 0;
	String limit="1";
	String briefId="-";
	String feedBackReply="-";
	String driverMobileNumber="";
	List<DebriefSubmitData> data = 	null;
	List<DebriefSubmitShowOpenTripsData> openTripsData = null;
	List<PeripheralOfUnitDuringTrip> peripheral=null;
	String tripStartDate="",tripEndDate="";
	String tripid="";
	//List<DebriefSubmitData> data = 	null;
	List<DebriefSubmitViewData> viewData= null;
	List<DriverDebriefForTrip> tripDebriefData = null;
	int numTriptripDebrief=0;
	int numOfPeripheralRecords=0;

	try{		
		data = vehicleDao.getDebriefSumbitData(session.getAttribute("usertypevaluemain").toString(),driverName,driverID,limit);
		if(data.size()>0){
		viewData = debriefSubmitViewDataProvider.getDebriefSubmitViewData(data,driverName,driverID);
		numRecords=viewData.size();
		}
	//	out.println("numREc===>"+numRecords);
	//	System.out.println("numREc===>"+numRecords);
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	
    if(numRecords>0 && !isNull(viewData.get(0).getBriefId())) {
		briefId = viewData.get(0).getBriefId();
		feedBackReply=viewData.get(0).getReplyFeedBack();
	//	out.println("briefid");
	}	
    if(numRecords>0){
    for(int counter=0; counter<numRecords; counter++){		
		final DebriefSubmitViewData currentRecord = viewData.get(counter);
		if(counter==0)
		{
			tripStartDate=getTripStartDate(currentRecord.getStartDate());
			tripEndDate=getTripEndDate(currentRecord.getEndDate());
		//	out.println(tripEndDate);
			tripid=currentRecord.getTripId();
		}
    }
    }
    else{
    	tripStartDate="-";
		tripEndDate="-";
		//out.println(tripEndDate);
		tripid="-";
	//	out.println("tripid = -");
	//	System.out.println("tripid = -");
    }
    
    try{		
		openTripsData = vehicleDao.getOpenTripsData(driverID,session.getAttribute("usertypevaluemain").toString());
		openTripRecords=openTripsData.size();
	//	System.out.println("openTripRecords===>"+openTripRecords);
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
%>
<%//out.println("hiii..>");%>
	<tr>
		<td colspan="2"><input type="hidden" name="brfid" value="<%=briefId%>">
		<div align="left">
		<table border="0" width="100%">
			<tr>
				
				<td>
				<div align="center"><font  size="3"><B>
				Driver DeBriefing Report of <%out.print(driverName);%></B> </font></div>
			
				</td>
			</tr>
		</table>
		</div>
	
		</td>
	</tr>
	<tr>
				<td>
	   			<style>
					.super {text-decoration: blink; text-align: center}
				</style>
				<span class="super"><font color="red" size="2"><b>New</b></font></span><br></br>
	   			<a href="#" onclick="openFeedback(<%=driverID%>);"><b>Incident Feedback</b></a><br></br>
	   </td>
	</tr>
	<tr>
		<td width="50%">
		<div align="left"><input type="hidden" name="driverid"
			value="<%out.print(driverID);%>"> <input type="hidden" name="drivername"
			value="<%out.print(driverName);%>"></div>
<%//out.println("hiii..>2");%>
		<table border="1" width="100%" class="stats">
			<tr>
				<td colspan="2" class="hed"><B> <%out.print(driverName);%> of <%out.print(trans);%>
				</B> <%//out.println("hiii..>1");%><br>
				<a href="#"
					onclick="javascript:window.open('brif_driverbrifsum.jsp?drvName=<%out.print(driverName);%>&driverid=<%out.print(driverID);%>' );">
				click here </a>to see debrief history <input type="hidden"
					name="drvrname" class="formElement" value="<%out.print(driverName);%>" /></td>
			</tr>
			<tr>
				<td>Driver Id:</td>
				<td><%out.print(driverID);%> <input type="hidden" name="drvrid"
					class="formElement" value="<%out.print(driverID);%>" readonly /></td>

			</tr>
			<tr>
				<td>Joined on:</td>
				<td>Training Date:</td>
			</tr>
			<tr>
				<td>Training Details</td>
				<td><a href="trininginfo.jsp?driverid=<%out.print(driverID);%>"
					onclick="popWin = open('briefing/trininginfo.jsp?driverid=<%out.print(driverID);%>','myWin','width=500,height=600');popWin.focus();return false">Click
				to View Training Details</a></td>
			</tr>
			<tr>
				<td colspan="2"><a
					href="brif_driverbrifsum.jsp?driverid=<%out.print(driverID);%>&drvName=<%out.print(driverName);%>"
					target="new"> Click Here</a> To View Last Briefing Details</td>
			</tr>
<%
//out.print("hello..");
//System.out.print("hello..");
try{
	
	if(numRecords>0){
	//	out.print("hello..1");
	//	System.out.print("hello..1");
		if((null!=data.get(0).getModule4() || "null".equalsIgnoreCase(data.get(0).getModule4())) && data.get(0).getModule4().equalsIgnoreCase("-"))
		{
%>
			<tr>
				<td>Last Training Date </td>
				<td><b><input type="hidden"
					name="lastTrainingDate" value="<%=data.get(0).getModule4Date()%>" maxlength="25" /></b><%=data.get(0).getModule4Date()%> </td>
			</tr>
			<tr>
				<td>Last Training </td>
				<td><b><input type="hidden"
					name="lastTraining" value="<%=data.get(0).getModule4()%>" maxlength="25" /></b><%=data.get(0).getModule4()%></td>
			</tr>
<%		}else if((null!=data.get(0).getModule3() || "null".equalsIgnoreCase(data.get(0).getModule3())) && data.get(0).getModule3().equalsIgnoreCase("-")){
		%>
		<tr>
			<td>Last Training Date </td>
			<td><b><input type="hidden"
				name="lastTrainingDate" value="<%=data.get(0).getModule3Date()%>" maxlength="25" /></b> <%=data.get(0).getModule3Date()%></td>
		</tr>
		<tr>
			<td>Last Training </td>
			<td><b><input type="hidden"
				name="lastTraining" value="<%=data.get(0).getModule3()%>" maxlength="25" /></b><%=data.get(0).getModule3()%></td>
		</tr>
<%		}else if((null!=data.get(0).getModule2() || "null".equalsIgnoreCase(data.get(0).getModule2())) && data.get(0).getModule2().equalsIgnoreCase("-")){
	%>
	<tr>
		<td>Last Training Date </td>
		<td><b><input type="hidden"
			name="lastTrainingDate" value="<%=data.get(0).getModule2Date()%>" maxlength="25" /></b> <%=data.get(0).getModule2Date()%></td>
	</tr>
	<tr>
		<td>Last Training </td>
		<td><b><input type="hidden"
			name="lastTraining" value="<%=data.get(0).getModule2()%>" maxlength="25" /></b><%=data.get(0).getModule2()%></td>
	</tr>
<%	
	}else if((null!=data.get(0).getModule1() || "null".equalsIgnoreCase(data.get(0).getModule1())) && data.get(0).getModule1().equalsIgnoreCase("-")){
		%>
		<tr>
			<td>Last Training Date </td>
			<td><b><input type="hidden"
				name="lastTrainingDate" value="<%=data.get(0).getModule1Date()%>" maxlength="25" /></b><%=data.get(0).getModule1Date()%> </td>
		</tr>
		<tr>
			<td>Last Training </td>
			<td><b><input type="hidden"
				name="lastTraining" value="<%=data.get(0).getModule1()%>" maxlength="25" /></b><%=data.get(0).getModule1()%></td>
		</tr>
	<%			
	}else if((null!=data.get(0).getBasic() || "null".equalsIgnoreCase(data.get(0).getBasic())) && data.get(0).getBasic().equalsIgnoreCase("-")){
		%>
		<tr>
			<td>Last Training Date </td>
			<td><b><input type="hidden"
				name="lastTrainingDate" value="<%=data.get(0).getBasicDate()%>" maxlength="25" /></b><%=data.get(0).getBasicDate()%> </td>
		</tr>
		<tr>
			<td>Last Training </td>
			<td><b><input type="hidden"
				name="lastTraining" value="<%=data.get(0).getBasic()%>" maxlength="25" /></b><%=data.get(0).getBasic()%></td>
		</tr>
	<%		
	}
	}else{
	//	out.println("training details in else");
	//	System.out.println("training details in else");
	%>
		<tr>
		<td>Last Training Date </td>
		<td><b>No Details Available</b> </td>
	</tr>
	<tr>
		<td>Last Training </td>
		<td><b>No Details Available</b></td>
	</tr>	
	<%	
	}
}
catch(Exception e){
	e.printStackTrace();
}
	
%>
		</table>
		</td>
		<td width="50%">
		<table>
			<tr>
				<td>
				<table class="stats" border="0" width="100%">
					<tr>
						<td align="center" colspan="4"><font size="2" ><b>Last Trip 
						Graph &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						TripId: <%=tripid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Note: * means 30kmph avg considered</b></font></td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td valign="top" style="background-color:#FFFFFF">
				<%
				
					 %>
				<div id="div1"><IFRAME
					src='debrifLasrTripChart.jsp?driverid=<%=driverID%>&tripid=<%=tripid%>&startDate=<%=tripStartDate%>&endDate=<%=tripEndDate %>&cnt=1' scrolling=no
					id='banner1' width='800' height='180'
					style='padding-top: 10; padding-left: 10' frameborder='0'></IFRAME>
				</div>
				<%
%>
			  </td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<table class="stats">
			<tr>
				<td align="center"><font  size="2"> <B>
				Last 10 Trips</B> </font></td>
			</tr>
			<tr>
				<td>
				<div
					style="margin-center: 178px; height: 170px; background-color: azure; border: 1px solid black; overflow: auto;">
				<table class="stats">
					<tr>
						<td class="hed"></td>
						<td class="hed"><B> Sr No</B></td>
						<td class="hed"><B> Trip Id</B></td>
						<td class="hed"><B> Start Date </B></td>
						<td class="hed"><B> Start Place </B></td>
						<td class="hed"><B> End Date </B></td>
						<td class="hed"><B> End Place </B></td>
						<td class="hed"><B> Distance</B></td>
						<td class="hed"><B> OS </B></td>
						<td class="hed"><B> RA </B></td>
						<td class="hed"><B> RD </B></td>
						<td class="hed"><B> ND </B></td>
						<td class="hed"><B> Rating </B></td>
						<td class="hed"><B> Disconnection Count </B></td>
						<td class="hed"><B> Peripheral in Vehicle </B></td>
					</tr>
					
<%
if(numRecords>0){
	
	DisconnectionCount disconnCount = new DisconnectionCount();
	for(int counter=0; counter<numRecords; counter++){		
		final DebriefSubmitViewData currentRecord = viewData.get(counter);
		i = counter + 1;	
		
		
%>
					
					<tr>
<%
try{		
	tripDebriefData = vehicleDao.getDebriefStatusForTrip(currentRecord.getTripId(),session.getAttribute("usertypevaluemain").toString());
	numTriptripDebrief=tripDebriefData.size();
	
	
}
catch (Exception e) {
	e.printStackTrace();
}
	if(numTriptripDebrief>0)
	{
	for(int counter1=0; counter1<numTriptripDebrief; counter1++){		
		final DriverDebriefForTrip tripRecord = tripDebriefData.get(counter1);
		if(Integer.parseInt(tripRecord.getCount())>0){
%>				
					<td>
					
					</td>
<%
		}
		else{
%>
				<td><input type="radio" name="debrifRadioId" id="debrifRadioId<%=i %>" value="<%=currentRecord.getTripId()%>#<%=getTripStartDate(currentRecord.getStartDate())%>#<%=getTripEndDate(currentRecord.getEndDate())%>#<%=currentRecord.getStartPlace()%>#<%=currentRecord.getEndPlace()%>#<%=trans%>#<%=currentRecord.getVehicleId()%>#<%=driverID%>" onclick="javascript:showHideTable(<%=i %>)"></input></td>
<%
			}
%>
<%
		}
	}
	else{
		%>
						<td><input type="radio" name="debrifRadioId<%=i %>" id="debrifRadioId<%=i %>" value="<%=currentRecord.getTripId()%>#<%=currentRecord.getStartDate()%>#<%=getTripEndDate(currentRecord.getEndDate())%>#<%=currentRecord.getStartPlace()%>#<%=currentRecord.getEndPlace()%>#<%=trans%>#<%=currentRecord.getVehicleId()%>#<%=driverID%>" onclick="javascript:showHideTable(<%=i %>)"></input></td>
		<%
					}
%>
					<td style="text-align: right"><%=i %>

<%
		if(i==1)
		{
			
			if(isNull(currentRecord.getDriverMobileNumber())){
				driverMobileNumber="-";
			}
			else{
				driverMobileNumber=currentRecord.getDriverMobileNumber();
			}
				
%>
						<input type="hidden" name="hidLastTripRating" value="<%= currentRecord.getTripRating() %>" /> 
						<input type="hidden" name="hidLastTripId" value="<%=currentRecord.getTripId()%>" />
<% 
//javascript:toggleDetails(=i,false);" onclick="	
}
%>
						</td>
						<td style="text-align: right"><a
							href="javascript:toggleDetails(<%=i%>,true);"
							title="Click To See the Reports"> <%=currentRecord.getTripId()%></a>
						<br>
						<div class="popup" id="popup<%=i%>">
						<table border="1" bgcolor="white">
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);" 
								onclick="javascript:window.open('ShowCustomReportonTWMap.jsp?tripid=<%=currentRecord.getTripId()%>&vehcode=<%=currentRecord.getVehicleId()%>&data=<%=getTripStartDate(currentRecord.getStartDate())%>&data1=<%=getTripEndDate(currentRecord.getEndDate())%>&ftime1=<%=getTripStartTimeHrs(currentRecord.getStartDate())%>&ftime2=<%=getTripStartTimeMins(currentRecord.getStartDate())%>&ttime1=<%=getTripEndTimeHrs(currentRecord.getEndDate())%>&ttime2=<%=getTripEndTimeMins(currentRecord.getEndDate())%>&vehregno=<%=currentRecord.getVehicleRegistrationNumber()%>&ownername=<%=currentRecord.getOwnerName()%>&startplace=<%=currentRecord.getStartPlace()%>&endplace=<%=currentRecord.getEndPlace()%>&pg=debrif');">Show
								Trip on Map </a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);" 
								onclick="newwindow1('debrifLasrTripChart.jsp?driverid=<%=driverID%>&tripid=<%=tripid%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>&cnt=1');">Driver RunHrs Chart
								</a></td>
							</tr>
							
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brif_customreport.jsp?tripid=<%=currentRecord.getTripId()%>&vehicleRegistrationNo=<%=currentRecord.getVehicleRegistrationNumber()%>&vehcode=<%=currentRecord.getVehicleId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>' );">Trip
								detail report </a></td>
							</tr>
							
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brfexceprepot.jsp?tripid=<%=currentRecord.getTripId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>' );">Trip
								exception report</a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('stop.jsp?tripid=<%=currentRecord.getTripId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>&startPlace=<%=currentRecord.getStartPlace() %>&endPlace=<%=currentRecord.getEndPlace() %>' );">Stops
								 report</a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);">Close
								</a></td>
							</tr>
						</table>
						</div>
						</td>
						<td style="text-align: left"><%=currentRecord.getStartDate() %></td>
						<td style="text-align: left"><%=currentRecord.getStartPlace()%></td>
						<td style="text-align: left"><%=currentRecord.getEndDate() %></td>
						<td style="text-align: left"><%=currentRecord.getEndPlace()%></td>
						<td style="text-align: right"><%=currentRecord.getKmTravelled()%></td>
						<td style="text-align: right"><%=currentRecord.getOverSpeedCount()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidAccelerationCount()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidDecelerationCount()%></td>
						<td style="text-align: left"><%=currentRecord.getNightDrivingInfo()%></td>
						<td style="text-align: right"><%=currentRecord.getTripRating()%></td>
						<%int disconCount=0;
						disconCount = disconnCount.CalulateDrivingHours(currentRecord.getVehicleId(),getTripStartDate(currentRecord.getStartDate()),getTripEndDate(currentRecord.getEndDate()),currentRecord.getTripId()); 
						if(disconCount>0)
						{
							%>
							<td style="text-align: right"><a href="#" onclick="javascript:window.open('disconnectionFeedBack.jsp?ownername=<%=currentRecord.getOwnerName() %>&vehicleCode=<%=currentRecord.getVehicleId()%>&tripid=<%=currentRecord.getTripId()%>&fromDateTime=<%=currentRecord.getStartDate()%>&toDateTime=<%=currentRecord.getEndDate()%>','','top=200,left=200,width=800,height=400,resizable=1,scrollbars=1');"><%=disconCount%></a></td>
							<%
						}
						else
						{
							%>
							<td style="text-align: right"><%=disconCount%></td>
							<%
						}
						%>
						<%
						try{
							peripheral=vehicleDao.getPeripheralOfUnitDuringTrip(currentRecord.getVehicleId(),new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(currentRecord.getStartDate())),new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(currentRecord.getEndDate())));
							numOfPeripheralRecords=peripheral.size();
						}
						catch(Exception e){
							e.printStackTrace();
						}
						if(numOfPeripheralRecords>0)
						{
							%>
							<td style="text-align: left"><%=peripheral.get(0).getPeripheral()%></td>
							<%
						}
						else
						{
						%>
							<td style="text-align: left"><%="-"%></td>
						<%	
						}
						%>
					</tr>
<%
		}
		
	}	
else{
	//out.println("not in completed journey");
	//System.out.println("not in completed journey");
	%>
						<tr>
						<td align="center" colspan="15"><font  size="3">NO TRIPS</font></td>
						</tr>
	<%
			}
%>
				</table>
				<input type="hidden" name="cnt" id="cnt" value="<%=i%>"></input>
				</div>
				</td>

			</tr>
		</table>

		</td>
	</tr>
	<tr>
	<td colspan="2">
		<table class="stats">
<%
if(openTripRecords>0)
{
	//out.println("in open journey");
	//System.out.println("in open journey");
%>
			<tr>
				<td align="center"><font  size="2"> <B>
				Open Trips</B> </font></td>
			</tr>
			<tr>
				<td>
				<div style="margin-center: 178px; height: 170px; background-color: azure; border: 1px solid black; overflow: auto;">
				<table class="stats">
					<tr>
						<td class="hed"><B> Sr No</B></td>
						<td class="hed"><B> Trip Id</B></td>
						<td class="hed"><B> Start Date </B></td>
						<td class="hed"><B> Start Place </B></td>
						<td class="hed"><B> End Place </B></td>
					</tr>
					<%
					
						for(int countr=0; countr<openTripRecords; countr++){		
							final DebriefSubmitShowOpenTripsData currentRecord = openTripsData.get(countr);
							i = countr + 1;		
%>
					<tr>
					<!--<td>
					<input type="radio" name="debrifRadioId1< %=i %>" id="debrifRadioId1< %=i %>" value="< %=currentRecord.getTripId()%>#< %=currentRecord.getStartDate()%>" onclick="javascript:showHideTable1(< %=i %>)"></input></td>-->
						<td style="text-align: left"><%=i%></td>
						<td style="text-align: left"><a
							href="javascript:toggleDetails1(<%=i%>,true);"
							title="Click To See the Reports"><%=currentRecord.getTripId()%></a>
							<br>
						<div class="popup" id="popupx<%=i%>">
						<table border="1" bgcolor="white">
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);" 
								onclick="javascript:window.open('endtrip.jsp?tripid=<%=currentRecord.getTripId()%>&vehcode=<%=currentRecord.getVehicleCode()%>&vehno=<%=currentRecord.getVehicleRegistrationNumber()%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">End Trip
								</a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails1(<%=i%>,false);">Close
								</a></td>
							</tr>
							</table>
							</div>
							</td>
						<td style="text-align: left"><%=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentRecord.getStartDate()+" "+currentRecord.getStartTime()))%></td>
						<td style="text-align: left"><%=currentRecord.getStartPlace()%></td>
						<td style="text-align: left"><%=currentRecord.getEndPlace()%></td>
					</tr>
<%
						}
					
%>

					</table>
					<input type="hidden" name="cnt1" id="cnt1" value="<%=i%>"></input>
					</div>
					</td>
				</tr>
<%
				}
					else{
					//	out.println("not in open journey");
%>
						<tr>
						<td align="center" colspan="14"><font  size="2">NO OPEN TRIPS</font></td>
						</tr>
<%						
					}
%>
				</table>
				</td>	
		</tr>
<%
			if(numRecords>0){
%>
		<tr>
		<td colspan="2"><input type="button" id ="generateTrip" value="Click Here" onclick="generateTripId(<%=viewData.get(0).getTripId()%>)"></input> To Generate New TripId
		</td>
		</tr>
<%
			}
			else{
				
			}
%>		
	
	<tr id="tra">
	<td colspan="2">
		
		<table width="100%" class="stats" id="tabl"
					style="display: none">
			<tr>
				<td align="center" colspan="3"><b><font size="2"
					>Driver Debriefing</font></b></td>
			</tr>
			<tr>
				<td width="0%">Trainer Name</td>
				<td width="" colspan="2"><%=trainerName%><input type="hidden"
					name="trinerName" value="<%=trainerName%>" maxlength="25" readonly />
					<input type="hidden"
					name="transporter" value="<%=trans%>" maxlength="25" readonly />
				<a href="#"
					onclick="javascript:window.open('brif_trinerbrifsum.jsp?trNm=<%=trainerName%>&pgFrom=debrif');">
				click here </a>to see Debrief history</td>
			</tr>
			<tr>
				<td><b><blink><font color="RED">Feed Back Reply From Transporter</font></blink></b></td>
				<td colspan="2"><blink><font color="RED" size="3"><b><%=feedBackReply%></b></font></blink></td>
			</tr>
			<tr>
				<td>Trip Classification</td>
				<td colspan="2">
<%
	if(session.getAttribute("usertypevaluemain").toString().equals("Castrol"))
	{
%> 
	<input type="radio" name="tripClassi" value="Castrol Trip"
					id="Trip" CHECKED onClick="HideandShow(0);">Castrol Trip
				&nbsp;&nbsp; <input type="radio" name="tripClassi"
					value="Non Castrol Trip" id="NonTrip" onClick="HideandShow(1);">
				Non Castrol trip &nbsp;&nbsp;&nbsp;&nbsp; 
<%
	}
	else if(session.getAttribute("usertypevaluemain").toString().equals("BS"))
	{
%> 
	<input type="radio" name="tripClassi" value="Shell Trip" id="Trip"
					CHECKED onClick="HideandShow(0);">Shell Trip &nbsp;&nbsp; <input
					type="radio" name="tripClassi" value="Non Shell Trip" id="NonTrip"
					onClick="HideandShow(1);"> Non Shell trip 
<%
	} 
%> 

			<b><label id="trr"> Trip ID : <input type="Text"
					name="tripid" id="tripid" value=""  readonly></input>
					<input type="hidden" id="transporter" value=<%=trans%>></input> </label>
					</b><div id="jrmDevice" style="display:none"><label>Unit Installed has JRM Device</label></div>
					Fill stop report : <input type="radio" name="stprpt" id="ancYes" value="Yes" onClick="displayAnchor(0);"> Yes &nbsp;&nbsp; 
					<input type="radio" name="stprpt" value="No" id="ancNo" onClick="displayAnchor(1);" CHECKED> No
					<!--<label id="id_anchor"><a href="#" id="stop" onclick="javascript :newwindow2()">Click here to view Stops Report</a></label>-->
					</td>
	
			</tr>

			<tr>
				<td class="hed">
				<div align="left">GPS Captured Data</div>
				</td>
				<td><input type="radio" name="gpscapt" value="Yes"
					onClick="displayRow1(0); showper(1);" CHECKED> Yes
				&nbsp;&nbsp; <input type="radio" name="gpscapt" value="No"
					onClick="displayRow1(1); showper(0);"> No</td>
				<td>
				<div id="captgps" style="display: ''"><select name="percGPS"
					class="formElement">
					<option value="select">Select</option>
<%
    for(int p = 100; p>=0; p-=5){
%>
					<option id="gpsPercnt" value="<%=p%>"><%=p%></option>
<%
    }
%>
				</select>Please mention how many percents <br>
				gps data has been captured.</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="gpstable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left"><b>GPS- Serviceable</b></div>
						</td>
						<td width="25%"><input type="radio" name="Serviceable"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="Serviceable" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=Serviceable&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b>Complete trip data available </b></div>
						</td>
						<td><input type="radio" name="tripdata" value="Yes" CHECKED>
						Yes &nbsp;&nbsp; <input type="radio" name="tripdata" value="No">
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=tripdata&comfrom=debrief');return false"
							target="_parent">Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b>Re-Activated (date)</b></div>
						</td>
						<td><input type="radio" name="reactive" value="Yes" CHECKED>
						Yes &nbsp;&nbsp; <input type="radio" name="reactive" value="No">
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=reactive&comfrom=debrief');return false"
							target="_parent">Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b> Replaced (if yes when)</b></div>
						</td>
						<td><input type="radio" name="replaced" value="Yes" CHECKED>
						Yes &nbsp;&nbsp; <input type="radio" name="replaced" value="No">
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=replaced&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b> Any other observation
						(tampered/disconnected)</b></div>
						</td>
						<td><input type="radio" name="OtherObs" value="Yes" CHECKED>
						Yes &nbsp;&nbsp; <input type="radio" name="OtherObs" value="No">
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=OtherObs&comfrom=debrief');return false"
							target="_parent">Click</a> to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>


			<tr>
				<td width="100%" colspan="3">
				<table id="jrmtable1" width="100%" class="stats" style="display: ''">
					<tr>
					
					
					
					
					
					
					
					
					
					
						 <%
						 String jrm = "";
						 String sql11="select JRM from t_transporter where TypeValue='"+trans+"' ";
						st.execute(sql11);
						ResultSet rs=st.executeQuery(sql11);
						while(rs.next())
						{
							 jrm=rs.getString(1);
							//System.out.println("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee444444444444444" +jrm);
							
						}
						if(jrm=="YES" || jrm.equalsIgnoreCase("YES"))
						
						{
							%>
						<td colspan="" class="hed" width="50%">
						<div align="left"><b>JRM </b><a href="javascript:flase" onclick="javascript:window.open('JRMRoute.jsp');"> (Click to view JRM All Routes Map)</a></div>
						</td>
						<td><input type="radio" name="jrmdb" value="Yes"
							onClick="displayRow3(1);"> Yes &nbsp;&nbsp; <input
							type="radio" name="jrmdb" value="No" onClick="displayRow3(0);"
							CHECKED> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdjrmbrief&comfrom=debrief');return false"
							target="_parent"> Click</a>to add Comment
							</td>
							<% 
						}
							else
							{
								%>
								<td colspan="" class="hed" width="50%">
							<div align="left"><b>JRM- Briefed</b> (Click to view JRM All Routes Map)</div>
							</td>
							
								<td>
							<div align="left"><b><font size="2" color="red"> JRM Briefing/Debriefing is not allowed for <%=trans %></font></b> </div>
							</td>
							
							<td></td>
							<% 
							}
							
	                          %>	
	                          
	                          
	                          
	                          
	                          
	                          
	                          
	                          
							
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="jrmtable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left"><b> Have you driven in the same route
						earlier? (compare violations/ratings)</b></div>
						</td>
						<td width="25%"><input type="radio" name="drivearlier"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="drivearlier" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=drivearlier&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> Any unscheduled stops
						-(why,where,when)</b></div>
						</td>
						<td width="25%"><input type="radio" name="unsched"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="unsched" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=unsched&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> Any deviation of route ? &nbsp;</b></div>

						</td>
						<td width="25%"><input type="radio" name="routdev"
							value="Yes" onclick= "routeDeviation(0)"> Yes &nbsp;&nbsp; <input type="radio"
							name="routdev" value="No"  onclick= "routeDeviation(1)" CHECKED> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=routdev&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> Route Feedback?</b></div>
						</td>
						<td width="25%"><input type="radio" name="jrmrisk"
							value="Yes" onclick= "routeFeedBack(0)"> Yes &nbsp;&nbsp; <input type="radio"
							name="jrmrisk" value="No" onclick= "routeFeedBack(1)" CHECKED> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=jrmrisk&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					
					<tr>
						<td width="50%">
						<div align="left"><b> Zone feedBack?</b></div>
						</td>
						<td width="25%"><input type="radio" name="otherFeedback"
							value="Yes" onclick= "zoneFeedBack(0)"> Yes &nbsp;&nbsp; <input type="radio"
							name="otherFeedback" value="No" onclick= "zoneFeedBack(1)" CHECKED> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=otherFeedback&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					
					<%//--------------change today--------------- %>
					<tr>
						<td width="50%">
						<div align="left"><b> Whether driver warned about zone change correctly?</b></div>
						</td>
						<td width="25%"><input type="radio" name="zonechangewarning"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="zonechangewarning" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=zonechangewarning&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					
					
					
					<tr>
						<td width="50%">
						<div align="left"><b> JRM device installed?</b></div>
						</td>
						<td width="25%"><input type="radio" name="JRMinstalled"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="JRMinstalled" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=JRMinstalled&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					
					<tr>
						<td width="50%">
						<div align="left"><b> Route uploaded from beginning?</b></div>
						</td>
						<td width="25%"><input type="radio" name="routeUpload"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="routeUpload" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=routeUpload&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					
				<%//--------------change today--------------- %>

				</table>
				</td>
			</tr>
			
			
			<tr>
				<td colspan="" class="hed" width="50%">
				<div align="left"><b>Vehicle fit for next trip</b></div>
				</td>
				<td><input type="radio" name="vehfit" value="Yes"
					onClick="displayRow4(1);"> Yes &nbsp;&nbsp; <input
					type="radio" name="vehfit" value="No" onClick="displayRow4(0);"
					CHECKED> No</td>
				<td colspan="2">
				<table border="0" id="vehiclecom" width="100%" style="display: none">
					<tr>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=vehfit&comfrom=debrief');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
				</table>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="routetable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left"><b> Due for any major servicing/repair</b>
						</div>
						</td>
						<td width="25%"><input type="radio" name="servicedue"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="servicedue" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=servicedue&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> Any visible/reported damage ?</b></div>
						</td>
						<td width="25%"><input type="radio" name="visibledamage"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="visibledamage" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=visibledamage&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> Overall Condition of the vehicle
						for the road worthiness for the coming trip )</b></div>
						</td>
						<td width="25%"><input type="radio" name="overall"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="overall" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=overall&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>

				</table>
				</td>
			</tr>
			<tr>
				<td colspan="" class="hed" width="50%">
				<div align="left"><b>Driver -Fitness</b></div>
				</td>
				<td><input type="radio" name="driverfit" value="Yes"
					onClick="displayRow5(1);"> Yes &nbsp;&nbsp; <input
					type="radio" name="driverfit" value="No" onClick="displayRow5(0);"
					CHECKED> No</td>
				<td><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=driverfit&comfrom=debrief');return false"
					target="_parent"> Click</a>to add Comment</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="mentaltable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left"><b> Any visible abnormality
						(physically/mentally)Injured, looked tired,</b></div>
						</td>
						<td width="25%"><input type="radio" name="visibleabnorm"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="visibleabnorm" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=visibleabnorm&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> Driver responding normal ?(pls
						note the observation)</b></div>
						</td>
						<td width="25%"><input type="radio" name="drrespons"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="drrespons" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=drrespons&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> Any other observation</b></div>
						</td>
						<td width="25%"><input type="radio" name="drfitothobs"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="drfitothobs" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=drfitothobs&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> The trip was completed by the same
						driver (record the observation)</b></div>
						</td>
						<td width="25%"><input type="radio" name="tripsamedriver"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="tripsamedriver" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=tripsamedriver&comfrom=debrief');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>


				</table>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Driver Response</b></div>
				</td>
				<td colspan="2"><textarea name="drvresp" class="formElement" /> </textarea>
				</td>
			</tr>

			<tr>
				<td>
				<div align="left"><b> Driver Mobile No.</b></div>
				</td>
				<td colspan="2"><input type="radio" name="mobno" value="Yes"
					CHECKED onClick="HideandShow1(0);">Yes &nbsp;&nbsp; <input
					type="radio" name="mobno" value="No" onClick="HideandShow1(1);">
				No <input type="text" name="drvMobNo" id="drvMobNo"
					value="<%=driverMobileNumber%>" maxlength="10" /></td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Other Observation </b></div>
				</td>
				<td><input type="radio" name="AllOthrObs" value="Yes" CHECKED>
				Yes &nbsp;&nbsp; <input type="radio" name="AllOthrObs" value="No">
				No</td>
				<td><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdAllOthrObs&comfrom=debrief');return false"
					target="_parent"> Click</a> to add Comment</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b>Remarks /special instructions </b></div>
				</td>
				<td><input type="radio" name="Rem" value="Yes"> Yes
				&nbsp;&nbsp; <input type="radio" name="Rem" value="No" CHECKED>
				No</td>
				<td><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=specinst&comfrom=debrief');return false"
					target="_parent"> Click</a> to add Comment</td>
			</tr>

			<tr>
				<td colspan="3" align="center"><input type="submit"
					name="submit" value="Submit" class="formElement" /></td>
			</tr>
		</table>
		
		</td>
	</tr>
</table>
</form>
<%@ include file="footernew.jsp"%>