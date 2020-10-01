<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<META HTTP-EQUIV="imagetoolbar" CONTENT="no">
<head>
    <title>Transworld Map </title>
    <%
    response.setHeader("Access-Control-Allow-Origin","*");
    %>
   
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" href="OpenLayers-2.10/style.css" type="text/css" />
   
    <!-- bring in the OpenLayers javascript library
         (here we bring it from the remote site, but you could
         easily serve up this javascript yourself) -->
    <script src="OpenLayers-2.10/OpenLayers.js"></script>
 
    <!-- bring in the OpenStreetMap OpenLayers layers.
         Using this hosted file will make sure we are kept up
         to date with any necessary changes -->
   <script src="OpenLayers-2.10/OpenStreetMap.js"></script>
 <link href="common/genomics.css" rel="StyleSheet" type="text/css"></link>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css"></link>
<link rel="stylesheet" type="text/css" href="css/update.css"></link>
    <script type="text/javascript">
// Start position for the map (hardcoded here for simplicity)
       var map, map1,layer1,layer;
    	var gmarkers = [];
    	var htmls = [];
    	var i=0;
    	var url = "http://203.199.134.131:8008/mapguide/mapagent/mapagent.fcgi?USERNAME=Administrator&PASSWORD=admin";
        //Initialise the 'map' object
        function init() {
 try
 {
        	var metersPerUnit = 111319.4908;  //value returned from mapguide
        	var inPerUnit = OpenLayers.INCHES_PER_UNIT.m * metersPerUnit;

        	OpenLayers.INCHES_PER_UNIT["dd"] = inPerUnit;
        	OpenLayers.INCHES_PER_UNIT["degrees"] = inPerUnit;
        	OpenLayers.DOTS_PER_INCH = 72;


        	  
        	var	lo=77.2167510986328;
        	var	la=28.5687255859375;

        	var extent1 = new OpenLayers.Bounds(68.162834117480,6.7542559500000,97.41516105,37.06396505);

        	var tempScales = [23659291,17074442,11322961,7588641,5059094,3372729,2248486,1498990,999327,666218,444145,296096,197397,131598,87732,58488,38992,25994,17329,11553,7702,5134,3423,2282,1521,1041,676,450,300,0];
        	  var mapOptions1 = {
        	     maxExtent: extent1, 
        	    scales:tempScales,
        	          units: "dd"
        	  };
        	  map1 = new OpenLayers.Map( 'map', mapOptions1 );
        	  map1.addControl(new OpenLayers.Control.PanZoomBar());
        	 // map1.addControl(new OpenLayers.Control.MouseToolbar());
        	//  map1.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':false}));
        	 // map1.addControl(new OpenLayers.Control.Permalink());
        	//  map1.addControl(new OpenLayers.Control.Permalink('permalink'));
        	  //map1.addControl(new OpenLayers.Control.MousePosition());
        	  map1.addControl(new OpenLayers.Control.OverviewMap());
        	  map1.addControl(new OpenLayers.Control.KeyboardDefaults());
        	  var params1 = {
        			  //  mapdefinition: 'Library://Samples/Sheboygan/MapsTiled/Sheboygan.MapDefinition'
        			  //  mapdefinition: 'Library://Transworld/Data/Transworld.MapDefinition',
        			  //  mapdefinition: 'Library://TransworldMap/IndiaMap.MapDefinition',
        			  mapdefinition: 'Library://TranswoldNew/test.MapDefinition',

        			 basemaplayergroupname: "Base Layer Group"
        			  };
        			  var options1 = 
            			  {
        			    //singleTile: false 
        				  singleTile: true, isBaseLayer: true,
        			    transitionEffect: "resize",
        			    buffer: 1,
        			    useOverlay: false,
        			    useAsyncOverlay: false
        			  };

    		  
        			  layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
        			//  layer1=new OpenLayers.Layer.OSM();
        	  map1.addLayer(layer1);

        	  map1.setCenter(new OpenLayers.LonLat(77.768553,23.402765).transform(
      		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      		        map1.getProjectionObject() // to Spherical Mercator Projection
      		      ),4);

           map1.events.register('zoomend', map1, function(evt)
                   {
               var zoom = map1.getZoom();
             //  alert(zoom);
                   });
 }
 catch(e)
 {
	 alert(e);
 }
 }
        
        //Disable right click script
        //visit http://www.rainbow.arch.scriptmania.com/scripts/
        var message="Sorry, right-click has been disabled";
        ///////////////////////////////////
        function clickIE() {if (document.all) {(message);return false;}}
        function clickNS(e) {if
        (document.layers||(document.getElementById&&!document.all)) {
        if (e.which==2||e.which==3) {(message);return false;}}}
        if (document.layers)
        {document.captureEvents(Event.MOUSEDOWN);document.onmousedown=clickNS;}
        else{document.onmouseup=clickNS;document.oncontextmenu=clickIE;}
        document.oncontextmenu=new Function("return false")
        
    </script>
</head>

 <%@ include file="Connections/helpconn.jsp" %>
<!-- body.onload is called once the page is loaded (call the 'init' function) -->
<body  onload="init();">

 <%
 try
 {
 	//System.out.println("\nnotice-->>");
 	
 	String user = session.getAttribute("usertest").toString();
 	 String sessionid=session.getId().toString();
 %>

	 
	 
    <!-- define a DIV into which the map will appear. Make it take up the whole window -->
    
    <table  style="text-align: center;margin-left: 22em;margin-right: 10em" border="1">
    <tr align="center">
    <td align="center">
    <div style="width:800px; height:500px;text-align: center;" id="map"></div>
    </td>
    </tr>
 </table>
 
 
 
 <%
	
 }
 catch(Exception e)
 {
     System.out.println(e);
 }
 finally
 {
 	try
 	{
 		
 		
 	}catch(Exception e)
 	{
 		
 	}
 	try
 	{
 		
 	}catch(Exception e)
 	{
 		
 	}
 	
 }
 %>
</body>
 
</html>