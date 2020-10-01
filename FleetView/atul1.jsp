<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<html>
<head>
<script type="text/javascript">
    //<![CDATA[
function load() {// The GGeoXml constructor takes a URL pointing to a KML or GeoRSS file.
// You add the GGeoXml object to the map as an overlay, and remove it as an overlay as well.
// The Maps API determines implicitly whether the file is a KML or GeoRSS file.

var map = new GMap2(document.getElementById('map'));
map.addControl(new GLargeMapControl());
map.setCenter(new GLatLng(19.496675,82.65625), 4); 
map.addControl(new GLargeMapControl());
var center = new GLatLng(18.4419, 73.1419);
        map.setCenter(center, 5);

        var marker = new GMarker(center, {draggable: true});

        GEvent.addListener(marker, "dragstart", function() {
          map.closeInfoWindow();
        });

        GEvent.addListener(marker, "dragend", function() {
          marker.openInfoWindowHtml("Just bouncing along...");
        });

        map.addOverlay(marker);

var gx = new GGeoXml("http://localhost:8080/FleetView/KML/india1.kml");

map.addOverlay(gx);

<%!
double lat,lon,lat1,lon1;
%>
<%
try{

Driver MM_driverUser = (Driver)Class.forName("org.gjt.mm.mysql.Driver").newInstance();
Connection MM_connUser = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","root","");
Statement s = MM_connUser.createStatement();

String sql55="select Lat, Lat+0.0001 as lat1, Lon,Lon+0.0001 as lon1 from way where OwnerName='iarmy' and RouteId='1'";

ResultSet rst55=s.executeQuery(sql55);
if(rst55.next())
{
        lat = rst55.getDouble("Lat"); 
	lon = rst55.getDouble("Lon"); 
}
while(rst55.next())
{
	lat1 = rst55.getDouble("Lat"); 
	lon1 = rst55.getDouble("Lon"); 
	%> 
var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#ffcc00",  6);
map.addOverlay(polyline);
<%
lat=lat1;
lon=lon1;
}
}catch(Exception e)
{
%> alert("<%=e%>"); <%
}

%>

}
  //]]>
    </script>

<script src="elabel.js" type="text/javascript"></script>

<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxQDcrUiT1n2wGtp80NHz-KNPlY2iRSm07rlwKEMyQBZsjTK0mnedLODCQ" type="text/javascript"></script>
</head>
<body onload="load()" onunload="GUnload()">
 <div id="map" style="width: 700px; height: 550px"></div>
</body>
</html>
