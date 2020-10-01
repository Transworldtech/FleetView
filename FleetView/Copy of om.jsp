<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

  <head>
    <title>Transworld Fleetview 1.14</title>
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ"           type="text/javascript"></script>
 </head>
  <body onunload="GUnload()">
	<table width=100%>
<tr><td width=20%><img src="images/l4.jpg" alt="Om Logistics"/></td><td width=80%>
	<marquee>
<font size=5 face=Arial bgcolor =yellow color=navy ><b><i> Vehicle Tracking Solutions Powered by Transworld - Mobile Eye 
www.TWTech1.com</i></b></font>
</marquee> </td></tr>
</table>
 

    <!-- you can use tables or divs for the overall layout -->
    <table border=1>
      <tr>
        
        <td width = 0 valign="top" style="text-decoration: underline; color: #4444ff;">
	
           <!-- =========== side_bar with scroll bar ================= -->
           <div id="side_bar"  style="overflow:auto; height:550px;"></div>
           <!-- ===================================================== -->
	
	
        </td>
	
	<td>
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

<%



	Class.forName("org.gjt.mm.mysql.Driver");
	
	
	
	
      			

	//out.println(d);
	String lat="0.0";
	String lon="0.0";
	String vehcode1 = "1";
	String vehid="0";
	String vehregno="0";
	String thedate="";
	String thetime="";
	String location="";
	String transporter;
	String lat1="0.0";
	String lon1="0.0";
	String UnitId="";
	if (request.getParameter("Vehcode") !=null) {vehcode1 = (String)request.getParameter("Vehcode");}

	//String Muser = request.getParameter("user");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","root","flashkit");
	Statement s = con.createStatement();
	String sql3 = "SELECT t_onlinedata.VehicleCode,t_onlinedata.VehicleRegNo,TheDate,TheTime,Location,t_onlinedata.Transporter,LatitudePosition,LatitudePosition+0.001 as lat1,LongitudePosition,LongitudePosition+0.001 as lon1,t_vehicledetails.UnitID as UnitID  FROM t_onlinedata,t_vehicledetails where t_vehicledetails.vehiclecode=t_onlinedata.vehiclecode and t_vehicledetails.UnitID ='" + vehcode1 + "'" ;
	
	ResultSet rs3 = s.executeQuery(sql3);
	while(rs3.next())
	{
	vehid= rs3.getString("VehicleCode");
	vehregno = rs3.getString("VehicleRegNo"); 
	thedate= rs3.getString("TheDate");
	thetime = rs3.getString("TheTime"); 
	location= rs3.getString("Location"); 
	transporter = rs3.getString("Transporter"); 
	lat = rs3.getString("LatitudePosition"); 
	lon = rs3.getString("LongitudePosition"); 
	lat1 = rs3.getString("lat1"); 
	lon1 = rs3.getString("lon1"); 
	UnitId=rs3.getString("UnitId");

	



	
	}
%>
 var map = new GMap2(document.getElementById("map"));
          map.addControl(new GLargeMapControl());
          map.addControl(new GMapTypeControl());
	  map.setCenter(new GLatLng(<%= lat%>, <%= lon%>), 10);

	var point = new GLatLng(<%= lat%>, <%= lon%>);
map.addOverlay(new GMarker(point));

var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);
map.addOverlay(polyline);





<%
	rs3.close();


	//int x= s.executeUpdate("Update t_hitcount set count=count+1");

String sql4 = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1  FROM t_veh"+ vehid +" where TheFieldDataDate>='"+ thedate +"' and LongitudeDir<>'-'";
	ResultSet rs4 = s.executeQuery(sql4);
	if(rs4.next())
	{
	while(true)
	{
	lat = rs4.getString("LatinDec"); 
	lon = rs4.getString("LonginDec"); 
	if (rs4.next())
	{
	lat1 = rs4.getString("lat1"); 
	lon1 = rs4.getString("lon1"); 
	}
	else
	{
	break;
	}

%>
var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);
map.addOverlay(polyline);
<%

	

	
	}
}



	rs4.close();


	s.close();
	con.close();
	
%>

//

               }
      
     else {
      alert("Sorry, the Google Maps API is not compatible with this browser");
    }

    // This Javascript is based on code provided by the
    // Blackpool Community Church Javascript Team
    // http://www.commchurch.freeserve.co.uk/   
    // http://econym.googlepages.com/index.htm

    //]]>
    </script>
  </body>

</html>
