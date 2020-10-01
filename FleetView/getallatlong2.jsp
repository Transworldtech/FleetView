<%@ include file="IRTEheader.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>

 <%@page import="com.fleetview.beans.classes"%>
 <%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader ("Expires", 0);
%>
<%!
		Connection conn;
		Statement st,st1,st2,st3;
		int count=0;
		ResultSet rst;
%>
<%
classes fleetview= new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//Class.forName("org.gjt.mm.mysql.Driver");
conn = fleetview.ReturnConnection();;
 st = conn.createStatement();
 st1 = conn.createStatement();
 st2 = conn.createStatement();
 st3 = conn.createStatement();
 
 String rfname=session.getAttribute("rfname").toString(); //user name  //.setAttribute("rfname",fnamelist);
 String rlname=session.getAttribute("rlname").toString();

 	String fwUser="";
 	String savedCoordiantes = "";String getCordiantesSql1 = "Select * from t_warehousedata where Owner='Castrol' and MarkerType='Point'";
 	
 	ResultSet rs22 = st3.executeQuery(getCordiantesSql1);
 
%>
<script type="text/javascript">
function toggleDetails(id, show)
{
//alert("In TggleDetails");
	//var popup = id;
	//alert("from showhide2");
	//alert(id);
	var popup =document.getElementById("popup"+id);
	var show1=show;
	//alert(show1);
//alert(popup);
//alert(popup1);
	if (show) {
		popup.style.visibility = "visible";
		popup.setfocus();
			} else {
		popup.style.visibility = "hidden";
	}
}

function toggleDetails1(id, show)
{

	var popupx = document.getElementById("popup"+id);
	if (show) {
		popupx.style.visibility = "visible";
		popupx.setfocus();
		
	} else {
		popupx.style.visibility = "hidden";
	}
}
var myname;
function callfun()
{
	//alert("aleast i am here");
	var aa=document.getlatlong.owner.value;
	//var owner1=document.getElementById("owner").value;	
	alert ("i got value of owner----" +aa);
	if(!(aa=="Select"))
	{	
		document.getlatlong.submit();
	}
}
</script>
<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;

.popupx {
background-color: #98AFC7;
position: absolute;
visibility: hidden;
}
</style>
<script type="text/javascript">

function changevale2()
{
	
  	
	var trgeo;
	var pt,ply;
	
		//alert("in changevalue2");
		
		 var center = new GLatLng(18.80,80.1);
		 myclick1(center);
		var marker100 = new GMarker(center,{draggable: true});

		    GEvent.addListener(marker100, "dragstart", function() {
		      map.closeInfoWindow();
		    });

		    GEvent.addListener(marker100, "dragend", function() {
		      marker100.openInfoWindowHtml("Just bouncing along...");
		      var latlong=marker100.getPoint();
		      var lat=latlong.lat();
		      var longi=latlong.lng();
		      //alert("lat="+lat+"long="+longi);
		      document.getElementById("lati").value=lat;
			 document.getElementById("langi").value=longi;
		    });

		    map.addOverlay(marker100);
	}
function changevale3(lon,lat)
{
	var trgeo;
	var pt,ply;
	//alert(lon);
	//alert(lat);
	
		//alert("in changevalue3");
		// var center = new GLatLng(18.80,80.1);
	         document.getElementById("lati1").value=lat;
			 document.getElementById("langi1").value=lon;
	
	
		 var center = new GLatLng(lon,lat);
		var marker100 = new GMarker(center,{draggable: true});
		
		    GEvent.addListener(marker100, "dragstart", function() {
		      map.closeInfoWindow();
		    });

		    GEvent.addListener(marker100, "dragend", function() {
		      marker100.openInfoWindowHtml("Just bouncing along...");
		      var latlong=marker100.getPoint();
		   
		      var newlat=latlong.lat();
		      var newlongi=latlong.lng();
		      //document.getElementById("lati").value=newlat;
			  //document.getElementById("langi").value=newlongi;
			 document.getElementById("lati1").value=newlat;
			 document.getElementById("langi1").value=newlongi;
			 
			 //alert(lon);
				//alert(lat);
		    });

		    map.addOverlay(marker100);
				
	
	}

function showhide1()
{
//	alert("kk");
	var tda, tdb,tdc,tdd,tdi,tdh;
	var tds=document.getElementById("ar").value;
	
	changevale2();
	
	if(tds=="ADD Record")
	{
		//alert("kk");
		tda=document.getElementById("tra");
		
		tda.style.display='';
		tdb=document.getElementById("trb");
		//alert(tdb);
		tdb.style.display='';
		tdc=document.getElementById("trc");
		tdc.style.display='';
		tdd=document.getElementById("trd");
		tdd.style.display='';
		tdi=document.getElementById("tri");
		tdi.style.display='';
		tdh=document.getElementById("addgeo");
		tdh.style.display='';
		
		

	}
	else

	{
		tda=document.getElementById("tra");
		tda.style.display='none';
		tdb=document.getElementById("trb");
		tdb.style.display='none';
		tdc=document.getElementById("trc");
		tdc.style.display='none';
		tdd=document.getElementById("trd");
		tdd.style.display='none';
		tdi=document.getElementById("tri");
		tdi.style.display='none';
		tdh=document.getElementById("addgeo");
		tdh.style.display='none';


		}
}
function Cancel()
{
	var addcan=document.getElementById("btn5").value;
	//var canupdate=document.getElementById("btn6").value;
	
if(addcan=="Cancel");
{
	//alert("cancel called");
	
	tda=document.getElementById("tra");
	tda.style.display='none';
	tdb=document.getElementById("trb");
	tdb.style.display='none';
	tdc=document.getElementById("trc");
	tdc.style.display='none';
	tdd=document.getElementById("trd");
	tdd.style.display='none';
	tdi=document.getElementById("tri");
	tdi.style.display='none';
	document.form1.action="getallatlong2.jsp";
	document.form1.submit();
	
}

}
function CancelUpdate()
{
	var canupdate=document.getElementById("btn6").value;
	if(canupdate=="Cancel Update")
	{
		tda=document.getElementById("tre");
		tda.style.display='none';
		tdb=document.getElementById("trf");
		tdb.style.display='none';
		tdc=document.getElementById("trg");
		tdc.style.display='none';
		tdd=document.getElementById("trh");
		tdd.style.display='none';
		tdi=document.getElementById("trj");
		tdi.style.display='none';	
		document.form1.action="getallatlong2.jsp";
		document.form1.submit();
	}
}
function showhide2(count,show)
{
	//changevale3(a,b);
	//alert("hii");
	var tde, tdf,tdg,tdh,tdj;
	
	
var count=count;
//var y=editid;
//alert(count);
toggleDetails(count,false);

//alert(y);
//alert("editname"+x);
//alert("edit id"+y);
	if(show)
		{
		//alert("In edit");
		
		tde=document.getElementById("tre");
	
		tde.style.display='';
		tdf=document.getElementById("trf");
		tdf.style.display='';
		tdh=document.getElementById("trg");
		tdh.style.display='';
		tdd=document.getElementById("trh");
		tdd.style.display='';
		tdj=document.getElementById("trj");
		tdj.style.display='';

		tda=document.getElementById("tra");
		tda.style.display='none';
		tdb=document.getElementById("trb");
		tdb.style.display='none';
		tdc=document.getElementById("trc");
		tdc.style.display='none';
		tdd=document.getElementById("trd");
		tdd.style.display='none';
		tdi=document.getElementById("tri");
		tdi.style.display='none';
		//getValue(a);
	}
	else
	{
		tda=document.getElementById("tre");
		tda.style.display='none';
		tdb=document.getElementById("trf");
		tdb.style.display='none';
		tdc=document.getElementById("trg");
		tdc.style.display='none';
		tdd=document.getElementById("trh");
		tdd.style.display='none';
		tdi=document.getElementById("trj");
		tdi.style.display='none';
	}
	//
}
function showhide3(count,show)
{
	

	//alert("hii");
	var tde, tdf,tdg,tdh,tdj;
	
var count=count;
//var y=editid;
//alert(count);
toggleDetails(count,false);
//changevale3(a,b);

//alert(y);
//alert("editname"+x);
//alert("edit id"+y);
	if(show)
		{
		//alert("In edit");
		
		tde=document.getElementById("tre");
	
		tde.style.display='';
		tdf=document.getElementById("trf");
		tdf.style.display='';
		tdh=document.getElementById("trg");
		tdh.style.display='';
		tdd=document.getElementById("trh");
		tdd.style.display='';
		tdj=document.getElementById("trj1");
		tdj.style.display='';

		tda=document.getElementById("tra");
		tda.style.display='none';
		tdb=document.getElementById("trb");
		tdb.style.display='none';
		tdc=document.getElementById("trc");
		tdc.style.display='none';
		tdd=document.getElementById("trd");
		tdd.style.display='none';
		tdi=document.getElementById("tri");
		tdi.style.display='none';
		//getValue(a);
	}
	else
	{
		tda=document.getElementById("tre");
		tda.style.display='none';
		tdb=document.getElementById("trf");
		tdb.style.display='none';
		tdc=document.getElementById("trg");
		tdc.style.display='none';
		tdd=document.getElementById("trh");
		tdd.style.display='none';
		tdi=document.getElementById("trj1");
		tdi.style.display='none';
	}
}
function CancelDelete()
{
	tda=document.getElementById("tre");
	tda.style.display='none';
	tdb=document.getElementById("trf");
	tdb.style.display='none';
	tdc=document.getElementById("trg");
	tdc.style.display='none';
	tdd=document.getElementById("trh");
	tdd.style.display='none';
	tdi=document.getElementById("trj1");
	tdi.style.display='none';
	document.form1.action="getallatlong2.jsp";
	document.form1.submit();
}
function get_radio_value(radioobject,warecode,wtype)
{
	//alert('hi');
//	alert(PolygonCoordinates);
//we are chaking dynamically values
	if(!radioobject)
		return "";
	var radiolength=radioobject.lenght;
	
	if(radiolength==undefined)
	{
		if(radioobject.checked)
		{
			//alert("into radio");
			myname=radioobject.value;
			document.getElementById("geo").value=myname;
			document.getElementById("geo1").value=warecode;
			document.getElementById("oldgeo").value=myname;
			document.getElementById("oldgeo1").value=warecode;
			document.getElementById("WType").value=wtype;
			document.getElementById("oldwtype").value=wtype;
			//alert(alertdocument.getElementById("PolygonCoordinates").value);
			
		}
	else{
         return false;
         }
			//alert('bbye');
	}
}
function getValue(a,b)
	{
	//alert(a);
	//alert(b);
	//changevale2(a,b);
	
	changevale3(a,b);
		
				
	}

	
function update()
{
//	alert('in side update ');

//var lati=document.getElementById("lati").value;
//var langi=document.getElementById("langi").value;

var nlati=document.getElementById("lati1").value;
var nlangi=document.getElementById("langi1").value;
	//alert("lati "+lati);
	//alert("lati1 "+langi);
	//alert("nlati"+nlati);
	//alert("nlangi"+nlangi);
	
	
	
	var loc=document.getElementById("geo").value;
	var loc1=document.getElementById("geo1").value;
	var oldloc=document.getElementById("oldgeo").value;
	var oldloc1=document.getElementById("oldgeo1").value;
	var wtype=document.getElementById("WType").value;
	var oldwtype=document.getElementById("oldwtype").value;
	
	
	//alert(wtype);
	if((loc==null)||(loc=="")||(loc1==null)||(loc1==""))
	{
		alert("Please select the location to be Update..!!!");	
		return 0;
	}
	if((oldloc==null)||(oldloc=="")||(oldloc1==null)||(oldloc1==""))
			{
		alert("Please select the location to be Update..!!!");	
		return 0;
			}
	//alert("cal to page update");
	document.form1.action="getGeoLocUpdate1.jsp?nlati="+nlati+"&nlangi="+nlangi+"&loc="+loc+"&loc1="+loc1+"&oldloc="+oldloc+"&oldloc1="+oldloc1+"&wtype="+wtype+"&oldwtype="+oldwtype; //+"&wtype="+wtype;

	document.form1.submit();	
	//alert("update complete");
}
function del()
{
	//alert('del fun is called');
   
	var loc=document.getElementById("geo").value;
	var loc1=document.getElementById("geo1").value;
	var oldloc=document.getElementById("oldgeo").value;
	var oldloc1=document.getElementById("oldgeo1").value;
	var wtype=document.getElementById("WType").value;
	var oldwtype=document.getElementById("oldwtype").value;
	
	if((loc==null)||(loc=="")||(loc1==null)||(loc1==""))
	{
		alert("Please select the location to be Delete..!!!");	
		return 0;
	}
	//alert("del called");
	document.form1.action="getGeoLocDel1.jsp?loc="+loc+"&loc1="+loc1+"&oldloc="+oldloc+"&oldloc1="+oldloc1+"&wtype="+wtype+"&oldwtype="+oldwtype;
	document.form1.submit();
}

function geoAdd()
{
	
	
	//alert('add fun is called');
	
	var lati=document.getElementById("lati").value;
	var langi=document.getElementById("langi").value;
	var warehouse=document.getElementById("add").value;
	var warehousecode=document.getElementById("addcode").value;
	var WType1=document.getElementById("WType1").value;
	//alert(WType1);
	if(WType1=="Select")
	{
		alert("Please Select Location Type..!!!");
		return 0;
	}
	/*if((lati==null)||(lati=="") || (langi==null)||(langi==""))
	{
		alert("To Geofence the location please drag the red baloon then fill the details..!!!");
		return 0;
	}*/
	if((warehouse=="")||(warehouse==null))
	{
		alert("Please enter new Geofence Location..!!!");
		return 0;
	}
	if((warehousecode=="")||(warehousecode==null))
	{
		alert("Please enter new Geofence Location Code..!!!");
		return 0;
	}
	if((lati=="")||(lati==null)||(langi=="")||(langi==null))
	{
		alert("Please drag the marker for lat and lon..!!!");
		return 0;
	}
	
	
	document.form1.action="getGeoLocAdd1.jsp?lati="+lati+"&langi="+langi+"&warehouse="+warehouse+"&warehousecode="+warehousecode+"&WType="+WType1;
	document.form1.submit();
	//alert("submit");
}
</script>
<!-- script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script -->
 <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAxjYame-JZRGh_FJuRBWlpBTlmEuEpA44GFjXbE_lz5qAkNbkwRTH_hHi4lHI7l-DNA8SyPlaWk0dhw" type="text/javascript"></script>
<body>
<!-- you can use tables or divs for the overall layout -->
<table border="1" bgcolor="white" align="center">
<tr>
<td colspan="2">
<table width="100%" align="center" >
	
			<tr>
			<td align="center">
			
			<font  size="3" ><b>Castrol Geofence Locations on Map</b></font></td>
			</tr>
</table>


<%
String editid=request.getParameter("editid");
String editname=request.getParameter("name");

String OwnerName = "";
 //fwUser="";
 
 fwUser = "castrol";
//System.out.println("--user---->>"+fwUser);

if (! session.isNew()) 
	OwnerName = (String) session.getAttribute("usertypevalue");
if (null == OwnerName) 
	{
		response.sendRedirect("index.jsp");
		return;
	}

//String =request.getParameter("owner");
String sql=null;
double lat=0.00,lon=0.00;
%>


</td>
</tr>
<tr>
<td width="20%" valign="top">
<table width="100%" border="1" valign="topo">
<%
if(OwnerName!=null)
{
%>
<tr><th>All Loacations for Castrol</th><th> <input type="button" value="ADD Record" onclick="showhide1();"id="ar" ></th></tr>

<%
}
else
{
%>

<tr><th colspan="1">All Loacations</th></tr>
<%}%>


</table>
 <!-- =========== side_bar with scroll bar ================= -->
 
<div id="side_bar"  style="overflow:auto; width:300px; height:390px;" align="left" ></div>
           <!-- ===================================================== -->	
	
</td>
<td  valign="top">
       <div id="map" style="width: 850px; height: 400px"></div>
</td>
      </tr>  
</table>

<% 
if(fwUser.equalsIgnoreCase("castrol"))
{
	%>
<form action="" name="form1" method="post" >

	<table class="stats" >
	
	<tr id="tra" style="display: none;">
		<td colspan="2" class="hed">Add New Geofence Location<br>(Click on map then fill the details)</td>
	</tr>
	<tr id="trb" style="display: none;">
		<td>New Geofence Location :</td>
		<td><input type="text" name="add" id="add" ></td>
	</tr>
	<tr id="trc" style="display: none;">
		<td>Geofence Location Code :</td>
		<td><input type="text" name="addcode" id="addcode" ></td>
	</tr>
	<tr id="trd" style="display: none;">
		<td>Location Type </td>
		<td><select name="WType1" id="WType1">
			<option value="Select" selected="selected">Select</option>
			<option value="WH">-</option>
			<option value="WH">WH</option>
			<option value="Zone">Zone</option>
			<option value="BusinessUnit">BusinessUnit</option>
			<option value="Office">Office</option>
			<option value="HUB">HUB</option>
			<option value="Plant">Plant</option>
			<option value="Depot">Depot</option>
		</select></td>
	</tr>	 
	<tr id="addgeo" style="display: none;">
	<td>Add to Depot List :</td><td><input type="radio" name="addgeo" value="Yes">Yes &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="addgeo" value="No" Checked>No</td>
</tr>

	<tr id="tri" style="display: none;">
	<td colspan="2">
	<input type="button" name="btn3" id="btn3" value="Add Geofence Location" onclick="geoAdd();">
	<input type="button" name="btn5" id="btn5" value="Cancel" onclick="Cancel();">
	
	<!--<input type="hidden" name="lati" id="lati" class="formElement" readonly>-->
	<!--<input type="hidden" name="langi" id="langi" class="formElement" readonly>-->
	<!--<input type="hidden" name="page" id="page" value="poly" class="formElement" readonly>-->
	<input type="hidden" name="lati" id="lati" class="formElement" readonly>
	<input type="hidden" name="langi" id="langi" class="formElement" readonly>
	</td>		
  </tr>
  
  
 	<tr><td>
	
	<input type="hidden" name="editid" id="editid" value=<%=editid%> class="formElement" readonly>
	<input type="hidden" name="editname" id="editname" value=<%=editname%> class="formElement" readonly>
	</td>
	</tr>
	                   
	
	<tr id="tre" style="display: none;">
		
	
		<td colspan="2" class="hed">Update  Geofence Locations(Select location to Update)</td>
		
	</tr>
	
	
	<tr id="trf" style="display: none;">
		<td>Location Name :</td>
		<td><input type="text" name="geo" id="geo" ></td>
	</tr>
	<tr id="trg" style="display: none;">
		<td>Location Code :</td>
		<td><input type="text" name="geo1" id="geo1" readonly><input type="hidden" name="oldgeo" id="oldgeo" >
		<input type="hidden" name="oldgeo1" id="oldgeo1" >
		<input type="hidden" name="oldwtype" id="oldwtype">
		
		<input type="hidden" name="lati1" id="lati1" class="formElement" readonly>
	    <input type="hidden" name="langi1" id="langi1" class="formElement" readonly>	
		</td>
	</tr>
	<tr id="trh" style="display: none;">
		<td >Location Type :</td>
			<td><select name="WType" id="WType" >
			<option value="-">-</option>
			<option value="WH">WH</option>
			<option value="Zone">Zone</option>
			<option value="BusinessUnit">BusinessUnit</option>
			<option value="Office">Office</option>
			<option value="HUB">HUB</option>
			<option value="Plant">Plant</option>
			<option value="Depot"> Depot</option>
			</select> </td>
		
	</tr>	 
	<tr id="trj" style="display: none;">
	<td colspan="2">
	<input type="button" name="btn1" id="btn1" value="Update" onclick="update();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" name="btn6" id="btn6" value="Cancel Update" onclick="CancelUpdate();">
	</td>
	
	</tr>
	<tr id="trj1" style="display: none;">
	<td colspan="2">
	<input type="button" name="btn2" id="btn2" value="Delete" onclick="del();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" name="btn7" id="btn7" value="Cancel Delete" onclick="CancelDelete();">
	</td>
	</tr>
	</table>
	</form>

    
<%
	
} //end of castrol condition
%>

      
    <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>
    <script type="text/javascript">
    //<![CDATA[
   		if (GBrowserIsCompatible()) 
 		{
   			  
	      	var side_bar_html = "";
	 		var combo="<select name='select1' id='select1' class='bodyText'>";
	 		var combo1="</select>";
	 		var side_bar_html1 = "";
	 		var gmarkers = [];
	 	   var htmls = [];
	 	    var i = 0;
	 	    var lastvehcode=200;	
	 		var days = 0;
	 		var difference = 0;
	 		var markertoshow=[];
	 		var j = 0;
	 		var lableshow=[];
	 		var k=0;
	 		var lineshow=[];
	 		var l=0;
	 		var degreesPerRadian = 180.0 / Math.PI;
 	      	var arrowIcon = new GIcon();
 	        arrowIcon.iconSize = new GSize(12,12);
 	        arrowIcon.shadowSize = new GSize(1,1);
 	        arrowIcon.iconAnchor = new GPoint(6,6);
 	        arrowIcon.infoWindowAnchor = new GPoint(0,0);
 	        
 	      	var map = new GMap2(document.getElementById("map"));
 			map.addControl(new GMapTypeControl(1));
 			map.enableScrollWheelZoom();
 			map.addControl(new GSmallMapControl());
 			map.addControl(new GScaleControl());
 			map.setCenter(new GLatLng(18.80,80.1),5);
		  
			lstner = GEvent.addListener(map, 'click', function(overlay, point){
			//document.form1.lati.value=point.y;
			//document.form1.langi.value=point.x;
			 	});
 			
 	     	function myclick(i,lat, lon) {
 	     		map.setCenter(new GLatLng(lat,lon),11);
 	     		//alert("hi");
 	     	        gmarkers[i].openInfoWindowHtml(htmls[i]);
 	     	}
 	     	function myclick1(center) {
 	 	     	//alert("myclick1");
 	     		map.setCenter(center,5);
 	     		//alert("hi");
 	     	        //gmarkers[i].openInfoWindowHtml(htmls[i]);
 	     	}
 	     	
 	     	
 	     	
	      	function createMarker(point,count,code,name,html1,lat,lon) {
				var cIcon = new GIcon();
				cIcon.image = 'images/mm_20_green.png';
				cIcon.shadow = 'images/mm_20_shadow.png';
				cIcon.iconSize = new GSize(12,20);
				cIcon.shadowSize = new GSize(22, 20);
				cIcon.iconAnchor = new GPoint(6, 20);
				cIcon.infoWindowAnchor = new GPoint(5, 1);
				markerOptions = { icon:cIcon};
				var marker = new GMarker(point,markerOptions);
		        GEvent.addListener(marker, "click", function() {

		        				        
		      
				        	
				map.setCenter(new GLatLng(lat,lon),9);
				
		        marker.openInfoWindowHtml(html1);
		        }); 
		      	//GEvent.addListener(marker, "mouseover", function() { 
				//map.setCenter(new GLatLng(lat,lon),9);
		       // marker.openInfoWindowHtml(html1);
		       // }); 
		     	gmarkers[i] = marker;
		        htmls[i] = html1;
		        var cc=code;
		        var nn=name;
		        //alert("count in Createmarker------>"+cou);
		     //side_bar_html += '<td align="left"><a href="javascript:myclick(' + i + ','+lat+','+lon+')" onclick="toggleDetails('+count+',true);" onmouseover="myclick(' + i + ','+lat+','+lon+');" title="Click To See the Reports" >'+name+'</a><br><div class="popup" id="popup'+count+'"><table border="1" bgcolor="white"><tr><td><input type=button name=bb class=formElementD value=Edit Record></td></tr><tr><td> <a href="javascript:getValue('+lat+','+lon+')" onclick="showhide2('+count+',true);" title="Click To Edit the Reports" >Delete Record </a></td></tr><tr><td> <a href="javascript:toggleDetails('+count+',false);">Close </a></td></tr></table></div></td></tr>';
		        		side_bar_html += '<td align="left"><a href="javascript:myclick(' + i + ','+lat+','+lon+')" onclick="toggleDetails('+count+',true);" onmouseover="myclick(' + i + ','+lat+','+lon+');" title="Click To See the Reports" >'+name+'</a><br><div class="popup" id="popup'+count+'"><table border="1" bgcolor="white"><tr><td><a href="javascript:getValue('+lat+','+lon+')" onclick="showhide2('+count+',true);" title="Click To Edit Record" >Edit Record </a></td></tr><tr><td> <a href="javascript:getValue('+lat+','+lon+')" onclick="showhide3('+count+',true);" title="Click To Edit the Reports" >Delete Record </a></td></tr><tr><td> <a href="javascript:toggleDetails('+count+',false);">Close </a></td></tr></table></div></td></tr>';
		        		//alert("Side Bar------>"+side_bar_html);
		        //side_bar_html += '<td align="left"><a href="javascript:myclick(' + i + ','+lat+','+lon+')" onclick="toggleDetails('+count+',true);" onmouseover="myclick(' + i + ','+lat+','+lon+');" title="Click To See the Reports" >'+name+'</a><br><div class="popup" id="popup'+count+'"><table border="1" bgcolor="white"><tr><td><a href="getallatlong2.jsp?WareHouseCode='+code+'&name=edit" onclick="toggleDetails1('+count+',false);">Edit Record </a></td></tr><tr><td> <a href="" onclick="toggleDetails1('+count+',false);">Delete Record </a></td></tr><tr><td> <a href="javascript:toggleDetails('+count+',false);">Close </a></td></tr></table></div></td></tr>';
		        //side_bar_html += '<td align="left"><a href="javascript:myclick(' + i + ','+lat+','+lon+')" onclick="toggleDetails('+count+',true);" onmouseover="myclick(' + i + ','+lat+','+lon+');" title="Click To See the Reports" >'+name+'</a><br><div class="popup" id="popup'+count+'"><table border="1" bgcolor="white"><tr><td><a href="" onclick="toggleDetails1('+count+',false);">Edit Record </a></td></tr><tr><td> <a href="" onclick="toggleDetails1('+count+',false);">Delete Record </a></td></tr><tr><td> <a href="javascript:toggleDetails('+count+',false);">Close </a></td></tr></table></div></td></tr>';
		        //side_bar_html += '<td><a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" title="Click To See the Reports" >'+name+'</a><br><div class="popup" id="popupx'+i+'"><table border="1" bgcolor="white"><tr><td><a href="deleterecord.jsp?whcode='+code+'&pg=st" onclick="toggleDetails1('+i+',false);">Edit Record </a></td></tr><tr><td> <a href="deleterecord.jsp?whcode='+code+'&pg=st" onclick="toggleDetails1('+i+',false);">Delete Record </a></td></tr><tr><td> <a href="javascript:toggleDetails1('+i+',false);">Close </a></td></tr></table></td></tr>';
		        //side_bar_html += '<td><a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" title="">'+name+'</a><a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" title="" href="javascript:toggleDetails1('+i+',true);" title="Click To See the Reports">'+name+'</a><br></td></tr>';
		     	//combo +='<option value="+i+" onClick="javascript:myclick(' + i + ','+lat+','+lon+')" >'+name+'</option>';
		     	//side_bar_html += '<td align="left"><a href="javascript:myclick(' + i + ','+lat+','+lon+')" onclick="toggleDetails('+count+',true);" onmouseover="myclick(' + i + ','+lat+','+lon+');" title="Click To See the Reports" >'+name+'</a><br><div class="popup" id="popup'+count+'"><table border="1" bgcolor="white"><tr><td><input type=button name=bb class=formElementD name="edit" id="editid" value=Edit Record onClick="showhide2();"></td></tr><tr><td> <a href="javascript:getValue('+lat+','+lon+')" onclick="showhide2('+count+',true);" title="Click To Edit the Reports" >Delete Record </a></td></tr><tr><td> <a href="javascript:toggleDetails('+count+',false);">Close </a></td></tr></table></div></td></tr>';
		    	i++;
		        return marker;
		 }
<%
try
{
	//********************Veriable from getGetLocUpdate*******************//
	String flag=request.getParameter("flag");
	//System.out.println("flag"+flag);
	//System.out.println("-- flag --"+flag);
	if(flag!=null && flag.equalsIgnoreCase("true"))
    {
		%>
		alert("Record Successfully Updated.");
		<%
    }
	else if(flag!=null && flag.equalsIgnoreCase("false"))
	{	
		%>
		alert("Please do some changes in fields...!");
		<%
	}
	
	//****************variable from delete page************//
	String flag1=request.getParameter("flag1");
	//System.out.println("-- flag1 --"+flag1);
	if(flag1!=null && flag1.equalsIgnoreCase("true"))
    {
		%>
		alert("Record Successfully Deleted.");
		<%
    }
	else if(flag1!=null && flag1.equalsIgnoreCase("false"))
	{	
		%>
		alert("Please select the record to be deleted...");
		<%
	}
	//****************variable from delete page************//
	String flag2=request.getParameter("flag2");
	//System.out.println("-- flag2 --"+flag2);
	if(flag2!=null && flag2.equalsIgnoreCase("true"))
    {
		%>
		alert("Record is successfully Added.");
		<%
    }
	else if(flag2!=null && flag2.equalsIgnoreCase("false"))
	{	
		%>
		alert("Same record is already present.Please enter diffrent values." );
		<%
	}
	//******************//	
	String otherflag=request.getParameter("otherflag");
	if(otherflag!=null && otherflag.equalsIgnoreCase("true"))
    {
		%>
		alert("Record is already Present.");
		<%
    }
	
	String wareHouseCode="-",wareHouse="-",owner="-",html1=null,wtype="-";
	if(OwnerName != null)
	{
	sql="select WareHouseCode,WareHouse,Owner,Latitude,Longitude,WType from t_warehousedata where Owner ='Castrol' group by WareHouseCode order by WareHouse ";
	 rst=st.executeQuery(sql);
	%>
	side_bar_html += '<table border="0" class="sortable"><tr><td>Click</td><td>Sr No.</td><td>Location Code</td><td>Location Name</td>';
	
	<%int sr=0;	
	while(rst.next())
	{
		count++;
		sr++;
		wareHouseCode=rst.getString("WareHouseCode");
		wareHouse=rst.getString("WareHouse");
		owner=rst.getString("Owner");
		lat=rst.getDouble("Latitude");
		lon=rst.getDouble("Longitude");
		wtype=rst.getString("WType");
		html1="<b>GeoFence</b><br>wareHouse-"+wareHouse+" owner-"+owner;
%>
		//side_bar_html += '<input type="radio" id="pra" name="pra" value="< %=wareHouse%>" onclick="get_radio_value(this,\'< %=wareHouseCode%>\',\'< %=wtype%>\')">';

		side_bar_html += '<tr><td><input type="radio" id="pra" name="pra" value="<%=wareHouse%>" onclick="get_radio_value(this,\'<%=wareHouseCode%>\',\'<%=wtype%>\')"></td><td><%=sr%></td><td align="left"><%=wareHouseCode%></td>';
 		var point = new GLatLng(<%= lat%>,<%= lon%>);
		var marker = createMarker(point,"<%=count%>","<%=wareHouseCode%>","<%=wareHouse%>","<div class='bodyText'><%=html1%></div>",<%= lat%>,<%= lon%>);
		map.addOverlay(marker);
<%
	} 
%>
		document.getElementById("side_bar").innerHTML = side_bar_html;
<%
}//end of if
}catch(Exception ex)
{
	%> alert("Exception --><%=ex%>"); <%
}
finally
{
	//conn.close();
}
%>
 }
     //]]>
    </script>
  
</body>

<% fleetview.closeConnection(); %>
			
<%@ include file="footernew.jsp" %>
