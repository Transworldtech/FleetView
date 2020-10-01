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
 
 
 function gen(stdate,fuelplan,StartPlace,EndPlace,routecodenew,vehcode)
 {
	    var Kmpl=document.getElementById("Kmpl").value;
	    var GPName=document.getElementById("GPName").value;
	    if(fuelplan=="Daywise"){
	    document.getElementById('temp2').style.display="";
	    }
	   // alert("fuelplan:-"+fuelplan);
        // alert("Kmpl:-"+Kmpl);
        //alert("GPName:-"+GPName);
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
				//document.getElementById("fdate9").innerHTML = reslt1[0];
				document.getElementById("element_3_9").value=reslt1[1];
				document.getElementById('temp2').style.display='none';
				//document.getElementById('temp3').style.display='none';
            	document.getElementById('temp1').style.display='none';
            	document.getElementById('temp4').style.display='none';
           	 
				var mystr;
				var i;
				for(i=1;i<reslt1[1];i++){

				 mystr+="<input type='hidden' name='amt9"+i+"' id='amt9"+i+"' value='123' />"
				 document.getElementById("tp").innerHTML = mystr;
				}
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
		
		var queryString ="?stdate="+stdate+"&fuelplan="+fuelplan+"&StartPlace="+StartPlace+"&EndPlace="+EndPlace+"&Kmpl="+Kmpl+"&GPName="+GPName+"&routecodenew="+routecodenew+"&vehcode="+vehcode;
		//alert(queryString);
		ajaxRequest.open("POST", "fuelplangen.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
	 
 }
 
 function genamount(){

	 var totcont=document.getElementById('element_3_9').value;
	 var totfuel=document.getElementById('element_3_10').value;
	 var GPName=document.getElementById('GPName').value;
	 var vehcode=document.getElementById('vehcode').value;
	 //alert("totcont:-"+totcont);
	 //alert("totfuel:-"+totfuel);
	 //alert("GPName:-"+GPName);
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
                var i;
                var j;
				var reslt1;
				var reslt2;
				//reslt=reslt.replace(/^\s+|\s+$/g,'');
				//alert(reslt);
				reslt1=reslt.split("#");
				reslt2=reslt.split("**");
				//alert("reslt1.length"+reslt1.length);
				//document.getElementById("thisdaydiv1").innerHTML = reslt1[0];
                             for(k=1;k<reslt1.length;k++){ 
				               document.getElementById("amt"+k).innerHTML = reslt1[k-1];
				               
                              }
                             for(j=1;j<reslt1.length;j++){
                            	 
                             //alert("amt9"+j);
                            // alert(reslt1[j-1]);
                             var elem = document.getElementById("amt9"+j).value;
                             //alert("elem"+elem);
                             
                             if(typeof elem !== 'undefined' && elem !== null) {
                               document.getElementById("amt9"+j).value = reslt1[j-1].trim();
                               //alert("elem******"+document.getElementById("amt9"+j).value);
                               
                             }
                             //document.getElementsByName(amt9)[];
                             //document.getElementById("amt9"+j).innerHTML = reslt1[j-1];
                             }
                             //for(i=1;i<reslt2.length;i++){ 
                            	 document.getElementById('temp2').style.display='none';
	                         	 document.getElementById('temp1').style.display="";
	                         	 document.getElementById('temp4').style.display="";
                            	  //hide
                            	  //show
                            	 if(reslt2[1]<0){
                            		 document.getElementById('saveForm2').style.display='none';
                            		 alertfun(); 
                            	 }else{
  				                document.getElementById("fuelbalance").value = reslt2[1];
  				                document.getElementById('saveForm2').style.display="";
                            	 }
                               // }
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
		
		var queryString ="?location123="+location123+"&totfuel="+totfuel+"&GPName="+GPName+"&vehcode="+vehcode;
		//alert(queryString);
		ajaxRequest.open("POST", "fuelamountgen.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
	 
	 
 }
 
 function alertfun()
 {
	 alert("Fuel Balance exceed max fuel Limits...");
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
 
 function myfulbalsearch123(){
		//to display the please wait ..
		//document.getElementById("plzwait").style.display="";
		setTimeout("myfulbalsearch()",1000);
		}
 
 function myfulbalsearch(){

     var fuelbalance="";
 var fuelbalance123="";
 var totcont=document.getElementById('element_3_9').value;
 var totalfuelbalence=document.getElementById('fuelbalance').value;
 //alert("totcont:-"+totcont);
  for(j=1; j < totcont; j++){
	 fuelbalance=document.getElementById("fuelentr"+j).value;
	 fuelbalance123+=fuelbalance+",";
	 //alert("location:-"+location);
	 
  }//for loop close
         
 	//alert("fuelbalance:-"+fuelbalance123);
 	
 	/* 
 	if(fuelbalance.length=="")
 		{
 		 //document.getElementById("searchuser").style.visibility='hidden';
 		//document.getElementById("searchuser").style.display="none";
 		}
 	else{ */
 		
 		//document.getElementById("searchuser").style.visibility="visible";
 		
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
 			alert("reslt:-"+reslt);
 			var reslt1;
			//reslt1=reslt.split("#");
 			document.getElementById("fuelbalance").value=reslt;
 			//document.getElementById("plzwait").style.display="none";
 		} 
 	}
 	var queryString = "?fuelbalance="+fuelbalance123+"&totalfuelbalence="+totalfuelbalence;
 	//alert("queryString:-"+queryString);
 	ajaxRequest.open("GET", "Fuelbalsearch.jsp" + queryString, true);
 	ajaxRequest.send(null); 
 	//}
     
 }
 
 function setname(newuser){
		//alert("in set");
		//document.getElementById("oldusername").value=newuser;
		document.userform.fuelserch.value=newuser;
		document.getElementById("searchuser").style.display='none';
		
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
String datenew1="",datenew2="",datenew3="",tripdays="",FIxedKM="";
//String totfuel="0.0";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
stmt2=con1.createStatement();
String RouteCode=request.getParameter("RouteCode");
String StartDate=request.getParameter("StartDate");
String TripID=request.getParameter("TripID");
//String StartCode=request.getParameter("StartCode");
//String EndCode=request.getParameter("EndCode");
///totfuel=request.getParameter("totfuel");
String VehRegNo=request.getParameter("VehRegNo");
String StartPlace=request.getParameter("StartPlace");
String EndPlace=request.getParameter("EndPlace");
//String FIxedKM=request.getParameter("FIxedKM");
String GPName=request.getParameter("GPName");
String Customer=request.getParameter("Customer");
//String tripdays=request.getParameter("tripdays");
String Kmpl=request.getParameter("Kmpl");
String DriverCode=request.getParameter("DriverCode");
String DriverName=request.getParameter("DriverName");
String vehcode=request.getParameter("vehcode");
String Finalrouteid=request.getParameter("Finalrouteid");
/////////////////////////Default fuel rate ................//////////////////////////////////

Double fuelrate=0.0,FIxedKM1=0.0,Kmpl1=0.0,totfuel=0.0;
Double roundOfftotfuel=0.0;
String Fuel="",routecodenew="";

String fueltype="select Fuel from db_gps.t_VehMst where VehId='"+vehcode+"' ";
//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
//System.out.println("re=codr:--********************************"+fueltype);
PreparedStatement ps4=con1.prepareStatement(fueltype);
ResultSet rs4=ps4.executeQuery();
if(rs4.next())
{
	Fuel=rs4.getString("Fuel");

}

if(Fuel.equals("-") || Fuel.equalsIgnoreCase("-"))
{
	
	String record="select rate from db_gps.t_Defaultfuelratemaster where fuel='"+Fuel+"' and transporter='"+GPName+"' order by UpdatedDate desc limit 1";
	//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
	System.out.println("re=codr:--********************************"+record);
	PreparedStatement ps2=con1.prepareStatement(record);
	ResultSet rs2=ps2.executeQuery();
	if(rs2.next())
	{
	fuelrate=rs2.getDouble("rate");
	//System.out.println("fuelrate1:--********************************"+fuelrate);

	if(fuelrate.equals("-") ){
	String record1="select rate from db_gps.t_Defaultfuelratemaster where fuel='"+Fuel+"' and transporter='Default' ";
	//System.out.println("re=codr:--********************************"+record1);
	PreparedStatement ps3=con1.prepareStatement(record1);
	ResultSet rs3=ps3.executeQuery();
	if(rs3.next()){
	fuelrate=rs3.getDouble("rate");
	//System.out.println("fuelrate3:--********************************"+fuelrate);
	}

	}
	}

}else{
	
	String record="select rate from db_gps.t_Defaultfuelratemaster where fuel='Diesel' and transporter='"+GPName+"' order by UpdatedDate desc limit 1";
	//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
	System.out.println("re=codr:--********************************"+record);
	PreparedStatement ps2=con1.prepareStatement(record);
	ResultSet rs2=ps2.executeQuery();
	if(rs2.next())
	{
	fuelrate=rs2.getDouble("rate");
	//System.out.println("fuelrate1:--********************************"+fuelrate);

	if(fuelrate.equals("-") ){
	String record1="select rate from db_gps.t_Defaultfuelratemaster where fuel='Diesel' and transporter='Default' ";
	//System.out.println("re=codr:--********************************"+record1);
	PreparedStatement ps3=con1.prepareStatement(record1);
	ResultSet rs3=ps3.executeQuery();
	if(rs3.next()){
	fuelrate=rs3.getDouble("rate");
	//System.out.println("fuelrate3:--********************************"+fuelrate);
	}

	}
	}

}// end of else


String routequery="select * from db_gps.routeprofilemaster where routecode='"+Finalrouteid+"' and owner='"+GPName+"' ";
System.out.println("re=codr:--********************************"+routequery);
PreparedStatement ps2=con1.prepareStatement(routequery);
ResultSet rs2=ps2.executeQuery();
if(rs2.next())
{
	

	FIxedKM=rs2.getString("stdkm");
	tripdays=rs2.getString("transitdays");
	StartCode=rs2.getString("origin");
	EndCode=rs2.getString("destination");
	routecodenew=rs2.getString("routecode");
	FIxedKM1=Double.parseDouble(FIxedKM);
	Kmpl1=Double.parseDouble(Kmpl);
	 try{
	totfuel=(FIxedKM1/Kmpl1);
	}catch(Exception e){
		totfuel=0.0;
		e.printStackTrace();
		
	} 
	 totfuel = Math.round(totfuel * 100.0) / 100.0;
	 //totfuel = (double) Math.round(totfuel);
	
   //System.out.println("fuelrate1:--********************************"+fuelrate);
}
/* String record="select fuelrate from db_gps.t_defaultvals where OwnerName='"+GPName+"' ";
//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
System.out.println("re=codr:--********************************"+record);
PreparedStatement ps2=con1.prepareStatement(record);
ResultSet rs2=ps2.executeQuery();
if(rs2.next())
{
fuelrate=rs2.getDouble("fuelrate");
//System.out.println("fuelrate1:--********************************"+fuelrate);

if(fuelrate.equals("0.0") || fuelrate==0.0){
String record1="select fuelrate from db_gps.t_defaultvals where OwnerName='Default' ";
//System.out.println("re=codr:--********************************"+record1);
PreparedStatement ps3=con1.prepareStatement(record1);
ResultSet rs3=ps3.executeQuery();
if(rs3.next()){
fuelrate=rs3.getDouble("fuelrate");
//System.out.println("fuelrate3:--********************************"+fuelrate);
}

}
}
 */
/////////////////////////////////////////////////////////////////////////////////////
%>
<%@ include file="headernew.jsp"%> 
				
<%!String StartDate="";
String VehRegNo="",TripID="",origin="",destination="",GPName="",StartCode="",EndCode="",EndDate="";
%>
<form name="userform" action="firstfuelreqinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<h1 align="center" style="width: 800px; margin-left: 250;"><font size="3">Fuel Plan Master</font></h1>
<div align="center">
<table width="50%" border="0">
<tr>
<td width="10%">
<table border="0"  width="100%">
<tr align="left">
<td  valign="top" width="0%"><font color="black">  <b> Vehicle:</b><%=VehRegNo %> </font></td>
<td valign="top"><font color="black"><b>Origin: </b><%=StartPlace %> </font></td>
<td valign="top"><font color="black" id="dist"><b>Destination:</b><%=EndPlace %> </font></td>
<td valign="top"><font color="black" id="dist"><b>Km:</b><%=FIxedKM %> </font></td>
</tr>
<tr align="left">
<td valign="top"  width="0%"><font color="black"><b>Owner:</b><%=GPName %> </font></td>
<td valign="top" ><font color="black"><b>Customer:</b><%=Customer %> </font></td>
<td valign="top"><font color="black" id="tripdays"><b>TripDays:</b><%=tripdays %> </font></td>
<td valign="top"><font color="black" id="tripdays"><b>Kmpl:</b><%=Kmpl %> </font></td>

</tr>
</table>
</td>
</tr>
</table>
</div>

<h1 align="center" style="width: 800px; margin-left: 250;"><font size="3">Fuel Issue Form</font></h1>
<br>
<div align="center" style="width: 800px; margin-left: 530;"><b>Fuel Rate: <%=fuelrate%></b></div>
<div align="center" id="thisfuelwisediv">
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
<td><br><input id="saveForm" name="submit"  class="button_text" type="button"  value="Generate" onclick="gen('<%=StartDate%>',document.getElementById('element_3_6').value,'<%=StartCode%>','<%=EndCode%>','<%=routecodenew%>','<%=vehcode %>');" /></td>
</tr>
</table>
</div>
<br>
<div id="temp3" style="" align='center'>
<table width="38%" border="0">
<tr>
<td>
<div id="temp4" style="display: none;">
<font size="" color="black"><b>Total Fuel Balance :</b></font><label name="fuelbalance2" id="fuelbalance2" style="width: px;" ><b><%=totfuel%></b></label> <b>Ltrs</b>
</div>
</td>
<td>
<div id="temp1" style="display: none;" align='center'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font color="black"><b>Fuel Balance :</b></font><input type="text" name="fuelbalance" id="fuelbalance" style="width: 70px;" value="" readonly onblur="" /><b>Ltrs</b>
</div>
<div id="temp2" style="display: none;" align='center'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font color="black"><b>Fuel Balance :</b></font><input type="text" name="fuelbalance1" id="fuelbalance1" style="width: 70px;" value="<%=totfuel%>" readonly onblur="" /><b>Ltrs</b>
</div>
</td>
</tr>
</table>
</div>


<div align="center" id="thisdaydiv1">
<!-- <table class="sortable" border="1" style="width:50%;" > -->
<!-- <tr>
			<th rowspan="1"> Sr.No</th>
			<th rowspan="1"> Date</th>
			<th rowspan="1"> Fuel</th>
			<th rowspan="1"> Quantity</th>
			<th rowspan="1"> Amount</th>
</tr> -->
<%-- <tr>
         <td style="text-align: right"><%=i%></td>
         <td><div align="right"><%=1%></div></td>
         <td><div align="left"><input type="text" style="width: 160px;" name="fuelentr" id="fuelentr" value="" onkeyup=""/></div></td>
         <td><div align="right"><%=12%></div></td>
         <td><div align="right"><%=130%></div></td>
</tr>
 --%>
 <!-- </table> -->
 <!-- <textarea name="amt91" id="amt91" >123</textarea>
 <textarea name="amt92" id="amt92" >123</textarea>
 <textarea name="amt93" id="amt93" >123</textarea> -->
</div>
<div id="tp" style="display: none;">

</div>
<div align="center">

<input type="hidden" name="element_3_9" id="element_3_9" value=""/>
<input type="hidden" name="element_3_10" id="element_3_10" value="<%=totfuel%>"/>

<input type="hidden" name="VehRegNo" id="VehRegNo" value="<%=VehRegNo%>"/>
<input type="hidden" name="StartPlace" id="StartPlace" value="<%=StartPlace%>"/>
<input type="hidden" name="EndPlace" id="EndPlace" value="<%=EndPlace%>"/>
<input type="hidden" name="FIxedKM" id="FIxedKM" value="<%=FIxedKM%>"/>
<input type="hidden" name="GPName" id="GPName" value="<%=GPName%>"/>
<input type="hidden" name="Customer" id="Customer" value="<%=Customer%>"/>
<input type="hidden" name="tripdays" id="tripdays" value="<%=tripdays%>"/>
<input type="hidden" name="Kmpl" id="Kmpl" value="<%=Kmpl%>"/>
<input type="hidden" name="TripID" id="TripID" value="<%=TripID%>"/>
<input type="hidden" name="DriverCode" id="DriverCode" value="<%=DriverCode%>"/>
<input type="hidden" name="DriverName" id="DriverName" value="<%=DriverName%>"/>
<input type="hidden" name="vehcode" id="vehcode" value="<%=vehcode%>"/>


<%//String recrdcont=request.getParameter("element_3_9");
//int recrdcont1=Integer.parseInt(recrdcont);
//for(int i=1; i<recrdcont1; i++){
	
//}
%>

<%-- <table width="30%" border="0">
<br>
<tr>
<td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<% 
//String abc=request.getParameter("");
%>
<input id="saveForm1" name="submit1"  class="button_text" type="button"  value="Expence" onclick="genamount(document.getElementById('element_3_9').value,document.getElementById('element_3_10').value);" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input id="saveForm2" name="submit2"  class="button_text" style="display: none;" type="Submit"  value="Save" onclick="" /></td>
</tr>
</table> --%>
</div>

</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>