<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>


  <head>
    <title>Transworld Fleetview </title>
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ"           type="text/javascript"></script>
 </head>
  <body onunload="GUnload()">
	<table width="90%" align="center">
<tr><td width=20><img src="images/FirstFlight.bmp"></td><td width=80%>
	<marquee>
<font size=5 face=Arial bgcolor =yellow color=navy ><b><i> Vehicle Tracking Solutions Powered by Transworld - Mobile Eye 
www.TWTech1.com</i></b></font>
</marquee> </td></tr>
</table>
 

    <!-- you can use tables or divs for the overall layout -->
    <table border=1 align="center">
      <tr>
       
	
	<td >
           <div id="map" style="width: 900px; height: 550px"></div>
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


      if (GBrowserIsCompatible()) {
	var map = new GMap2(document.getElementById("map"));
	map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));

	map.addControl(new GLargeMapControl());
	<%!  
		Connection conn;
		Statement st, st1;
		String vehcode,vehregno,reg,lat,lon,lat1,lon1;
	%>
	<%
	vehregno=request.getParameter("Vehcode");
	try{
		Class.forName("org.gjt.mm.mysql.Driver"); 
	conn = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
	st=conn.createStatement();
	String sql="select * from t_vehicledetails";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	reg=rst.getString("VehicleRegNumber");
	reg=reg.replace(" ","");
	
	if(vehregno.equals(reg))
	{
	vehcode=rst.getString("VehicleCode");
	}
	}
	String sql1="select LatinDec,LatinDec+0.0001 as lat, LonginDec, LonginDec+0.0001 as lon, TheFieldDataDate, TheFieldDataTime,TheFieldSubject from t_veh"+vehcode+" where TheFieldDataDate=now() order by concat(TheFieldDataDate,TheFieldDataTime) desc";	

	ResultSet rst1=st.executeQuery(sql1);
	if(rst1.next())
	{
	lat=rst1.getString("LatinDec");
	lon=rst1.getString("LonginDec");
	java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheFieldDataDate"));
	Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate1 = formatter1.format(ShowDate1);
	String html="<div class='bodyText'>"+vehregno+" "+showdate1+" "+rst1.getString("TheFieldDataTime")+"<br>"+rst1.getString("TheFieldSubject")+"</div>";
	%>
	var point = new GLatLng(<%= lat%>, <%= lon%>);
	marker=new GMarker(point);
	GEvent.addListener(marker, "mouseover", function() {
	         marker.openInfoWindowHtml("<%=html %>");
        });
	map.addOverlay(marker);
	<%
	}
	while(rst1.next())
	{
	lat1=rst1.getString("lat");
	lon1=rst1.getString("lon");
	%>
	var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);
map.addOverlay(polyline)
	
	<%
	lat=lat1;
	lon=lon1;
	}
	
	}catch(Exception e)
	{
	%> alert("<%=e%>");<%
	}
	finally
	{
	conn.close();
	}


	%>

               }
      
     else {
      alert("Sorry, the Google Maps API is not compatible with this browser");
    }

    //]]>
    </script>
  </body>

</html>
