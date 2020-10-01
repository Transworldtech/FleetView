

// java script code to add marker , plotting line on map ///

	var map=null;
  google.load("maps", "2.x");
  google.load("search", "1");
  google.load("feeds", "1");
  // Call this function when the page has been loaded
  function initialize() {
    map = new google.maps.Map2(document.getElementById("map"));
    map.setCenter(new google.maps.LatLng(17.4419, 80.1419), 5);
    map.addControl(new GSmallMapControl());
    map.addControl(new GMapTypeControl());
    map.enableScrollWheelZoom();
    map.addMapType(G_PHYSICAL_MAP);
    map.addMapType(mtTerCross);
  }
  google.setOnLoadCallback(initialize);
function sendalert()
{
	alert("Hi Atul");
}
function addMarker(Latitude, Longitude, Image, Discription)
{
		var cIcon = new GIcon();
		cIcon.image = 'images/'+Image;
		cIcon.image = 'images/t5.png';
		cIcon.iconSize = new GSize(12,20);
		cIcon.iconAnchor = new GPoint(0,5);
		cIcon.infoWindowAnchor = new GPoint(1, 1);
		markerOptions = { icon:cIcon};
		var point= new GLatLng(Latitude,Longitude);
		var marker = new GMarker(point, markerOptions);
         GEvent.addListener(marker, "click", function() {
        	 map.setCenter(new GLatLng(lat,lon),9);
        	 	marker.openInfoWindowHtml(Discription);
        });
         GEvent.addListener(marker, "mouseover", function() {
        	 marker.openInfoWindowHtml(Discription);
        });
         map.addOverlay(marker);
      }
function addLine(poly)
{
	alert(poly);
	//var polyline = new GPolyline([new GPoint(74.8954,17.5981),new GPoint(74.8918,17.5982)],"#ff0ff0", 5, 10);
	//var polyline = new GPolyline(poly,"#ff0ff0", 5, 10);
	map.addOverlay(poly);
	
	
}
