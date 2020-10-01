<%@ include file="headernew.jsp" %>
 <%@ page import="kml.KML1" %>
 <%
classes fleetview=new classes(); 
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String username="";
String status=request.getParameter("status");
if(status == null || status.equalsIgnoreCase("null"))
{
	status = "All";
}
String msg=request.getParameter("msg");
String para=request.getParameter("Parameter");
if(para!=null)
{%>
	<script>
	alert("Zoom Level Set successfully");
	window.location="home.jsp";
	</script>
	<%
}
if(msg!=null)
{%>
	<script>
	alert("Data Already present");
	window.location="home.jsp";
	</script>
	<%
}
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
            name:North;
        }
        #map2 {
            width: 400px;
            height: 400px;
            border: 1px solid black;
            float:left;
            name:East;
        }
         #map3 {
            width: 400px;
            height: 400px;
            border: 1px solid black;
            float:left;
            name:West;
        }
         #map4 {
            width: 400px;
            height: 400px;
            border: 1px solid black;
            float:left;
            name:South;
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
    String html1,location;
    String test;
    double lat,lon;
    %>
    
    <%
    html1 = "";location = "";
    lat = 0.0;lon = 0.0;
    test="";
    
    %>
<!--    <br>-->
<!--    <table style="text-align: center;margin-left: 48em;margin-right: 48em;"><tr align="center"><td align="center">-->
<!--<font size="3"><B>All Vehicles on Map</B></font></td></tr></table>-->
<div align="center"><font size="3"><B>All Vehicles on Map</B></font></div>
<br></br>
<%!
Connection conn2,conn;
Statement st,st1,st2,st3;
%>
	<%
	try
	{
	
		
	
    username=(String)session.getAttribute("mainuser");
	System.out.println("username" +username);
	
	}
	catch(Exception e)
	{
		System.out.println("Exception eeeeeeeeeee"  +e);
	}
	%>
	<form name="zoom" id="zoom" method="post" action="insertzoom.jsp">
	<input type="hidden" name="zoom1" id="zoom1" value="<%="" %>"></input>
	<input type="hidden" name="zoomlat" id="zoomlat" value="<%="" %>"></input>
	<input type="hidden" name="zoomlon" id="zoomlon" value="<%="" %>"></input>
	
	<input type="hidden" name="zoom2" id="zoom2" value="<%="" %>"></input>
	<input type="hidden" name="zoomlat2" id="zoomlat2" value="<%="" %>"></input>
	<input type="hidden" name="zoomlon2" id="zoomlon2" value="<%="" %>"></input>
	
	<input type="hidden" name="zoom3" id="zoom3" value="<%="" %>"></input>
	<input type="hidden" name="zoomlat3" id="zoomlat3" value="<%="" %>"></input>
	<input type="hidden" name="zoomlon3" id="zoomlon3" value="<%="" %>"></input>
	
	<input type="hidden" name="zoom4" id="zoom4" value="<%="" %>"></input>
	<input type="hidden" name="zoomlat4" id="zoomlat4" value="<%="" %>"></input>
	<input type="hidden" name="zoomlon4" id="zoomlon4" value="<%="" %>"></input>
	
	<table border="0" style="width: 55%"  align="center"> 
<tr>
<!--		<td bgcolor="#BDEDFF" class="sorttable_nosort" style="width: 10px;">-->
<!--			<b>Color Code Indications:-<a href="home.jsp?status=All"><span>All</span></a>-->
<!--			</b>-->
<!--		</td>   -->
<!--		<td style="width: 2px;" bgcolor="#CCFFCC" class="sorttable_nosort"><b><a href="home.jsp?status=moving">Moving</a></b></td>-->
<!--		<td style="width: 5px;" bgcolor="#FFFFCC" class="sorttable_nosort" ><b><a href="home.jsp?status=Stop">Stop</a></b></td>-->
<!--		<td style="width:10px" bgcolor="#DCDCDC" class="sorttable_nosort"><b><a href="home.jsp?status=Disconnected">Disconnected</a></b></td>-->
<!--		<td style="width: 10px" bgcolor="#FF6600" class="sorttable_nosort" ><b><a href="home.jsp?status=Ignition">Iginition off</a></b></td>-->
<!--		<td style="width: 10px" bgcolor="#D4C0F0" class="sorttable_nosort"><b><a href="home.jsp?status=Stopengine">Idle</a></b></td>-->
<!--		<td style="width: 10px" bgcolor="#F5DEB3" class="sorttable_nosort"><b><a href="home.jsp?status=Stop>4">Stop>4</a></b></td>				-->
<!--		<td style="width: 10px" bgcolor="" class="sorttable_nosort"><b><a href="home.jsp?status=Inactive">Inactive</a></b></td>	-->
	
		<td style="width: 10px" align="center"><div align="center">
			<input type="hidden" name="status" id="status" value="<%=status %>">
<input  type="submit" name="submit" id="submit" value="Setzoomlevel" style="border-style: outset; border-color: black" onclick="pass();" >
</div>
</td>
	</tr>		
	</table>

<%




%>
</form>


<table border="0" width="55%" >

<tr>
<td align="left">
		
		<% int i=1; %>
</td>
</tr>
<tr align="center"><td align="center" colspan="2">
<table border="0" width="55%" align="center" class="stats">
<tr>
<td width="85%" align="right">North

  <div id=map style="width: 400px;height: 300px;overflow:auto;position: relative;" align="center"></div>
 
  </td>
  <td width="85%" align="left">East

  <div id=map2 style="width: 400px;height: 300px;overflow:auto;position: relative;" align="center"></div>
 
  </td>

<td width="15%" align="left" colspan="2">
<div id="sidebar" style="overflow:auto;width: 400px;height: 300px"></div>
</td>
</tr>
<tr>
<td width="85%" align="right">West

  <div id=map3 style="width: 400px;height: 300px;overflow:auto;position: relative;" align="center"></div>
 
  </td>
  <td width="85%" align="left">South

  <div id=map4 style="width: 400px;height: 300px;overflow:auto;position: relative;" align="center"></div>
 
  </td>


</tr>
</table>
</td></tr>
</table>
<td>
    <div align="center"><font face="Arial" color="black">Copyright &copy; Transworld 2012.All rights reserved</font></div></td> 
    <script type="text/javascript">

    
    //<![CDATA[
    try
    {
   		var map, map1,layer1,layer,markers1,markers2,map2,layer2,markers3,layer3,map3,map4,markers4;
    	var tmarkers = [];
    	var htmls = [];
    	var i=0;
    	var tmarkers1 = [];
    	var htmls1 = [];
    	var j=0;
    	var tmarkers2 = [];
    	var htmls2 = [];
    	var k=0;
    	var tmarkers3 = [];
    	var htmls3 = [];
    	var l=0;
    	var url = "http://203.199.134.131:8008/mapguide/mapagent/mapagent.fcgi?USERNAME=Administrator&PASSWORD=admin";
    	<%
    	try
    	{
    		Class.forName(MM_dbConn_DRIVER);
    		//	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    			conn2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    		   st=conn2.createStatement();
    		   st1=conn2.createStatement();
    		   st3=conn2.createStatement();
    		   st2=conn2.createStatement();
    		   double Mapzoomlevel=0,Mapceterlat=0,Mapcenterlon=0,latitude=0,Mapzoomlevel1=0,Mapceterlat1=0,Mapcenterlon1=0;
    		   double Mapzoomlevel2=0,Mapceterlat2=0,Mapcenterlon2=0,Mapzoomlevel3=0,Mapceterlat3=0,Mapcenterlon3=0;
    		   String sql="select * from db_gps.t_security where Username='"+username+"'";
    		   ResultSet rs=st.executeQuery(sql);
    		   System.out.println("security querry" +sql);
    		   if(rs.next())
    		   {
    		   	Mapzoomlevel=rs.getDouble("Mapzoomlevel");
    		   	Mapceterlat =rs.getDouble("Mapceterlat");
    		   	Mapcenterlon =rs.getDouble("Mapcenterlon");
    		   	
    		   	Mapzoomlevel1=rs.getDouble("Mapzoomlevel1");
    		   	Mapceterlat1 =rs.getDouble("Mapceterlat1");
    		   	Mapcenterlon1 =rs.getDouble("Mapcenterlon1");
    		   	
    		   	Mapzoomlevel2=rs.getDouble("Mapzoomlevel2");
    		   	Mapceterlat2 =rs.getDouble("Mapceterlat2");
    		   	Mapcenterlon2 =rs.getDouble("Mapcenterlon2");
    		   	
    		   	Mapzoomlevel3=rs.getDouble("Mapzoomlevel3");
    		   	Mapceterlat3=rs.getDouble("Mapceterlat3");
    		   	Mapcenterlon3 =rs.getDouble("Mapcenterlon3");
    		   	
    		   }
    		   
    			   if(Mapceterlat==0 && Mapcenterlon==0 )
    			   {
    				   System.out.println("----------------------------------------------------->in ist if"); 
    			   	Mapzoomlevel=7;
    			   	Mapceterlat=23.402765;
    			   	Mapcenterlon=77.768553;
    			   	
    			   }
    			   else if(Mapceterlat1==0 && Mapcenterlon1==0)
    			   {
    				   System.out.println("----------------------------------------------------->in 2nd if"); 
    				Mapzoomlevel1=7;
       			   	Mapceterlat1=23.402765;
       			   	Mapcenterlon1=77.768553;  
    			   }
    			   else if(Mapceterlat2==0 && Mapcenterlon2==0)
    			   {
    				   System.out.println("----------------------------------------------------->in 3rd if"); 
       			   	Mapzoomlevel2=7;
       			   	Mapceterlat2=23.402765;
       			   	Mapcenterlon2=77.768553;  
    			   }
    			   
    			   else if(Mapceterlat3==0 && Mapcenterlon3==0) 
    			   {
    				   System.out.println("----------------------------------------------------->in 4tth if"); 
    					Mapzoomlevel3=7;
        			   	Mapceterlat3=23.402765;
        			   	Mapcenterlon3=77.768553;
    			   }
    			   
    			   %>
    			   zoomlevel = "<%=Mapzoomlevel%>";
    			   newlat = "<%=Mapceterlat%>";
    			   newlon = "<%=Mapcenterlon%>";

    			   zoomlevel1 = "<%=Mapzoomlevel1%>";
    			   newlat1 = "<%=Mapceterlat1%>";
    			   newlon1 = "<%=Mapcenterlon1%>";

    			   zoomlevel2 = "<%=Mapzoomlevel2%>";
    			   newlat2 = "<%=Mapceterlat2%>";
    			   newlon2 = "<%=Mapcenterlon2%>";

    			   zoomlevel3 = "<%=Mapzoomlevel3%>";
    			   newlat3 = "<%=Mapceterlat3%>";
    			   newlon3 = "<%=Mapcenterlon3%>";
    			   <%   
    		   
    	}
    	catch(Exception e)
    	{
    		System.out.println("^^^^   "+e);
    	}
    	%>





    	
    	 function myclick(i,lat,lon,start,end) 
    		{
     		try
     		{
         	//	alert("----------------------------------------------------------->");
         		//var Startzone;
         		///alert(zone);
         		//alert(start);
         		//alert(end);
         		
     			if(start=="3")
         		{
     				//alert("3"+zone);
    			    map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
      		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      		        map1.getProjectionObject() // to Spherical Mercator Projection
      		      ),25);
         		}
     			else if(start=="1")
             		{
    			    	//alert("1"+zone);
    			    map2.setCenter(new OpenLayers.LonLat(lon,lat).transform(
      		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      		        map2.getProjectionObject() // to Spherical Mercator Projection
      		      ),25);
             		}

     			else if(start=="2")
             		{
             			//alert("2"+zone);
    			    map3.setCenter(new OpenLayers.LonLat(lon,lat).transform(
    	      		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    	      		        map3.getProjectionObject() // to Spherical Mercator Projection
    	      		      ),25);
             		}

     			else if(start=="4")
             		{
             			//alert("4"+zone);
    			    map4.setCenter(new OpenLayers.LonLat(lon,lat).transform(
    	      		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    	      		        map4.getProjectionObject() // to Spherical Mercator Projection
    	      		      ),25);
             		}

     			if(end=="3")
         		{
     				//alert("3"+zone);
    			    map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
      		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      		        map1.getProjectionObject() // to Spherical Mercator Projection
      		      ),25);
         		}
     			else if(end=="1")
             		{
    			    	//alert("1"+zone);
    			    map2.setCenter(new OpenLayers.LonLat(lon,lat).transform(
      		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      		        map2.getProjectionObject() // to Spherical Mercator Projection
      		      ),25);
             		}

     			else if(end=="2")
             		{
             			//alert("2"+zone);
    			    map3.setCenter(new OpenLayers.LonLat(lon,lat).transform(
    	      		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    	      		        map3.getProjectionObject() // to Spherical Mercator Projection
    	      		      ),25);
             		}

     			else if(end=="4")
             		{
             			//alert("4"+zone);
    			    map4.setCenter(new OpenLayers.LonLat(lon,lat).transform(
    	      		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    	      		        map4.getProjectionObject() // to Spherical Mercator Projection
    	      		      ),25);
             		}
         		
    			   // map1.events.register('click', lonLatMarker, function(){popup.show();});
    			   /* var popup = new OpenLayers.Popup("olPopup",
    			    		tmarkers[i].lonLat,
                            null,
                           "GeoInfo",
                            true);
                 map1.addPopup(popup);*/

    	      		
    			/*    popup = new OpenLayers.Popup("olPopup",
    	    	      		new OpenLayers.LonLat(lon,lat).transform(
    	    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    	    			              map1.getProjectionObject() // to Spherical Mercator Projection
    	    			            ),
    	    	      		new OpenLayers.Size(250,100),
    	    	      		html[i],
    	    	      		true);
    	    	    popup.closeOnMove = true; 
    	    	      		 map1.addPopup(popup);*/

     		}
     		catch(e)
     		{
         		//alert(e);
     		} 
    	    		
    		    
    		}

    	function returnMarker(latitude,longitude,discription,vehregno,speed,datetime,location,distanceTraveledToday,tripid,origin,dest,drivid,drivname,cIconSatus,update11,drivemob)
    	{
    		try{
    			var cIcon;
    		var currentTime = new Date();
    		var day = currentTime.getDate();
    		
    		var size = new OpenLayers.Size(10,20);
    		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
    		if(cIconSatus=="Red")
    			{
    			cIcon= new OpenLayers.Icon('images/mm_20_red.png', size, offset);
    			}
    		if(cIconSatus=="Gray")
			{
    			
			cIcon= new OpenLayers.Icon('images/mm_20_grey.png', size, offset);
			}
    		
    		if(cIconSatus=="Green")
			{
			cIcon= new OpenLayers.Icon('images/mm_20_green.png', size, offset);
			}
    		
    		
    		if(cIconSatus=="Yellow")
			{
			cIcon= new OpenLayers.Icon('images/mm_20_yellow.png', size, offset);
			}
    		if(cIconSatus=="Violet")
			{
    			size = new OpenLayers.Size(17,20);
    			cIcon= new OpenLayers.Icon('images/violet1.png', size, offset);
			}
    		if(cIconSatus=="Brown")
			{
    			
    			cIcon= new OpenLayers.Icon('images/mm_20_brown.png', size, offset);
			}
    		
			var marker = new OpenLayers.Marker(new OpenLayers.LonLat(longitude,latitude).transform(
		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		              map1.getProjectionObject() // to Spherical Mercator Projection
		            ),cIcon);
    
    		var html="<font size='1' face='Arial'><br><b>Veh: </b>"+vehregno+"<br><b>Speed: </b>"+speed+" (KM/Hr)<br><b>Updated: </b>"+datetime+"<br><b>KmToday:</b>"+distanceTraveledToday+"<br><b>Loc: </b>"+location;

    	//	alert("tripid    "+tripid+"  vehregno     "+vehregno);
 if(tripid == "-" || tripid=="")
 {
	 html = html + "<br><b>Trip: </b>"+update11;
 }
 else 
 {
	 html = html + "<br><b>Trip: </b>"+tripid+"<br><b>Org: </b>"+origin+"<br><b>Dest: </b>"+dest+"<br><b>Driver ID/Name: </b>"+drivid+"("+drivname+")<br><b>Driver MobileNo: </b>"+drivemob;
 }
    		html = html +"</font>";
    		marker.events.register('mousedown', marker, function(evt) { popup = new OpenLayers.Popup("olPopup",
    	      		new OpenLayers.LonLat(longitude,latitude).transform(
    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    			              map1.getProjectionObject() // to Spherical Mercator Projection
    			            ),
    	      		new OpenLayers.Size(250,100),
    	      		html,
    	      		true);
    	    popup.closeOnMove = true; 
    	      		 map1.addPopup(popup);
    	          });

    		/*marker.events.register('mouseover', marker, function(evt) { popup = new OpenLayers.Popup("olPopup",
    	      		new OpenLayers.LonLat(longitude,latitude).transform(
    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    			              map1.getProjectionObject() // to Spherical Mercator Projection
    			            ),
    	      		new OpenLayers.Size(250,100),
    	      		html,
    	      		true);
    	    popup.closeOnMove = true; 
    	      		 map1.addPopup(popup);
    	          });*/
    	         // alert(discription);
    	         /* if(discription==1)
                  {
               	   map1.setCenter(new OpenLayers.LonLat(longitude,latitude).transform(
              		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
              		        map1.getProjectionObject() // to Spherical Mercator Projection
              		      ),7);
                  } */
    	          
	          
    	    if(tmarkers[discription])
    	    {
    	    	markers1.removeMarker(tmarkers[discription]); 
    	    }

    	    markers1.addMarker(marker);    	    
    	    tmarkers[discription] = marker;
    		htmls[discription] = html;
    		
    		}
    		catch(e){
    		//	alert(e);
    		}

    	}

    	function returnMarker1(latitude,longitude,discription,vehregno,speed,datetime,location,distanceTraveledToday,tripid,origin,dest,drivid,drivname,cIconSatus,update11,drivemob)
    	{
    		try{
    			var cIcon;
    		var currentTime = new Date();
    		var day = currentTime.getDate();
    		
    		var size = new OpenLayers.Size(10,20);
    		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
    		if(cIconSatus=="Red")
    			{
    			cIcon= new OpenLayers.Icon('images/mm_20_red.png', size, offset);
    			}
    		if(cIconSatus=="Gray")
			{
    			
			cIcon= new OpenLayers.Icon('images/mm_20_grey.png', size, offset);
			}
    		
    		if(cIconSatus=="Green")
			{
			cIcon= new OpenLayers.Icon('images/mm_20_green.png', size, offset);
			}
    		
    		
    		if(cIconSatus=="Yellow")
			{
			cIcon= new OpenLayers.Icon('images/mm_20_yellow.png', size, offset);
			}
    		if(cIconSatus=="Violet")
			{
    			size = new OpenLayers.Size(17,20);
    			cIcon= new OpenLayers.Icon('images/violet1.png', size, offset);
			}
    		if(cIconSatus=="Brown")
			{
    			
    			cIcon= new OpenLayers.Icon('images/mm_20_brown.png', size, offset);
			}
    		
			var marker = new OpenLayers.Marker(new OpenLayers.LonLat(longitude,latitude).transform(
		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		              map2.getProjectionObject() // to Spherical Mercator Projection
		            ),cIcon);
    
    		var html="<font size='1' face='Arial'><br><b>Veh: </b>"+vehregno+"<br><b>Speed: </b>"+speed+" (KM/Hr)<br><b>Updated: </b>"+datetime+"<br><b>KmToday:</b>"+distanceTraveledToday+"<br><b>Loc: </b>"+location;

    	//	alert("tripid    "+tripid+"  vehregno     "+vehregno);
 if(tripid == "-" || tripid=="")
 {
	 html = html + "<br><b>Trip: </b>"+update11;
 }
 else 
 {
	 html = html + "<br><b>Trip: </b>"+tripid+"<br><b>Org: </b>"+origin+"<br><b>Dest: </b>"+dest+"<br><b>Driver ID/Name: </b>"+drivid+"("+drivname+")<br><b>Driver MobileNo: </b>"+drivemob;
 }
    		html = html +"</font>";
    		marker.events.register('mousedown', marker, function(evt) { popup = new OpenLayers.Popup("olPopup",
    	      		new OpenLayers.LonLat(longitude,latitude).transform(
    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    			              map2.getProjectionObject() // to Spherical Mercator Projection
    			            ),
    	      		new OpenLayers.Size(250,100),
    	      		html,
    	      		true);
    	    popup.closeOnMove = true; 
    	      		 map2.addPopup(popup);
    	          });

    		/*marker.events.register('mouseover', marker, function(evt) { popup = new OpenLayers.Popup("olPopup",
    	      		new OpenLayers.LonLat(longitude,latitude).transform(
    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    			              map1.getProjectionObject() // to Spherical Mercator Projection
    			            ),
    	      		new OpenLayers.Size(250,100),
    	      		html,
    	      		true);
    	    popup.closeOnMove = true; 
    	      		 map1.addPopup(popup);
    	          });*/
    	         // alert(discription);
    	         /* if(discription==1)
                  {
               	   map1.setCenter(new OpenLayers.LonLat(longitude,latitude).transform(
              		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
              		        map1.getProjectionObject() // to Spherical Mercator Projection
              		      ),7);
                  } */
    	          
	          
    	    if(tmarkers1[discription])
    	    {
    	    	markers2.removeMarker(tmarkers1[discription]); 
    	    }

    	    markers2.addMarker(marker);    	    
    	    tmarkers1[discription] = marker;
    		htmls1[discription] = html;
    		
    		}
    		catch(e){
    			//alert(e);
    		}
    	}
    	function returnMarker2(latitude,longitude,discription,vehregno,speed,datetime,location,distanceTraveledToday,tripid,origin,dest,drivid,drivname,cIconSatus,update11,drivemob)
    	{

    		try{
    			var cIcon;
    		var currentTime = new Date();
    		var day = currentTime.getDate();
    		
    		var size = new OpenLayers.Size(10,20);
    		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
    		if(cIconSatus=="Red")
    			{
    			cIcon= new OpenLayers.Icon('images/mm_20_red.png', size, offset);
    			}
    		if(cIconSatus=="Gray")
			{
    			
			cIcon= new OpenLayers.Icon('images/mm_20_grey.png', size, offset);
			}
    		
    		if(cIconSatus=="Green")
			{
			cIcon= new OpenLayers.Icon('images/mm_20_green.png', size, offset);
			}
    		
    		
    		if(cIconSatus=="Yellow")
			{
			cIcon= new OpenLayers.Icon('images/mm_20_yellow.png', size, offset);
			}
    		if(cIconSatus=="Violet")
			{
    			size = new OpenLayers.Size(17,20);
    			cIcon= new OpenLayers.Icon('images/violet1.png', size, offset);
			}
    		if(cIconSatus=="Brown")
			{
    			
    			cIcon= new OpenLayers.Icon('images/mm_20_brown.png', size, offset);
			}
    		
			var marker = new OpenLayers.Marker(new OpenLayers.LonLat(longitude,latitude).transform(
		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		              map3.getProjectionObject() // to Spherical Mercator Projection
		            ),cIcon);
    
    		var html="<font size='1' face='Arial'><br><b>Veh: </b>"+vehregno+"<br><b>Speed: </b>"+speed+" (KM/Hr)<br><b>Updated: </b>"+datetime+"<br><b>KmToday:</b>"+distanceTraveledToday+"<br><b>Loc: </b>"+location;

    	//	alert("tripid    "+tripid+"  vehregno     "+vehregno);
 if(tripid == "-" || tripid=="")
 {
	 html = html + "<br><b>Trip: </b>"+update11;
 }
 else 
 {
	 html = html + "<br><b>Trip: </b>"+tripid+"<br><b>Org: </b>"+origin+"<br><b>Dest: </b>"+dest+"<br><b>Driver ID/Name: </b>"+drivid+"("+drivname+")<br><b>Driver MobileNo: </b>"+drivemob;
 }
    		html = html +"</font>";
    		marker.events.register('mousedown', marker, function(evt) { popup = new OpenLayers.Popup("olPopup",
    	      		new OpenLayers.LonLat(longitude,latitude).transform(
    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    			              map3.getProjectionObject() // to Spherical Mercator Projection
    			            ),
    	      		new OpenLayers.Size(250,100),
    	      		html,
    	      		true);
    	    popup.closeOnMove = true; 
    	      		 map3.addPopup(popup);
    	          });

    		/*marker.events.register('mouseover', marker, function(evt) { popup = new OpenLayers.Popup("olPopup",
    	      		new OpenLayers.LonLat(longitude,latitude).transform(
    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    			              map1.getProjectionObject() // to Spherical Mercator Projection
    			            ),
    	      		new OpenLayers.Size(250,100),
    	      		html,
    	      		true);
    	    popup.closeOnMove = true; 
    	      		 map1.addPopup(popup);
    	          });*/
    	         // alert(discription);
    	         /* if(discription==1)
                  {
               	   map1.setCenter(new OpenLayers.LonLat(longitude,latitude).transform(
              		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
              		        map1.getProjectionObject() // to Spherical Mercator Projection
              		      ),7);
                  } */
    	          
	          
    	    if(tmarkers2[discription])
    	    {
    	    	markers3.removeMarker(tmarkers2[discription]); 
    	    }

    	    markers3.addMarker(marker);    	    
    	    tmarkers2[discription] = marker;
    		htmls2[discription] = html;
    		
    		}
    		catch(e){
    			//alert(e);
    		}
        	
    	}
    	function returnMarker3(latitude,longitude,discription,vehregno,speed,datetime,location,distanceTraveledToday,tripid,origin,dest,drivid,drivname,cIconSatus,update11,drivemob)
    	{

    		try{
    			var cIcon;
    		var currentTime = new Date();
    		var day = currentTime.getDate();
    		
    		var size = new OpenLayers.Size(10,20);
    		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
    		if(cIconSatus=="Red")
    			{
    			cIcon= new OpenLayers.Icon('images/mm_20_red.png', size, offset);
    			}
    		if(cIconSatus=="Gray")
			{
    			
			cIcon= new OpenLayers.Icon('images/mm_20_grey.png', size, offset);
			}
    		
    		if(cIconSatus=="Green")
			{
			cIcon= new OpenLayers.Icon('images/mm_20_green.png', size, offset);
			}
    		
    		
    		if(cIconSatus=="Yellow")
			{
			cIcon= new OpenLayers.Icon('images/mm_20_yellow.png', size, offset);
			}
    		if(cIconSatus=="Violet")
			{
    			size = new OpenLayers.Size(17,20);
    			cIcon= new OpenLayers.Icon('images/violet1.png', size, offset);
			}
    		if(cIconSatus=="Brown")
			{
    			
    			cIcon= new OpenLayers.Icon('images/mm_20_brown.png', size, offset);
			}
    		
			var marker = new OpenLayers.Marker(new OpenLayers.LonLat(longitude,latitude).transform(
		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		              map4.getProjectionObject() // to Spherical Mercator Projection
		            ),cIcon);
    
    		var html="<font size='1' face='Arial'><br><b>Veh: </b>"+vehregno+"<br><b>Speed: </b>"+speed+" (KM/Hr)<br><b>Updated: </b>"+datetime+"<br><b>KmToday:</b>"+distanceTraveledToday+"<br><b>Loc: </b>"+location;

    	//	alert("tripid    "+tripid+"  vehregno     "+vehregno);
 if(tripid == "-" || tripid=="")
 {
	 html = html + "<br><b>Trip: </b>"+update11;
 }
 else 
 {
	 html = html + "<br><b>Trip: </b>"+tripid+"<br><b>Org: </b>"+origin+"<br><b>Dest: </b>"+dest+"<br><b>Driver ID/Name: </b>"+drivid+"("+drivname+")<br><b>Driver MobileNo: </b>"+drivemob;
 }
    		html = html +"</font>";
    		marker.events.register('mousedown', marker, function(evt) { popup = new OpenLayers.Popup("olPopup",
    	      		new OpenLayers.LonLat(longitude,latitude).transform(
    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    			              map4.getProjectionObject() // to Spherical Mercator Projection
    			            ),
    	      		new OpenLayers.Size(250,100),
    	      		html,
    	      		true);
    	    popup.closeOnMove = true; 
    	      		 map4.addPopup(popup);
    	          });

    		/*marker.events.register('mouseover', marker, function(evt) { popup = new OpenLayers.Popup("olPopup",
    	      		new OpenLayers.LonLat(longitude,latitude).transform(
    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    			              map1.getProjectionObject() // to Spherical Mercator Projection
    			            ),
    	      		new OpenLayers.Size(250,100),
    	      		html,
    	      		true);
    	    popup.closeOnMove = true; 
    	      		 map1.addPopup(popup);
    	          });*/
    	         // alert(discription);
    	         /* if(discription==1)
                  {
               	   map1.setCenter(new OpenLayers.LonLat(longitude,latitude).transform(
              		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
              		        map1.getProjectionObject() // to Spherical Mercator Projection
              		      ),7);
                  } */
    	          
	          
    	    if(tmarkers3[discription])
    	    {
    	    	markers4.removeMarker(tmarkers3[discription]); 
    	    }

    	    markers4.addMarker(marker);    	    
    	    tmarkers3[discription] = marker;
    		htmls3[discription] = html;
    		
    		}
    		catch(e){
    			//alert(e);
    		}
        	
    	}
    	function GetUpdates1()
    	{
    		var status1=document.zoom.status.value;
        	
    		var ajaxRequest;  // The variable that makes Ajax possible!
    		//alert("get updates ");
    		try{
    				ajaxRequest = new XMLHttpRequest();
    		    }  
    	        catch (e)
    	        {
    			    try{
    				   		ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
    			        } 
    	                catch (e)
    	                {
    				   		try{
    				       			ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
    				   			} 
    	                        catch (e)
    	                        {
    				      			alert("Your browser broke!");
    				      			return false;
    				   			}
    			        }
    	          }
    	          ajaxRequest.onreadystatechange = function()
    	          {
    	    	  		if(ajaxRequest.readyState == 4)
    	                {
    		                try{
    	                	var reslt=ajaxRequest.responseText;
    	                    var resnew=reslt.split("@");
    	                    document.getElementById("sidebar").innerHTML=resnew[0];
    	               	 	var markerslist=resnew[1].split("$");
    	               	  //  alert(resnew[0]);

    						for(x=0;x<resnew[2]-1;x++)
    	               	 	{
    	                   	 var marval=markerslist[x].split("~");
    	                   	// alert(marval[16]);
							//alert(marval[16]+"  East "+(marval[16].search("East")));
							//alert(marval[16]+"  West "+(marval[16].search("West")));
							//alert(marval[16]+"  North "+(marval[16].search("North")));
							//alert(marval[16]+"  South "+(marval[16].search("South")));
    	                   	 
    	                   	 if(marval[16].search("East") >= 0)
    	                   	 {
    	                   		returnMarker1(marval[0],marval[1],marval[2],marval[3],marval[4],marval[5],marval[6],marval[7],marval[8],marval[9],marval[10],marval[11],marval[12],marval[13],marval[14],marval[15],marval[16]);
       	                   	 
    	                   	 }
    	                   	  if(marval[16].search("West")  >= 0)
    	                   	 {
    	                   		returnMarker2(marval[0],marval[1],marval[2],marval[3],marval[4],marval[5],marval[6],marval[7],marval[8],marval[9],marval[10],marval[11],marval[12],marval[13],marval[14],marval[15],marval[16]);
         	                   	 
    	                   	 }
    	                   	  if(marval[16].search("North")  >= 0)
    	                   	 {
    	                   		 returnMarker(marval[0],marval[1],marval[2],marval[3],marval[4],marval[5],marval[6],marval[7],marval[8],marval[9],marval[10],marval[11],marval[12],marval[13],marval[14],marval[15],marval[16]);
        	                   	 
    	                   	 }

    	                   	  if(marval[16].search("South") >= 0)
    	                   	 {
    	                   		returnMarker3(marval[0],marval[1],marval[2],marval[3],marval[4],marval[5],marval[6],marval[7],marval[8],marval[9],marval[10],marval[11],marval[12],marval[13],marval[14],marval[15],marval[16]);
           	               	 
    	                   	 }
    	                   	 
    	               	 	}
    		                }
    		                catch(e)
    		                {
    			               //alert(e);
    		                }
    	                }
    	         	}

    	          queryStringg = "?status="+status1;
    	          ajaxRequest.open("GET", "mapUpdateerpl.jsp"+queryStringg, true);
    	      ajaxRequest.send(null); 
    	}
    	
    	 function setToRed ( )
 		{
 			GetUpdates1();
 		}

	      function initialize()
	       {
	var metersPerUnit = 111319.4908;  //value returned from mapguide
	var inPerUnit = OpenLayers.INCHES_PER_UNIT.m * metersPerUnit;

	OpenLayers.INCHES_PER_UNIT["dd"] = inPerUnit;
	OpenLayers.INCHES_PER_UNIT["degrees"] = inPerUnit;
	OpenLayers.DOTS_PER_INCH = 72;


	  
	var	lo=77.2167510986328;
	var	la=28.5687255859375;

	//  var extent1 = new OpenLayers.Bounds(68.1623341674805,6.771473,97.4037974243164,37.064465);
	  var extent1 = new OpenLayers.Bounds(68.162834117480,6.7542559500000,97.41516105,37.06396505);
	  

	  //var tempScales = [20000,10000,5794.74679,2826.95795,1894.95494,796.85673,327.59372,130.69773,100,50,25,12,6,3,2,1,0];
	 var tempScales = [23659291,17074442,11322961,7588641,5059094,3372729,2248486,1498990,999327,666218,444145,296096,197397,131598,87732,58488,38992,25994,17329,11553,7702,5134,3423,2282,1521,1041,676,450,300,0];
	  var mapOptions1 = {
	     maxExtent: extent1, 
	    scales:tempScales,
	          units: "dd"
	  };
	  map1 = new OpenLayers.Map( 'map', mapOptions1);
	  map1.addControl(new OpenLayers.Control.PanZoomBar());
	  map1.addControl(new OpenLayers.Control.MouseToolbar());
	 // map1.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':false}));
	//  map1.addControl(new OpenLayers.Control.Permalink());
	//  map1.addControl(new OpenLayers.Control.Permalink('permalink'));
	//  map1.addControl(new OpenLayers.Control.MousePosition());
	  map1.addControl(new OpenLayers.Control.OverviewMap());
	  map1.addControl(new OpenLayers.Control.KeyboardDefaults());
	  
	  map2 = new OpenLayers.Map( 'map2', mapOptions1 );
	  map2.addControl(new OpenLayers.Control.PanZoomBar());
	  map2.addControl(new OpenLayers.Control.MouseToolbar());
	  //map1.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':false}));
	  //map1.addControl(new OpenLayers.Control.Permalink());
	  //map1.addControl(new OpenLayers.Control.Permalink('permalink'));
	//  map1.addControl(new OpenLayers.Control.MousePosition());
	  map2.addControl(new OpenLayers.Control.OverviewMap());
	  map2.addControl(new OpenLayers.Control.KeyboardDefaults());

	  map3 = new OpenLayers.Map( 'map3', mapOptions1 );
	  map3.addControl(new OpenLayers.Control.PanZoomBar());
	  map3.addControl(new OpenLayers.Control.MouseToolbar());
	  //map1.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':false}));
	  //map1.addControl(new OpenLayers.Control.Permalink());
	  //map1.addControl(new OpenLayers.Control.Permalink('permalink'));
	//  map1.addControl(new OpenLayers.Control.MousePosition());
	  map3.addControl(new OpenLayers.Control.OverviewMap());
	  map3.addControl(new OpenLayers.Control.KeyboardDefaults());

	  map4 = new OpenLayers.Map( 'map4', mapOptions1 );
	  map4.addControl(new OpenLayers.Control.PanZoomBar());
	  map4.addControl(new OpenLayers.Control.MouseToolbar());
	  //map1.addControl(new OpenLayers.Control.LayerSwitcher({'ascending':false}));
	  //map1.addControl(new OpenLayers.Control.Permalink());
	  //map1.addControl(new OpenLayers.Control.Permalink('permalink'));
	//  map1.addControl(new OpenLayers.Control.MousePosition());
	  map4.addControl(new OpenLayers.Control.OverviewMap());
	  map4.addControl(new OpenLayers.Control.KeyboardDefaults());
	  var params1 = {
			  //  mapdefinition: 'Library://Samples/Sheboygan/MapsTiled/Sheboygan.MapDefinition'
			  //  mapdefinition: 'Libary://Transworld/Data/Transworld.MapDefinition',
			 //  mapdefinition: 'Library://TransworldMap/IndiaMap.MapDefinition',
			//mapdefinition: 'Library://TWMaps/TWMaps.MapDefinition',
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
			  }

	  
			  layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	  layer2 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	  layer3 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	  layer4 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
			//  layer1=new OpenLayers.Layer.OSM();
	  map1.addLayer(layer1);
	  map2.addLayer(layer2);
	  map3.addLayer(layer3);
	  map4.addLayer(layer4);
	//  loadKML("KML/test.kml");

		    markers1 = new OpenLayers.Layer.Markers( "Markers");
	  		map1.addLayer(markers1);

	  		markers2 = new OpenLayers.Layer.Markers( "Markers");
	  		map2.addLayer(markers2);
	  		
	  		markers3 = new OpenLayers.Layer.Markers( "Markers");
	  		map3.addLayer(markers3);
	  		
	  		markers4 = new OpenLayers.Layer.Markers( "Markers");
	  		map4.addLayer(markers4);
		/*var size = new OpenLayers.Size(12,18);
		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
		var iconn = new OpenLayers.Icon('images/mm_20_red.png', size, offset);*/
 	  
	  
		 map1.setCenter(new OpenLayers.LonLat(newlon,newlat).transform(
			        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
			        map1.getProjectionObject() // to Spherical Mercator Projection
			      ),zoomlevel);
		 map2.setCenter(new OpenLayers.LonLat(newlon1,newlat1).transform(
			        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
			        map2.getProjectionObject() // to Spherical Mercator Projection
			      ),zoomlevel1);

		 map3.setCenter(new OpenLayers.LonLat(newlon2,newlat2).transform(
			        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
			        map3.getProjectionObject() // to Spherical Mercator Projection
			      ),zoomlevel2);


		 map4.setCenter(new OpenLayers.LonLat(newlon3,newlat3).transform(
			        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
			        map4.getProjectionObject() // to Spherical Mercator Projection
			      ),zoomlevel3);
	      

    map1.events.register('zoomend', map1, function(evt)
            {
    	try
        {
            ////////////////////////////////////NEW CODE ADDED TO CALCULATE LAT AND LON FOR A GIVEN POS//////////////////////
        var zoom = map1.getZoom();
      //  alert(zoom);
        var pos=map1.getCenter();
      //  alert(pos);
       
             var a =pos.transform(map1.getProjectionObject(),map1.displayProjection);
             var lati=a.lat;
             var longi=a.lon;
          //   alert(lati);
          //  alert(longi);
            
        
                      
         }
        catch(e)
        {
            alert(e);
        };
            });
    map2.events.register('zoomend', map2, function(evt)
            {
    	try
        {
            ////////////////////////////////////NEW CODE ADDED TO CALCULATE LAT AND LON FOR A GIVEN POS//////////////////////
        var zoom = map2.getZoom();
      //  alert(zoom);
        var pos=map2.getCenter();
      //  alert(pos);
       
             var a =pos.transform(map2.getProjectionObject(),map2.displayProjection);
             var lati=a.lat;
             var longi=a.lon;
          //   alert(lati);
          //  alert(longi);
            
        
                      
         }
        catch(e)
        {
            //alert(e);
        };
            });
    map3.events.register('zoomend', map3, function(evt)
            {
    	try
        {
            ////////////////////////////////////NEW CODE ADDED TO CALCULATE LAT AND LON FOR A GIVEN POS//////////////////////
        var zoom = map3.getZoom();
      //  alert(zoom);
        var pos=map3.getCenter();
      //  alert(pos);
       
             var a =pos.transform(map3.getProjectionObject(),map3.displayProjection);
             var lati=a.lat;
             var longi=a.lon;
          //   alert(lati);
          //  alert(longi);
            
        
                      
         }
        catch(e)
        {
           // alert(e);
        };
            });

    map4.events.register('zoomend', map4, function(evt)
            {
    	try
        {
            ////////////////////////////////////NEW CODE ADDED TO CALCULATE LAT AND LON FOR A GIVEN POS//////////////////////
        var zoom = map4.getZoom();
      //  alert(zoom);
        var pos=map4.getCenter();
      //  alert(pos);
       
             var a =pos.transform(map4.getProjectionObject(),map4.displayProjection);
             var lati=a.lat;
             var longi=a.lon;
          //   alert(lati);
          //  alert(longi);
            
        
                      
         }
        catch(e)
        {
           // alert(e);
        };
            });

    
    setToRed ();
    
      }

	      initialize();

	      function pass()
	      {

	  try
	  {

	     //     alert("---------------------------->");
	          var zoom = map1.getZoom();
	     //     alert(zoom);
	          var pos=map1.getCenter();
	        //  alert(pos);
	         
	               var a =pos.transform(map1.getProjectionObject(),map1.displayProjection);
	               var lati=a.lat;
	               var longi=a.lon;
	           //   alert(lati);
	           //   alert(longi);

              
	            //   alert(lati);
	             // alert(longi);

	               var zoom2 = map2.getZoom();
	    	       //   alert(zoom2);
	    	          var pos2=map2.getCenter();
	    	       //   alert(pos2);
	    	         
	    	               var l =pos2.transform(map2.getProjectionObject(),map2.displayProjection);
	    	               var lati2=l.lat;
	    	               var longi2=l.lon;
	    	            //    alert(lati2);
	    		        //    alert(longi2);
	    		             
	    		             
	    		             
	    	               var zoom3= map3.getZoom();
	    	    	       //   alert(zoom);
	    	    	          var pos3=map3.getCenter();
	    	    	       //   alert(pos);
	    	    	         
	    	    	               var m =pos3.transform(map3.getProjectionObject(),map3.displayProjection);
	    	    	               var lati3=m.lat;
	    	    	               var longi3=m.lon;

	    	    	               var zoom4 = map4.getZoom();
	    	    	    	       //   alert(zoom);
	    	    	    	          var pos4=map4.getCenter();
	    	    	    	       //   alert(pos);
	    	    	    	         
	    	    	    	               var n =pos4.transform(map4.getProjectionObject(),map4.displayProjection);
	    	    	    	               var lati4=n.lat;
	    	    	    	               var longi4=n.lon;
		             
		             
	  }
	  catch(e)
	  {
	  alert(e);
	  }

	          
	          document.getElementById("zoom1").value=zoom;
	          document.getElementById("zoomlat").value=lati;
	          document.getElementById("zoomlon").value=longi;
	       //   alert(zoom);
	      //    alert(lati);
	      //    alert(longi);
	          document.getElementById("zoom2").value=zoom2;
	          document.getElementById("zoomlat2").value=lati2;
	          document.getElementById("zoomlon2").value=longi2;
	        //  alert(zoom2);
	        //  alert(lati2);
	        //  alert(longi2);
	          document.getElementById("zoom3").value=zoom3;
	          document.getElementById("zoomlat3").value=lati3;
	          document.getElementById("zoomlon3").value=longi3;
	       //   alert(zoom3);
	       //   alert(lati3);
	        //  alert(longi3);
	          document.getElementById("zoom4").value=zoom4;
	          document.getElementById("zoomlat4").value=lati4;
	          document.getElementById("zoomlon4").value=longi4;
	       //   alert(zoom4);
	      //    alert(lati4);
	       //   alert(longi4);
		 	      }  
	    
  //	alert(map1.getZoom());
			<%
			/*lon = 77.768553;
			lat = 23.402765;
			location = "vcbnvhcdgcfnbxn";
			String dt = new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse("2012-08-22"));
			String html1="<b>Last location:</b><br>"+location+"<br><b>Date Time : </b>"+dt+" 15:19:00";*/
			%>
		//	var point1 = 1;
		//	createMarker(point1,"<div class='bodyText'></%=html1%></div>","<div class='bodyText'></%=html1%></div>","AC",</%=lat%>,</%=lon%>);
    }
    catch(e)
    {
        //alert(e);
    }

  


    
    function loadKML(url){
        try
        {
  	  map1.addLayer(new OpenLayers.Layer.GML(url,url, 
  	          {
  	           format: OpenLayers.Format.KML, 
  	           formatOptions: {
  	             extractStyles: true 
  	           }
  	          }));
        }
        catch(e)
        {
           // alert(e);
        }
    }
    
    function createMarker(point,name,html,stamp,lat,lon) 
    {
        try
        {
		var cIcon;
		//alert(html);
		/*var mark = new OpenLayers.Layer.Markers( "Markers" );
		map1.addLayer(mark);
		var size = new OpenLayers.Size(21,25);
		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);*/
		//alert(offset);
		if(stamp=="OS")
		{
			cIcon= new OpenLayers.Icon('images/mm_20_red.png', size, offset);
		}
		if(stamp=="ST" || stamp=="SP")
		{
			cIcon= new OpenLayers.Icon('images/mm_20_white.png', size, offset);
		}
		if(stamp=="AC")
		{
			cIcon= new OpenLayers.Icon('images/t5.png', size, offset);
		}
		if(stamp=="DC")
		{
			cIcon= new OpenLayers.Icon('images/mm_20_yellow.png', size, offset);
		}
		if(stamp=="SI"||stamp=="OF")
		{
			cIcon= new OpenLayers.Icon('images/mm_20_green.png', new OpenLayers.Size(18,27), offset);
		}

			
			//mark.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat),cIcon));
			//mark.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat),cIcon.clone()));
		
	    var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
	              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
	              map1.getProjectionObject() // to Spherical Mercator Projection
	            ),cIcon);
	    
	    

	    
	   mark.events.register('mousedown', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
	      		new OpenLayers.LonLat(lon,lat).transform(
			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
			              map1.getProjectionObject() // to Spherical Mercator Projection
			            ),
	      		new OpenLayers.Size(250,100),
	      		html,
	      		true);
	    popup.closeOnMove = true; 
	      		 map1.addPopup(popup);
	          });

	      alert(i);
                          
	          

	    markers1.addMarker(mark);
		gmarkers[i] = mark;
    	htmls[i] = html;
    	i++;
        
        }
        catch(e)
        {
           // alert(e);
        }
	    
      }
    </script>
    
    <%
    System.out.println("**************        *************");
    %>
    </body>
    </html>