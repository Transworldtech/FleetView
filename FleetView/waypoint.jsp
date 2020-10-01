<%@ include file="header.jsp" %>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxQDcrUiT1n2wGtp80NHz-KNPlY2iRSm07rlwKEMyQBZsjTK0mnedLODCQ" type="text/javascript"></script>
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">
.elabelstyle {color:black; background-color:#ffffaa; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
<script language=JavaScript>
function validate()
{
	
	if(document.getElementById("name").value=="")
	{
		alert("Please Enter the Name for Waypoint");
		return false;
	}
	if(document.getElementById("discription").value=="")
	{
		alert("Please Enter the Discription");
		return false;
	}
	if(document.getElementById("discription").value=="")
	{
		alert("Please Enter the Discription");
		return false;
	}
return true;
}

</script>
 
<table width="100%" border="1" bgcolor="white">
<tr><td ><div id="map" style="width: 980px; height: 350px"></div></td></tr><tr>
<td valign="top">

<table class="stats" >
<form action="addwaypoint.jsp" name="waypointform" method="get" onsubmit="return validate();">
<tr>
<td colspan="2" class="hed">Add Point</td></tr>

<%! 
Connection conn,conn1;
Statement st;
%>
<%
try{
	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	}catch(Exception e)
{
	out.print("Exception "+e);
}
%>


<tr>
<td class="bodyText">Name :</td>
<td class="bodyText"><input type="text" name="name" id="name" class="formElement"></td></tr>
<tr>
<td class="bodyText">Discription :</td>
<td class="bodyText"><input type="text" name="discription" id="discription" class="formElement"></td></tr>
<tr>
<td class="bodyText">Lat :</td>
<td class="bodyText"><input type="text" name="lat" id="lat" class="formElement" readonly></td></tr>
<tr>
<td class="bodyText">Lon :</td>
<td class="bodyText"><input type="text" name="lon" id="lon" class="formElement" readonly></td></tr>
<tr>

<tr><td colspan="2"><input type="submit" value="submit" class="formElement"><input type="hidden" name="imgname" id="imgname" value="roadpoint.png"></td></tr>
</form>
</tr>

</table>

</td></tr>
</table>
<script type="text/javascript">
    //<![CDATA[
  	var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));
	map.addControl(new GLargeMapControl());

	lstner = GEvent.addListener(map, 'click', function(overlay, point){
	document.waypointform.lat.value=point.x;
	document.waypointform.lon.value=point.y;
   	});

function findcity(city)
{
	 var str=city.value;
	 mySplitResult=str.split(",");
	 map.setCenter(new GLatLng( mySplitResult[0], mySplitResult[1]),9);
	
}

function createMarker(point,name,html,imgname,lat,long){
	
	var cIcon = new GIcon();
	cIcon.image = 'images/sym_20950.png';
	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize(20,20);
	cIcon.shadowSize = new GSize(10, 10);
	cIcon.iconAnchor = new GPoint(1,1);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
	var marker = new GMarker(point, markerOptions);
	//var marker = new GMarker(point);
         GEvent.addListener(marker, "click", function() {
	map.setCenter(new GLatLng(lat,long),9);
        marker.openInfoWindowHtml(html);
        });
      GEvent.addListener(marker, "mouseover", function() {
	//map.setCenter(new GLatLng(lat,long),9);
        marker.openInfoWindowHtml(html);
        });
	return marker;
      }



//]]>
    </script>
 <%
 try{
	Statement st1=conn.createStatement();
	String LatitudePosition,LongitudePosition, name1, discription1,imgname1;
	String user1=session.getAttribute("usertypevalue").toString();
	String sql3="select * from t_waypoints where OwnerName='"+user1+"'";
	ResultSet rst3=st1.executeQuery(sql3);
	while(rst3.next())
	{
	LatitudePosition=rst3.getString("Lon");
	LongitudePosition=rst3.getString("Lat");
	name1=rst3.getString("Name");
	discription1=rst3.getString("Discription");
	imgname1=rst3.getString("Category");

	%>
	<script type="text/javascript">
    //<![CDATA[

	var point1 = new GLatLng(<%= LongitudePosition%>,<%= LatitudePosition%>);var marker = createMarker(point1,"<%= name1%>","<div class='bodyText'><%= discription1%></div>","<%=imgname1%>",<%= LongitudePosition%>,<%= LatitudePosition%>);
	map.addOverlay(marker);
	var label=new ELabel(point1, "<b><%=name1%></b>","elabelstyle",new GSize(20,10),90);
	map.addOverlay(label);
	
//]]>
    </script>
	<%
	}


}catch(Exception e)
{
	out.print("Exception "+e);
}

%>
<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2007 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
