<%@ include file="header.jsp" %>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<script src="elabel.js" type="text/javascript"></script>


<table width="100%" border="1" bgcolor="white">
<tr><td ><div id="map" style="width: 980px; height: 330px"></div></td></tr><tr>
<td valign="top">

<table class="stats" >
<form action="addwaypoint.jsp" name="waypointform" method="get" onsubmit="return validate();">
<tr>
<td colspan="2" class="hed">Latitude & Longitude</td></tr>
<tr>
<td class="bodyText">Latitude :</td>
<td class="bodyText"><input type="text" name="lon" id="lon" class="formElement" readonly></td></tr>
<tr>
<td class="bodyText">Longitude :</td>
<td class="bodyText"><input type="text" name="lat" id="lat" class="formElement" readonly></td></tr>
<tr>
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
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());

	lstner = GEvent.addListener(map, 'click', function(overlay, point){
	document.waypointform.lat.value=point.x;
	document.waypointform.lon.value=point.y;
   	});

//]]>
    </script>
<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2007 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
