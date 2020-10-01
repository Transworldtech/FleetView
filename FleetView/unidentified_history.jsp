<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>

<%@ include file="Connections/conn.jsp" %>
<html>
<head>


<title>Vehicle Tracking System </title>

<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>


<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript" language="JavaScript"></script>

</head>
<body bgcolor="#FFE4E1" onLoad="JavaScript:initRotator(),loadSearchHighlight();">

<P></P>
<table border="1" width="100%" align="center" bgcolor="#FFFAFA" class="solid">
<tr >
<td valign="top">
<table border="0" width="100%" bgcolor="#F8F8FF">
<tr>
<td rowspan="2" align="center" width="13%">
<a href="images/logo.jpg" >
<img src="images/logo.jpg"  border="0">
</a>
</td>
<td  align="left">
<img src="images/ind11.jpg" width="30%" height="100%">
<img src="images/foodlandveh.png" border="0"  width="15%" >
<img src="images/Img6.gif" width="10%" height="30%">
<%@ include file="imgrotate.html" %>
</td>
</tr>

<tr><td colspan="2"><table border="0" width="100%" align="right" background="images/background1.bmp"><tr>
		<td align="right"><font COLOR="#696969" face="Tahoma"><b>WELCOME :</b></font><font color="red"><%=session.getAttribute("dispalyname").toString() %></b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp" title="Logout">LOGOUT</a></td>
</tr>
</table></td><tr>
</table>
</td></tr>
</table>
<!-- code start here -->
<table width="100%" bgcolor="white" border="1">
<tr><td>
<div id="map" style="width: 790px; height: 450px"></div>

</td>
<td valign="top">
<div id="dd"></div>
</td></tr>
</table>
<script type="text/javascript">
    //<![CDATA[
   
        var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));
map.addControl(new GLargeMapControl());
map.addControl(new GScaleControl(250));

function createMarker1(point,html,lat,lon){
	
	var cIcon = new GIcon();
	cIcon.image = 'images/t5.png';
	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize(12,20);
	cIcon.shadowSize = new GSize(22, 20);
	cIcon.iconAnchor = new GPoint(6,11);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
	var marker = new GMarker(point, markerOptions);
	GEvent.addListener(marker, "click", function() {
	map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(html1);
        });
      	GEvent.addListener(marker, "mouseover", function() {
	marker.openInfoWindowHtml(html);
        });
	return marker;
      }

<%!
Connection conn;
Statement st;
String sql,unitid,data,location, info,info1;
double lat, lat1, lon, lon1;
%>
<%
unitid=request.getParameter("unitid");
data=request.getParameter("data");
try
{
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();
	sql="select * from t_veh0 where UnitId='"+unitid+"' and TheFieldDataDate='"+data+"' order by concat(TheFieldDataDate,TheFieldDataTime) desc";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		lat=rst.getDouble("Latindec");
		lon=rst.getDouble("LonginDec");
		location=rst.getString("TheFieldSubject");
		info="<b>End Location </b>"+rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime")+" "+rst.getString("TheFieldSubject");
%>
	var point1 = new GLatLng(<%= lat%>,<%= lon%>);
	var marker = createMarker1(point1,"<div class='bodyText'>Last Location  <%= location%></div>",<%= lat%>,<%= lon%>);
      map.addOverlay(marker);
<%
	}
	while(rst.next())
	{
		lat1=rst.getDouble("Latindec");
		lon1=rst.getDouble("LonginDec");
	%> 
var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);
map.addOverlay(polyline);

	<%
	lat=lat1;
	lon=lon1;
	location=rst.getString("TheFieldSubject");
	info1="<b>Start Location </b>"+rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime")+" "+rst.getString("TheFieldSubject");
	}
%>
	var point1 = new GLatLng(<%= lat%>,<%= lon%>);
	var marker = createMarker1(point1,"<div class='bodyText'>Last Location  <%= location%></div>",<%= lat%>,<%= lon%>);
      map.addOverlay(marker);
<%

info1+="<br><br><br>"+info;
%>
document.getElementById("dd").innerHTML = "<font class='bodyText'><%=info1%></font>";
<%
}
catch(Exception e)
{
	out.print("Exception -->"+e);
}
finally
{
	try
	{
		conn.close();	
	}catch(Exception e)
	{}
}
%>
//]]>
    </script>
<!-- end code -->
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
