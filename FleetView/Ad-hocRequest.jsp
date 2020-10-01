<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
 <link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link> 
<link href="css/css.css" rel="StyleSheet" type="text/css"></link> 
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<!-- <link rel="stylesheet" type="text/css" href="css/form.css" media="all"> -->
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}

</style>
<script>
 function Displayer(n)
 {var check = document.getElementById('Section' + n);
 if(check.style.display == 'none')
 {check.style.display='inline';}
 else{check.style.display='none';}
 }
 
 function showtablegeo(routeid)
 {
	 var location=document.getElementById("element_3_1").value;
	 var km=document.getElementById("element_3_2").value;
	 try
		{
	//alert("ajax 222");
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
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				try
				{
				var reslt=ajaxRequest.responseText;
				//alert(reslt);
				reslt=reslt.replace(/^\s+|\s+$/g,'');
				//alert(reslt);
				document.getElementById("thisdiv").innerHTML = reslt;
				window.location.reload();
				document.getElementById("element_3_2").value='';
				document.getElementById("element_3_1").value='';
				
				}
				catch(e)
				{
					alert(e);
				}
			}
		};
		
		var queryString ="?routeid="+routeid+"&element_3_1="+location+"&element_3_2="+km;
		//alert(queryString);
		ajaxRequest.open("POST", "Geofencewisesetinsert.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
	 
 }
 
 function open1(Rid,TripID,Geofence,FuelIssueCategory,FuelQuantity,Rate)
 {
   testwindow = window.open("Ad-hocUpdate.jsp?Rid="+Rid+"&TripID="+TripID+"&Geofence="+Geofence+"&FuelIssueCategory="+FuelIssueCategory+"&FuelQuantity="+FuelQuantity+"&Rate="+Rate,"FuelPlanning","width=700,height=500,scrollbars=yes");
 		testwindow.moveTo(250,250);
 }
 
 
 function usrval()
 {
 	var username=document.userform.fuelserch.value;
 	document.getElementById("usrn").style.display = "none";

 	if(username==null || username=="" || username.length==0){
 		document.getElementById("usrn").style.display = "";
 		return false;
 	}
 	
 	
 	}
 
 
 
 function timer(){
		//to display the please wait ..
		//document.getElementById("plzwait").style.display="";
		setTimeout("mysearch()",2000);
		}

 
 function mysearch(){

	  document.getElementById("searchuser").style.display='block';
	 	var fuelserch=document.userform.fuelserch.value;
	 	var fuelserch=document.getElementById("fuelserch").value;

	  document.getElementById("searchuser").style.display='block';
	 	var fuelserch=document.userform.fuelserch.value;
	 	var fuelserch=document.getElementById("fuelserch").value;
	 	//alert("fuelserch:-"+fuelserch);
	 	
	 	//var vehiclesearch=document.getElementById("vehicleserch").checked
	 	//alert("vehsearch:-"+vehiclesearch);
	 	
	 	//var vehidserch=document.getElementById("vehidserch").checked
	 	//alert("vehidserch:-"+vehidserch);
	 	
	 	if(fuelserch.length=="")
	 		{
	 		 document.getElementById("searchuser").style.visibility='hidden';
	 		//document.getElementById("searchuser").style.display="none";
	 		}
	 	else{
	 		
	 		document.getElementById("searchuser").style.visibility="visible";
	 		
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

	 	
	 	ajaxRequest.onreadystatechange = function()
	 	{
	 		if(ajaxRequest.readyState == 4)
	 		{
	 			var reslt=ajaxRequest.responseText;
	 			//alert("reslt:-"+reslt);
	 			
	 			document.getElementById("searchuser").innerHTML=reslt;
	 			
	 			//document.getElementById("plzwait").style.display="none";
	 		} 
	 	}
	 	var queryString = "?fuelserch=" +fuelserch;
	 	//alert("queryString:-"+queryString);
	 	ajaxRequest.open("GET", "Ad-hocAjaxRequest.jsp" + queryString, true);
	 	ajaxRequest.send(null); 
	 	}

	 }
 
 function setname(newuser){
		alert("in set"+newuser);
		newuser=newuser.replaceAll("#", " ");
		alert("in set after"+newuser);
		//document.getElementById("searchuser").style.display='none';
		document.getElementById("searchuser").style.visibility="hidden";
		document.getElementById("fuelserch").value=newuser;
		//document.userform.fuelserch.value=newuser;
		
		//alert("in set last");
	}
 
 /* function open1(StartDate,TripID,StartCode,EndCode,roundOfftotfuel)
 {
   testwindow = window.open("locationwise.jsp?StartDate="+StartDate+"&TripID="+TripID+"&StartCode="+StartCode+"&EndCode="+EndCode+"&totfuel="+roundOfftotfuel,"FuelPlanning","width=1000,height=700,scrollbars=yes");
 		testwindow.moveTo(250,250);
 } */
 
 
 
function formValidation()
{
var displaylabel="";
var displaycount="";
var count3="";
// Mandatorytransworld
// alphatransworld
// charactertransworld
// numbertransworld
// emailtransworld

if(displaylabel == ""){
return true;
}

else{
var displaylabelres = displaylabel.split(",");
var res1=displaycount.split(",");
var res2=count3.split(",");
var i;
var j;

for(j=0; j < res2.length-1; j++){
 document.getElementById("element_error_"+ res2[j]).style.display='none';
 }
 
for (i = 0; i < displaylabelres.length-1; i++) {
    var element_error_="element_error_"+i;
    var number=i;
    document.getElementById("element_error_"+ res1[i]).style.display="";
    document.getElementById("element_error_"+ res1[i]).innerHTML=displaylabelres[i];
} 

 return false;
}
}
</script>
<%
Connection con1 = null;
Statement stdynamicdrop = null,stmt2=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
stmt2=con1.createStatement();
String RouteCode=request.getParameter("RouteCode");
%>
<%@ include file="headernew.jsp"%> 
				
<%!String StartDate="",DriverCode="",DriverName="";
int i=1;
String VehRegNo="",TripID="",origin="",destination="",FIxedKM="",GPName="",StartCode="",EndCode="",EndDate="";%>
<br>
<br>
<%
String owner=session.getAttribute("usertypevalue").toString();
String Customer="";
//String Customer=session.getAttribute("typevalue").toString();
String EndPlace="",JRMRouteID="",StartPlace="",startend="",Owner="",vehregno="";
String Tripid="",drivername="",driver_id="",Vendor="",FuelIssueCategory="",Distance="",Day="",Geofence="",FuelQuantity="",Rate="",Amount="",Status="";
double Km=0.0;
PreparedStatement preparedStatement = null;
/* String sql="select * from db_gps.t_castrolroutetest where RouteCode= ? ";
try{
	preparedStatement =con1.prepareStatement(sql);
	preparedStatement.setString(1, RouteCode);
	ResultSet rs=preparedStatement.executeQuery();
	if(rs.next()){
		JRMRouteID=rs.getString("JRMRouteID");
		Km=rs.getDouble("Km");
		StartPlace=rs.getString("StartPlace");
		EndPlace=rs.getString("EndPlace");
		Owner=rs.getString("Owner");
		startend=StartPlace+"-"+EndPlace;
	}
	
	 //vehregno="MH 12 YD 1516";	
}catch(Exception e){
	e.printStackTrace();
}
session.setAttribute("routeid", JRMRouteID);
 */%>

<h1 align="center" style="width: 1290px; margin-left: 0;"><font size="3">Ad-hoc Request</font></h1>

<form name="userform" action="" method="post" onsubmit="return formValidation();">

<div align="center">
<table width="35%" border="0">

<tr bgcolor="" id="tr20">
  <td> 
           <label id="element_1" name="element_1"  class="description" for="element_1"><b>Enter Vehicle Number :</b> </label>
        <select name="vehicle" id="vehicle" style="width: 135px; height:23px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
        <option value="Select">Select</option>
            <%
        String vehiclecode="",Rid="";
       	String sqlregno = "select VehicleRegNumber,vehiclecode from db_gps.t_vehicledetails where vehiclecode in "+session.getAttribute("VehList").toString()+" order by VehicleRegNumber";
		System.out.println("*******"+sqlregno);
		PreparedStatement ps=con1.prepareStatement(sqlregno);
        ResultSet rsregno = ps.executeQuery();
		while(rsregno.next())
		{
			 vehiclecode= rsregno.getString("vehiclecode");
			 VehRegNo=rsregno.getString("VehicleRegNumber");
			 
			 System.out.println("VehicleRegNo-->"+VehRegNo);
			
	         
			//String vehicles="";
			//vehicles=vehicles.replace("(","");
			//vehicles=vehicles.replace(")","");
			
			
		//	System.out.println("*******");
			//System.out.println("*vehicles******"+vehicles);
			//System.out.println("*VehRegNo******"+VehRegNo);
			//System.out.println("-anil veh-------"+vehicles.equalsIgnoreCase(rsregno.getString("VehicleRegNumber")));
			
			
			%>
		    <option value="<%=rsregno.getString("VehicleRegNumber")%>" ><%=rsregno.getString("VehicleRegNumber")%></option>			
			<%
			
      }
		%>
           </select>
     </td>
      <td><br><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Search" /></td> 
      
 </tr>
  

</table>
</div>
<br>



<%
//if (!(null == request.getQueryString())) {
	%>
	<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center"><font face="Arial" size="3">
	<B>Ad-hoc Request For Vehicle <%=request.getParameter("vehicle")%></B></font></div>
	
	<div id="mytable"> 
			<table border="1" class="sortable" style="align:center; font:normal 13px Arial,Helvtica,sans-serif; width : 100%;" >
			
			<tr>
				<th>Sr.</th>
				<th> TripId </th>
				<th> VehicleRegNo </th>
				<th> Owner</th>
				<th> Vendor</th>
				<th> FuelIssueCategory</th>
				<th> Distance </th>
				<th> Day </th>
				<th> Geofence </th>
				<th> FuelQuantity </th>
				<th> Rate </th>
				<th> Amount </th>
				<th> Status </th>
				<th> DriverId </th>
				<th> DriverName </th>
								
			</tr>
	<% 
	
	String record="select * from db_gps.t_fuelissuemaster where vehregno='"+request.getParameter("vehicle")+"' and Status='Unprocessed' order by rid asc limit 1";
	PreparedStatement ps1=con1.prepareStatement(record);
    ResultSet rsrecord = ps1.executeQuery();
    String record1="select * from db_gps.t_fuelissuemaster where vehregno='"+request.getParameter("vehicle")+"' and Status='Unprocessed' order by rid asc limit 1";
	PreparedStatement ps2=con1.prepareStatement(record);
    ResultSet rsrecord1 = ps2.executeQuery();
    
    if(!(rsrecord1.next())){%>
    	<div align="center"><font size="2" color="red"><b>No Fuel Request for vehicle :-<%=request.getParameter("vehicle")%></b></font></div>
    <%}
    else{
	while(rsrecord.next())
	{
		
		Rid=rsrecord.getString("Rid");
		Tripid=rsrecord.getString("Tripid");
		vehregno=rsrecord.getString("vehregno");
		Owner=rsrecord.getString("Owner");
		Vendor=rsrecord.getString("Vendor");
		FuelIssueCategory=rsrecord.getString("FuelIssueCategory");
		Distance=rsrecord.getString("Distance");
		Day=rsrecord.getString("Day");
		Geofence=rsrecord.getString("Geofence");
		FuelQuantity=rsrecord.getString("FuelQuantity");
		Rate=rsrecord.getString("Rate");
		Amount=rsrecord.getString("Amount");
		Status=rsrecord.getString("Status");
		driver_id=rsrecord.getString("driver_id");
		drivername=rsrecord.getString("drivername");
		
	
	%>
	<tr>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=i%></td>
		
		<%-- <td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=Tripid%></td> --%>
		<td><div align="right"><a href="#" onclick="open1('<%=Rid%>','<%=Tripid%>','<%=Geofence%>','<%=FuelIssueCategory%>','<%=FuelQuantity%>','<%=Rate%>')"><%=Tripid%></a></div></td>
		<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=vehregno%></td> 
		
		<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=Owner%></td>
		<%-- <td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=location%> </a></td> --%>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Vendor%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=FuelIssueCategory%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Distance%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;width: 190px;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Day))%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Geofence%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=FuelQuantity%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Rate%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Amount%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Status%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=driver_id%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=drivername%></td>
		
		
		
	</tr>
<%i++;
	}
       }
%>
	</table>
	</div>
	</form>
	<%
//}
	%>
<%
try{
		
		
}catch(Exception e)
{
	e.printStackTrace();
}
%>

</jsp:useBean>
<%@ include file="footernew.jsp" %>