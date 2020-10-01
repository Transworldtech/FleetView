<%@ include file="headerpopup.jsp" %>
 <%@ page import="kml.KML1" %>
 <%classes fleetview=new classes(); 
 String MM_dbConn_STRING = "jdbc:mysql://192.168.2.55/db_gps" ;
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
String gpname="",transporter="",gpname1="",ownername1="";
double lat, lat1, lon, lon1,latw,longw,latw1,longw1,lat11,lon11;
float slatitude=0,slongitude=0,elatitude=0,elongitude=0;
int show,dist;
boolean flag1=false,flag2=false;
String tripid = "",briefid = "",driverid = "",routeid = "";
String dates1[] = null,dates2[] = null,dates[] = null;
String day[] = null;
String UnitId="",idate="";
String from_date="",to_date="";

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
    UnitId = request.getParameter("unitid");
    from_date=request.getParameter("from_date");
    to_date=request.getParameter("to_date");
    idate = request.getParameter("idate");
    System.out.println("idate   "+idate);
    
	String sql = "",startdate = "",enddate = "",daylist = "",dayquery = "";

	
	
	// System.out.println("daylist   "+daylist);
	%>
    <br>
    <table style="text-align: center;margin-left: 48em;"><tr ><td>
<font size="2"><B>View Journey on Map</B></font></td></tr></table>
<table  border="0">
    <tr align="center">
    <td width="20%" valign="top">
    
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
    	 	st5=conn.createStatement();
    	 	stDisconn=conn.createStatement();
    	 	Class.forName(MM_dbConn_DRIVER); 
    	 	//MM_dbConn_STRING1 = "jdbc:mysql://192.168.2.55/db_gps" ;
    	 	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    	 	stAC=conn1.createStatement();
    	 }
    	 catch(Exception e)
    	 {
    	 	out.print("Exception "+e);
    	 }
    	 %>

    	  function loadKML(url)
    	  {
  	        try
  	        {
  	  	  
  	        	//alert("inside load kml function");
  	        	//alert("url==>"+url);
  	        	
  	        	
  	        	
  	        	
  	        	map1.addLayer(new OpenLayers.Layer.GML("KML",url, 
  	  	          {
  	  	           format: OpenLayers.Format.KML, 
  	  	           formatOptions: 
  	  	  	       {
  	  	             extractStyles: true, 
  	  	         	 extractAttributes: true
  	  	             
  	  	             
  	  	           }
  	  	          }
  	        	
  	        	
  	        	));
  	        }
  	        catch(e)
  	        {
  	            //alert("%%%%%%%%%%%%%%%"+e);
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
           		      ),10);

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
         		      ),10);

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
         		      ),10);

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
            		      ),10);

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
			  layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	  		  map1.addLayer(layer1);
		  	  markers1 = new OpenLayers.Layer.Markers( "Markers");
	  		  map1.addLayer(markers1);
	  		  
	  	   <%
	  		String sql11="",sql12 ="";
	  		ResultSet rst12 = null,rst = null,rst11 = null;
	  		String color="ff0BA903"; //green
	  		String color1 = "ffF4070B";//red
	  		String vehregno = "",vehcode = "";
	  		String lat1="",Long1="";
			try
			{    	
			   
			  
			    	HashMap<String, String> coordinateMap = null;
					HashMap<String, String> coordinateMapStart = null;
					HashMap<String, String> coordinateMapEnd = null;
					List<HashMap<String, String>> coordinateList = null;
					  
					
					coordinateList=new ArrayList<HashMap<String, String>>();
				//from_date=request.getParameter("from_date");
    			//to_date=request.getParameter("to_date");
			    
    			
    			
    			
			     sql12 = "select lati,longi from db_gps.t_processincident where unitid = '"+UnitId+"'  and  stampdate ='"+idate+"'  and stampdate>='"+from_date+"' and stampdate <= '"+to_date+"' order by stampdate,stamptime asc limit 1 ";
			    //sql12 = "select lati,longi from db_gps.t_processincident where (unitid,stampdate)=('"+UnitId+"','"+idate+"') order by stampdate,stamptime asc limit 1";
			  
			    //System.out.println("sql ___@@@@@@2_______====>"+sql12);
			    rst12=stDisconn.executeQuery(sql12);
				System.out.println("sql last loc====>"+sql12);
				if(rst12.next())
				{
					//System.out.println("*****   1st location");
					coordinateMapStart =  new java.util.HashMap<String, String>();
					coordinateMapStart.put("lat",rst12.getString("lati")); 
					coordinateMapStart.put("longi",rst12.getString("longi"));  
				}
				
				
				
				//*********sql1 = "select lati,longi from db_gps.t_processincident where (unitid,stampdate)=('"+UnitId+"','"+idate+"')   order by stampdate,stamptime asc";
				
				
				//sql1 = "select lati,longi from db_gps.t_processincident where (unitid,stampdate)=('"+UnitId+"','"+idate+"')   order by stampdate,stamptime asc";
				sql1 = "SELECT lati,longi from db_gps.t_processincident  WHERE unitid = '"+UnitId+"'  and  stampdate = '"+idate+"' and stampdate>='"+from_date+"' and stampdate <= '"+to_date+"'  order by stampdate,stamptime asc  ";
				//sql1 = "SELECT * FROM (	SELECT	@row := @row +1 AS rownum, lati,longi,unitid,stampdate FROM (SELECT @row :=0) r,db_gps.t_processincident) ranked	WHERE (unitid,stampdate)=('"+UnitId+"','"+idate+"')  and rownum %10 =1";													 
				
				
					//System.out.println("sql1_____ ====>"+sql1);
				rst=stDisconn.executeQuery(sql1);
				System.out.println("sql1 ====>"+sql1);
				
				while(rst.next())
				{ /**********record is added for- if no data then it will not come in while loop and willnot get ++ then not to show start point*************/
					coordinateMap =  new java.util.HashMap<String, String>();
				    coordinateMap.put("lat",rst.getString("lati")); 
				    coordinateMap.put("longi",rst.getString("longi"));                         
				    coordinateList.add(coordinateMap);
//				      System.out.println("Coordlist----------"+coordinateMap.get("lat")+","+coordinateMap.get("longi"));
				}
				
				sql11 = "select lati,longi from db_gps.t_processincident where unitid ='"+UnitId+"'  and  stampdate ='"+idate+"' and stampdate>='"+from_date+"' and stampdate <= '"+to_date+"' order by stampdate,stamptime DESC limit 1";	
				//sql11 = "select lati,longi from db_gps.t_processincident where (unitid,stampdate)=('"+UnitId+"','"+idate+"') order by stampdate,stamptime DESC limit 1";
				//System.out.println("sql11 ==____$$$$44==>"+sql11);
				rst11=stDisconn.executeQuery(sql11);
				
				//	System.out.println("rst11====>"+rst11);
				
				
				System.out.println("sql11 ====>"+sql11);
				if(rst11.next())
				{
					//System.out.println("*****   Last location");
					//System.out.println("1038 Hii");
					coordinateMapEnd =  new java.util.HashMap<String, String>();
				  
				    coordinateMapEnd.put("lat",rst11.getString("lati")); 
				    coordinateMapEnd.put("longi",rst11.getString("longi"));
				    lat1=rst11.getString("lati");
				    Long1 =rst11.getString("longi");
				}	
				boolean flag=true;
		//		sql1 = "select TheFieldSubject,LatinDec,LonginDec  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+startdate+"' and Thefielddatadatetime <= '"+enddate+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  and TheFieldSubject in (select distinct(TheFieldSubject)  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+startdate+"' and Thefielddatadatetime <= '"+enddate+"' and  thefielddatadatetime <> 'NULL'  and TheFiledTextFileName  NOT IN('AC','DC','OS')) order by  Thefielddatadatetime";
								 
			
			//System.out.println("*****  mydate1   "+mydate1+"   mydate2   "+mydate2);
			//System.out.println("*****  coordinateList   "+coordinateList);
		//	System.out.println("*****  coordinateMapEnd   "+coordinateMapEnd);
			try
			{
				String dir=request.getRealPath("/");//
				System.out.println("in the INCIVIEWJRNYONMAP and the real path is :- "+dir);
				dir=dir+"KML/"+"kml_"+tripid+"_"+briefid+".kml";	
				System.out.println("in the INCIVIEWJRNYONMAP and the real path is (After appending):- "+dir);
				KML1 kml=new KML1();
				flag1=kml.generateKMLFORLINE(coordinateList,dir,coordinateMapStart,coordinateMapEnd,color);
				%>
				//var date1 = < %=mydate1%>;
				//var date2 = < %=mydate2%>;
				//alert("date1   "+date1);
				//alert("date2   "+date2);
				var filename="<%=tripid%>_<%=briefid%>";
				alert("filename is:- "+filename);//filename is:- _
				var url="KML/kml_"+filename+".kml?date="+new Date().getTime();
				alert("url is:- "+url);
				
				// KML/kml__.kml?date=1383822992102
				
				loadKML(url);	
				
				
				map1.setCenter(new OpenLayers.LonLat(<%=Long1 %>,<%=lat1 %>).transform(
					    new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
					    map1.getProjectionObject() // to Spherical Mercator Projection
					     ),10);
				
				<%	
				
			}
			catch(Exception   e)
			{
				System.out.println("YYYYYYY    "+e);
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
		
	  		map1.setCenter(new OpenLayers.LonLat(<%=Long1 %>,<%=lat1 %>).transform(
		    new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		    map1.getProjectionObject() // to Spherical Mercator Projection
		     ),30);

		    map1.events.register('zoomend', map1, function(evt)
            {
        	var zoom = map1.getZoom();
      		//  alert(zoom);
            });

    
    	<%
   		
   		 %>
     

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
