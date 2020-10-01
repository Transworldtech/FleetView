<%@ include file="headernew.jsp" %>
 <%@page import="com.fleetview.beans.classes"%>
 <%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader ("Expires", 0);
%>
<%!
		Connection conn;
		Statement st,st1;
%>
<%
classes fleetview= new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//Class.forName("org.gjt.mm.mysql.Driver");
conn = fleetview.ReturnConnection();;
 st = conn.createStatement();
 st1 = conn.createStatement();
%>
<script type="text/javascript">
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

<script>
function get_radio_value(radioobject,warecode,wtype)
{
	//alert('hi');
	//alert(wtype);
//we are chaking dynamically values
	if(!radioobject)
		return "";
	var radiolength=radioobject.lenght;
	
	if(radiolength==undefined)
	{
		if(radioobject.checked)
		{
			myname=radioobject.value;
			document.getElementById("geo").value=myname;
			document.getElementById("geo1").value=warecode;
			document.getElementById("oldgeo").value=myname;
			document.getElementById("oldgeo1").value=warecode;
			document.getElementById("WType").value=wtype;
			document.getElementById("oldwtype").value=wtype;
		}
	else{
         return false;
         }
			//alert('bbye');
	}
}

function update()
{
	//alert('in side update ');
	
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
	document.form1.action="getGeoLocUpdate.jsp?loc="+loc+"&loc1="+loc1+"&oldloc="+oldloc+"&oldloc1="+oldloc1+"&wtype="+wtype+"&oldwtype="+oldwtype; //+"&wtype="+wtype;
	document.form1.submit();	
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
	document.form1.action="getGeoLocDel.jsp?loc="+loc+"&loc1="+loc1+"&oldloc="+oldloc+"&oldloc1="+oldloc1+"&wtype="+wtype+"&oldwtype="+oldwtype;
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
	if((lati==null)||(lati=="") || (langi==null)||(langi==""))
	{
		alert("To Geofence the location please drag the red baloon then fill the details..!!!");
		return 0;
	}
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
	document.form1.action="getGeoLocAdd.jsp?lati="+lati+"&langi="+langi+"&warehouse="+warehouse+"&warehousecode="+warehousecode+"&WType="+WType1;
	document.form1.submit();
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
			
			<font  size="3" ><b>All Geofence Locations on Map</b></font></td>
			</tr>
</table>
<%
String OwnerName = "",fwUser="";
 fwUser = (String) session.getAttribute("user");
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
<tr><th colspan="1">All Loacations for <%=OwnerName %></th></tr>
<% }else{ %>
<tr><th colspan="1">All Loacations</th></tr>
<% }%>
</table>
           <!-- =========== side_bar with scroll bar ================= -->
 
<div id="side_bar"  style="overflow:auto; height:390px;" align="left" ></div>
           <!-- ===================================================== -->	
	
</td>
<td  valign="top">
       <div id="map" style="width: 800px; height: 400px"></div>
</td>
      </tr>  
</table>

<!--// Code for edit and  delete an update -->

<table  border="1" bgcolor="white">
<tr><td ><div id="map" style="width: 980px; height: 6px"></div></td></tr><tr>
<td valign="top">
<table class="stats" >
<form action="addwaypoint.jsp" name="form1" method="post" >
<tr>
	<td colspan="2" class="hed">Update Or Delete Geofence Locations<br>(Select location to Update or Delete)</td>
	<td colspan="2" class="hed">Add New Geofence Location<br>(Drag baloon to any location to add Location)</td>
</tr>
<tr>
	<td >Location Name :</td>
	<td ><input type="text" name="geo" id="geo" ></td>
	<td>New Geofence Location :</td>
	<td><input type="text" name="add" id="add" ></td>
</tr>
<tr>
	<td >Location Code :</td>
	<td ><input type="text" name="geo1" id="geo1"  ><input type="hidden" name="oldgeo" id="oldgeo" ><input type="hidden" name="oldgeo1" id="oldgeo1" >
	</td>
	<td>Geofence Location Code :</td>
	<td><input type="text" name="addcode" id="addcode" ></td>
</tr>
<tr>
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
		</select> <input type="hidden" name="oldwtype" id="oldwtype"></td>
	
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
<tr><td><td ><input type="button" name="btn1" id="btn1" value="Update" onclick="update();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btn2" id="btn2" value="Delete" onclick="del();"></td></td><td></td><td><input type="button" name="btn3" id="btn3" value="Add Geofence Location" onclick="geoAdd();"><input type="hidden" name="lati" id="lati" class="formElement" readonly><input type="hidden" name="langi" id="langi" class="formElement" readonly>
	</td>		
</tr>
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

 			  var center = new GLatLng(18.80,80.1);
				
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

			lstner = GEvent.addListener(map, 'click', function(overlay, point){
			//document.form1.lati.value=point.y;
			//document.form1.langi.value=point.x;
			 	});
 			
 	     	function myclick(i,lat, lon) {
 	     		map.setCenter(new GLatLng(lat,lon));
 	     	        gmarkers[i].openInfoWindowHtml(htmls[i]);
 	     	}
	      	function createMarker(point,name,html1,lat,lon) {
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
		        side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" title="">'+name+'</a><br>';
		     	//combo +='<option value="+i+" onClick="javascript:myclick(' + i + ','+lat+','+lon+')" >'+name+'</option>';
		    	i++;
		        return marker;
		 }
<%
try
{
	//********************Veriable from getGetLocUpdate*******************//
	String flag=request.getParameter("flag");
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
	sql="select WareHouseCode,WareHouse,Owner,Latitude,Longitude,WType from t_warehousedata where Owner like '"+ OwnerName +"' order by WareHouse ";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		wareHouseCode=rst.getString("WareHouseCode");
		wareHouse=rst.getString("WareHouse");
		owner=rst.getString("Owner");
		lat=rst.getDouble("Latitude");
		lon=rst.getDouble("Longitude");
		wtype=rst.getString("WType");
		html1="<b>GeoFence</b><br>wareHouse-"+wareHouse+" owner-"+owner;
%>
		side_bar_html += '<input type="radio" id="pra" name="pra" value="<%=wareHouse%>" onclick="get_radio_value(this,\'<%=wareHouseCode%>\',\'<%=wtype%>\')">';
 		var point = new GLatLng(<%= lat%>,<%= lon%>);
		var marker = createMarker(point,"<%=wareHouse%>","<div class='bodyText'><%=html1%></div>",<%= lat%>,<%= lon%>);
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
    </form>

</body>
</table>
<% fleetview.closeConnection(); %>
			
<%@ include file="footernew.jsp" %>
