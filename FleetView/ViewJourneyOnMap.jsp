<%@ include file="headerpopup.jsp" %>
 <%@ page import="kml.KML1" %>
 <%classes fleetview=new classes(); 
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);%>
<%@page import="com.fleetview.beans.classes"%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>View Journey on Map</title>
    <link rel="stylesheet" href="../theme/default/style.css" type="text/css">
    <link rel="stylesheet" href="style.css" type="text/css">
<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
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
 <%! Connection conn,conn1,con;
Statement st,st1,st2,st3,st4,st5,stAC,stDisconn;
String htmlvis1,htmlvis2,sql,sql1,sql2,sql3,sql4,sql5,sqlware,data1,data2,vehcode,location,Stamp,label1,html1,html2,html11,html22,d1,d2,t1,t2,time1,time2,fromtime,totime,ftime1,ftime2,ttime1,ttime2;
String thedate="",thedate1="",startplace1="",endplace1="",thetime="",thetime1="",vehregno="",ownername="",lastlocation="",strtcode="",endcode="",startplace="",endplace="",enddate,sdate1,enddate1,stopdatetime, startdatetime,latStart="",longStart="",locationStart="",thedateStart="",thetimeStart="",firstlocation="-",location1="-";
String mydate1="",mydate2="";
String smap="",smap1="";
String gpname="",transporter="",gpname1="",ownername1="";
double lat, lat1, lon, lon1,latw,longw,latw1,longw1,lat11,lon11;
float slatitude=0,slongitude=0,elatitude=0,elongitude=0;
int show,dist;
boolean flag1=false,flag2=false;
String tripid = "",briefid = "",driverid = "",routeid = "";
String dates1[] = null,dates2[] = null,dates[] = null;
String day[] = null;
%>
 <%
    try
    {
         con = fleetview.ReturnConnection();
        // System.out.println("con   "+con);
    	st=con.createStatement();
    	st1 = con.createStatement();
    //	System.out.println("st   "+st);
    }
    catch(Exception e)
    {
    	System.out.println("====>error in connection");
    	e.printStackTrace();
    }
    
    html1 = "";location = "";
    lat = 0.0;lon = 0.0;
    data1 = "";data2 = "";
    tripid = request.getParameter("tripid");
    briefid = request.getParameter("briefid");
    driverid=  request.getParameter("driverid");
    routeid = request.getParameter("rid");
	String sql = "",startdate = "",enddate = "",daylist = "",dayquery = "";
	sql = "select start from db_gps.t_jrnyplanning where  Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  order by start limit 1";
	ResultSet rsdate = st.executeQuery(sql);
	if(rsdate.next())
	{
		startdate = rsdate.getString("start");
	}
	
	sql = "select end from db_gps.t_jrnyplanning where  Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  order by start desc limit 1";
	 rsdate = st.executeQuery(sql);
	if(rsdate.next())
	{
		enddate = rsdate.getString("end");
	}
	
	int k = 0,l = 0;
	if(request.getParameter("check")!=null)
	{
		//System.out.println("days    "+dates.length);
		daylist = "";
		k = 0;	
		dates= request.getParameterValues("check");
		l = dates.length -1;
	
		dates1 = new String[dates.length];
		dates2 = new String[dates.length];
		
		 for(int i = 0; i < dates.length; i++)
		 {			 
			 if(startdate.contains(dates[i]))
			 { 	 
				 dates1[i] = startdate;		
			 }
			 else
			 {
				 dates1[i] = dates[i]+" 00:00:00";
			 }
			 
			 if(enddate.contains(dates[i]))
			 { 	 
				 dates2[i] = enddate;		
			 }
			 else
			 {
				 dates2[i] = dates[i]+" 23:59:59";
			 }	 
			 
			 sql = "select Day from db_gps.t_jrnyplanning where  Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and start like '"+dates[i]+"%'  order by start limit 1 ";
			 rsdate = st.executeQuery(sql);
			 if(rsdate.next())
			 {
				 daylist+= rsdate.getString("Day")+",";
			 }
		 }	
		 
		 daylist=daylist.substring(0,daylist.length()-1);		 
		 dayquery = " and Day in ("+daylist+")";
		 day = daylist.split(",");
	}
	else
	{
		dates = null;
		dayquery = "";
	}
	
	// System.out.println("daylist   "+daylist);
	%>
    <br>
    <table style="text-align: center;margin-left: 48em;"><tr ><td>
<font size="2"><B>View Journey on Map</B></font></td></tr></table>
<table  border="0">
    <tr align="center">
    <td width="20%" valign="top">
    <form name="checkDates" method="get" action="" >
    <table>
    <tr> 
    <td><table class="sortable" border="1" style="width: 80%;">
    <tr>
    <th>Images</th>
    <th>Meaning</th>
    </tr>
    <tr><td width="50%"><img src="newimages/Green_Line.png" style="height: 3px;width: 70%;"></img></td>
    <td width="50%" style="text-align: left;">Planned Journey</td> </tr>
   <tr><td width="50%"><img src="newimages/Blue_Line.png" style="height: 3px;width: 70%;"></img></td>
    <td width="50%" style="text-align: left;">Actual Journey</td> </tr>
    <tr><td width="50%"><img src="newimages/source.png" style="width: 20px;height: 20px;"></img></td>
    <td width="50%" style="text-align: left;">Planned Start Location</td> </tr>
    <tr><td width="50%"><img src="images/mm_20_green.png"></img></td>
    <td width="50%" style="text-align: left;">Actual Start Location</td> </tr>
    <tr><td width="50%"><img src="newimages/dest.png" style="width: 20px;height: 20px;"></img></td>
    <td width="50%" style="text-align: left;">Planned Destination</td> </tr>
    <tr><td width="50%"><img src="images/mm_20_black.png" ></img></td>
    <td width="50%" style="text-align: left;">Current Location</td> </tr>
    <tr><td width="50%"><img src="newimages/tea.png" style="width: 25px;height: 25px;"></img></td>
    <td width="50%" style="text-align: left;">Planned Stop</td> </tr>
    <tr><td width="50%"><img src="images/mm_20_white.png"></img></td>
    <td width="50%" style="text-align: left;">Actual Stop</td> </tr>
    <tr><td width="50%"><img src="newimages/moon.png" style="width: 18px;height: 18px;"></img></td>
    <td width="50%" style="text-align: left;">Night Halt</td> </tr>
    </table><br></br></td>
    </tr>
    
   
   <%  
   int m = 0;
   sql = "select distinct(Day) as Day  from db_gps.t_jrnyplanning where  Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' order by Day";
  ResultSet rs = st.executeQuery(sql);
  while(rs.next())
  {
	  String date = "",date1 = "";
	  String sql1 = "select start from db_gps.t_jrnyplanning where  Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' and Day = '"+rs.getInt("Day")+"' order by start limit 1";
	  ResultSet rs1 = st1.executeQuery(sql1);
	  if(rs1.next())
	  {
		  date =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("start")));
		  date1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("start")));
	  }
	  
	  if(dates!=null)
	  {
	  boolean check = false;
	  for(int i = 0;i<dates.length;i++)
	  {
		  if(dates[i].contains(date1))
		  {
			  check = true;
			  break;
		  }
	  }
	  
	  if(check)
	  {
	  %>
	  <tr>	
	  <td>   
	 <font size="2" color="black"><input type="checkbox" name="check" value="<%=date1%>"  checked="checked" /><%=date%></font>
	</td></tr>
	  <%
	  }
	  else
	  {
		  %>
		  <tr>	  
		   <td>  
			 <font size="2" color="black"><input type="checkbox" name="check" value="<%=date1%>" /> <%=date%></font></td></tr>
			 	  
		<%
	  }
	 
  }
	  else
	  {
		  %>	
		  <tr>
		  <td>    
			 <font size="2" color="black"><input type="checkbox" name="check" value="<%=date1%>" /> <%=date%></font></td> </tr>
			 
		<%
	  }
  }
   %>
   
   
   <tr>
   <td>
   <br>
   <input type="hidden" name="tripid" value="<%=tripid %>">
    <input type="hidden" name="briefid" value="<%=briefid %>">
     <input type="hidden" name="driverid" value="<%=driverid %>">
      <input type="hidden" name="rid" value="<%=routeid %>">
   <input type="submit" name="submit" value="Submit"></td></tr>
    </table>
    </form>
    </td>
    <td align="center" width="90%">
    <div style="width:1000px; height:700px;text-align: center;" id="map"></div>
    <div align="right" style="width: 950px;"><font face="Arial" color="black">Copyright &copy; Transworld 2012.All rights reserved</font></div>
    </td>
    </tr>
 </table>
 
 <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>
    
 <script type="text/javascript">
    //<![CDATA[
    try
    {
    	 <%
    	 try
    	 {
    	 	conn = fleetview.ReturnConnection();
    	 	st=conn.createStatement();
    	 	st1=conn.createStatement();
    	 	st3=conn.createStatement();
    	 	st2=conn.createStatement();
    	 	st4=conn.createStatement();
    	 	st5=conn.createStatement();
    	 	stDisconn=conn.createStatement();
    	 	Class.forName(MM_dbConn_DRIVER); 
    	 	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    	 	stAC=conn1.createStatement();
    	 }
    	 catch(Exception e)
    	 {
    	 	out.print("Exception "+e);
    	 }
    	 %>

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

    	  function createMarker3(name,html,lat,lon)
    	  {
    		  try
    		    {
    	    	var cIcon;
    	    	var size = new OpenLayers.Size(15,18);
        		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
        		cIcon= new OpenLayers.Icon('images/mm_20_black.png', size, offset);
        		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
    		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    		              map1.getProjectionObject() // to Spherical Mercator Projection
    		            ),cIcon);

        		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
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

        		tmarkers[i] = mark;
            	htmls[i] = html;
            	i++;

            	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
          		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
          		        map1.getProjectionObject() // to Spherical Mercator Projection
          		      ),3);

            	return mark;
    		    }
    		    catch(e)
    		    {
    			    alert(e);
    		    }
    	  }
    	  
    	  function createMarker(name,html,stamp,lat,lon) 
    	  {
    		  try
    		  {
    		  var cIcon ;
    		  var size = new OpenLayers.Size(20,20);
        	  var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
        	  if(stamp=="Rest")
      		{
        		  size = new OpenLayers.Size(25,25);
        		  cIcon= new OpenLayers.Icon('newimages/tea.png', size, offset);
      		}
      		if(stamp=="Night Halt")
      		{
      			size = new OpenLayers.Size(20,20);
      			cIcon= new OpenLayers.Icon('newimages/moon.png', size, offset);
      		}
      		
      		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
    	              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    	              map1.getProjectionObject() // to Spherical Mercator Projection
    	            ),cIcon);

    	mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
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

    	tmarkers[i] = mark;
    	htmls[i] = html;
    	i++;
    		  }
    		  catch(e)
    		  {
    			 alert(e);
    		  }
    	return mark;
    	  }

    	  function createMarker4(name,html,lat,lon)
     	    {
     		    try
     		    {
     	    	var cIcon;
     	    	var size = new OpenLayers.Size(15,18);
         		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
         		cIcon= new OpenLayers.Icon('images/mm_20_green.png', size, offset);
         		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
     		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
     		              map1.getProjectionObject() // to Spherical Mercator Projection
     		            ),cIcon);

         		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
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

         		tmarkers[i] = mark;
             	htmls[i] = html;
             	i++;

             	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
           		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
           		        map1.getProjectionObject() // to Spherical Mercator Projection
           		      ),3);

             	return mark;
     		    }
     		    catch(e)
     		    {
     			 
     		    }
     		}

    	  function createMarker5(name,html,stamp,lat,lon)
   	    {
   		    try
   		    {
   	    	var cIcon;
   	    	var size = new OpenLayers.Size(15,18);
       		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
       		cIcon= new OpenLayers.Icon('images/mm_20_white.png', size, offset);
       		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
   		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
   		              map1.getProjectionObject() // to Spherical Mercator Projection
   		            ),cIcon);

       		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
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

       		tmarkers[i] = mark;
           	htmls[i] = html;
           	i++;

           	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
         		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
         		        map1.getProjectionObject() // to Spherical Mercator Projection
         		      ),3);

           	return mark;
   		    }
   		    catch(e)
   		    {
   			   // alert(e);
   		    }
   		}
    	  
    	   function createMarker2(name,html,lat,lon)
   	    {
   		    try
   		    {
   	    	var cIcon;
   	    	var size = new OpenLayers.Size(20,20);
       		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
       		cIcon= new OpenLayers.Icon('newimages/source.png', size, offset);
       		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
   		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
   		              map1.getProjectionObject() // to Spherical Mercator Projection
   		            ),cIcon);

       		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
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

       		tmarkers[i] = mark;
           	htmls[i] = html;
           	i++;

           	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
         		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
         		        map1.getProjectionObject() // to Spherical Mercator Projection
         		      ),3);

           	return mark;
   		    }
   		    catch(e)
   		    {
   			   // alert(e);
   		    }
   		}

    	   function createMarker1(name,html,lat,lon)
      	    {
      		    try
      		    {
      	    	var cIcon;
      	    	var size = new OpenLayers.Size(20,20);
          		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
          		cIcon= new OpenLayers.Icon('newimages/dest.png', size, offset);
          		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
      		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      		              map1.getProjectionObject() // to Spherical Mercator Projection
      		            ),cIcon);

          		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
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

          		tmarkers[i] = mark;
              	htmls[i] = html;
              	i++;

              	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
            		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
            		        map1.getProjectionObject() // to Spherical Mercator Projection
            		      ),3);

              	return mark;
      		    }
      		    catch(e)
      		    {
      			   // alert(e);
      		    }
      		}

    	  	var side_bar_html = "";
    	 	var side_bar_html1 = "";
    	  	var str;	
    	  	var tmarkers = [];
    	  	var tmarkerdis = [];
    	  	var htmls = [];
    	  	var htmldis = [];
    	  	var i = 0;dis=0;
    		var tmarkerstop = [];
    		var htmlstop = [];
    		var stopcnt = 0;
    		var tmarkerOS = [];
    		var htmlOS = [];
    		var OScnt = 0;
    		var tmarkerRA = [];
    		var htmlRA = [];
    		var RAcnt = 0;
    		var tmarkerRD = [];
    		var htmlRD = [];
    		var RDcnt = 0;
    		var tmarkerDisconn = [];
    		var htmlDisconn = [];
    		var Disconncnt = 0;
    		var url = "http://203.199.134.131:8008/mapguide/mapagent/mapagent.fcgi?USERNAME=Administrator&PASSWORD=admin";
			var metersPerUnit = 111319.4908;  //value returned from mapguide
			var inPerUnit = OpenLayers.INCHES_PER_UNIT.m * metersPerUnit;
			OpenLayers.INCHES_PER_UNIT["dd"] = inPerUnit;
			OpenLayers.INCHES_PER_UNIT["degrees"] = inPerUnit;
			OpenLayers.DOTS_PER_INCH = 72;
	  
			var	lo=77.2167510986328;
			var	la=28.5687255859375;
	 		var extent1 = new OpenLayers.Bounds(68.162834117480,6.7542559500000,97.41516105,37.06396505);
	 		var tempScales = [23659291,17074442,11322961,7588641,5059094,3372729,2248486,1498990,999327,666218,444145,296096,197397,131598,87732,58488,38992,25994,17329,11553,7702,5134,3423,2282,1521,1041,676,450,300,0];
	  		var mapOptions1 = 
		  	{
	    	maxExtent: extent1, 
	    	scales:tempScales,
	        units: "dd"
	  		};
	  		map1 = new OpenLayers.Map( 'map', mapOptions1 );
	  		map1.addControl(new OpenLayers.Control.PanZoomBar());
	  		map1.addControl(new OpenLayers.Control.OverviewMap());
	 		map1.addControl(new OpenLayers.Control.KeyboardDefaults());
	 		var params1 = 
		 	{
				mapdefinition: 'Library://TranswoldNew/test.MapDefinition',
			 	basemaplayergroupname: "Base Layer Group"
			}
			var options1 = 
   			{
				singleTile: true, isBaseLayer: true,
			    transitionEffect: "resize",
			    buffer: 1,
			    useOverlay: false,
			    useAsyncOverlay: false
			 }
			  //layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	 		<%

	 		//map integrate
	 		String sqlmap="select * from t_defaultvals where OwnerName='"+session.getAttribute("usertypevalue")+"'";
	 		//String sqlmap="select * from t_defaultvals where OwnerName='Castrol'";
	 		ResultSet rsmap=st4.executeQuery(sqlmap);
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
	 				ResultSet rsmap1=st2.executeQuery(sqlmap1);
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
		  	  markers1 = new OpenLayers.Layer.Markers( "Markers");
	  		  map1.addLayer(markers1);
	  		loadKML("KMLJRM/TWIndiaBoundry.kml");
	  		  
	  	   <%
	  		String sql11="",sql12 ="";
	  		ResultSet rst12 = null,rst = null,rst11 = null;
	  		String color="ff0BA903"; //green
	  		String color1 = "ffF4070B";//red
	  		String vehregno = "",vehcode = "";
			
			try
			{    	
			    sql1 = "select VehRegNo from db_gps.t_briefing where Briefid = '"+briefid+"' and tripid = '"+tripid+"' and Driverid = '"+driverid+"'";
			    rst = stDisconn.executeQuery(sql1);
			  //  System.out.println("sql last loc====>"+sql1);
			    if(rst.next())
			    {
			    	vehregno = rst.getString("VehRegNo");
			    }
			   // System.out.println("vehregno   "+vehregno);
			    
			    sql1 = "select vehiclecode from db_gps.t_vehicledetails where vehicleregnumber = '"+vehregno+"'";
			    rst = stDisconn.executeQuery(sql1);
			    if(rst.next())
			    {
			    	vehcode =  rst.getString("vehiclecode");
			    }		    	
			  //  System.out.println("vehcode   "+vehcode);	
			    
			    if(dates!=null)
			    {
			    	for(int i = 0; i < dates.length; i++)
					 {
			    		try
			    		{
			    		HashMap<String, String> coordinateMap = null;
						HashMap<String, String> coordinateMapStart = null;
						HashMap<String, String> coordinateMapEnd = null;
						List<HashMap<String, String>> coordinateList = null;
						  
						HashMap<String, String> actualcoordinateMap = null;
						HashMap<String, String> actualcoordinateMapStart = null;
						HashMap<String, String> actualcoordinateMapEnd = null;
						List<HashMap<String, String>> actualcoordinateList = null;    
						coordinateList=new ArrayList<HashMap<String, String>>();
						actualcoordinateList =new ArrayList<HashMap<String, String>>();
						
						sql12 = "select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and Day = '"+day[i]+"'  order by advancedtrackid asc ,row asc limit 1";
						rst12=stDisconn.executeQuery(sql12);
					//	System.out.println("sql last loc====>"+sql12);
						if(rst12.next())
						{
							//System.out.println("*****   1st location");
							mydate1 = rst12.getString("CumTime");
						    coordinateMapStart =  new java.util.HashMap<String, String>();
							coordinateMapStart.put("name",rst12.getString("Placename"));
							coordinateMapStart.put("desc", rst12.getString("Placename"));
							coordinateMapStart.put("lat",rst12.getString("latitude")); 
							coordinateMapStart.put("longi",rst12.getString("longitude"));  
						}
						
						sql1 = "select Placename,latitude,longitude from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  and Day = '"+day[i]+"'   order by advancedtrackid asc,row asc ";
						rst=stDisconn.executeQuery(sql1);
						while(rst.next())
						{ /**********record is added for- if no data then it will not come in while loop and willnot get ++ then not to show start point*************/
							coordinateMap =  new java.util.HashMap<String, String>();
						    coordinateMap.put("name",rst.getString("Placename"));
						    coordinateMap.put("desc", rst.getString("Placename"));
						    coordinateMap.put("lat",rst.getString("latitude")); 
						    coordinateMap.put("longi",rst.getString("longitude"));                         
						    coordinateList.add(coordinateMap);
//						      System.out.println("Coordlist----------"+coordinateMap.get("lat")+","+coordinateMap.get("longi"));
						}
						
						sql11 = "select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  and Day = '"+day[i]+"'  order by advancedtrackid desc ,row desc limit 1";		
						rst11=stDisconn.executeQuery(sql11);
					//	System.out.println("rst11====>"+sql11);
						if(rst11.next())
						{
							//System.out.println("*****   Last location");
							//System.out.println("1038 Hii");
							mydate2 = rst11.getString("CumTime");
						    coordinateMapEnd =  new java.util.HashMap<String, String>();
						    coordinateMapEnd.put("name",rst11.getString("Placename"));
						    coordinateMapEnd.put("desc", rst11.getString("Placename"));
						    coordinateMapEnd.put("lat",rst11.getString("latitude")); 
						    coordinateMapEnd.put("longi",rst11.getString("longitude"));   
						}	
						boolean flag=true;
						//sql1 = "select TheFieldSubject,LatinDec,LonginDec  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+dates1[i]+"' and Thefielddatadatetime <= '"+dates2[i]+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  and TheFieldSubject in (select distinct(TheFieldSubject)  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+dates1[i]+"' and Thefielddatadatetime <= '"+dates2[i]+"' and  thefielddatadatetime <> 'NULL'  and TheFiledTextFileName  NOT IN('AC','DC','OS')) order by  Thefielddatadatetime";
						sql1 = "select TheFieldSubject,LatinDec,LonginDec,Speed  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+dates1[i]+"' and Thefielddatadatetime <= '"+dates2[i]+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'   order by  Thefielddatadatetime";
						rst=stDisconn.executeQuery(sql1);
					//	 System.out.println("sql   "+sql1);
						 while(rst.next())
						 {
							 actualcoordinateMap =  new java.util.HashMap<String, String>();
							 if(rst.getInt("Speed")==0)
							{
								 if(flag)
								{
									actualcoordinateMap.put("name",rst.getString("TheFieldSubject"));
									actualcoordinateMap.put("desc", rst.getString("TheFieldSubject"));
									actualcoordinateMap.put("lat",rst.getString("LatinDec")); 
									actualcoordinateMap.put("longi",rst.getString("LonginDec"));   
									actualcoordinateList.add(actualcoordinateMap);
									 flag=false;
								}
							}
							 else
							 {
								 flag=true;
								 actualcoordinateMap.put("name",rst.getString("TheFieldSubject"));
								 actualcoordinateMap.put("desc", rst.getString("TheFieldSubject"));
								 actualcoordinateMap.put("lat",rst.getString("LatinDec")); 
								 actualcoordinateMap.put("longi",rst.getString("LonginDec"));   
								 actualcoordinateList.add(actualcoordinateMap);
							 }
							 ///System.out.println("****   ");
							
							
						 }
						 
						 sql1 = " select TheFieldSubject,LatinDec,LonginDec  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+dates1[i]+"' and Thefielddatadatetime <= '"+dates2[i]+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  order by Thefielddatadatetime asc limit 1";
						 rst=stDisconn.executeQuery(sql1);
						// System.out.println("sql   "+sql1);
						 if(rst.next())
						 {
							 actualcoordinateMapStart =  new java.util.HashMap<String, String>();
							 actualcoordinateMapStart.put("name",rst.getString("TheFieldSubject"));
							 actualcoordinateMapStart.put("desc", rst.getString("TheFieldSubject"));
							 actualcoordinateMapStart.put("lat",rst.getString("LatinDec")); 
							 actualcoordinateMapStart.put("longi",rst.getString("LonginDec"));  
						 }
						 
						 sql1 = " select TheFieldSubject,LatinDec,LonginDec  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+dates1[i]+"' and Thefielddatadatetime <= '"+dates2[i]+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  order by Thefielddatadatetime desc limit 1";
						 rst=stDisconn.executeQuery(sql1);
					//	 System.out.println("sql   "+sql1);
						 if(rst.next())
						 {
							 actualcoordinateMapEnd =  new java.util.HashMap<String, String>();
							 actualcoordinateMapEnd.put("name",rst.getString("TheFieldSubject"));
							 actualcoordinateMapEnd.put("desc", rst.getString("TheFieldSubject"));
							 actualcoordinateMapEnd.put("lat",rst.getString("LatinDec")); 
							 actualcoordinateMapEnd.put("longi",rst.getString("LonginDec"));  
						 }
						 
						
						String dir=request.getRealPath("/");
						dir=dir+"KML/"+"kml_"+tripid+"_"+briefid+"_"+i+".kml";	
						KML1 kml=new KML1();
						flag1=kml.generateKMLFORLINE(coordinateList,dir,coordinateMapStart,coordinateMapEnd,color);
						%>
						//var date1 = < %=mydate1%>;
						//var date2 = < %=mydate2%>;
						//alert("date1   "+date1);
						//alert("date2   "+date2);
						var filename="<%=tripid%>_<%=briefid%>";
						var num = "<%=i%>"
						var url="KML/kml_"+filename+"_"+num+".kml?date="+new Date().getTime();
						loadKML(url);	
						<%	
						String dir1 = request.getRealPath("/");
						dir1 = dir1+"KML/"+"actkml_"+tripid+"_"+briefid+"_"+i+".kml";
						KML1 kml1=new KML1();
						flag1=kml1.generateKMLFORLINE(actualcoordinateList,dir1,actualcoordinateMapStart,actualcoordinateMapEnd,color1);
						%>
						var filename1="<%=tripid%>_<%=briefid%>";
						var url1="KML/actkml_"+filename1+"_"+num+".kml?date="+new Date().getTime();
						loadKML(url1);	
						<%
						
			    		}
			    		catch(Exception  e)
			    		{
			    			System.out.println("Exception--->    "+e);
			    		}
					 }		    	
			    }
			    else
			    {
			    	HashMap<String, String> coordinateMap = null;
					HashMap<String, String> coordinateMapStart = null;
					HashMap<String, String> coordinateMapEnd = null;
					List<HashMap<String, String>> coordinateList = null;
					  
					HashMap<String, String> actualcoordinateMap = null;
					HashMap<String, String> actualcoordinateMapStart = null;
					HashMap<String, String> actualcoordinateMapEnd = null;
					List<HashMap<String, String>> actualcoordinateList = null;    
					coordinateList=new ArrayList<HashMap<String, String>>();
					actualcoordinateList =new ArrayList<HashMap<String, String>>();
			    	
			    sql12 = "select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid asc ,row asc limit 1";
				rst12=stDisconn.executeQuery(sql12);
				//System.out.println("sql last loc====>"+sql12);
				if(rst12.next())
				{
					//System.out.println("*****   1st location");
					mydate1 = rst12.getString("CumTime");
				    coordinateMapStart =  new java.util.HashMap<String, String>();
					coordinateMapStart.put("name",rst12.getString("Placename"));
					coordinateMapStart.put("desc", rst12.getString("Placename"));
					coordinateMapStart.put("lat",rst12.getString("latitude")); 
					coordinateMapStart.put("longi",rst12.getString("longitude"));  
				}
				
				sql1 = "select Placename,latitude,longitude from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  "+dayquery+"  order by advancedtrackid asc,row asc ";
				rst=stDisconn.executeQuery(sql1);
				while(rst.next())
				{ /**********record is added for- if no data then it will not come in while loop and willnot get ++ then not to show start point*************/
					coordinateMap =  new java.util.HashMap<String, String>();
				    coordinateMap.put("name",rst.getString("Placename"));
				    coordinateMap.put("desc", rst.getString("Placename"));
				    coordinateMap.put("lat",rst.getString("latitude")); 
				    coordinateMap.put("longi",rst.getString("longitude"));                         
				    coordinateList.add(coordinateMap);
//				      System.out.println("Coordlist----------"+coordinateMap.get("lat")+","+coordinateMap.get("longi"));
				}
				
				sql11 = "select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid desc ,row desc limit 1";		
				rst11=stDisconn.executeQuery(sql11);
				//	System.out.println("rst11====>"+rst11);
				if(rst11.next())
				{
					//System.out.println("*****   Last location");
					//System.out.println("1038 Hii");
					mydate2 = rst11.getString("CumTime");
				    coordinateMapEnd =  new java.util.HashMap<String, String>();
				    coordinateMapEnd.put("name",rst11.getString("Placename"));
				    coordinateMapEnd.put("desc", rst11.getString("Placename"));
				    coordinateMapEnd.put("lat",rst11.getString("latitude")); 
				    coordinateMapEnd.put("longi",rst11.getString("longitude"));   
				}	
				boolean flag=true;
		//		sql1 = "select TheFieldSubject,LatinDec,LonginDec  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+startdate+"' and Thefielddatadatetime <= '"+enddate+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  and TheFieldSubject in (select distinct(TheFieldSubject)  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+startdate+"' and Thefielddatadatetime <= '"+enddate+"' and  thefielddatadatetime <> 'NULL'  and TheFiledTextFileName  NOT IN('AC','DC','OS')) order by  Thefielddatadatetime";
				sql1 = "select TheFieldSubject,LatinDec,LonginDec,speed  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+startdate+"' and Thefielddatadatetime <= '"+enddate+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'   order by thefielddatadatetime";

				rst=stDisconn.executeQuery(sql1);
				// System.out.println("sql   "+sql1);
				 while(rst.next())
				 {
					 actualcoordinateMap =  new java.util.HashMap<String, String>();
					 if(rst.getInt("Speed")==0)
					 {
							if(flag)
							{	
							//	System.out.println("******    "+rst.getString("TheFieldSubject"));
					 			actualcoordinateMap.put("name",rst.getString("TheFieldSubject"));
								actualcoordinateMap.put("desc", rst.getString("TheFieldSubject"));
					 			actualcoordinateMap.put("lat",rst.getString("LatinDec")); 
					 			actualcoordinateMap.put("longi",rst.getString("LonginDec"));   
								actualcoordinateList.add(actualcoordinateMap);
								flag=false;
							}
					 }
					 else
					 {
						// System.out.println("******    "+rst.getString("TheFieldSubject"));
						 flag=true;
						 actualcoordinateMap.put("name",rst.getString("TheFieldSubject"));
						 actualcoordinateMap.put("desc", rst.getString("TheFieldSubject"));
						 actualcoordinateMap.put("lat",rst.getString("LatinDec")); 
						 actualcoordinateMap.put("longi",rst.getString("LonginDec"));   
						 actualcoordinateList.add(actualcoordinateMap);
					 }
				 }
				 
				 sql1 = " select TheFieldSubject,LatinDec,LonginDec  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+startdate+"' and Thefielddatadatetime <= '"+enddate+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  order by Thefielddatadatetime asc limit 1";
				 rst=stDisconn.executeQuery(sql1);
				// System.out.println("sql   "+sql1);
				 if(rst.next())
				 {
					 actualcoordinateMapStart =  new java.util.HashMap<String, String>();
					 actualcoordinateMapStart.put("name",rst.getString("TheFieldSubject"));
					 actualcoordinateMapStart.put("desc", rst.getString("TheFieldSubject"));
					 actualcoordinateMapStart.put("lat",rst.getString("LatinDec")); 
					 actualcoordinateMapStart.put("longi",rst.getString("LonginDec"));  
				 }
				 
				 sql1 = " select TheFieldSubject,LatinDec,LonginDec  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+startdate+"' and Thefielddatadatetime <= '"+enddate+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  order by Thefielddatadatetime desc limit 1";
				 rst=stDisconn.executeQuery(sql1);
			//	 System.out.println("sql   "+sql1);
				 if(rst.next())
				 {
					 actualcoordinateMapEnd =  new java.util.HashMap<String, String>();
					 actualcoordinateMapEnd.put("name",rst.getString("TheFieldSubject"));
					 actualcoordinateMapEnd.put("desc", rst.getString("TheFieldSubject"));
					 actualcoordinateMapEnd.put("lat",rst.getString("LatinDec")); 
					 actualcoordinateMapEnd.put("longi",rst.getString("LonginDec"));  
				 }
				 
			
			//System.out.println("*****  mydate1   "+mydate1+"   mydate2   "+mydate2);
			//System.out.println("*****  coordinateList   "+coordinateList);
		//	System.out.println("*****  coordinateMapEnd   "+coordinateMapEnd);
			try
			{
				String dir=request.getRealPath("/");
				dir=dir+"KML/"+"kml_"+tripid+"_"+briefid+".kml";	
				KML1 kml=new KML1();
				flag1=kml.generateKMLFORLINE(coordinateList,dir,coordinateMapStart,coordinateMapEnd,color);
				%>
				//var date1 = < %=mydate1%>;
				//var date2 = < %=mydate2%>;
				//alert("date1   "+date1);
				//alert("date2   "+date2);
				var filename="<%=tripid%>_<%=briefid%>";
				var url="KML/kml_"+filename+".kml?date="+new Date().getTime();
				loadKML(url);	
				<%	
				String dir1 = request.getRealPath("/");
				dir1 = dir1+"KML/"+"actkml_"+tripid+"_"+briefid+"_act.kml";
				KML1 kml1=new KML1();
				flag1=kml1.generateKMLFORLINE(actualcoordinateList,dir1,actualcoordinateMapStart,actualcoordinateMapEnd,color1);
				%>
				var filename1="<%=tripid%>_<%=briefid%>_act";
				var url1="KML/actkml_"+filename1+".kml?date="+new Date().getTime();
				loadKML(url1);	
				<%
			}
			catch(Exception   e)
			{
				System.out.println("YYYYYYY    "+e);
			}
			}
			}
			catch(Exception e)
			{
			    System.out.println("Exception ----------->    "+e);
			}
			%>
			/*var size = new OpenLayers.Size(12,18);
			var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
			var iconn = new OpenLayers.Icon('images/mm_20_red.png', size, offset);*/
 	  
		    markers = new OpenLayers.Layer.Markers( "Markers");
			map1.addLayer(markers);
		
	  		map1.setCenter(new OpenLayers.LonLat(77.768553,23.402765).transform(
		    new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		    map1.getProjectionObject() // to Spherical Mercator Projection
		     ),3);

		    map1.events.register('zoomend', map1, function(evt)
            {
        	var zoom = map1.getZoom();
      		//  alert(zoom);
            });

    
    	<%
   		 try
    	{
    	 	sql12="select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid asc ,row asc limit 1";
    		// System.out.println("sql start loc====>"+sql12);
			 rst12=st.executeQuery(sql12);
		 	if(rst12.next())
		 	{
			    lat=rst12.getDouble("latitude");
				lon=rst12.getDouble("longitude");
				location=rst12.getString("Placename");
			
				String dt1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst12.getString("CumTime")));
				html2="<b>Start location:</b><br>"+location+"<br><b>Date Time : </b>"+dt1;
				%>
				//document.getElementById("strtloc11").innerHTML=< %=location%>;
				var marker1 = createMarker2("<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
			 	markers.addMarker(marker1);    	   
				<%
			}
		
		
			sql12="select Placename,latitude,longitude,CumTime,Event from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and event in ('Night Halt','Rest')  "+dayquery+"  order by advancedtrackid asc,row asc";
  			// 	 System.out.println("sql start loc====>"+sql12);
			rst12=st.executeQuery(sql12);
			while(rst12.next())
			{
			   	String dur = "",datetime = "";
				String sql13 = "select stopDuration,End  from db_gps.t_jrnyplanning where Tripid = '"+tripid+"'  and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and Destination = '"+rst12.getString("Placename")+"'";
				ResultSet rs13 = st3.executeQuery(sql13);
				if(rs13.next())
				{
					dur =new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs13.getString("stopDuration")));
					datetime = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs13.getString("End")));
				}
			
				label1="<b>"+rst12.getString("Event")+"</b><br><b>Date Time : </b>"+datetime+"<br><b>Duration : </b>" +dur+ " Sec.<br><b>Location : </b>"+rst12.getString("Placename");
				%>  
				var marker = createMarker("<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","<%=rst12.getString("Event")%>",<%= rst12.getString("latitude")%>,<%= rst12.getString("longitude")%>);
				markers.addMarker(marker);	
				<%
			
			}
		
			sql12="select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid desc ,row desc limit 1";
	 		 // 	 System.out.println("sql start loc====>"+sql12);
			rst12=st.executeQuery(sql12);
			while(rst12.next())
			{
				lat=rst12.getDouble("latitude");
				lon=rst12.getDouble("longitude");
				location=rst12.getString("Placename");
				
				String dt1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst12.getString("CumTime")));
				html2="<b>End location:</b><br>"+location+"<br><b>Date Time : </b>"+dt1;
				%>
				//document.getElementById("strtloc11").innerHTML=< %=location%>;
				var marker1 = createMarker1("<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
			 	markers.addMarker(marker1); 	   
				<%			
			}
			
			sql12 = "select TheFieldSubject,LatinDec,LonginDec,TheFieldDataDateTime  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+startdate+"' and Thefielddatadatetime <= '"+enddate+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  order by Thefielddatadatetime desc limit 1";
			rst12 = st.executeQuery(sql12);
			//System.out.println("&&&   End location  sql12   "+sql12);
			if(rst12.next())
			{
				//System.out.println("&&&   End location   ");
				lat=rst12.getDouble("LatinDec");
				lon=rst12.getDouble("LonginDec");
				location=rst12.getString("TheFieldSubject");
			
				String dt1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst12.getString("TheFieldDataDateTime")));
				html2="<b>Current location:</b><br>"+location+"<br><b>Date Time : </b>"+dt1;
				%>
				//document.getElementById("strtloc11").innerHTML=< %=location%>;
				var marker1 = createMarker3("<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
			 	markers.addMarker(marker1); 	   
				<%
			}
			
			sql12="select TheFieldSubject,LatinDec,LonginDec,TheFieldDataDateTime  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+startdate+"' and Thefielddatadatetime <= '"+enddate+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  order by Thefielddatadatetime asc limit 1";
	   		 // System.out.println("sql start loc====>"+sql12);
			 rst12=st.executeQuery(sql12);
			if(rst12.next())
			{
				lat=rst12.getDouble("LatinDec");
				lon=rst12.getDouble("LonginDec");
				location=rst12.getString("TheFieldSubject");
			
				String dt1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst12.getString("TheFieldDataDateTime")));
				html2="<b>Start location:</b><br>"+location+"<br><b>Date Time : </b>"+dt1;
				%>
				//document.getElementById("strtloc11").innerHTML=< %=location%>;
				var marker1 = createMarker4("<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
				 markers.addMarker(marker1);    	   
				<%
			}
			
			if(dates!=null)
		    {
				for(int i = 0; i < dates.length; i++)
				 {
					sql12 = "select * from db_gpsExceptions.t_veh"+vehcode+"_stsp where concat(FromDate,' ',FromTime) >= '"+dates1[i]+"' and concat(FromDate,' ',FromTime) <= '"+dates2[i]+"' and Duration >= '00:15:00' ";
					rst12 = st.executeQuery(sql12);
				//	System.out.println(sql12);
					while(rst12.next())
					{
						String sql13 = "select * from db_gps.t_veh"+vehcode+"  where thefieldsubject = '"+rst12.getString("Location")+"'  and thefielddatadatetime >= '"+dates1[i]+"'  and  thefielddatadatetime <= '"+dates2[i]+"'  limit 1";
						ResultSet rst13 = st3.executeQuery(sql13);
					//	System.out.println(sql13);
						if(rst13.next())
						{					
							label1="<b>Stop </b><br><b>Date Time : </b>"+rst12.getString("FromDate")+" "+rst12.getString("FromTime")+"<br><b>Duration : </b>" +rst12.getString("Duration")+ " Sec.<br><b>Location : </b>"+rst12.getString("Location");
							%>  
							var marker = createMarker5("<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","Stop",<%= rst13.getString("LatinDec")%>,<%= rst13.getString("LonginDec")%>);
							markers.addMarker(marker);	
							<%
						}
					}
				    
				 }
		    }
		    else
		    {			
			sql12 = "select * from db_gpsExceptions.t_veh"+vehcode+"_stsp where concat(FromDate,' ',FromTime) >= '"+startdate+"' and concat(FromDate,' ',FromTime) <= '"+enddate+"' and Duration >= '00:15:00' ";
			rst12 = st.executeQuery(sql12);
		//	System.out.println(sql12);
			while(rst12.next())
			{
				String sql13 = "select * from db_gps.t_veh"+vehcode+"  where thefieldsubject = '"+rst12.getString("Location")+"'  and thefielddatadatetime >= '"+startdate+"'  and  thefielddatadatetime <= '"+enddate+"'  limit 1";
				ResultSet rst13 = st3.executeQuery(sql13);
			//	System.out.println(sql13);
				if(rst13.next())
				{					
					label1="<b>Stop </b><br><b>Date Time : </b>"+rst12.getString("FromDate")+" "+rst12.getString("FromTime")+"<br><b>Duration : </b>" +rst12.getString("Duration")+ " Sec.<br><b>Location : </b>"+rst12.getString("Location");
					%>  
					var marker = createMarker5("<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","Stop",<%= rst13.getString("LatinDec")%>,<%= rst13.getString("LonginDec")%>);
					markers.addMarker(marker);	
					<%
				}
			}
		    }
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
   		 %>
     // }

	    //  initialize();
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
        alert(e);
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
    
   
    </script>
    
    <%
  //  System.out.println("**************        *************");
    %>
    </body>
    </html>