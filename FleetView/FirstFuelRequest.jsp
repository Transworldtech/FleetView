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
 
 
 function usrval()
 {
 	var username=document.userform.fuelserch.value;
 	document.getElementById("usrn").style.display = "none";

 	if(username==null || username=="" || username.length==0){
 		document.getElementById("usrn").style.display = "";
 		return false;
 	}
 	
 	
 	}
 
 
 function gen(stdate,fuelplan,StartPlace,EndPlace)
 {
	 //var km=document.getElementById("element_3_2").value;
         //alert("fuelplan:-"+fuelplan);
         //alert("stdate:-"+stdate);
	 try
		{
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
				var reslt1;
				reslt=reslt.replace(/^\s+|\s+$/g,'');
				//alert(reslt);
				reslt1=reslt.split("#");
				document.getElementById("thisdaydiv1").innerHTML = reslt1[0];
				document.getElementById("element_3_9").value=reslt1[1];
				//window.location.reload();
				//document.getElementById("element_3_9").value='';
				//document.getElementById("element_3_1").value='';
				
				}
				catch(e)
				{
					alert(e);
				}
			}
		};
		
		var queryString ="?stdate="+stdate+"&fuelplan="+fuelplan+"&StartPlace="+StartPlace+"&EndPlace="+EndPlace;
		//alert(queryString);
		ajaxRequest.open("POST", "fuelplangen.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
	 
 }
 
 function genamount(totcont){

	 var location="";
	 var location123="";
	 var totalcount=totcont;
	 //alert(totcont);
	 for(j=1; j < totalcount; j++){
		 //document.getElementById("element_error_"+ res2[j]).style.display='none';
		 //alert("j:-"+j);
		 //alert("abc:-"+document.getElementById("fuelentr"+j).value);
		 location=document.getElementById("fuelentr"+j).value;
		 location123+=location+",";
		 //alert("location:-"+location);
		 
		 }
	 //alert("location123:-"+location123);
	 
	 try
		{
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
                var k; 
				var reslt1;
				//reslt=reslt.replace(/^\s+|\s+$/g,'');
				//alert(reslt);
				reslt1=reslt.split("#");
				//alert("reslt1.length"+reslt1.length);
				//document.getElementById("thisdaydiv1").innerHTML = reslt1[0];
                             for(k=1;k<reslt1.length;k++){ 
				               document.getElementById("amt"+k).innerHTML = reslt1[k-1];
                              }
				//document.getElementById("element_3_9").value=reslt1[1];
				//window.location.reload();
				//document.getElementById("element_3_9").value='';
				//document.getElementById("element_3_1").value='';
				
				}
				catch(e)
				{
					alert(e);
				}
			}
		};
		
		var queryString ="?location123="+location123;
		//alert(queryString);
		ajaxRequest.open("POST", "fuelamountgen.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
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
	 	ajaxRequest.open("GET", "Fuelsearchtripid.jsp" + queryString, true);
	 	ajaxRequest.send(null); 
	 	}

	 }
 
 function setname(newuser){
		//alert("in set");
		//document.getElementById("oldusername").value=newuser;
		document.userform.fuelserch.value=newuser;
		document.getElementById("searchuser").style.display='none';
		
	}
 
 /* function open1(StartDate,TripID,StartCode,EndCode,roundOfftotfuel)
 {
   testwindow = window.open("locationwise.jsp?StartDate="+StartDate+"&TripID="+TripID+"&StartCode="+StartCode+"&EndCode="+EndCode+"&totfuel="+roundOfftotfuel,"FuelPlanning","width=1000,height=700,scrollbars=yes");
 		testwindow.moveTo(250,250);
 } */
 
 function open1(StartDate,TripID,StartCode,EndCode,roundOfftotfuel,VehRegNo,StartPlace,EndPlace,FIxedKM,GPName,Customer,tripdays,Kmpl,DriverCode,DriverName,vehcode,Finalrouteid)
 {
	 
  var temp=Finalrouteid;
  if(temp=="Select"){
	  alert("Please Select Route First...");
  }else{
   testwindow = window.open("locationwise.jsp?StartDate="+StartDate+"&TripID="+TripID+"&StartCode="+StartCode+"&EndCode="+EndCode+"&totfuel="+roundOfftotfuel+"&VehRegNo="+VehRegNo+"&StartPlace="+StartPlace+"&EndPlace="+EndPlace+"&FIxedKM="+FIxedKM+"&GPName="+GPName+"&Customer="+Customer+"&tripdays="+tripdays+"&Kmpl="+Kmpl+"&DriverCode="+DriverCode+"&DriverName="+DriverName+"&vehcode="+vehcode+"&Finalrouteid="+Finalrouteid,"FuelPlanning","width=800,height=600,scrollbars=yes");
 		testwindow.moveTo(250,250);
  }
 }
 
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
String VehRegNo="",TripID="",origin="",destination="",FIxedKM="0",GPName="",StartCode="",EndCode="",EndDate="";%>
<form name="userform" action="" method="post" onsubmit="return formValidation();">
<br>
<br>
<%
String owner=session.getAttribute("usertypevalue").toString();
String Customer="";
//String Customer=session.getAttribute("typevalue").toString();
String EndPlace="",JRMRouteID="",StartPlace="",startend="",Owner="",vehregno="";
double Km=0.0;
PreparedStatement preparedStatement = null;
/* String sql="select * from db_gps.t_castrolroutes where RouteCode= ? ";
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
 */
 //session.setAttribute("routeid", JRMRouteID);
%>

<h1 align="center" style="width: 1290px; margin-left: 0;"><font size="3">Fuel Issue Form</font></h1>
<div align="center">
<table width="35%" border="0">

<tr bgcolor="" id="tr20">
   <td><font color="black"><b></b></font> 
  
  <!-- <input id="vehicleserch" name="vehserch" class="element radio" type="radio" checked="checked" value="vehicleserchdetails" />
<label class="choice" for="element_1">Vehicle</label>
<input id="vehidserch" name="vehserch" class="element radio" type="radio" value="vehidserchdetails" />
<label class="choice" for="element_2">TripId</label>

  <input type="radio" name="vehidserch" id="vehidserch" value="" onblur="" onkeyup=""/> -->
  </td>
  
  
  <!-- <td> 
           <label id="element_1" name="element_1"  class="description" for="element_1"><b>Trip Search :</b> </label>
           <input type="text" name="fuelserch" id="fuelserch" value="" onblur="usrval()" onkeyup="timer()"/>
           <br>
           <label name="usrn" id="usrn" style="display: none;"><font color="red">&nbsp;&nbsp;Please Enter User Name</font></label>
<input type="hidden" name="olduser123" id="olduser123" value="false"  >
           please wait functinality is here....
           <div id="plzwait" name="plzwait" style="display: none;"><font color="red" size="2">Please Wait...</font></div>
           
     </td>
      <td><br><input id="saveForm" name="submit"  class="button_text" type="button"  value="Submit" /></td> -->
      
 </tr>
  <tr><td></td><td><div id="searchuser" name="searchuser" style="position: fixed; overflow: auto;"></div></td><td></td></tr>

</table>
</div>
<br>

</form>

<div align="center" id="thisdaydiv">
<table class="sortable" border="1" style="width:100%;" >
<tr>
			<th rowspan="1"> Sr.No</th>
			<th rowspan="1"> Vehicle</th>
			<th rowspan="1"> RouteSelection</th>
			<th rowspan="1"> TripId</th>
			<th rowspan="1"> Origin</th>
			<th rowspan="1"> Destination</th>
			<th rowspan="1"> Owner</th>
			<th rowspan="1"> Customer</th>
			<th rowspan="1"> StartDate</th>
			<th rowspan="1"> TripDays</th>
			<th rowspan="1"> Km</th>
			<th rowspan="1"> KMPL</th>
			<th rowspan="1"> Total Fuel</th>
</tr>

<%
try{
		
	String fuelserch1=request.getParameter("fuelserch");
	int i=1;
	String record1="",vehcode="",record2="";
	int tripdays=0;
	Double roundOfftotfuel=0.0;
	Double Kmpl=0.0,totfuel=0.0,FIxedKM1=0.0;
	//String record="select * from db_gps.t_startedjourney where TripID='"+fuelserch1+"' ";
	String record="select * from db_gps.t_startedjourney where (GPName='"+owner+"' or OwnerName='"+owner+"') and (JStatus='Running' or JStatus='tobeclosed') and fuelrequest='No' ";
	//String record="select * from db_gps.t_startedjourney where (GPName='"+owner+"' or OwnerName='"+owner+"') and StartDate='2016-04-26' and fuelrequest='No' and tripid='13011071' ";
	System.out.println("re=codr:--********************************"+record);
	PreparedStatement ps=con1.prepareStatement(record);
	ResultSet rs=ps.executeQuery();
	while(rs.next())
	{
		VehRegNo=rs.getString("VehRegNo");
		TripID=rs.getString("TripID");
		StartPlace=rs.getString("StartPlace");
		EndPlace=rs.getString("EndPlace");
		StartCode=rs.getString("StartCode");
		
		EndCode=rs.getString("EndCode");
		vehcode=rs.getString("Vehid");
		
		//FIxedKM=rs.getString("FIxedKM");
		GPName=rs.getString("OwnerName");
		Customer=rs.getString("Vendor");
		StartDate=rs.getString("StartDate");
		DriverCode=rs.getString("DriverCode");
		DriverName=rs.getString("DriverName");
		 //record1="select * from db_gps.t_castrolroutes where StartCode='"+StartCode.trim()+"' and EndCode='"+EndCode.trim()+"' limit 1";
		//record1="select * from db_gps.t_castrolroutes where StartCode='"+StartCode+"' and EndCode='"+EndCode+"' limit 1";
		record1="select * from db_gps.t_castrolroutes where StartCode='"+StartCode+"' and EndCode='"+EndCode+"' limit 1";
		//PreparedStatement ps1=con1.prepareStatement(record1);
		//ResultSet rs1=ps1.executeQuery();
		//if(rs1.next()){
			//FIxedKM=rs1.getString("Km");
			/* try{
			FIxedKM=rs1.getString("FuelApprovedKm");
			tripdays=rs1.getInt("tripdays");
			FIxedKM1=Double.parseDouble(FIxedKM);
			}catch(Exception e)
			{
				e.printStackTrace();
			} */
			
			record2="select Kmpl from db_gps.t_vehicledetails where VehicleCode='"+vehcode+"' ";
			PreparedStatement ps2=con1.prepareStatement(record2);
			ResultSet rs2=ps2.executeQuery();
			if(rs2.next()){
				
				Kmpl=rs2.getDouble("Kmpl");
				 try{
				totfuel=FIxedKM1/Kmpl;
				}catch(Exception e){
					totfuel=0.0;
					e.printStackTrace();
					
				} 
				roundOfftotfuel = (double) Math.round(totfuel);
				 
		//EndDate=rs.getString("ETA");
		
		%>
		<tr>
         <td style="text-align: right"><%=i%></td>
         <td><div align="left"><%=VehRegNo%></div></td>
         <td><div align="left">
         <select id="element_3_20" name="element_3_20"  style="width: 150px" class="element select medium" >
          <option value="Select" selected="selected">Select</option> 
       <% String route="select distinct(routecode) from db_gps.routeprofilemaster where Owner=? "; 
        PreparedStatement ps20=con1.prepareStatement(route);
		ps20.setString(1, owner);
		ResultSet rs20=ps20.executeQuery();
		while(rs20.next()){ 
        %>
           <option value="<%=rs20.getString("routecode")%>"><%=rs20.getString("routecode")%></option>
           <% }  %>
          </select></div></td>
			<%-- <td><div align="right"><a href="locationwise.jsp?StartDate=<%=StartDate%>&TripID=<%=TripID%>&StartCode=<%=StartCode.trim()%>&EndCode=<%=EndCode.trim()%>&totfuel=<%=roundOfftotfuel%>"><%=TripID%></a></div></td> --%>
			<%-- <td><div align="right"><a href="#" onclick="open1('<%=StartDate%>','<%=TripID%>','<%=StartCode.trim()%>','<%=EndCode.trim()%>','<%=roundOfftotfuel%>')"><%=TripID%></a></div></td> --%>
			<td><div align="right"><a href="#" onclick="open1('<%=StartDate%>','<%=TripID%>','<%=StartCode%>','<%=EndCode%>','<%=roundOfftotfuel%>','<%=VehRegNo%>','<%=StartPlace%>','<%=EndPlace%>','<%=FIxedKM%>','<%=GPName%>','<%=Customer%>','<%=tripdays%>','<%=Kmpl%>','<%=DriverCode%>','<%=DriverName%>','<%=vehcode%>',document.getElementById('element_3_20').value)"><%=TripID%></a></div></td>
			<td><div align="left"><%=StartPlace%></div></td>
			<td><div align="left"><%=EndPlace%></div></td>			
			<td><div align="left"><%=GPName%></div></td>
			<td><div align="left"><%=Customer%></div></td>
			<td><div align="right"><%=StartDate%></div></td>
			<td><div align="right"><%=tripdays%></div></td>
			<td><div align="right"><%=FIxedKM%></div></td>
			<td><div align="right"><%=Kmpl%></div></td>
			<td><div align="right"><%=roundOfftotfuel%></div></td>	
						
<% 	i++;}}//}
	
}catch(Exception e)
{
	e.printStackTrace();
}
%>
</table>
</div>
<br>
<%-- <div align="center" id="thisfuelwisediv">
<table width="30%" border="0">
<tr>
<td>
<label id="element_1" name="element_1"  class="description" for="element_1"><b>FuelPlan</b></label><select id="element_3_6" name="element_3_6"  style="width: 150px" class="element select medium" >
<option value="Select" selected="selected">Select</option> 
<%/* String day="select distinct(WareHouse),WareHouseCode from db_gps.t_warehousedata where Owner=? and Status=? "; 
        PreparedStatement ps=con1.prepareStatement(loc);
		ps.setString(1, owner);
		ps.setString(2, "Active");
		ResultSet rs=ps.executeQuery();
		while(rs.next()){ */
%>
<option value="Daywise">Daywise</option>
<option value="Geofence">Geofence</option>
<option value="Km">Km</option>
<%/* } */ %>
</select>
</td>
<td><br><input id="saveForm" name="submit"  class="button_text" type="button"  value="Generate" onclick="gen('<%=StartDate%>',document.getElementById('element_3_6').value,'<%=StartCode%>','<%=EndCode%>');" /></td>
</tr>
</table>
</div> --%>

<%-- <div align="center" id="thisdaydiv1">
<!-- <table class="sortable" border="1" style="width:50%;" > -->
<!-- <tr>
			<th rowspan="1"> Sr.No</th>
			<th rowspan="1"> Date</th>
			<th rowspan="1"> Fuel</th>
			<th rowspan="1"> Quantity</th>
			<th rowspan="1"> Amount</th>
</tr> -->
<tr>
         <td style="text-align: right"><%=i%></td>
         <td><div align="right"><%=1%></div></td>
         <td><div align="left"><input type="text" style="width: 160px;" name="fuelentr" id="fuelentr" value="" onkeyup=""/></div></td>
         <td><div align="right"><%=12%></div></td>
         <td><div align="right"><%=130%></div></td>
</tr>

 <!-- </table> -->
</div>
 --%>
 
<%-- <div align="center">
<input type="hidden" name="element_3_9" id="element_3_9" value=""/>
<% 
//String abc=request.getParameter("");
%>
<input id="saveForm1" name="submit1"  class="button_text" type="button"  value="GenerateAmount" onclick="genamount(document.getElementById('element_3_9').value);" />
</div>
 --%></jsp:useBean>
<%@ include file="footernew.jsp" %>