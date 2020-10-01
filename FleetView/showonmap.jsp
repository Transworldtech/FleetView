<%@ include file="headernew.jsp" %>
<%@page import="com.sun.corba.se.impl.transport.SelectorImpl,java.util.*,java.io.File,java.io.FileOutputStream,java.util.ArrayList, java.util.Iterator,java.util.Map,java.util.HashMap,java.io.*"%>
<%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader ("Expires", 0);
%>
	
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
	<%
	fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	%>
	
	<html>
	<body >
	 <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAxjYame-JZRGh_FJuRBWlpBTlmEuEpA44GFjXbE_lz5qAkNbkwRTH_hHi4lHI7l-DNA8SyPlaWk0dhw" type="text/javascript"></script>
<!-- <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAxjYame-JZRGh_FJuRBWlpBQjodmHlgj7iM0x8Q_TvP1ioL-trBTPHJlaGlEfucDMTxWYtkFsXS6wNw" type="text/javascript"></script> -->

<script type="text/javascript">
	
			function ajaxFunction(xx)
			{
			
			var ajaxRequest;  // The variable that makes Ajax possible!
				try
				{
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
				
			// Create a function that will receive data sent from the server
			ajaxRequest.onreadystatechange = function()
				{
					if(ajaxRequest.readyState == 4)
			                {
			                	var reslt=ajaxRequest.responseText;
			                	document.getElementById("reportdiv").innerHTML=reslt;
					}
				}
			if(xx==1)
			{
			ajaxRequest.open("GET", "tripos.jsp", true);
			}
			if(xx==2)
			{
			ajaxRequest.open("GET", "tripac.jsp", true);
			}
			if(xx==3)
			{
			ajaxRequest.open("GET", "tripdc.jsp", true);
			}
			if(xx==4)
			{
			ajaxRequest.open("GET", "tripst.jsp", true);
			}
			ajaxRequest.send(null); 
			}

			 var map;
			 var geoXml;
			 var toggleState = 1;
						
			
			
</script>
	
	<%!
	Connection conn;
	Statement st=null, stmt=null,st1=null,st2=null;
	%>
	<% 
		List coordinateList = new ArrayList();
		String fileName =request.getRealPath("/")+"kml_runtime_gen/MyKmlLineDB1.kml";
		System.out.println("=====filename===="+fileName);
		java.util.HashMap coordinateMap = null;
		String name = "";
		String description="";
		String coordinates = "";
		
		try
			{
					System.out.println("=====In side getMapDetails====");
					//Class.forName("org.gjt.mm.mysql.Driver");
					System.out.println("--1--");
					//Connection conn= DriverManager.getConnection("jdbc:mysql://localhost/db_MyMapDemo","root","flashkit");
					System.out.println("--2--");
					String sql="SELECT * FROM t_onlinedata where TheDate >='2010-03-01'"; // select query which will provide ist of all required details
					System.out.println("SQL::->"+sql);
					Statement stmt = conn.createStatement();
					
					ResultSet rststmt=stmt.executeQuery(sql);
					
					//java.util.HashMap.coordinateName=null;
					String coordinateString = "";//,coordinateName="",coordinateDesc="";
					while(rststmt.next())
					{
						System.out.println("=====In side getMapDetails== rst.nxt()==");
						coordinateMap =  new java.util.HashMap();
						
						coordinateMap.put("name", rststmt.getString("VehicleRegNo"));
						coordinateMap.put("desc", rststmt.getString("Location"));
						coordinateMap.put("lat",rststmt.getString("LatitudePosition"));
						coordinateMap.put("longi",rststmt.getString("LongitudePosition"));				
						coordinateList.add(coordinateMap);
						System.out.println("\ncoordinateString===>>"+coordinateList);
					}
					
				}catch(Exception e)
				{
					System.out.println("=====In side getMapDetails===Exception=");
					e.printStackTrace();
				}

				System.out.println(":::GEN KML CALLED::::");
				String outputString ="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"+
									 "<kml xmlns=\"http://www.opengis.net/kml/2.2\">\n" +
						"   <Document>";
				
				
				for (Iterator iterator = coordinateList.iterator(); iterator.hasNext();)
				{
					java.util.HashMap	coordinateMap1 = (java.util.HashMap) iterator.next();
					
					//this is for creating line item
					coordinates+= coordinateMap1.get("lat") + "," +coordinateMap1.get("longi")+",0 ";
					
					name = (String)coordinateMap1.get("name");
					description = (String)coordinateMap1.get("desc");
					
					
					// Creating Point item
					outputString +="<Placemark>\n" +
				   		"<name>"+name+"</name>\n"+
				   		"<description>"+description+"</description>\n";
						outputString +="<Point>\n"+
			   								"<coordinates>"+coordinateMap1.get("lat")+","+coordinateMap1.get("longi")+"</coordinates>\n"+
			   							"</Point>\n"+
			   						"</Placemark>\n";
				}
				
				// Creating LineString
				outputString +="<Placemark>\n" +
		   		"<name>"+name+"</name>\n"+
		   		"<description>"+description+"</description>\n";
				outputString +="<LineString>\n"+
										"<coordinates>"+coordinates+"</coordinates>\n"+
									"</LineString>\n"+
								"</Placemark>\n";
				
				outputString +="</Document>\n"+
								"</kml>\n";
		
				System.out.println("Generated KML file :::\n"+outputString);
				try
				{
					File f=new File(fileName);
					FileOutputStream fop=new FileOutputStream(f);
					fop.write(outputString.getBytes());
					fop.close();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
		


	%>	
	<%
		String sql=null,tripid="",vehcode="",sdate="",Stamp="",label1="",sql1=null,sql2=null,sql3=null,osstr,acstr,dcstr,ststr,pg,colorcode,nstd,nspd;
		String lat="", lon="",location="",thedate="",thedate1="",thetime="",thetime1="",lat1="",lon1="",vehregno="",ownername="",lastlocation="",startplace,endplace,enddate,sdate1,enddate1,stopdatetime, startdatetime,latStart="",longStart="",locationStart="",thedateStart="",thetimeStart="",firstlocation="-",location1="-";
		int oscount,account,dccount,stcount,dist,dist1,distance,distStart;
		double latx,lonx,latx1,lonx1;
		String ColorCode="",ColorCode1="";
		String distTrav="-";
		
		stopdatetime="-";
		startdatetime="-";
		dist=0;
		dist1=0;
		distance=0;
		oscount=0;
		account=0;
		dccount=0;
		stcount=0;
		pg=request.getParameter("pg");
		session.setAttribute("pg",pg);
		sdate=request.getParameter("sdate");
		enddate=request.getParameter("enddate");
		startplace=request.getParameter("startplace");
		session.setAttribute("tripstartplace",startplace);
		endplace=request.getParameter("endplace");
		session.setAttribute("tripendplace",endplace);
		tripid=request.getParameter("tripid");
		vehcode=request.getParameter("vehcode");
		vehregno=request.getParameter("vehregno");
		session.setAttribute("tripvehregno",vehregno);
		ownername=request.getParameter("ownername");
		session.setAttribute("tripownername",ownername);
		session.setAttribute("tripid",tripid);
		session.setAttribute("tripenddate",enddate);
		session.setAttribute("tripstartdate",sdate);
	
	%>
		<table border="0" width="100%" bgcolor="white">
		<tr><td colspan="2" align="center">
		<font size="3">
		<!-- <div align="left">Report No:1.13</div>-->
		<b>Trip On Map</b>
		</font>
		</td></tr>
		<tr><td colspan="2">
		<div align='left'>
		<font size="3"><B>
		The Trip Report For Vehicle <%=vehregno %> From Date 
		<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate)) %>
		<%
		if(pg.equals("cm"))
		{
		java.util.Date ed1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddate);
		Format fmt2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
		String eh1 = fmt2.format(ed1);
		 out.print(" To Date :" +eh1);
		}
		%> Trip Id: <%=tripid%>, Owner Name : <%=ownername%>, Start Place : <%=startplace%>, End Place : <%=endplace%></B></font></div>
		<div align="right">
		<a href="#" onclick="javascript:window.open('detailjourney.jsp');" title="Print Detail Journey Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceldetailjourney.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
		<%=fleetview.PrintDate() %>
		</div>
		</td></tr>
		<tr><td>
		<table border="1" width="100%">
		<tr>
		<td style="width: 550px; height: 570px">
		<div id="map" style="width: 550px; height: 570px"></div>
		</td>
		<td valign="top">
		<table class="stats">
		<tr><td>
		<div id="mydiv" name="mydiv"  align='left'></div></td></tr>
		<tr><td><div id="mydiv1" name="mydiv1" class="bodyText"></div>
		<div id="reportdiv" name="reportdiv" style="overflow:auto;height:300px;"></div>
		</td></tr>
		</table>
		</td>
		</tr>
		</table>
		</td></tr>
		</table>
		<script type="text/javascript">
	    //<![CDATA[
	
	    
	   if (GBrowserIsCompatible()) 
		{
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
	     	var gx2 = new GGeoXml("http://myfleetview.com/FleetView/kml_runtime_gen/MyKmlLineDB1.kml");
	     	
	     	//var gx2 = new GGeoXml("http://pgo.transtrack.in/uctc/MyKmlLineDB1.kml");
	     //	var gx2 = new GGeoXml("http://pgo.transtrack.in/fleetview/kml_runtime_gen/MyKmlLineDB1.kml");
	     	map.addOverlay(gx2);

	     	
	     	<%
	     	if(session.getAttribute("usertypevaluemain").equals("Castrol") || session.getAttribute("usertypevaluemain").equals("All")) 
	     	{ 
	     	%>
			
			<%
	     	}
	     	%>
			function createMarker1(point,html,lat,lon,stamp){
			var cIcon = new GIcon();
			if(stamp=="OS")
			{
				cIcon.image = 'images/mm_20_red.png';
			}	
			if(stamp=="ST")
			{
				cIcon.image = 'images/mm_20_white.png';
			}
			if(stamp=="AC")
			{
				cIcon.image = 'images/mm_20_blue.png';
			}
			if(stamp=="DC")
			{
				cIcon.image = 'images/mm_20_yellow.png';
			}
			if(stamp=="SI")
			{
				cIcon.image = 'images/mm_20_green.png';
			}
			cIcon.shadow = 'images/mm_20_shadow.png';
			cIcon.iconSize = new GSize(12,20);
			cIcon.shadowSize = new GSize(22, 20);
			cIcon.iconAnchor = new GPoint(6, 20);
			cIcon.infoWindowAnchor = new GPoint(5, 1);
			markerOptions = { icon:cIcon};
		
			var marker = new GMarker(point, markerOptions);
			//var marker = new GMarker(point);
	        GEvent.addListener(marker, "click", function() {
			map.setCenter(new GLatLng(lat,lon),9);
	        marker.openInfoWindowHtml(html1);
	        });
	      	GEvent.addListener(marker, "mouseover", function() {
			//map.setCenter(new GLatLng(lat,lon),9);
	        marker.openInfoWindowHtml(html);
	        });
			return marker;
	      
			}
			
	   
	
	  function createMarker2(point,html,lat,lon)
	    {
			var cIcon = new GIcon();
			cIcon.image = 'images/mm_20_black.png';
			cIcon.shadow = 'images/mm_20_shadow.png';
			cIcon.iconSize = new GSize (20,25);
			cIcon.shadowSize = new GSize(22, 20);
			cIcon.iconAnchor = new GPoint(6, 20);
			cIcon.infoWindowAnchor = new GPoint(5, 1);
			markerOptions = { icon:cIcon};
			
			var marker = new GMarker(point, markerOptions);
			//var marker = new GMarker(point);
	        GEvent.addListener(marker, "click", function() {
			map.setCenter(new GLatLng(lat,lon),9);
	        marker.openInfoWindowHtml(html1);
        });
	    GEvent.addListener(marker, "mouseover", function() 
	    {
			//map.setCenter(new GLatLng(lat,lon),9);
	        marker.openInfoWindowHtml(html);
        });
				return marker;
		}
		      
		 function myclick(i,lat,lon) 
			{
					map.setCenter(new GLatLng(lat,lon));
			        gmarkers[i].openInfoWindowHtml(htmls[i]);
		    }
			 
		 function bearing( from, to ) 
		 {
		    	 
		       // See T. Vincenty, Survey Review, 23, No 176, p 88-93,1975.
		        // Convert to radians.
		        var lat1 = from.latRadians();
		        var lon1 = from.lngRadians();
		        var lat2 = to.latRadians();
		        var lon2 = to.lngRadians();

		        // Compute the angle.
		        var angle = - Math.atan2( Math.sin( lon1 - lon2 ) * Math.cos( lat2 ), Math.cos( lat1 ) * Math.sin( lat2 ) - Math.sin( lat1 ) * Math.cos( lat2 ) * Math.cos( lon1 - lon2 ) );
		        if ( angle < 0.0 )
			 	angle  += Math.PI * 2.0;
		       
		        // And convert result to degrees.
		        angle = angle * degreesPerRadian;
		        angle = angle.toFixed(1);

		        return angle;
		    }

		function arrowHead(px1,px2) 
		{
		    	  var p1=px1;
		          var p2=px2;
		       //   alert(p1);
		        //  alert(p2);
		          var dir = bearing(p2,p1);
		          // == round it to a multiple of 3 and cast out 120s
		          var dir = Math.round(dir/3) * 3;
		          
		          while (dir >= 120) {dir -= 120;}
		          // == use the corresponding triangle marker 
		          
		          arrowIcon.image = "http://www.google.com/intl/en_ALL/mapfiles/dir_"+dir+".png";
		          map.addOverlay(new GMarker(p1, arrowIcon));
      }

	<%
		try{
			conn = fleetview.ReturnConnection();
			st=conn.createStatement();
			st1=conn.createStatement();
			st2=conn.createStatement();
			sql = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime,Distance,Speed ,TheFiledTextFileName FROM t_veh"+ vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+sdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and LonginDec>0 and TheFiledTextFileName='SI' and Speed >0 order by concat(TheFieldDataDate ,TheFieldDataTime) desc";
			ResultSet rst=st.executeQuery(sql);
			if(rst.next())
			{
		        lat = rst.getString("LatinDec"); 
				lon = rst.getString("LonginDec"); 
				location= rst.getString("TheFieldSubject");
				thedate= rst.getString("TheFieldDataDate");
				thetime = rst.getString("TheFieldDataTime"); 
				dist=rst.getInt("Distance");
				lastlocation=" Last Location :"+thedate+" "+thetime+" "+location;
		%>
		
		var point1 = new GLatLng(<%= lat%>,<%= lon%>);
		map.setCenter(point1,6);
		var marker = createMarker1(point1,"<div class='bodyText' align='left'><b ><%=vehregno%></b><br><%=thedate%> <%=thetime%><br>Last Location  <%= location%></div>",<%= lat%>,<%= lon%>,'SI');
		map.addOverlay(marker);
		<% 
		}
		while(rst.next())
			{
			dist1=rst.getInt("Distance");
			lat1 = rst.getString("LatinDec"); 
			lon1 = rst.getString("LonginDec"); 
			thedate1= rst.getString("TheFieldDataDate");
			thetime1 = rst.getString("TheFieldDataTime"); 
			location1= rst.getString("TheFieldSubject");
			thedateStart= rst.getString("TheFieldDataDate");
			thetimeStart = rst.getString("TheFieldDataTime");
			
			if(Double.parseDouble(lat)-Double.parseDouble(lat1) >0.00005 || Double.parseDouble(lon)-Double.parseDouble(lon1) >0.00005 ||Double.parseDouble(lat1)-Double.parseDouble(lat) >0.00005 || Double.parseDouble(lon1)-Double.parseDouble(lon) >0.00005  )
		{
		boolean flag=true;
		if(rst.getTime("TheFieldDataTime").compareTo(java.sql.Time.valueOf("05:30:00")) < 1 && rst.getTime("TheFieldDataTime").compareTo(java.sql.Time.valueOf("22:30:00")) < 1 )
		{
			colorcode="#000000";
		
		}
		else
		{
		colorcode="#736AFF";
		//colorcode="#827839";
		}
		%>
		var polyline = new GPolyline([new GLatLng('<%= lat%>','<%= lon%>'),new GLatLng('<%= lat1%>','<%= lon1%>')], '<%=colorcode%>',  4);
		map.addOverlay(polyline);
		arrowHead(new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>));
		<%
		}
		lat = lat1; 
		lon =lon1;
		thedateStart=thedate1;
		thetimeStart=thetime1;
		locationStart= location1;
		firstlocation="Start Location :"+thedateStart+" "+thetimeStart+" "+locationStart;
		
		}//while
		
		%>
		
		var marker1 = createMarker2(new GLatLng(<%= lat%>,<%= lon%>),"<div class='bodyText' align='left'><b ><%=vehregno%></b><br><%=thedateStart%> <%=thetimeStart%><br>Start Location  <%= locationStart%></div>",<%= lat%>,<%=lon%>);
		map.addOverlay(marker1);
		
		<%
			ResultSet rstos=fleetview.getOSforDateRange(sdate,enddate,vehcode);
			while(rstos.next())
			{
				label1="OS "+new SimpleDateFormat("dd-MMM-yyyy").format(rstos.getDate("TheFieldDataDate"))+" "+rstos.getString("TheFieldDataTime")+" Speed " +rstos.getString("Speed")+" Duration " + rstos.getString("Distance") + " Sec.";
				oscount++;
				%>
				var point1 = new GLatLng(<%= rstos.getString("LatinDec")%>,<%= rstos.getString("LonginDec")%>);
				var marker = createMarker1(point1,"<div class='bodyText' align='left'><%=label1%></div>",'<%= rstos.getString("LatinDec")%>','<%= rstos.getString("LonginDec")%>','OS');
				map.addOverlay(marker);
				<%
			}
			ResultSet rstac=fleetview.getACforDateRange(sdate,enddate,vehcode);
			while(rstac.next())
			{
				label1="AC "+new SimpleDateFormat("dd-MMM-yyyy").format(rstac.getDate("TheFieldDataDate"))+" " +rstac.getString("TheFieldDataTime")+  " Speed from " +rstac.getString("Distance")+" To " + rstac.getString("Speed")  ;
				account++;
				%>
				var point1 = new GLatLng(<%= rstac.getString("LatinDec")%>,<%= rstac.getString("LonginDec")%>);
				var marker = createMarker1(point1,"<div class='bodyText' align='left'><%=label1%></div>",'<%= rstac.getString("LatinDec")%>','<%= rstac.getString("LonginDec")%>','AC');
				map.addOverlay(marker);
			<%
			}
			
			ResultSet rstdc=fleetview.getDCforDateRange(sdate,enddate,vehcode);
			while(rstdc.next())
			{
				label1="DC "+new SimpleDateFormat("dd-MMM-yyyy").format(rstdc.getDate("TheFieldDataDate"))+" " +rstdc.getString("TheFieldDataTime")+  " Speed from " +rstdc.getString("Distance")+" To " + rstdc.getString("Speed")  ;
				dccount++;
				%>
				var point1 = new GLatLng(<%= rstdc.getString("LatinDec")%>,<%= rstdc.getString("LonginDec")%>);
				var marker = createMarker1(point1,"<div class='bodyText' align='left'><%=label1%></div>",'<%= rstdc.getString("LatinDec")%>','<%= rstdc.getString("LonginDec")%>','DC');
				map.addOverlay(marker);
			<%
			}
	/******************code for stops***************/
	
	/**********tripid , calculate distance****/
	
	try{
			sql3="select KmTravelled from t_completedjourney where TripID='"+tripid+"'";
			ResultSet rst3=st2.executeQuery(sql3);
			if(rst3.next())
			{
				distTrav=rst3.getString("KmTravelled");
			}
	}catch(Exception e)
	{
		System.out.println("Exception:-->"+e);	
	}finally{
		rst.close();
		st2.close();
		
		}
	/*********************************************/
	
		sql="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+sdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
		//System.out.println("SQL:::11-showon map--->>>"+sql);
		ResultSet rst2=st.executeQuery(sql);
		boolean flag=true;
		int i=1;
		while(rst2.next())
		{
			if(rst2.getInt("Speed")==0)
			{
				if(flag)
				{
					stopdatetime=rst2.getString("TheFieldDataDate")+" "+rst2.getString("TheFieldDataTime");
					flag=false;
				}
			}
			else
			{
				flag=true;
				startdatetime=rst2.getString("TheFieldDataDate")+" "+rst2.getString("TheFieldDataTime");
				if(!(stopdatetime.equals("-")))
				{
					java.util.Date spdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stopdatetime);
					java.util.Date stdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdatetime);
					
					long mils=(stdate.getTime()-spdate.getTime());
					long mins=mils/1000/60;
					if(mins >= Integer.parseInt(session.getAttribute("stop11").toString()))
					{
						String hrs=""+mins/60;
						String min="00";
						try{
						 min=""+mins%60;
						}catch(Exception ee)
						{
							min="00";
						}
						String html2="ST "+new SimpleDateFormat("dd-MMM-yyyy").format(rst2.getDate("TheFieldDataDate"))+"  "+rst2.getString("TheFieldDataTime")+"<br> "+hrs+"hrs "+min+"min  "+rst2.getString("TheFieldSubject");
						stcount++;
						%> 
	
							var point1 = new GLatLng(<%=rst2.getString("LatinDec")%>,<%=rst2.getString("LonginDec")%>);
							var marker = createMarker1(point1,"<div class='bodyText' align='left'><%= html2%></div>",'<%=rst2.getString("LatinDec")%>','<%=rst2.getString("LonginDec")%>','ST');
						    map.addOverlay(marker);
	
						<%
						stopdatetime="-";
						i++;
					}
				}
			}
		}
	
	/******************code for stops***************/
	
	
	}catch(Exception e)
	{
	%> alert("<%=e %>"); <%
	}
	finally
	{
		conn.close();
	}
	distance=dist-dist1;
	if(oscount > 0)
	{
	osstr="<a href='javascript:ajaxFunction(1);'>"+oscount+"</a>";
	}
	else
	{
	osstr=""+oscount;
	}
	if(account > 0)
	{
	acstr="<a href='javascript:ajaxFunction(2);'>"+account+"</a>";
	}
	else
	{
	acstr=""+account;
	}
	if(dccount > 0)
	{
	dcstr="<a href='javascript:ajaxFunction(3);'>"+dccount+"</a>";
	}
	else
	{
	dcstr=""+dccount;
	}
	if(stcount > 0)
	{
	 pg="tripst";
	ststr="<a href='javascript:ajaxFunction(4);'>"+stcount+"</a>";
	}
	else
	{
	ststr=""+stcount;
	}
	
	
	String str ="<table class='stats'><tr><td class='bodyText'><div align='left'><img src='images/mm_20_red.png'>Total Over Speed Count :  "+osstr+"</div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/mm_20_blue.png'>Total Rapid Acceleration :  "+acstr+"</div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/mm_20_yellow.png' >Total Rapid Deceleration : "+dcstr+"</div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/mm_20_white.png'>Total Stops : "+ststr+"<div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/mm_20_green.png' >"+lastlocation+"<div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/mm_20_black.png' >"+firstlocation+"<div></td></tr><tr><td class='bodyText'><div align='left'>Distance Travelled : "+distTrav+" Km</div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/nd.png' width='30px' height='20px'>Night Driving : <div></td></tr></table>";
	%>
	}
	document.getElementById("mydiv").innerHTML="<%=str%>";
	document.getElementById("mydiv1").innerHTML="<b><%=lastlocation%></b>";
	 //]]>
	</script>
	</body>
	</html>
	<%fleetview.closeConnection(); %>
	</jsp:useBean>
	
		
	<%@ include file="footernew.jsp" %>
