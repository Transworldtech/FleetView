	<%@ include file="headernew.jsp" %>
	<%@page import="com.sun.corba.se.impl.transport.SelectorImpl"%><jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
	<%
	fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	%>
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
	<script language="javaScript">
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
	
	</script>
	
	<%!
	Connection conn;
	Statement st=null,st1=null,st2=null;
	%>
	<%
	String sql=null,tripid="",vehcode="",sdate="",Stamp="",label1="",sql1=null,sql2=null,sql3=null,osstr,acstr,dcstr,ststr,pg,colorcode,nstd,nspd;
	String Diff="",lat="", lon="",location="",thedate="",thedate1="",thetime="",thetime1="",lat1="",lon1="",vehregno="",ownername="",lastlocation="",startplace,endplace,enddate,sdate1,enddate1,stopdatetime, startdatetime,latStart="",longStart="",locationStart="",thedateStart="",thetimeStart="",firstlocation="-",location1="-";
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
	Diff=request.getParameter("Diff");
	vehcode=request.getParameter("vehcode");
	vehregno=request.getParameter("vehregno");
	session.setAttribute("tripvehregno",vehregno);
	session.setAttribute("tripenddate",enddate);
	session.setAttribute("tripstartdate",sdate);
	%>
	<table border="0" width="100%" bgcolor="white">
	<tr><td colspan="2" align="center">
	
	<font size="3">
	<b>Data On Map</b>
	</font>
	</td></tr>
	<tr><td colspan="2">
	<div align='left'>
	<font size="3"><B>
	The Data For Vehicle <%=vehregno %> From Date 
	<%=sdate%> To Date <%=enddate%> 
	<br>Start Place : <%=startplace%>
	<br> End Place : <%=endplace%>
	<br> Distance : <%=Diff%>
	</B></font></div>
 	
	<div align="right">
<!--  	<a href="#" onclick="javascript:window.open('detailjourney.jsp');" title="Print Detail Journey Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceldetailjourney.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
-->	<%=fleetview.PrintDate() %>
	</div>
	
	</td></tr>
	<tr><td>
	<table border="1" width="100%">
	<tr>
	<td style="width: 550px; height: 570px">
	<div id="map" style="width: 100%; height: 570px"></div>
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


	     	function createMarker1(point,html,lat,lon,stamp){
				var cIcon = new GIcon();
				
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

	     	
			function createMarker2(point,html,lat,lon){
				var cIcon = new GIcon();
				//we have to insert black img  here..... coz it is overlapping
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
		      	GEvent.addListener(marker, "mouseover", function() {
				//map.setCenter(new GLatLng(lat,lon),9);
		        marker.openInfoWindowHtml(html);
		        });
				return marker;
		      }
		      
			 function myclick(i,lat,lon) {
					map.setCenter(new GLatLng(lat,lon));
			        gmarkers[i].openInfoWindowHtml(htmls[i]);
			      }
			 
		      function bearing( from, to ) {
		    	 
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
			function arrowHead(px1,px2) {
		    	  
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
		
		sdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(sdate));
		enddate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(enddate));
		
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
	
	}
	%>
	var marker1 = createMarker2(new GLatLng(<%= lat%>,<%= lon%>),"<div class='bodyText' align='left'><b ><%=vehregno%></b><br><%=thedateStart%> <%=thetimeStart%><br>First Location  <%= locationStart%></div>",<%= lat%>,<%=lon%>);
	map.addOverlay(marker1);
	<%
	}catch(Exception e)
	{
	%> alert("<%=e %>"); <%
	}
	finally
	{
		conn.close();
	}
	%>
	}
	</script>
	<% fleetview.closeConnection(); %>
	</jsp:useBean>
	<%@ include file="footernew.jsp" %>
