<%@ include file="headernew.jsp" %>
 <%@page import="com.fleetview.beans.classes"%>
 <%
classes fleetview=new classes(); 
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
System.out.println("in the geofence paeg");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

%>

<%@page import="com.fleetview.beans.classes"%>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>OpenLayers MapGuide Layer Example</title>
    <link rel="stylesheet" href="../theme/default/style.css" type="text/css">
    <link rel="stylesheet" href="style.css" type="text/css">

    <style type="text/css">
        #map {
            width: 100%;
            height: 800px;
            border: 1px solid black;
            float:left;
        }
        #map2 {
            width: 400px;
            height: 400px;
            border: 1px solid black;
            float:left;
        }
    </style>
  <script src="OpenLayers-2.10/OpenLayers.js"></script>
    <script type="text/javascript" src="OpenLayers-2.10/binaryajax.js"></script>
<script type="text/javascript" src="OpenLayers-2.10/binarywrapper.js"></script>
<script type="text/javascript" src="OpenLayers-2.10/shapefile.js"></script>
<script type="text/javascript" src="OpenLayers-2.10/dbf.js"></script>
<script src="elabel.js" type="text/javascript"></script>
  
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
    </head>
    <body>
    <%!
		Connection conn;
		Statement st,st1,st2,st3,stgeo,stlogo;
%>
<%
//Class.forName("org.gjt.mm.mysql.Driver");
String wareHouseCode="-",wareHouse="-",owner="-",html1=null,wtype="-",PolygonCoordinates="-",fwUser="",selecteduser="";//,rad="";
conn = fleetview.ReturnConnection();
 st = conn.createStatement();
 st1 = conn.createStatement();
 st2 = conn.createStatement();
 st3 = conn.createStatement();
 stgeo = conn.createStatement();
 stlogo = conn.createStatement();
 String smap="",smap1="",geoname="",geotrans="",logoname="",logotrans="";
 
%>
    <%
String rfname=session.getAttribute("rfname").toString(); //user name  //.setAttribute("rfname",fnamelist);
String rlname=session.getAttribute("rlname").toString();
//System.out.println("31 firstname "+rfname+ "lastname " +rlname);
	selecteduser= (String) session.getAttribute("selecteduser");
	fwUser = (String) session.getAttribute("user");
	
	String name=(String)session.getAttribute("mainuser");
	System.out.println("name "+name);
	//session.setAttribute("selecteduser1",selecteduser);
	//System.out.println("34 selecteduser "+selecteduser+ "fwUser " +fwUser);	
	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	String Date = fmt.format(new java.util.Date());
	String Date1=fmt.format(new java.util.Date());
	String Date2=fmt.format(new java.util.Date());
	//System.out.println("37" +Date);
//out.println(fwUser);
	String sqlgeoinfo="select * from db_gps.t_geouserinfo where Transporter ='"+selecteduser+"' and Status='Yes'";
	//System.out.println("38 sqlgeoinfo "+sqlgeoinfo);
	ResultSet rstgeo=stgeo.executeQuery(sqlgeoinfo);
	System.out.println("Query no 1"+sqlgeoinfo);
	if(rstgeo.next())
	{
		geoname="Yes";
	}
	
	String sqllogo="select * from db_gps.t_logouserinfo where Transporter ='"+selecteduser+"' and Status='Yes'";
	//System.out.println("46 sqllogo "+sqllogo);
	ResultSet rstlogo=stlogo.executeQuery(sqllogo);
	System.out.println("Query no 2"+sqlgeoinfo);
	if(rstlogo.next())
	{
		//logoname=rstlogo.getString("User");
		logotrans=rstlogo.getString("Transporter");
	}
/*	System.out.println("--->"+selecteduser);
	System.out.println("--->"+sqlgeoinfo);
	System.out.println("--->"+sqllogo);*/
	/*String strown="Select * from t_security where Username='"+fwUser1+"' limit 1";
		
	ResultSet rstown = st3.executeQuery(strown);
	if(rstown.next())
	{
		 fwUser = rstown.getString("FullName");
	}*/
	String savedCoordiantes = "";
	String getCordiantesSql = "Select * from t_warehousedata where Owner='"+ selecteduser+"' and Latitude <> '0' and Longitude <> '0' and MarkerType='Poly'";
	//System.out.println("65 getCordiantesSql "+getCordiantesSql);
	String getCordiantesSql1 = "Select * from t_warehousedata where Owner='"+ selecteduser+"' and Latitude <> '0' and Longitude <> '0' and MarkerType='Point'";
	//System.out.println("67 getCordiantesSql1-->"+getCordiantesSql1);
	ResultSet rs2 = st2.executeQuery(getCordiantesSql);
	System.out.println("Query no 3 or 4"+getCordiantesSql);
	ResultSet rs22 = st3.executeQuery(getCordiantesSql1);
	System.out.println("Query no 3 or 4"+getCordiantesSql);
	//System.out.println("Hii");
%>

<%
    String polygonCordinate = (String) request.getParameter("cordonatestoasave");
if(polygonCordinate !=null && !polygonCordinate.equals(""))
{
	 //System.out.println("81 Hii");
	 StringTokenizer tokenizer = new StringTokenizer(polygonCordinate,",");
     StringBuffer polygonSql = new StringBuffer("insert into t_warehousedata (WareHouseCode,WareHouse,Owner,Transporter,Latitude,SLatitude,ELatitude,Longitude,SLongitude,ELongitude,WType,Location,EntBy,UpdatedDate,g) values (,,,,,,,,,,,,,,PolygonFromText('POLYGON((" );        
     int cntr=1;
     int tokens = tokenizer.countTokens();
     while (tokenizer.hasMoreElements()) 
     {
    	 System.out.println("88 Hii");
         String object = (String) tokenizer.nextElement();            
         if(cntr%2 == 0)
         {            
             polygonSql.append(object +" ");
             if(cntr != tokens)
                 polygonSql.append(",");
         }
         else
             polygonSql.append(object +" ");
         cntr++;
     }            
     polygonSql.append("))')");  
     
%>
<%=polygonSql%>
<% }%>
    
    <table border="1" class="stats" align="center" >
<tr>
<td colspan="3">
<table width="100%" align="center" class="stats" >
			<tr>
			<td align="center">
			<font  size="3" ><b>All Geofence Locations on Map</b></font></td>
			</tr>
</table>


<%
//System.out.println("2111 Hii");
String OwnerName = "";
fwUser = (String) session.getAttribute("user");
//System.out.println("--user---->>"+fwUser);
selecteduser = (String) session.getAttribute("selecteduser");
System.out.println("selecteduser "+selecteduser);
if (! session.isNew()) 
	OwnerName = (String) session.getAttribute("usertypevalue");
    System.out.println("OwnerName "+OwnerName);
if (null == OwnerName) 
	{
		response.sendRedirect("index.html");
		return;
	}

//String =request.getParameter("owner");
String sql=null;
String lat="18.80",lon="80.1";
String VehRegNo="select";
Statement stveh;
stveh=conn.createStatement();
String vehcode=(String)session.getAttribute("VehList");
System.out.println(vehcode);
vehcode=vehcode.replace(",","','");
vehcode=vehcode.replace("(","");
vehcode=vehcode.replace(")","");
%>
</td>
</tr>
<%
//if(geoname.equalsIgnoreCase("Yes"))
//{ %>
<tr>
<td>
<div align="left"><input type="button" value="Start Geofencing" onclick="changevale();"  id="stg"  >
&nbsp;&nbsp;
<a href="#" onclick="showhide1();" id="tdx" style="display: none">ADD</a>
&nbsp;&nbsp;
<a href="#" onclick="showhide2();" id="tdy" style="display: none">EDIT</a>
&nbsp;&nbsp;
<a href="#" onclick="showhide3();" id="tdz" style="display: none">DELETE</a>
&nbsp;&nbsp;
<div id="trtyp" style="display: none">
<input type="radio" value="Map" id="trk" class="" name="trk" onclick="changevale3('Map')">Map
<input type="radio" value="DetailReport" id="trk" class="" name="trk" onclick="changevale4()">Detail Report
</div>
<input type="hidden" name="lati" id="lati" class="formElement" readonly>
<input type="hidden" name="langi" id="langi" class="formElement" readonly>
<input type="hidden" name="oldgeo" id="oldgeo" value="">
<input type="hidden" name="oldgeo1" id="oldgeo1" value="">
<input type="hidden" name="oldwtype" id="oldwtype" value="">
<!-- <input type="hidden" name="radius" id="radius" value="">-->
<br>
<div id="tradd" name="tradd" style="display: none;"><a href="#" onclick="addgeo();">add as a geofenced location..</a></div>
</div></td>
<td align="left" id=tr1 style="display: none"><font size="3"><b>Please set 1 km zoom level to geofence the location.</b></font></td>
</tr>
<%
//} 
%>
<tr>
<td width="30%" valign="topo"><table width="100%" border="1" valign="top" class="stats">
<% if(OwnerName!=null)
{%>


<tr><th colspan="1">All Locations for <%=OwnerName %></th></tr>
<% }else{ %>  
<tr><th colspan="1">All Locations</th></tr>
<%} %> 
</table>

<!-- =========== side_bar with scroll bar ================= -->

<div id="side_bar"  style="overflow:scroll; height:450px;" align="left" ></div>

           <!-- ===================================================== -->	
           </td>





<td  valign="topo">
<input type="hidden" id="map1" name="map1">
       <div id="map" style="width: 800px; height: 450px;position: relative;" ></div>
</td>
</tr>  
</table>

<script>


function addgeo()
{
	try
	{
	//alert("88888");
 
var myPoint = new OpenLayers.Geometry.Point(tmarkers.features[0].geometry.getVertices()[0].x,
		tmarkers.features[0].geometry.getVertices()[0].y )
        var myLatLonPoint = myPoint.transform( map1.getProjectionObject(),
                new OpenLayers.Projection("EPSG:4326"));

      var lon = myLatLonPoint.getVertices()[0].x;	
      var lat = myLatLonPoint.getVertices()[0].y;
 alert("lat   "+lat+ " \n lon   "+lon);

 testwindow1 = window.open("geoAddForm.jsp?lati="+lat+"&langi="+lon+"&fpage1=getalllatlong1.jsp", "AddGeofence", "width=500,height=280");
    testwindow1.moveTo(500,250);
    testwindow1.focus();

	if(null!=tmarkers)
	{
		map1.removeLayer(tmarkers);
		
		 tmarkers = null;
	}
      
	
	}
	catch(e)
	{
		alert(e);
	}
}

function Reload()
{
	//alert("Hej");  
    window.location.reload(); 
}

var map1,layer1,layer,markers1;
var tmarkers = null;

var side_bar_html = "<table border=1 align=center width=40% class='sortable' ><tr><td align=center style=background-color:#9db5e5><b>Location Name</b></td><td align=center style=background-color:#9db5e5><b>Location Code</b></td><td align=center style=background-color:#9db5e5><b>Location Type</b></td></tr>";
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
	var vectors
	
var url = "http://203.199.134.131:8008/mapguide/mapagent/mapagent.fcgi?USERNAME=Administrator&PASSWORD=admin";


	function myclick(i,lat, lon) {
     
		map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		        map1.getProjectionObject() // to Spherical Mercator Projection
		      ),20);
	
	}
	
function changevale4()
{
	//alert("in detail report");
try{
	if(null!=tmarkers)
	{
		map1.removeLayer(tmarkers);
		
		 tmarkers = null;
	}
	document.getElementById("tr1").style.display="none";
	var lat=document.getElementById("lati").value;
	var lon=document.getElementById("langi").value;

	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
	        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
	        map1.getProjectionObject() // to Spherical Mercator Projection
	      ),2);
	
	//map.setCenter(new GLatLng(lat,lon),5);
	//gmarker="";
	testwindow = window.open("geocustomDetailReport.jsp", "CustomReport", "width=750,height=600,scrollbars=yes");
	testwindow.focus();
    testwindow.moveTo(500,250);
	}catch(e)
	{alert(e);
	}
}

function openadd()
{
	try
	{
	var lat=document.getElementById("lati").value;
	var lon=document.getElementById("langi").value;

	testwindow1 = window.open("geoAddForm.jsp?lati="+lat+"&langi="+lon+"&fpage1=getalllatlong1.jsp", "AddGeofence", "width=500,height=280");
    testwindow1.moveTo(500,250);
    testwindow1.focus();

	if(null!=tmarkers)
	{
		map1.removeLayer(tmarkers);
		
		 tmarkers = null;
	}
    
	}
	catch(e)
	{
		//alert(e);
	}
}

function changevale2()
{
	try
	{
	var tra,trb,trc,trd,tri;//trtbl;
	var pt,ply;
	var size = new OpenLayers.Size(25,25);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
    
    
		var lat1=document.getElementById("lati").value;
		var long1=document.getElementById("langi").value;
		
		// var center = new GLatLng(lat1,long1);
		/*map1.setCenter(new OpenLayers.LonLat(long1,lat1).transform(
	        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
	        map1.getProjectionObject() // to Spherical Mercator Projection
	      ),2);
		
		//var marker100 = new GMarker(center,{draggable: true});
		//alert("long1 "+long1+" lat1 "+lat1);
		cIcon= new OpenLayers.Icon('images/red-dot.png', size, offset);

    		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(long1,lat1).transform(
		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		              map1.getProjectionObject() // to Spherical Mercator Projection
		            ),cIcon);*/
        
		//alert("drag");
		   /* GEvent.addListener(marker100, "dragstart", function() {
		      map.closeInfoWindow();
		    });
         
		    GEvent.addListener(marker100, "dragend", function() {
			    var zoomlevel1=document.getElementById("map1").value
			  if(zoomlevel1>=14)
			  {
				  marker100.openInfoWindowHtml("Just bouncing along...<br><a href='javascript:openadd()'>Geofence this location</a>");
			  }
			  else
			  {
     	      marker100.openInfoWindowHtml("Just bouncing along...");
			  }
		      var latlong=marker100.getPoint();
		      var lat=latlong.lat();
		      var longi=latlong.lng();
		  
		      document.getElementById("lati").value=lat;
			 document.getElementById("langi").value=longi;
		    });
            if(gmarker==null)
            {
                gmarker=marker100;
		    map.addOverlay(marker100);
            }
	
         */
        // alert("888888888   "+tmarker);

         vectors = new OpenLayers.Layer.Vector("Vector Layer",{
             styleMap: new OpenLayers.StyleMap({
             externalGraphic: "images/red-dot.png",
             graphicOpacity: 1.0,
             graphicWith: 16,
             graphicHeight: 26,
             graphicYOffset: -26
         })
             });
         
         point = new OpenLayers.Geometry.Point(77.768553,23.402765);
         vectors.addFeatures([new OpenLayers.Feature.Vector(point)]);
       

         var drag=new OpenLayers.Control.DragFeature(vectors);

         map1.addControl(drag);
         drag.activate();

		
         
        if(tmarkers==null)
         {
    		map1.addLayer(vectors);
	   	    tmarkers =    vectors;	    
         }


        
       
	}
	catch(e)
	{
		alert(e);
	}
}

function getlatlong()
{
	alert("eeee");
}

function changevale3(typ)
{
	//alert("Hii");
	try
	{
	var show1,tre,trn,trf,trg,trh,trj,tro;
	var typ=document.getElementById("trk").value;
	if(typ=="Map")
	{
		document.getElementById("tr1").style.display="";	
	    changevale2();  
	}
	}catch(e)
	{
		
	}
	
}

function showhide3()
{
	try{
		
		var count=0;
		var elems=document.getElementsByName("trk");
		for(var i=0;i<elems.length;i++)
		{
			elems[i].checked=false;
		}
		//document.getElementById("trk").checked=false;
		document.getElementById("tr1").style.display="none";
		document.getElementById("trtyp").style.display="none";
	var oldgeo=document.getElementById("oldgeo").value;
	var oldgeo1=document.getElementById("oldgeo1").value;
	var oldwtype=document.getElementById("oldwtype").value;
	if(null!=tmarkers)
	{
		map1.removeLayer(tmarkers);
		
		 tmarkers = null;
	}
	var elems1=document.getElementsByName("pra");
	for(var i=0;i<elems1.length;i++)
	{
		if(elems1[i].checked==true)
		{
			count=count+1;
		}
	}
	//alert(count);
var lat=document.getElementById("lati").value;
		var lon=document.getElementById("langi").value;
		map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		        map1.getProjectionObject() // to Spherical Mercator Projection
		      ),2);
	if(count>0)
	{
	testwindow = window.open("geoDeleteForm.jsp?oldloc="+oldgeo+"&oldloc1="+oldgeo1+"&oldwtype="+oldwtype,"DeleteGeofence","width=450,height=250");
    testwindow.moveTo(500,250);	
	}
	else
	{
		alert("Please select the location name.........!");
	}
	}catch(e)
	{//alert(e);
	}
}


function showhide2()
{
	
	//alert("in edit");
	var count=0;
	
	var elems=document.getElementsByName("trk");
		for(var i=0;i<elems.length;i++)
		{
			elems[i].checked=false;
		}
		document.getElementById("tr1").style.display="none";
		//document.getElementById("trk").checked=false;
		document.getElementById("trtyp").style.display="none";
	var oldgeo=document.getElementById("oldgeo").value;
	var oldgeo1=document.getElementById("oldgeo1").value;
	var oldwtype=document.getElementById("oldwtype").value;
	//var rad=document.getElementById("radius").value;
	if(null!=tmarkers)
	{
		map1.removeLayer(tmarkers);
		
		 tmarkers = null;
	}
	
	var elems1=document.getElementsByName("pra");
	for(var i=0;i<elems1.length;i++)
	{
		if(elems1[i].checked==true)
		{
			count=count+1;
		}
	}
	
	var lat=document.getElementById("lati").value;
	var lon=document.getElementById("langi").value;
	map1.setCenter(new OpenLayers.LonLat(77.768553,23.402765).transform(
		     new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		     map1.getProjectionObject() // to Spherical Mercator Projection
		   ),2);
	//alert("geo "+oldgeo+" geo1 "+oldgeo1+" wtype "+oldwtype);
	if(count>0)
	{
		
		testwindow = window.open("geoUpdateForm.jsp?oldloc="+oldgeo+"&oldloc1="+oldgeo1+"&oldwtype="+oldwtype, "UpdateGeofence", "width=500,height=280");//&rad="+rad
    testwindow.moveTo(500,250);	
	}
	else
	{
		alert("Please select the location name.........!");
	}
	
}

function showhide1()
{
	try
	{
	
	var trtyp,tre,trn,trf,trg,trh,trj,tro;
	//var tds=document.getElementById("tdx").value;
/*	if(tds=="ADD")
	{			*/   
	var elems=document.getElementsByName("trk");
	           for(var i=0;i<elems.length;i++)
		      {
		    	elems[i].checked=false;
		       }
	    
	        trtyp=document.getElementById("trtyp");
            trtyp.style.display='';
            
        	if(null!=tmarkers)
    		{
    			map1.removeLayer(tmarkers);
    			
    			 tmarkers = null;
    		}

        	var elems1=document.getElementsByName("pra");
			for(var i=0;i<elems1.length;i++)
			{
				elems1[i].checked=false;
			}
    		
			var lat=document.getElementById("lati").value;
			var lon=document.getElementById("langi").value;
			

			map1.setCenter(new OpenLayers.LonLat(77.768553,23.402765).transform(
				     new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
				     map1.getProjectionObject() // to Spherical Mercator Projection
				   ),2);
		 document.getElementById("tr1").style.display="none";
          
		  
	   }catch(e)
		{//alert(e);
		}
}

function changevale()
{
	
	var trgeo,Date2;
	var ply;
	var stg=document.getElementById("stg").value;
	if(stg=="Start Geofencing")
	{
		document.getElementById("tdx").style.display="";
		document.getElementById("tdy").style.display="";
		document.getElementById("tdz").style.display="";
		document.getElementById("stg").value="Cancel Geofencing";
		document.getElementById("tr1").style.display="none";
	}
	else
		if(stg=="Cancel Geofencing")
	{	
		document.getElementById("tr1").style.display="none";
		document.getElementById("tdx").style.display="none";
		document.getElementById("tdy").style.display="none";
		document.getElementById("tdz").style.display="none";
		var elems=document.getElementsByName("trk");
		for(var i=0;i<elems.length;i++)
		{
			elems[i].checked=false;
		}
		
		document.getElementById("trtyp").style.display="none";

		var elems1=document.getElementsByName("pra");
		for(var i=0;i<elems1.length;i++)
		{
			elems1[i].checked=false;
		}	
		if(null!=tmarkers)
		{
			map1.removeLayer(tmarkers);
			
			 tmarkers = null;
		}
		var lat=document.getElementById("lati").value;
		var lon=document.getElementById("langi").value;
		//map.setCenter(new GLatLng(lat,lon),5);
		map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
			     new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
			     map1.getProjectionObject() // to Spherical Mercator Projection
			   ),2);
		
		document.getElementById("stg").value="Start Geofencing";
	}
		       
}

function myclick(i,lat, lon) {
 	
	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
		     new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		     map1.getProjectionObject() // to Spherical Mercator Projection
		   ),24);
	
}

function createMarker(name,html1,lat,lon) 
{
	try
	{
		//alert('in side create marker');
	var cIcon;
	var size = new OpenLayers.Size(12,20);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
	
	
	<%
	//if(selecteduser.equalsIgnoreCase("ashwinagarwal1@gmail.com")|| selecteduser.equalsIgnoreCase("vehicles.sslpl@gmail.com"))
	if(logotrans.equalsIgnoreCase("Safe And Secure"))
	{
	//	System.out.println("In Logo Loop");
		%>
		cIcon= new OpenLayers.Icon('images/KraftFood.png', size, offset);
		//cIcon.image = 'images/KraftFood.png';
		<%
	}
	else
	{
		
		%>
		cIcon= new OpenLayers.Icon('images/mm_20_green.png', size, offset);
		
	    <%	
	}
	%>
	
	var marker = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
            new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
            map1.getProjectionObject() // to Spherical Mercator Projection
          ),cIcon);

	marker.events.register('mousedown', marker, function(evt) { popup = new OpenLayers.Popup("olPopup",
      		new OpenLayers.LonLat(lon,lat).transform(
		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		              map1.getProjectionObject() // to Spherical Mercator Projection
		            ),
      		new OpenLayers.Size(250,100),
      		html1,
      		true);
    popup.closeOnMove = true; 
      		 map1.addPopup(popup);
          });
  
 	gmarkers[i] = marker;
    htmls[i] = html1;
    side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" title="">'+name+'</a><br></div></td>';
	
	i++;
   
	}
	catch(e)
	{
		alert(e);
	}
	 return marker;
}

function loadKML(url){
      try
      {
	  map1.addLayer(new OpenLayers.Layer.GML("KML",url, 
	          {
	           format: OpenLayers.Format.KML, 
	           formatOptions: 
	  	       {
	             extractStyles: true 
	           }
	          }));
      }
      catch(e)
      {
          alert("%%%%%%%%%%%%%%%"+e);
      }
  }

function getzoom()
{
	var zoom = map1.getZoom();

	if(tmarkers!=null)
	{
	if(zoom >= 20)
	{
		document.getElementById("tradd").style.display = "";
	}
	else
	{
		document.getElementById("tradd").style.display = "none";
	}
	}
	else
	{
		document.getElementById("tradd").style.display = "none";
	}
}

function get_radio_value(radioobject,warecode,wtype)//,rad
{
	
	if(!radioobject)
		return "";
	var radiolength=radioobject.lenght;
	
	if(radiolength==undefined)
	{
		if(radioobject.checked)
		{
			
			myname=radioobject.value;
			
			document.getElementById("oldgeo").value=myname;
			document.getElementById("oldgeo1").value=warecode;
		
			document.getElementById("oldwtype").value=wtype;
		
		}
	else{
         return false;
         }
			
	}
}

function initialize()
{
	try
	{
// 	alert("ketki");	
var metersPerUnit = 111319.4908;  //value returned from mapguide
var inPerUnit = OpenLayers.INCHES_PER_UNIT.m * metersPerUnit;

OpenLayers.INCHES_PER_UNIT["dd"] = inPerUnit;
OpenLayers.INCHES_PER_UNIT["degrees"] = inPerUnit;
OpenLayers.DOTS_PER_INCH = 72;
// alert("gawande");

document.getElementById("lati").value=23.402765;
document.getElementById("langi").value=77.768553;

//  var extent1 = new OpenLayers.Bounds(68.1623341674805,6.771473,97.4037974243164,37.064465);
var extent1 = new OpenLayers.Bounds(68.162834117480,6.7542559500000,97.41516105,37.06396505);


//var tempScales = [20000,10000,5794.74679,2826.95795,1894.95494,796.85673,327.59372,130.69773,100,50,25,12,6,3,2,1,0];
var tempScales = [23659291,17074442,11322961,7588641,5059094,3372729,2248486,1498990,999327,666218,444145,296096,197397,131598,87732,58488,38992,25994,17329,11553,7702,5134,3423,2282,1521,1041,676,450,300,0];
var mapOptions1 = {
maxExtent: extent1, 
scales:tempScales,
   units: "dd"
};
map1 = new OpenLayers.Map( 'map', mapOptions1 );
map1.addControl(new OpenLayers.Control.PanZoomBar());

map1.addControl(new OpenLayers.Control.OverviewMap());
map1.addControl(new OpenLayers.Control.KeyboardDefaults());



var params1 = {
	
mapdefinition: 'Library://TranswoldNew/test.MapDefinition',

	 basemaplayergroupname: "Base Layer Group"
	  }
	  var options1 = 
	  {
	    //singleTile: false 
		  singleTile: true, isBaseLayer: true,
	    transitionEffect: "resize",
	    buffer: 1,
	    useOverlay: false,
	    useAsyncOverlay: false
	  };


	  //layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
//layer1=new OpenLayers.Layer.OSM("Local Tiles","http://173.234.153.82/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19, 'attribution': false, "tileOptions": {"crossOriginKeyword": null}},params1, options1);
	//  layer1=new OpenLayers.Layer.OSM();
	<%

//map integrate
String sqlmap="select * from t_defaultvals where OwnerName='"+session.getAttribute("usertypevalue")+"'";
//String sqlmap="select * from t_defaultvals where OwnerName='Castrol'";
ResultSet rsmap=st1.executeQuery(sqlmap);
System.out.println("started journey querry--------->"  +sqlmap);
if(rsmap.next())
{
	smap=rsmap.getString("Map");
	System.out.println("Map"  +smap);
}
%>
<%
if(smap.equals("OSM"))
{
	System.out.println("Hi1");
%>
layer1=new OpenLayers.Layer.OSM("Local Tiles","http://maps.myfleetview.com/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19, attribution : '<a href="http://myfleetview.com/" style="text-decoration:none"><font face="Hemi Head 426" size="03" color="#0853A0">FleetView <br><font face="Hemi Head 426" size="0.5" color="#0853A0">Transworld Technologies Ltd.  </a>', "tileOptions": {"crossOriginKeyword": null}},params1, options1);
	
	<%
	System.out.println("Hi2");
}

	else if(smap.equals("MPG"))
	{
	%>
	
	layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	<%
    }
	
	else if(smap.equals(""))
	{
		System.out.println("No Data");
		String sqlmap1="select * from t_defaultvals where OwnerName='Default'";
		//String sqlmap="select * from t_defaultvals where OwnerName='Castrol'";
		ResultSet rsmap1=st1.executeQuery(sqlmap1);
		System.out.println("started journey querry--------->"  +sqlmap1);
		if(rsmap1.next())
		{
			smap1=rsmap1.getString("Map");
			System.out.println("Map"  +smap1);
		}
		if(smap1.equals("OSM"))
				{
			
			System.out.println("Hi1");
    %>
    layer1=new OpenLayers.Layer.OSM("Local Tiles","http://maps.myfleetview.com/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19, attribution : '<a href="http://myfleetview.com/" style="text-decoration:none"><font face="Hemi Head 426" size="03" color="#0853A0">FleetView <br><font face="Hemi Head 426" size="0.5" color="#0853A0">Transworld Technologies Ltd.  </a>', "tileOptions": {"crossOriginKeyword": null}},params1, options1);
	
	<%
		}
		else if(smap1.equals("MPG"))
		{
	System.out.println("Data1");
	%>
	
	layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	<%
		}
	}
    %>
	
	map1.addLayer(layer1);
//  loadKML("KML/test.kml");
loadKML("KMLJRM/TWIndiaBoundry.kml");

//vectorLayer = new OpenLayers.Layer.Vector("Vectors");
//map1.addLayer(vectorLayer);

	/*controls = {
			 drag: new OpenLayers.Control.DragFeature(markers1)

	};

	 controls.activate();*/
		
		
map1.setCenter(new OpenLayers.LonLat(77.768553,23.402765).transform(
     new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
     map1.getProjectionObject() // to Spherical Mercator Projection
   ),2);

map1.events.register('zoomend', map1,getzoom);

markers1 = new OpenLayers.Layer.Markers( "Markers");
map1.addLayer(markers1);
// alert("ketki Gawande");
<%
try
{
	//********************Veriable from getGetLocUpdate*******************//
	String Msg=request.getParameter("Msg");
	String flag=request.getParameter("flag");
	//System.out.println("-- flag --"+flag);
	if(flag!=null && flag.equalsIgnoreCase("true"))
    {
		%>
		alert("Record Successfully Updated.");
		<%
		flag=null;
    }
	else if(flag!=null && flag.equalsIgnoreCase("false"))
	{	
		%>
		alert("Please do some changes in fields...!");
		<%
	}
	else if(Msg!=null)
	{
		%>
		alert("The code already exist!! Please enter different code");
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
		flag1=null;
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
		flag2=null;
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
	      otherflag=null;
    }
	
	 StringBuffer polygonSql1 = new StringBuffer();
	 String dbLatitude ="17";
	 String dbLongitude="80";
	 int index = 0;
	if(OwnerName != null)
	{
	sql="select WareHouseCode,WareHouse,Owner,Latitude,Longitude,WType,PolygonCoordinates,Radius from t_warehousedata where Owner like '"+ OwnerName +"' and Latitude <> '0' and Longitude <> '0' order by WareHouse ";
	ResultSet rst=st.executeQuery(sql);
	System.out.println("QUERY WHICH M LOOKING FOR"+sql);
	while(rst.next())
	{
		wareHouseCode=rst.getString("WareHouseCode");
		wareHouse=rst.getString("WareHouse");
		owner=rst.getString("Owner");
		lat=rst.getString("Latitude");
		lon=rst.getString("Longitude");
		wtype=rst.getString("WType");
		//rad=rst.getString("Radius");
		PolygonCoordinates=rst.getString("PolygonCoordinates");
// 		System.out.println("WareHouseCode value"+wareHouseCode);
// 		System.out.println("WareHouse value"+wareHouseCode);
// 		System.out.println("WareHouse value"+wareHouseCode);
// 		System.out.println("WareHouse value"+wareHouseCode);
		
		System.out.println("WareHouse value"+wareHouseCode);
// 		System.out.println("WareHouse value"+wareHouseCode);
		System.out.println("wareHouseCode : "+wareHouseCode +" Lat : "+lat + " Long :"+lon + " PolygonCoordinates:::"+PolygonCoordinates );
		if(PolygonCoordinates == null)
		{
		dbLatitude = lat;
		dbLongitude= lon;
		}
				
		if(PolygonCoordinates !=null && !PolygonCoordinates.equals("") && !PolygonCoordinates.equals("-"))
                   {
			     System.out.println("inside if ");
			  	
                 StringTokenizer tokenizer = new StringTokenizer(PolygonCoordinates,",");                        
                 int cntr=1;
                 int tokens = tokenizer.countTokens();
                 System.out.println("Token value"+tokens);
                 while (tokenizer.hasMoreElements()) 
                  {
                	 System.out.println("in side while");
                     dbLatitude = (String) tokenizer.nextElement();                                                      
	 	    		 dbLongitude= (String) tokenizer.nextElement();
	 	    		 
	 	    		System.out.println("dbLatitude : "+dbLatitude);
	 	    		 
	 	    		 System.out.println("dbLongitude : "+dbLongitude);
	 	    		break;
              	 }  
               }
		
		html1="<b>GeoFence</b><br>Location Name- "+wareHouse+"<br>Location Code- "+wareHouseCode+"<br>Location Type- "+wtype+" <br>Owner- "+owner;
		
		System.out.println("value of wareHouse is"+wareHouse);
		System.out.println("value of wareHousecode is"+wareHouseCode);
		System.out.println("value of dbLatitude is"+dbLatitude);
		System.out.println("value of dbLongitude is"+dbLongitude);
	
%>
side_bar_html += '<tr><td><div align=left><input type="radio" id="pra" name="pra" value="<%=wareHouse%>" onclick="get_radio_value(this,\'<%=wareHouseCode%>\',\'<%=wtype%>\')">';//,\'< %=rad%>\'

 var marker<%=index+""%> = createMarker("<%=wareHouse%>","<div class='bodyText' align=left><%=html1%></div>",<%=dbLatitude%>,<%=dbLongitude%>);
markers1.addMarker(marker<%=index+""%>);
side_bar_html+='<td><div align=left><%=wareHouseCode%></div></td><td><div align=left><%=wtype%></div></td></tr>';
<%
}  index++;
//}}
//System.out.println(side_bar_html);
%>
side_bar_html+='</table>';
document.getElementById("side_bar").innerHTML = side_bar_html;
<%
}//end of if
}catch(Exception ex)
{
%> alert("Exception --><%=ex%>"); <%
}
finally
{
try
{
conn.close();
}catch(Exception e)
{}
try
{
fleetview.closeConnection();
}catch(Exception e)
{}
}
%>




	}
	catch(e)
	{
		alert(e);
	}
}

onload = function()
{
	document.getElementById("oldgeo").value="";
	document.getElementById("oldgeo1").value="";
	document.getElementById("oldwtype").value="";
	initialize();
};


</script>
</body>
</html>