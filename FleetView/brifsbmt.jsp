<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.DebriefSubmitData"
	import="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
	import="com.transworld.fleetview.framework.DebriefSubmitViewData"
	import="com.transworld.fleetview.framework.ReasonOfRejection"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberForTransporter"
	import="com.fleetview.beans.DisconnectionCount"
	import="com.transworld.fleetview.framework.PeripheralOfUnitDuringTrip"%>
	

<%@ include file="headernew.jsp"%>


<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>

<jsp:useBean id="debriefSubmitViewDataProvider"
	type="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
	scope="application"></jsp:useBean>

<style>
<!--
SPAN.searchword {
	background-color: cyan;
}
-->
</style>
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
<script language="JavaScript">
<!--
function loadSearchHighlight()
{
	SearchHighlight();
	document.searchhi.h.value = searchhi_string;
	if( location.hash.length > 1 ) location.hash = location.hash;
}
// -->
</script>

<script language="javascript">



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

function popitup(){
	//	alert("hii");
	var webadd ="castrol_customDetailReport.jsp";
	var VehRegNo=document.driverbriefingform1.VehRegNo.value;
	//alert(webadd);
	var webadd1 = webadd+"?vehicleRegistrationNo="+VehRegNo;
	//alert(webadd1);
	window.open(webadd1);
}

function getPeripheral(frmele)
{

	var VehRegNo=document.driverbriefingform1.VehRegNo.value;
	//alert(VehRegNo);
	var reslt=VehRegNo.split(",");
	var peripheral=reslt[1];
	var jrmBuzz="JRM";
	//alert(trim(peripheral));
//	alert(document.getElementById("customdetailreport").style.display);
	
	document.getElementById("customdetailreport").style.display="";
//	if(trim(peripheral)==trim(jrmBuzz))
	RouteName(VehRegNo);
	if(peripheral.indexOf(jrmBuzz)!=-1)
	{
		document.getElementById("jrmDevice").style.display="";
		document.getElementById("vehroute").style.display= "";
	}
	else{
		document.getElementById("jrmDevice").style.display="none";
		document.getElementById("vehroute").style.display= "none";
		document.getElementById("vehroute").innerHTML= "";
	}
	
}





function RouteName(VehRegNo)
{
	 //alert("in fun");
	 var ajaxRequest;  // The variable that makes Ajax possible!
	    try
	    {
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
				document.getElementById("vehroute").innerHTML = reslt;
				//alert(">>>    "+reslt);
				}
				else
				{
			    	//alert("data not fetch successfully");
					
				}
			}
		
		var queryString = "?VehRegNo="+VehRegNo;
		//alert(queryString);
		
		ajaxRequest.open("GET", "AjaxgetVehroute.jsp" + queryString, true);
		ajaxRequest.send(null); 
}




var tripp="Yes";
var mb="Yes";
var gps="Yes";
var othdeb="No";
var perm="yes";
function functoggle(sel)
{
	
if(sel.selectedIndex==0)
	{
		sel.form['commentForReason'].style.display="none";
		document.getElementById('rsn').style.display="none";
	}
	else 
	{
		sel.form['commentForReason'].style.display='';
		document.getElementById('rsn').style.display="";
	};
}
function validate()
{
	
	//alert("hi..");
	//alert(cmntreason);
	//alert("cmntreason: "+cmntreason.length);
	//alert(document.driverbriefingform1.reason.value);
		/*var commentForReason=document.driverbriefingform1.commentForReason.value;
	if(reason!='None'){
	if(commentForReason.length==0){
		alert("Please enter reason for rejection");
		return false;
	}*/
	//var closeStatus=document.getElementById("rejectionConfirmNo");//document.driverbriefingform1.rejectionConfirm.value;
//	alert(document.getElementById("rejectionConfirmNo"));
	//if(closeStatus=='No'){
	//	alert("Please check the Previous Rejection And Close it"+closeStatus);
	//	alert(document.getElementById("rejectionConfirmNYes"));
	//	return false;
	//}
	var tpclass=document.driverbriefingform1.tripid.value;
	//("tripid---->"+tpclass);
	var percGPS=document.driverbriefingform1.percGPS.value;
	//(percGPS);
	var startplace=document.driverbriefingform1.startplace.value;
	//alert(startplace);
	var endplace=document.driverbriefingform1.endplace.value;
	//alert(endplace);
	var drvresp=document.driverbriefingform1.drvresp.value;
	//alert(drvresp);
	var v27=document.driverbriefingform1.othperson.value;
	tpclass=tpclass.replace(/^\s+|\s+$/g,"");//trim	
	drvresp=drvresp.replace(/^\s+|\s+$/g,"");
	var VehRegNo=document.driverbriefingform1.VehRegNo.value;
	

	var mobno=document.getElementById("drvMobNo").value;
	//alert("&****    "+mobno);
	if(mobno == "")
	{
		alert("Please Enter the Mobile No.");
		return false;
	}
	else
		if(isNaN(mobno))
		{
			alert("Please Enter valid Mobile No.");
			return false;
		}
		else if(mobno.length < 10)
		{
			alert("Please Enter valid Mobile No.");
			return false;
		}
	
	if(tripp=="Yes")
	{
		//alert("hi just Relax !!! Ok !");
		if(tpclass.length==0)
		{
			alert("please enter trip id");
			return false;
		}
		if(tpclass.length>100){
			alert("tripid length should not be greater than 100");
		}
		/*if(isNaN(tpclass))
  		{
  			alert("please enter only Numeric trip id");
			return false;
		}*/
		
	}
	//alert("hi Vikram just Relax !!! Ok !");
	if(startplace=="Select")
	{
		alert("Please select Trip start Place");
		return false;
	}	
	//alert("hi Vikram just Relax !!! Ok !");
	if(endplace=="Select")
	{
		alert("Please select Trip End Place");
		return false;
	}		

	if(VehRegNo=='Select')
	{
		alert("Please select Vehicle Registration Number");
		return false;
	}
	if(gps=="Yes")
	{
		if(percGPS=="Select")
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
	var reason=document.driverbriefingform1.reason.value;
	var cmntreason=document.getElementById('cmntreason').value;
	var rejectionConfirm=document.driverbriefingform1.rejectionConfirm;

	if(reason=='None'){
		//alert("Submit form");
		
	}
	else{	//alert(cmntreason);
		//alert(cmntreason.length);
		//if(cmntreason==""||cmntreason.length==0||cmntreason.length==1){
//			alert("Please enter the reason for rejection");
		//	return false;
		}
	

	if(reason=='None'){
	//	alert("Driver / Vehicle is Rejected.");
	//	return false;
	}
	else{
	//	
	}
	
	
	/*if(reason=="Not Rejected"){
		alert("Submit form");
		
	}
	else{	alert(cmntreason);
		alert(cmntreason.length);
		if(cmntreason==""||cmntreason.length==0||cmntreason.length==1){
			alert("Please enter the reason for rejection");
			return false;
		}
	}

	if(reason=="Not Rejected"){
	//
	}
	else{
			alert("Driver / Vehicle is Rejected.");
			return false;
	}*/
	
	if(perm=="yes")
	{	
		if(v27.length==0)
		{
			alert("please Enter permissin By person");
			return false;
		}
	}
	
		

	
	
	

	
	
	var rad_val;
	//alert(VehRegNo);
	for (var i=0; i < rejectionConfirm.length; i++)
	   {
	   if (rejectionConfirm[i].checked)
	      {
		   rad_val= document.driverbriefingform1.rejectionConfirm[i].value;
	      }
	   }
	   
	if(rad_val=="No"|| rad_val==""){
		alert("please close previous rejection");
		return false;
	}
	
	
	
	return true;
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
function displayRow(ind)
{
	var row = document.getElementById("inputtable");

	if(ind==0) 
		row.style.display = 'none';

	else
		row.style.display = '';		
}

function HideandShow(id)
{
	if(id==1)
	{
		var row12 = document.getElementById("trr");
		var row20=document.getElementById("jrmtable1");
		document.driverbriefingform1.tripid.style.visibility="hidden";
		row12.style.visibility="hidden";
		//row20.style.visibility="hidden";
		document.driverbriefingform1.tripid.value="";
		tripp="No";
	}
	else
	{
		var row12 = document.getElementById("trr");
		var row20=document.getElementById("jrmtable1");
		document.driverbriefingform1.tripid.style.visibility="visible";
		row12.style.visibility="visible";
		//row20.style.visibility="visible";
		tripp="Yes";
	}
}

function HideandShow1(id)
{
	if(id==1)
	{
		var row12 = document.getElementById("drvMobNo");
		
		document.driverbriefingform1.drvMobNo.style.visibility="hidden";
		row12.style.visibility="hidden";
		document.driverbriefingform1.drvMobNo.value="";
		mb="No";
	}
	else
	{
		var row12 = document.getElementById("drvMobNo");
		document.driverbriefingform1.drvMobNo.style.visibility="visible";
		row12.style.visibility="visible";
		mb="Yes";
	}
}
function HideandShow2(id)
{
	if(id==1)
	{
		var row21=document.getElementById("permition");
		row21.style.visibility="hidden";
		perm="No";
	}
	else
	{
		var row21=document.getElementById("permition");
		row21.style.visibility="visible";
		perm="yes";
	}
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
	var row3 = document.getElementById("vehicletable");
	
	if(ind==0) 
		row3.style.display = 'none';
		
	else
		row3.style.display = '';
		
}

function displayRow4(ind)
{
	var row4 = document.getElementById("routetable");
	
	if(ind==0) 
		row4.style.display = 'none';
		
	else
		row4.style.display = '';
		
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



      
function ShowNewProbText1(ind)
{ 
	//alert("Hi");
       	var othdebit=document.getElementById("othdeb");
	if(ind==1)
	{
		othdebit.style.display='';
		othdeb="Yes";
	}
	else
	{
		othdebit.style.display='none';
		othdeb="No";
	}
}	
function AJAXFunc(id)
{
	//alert("now in ajax function");
	if(id==1){
		alert("You cannot brief the driver unless you close the previous rejection");
	}
	else{
  var v1=document.driverbriefingform1.drvrid.value;
  var v2=document.driverbriefingform1.drvrName.value;
  var v3=document.driverbriefingform1.drvrTransporter.value;
 // var v2=document.driverbriefingform1.closedRejection.value;
 // alert(v1+v2+v3);
  var ajaxRequest;  // The variable that makes Ajax possible!

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
                      //reslt = reslt.replace(/^\s+|\s+$/g,"");//trim
                  //    alert(reslt);
                      var resnew=reslt.split("#");

                      //var insert=resnew[0];
                      var driverid=resnew[0];
                      var drivername=resnew[1];
                      var transporter=resnew[2];
                    //  alert("--------"+driverid,drivername,transporter);
                      
                     // if(reslt=="inserted"){
                        //  alert("hi");
                          var jspcall="brifsbmt.jsp?driverid="+v1+"&drivername="+v2+"&trans="+v3;
                        //  alert(jspcall);
                          window.location.href = jspcall;
                   //  }
                    //  else{
                          
                    //  }
                      
 	       } 
            };
           var queryString = "?driverid="+v1+"&driverName="+v2+"&trans="+v3;
        //   var queryString1 = "&commentRejection=" +v2;
      //  alert(queryString);
 	   ajaxRequest.open("GET", "reasonForRejectoninsert.jsp" + queryString, true);
 	   ajaxRequest.send(null); 
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
function newwindow1(webadd)
{ 
	window.open(webadd,'jav','width=800,height=200,resizable=yes');
}
function newwindow(webadd)
{ 
	window.open(webadd,'jav','width=600,height=600,resizable=yes');
} 
function openFeedback()
{ 
	window.open("incidentFeedbackContest.jsp",'jav','width=400,height=200,resizable=yes,scrollbars=yes');
}

function openFeedbackVideo()
{ 
	window.open("IncidentFeedbackFormVideo.jsp",'jav1');
}


//-->
</script>

<%!	
private String getTripStartDate(final String datetime) {
	String fromdate = "";
	try {
		fromdate = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
				.parse(datetime));
		
	} catch (Exception e) {
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(datetime));
			
		} catch (Exception e1) {
			try{
				fromdate = new SimpleDateFormat("yyyy-MM-dd")
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

private String getTripStartDateTime(final String datetime) {
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
		todate = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
				.parse(datetime));
		
	} catch (Exception e) {
		try{
			todate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(datetime));
		}catch(Exception e1){
			try{
				todate = new SimpleDateFormat("yyyy-MM-dd")
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

<form name="driverbriefingform1" method="post" action="brifinsert.jsp" onSubmit="return validate();" >
<table border="1" width="100%" class="stats" bgcolor="white">

<%	
	final String lastmnthdate="", lastsixdate="", riskratingfrmtd="";
	//System.out.println("step1");
	final String trainerName = (String) session.getAttribute("user");
	final String drverid=request.getParameter("driverid");
	final String drivernam=request.getParameter("drivername");
	
	
	final String transname=request.getParameter("trans");
	final String transporter=request.getParameter("trans");
	
	session.setAttribute("drivername",drivernam);
	session.setAttribute("driverid",drverid);
	session.setAttribute("tname",transname);
	final String trans=request.getParameter("trans");
	final String briefId = request.getParameter("briefId");
	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String tdydte1=formatter.format(tdydte);
	NumberFormat nf = DecimalFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);	
	nf.setGroupingUsed(false);
	String drivermob="";
	final String drivername=(String) session.getAttribute("drivername");
	final String driverid=(String) session.getAttribute("driverid");
	final String transporterName=(String) session.getAttribute("tname");
	String commtext="";	//reset
	session.setAttribute("remarkcom",commtext);
	int numRecords=0;
	int numRecordsFor=0;
	String limit="10";
	String driverMobileNumber="";
	//System.out.println("step2");
	String msg="";
	List<DebriefSubmitData> data = 	null;
	List<ReasonOfRejection> reason = 	null;
	List<DebriefSubmitViewData> viewData= null;
	List<VehicleRegistrationNumberForTransporter> VehRegNumber=null;
	List<PeripheralOfUnitDuringTrip> peripheral=null;
	List<String> castrolZones =null;
	int numOfRejectionRecords=0;
	int numOfVehRecords=0;
	int numOfPeripheralRecords=0;
	try{
		castrolZones=vehicleDao.getCastrolZones();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	try{
		reason=vehicleDao.getReasonOfRejection(driverid);
		numOfRejectionRecords=reason.size();
	//	System.out.println("numOfRejectionRecords"+numOfRejectionRecords);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	try{
		VehRegNumber=vehicleDao.getVehicleRegistrationNumberForTransporter(transporter);
		numOfVehRecords=VehRegNumber.size();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	try{		
		data = vehicleDao.getDebriefSumbitData(session.getAttribute("usertypevaluemain").toString(),drivername,driverid,limit);
		viewData = debriefSubmitViewDataProvider.getDebriefSubmitViewData(data,drivername,driverid);
		numRecords=viewData.size();
		 System.out.println("numrecords====?"+numRecords);
    }
    catch (Exception e) {
    	e.printStackTrace();
	}
    //System.out.println("step3");
    
    
    
    if(numRecords>0 && !isNull(data.get(0).getBriefId())) {
    	
  //  System.out.println("-------------debrief------------");
    	msg = "Driver has already been briefed";
%>
	<tr>
		<td width="75%">
		<div align="center">
		<table border="5" class="stats">
			<tr>
				<td width="10%"><a href="javascript:history.go(-1);"><img
					src="images/arrow.bmp" width="20px" height="20px" border="0"></a>
				</td>
				<td>
				<div align="center"><font size="2"><B>
				Driver Briefing Report</B> </font></div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<div align="center"><font size="2"> <B>
				<%=msg%></B></font></div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<div align="center"><font color="blue" size="2"><B><blink>
				<a
					href="debrifsbmt.jsp?driverid=<%=driverid%>&drivername=<%=drivername%>&trans=<%=trans%>&briefid=<%="Briefid"%>">
				Click here to de-brief the form.</a></blink></B> </font></div>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
<%
	}
    else{
    	//System.out.println("else ");
    	
    	//no rejection
    if(numOfRejectionRecords==0){

    	//System.out.println("step4");
%>
	<tr>
		<td width="100%" colspan="2" class="stats">
		<table border="0" width="100%">
			<tr>
				<td width="10%"><a href="javascript:history.go(-1);"> <img
					src="images/arrow.bmp" width="20px" height="20px" border="0">
				</a></td>
				<td width="90%"><font size="3"> <B>
				Driver Briefing Report of <%=drivername%> </B> </font></td>

			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
	   			<style>
					.super {text-decoration: blink; text-align: center}
				</style>
				<span class="super"><font color="red" size="2"><b>New</b></font></span><br></br>
	   			<a href="#" onclick="openFeedback();"><b>Incident Feedback</b></a><br></br>
	   </td>
	</tr>
	<tr>
		<td width="50%">
		<div align="left">
		<table border="1" width="100%" class="stats">
			<tr>
				<!-- <td colspan="2" class="hed"> <B> <%=drivername%> of <%=trans%> </B> <br><a href="#" onclick="javascript:window.open('briefing/trininginfo.jsp?drvName=<%=drivername%>&driverid=<%=driverid%>' );" > click here   </a>to see brief history</td>  -->
				<td colspan="2" class="hed"><B> <%=drivername%> of <%=trans%>
				</B> <br>
				<a href="#"
					onclick="javascript:window.open('brif_driverbrifsum.jsp?drvName=<%=drivername%>&driverid=<%=driverid%>' );">
				click here </a>to see brief history <input type="hidden" name="drvrname"
					class="formElement" value="<%=drivername%>" /></td>
			</tr>
			<tr>
				<td>Driver Id:</td>
				<td><%=driverid%> <input type="hidden" name="drvrid"
					class="formElement" value="<%=driverid%>" readonly />
					<input type="hidden" name="drvrName"
					class="formElement" value="<%=drivernam%>" readonly />
					<input type="hidden" name="drvrTransporter"
					class="formElement" value="<%=trans%>" readonly /></td>
<%
//System.out.println("step5");
%>
			</tr>
			<tr>
				<td>Joined on:</td>
				<td>Training Date:</td>
			</tr>
			<tr>
				<td>Training Details</td>
				<td><a href="briefing/trininginfo.jsp?driverid=<%=driverid%>"
					onclick="popWin = open('briefing/trininginfo.jsp?driverid=<%=driverid%>','myWin','width=500,height=600');popWin.focus();return false">Click
				to View Training Details</a></td>
			</tr>
	<%
//System.out.println("step6");
%>
			<tr>
				<td><b>Trainer Name </b></td>
				<td><b> <%=trainerName%><input type="hidden"
					name="trainerName" value="<%= trainerName %>" maxlength="25"
					readonly /></b> <a href="#"
					onclick="javascript:window.open('brif_trinerbrifsum.jsp?trNm=<%=trainerName%>&pgFrom=brif');">
				click here </a>to see Trainer's brief history</td>
			</tr>
			<%
			//System.out.println("step7");
			try{
			if(numRecords>0){
		if((null!=data.get(0).getModule4() || "null".equalsIgnoreCase(data.get(0).getModule4())) && !(data.get(0).getModule4().equalsIgnoreCase("-")))
		{
%>
			<tr>
				<td>Last Training Date </td>
				<td><b><input type="hidden"
					name="lastTrainingDate" value="<%=data.get(0).getModule4Date()%>" maxlength="25" /></b> <%=data.get(0).getModule4Date()%></td>
			</tr>
			<tr>
				<td>Last Training </td>
				<td><b><input type="hidden"
					name="lastTraining" value="<%=data.get(0).getModule4()%>" maxlength="25" /></b><%=data.get(0).getModule4()%></td>
			</tr>
<%		}else if((null!=data.get(0).getModule3() || "null".equalsIgnoreCase(data.get(0).getModule3())) && !(data.get(0).getModule3().equalsIgnoreCase("-"))){
		%>
		<tr>
			<td>Last Training Date </td>
			<td><b><input type="hidden"
				name="lastTrainingDate" value="<%=data.get(0).getModule3Date()%>" maxlength="25" /></b><%=data.get(0).getModule3Date()%> </td>
		</tr>
		<tr>
			<td>Last Training </td>
			<td><b><input type="hidden"
				name="lastTraining" value="<%=data.get(0).getModule3()%>" maxlength="25" /></b><%=data.get(0).getModule3()%></td>
		</tr>
<%		}else if((null!=data.get(0).getModule2() || "null".equalsIgnoreCase(data.get(0).getModule2())) && !(data.get(0).getModule2().equalsIgnoreCase("-"))){
	%>
	<tr>
		<td>Last Training Date </td>
		<td><b><input type="hidden"
			name="lastTrainingDate" value="<%=data.get(0).getModule2Date()%>" maxlength="25" /></b><%=data.get(0).getModule2Date()%> </td>
	</tr>
	<tr>
		<td>Last Training </td>
		<td><b><input type="hidden"
			name="lastTraining" value="<%=data.get(0).getModule2()%>" maxlength="25" /></b><%=data.get(0).getModule2()%></td>
	</tr>
<%	
	}else if((null!=data.get(0).getModule1() || "null".equalsIgnoreCase(data.get(0).getModule1())) && !(data.get(0).getModule1().equalsIgnoreCase("-"))){
		%>
		<tr>
			<td>Last Training Date </td>
			<td><b><input type="hidden"
				name="lastTrainingDate" value="<%=data.get(0).getModule1Date()%>" maxlength="25" /></b><%=data.get(0).getModule1Date()%> </td>
		</tr>
		<tr>
			<td>Last Training </td>
			<td><b><input type="hidden"
				name="lastTraining" value="<%=data.get(0).getModule1()%>" maxlength="25" /></b><%=data.get(0).getModule1() %></td>
		</tr>
	<%			
	}else if((null!=data.get(0).getBasic() || "null".equalsIgnoreCase(data.get(0).getBasic())) && !(data.get(0).getBasic().equalsIgnoreCase("-"))){
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
		</div>
		</td>
		<td width="50%">
		<table>
			<tr>
				<td>
				<table class="stats" border="0" width="100%">
					
					<tr>
						<td align="center" colspan="5"><font size="2"><b>Driver Run Hours
						</b></font></td>
					</tr>
					
				</table>
				</td>
			</tr>
<%
	//System.out.println("step11");
%>
			<tr>
				<td valign="top"  style="background-color:#FFFFFF">
				<div id="div1"><IFRAME
					src='driverRunHoursChart.jsp?driverid=<%=driverid%>&cnt=1' scrolling=no
					id='banner1' width='800' height='350'
					style='padding-top: 10; padding-left: 10' frameborder='0'></IFRAME>
				</div>
				</td>
				
			</tr>
		</table>
		</td>
	</tr>
	<tr>
	<%
	//System.out.println("step11");
%>
		<td colspan="2">
		<table class="stats">
			<tr>
				<td align="center"><font  size="2"> <B>
				Last 10 Trips</B> </font></td>
			</tr>
			<tr>
				<td>
				<div
					style="margin-center: 178px; height: 200px; background-color: azure; border: 1px solid black; overflow: auto;">
				<table width="100%" class="stats">
					<tr>
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
//System.out.println("step12");	
if(numRecords>0){
	
	DisconnectionCount disconnCount = new DisconnectionCount();
	for(int counter=0; counter<numRecords;counter++)
	{	
		final DebriefSubmitViewData currentRecord = viewData.get(counter);
		final int i= counter + 1;
%>
				<tr>
					<td><%=i%>	
<%
       	if(i == 1){
       		if(isNull(currentRecord.getDriverMobileNumber())){
				driverMobileNumber="-";
			}
			else{
				driverMobileNumber=currentRecord.getDriverMobileNumber();
			}
%>
					<input type="hidden" name="hidLastTripRating" value="<%=currentRecord.getTripRating() %>" /> 
					<input type="hidden" name="hidLastTripId" value="<%=currentRecord.getTripId()%>" />
<%
		}
%>
						</td>
						<td><a href="javascript:toggleDetails(<%=i%>,true);"
							title="Click To See the Reports"> <%=currentRecord.getTripId()%></a>
						<br>
						<div class="popup" id="popup<%=i%>">
						<table border="1" bgcolor="white">
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"onclick="javascript:window.open('ShowCustomReportonTWMap.jsp?tripid=<%=currentRecord.getTripId()%>&vehcode=<%=currentRecord.getVehicleId()%>&data=<%=getTripStartDate(currentRecord.getStartDate())%>&data1=<%=getTripEndDate(currentRecord.getEndDate())%>&ftime1=<%=getTripStartTimeHrs(currentRecord.getStartDate())%>&ftime2=<%=getTripStartTimeMins(currentRecord.getStartDate())%>&ttime1=<%=getTripEndTimeHrs(currentRecord.getEndDate())%>&ttime2=<%=getTripEndTimeMins(currentRecord.getEndDate())%>&vehregno=<%=currentRecord.getVehicleRegistrationNumber()%>&ownername=<%=currentRecord.getOwnerName()%>&startplace=<%=currentRecord.getStartPlace()%>&endplace=<%=currentRecord.getEndPlace()%>&pg=brief' );">Show
								Trip on Map </a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);" 
								onclick="newwindow1('debrifLasrTripChart.jsp?driverid=<%=driverid%>&tripid=<%=currentRecord.getTripId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>&cnt=1');">Driver RunHrs Chart
								</a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brif_customreport.jsp?tripid=<%=currentRecord.getTripId()%>&transporter=<%=currentRecord.getOwnerName()%>&vehicleRegistrationNo=<%=currentRecord.getVehicleRegistrationNumber()%>&vehcode=<%=currentRecord.getVehicleId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>' );">Trip
								detail report </a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brfexceprepot.jsp?tripid=<%=currentRecord.getTripId()%>&vehcode=<%=currentRecord.getVehicleId()%>&startDate=<%=getTripStartDateTime(currentRecord.getStartDate())%>&endDate=<%=getTripStartDateTime(currentRecord.getEndDate())%>' );">Trip
								exception report</a></td>
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
						disconCount = disconnCount.CalulateDrivingHours(currentRecord.getVehicleId(),currentRecord.getStartDate(),currentRecord.getEndDate(),currentRecord.getTripId()); 
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
	%>
	<tr><td align="center" colspan="14"><font  size="3">NO TRIPS</font></td></tr>
	<%
}
%>

				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>



	<tr>
		<td colspan="2">
	<% 
	
	
	%>
		<table class="stats" width="100%" align="center" id="showtab" >
			<tr>
				<td align="center" colspan="3"><b><font size="2"
					>Driver Briefing</font></b></td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Trip Classification </b></div>
				</td>
				<td colspan="2">
				<div align="left">
<%
	if(session.getAttribute("usertypevaluemain").toString().equalsIgnoreCase("Castrol")) {
%>
	<input type="radio" name="tripClass" value="Castrol Trip"
					id="Trip" CHECKED onClick="HideandShow(0);">Castrol Trip
				&nbsp;&nbsp; <input type="radio" name="tripClass"
					value="Non Castrol Trip" id="NonTrip" onClick="HideandShow(1);">
				Non Castrol Trip &nbsp;&nbsp;&nbsp;&nbsp; 
<%
	} else if(session.getAttribute("usertypevaluemain").toString().equalsIgnoreCase("BS")) {
%>  
	<input type="radio" name="tripClass" value="Shell Trip" id="Trip"
					CHECKED onClick="HideandShow(0);">Shell Trip &nbsp;&nbsp; <input
					type="radio" name="tripClass" value="Non Shell Trip" id="NonTrip"
					onClick="HideandShow(1);"> Non Shell Trip
				&nbsp;&nbsp;&nbsp;&nbsp; 
<%
	} 
%> 
	<b><label id="trr"> Trip ID : </label> <input type="Text"
					id="tripid" name="tripid" value="" class="formElement"></input> </b></div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Trip Start Place : </b></div>
				</td>
				<td colspan="2">
				<div align="left"><select name="startplace" id="startplace"
					class="formElement">
					<option value="Select">Select</option>
<%
	int castrolZonesCount = 0;
	try {
		castrolZonesCount = castrolZones.size();
	} catch(Exception e){
		e.printStackTrace();
	}
	if(castrolZonesCount>0){
	for(int i=0;i<castrolZonesCount;i++){
		final String zoneRecord = castrolZones.get(i);
%>
					<option value="<%=zoneRecord%>"><%=zoneRecord%></option>
<%
   	}
	}
%>
				</select> &nbsp;&nbsp; <a href="#"
					onclick="javascript:window.open('zonentry.jsp');" title="Add new location">Other</a>&nbsp;&nbsp;&nbsp; <!--<a href="zonentry.jsp"><font size="1" color="black">Other</font>  -->
				</div>
				</td>

			</tr>
			<tr>
				<td>
				<div align="left"><b>Trip Destination : </b></div>
				</td>
				<td colspan="2">
				<div align="left"><select name="endplace" id="endplace"
					class="formElement">
					<option value="Select">Select</option>
<%
if(castrolZonesCount>0){
	for(int i=0;i<castrolZonesCount;i++){
		final String zoneRecord = castrolZones.get(i);
%>
					<option value="<%=zoneRecord%>"><%=zoneRecord%></option>
<%
	}
}
%>
				</select> &nbsp;&nbsp; <a href="#"
					onclick="javascript:window.open('zonentry.jsp?inserted=');"
					title="Add new location">Other</a>&nbsp;&nbsp;&nbsp; <!-- <a href="zonentry.jsp"><font size="1" color="black">Other</font> -->
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Probable Trip End Date</b></div>
				</td>
				<td colspan="2">
				<div align="left"><input type="text" id="data" name="data"
					value="" size="15" readonly /> <img src="images/calendar.png"
					id="trigger"> <!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
				<script type="text/javascript">
  					Calendar.setup(
    				{
      				inputField  : "data",         // ID of the input field
      				ifFormat    : "%d-%b-%Y",     // the date format
      				button      : "trigger"       // ID of the button
    				}
  					);
					</script></div>
				</td>

			</tr>
			<tr>
				<td>
				<div align="left"><b> Transporter</b></div>
				</td>
				<td colspan="2">
					<div align="left"><input type="text" id="transporter" name="transporter"
							value="<%=trans %>" size="15"  readonly/> 
						</div>
				</td>
			</tr>
			
			<tr>
				<td>
				<div align="left"><b>Vehicle Registration Number</b></div>
				</td>
				<td colspan="2">
					<div align="left"><select name="VehRegNo" id="VehRegNo" onchange="getPeripheral(this)">
     	      						<option value="Select" id="VehRegNo">Select</option>
     	      						<%
     	      						if(numOfVehRecords>0){
		try{
				for (final VehicleRegistrationNumberForTransporter vehRegNo : VehRegNumber) 
				{
%>	
     	      						<option value="<%=vehRegNo.getVehicleRegistrationNumber()%>,<%=vehRegNo.getPeripheral() %>"> <%=vehRegNo.getVehicleRegistrationNumber()%> </option>
				<%
				}
				}catch(Exception e){
					e.printStackTrace();
				}
     	      						}
%>
						</select>		
						</div>
						
                        
				</td>
			</tr>
		    <tr>
		    <td></td>
		    <td colspan="2">
		    
		    <div id="customdetailreport" style="display:none"><a href="#" onclick="popitup()">Click here to view custom detail report for this vehicle</a></div>
						<div id="jrmDevice" style="display:none"><label>Device:JRM</label></div>
                        <div id="vehroute"></div>
		    </td>
		    
		    </tr>
			<tr>
				<td>
				<div align="left"><b> Pre Induction and Maintainance check
				(PIMC) Ok</b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="pimc" value="Yes"
					CHECKED /> Yes &nbsp;&nbsp; <input type="radio" name="pimc"
					value="No" /> No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=PIMC');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b>Mode Of Briefing</b></div>
				</td>
				<td colspan="2">
				<div align="left"><input type="radio" name="mode"
					value="Personal" CHECKED /> Personal &nbsp;&nbsp; <input
					type="radio" name="mode" value="Video" /> Video &nbsp;&nbsp; <input
					type="radio" name="mode" value="Audio" /> Audio</div>
				</td>

			</tr>
			<tr>
				<td class="hed">
				<div align="left">GPS Captured Data</div>
				</td>
				<td>
				<div align="left"><input type="radio" name="Gpsdata"
					value="Yes" onClick="displayRow1(0); showper(1);" CHECKED /> Yes
				&nbsp;&nbsp; <input type="radio" name="Gpsdata" value="No"
					onClick="displayRow1(1); showper(0);" /> No</div>
				</td>
				<td>
				<div id="captgps" style="display: ''"><select name="percGPS"
					class="formElement">
					<option value="Select">Select</option>
<%
	for(int p = 100; p>=0; p-=5){
%>
					<option id="gpsPercnt" value="<%=p%>"><%=p%></option>
<%
	}
%>
				</select>Please select percentage of <br>
				gps data captured.</div>
				</td>
			</tr>
			<tr>
				<td colspan="" class="hed">
				<div align="left"><b>Vehicle fit for next trip</b></div>
				</td>
				<td><div align="left"><input type="radio" name="vehfit" value="Yes"
					onClick=""> Yes &nbsp;&nbsp; <input
					type="radio" name="vehfit" value="No" onClick=""
					CHECKED> No</div></td>
				<td>
				<div align="left"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=vehfit&comfrom=brief');return false"
							target="_parent"> Click</a>to add Comment
							</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="gpstable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left"><b>Serviceable </b></div>
						</td>
						<td width="25%"><input type="radio" name="rdServiceable"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdServiceable" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdServiceable');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b> Re-Activated (date)</b></div>
						</td>
						<td><input type="radio" name="rdReActivated" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdReActivated" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdReActivated');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b> Replaced (if yes when) </b></div>
						</td>
						<td><input type="radio" name="rdReplaced" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdReplaced" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdReplaced');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b> Any other observation </b></div>
						</td>
						<td><input type="radio" name="rdOtherObs" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdOtherObs" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdOtherObs');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="hed">
				<div align="left"><b> Vehicle Familiarization</b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="vehfamlarzsn"
					value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
					name="vehfamlarzsn" value="No" /> No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=vehiclefamiliarize1');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td width="50%">
				<div align="left"><b>A] Veh
				-Documents(RC,Insurance,fitness,tax,permit,PUC)</b></div>
				</td>
				<td width="25%">
				<div align="left"><input type="radio" name="rdDocuments"
					value="Yes" onClick="displayRow2(0);" CHECKED /> Yes &nbsp;&nbsp;
				<input type="radio" name="rdDocuments" value="No"
					onClick="displayRow2(1);" /> No</div>
				</td>
				<td width="25%">
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdDocuments');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" align="left" id="documenttable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">Driver License 
						(photocopy/Challan)</div>
						</td>
						<td width="25%"><input type="radio" name="rdlicen"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdlicen" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdlicen');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Veh
						-Documents(RC,Insurance,fitness,tax,permit,PUC)</div>
						</td>
						<td><input type="radio" name="rdtaxpermit" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdtaxpermit" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdtaxpermit');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>

					<tr>
						<td>
						<div align="left">Helper provided</div>
						</td>
						<td><input type="radio" name="rdhelper" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdhelper" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdhelper');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b>B] Vehicle Checklist</b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="vehcheck"
					value="Yes" onClick="displayRow3(1);" /> Yes &nbsp;&nbsp; <input
					type="radio" name="vehcheck" value="No" onClick="displayRow3(0);"
					CHECKED /> No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=vehicl');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="vehicletable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">All lights and signalling
						devices(H.Light,Brake light,Indicators,Parking, Reverse)</div>
						</td>
						<td width="25%"><input type="radio" name="rdsignldevice"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdsignldevice" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdsignldevice');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Instrument panels/switches(speedo,temp,eng
						oil, charging)</div>
						</td>
						<td><input type="radio" name="rdinstrmntpanels" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdinstrmntpanels" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdinstrmntpanels');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">windscreen/mirrors</div>
						</td>
						<td><input type="radio" name="rdwidescreenmirror" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdwidescreenmirror" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdwidescreenmirror');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Tyre pressure- Less pressure,ii)wornout,
						iii)Cut/cracks,iv)bulged out</div>
						</td>
						<td><input type="radio" name="rdtyrepress" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdtyrepress" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdtyrepress');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Brakes functional (spongy/leaking)</div>
						</td>
						<td><input type="radio" name="rdbreaks" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdbreaks" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdbreaks');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Seat belt (tight and secured) Seat belt worn
						out. ii) Mounting not ok, iii) Retractable belt jam iv)Locking
						system not OK</div>
						</td>
						<td><input type="radio" name="rdseatbelt" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdseatbelt" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdseatbelt');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Rear under run protection device (RUPD)</div>
						</td>
						<td><input type="radio" name="rdrupd" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdrupd" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdrupd');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Side under run protection Device (SUPD)</div>
						</td>
						<td><input type="radio" name="rdSUPD" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdSUPD" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdSUPD');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Fire extinguisher (Date expired, Due for
						calibration)</div>
						</td>
						<td><input type="radio" name="rdfire" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdfire" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdfire');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Reflectors/Warning triangle</div>
						</td>
						<td><input type="radio" name="rdreflector" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdreflector" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdreflector');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">First Aid kit</div>
						</td>
						<td><input type="radio" name="rdfirstaid" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdfirstaid" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdfirstaid');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Tool box/Spare wheel with jack and handle</div>
						</td>
						<td><input type="radio" name="rdtoolbox" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdtoolbox" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdtoolbox');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Overall Condition of the vehicle for the
						road worthiness for the coming trip )</div>
						</td>
						<td><input type="radio" name="rdcondveh" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdcondveh" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdcondveh');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="50%">
				<div align="left"><b>C] Route Familiarization </b></div>
				</td>
				<td width="25%">
				<div align="left"><input type="radio" name="rdrootfam"
					value="Yes" onClick="displayRow4(1);" /> Yes &nbsp;&nbsp; <input
					type="radio" name="rdrootfam" value="No" onClick="displayRow4(0);"
					CHECKED /> No</div>
				</td>
				<td width="25%">
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdrootfam');return false"
					target="_parent"> Click</a>to add Comment</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="routetable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">Have you driven in the same route earlier?
						</div>
						</td>
						<td width="25%">
						<div align="left"><input type="radio" name="rdearlierdriven"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdearlierdriven" value="No" /> No</div>
						</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdearlierdriven');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left">Scheduled stops -planned (where? when ?
						after how many KMS)</div>
						</td>
						<td width="25%"><input type="radio" name="rdstopsched"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdstopsched" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdstopsched');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="50%">
				<div align="left"><b>D] Mental / Physical Condition</b></div>
				</td>
				<td width="25%">
				<div align="left"><input type="radio" name="rdmental"
					value="Yes" onClick="displayRow5(0);" CHECKED /> Yes &nbsp;&nbsp;
				<input type="radio" name="rdmental" value="No"
					onClick="displayRow5(1);" /> No</div>
				</td>
				<td width="25%">
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdmental');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="mentaltable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">General appearance , any
						weakness/drowsiness</div>
						</td>
						<td width="25%"><input type="radio" name="rdgenapearance"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="rdgenapearance" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdgenapearance');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left">Any visible Injury</div>
						</td>
						<td align="left"><input type="radio" name="rdvisibleinjury"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdvisibleinjury" value="No" /> No</td>
						<td align="left"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdvisibleinjury');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Find repeatedly stretching / yawning ?</div>
						</td>
						<td><input type="radio" name="rdrepetstrech" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdrepetstrech" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdrepetstrech');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Any medication /Drugs ?</div>
						</td>
						<td><input type="radio" name="rddrug" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rddrug" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rddrug');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">I) Mentally Not able to respond ii) Having
						domestic problem, ,iii) Physical injury found</div>
						</td>
						<td><input type="radio" name="rdmentalprob" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdmentalprob" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdmentalprob');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Adequate sleep before the journey
						commenced?( 4+ hrs,6+hrs,8+hrs)If less than six advise rest.</div>
						</td>
						<td><input type="radio" name="rdadequetsleep" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdadequetsleep" value="No" /> No</td>
						<td align="left"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdadequetsleep');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Any other observation</div>
						</td>
						<td><input type="radio" name="rdotherobser" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdotherobser" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdotherobser');return false"
							target="_parent"> Click</a>to add Comment</td>
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
						 String sql11="select JRM from t_transporter where TypeValue='"+transporterName+"' ";
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
						<div align="left"><b>JRM- Briefed</b><a href="javascript:flase" onclick="javascript:window.open('JRMRoute.jsp');"> (Click to view JRM All Routes Map)</a></div>
						</td>
					
					
                         <td>
						
						<div align="left"><input type="radio" name="rdjrmbrief"
							value="Yes" onClick="displayRow6(1);" /> Yes &nbsp;&nbsp; <input
							type="radio" name="rdjrmbrief" value="No"
							onClick="displayRow6(0);" CHECKED /> No</div>
						</td>
						
						
						<td>
						<div align="left"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdjrmbrief');return false"
							target="_parent"> Click</a>to add Comment</div>
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
						<div align="left"><b><font size="2" color="red"> JRM Briefing/Debriefing is not allowed for <%=transporterName %></font></b> </div>
						</td>
						
						<td></td>
						<% 
						}
						
                          %>			
                          
                          
					
					
					
					
					
					
					
					
					</tr>
				</table>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="jrmtable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">understanding of ,High risk, medium risk
						and low risk, routes</div>
						</td>
						<td width="25%"><input type="radio" name="rdriskunder"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdriskunder" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdriskunder');return false"
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
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=JRMinstalled');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> Route uploaded?</b></div>
						</td>
						<td width="25%"><input type="radio" name="routeUpload"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="routeUpload" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=routeUpload');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Driver Response </b></div>
				</td>
				<td colspan="2">
				<div align="left"><textarea name="drvresp" rows="4" cols="50"
					class="formElement" /> </textarea></div>
				</td>
			</tr>

			<tr>
				<td>
				<div align="left"><b> Driver Mobile No.</b></div>
				</td>
				<td colspan="1" align="left"><!-- <input type="radio" name="mobno" value="Yes"
					CHECKED onClick="HideandShow1(0);">Yes &nbsp;&nbsp; <input
					type="radio" name="mobno" value="No" onClick="HideandShow1(1);">
				No --><input type="text" name="drvMobNo" id="drvMobNo"
					value="<%=driverMobileNumber%>" maxlength="10" /> * (10 digit) <font color="Red"><b>Mandatory</b></font></td>
					<td></td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Other Observation </b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="rdAllOthrObs"
					value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
					name="rdAllOthrObs" value="No" /> No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdAllOthrObs');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Remarks /special instructions </b></div>
				</td>

				<td>
				<div align="left"><input type="radio" name="Rem" value="Yes" />
				Yes &nbsp;&nbsp; <input type="radio" name="Rem" value="No" CHECKED />
				No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=briefingremark&comfrom=brief');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b>Reason of rejection</b></div>
				</td>
				<td>
					<div align="left"><select name="reason" id="reason" class="formElement" onchange="functoggle(this)">
	             		<option>None</option>
		                <option>Driver Rejection</option>
		                <option>Vehicle Rejection</option>
		                <option>Driver and Vehicle Rejection</option>
		                <option>Other</option>
             		</select>
             		</div>
				</td>
				
				<td><div id="rsn" style="display: none"><label for="reasonlabel">Reason :</label></div>&nbsp;&nbsp;&nbsp;&nbsp;<!--<input type="text" name="commentForReason" class="formElement" />-->
				<textarea id="cmntreason" name="commentForReason" rows="4" cols="50"
					class="formElement" style="display: none"/> </textarea></td>
				
			</tr>
			<tr>
				<td>
				<div align="left"><b> Permission Granted </b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="rdPermission"
					value="Yes" onClick="HideandShow2(0);" /> Yes &nbsp;&nbsp; <input
					type="radio" name="rdPermission" value="No"
					onClick="HideandShow2(1);" CHECKED /> No</div>
				</td>
				<td>
				<div align="left">
				<table id="permition" border="0">
					<tr>
						<td><b> By Person &nbsp;&nbsp;&nbsp;&nbsp; <input
							type="text" name="othperson" class="formElement" /></b></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			
			<tr>
				<td>
				<div align="left"><b>Feed Back For Transporter</b></div>
				</td>
				<td colspan="2">
				<div align="left"><textarea name="feedback" rows="4" cols="50"
					class="formElement" /> </textarea></div>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="center"><input type="submit"
					name="submit" value="Submit" class="formElement" /></td>
			</tr>
		</table>
		</td>
		</tr>
		<%
			//--------------------------------------------------------------
    }
    	
    else if(numOfRejectionRecords>0) 
		{	// if rejection closed
		if(null==reason.get(0).getStatus()||"null".equalsIgnoreCase(reason.get(0).getStatus())||reason.get(0).getStatus().equalsIgnoreCase("No"))
		{
    	//System.out.println("step4");
%>
	<tr>
		<td width="100%" colspan="2">
		<table border="0" width="100%">
			<tr>
				<td width="10%"><a href="javascript:history.go(-1);"> <img
					src="images/arrow.bmp" width="20px" height="20px" border="0">
				</a></td>
				<td width="90%"><font  size="3"> <B>
				Driver Briefing Report of <%=drivername%> </B> </font></td>
                 </tr>
                 
		</table>
		</td>
	</tr>
	<tr>
		<td width="50%">
		<div align="left">
		<table border="1" width="100%" class="stats">
			<tr>
				<!-- <td colspan="2" class="hed"> <B> <%=drivername%> of <%=trans%> </B> <br><a href="#" onclick="javascript:window.open('briefing/trininginfo.jsp?drvName=<%=drivername%>&driverid=<%=driverid%>' );" > click here   </a>to see brief history</td>  -->
				<td colspan="2" class="hed"><B> <%=drivername%> of <%=trans%>
				</B> <br>
				<a href="#"
					onclick="javascript:window.open('brif_driverbrifsum.jsp?drvName=<%=drivername%>&driverid=<%=driverid%>' );">
				click here </a>to see brief history <input type="hidden" name="drvrname"
					class="formElement" value="<%=drivername%>" /></td>
			</tr>
			<tr>
				<td>Driver Id:</td>
				<td><%=driverid%> <input type="hidden" name="drvrid"
					class="formElement" value="<%=driverid%>" readonly />
					<input type="hidden" name="drvrName"
					class="formElement" value="<%=drivernam%>" readonly />
					<input type="hidden" name="drvrTransporter"
					class="formElement" value="<%=trans%>" readonly /></td>
<%
//System.out.println("step5");
%>
			</tr>
			<tr>
				<td>Joined on:</td>
				<td>Training Date:</td>
			</tr>
			<tr>
				<td>Training Details</td>
				<td><a href="briefing/trininginfo.jsp?driverid=<%=driverid%>"
					onclick="popWin = open('briefing/trininginfo.jsp?driverid=<%=driverid%>','myWin','width=500,height=600');popWin.focus();return false">Click
				to View Training Details</a></td>
			</tr>
	<%
//System.out.println("step6");
%>
			<tr>
				<td><b>Trainer Name </b></td>
				<td><b> <%=trainerName%><input type="hidden"
					name="trainerName" value="<%= trainerName %>" maxlength="25"
					readonly /></b> <a href="#"
					onclick="javascript:window.open('brif_trinerbrifsum.jsp?trNm=<%=trainerName%>&pgFrom=brif');">
				click here </a>to see Trainer's brief history</td>
			</tr>
			<%
		//	System.out.println("step7");
			try{
			if(numRecords>0){
		if((null!=data.get(0).getModule4() || "null".equalsIgnoreCase(data.get(0).getModule4())) && !(data.get(0).getModule4().equalsIgnoreCase("-")))
		{
%>
			<tr>
				<td>Last Training Date </td>
				<td><b><input type="hidden"
					name="lastTrainingDate" value="<%=data.get(0).getModule4Date()%>" maxlength="25" /></b> <%=data.get(0).getModule4Date()%></td>
			</tr>
			<tr>
				<td>Last Training </td>
				<td><b><input type="hidden"
					name="lastTraining" value="<%=data.get(0).getModule4()%>" maxlength="25" /></b><%=data.get(0).getModule4()%></td>
			</tr>
<%		}else if((null!=data.get(0).getModule3() || "null".equalsIgnoreCase(data.get(0).getModule3())) && !(data.get(0).getModule3().equalsIgnoreCase("-"))){
		%>
		<tr>
			<td>Last Training Date </td>
			<td><b><input type="hidden"
				name="lastTrainingDate" value="<%=data.get(0).getModule3Date()%>" maxlength="25" /></b><%=data.get(0).getModule3Date()%> </td>
		</tr>
		<tr>
			<td>Last Training </td>
			<td><b><input type="hidden"
				name="lastTraining" value="<%=data.get(0).getModule3()%>" maxlength="25" /></b><%=data.get(0).getModule3()%></td>
		</tr>
<%		}else if((null!=data.get(0).getModule2() || "null".equalsIgnoreCase(data.get(0).getModule2())) && !(data.get(0).getModule2().equalsIgnoreCase("-"))){
	%>
	<tr>
		<td>Last Training Date </td>
		<td><b><input type="hidden"
			name="lastTrainingDate" value="<%=data.get(0).getModule2Date()%>" maxlength="25" /></b><%=data.get(0).getModule2Date()%> </td>
	</tr>
	<tr>
		<td>Last Training </td>
		<td><b><input type="hidden"
			name="lastTraining" value="<%=data.get(0).getModule2()%>" maxlength="25" /></b><%=data.get(0).getModule2()%></td>
	</tr>
<%	
	}else if((null!=data.get(0).getModule1() || "null".equalsIgnoreCase(data.get(0).getModule1())) && !(data.get(0).getModule1().equalsIgnoreCase("-"))){
		%>
		<tr>
			<td>Last Training Date </td>
			<td><b><input type="hidden"
				name="lastTrainingDate" value="<%=data.get(0).getModule1Date()%>" maxlength="25" /></b><%=data.get(0).getModule1Date()%> </td>
		</tr>
		<tr>
			<td>Last Training </td>
			<td><b><input type="hidden"
				name="lastTraining" value="<%=data.get(0).getModule1()%>" maxlength="25" /></b><%=data.get(0).getModule1() %></td>
		</tr>
	<%			
	}else if((null!=data.get(0).getBasic() || "null".equalsIgnoreCase(data.get(0).getBasic())) && !(data.get(0).getBasic().equalsIgnoreCase("-"))){
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
		</div>
		</td>
		<td width="50%">
		<table>
			<tr>
				<td>
				<table class="stats" border="0" width="100%">
					
					<tr>
						<td align="center" colspan="4"><font size="2" ><b>Driver Run Hours
						</b></font></td>
					</tr>
				
				</table>
				</td>
			</tr>
<%
	//System.out.println("step11");
%>
			<tr>
				<td valign="top" style="background-color:#FFFFFF">
				<div id="div1"><IFRAME
					src='driverRunHoursChart.jsp?driverid=<%=driverid%>&cnt=1' scrolling=no
					id='banner1' width='800' height='350'
					style='padding-top: 10; padding-left: 10' frameborder='0'></IFRAME>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
	<%
	//System.out.println("step11");
%>
		<td colspan="2">
		<table class="stats">
			<tr>
				<td align="center"><font  size="2"> <B>
				Last 10 Trips</B> </font></td>
			</tr>
			<tr>
				<td>
				<div
					style="margin-center: 178px; height: 200px; background-color: azure; border: 1px solid black; overflow: auto;">
				<table width="100%" class="stats">
					<tr>
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
//System.out.println("step12");	
if(numRecords>0){

	DisconnectionCount disconnCount = new DisconnectionCount();
	for(int counter=0; counter<numRecords;counter++)
	{	
		final DebriefSubmitViewData currentRecord = viewData.get(counter);
		final int i= counter + 1;
%>
				<tr>
					<td><%=i%>	
<%
       	if(i == 1){
       		if(isNull(currentRecord.getDriverMobileNumber())){
				driverMobileNumber="-";
			}
			else{
				driverMobileNumber=currentRecord.getDriverMobileNumber();
			}
%>
					<input type="hidden" name="hidLastTripRating" value="<%=currentRecord.getTripRating() %>" /> 
					<input type="hidden" name="hidLastTripId" value="<%=currentRecord.getTripId()%>" />
<%
		}
%>
						</td>
						<td><a href="javascript:toggleDetails(<%=i%>,true);"
							title="Click To See the Reports"> <%=currentRecord.getTripId()%></a>
						<br>
						<div class="popup" id="popup<%=i%>">
						<table border="1"  bgcolor="#9db5e5" cellpadding="1px" cellspacing="1px">
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"onclick="javascript:window.open('ShowCustomReportonTWMap.jsp?tripid=<%=currentRecord.getTripId()%>&vehcode=<%=currentRecord.getVehicleId()%>&data=<%=getTripStartDate(currentRecord.getStartDate())%>&data1=<%=getTripEndDate(currentRecord.getEndDate())%>&ftime1=<%=getTripStartTimeHrs(currentRecord.getStartDate())%>&ftime2=<%=getTripStartTimeMins(currentRecord.getStartDate())%>&ttime1=<%=getTripEndTimeHrs(currentRecord.getEndDate())%>&ttime2=<%=getTripEndTimeMins(currentRecord.getEndDate())%>&vehregno=<%=currentRecord.getVehicleRegistrationNumber()%>&ownername=<%=currentRecord.getOwnerName()%>&startplace=<%=currentRecord.getStartPlace()%>&endplace=<%=currentRecord.getEndPlace()%>&pg=brief' );">Show
								Trip on Map </a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);" 
								onclick="newwindow1('debrifLasrTripChart.jsp?driverid=<%=driverid%>&tripid=<%=currentRecord.getTripId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>&cnt=1');">Driver RunHrs Chart
								</a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brif_customreport.jsp?tripid=<%=currentRecord.getTripId()%>&transporter=<%=currentRecord.getOwnerName()%>&vehicleRegistrationNo=<%=currentRecord.getVehicleRegistrationNumber()%>&vehcode=<%=currentRecord.getVehicleId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>' );">Trip
								detail report </a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brfexceprepot.jsp?tripid=<%=currentRecord.getTripId()%>&vehcode=<%=currentRecord.getVehicleId()%>&startDate=<%=getTripStartDateTime(currentRecord.getStartDate())%>&endDate=<%=getTripStartDateTime(currentRecord.getEndDate())%>' );">Trip
								exception report</a></td>
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
						disconCount = disconnCount.CalulateDrivingHours(currentRecord.getVehicleId(),currentRecord.getStartDate(),currentRecord.getEndDate(),currentRecord.getTripId()); 
						if(disconCount>0)
						{
							%>
							<td style="text-align: right"><a href="#" onclick="javascript:window.open('disconnectionFeedBack.jsp?ownername=<%=currentRecord.getOwnerName()%>&vehicleCode=<%=currentRecord.getVehicleId()%>&tripid=<%=currentRecord.getTripId()%>&fromDateTime=<%=currentRecord.getStartDate()%>&toDateTime=<%=currentRecord.getEndDate()%>','','top=200,left=200,width=800,height=400,resizable=1,scrollbars=1');"><%=disconCount%></a></td>
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
%>
		<tr><td align="center" colspan="14"><font  size="3">NO TRIPS</font></td></tr>
<%
}
%>

				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>



	<tr>
		<td colspan="2">
	<% 
	
	
	%>
		<table class="stats" width="100%" align="center" id="showtab">
			<tr>
				<td align="center" colspan="3"><b><font size="2"
					>Driver Briefing</font></b></td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Trip Classification </b></div>
				</td>
				<td colspan="2">
				<div align="left">
<%
	if(session.getAttribute("usertypevaluemain").toString().equalsIgnoreCase("Castrol")) {
%>
	<input type="radio" name="tripClass" value="Castrol Trip"
					id="Trip" CHECKED onClick="HideandShow(0);">Castrol Trip
				&nbsp;&nbsp; <input type="radio" name="tripClass"
					value="Non Castrol Trip" id="NonTrip" onClick="HideandShow(1);">
				Non Castrol Trip &nbsp;&nbsp;&nbsp;&nbsp; 
<%
	} else if(session.getAttribute("usertypevaluemain").toString().equalsIgnoreCase("BS")) {
%>  
	<input type="radio" name="tripClass" value="Shell Trip" id="Trip"
					CHECKED onClick="HideandShow(0);">Shell Trip &nbsp;&nbsp; <input
					type="radio" name="tripClass" value="Non Shell Trip" id="NonTrip"
					onClick="HideandShow(1);"> Non Shell Trip
				&nbsp;&nbsp;&nbsp;&nbsp; 
<%
	} 
%> 
	<b><label id="trr"> Trip ID : </label> <input type="Text"
					id="tripid" name="tripid" value="" class="formElement"></input> </b></div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Trip Start Place : </b></div>
				</td>
				<td colspan="2">
				<div align="left"><select name="startplace" id="startplace"
					class="formElement">
					<option value="Select">Select</option>
<%
	int castrolZonesCount = 0;
	try {
		castrolZonesCount = castrolZones.size();
	} catch(Exception e){
		e.printStackTrace();
	}
	if(castrolZonesCount>0){
	for(int i=0;i<castrolZonesCount;i++){
		final String zoneRecord = castrolZones.get(i);
%>
					<option value="<%=zoneRecord%>"><%=zoneRecord%></option>
<%
   	}
	}
%>
				</select> &nbsp;&nbsp; <a href="#"
					onclick="javascript:window.open('zonentry.jsp');" title="Add new location">Other</a>&nbsp;&nbsp;&nbsp; <!--<a href="zonentry.jsp"><font size="1" color="black">Other</font>  -->
				</div>
				</td>

			</tr>
			<tr>
				<td>
				<div align="left"><b>Trip Destination : </b></div>
				</td>
				<td colspan="2">
				<div align="left"><select name="endplace" id="endplace"
					class="formElement">
					<option value="Select">Select</option>
<%
if(castrolZonesCount>0){
	for(int i=0;i<castrolZonesCount;i++){
		final String zoneRecord = castrolZones.get(i);
%>
					<option value="<%=zoneRecord%>"><%=zoneRecord%></option>
<%
	}
}
%>
				</select> &nbsp;&nbsp; <a href="#"
					onclick="javascript:window.open('zonentry.jsp?inserted=');"
					title="Add new location">Other</a>&nbsp;&nbsp;&nbsp; <!-- <a href="zonentry.jsp"><font size="1" color="black">Other</font> -->
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Probable Trip End Date</b></div>
				</td>
				<td colspan="2">
				<div align="left"><input type="text" id="data" name="data"
					value="" size="15" readonly /> <img src="images/calendar.png"
					id="trigger"> <!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
				<script type="text/javascript">
  					Calendar.setup(
    				{
      				inputField  : "data",         // ID of the input field
      				ifFormat    : "%d-%b-%Y",     // the date format
      				button      : "trigger"       // ID of the button
    				}
  					);
					</script></div>
				</td>

			</tr>
			<tr>
				<td>
				<div align="left"><b> Transporter</b></div>
				</td>
				<td colspan="2">
					<div align="left"><input type="text" id="transporter" name="transporter"
							value="<%=trans %>" size="15"  readonly/> 
						</div>
				</td>
			</tr>
			
			<tr>
				<td>
				<div align="left"><b>Vehicle Registration Number</b></div>
				</td>
				<td colspan="2">
					<div align="left"><select name="VehRegNo" id="VehRegNo" onchange="getPeripheral(this)">
     	      						<option value="Select" id="VehRegNo">Select</option>
     	      						<%
     	      						if(numOfVehRecords>0){
		try{
				for (final VehicleRegistrationNumberForTransporter vehRegNo : VehRegNumber) 
				{
%>	
     	      						<option value="<%=vehRegNo.getVehicleRegistrationNumber()%>,<%=vehRegNo.getPeripheral()%>"> <%=vehRegNo.getVehicleRegistrationNumber()%> </option>
				<%
				}
				}catch(Exception e){
					e.printStackTrace();
				}
     	      						}
%>
				</select>		
				</div>
				<div id="customdetailreport" style="display:none"><a href="#" onclick="popitup()">Click here to view custom detail report for this vehicle</a></div>
			<div id="jrmDevice" style="display:none"><label>Unit Installed is JRM Device</label></div>
				</td>
			</tr>
		
			<tr>
				<td>
				<div align="left"><b> Pre Induction and Maintainance check
				(PIMC) Ok</b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="pimc" value="Yes"
					CHECKED /> Yes &nbsp;&nbsp; <input type="radio" name="pimc"
					value="No" /> No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=PIMC');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b>Mode Of Briefing</b></div>
				</td>
				<td colspan="2">
				<div align="left"><input type="radio" name="mode"
					value="Personal" CHECKED /> Personal &nbsp;&nbsp; <input
					type="radio" name="mode" value="Video" /> Video &nbsp;&nbsp; <input
					type="radio" name="mode" value="Audio" /> Audio</div>
				</td>

			</tr>
			<tr>
				<td class="hed">
				<div align="left">GPS Captured Data</div>
				</td>
				<td>
				<div align="left"><input type="radio" name="Gpsdata"
					value="Yes" onClick="displayRow1(0); showper(1);" CHECKED /> Yes
				&nbsp;&nbsp; <input type="radio" name="Gpsdata" value="No"
					onClick="displayRow1(1); showper(0);" /> No</div>
				</td>
				<td>
				<div id="captgps" style="display: ''"><select name="percGPS"
					class="formElement">
					<option value="Select">Select</option>
<%
	for(int p = 100; p>=0; p-=5){
%>
					<option id="gpsPercnt" value="<%=p%>"><%=p%></option>
<%
	}
%>
				</select>Please select percentage of <br>
				gps data captured.</div>
				</td>
			</tr>
						<tr>
				<td class="hed">
				<div align="left"><b>Vehicle fit for next trip</b></div>
				</td>
				<td><div align="left"><input type="radio" name="vehfit" value="Yes"
					onClick=""> Yes &nbsp;&nbsp; <input
					type="radio" name="vehfit" value="No" onClick=""
					CHECKED> No</div></td>
				<td>
				<div align="left"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=vehfit&comfrom=brief');return false"
							target="_parent"> Click</a>to add Comment
							</div>
				</td>
			</tr>
			
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="gpstable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left"><b>Serviceable </b></div>
						</td>
						<td width="25%"><input type="radio" name="rdServiceable"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdServiceable" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdServiceable');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b> Re-Activated (date)</b></div>
						</td>
						<td><input type="radio" name="rdReActivated" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdReActivated" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdReActivated');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b> Replaced (if yes when) </b></div>
						</td>
						<td><input type="radio" name="rdReplaced" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdReplaced" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdReplaced');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left"><b> Any other observation </b></div>
						</td>
						<td><input type="radio" name="rdOtherObs" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdOtherObs" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdOtherObs');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="hed">
				<div align="left"><b> Vehicle Familiarization</b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="vehfamlarzsn"
					value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
					name="vehfamlarzsn" value="No" /> No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=vehiclefamiliarize1');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td width="50%">
				<div align="left"><b>A] Veh
				-Documents(RC,Insurance,fitness,tax,permit,PUC)</b></div>
				</td>
				<td width="25%">
				<div align="left"><input type="radio" name="rdDocuments"
					value="Yes" onClick="displayRow2(0);" CHECKED /> Yes &nbsp;&nbsp;
				<input type="radio" name="rdDocuments" value="No"
					onClick="displayRow2(1);" /> No</div>
				</td>
				<td width="25%">
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdDocuments');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" align="left" id="documenttable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">Driver License
						(photocopy/Challan)</div>
						</td>
						<td width="25%"><input type="radio" name="rdlicen"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdlicen" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdlicen');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Veh
						-Documents(RC,Insurance,fitness,tax,permit,PUC)</div>
						</td>
						<td><input type="radio" name="rdtaxpermit" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdtaxpermit" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdtaxpermit');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>

					<tr>
						<td>
						<div align="left">Helper provided</div>
						</td>
						<td><input type="radio" name="rdhelper" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdhelper" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdhelper');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b>B] Vehicle Checklist</b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="vehcheck"
					value="Yes" onClick="displayRow3(1);" /> Yes &nbsp;&nbsp; <input
					type="radio" name="vehcheck" value="No" onClick="displayRow3(0);"
					CHECKED /> No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=vehicl');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="vehicletable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">All lights and signalling
						devices(H.Light,Brake light,Indicators,Parking, Reverse)</div>
						</td>
						<td width="25%"><input type="radio" name="rdsignldevice"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdsignldevice" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdsignldevice');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Instrument panels/switches(speedo,temp,eng
						oil, charging)</div>
						</td>
						<td><input type="radio" name="rdinstrmntpanels" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdinstrmntpanels" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdinstrmntpanels');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">windscreen/mirrors</div>
						</td>
						<td><input type="radio" name="rdwidescreenmirror" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdwidescreenmirror" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdwidescreenmirror');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Tyre pressure- Less pressure,ii)wornout,
						iii)Cut/cracks,iv)bulged out</div>
						</td>
						<td><input type="radio" name="rdtyrepress" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdtyrepress" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdtyrepress');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Brakes functional (spongy/leaking)</div>
						</td>
						<td><input type="radio" name="rdbreaks" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdbreaks" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdbreaks');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Seat belt (tight and secured) Seat belt worn
						out. ii) Mounting not ok, iii) Retractable belt jam iv)Locking
						system not OK</div>
						</td>
						<td><input type="radio" name="rdseatbelt" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdseatbelt" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdseatbelt');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Rear under run protection device (RUPD)</div>
						</td>
						<td><input type="radio" name="rdrupd" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdrupd" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdrupd');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Side under run protection Device (SUPD)</div>
						</td>
						<td><input type="radio" name="rdSUPD" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdSUPD" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdSUPD');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Fire extinguisher (Date expired, Due for
						calibration)</div>
						</td>
						<td><input type="radio" name="rdfire" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdfire" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdfire');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Reflectors/Warning triangle</div>
						</td>
						<td><input type="radio" name="rdreflector" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdreflector" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdreflector');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">First Aid kit</div>
						</td>
						<td><input type="radio" name="rdfirstaid" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdfirstaid" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdfirstaid');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Tool box/Spare wheel with jack and handle</div>
						</td>
						<td><input type="radio" name="rdtoolbox" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdtoolbox" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdtoolbox');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Overall Condition of the vehicle for the
						road worthiness for the coming trip )</div>
						</td>
						<td><input type="radio" name="rdcondveh" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rdcondveh" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdcondveh');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="50%">
				<div align="left"><b>C] Route Familiarization </b></div>
				</td>
				<td width="25%">
				<div align="left"><input type="radio" name="rdrootfam"
					value="Yes" onClick="displayRow4(1);" /> Yes &nbsp;&nbsp; <input
					type="radio" name="rdrootfam" value="No" onClick="displayRow4(0);"
					CHECKED /> No</div>
				</td>
				<td width="25%">
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdrootfam');return false"
					target="_parent"> Click</a>to add Comment</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="routetable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">Have you driven in the same route earlier?
						</div>
						</td>
						<td width="25%">
						<div align="left"><input type="radio" name="rdearlierdriven"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdearlierdriven" value="No" /> No</div>
						</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdearlierdriven');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left">Scheduled stops -planned (where? when ?
						after how many KMS)</div>
						</td>
						<td width="25%"><input type="radio" name="rdstopsched"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdstopsched" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdstopsched');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="50%">
				<div align="left"><b>D] Mental / Physical Condition</b></div>
				</td>
				<td width="25%">
				<div align="left"><input type="radio" name="rdmental"
					value="Yes" onClick="displayRow5(0);" CHECKED /> Yes &nbsp;&nbsp;
				<input type="radio" name="rdmental" value="No"
					onClick="displayRow5(1);" /> No</div>
				</td>
				<td width="25%">
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdmental');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="mentaltable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">General appearance , any
						weakness/drowsiness</div>
						</td>
						<td width="25%"><input type="radio" name="rdgenapearance"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="rdgenapearance" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdgenapearance');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left">Any visible Injury</div>
						</td>
						<td align="left"><input type="radio" name="rdvisibleinjury"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdvisibleinjury" value="No" /> No</td>
						<td align="left"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdvisibleinjury');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Find repeatedly stretching / yawning ?</div>
						</td>
						<td><input type="radio" name="rdrepetstrech" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdrepetstrech" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdrepetstrech');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Any medication /Drugs ?</div>
						</td>
						<td><input type="radio" name="rddrug" value="Yes" CHECKED />
						Yes &nbsp;&nbsp; <input type="radio" name="rddrug" value="No" />
						No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rddrug');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">I) Mentally Not able to respond ii) Having
						domestic problem, ,iii) Physical injury found</div>
						</td>
						<td><input type="radio" name="rdmentalprob" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdmentalprob" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdmentalprob');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Adequate sleep before the journey
						commenced?( 4+ hrs,6+hrs,8+hrs)If less than six advise rest.</div>
						</td>
						<td><input type="radio" name="rdadequetsleep" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdadequetsleep" value="No" /> No</td>
						<td align="left"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdadequetsleep');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
					<tr>
						<td>
						<div align="left">Any other observation</div>
						</td>
						<td><input type="radio" name="rdotherobser" value="Yes"
							CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdotherobser" value="No" /> No</td>
						<td><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdotherobser');return false"
							target="_parent"> Click</a>to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>










			<tr>
			
			
			
			
			
						 <%
						 String jrm = "";
						 String sql11="select JRM from t_transporter where TypeValue='"+transporterName+"' ";
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
				<td width="100%" colspan="3">
				<table id="jrmtable1" width="100%" class="stats" style="display: ''">
					<tr>
						<td colspan="" class="hed" width="50%">
						<div align="left"><b>JRM- Briefed</b><a href="javascript:flase" onclick="javascript:window.open('JRMRoute.jsp');"> (Click to view JRM All Routes Map)</a></div>
						</td>
						<td>
						<div align="left"><input type="radio" name="rdjrmbrief"
							value="Yes" onClick="displayRow6(1);" /> Yes &nbsp;&nbsp; <input
							type="radio" name="rdjrmbrief" value="No"
							onClick="displayRow6(0);" CHECKED /> No</div>
						</td>
						<td>
						<div align="left"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdjrmbrief');return false"
							target="_parent"> Click</a>to add Comment</div>
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
						<div align="left"><b><font size="2" color="red"> JRM Briefing/Debriefing is not allowed for <%=transporterName %></font></b> </div>
						</td>
						
						<td></td>
						<% 
						}
						
                          %>			
                          
						
						
						
						
						
						
					</tr>
				</table>
			</tr>
		
			<tr>
				<td colspan="3">
				<table width="100%" class="stats" id="jrmtable"
					style="display: none">
					<tr>
						<td width="50%">
						<div align="left">understanding of ,High risk, medium risk
						and low risk, routes</div>
						</td>
						<td width="25%"><input type="radio" name="rdriskunder"
							value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
							name="rdriskunder" value="No" /> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdriskunder');return false"
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
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=JRMinstalled');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
					<tr>
						<td width="50%">
						<div align="left"><b> Route uploaded?</b></div>
						</td>
						<td width="25%"><input type="radio" name="routeUpload"
							value="Yes" CHECKED> Yes &nbsp;&nbsp; <input type="radio"
							name="routeUpload" value="No"> No</td>
						<td width="25%"><a href=""
							onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=routeUpload');return false"
							target="_parent"> Click</a> to add Comment</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Driver Response </b></div>
				</td>
				<td colspan="2">
				<div align="left"><textarea name="drvresp" rows="4" cols="50"
					class="formElement" /> </textarea></div>
				</td>
			</tr>

			<tr>
				<td>
				<div align="left"><b> Driver Mobile No.</b></div>
				</td>
				<td colspan="1"><!-- <input type="radio" name="mobno" value="Yes"
					CHECKED onClick="HideandShow1(0);">Yes &nbsp;&nbsp; <input
					type="radio" name="mobno" value="No" onClick="HideandShow1(1);">
				No--> <input type="text" name="drvMobNo" id="drvMobNo"
					value="<%=driverMobileNumber%>" maxlength="10" /> * (10 digit) <font color="Red"><b>Mandatory</b></font></td>
					<td></td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Other Observation </b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="rdAllOthrObs"
					value="Yes" CHECKED /> Yes &nbsp;&nbsp; <input type="radio"
					name="rdAllOthrObs" value="No" /> No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rdAllOthrObs');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b> Remarks /special instructions </b></div>
				</td>

				<td>
				<div align="left"><input type="radio" name="Rem" value="Yes" />
				Yes &nbsp;&nbsp; <input type="radio" name="Rem" value="No" CHECKED />
				No</div>
				</td>
				<td>
				<div align="left"><a href=""
					onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=briefingremark&comfrom=brief');return false"
					target="_parent"> Click</a> to add Comment</div>
				</td>
			</tr>
			<tr>
				<td>
				<div align="left"><b>Reason of rejection</b></div>
				</td>
				<td>
					<div align="left"><select name="reason" id="reason" class="formElement" onchange="functoggle(this)">
	             		<option>None</option>
		                <option>Driver Rejection</option>
		                <option>Vehicle Rejection</option>
		                <option>Driver and Vehicle Rejection</option>
		                <option>Other</option>
             		</select>
             		</div>
				</td>
				
				<td><div id="rsn" style="display: none"><label for="reasonlabel">Reason :</label></div>&nbsp;&nbsp;&nbsp;&nbsp;<!--<input type="text" name="commentForReason" class="formElement" />-->
				<textarea id="cmntreason" name="commentForReason" rows="4" cols="50"
					class="formElement" style="display: none"/> </textarea></td>
				
			</tr>
			<tr>
				<td>
				<div align="left"><b> Permission Granted </b></div>
				</td>
				<td>
				<div align="left"><input type="radio" name="rdPermission"
					value="Yes" onClick="HideandShow2(0);" /> Yes &nbsp;&nbsp; <input
					type="radio" name="rdPermission" value="No"
					onClick="HideandShow2(1);" CHECKED /> No</div>
				</td>
				<td>
				<div align="left">
				<table id="permition" border="0">
					<tr>
						<td><b> By Person &nbsp;&nbsp;&nbsp;&nbsp; <input
							type="text" name="othperson" class="formElement" /></b></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			
			<tr>
				<td>
				<div align="left"><b>Feed Back For Transporter</b></div>
				</td>
				<td colspan="2">
				<div align="left"><textarea name="feedback" rows="4" cols="50"
					class="formElement" /> </textarea></div>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="center"><input type="submit"
					name="submit" value="Submit" class="formElement" /></td>
			</tr>
		</table>
		</td>
		</tr>
		<%
			}
		//rejected
			else if(reason.get(0).getStatus().equalsIgnoreCase("yes")){
			//System.out.println("next elsedfgdfghfhg");%>
			
			<tr>
		<td width="100%" colspan="2">
		<table border="0" width="100%">
			<tr>
				<td width="10%"><a href="javascript:history.go(-1);"> <img
					src="images/arrow.bmp" width="20px" height="20px" border="0">
				</a></td>
				<td width="90%"><font  size="3"> <B>
				Driver Briefing Report of <%=drivername%> </B> </font></td>
                 
                 <td align="left">
                 <style>
.                 super {text-decoration: blink; text-align: center}
                </style>
                <span class="super"><font color="red">New</font></span>
               
                 </td>
                
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td width="50%">
		<div align="left">
		<table border="1" width="100%" class="stats">
			<tr>
				<!-- <td colspan="2" class="hed"> <B> <%=drivername%> of <%=trans%> </B> <br><a href="#" onclick="javascript:window.open('briefing/trininginfo.jsp?drvName=<%=drivername%>&driverid=<%=driverid%>' );" > click here   </a>to see brief history</td>  -->
				<td colspan="2" class="hed"><B> <%=drivername%> of <%=trans%>
				</B> <br>
				<a href="#"
					onclick="javascript:window.open('brif_driverbrifsum.jsp?drvName=<%=drivername%>&driverid=<%=driverid%>' );">
				click here </a>to see brief history <input type="hidden" name="drvrname"
					class="formElement" value="<%=drivername%>" /></td>
			</tr>
			<tr>
				<td>Driver Id:</td>
				<td><%=driverid%> <input type="hidden" name="drvrid"
					class="formElement" value="<%=driverid%>" readonly />
					<input type="hidden" name="drvrName"
					class="formElement" value="<%=drivernam%>" readonly />
					<input type="hidden" name="drvrTransporter"
					class="formElement" value="<%=trans%>" readonly /></td>
<%
//System.out.println("step5");
%>
			</tr>
			<tr>
				<td>Joined on:</td>
				<td>Training Date:</td>
			</tr>
			<tr>
				<td>Training Details</td>
				<td><a href="briefing/trininginfo.jsp?driverid=<%=driverid%>"
					onclick="popWin = open('briefing/trininginfo.jsp?driverid=<%=driverid%>','myWin','width=500,height=600');popWin.focus();return false">Click
				to View Training Details</a></td>
			</tr>
	<%
	//System.out.println("step6");
%>
			<tr>
				<td><b>Trainer Name </b></td>
				<td><b> <%=trainerName%><input type="hidden"
					name="trainerName" value="<%= trainerName %>" maxlength="25"
					readonly /></b> <a href="#"
					onclick="javascript:window.open('brif_trinerbrifsum.jsp?trNm=<%=trainerName%>&pgFrom=brif');">
				click here </a>to see Trainer's brief history</td>
			</tr>
			<%
			//System.out.println("step7");
			try{
			if(numRecords>0){
		if((null!=data.get(0).getModule4() || "null".equalsIgnoreCase(data.get(0).getModule4())) && !(data.get(0).getModule4().equalsIgnoreCase("-")))
		{
%>
			<tr>
				<td>Last Training Date </td>
				<td><b><input type="hidden"
					name="lastTrainingDate" value="<%=data.get(0).getModule4Date()%>" maxlength="25" /></b> <%=data.get(0).getModule4Date()%></td>
			</tr>
			<tr>
				<td>Last Training </td>
				<td><b><input type="hidden"
					name="lastTraining" value="<%=data.get(0).getModule4()%>" maxlength="25" /></b><%=data.get(0).getModule4()%></td>
			</tr>
<%		}else if((null!=data.get(0).getModule3() || "null".equalsIgnoreCase(data.get(0).getModule3())) && !(data.get(0).getModule3().equalsIgnoreCase("-"))){
		%>
		<tr>
			<td>Last Training Date </td>
			<td><b><input type="hidden"
				name="lastTrainingDate" value="<%=data.get(0).getModule3Date()%>" maxlength="25" /></b><%=data.get(0).getModule3Date()%> </td>
		</tr>
		<tr>
			<td>Last Training </td>
			<td><b><input type="hidden"
				name="lastTraining" value="<%=data.get(0).getModule3()%>" maxlength="25" /></b><%=data.get(0).getModule3()%></td>
		</tr>
<%		}else if((null!=data.get(0).getModule2() || "null".equalsIgnoreCase(data.get(0).getModule2())) && !(data.get(0).getModule2().equalsIgnoreCase("-"))){
	%>
	<tr>
		<td>Last Training Date </td>
		<td><b><input type="hidden"
			name="lastTrainingDate" value="<%=data.get(0).getModule2Date()%>" maxlength="25" /></b><%=data.get(0).getModule2Date()%> </td>
	</tr>
	<tr>
		<td>Last Training </td>
		<td><b><input type="hidden"
			name="lastTraining" value="<%=data.get(0).getModule2()%>" maxlength="25" /></b><%=data.get(0).getModule2()%></td>
	</tr>
<%	
	}else if((null!=data.get(0).getModule1() || "null".equalsIgnoreCase(data.get(0).getModule1())) && !(data.get(0).getModule1().equalsIgnoreCase("-"))){
		%>
		<tr>
			<td>Last Training Date </td>
			<td><b><input type="hidden"
				name="lastTrainingDate" value="<%=data.get(0).getModule1Date()%>" maxlength="25" /></b><%=data.get(0).getModule1Date()%> </td>
		</tr>
		<tr>
			<td>Last Training </td>
			<td><b><input type="hidden"
				name="lastTraining" value="<%=data.get(0).getModule1()%>" maxlength="25" /></b><%=data.get(0).getModule1() %></td>
		</tr>
	<%			
	}else if((null!=data.get(0).getBasic() || "null".equalsIgnoreCase(data.get(0).getBasic())) && !(data.get(0).getBasic().equalsIgnoreCase("-"))){
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
		
<%
//System.out.println("step9");
	//try{
	//	if(numOfRejectionRecords>0)
	//	{
	//	if(reason.get(0).getStatus().equalsIgnoreCase("yes"))
	
//	{
		//System.out.println("step5");
%>
		
			<tr>
				<td>
				<div align="left"><font size="3"><b> Driver is Rejected Due to <%=reason.get(0).getReasonOfComment()%>
				:<%=reason.get(0).getReasonOfRejection() %></b></font></div>
				</td>
		
				<td colspan="2" id="check">
					<div align="left"><font size="2">Close Rejection? </font> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
						<input type="radio" name="rejectionConfirm" value="Yes" id="rejectionConfirm" onclick="AJAXFunc(0)" /> Yes &nbsp;&nbsp; 
						<input type="radio" name="rejectionConfirm" value="No" id="rejectionConfirm" onclick="AJAXFunc(1)" /> NO
					</div>
					
				</td>
				<!--<td colspan="3" align="center"></td>-->
				</tr>
			
		
<%//}
	//	}
	//	}catch(Exception e)
	//{
	//	e.printStackTrace();
	//}
	//System.out.println("step10");
%>
	</table>
		</div>
		</td>
		<td width="50%">
		<table>
			<tr>
				<td>
				<table class="stats" border="0" width="100%">
					
					<tr>
						<td align="center" colspan="4"><font size="2" ><b>Driver Run Hours
						</b></font></td>
					</tr>
					
				</table>
				</td>
			</tr>
<%
	//System.out.println("step11");
%>
			<tr>
				<td valign="top" style="background-color:#FFFFFF">
				<div id="div1"><IFRAME
					src='driverRunHoursChart.jsp?driverid=<%=driverid%>&cnt=1' scrolling=no
					id='banner1' width='580' height='350'
					style='padding-top: 10; padding-left: 10' frameborder='0'></IFRAME>
				</div>
						</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
	<%
	//System.out.println("step11");
%>
		<td colspan="2">
		<table class="stats">
			<tr>
				<td align="center"><font  size="2"> <B>
				Last 10 Trips</B> </font></td>
			</tr>
			<tr>
				<td>
				<div
					style="margin-center: 178px; height: 200px; background-color: azure; border: 1px solid black; overflow: auto;">
				<table width="100%" class="stats">
					<tr>
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
//System.out.println("step12");	
if(numRecords>0){

	DisconnectionCount disconnCount = new DisconnectionCount();
	for(int counter=0; counter<numRecords;counter++)
	{	
		final DebriefSubmitViewData currentRecord = viewData.get(counter);
		final int i= counter + 1;
%>
				<tr>
					<td><%=i%>	
<%
       	if(i == 1){
       		if(isNull(currentRecord.getDriverMobileNumber())){
				driverMobileNumber="-";
			}
			else{
				driverMobileNumber=currentRecord.getDriverMobileNumber();
			}
%>
					<input type="hidden" name="hidLastTripRating" value="<%=currentRecord.getTripRating() %>" /> 
					<input type="hidden" name="hidLastTripId" value="<%=currentRecord.getTripId()%>" />
<%
		}
%>
						</td>
						<td><a href="javascript:toggleDetails(<%=i%>,true);"
							title="Click To See the Reports"> <%=currentRecord.getTripId()%></a>
						<br>
						<div class="popup" id="popup<%=i%>">
						<table border="1" bgcolor="white">
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"onclick="javascript:window.open('ShowCustomReportonTWMap.jsp?tripid=<%=currentRecord.getTripId()%>&vehcode=<%=currentRecord.getVehicleId()%>&data=<%=getTripStartDate(currentRecord.getStartDate())%>&data1=<%=getTripEndDate(currentRecord.getEndDate())%>&ftime1=<%=getTripStartTimeHrs(currentRecord.getStartDate())%>&ftime2=<%=getTripStartTimeMins(currentRecord.getStartDate())%>&ttime1=<%=getTripEndTimeHrs(currentRecord.getEndDate())%>&ttime2=<%=getTripEndTimeMins(currentRecord.getEndDate())%>&vehregno=<%=currentRecord.getVehicleRegistrationNumber()%>&ownername=<%=currentRecord.getOwnerName()%>&startplace=<%=currentRecord.getStartPlace()%>&endplace=<%=currentRecord.getEndPlace()%>&pg=brief' );">Show
								Trip on Map </a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);" 
								onclick="newwindow1('debrifLasrTripChart.jsp?driverid=<%=driverid%>&tripid=<%=currentRecord.getTripId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>&cnt=1');">Driver RunHrs Chart
								</a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brif_customreport.jsp?tripid=<%=currentRecord.getTripId()%>&transporter=<%=currentRecord.getOwnerName()%>&vehicleRegistrationNo=<%=currentRecord.getVehicleRegistrationNumber()%>&vehcode=<%=currentRecord.getVehicleId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>' );">Trip
								detail report </a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brfexceprepot.jsp?tripid=<%=currentRecord.getTripId()%>&vehcode=<%=currentRecord.getVehicleId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripStartDate(currentRecord.getEndDate())%>' );">Trip
								exception report</a></td>
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
						disconCount = disconnCount.CalulateDrivingHours(currentRecord.getVehicleId(),currentRecord.getStartDate(),currentRecord.getEndDate(),currentRecord.getTripId()); 
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
%>
<tr><td align="center" colspan="14"><font  size="3">NO TRIPS</font></td></tr>
<%
}
%>

				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>


			
			
			
			<%
		}
			
		}// numOfRecords>0
		}// else
    
		%>
	
<%
    
%>
</table>
</form>
<%@ include file="footernew.jsp"%>