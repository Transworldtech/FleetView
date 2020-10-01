<html>
<!--<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>-->
<!--<script type="text/javascript" src="http://maps.google.com/">

</script>-->
<script src="http://openlayers.org/api/OpenLayers.js"></script>
<script src="http://www.openstreetmap.org/openlayers/OpenStreetMap.js"></script>


<script type="text/javascript">
    //<![CDATA[	
	var lat=<%=request.getParameter("lat") %>;
        var lon=<%=request.getParameter("long")%>;
        var zoom=14;
 
        var map; //complex object of type OpenLayers.Map
 
        //Initialise the 'map' object
        function init() {
 
            map = new OpenLayers.Map ("map", {
                controls:[
                    new OpenLayers.Control.Navigation(),
                    new OpenLayers.Control.PanZoomBar(),
                   // new OpenLayers.Control.Permalink(),
                    new OpenLayers.Control.ScaleLine({geodesic: true}),
                   // new OpenLayers.Control.Permalink('permalink'),
                    new OpenLayers.Control.MousePosition(),                    
                    new OpenLayers.Control.Attribution()],
                maxExtent: new OpenLayers.Bounds(-20037508.34,-20037508.34,20037508.34,20037508.34),
                maxResolution: 156543.0339,
                numZoomLevels: 19,
                units: 'm',
                projection: new OpenLayers.Projection("EPSG:900913"),
                displayProjection: new OpenLayers.Projection("EPSG:4326")
            } );
 
            // This is the layer that uses the locally stored tiles
            //String war="new OpenLayers.Layer.OSM(\"Local Tiles\",\"http://192.168.2.94/osm/\${z}/\${x}/\${y}.png\", {numZoomLevels: 19, \"tileOptions\": {\"crossOriginKeyword\": null}})";
            //var newLayer =war;
            
            var newLayer = new OpenLayers.Layer.OSM("Local Tiles","http://maps.myfleetview.com/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19,attribution : '<a href="http://mapsurfernet.com/" style="text-decoration:none"><font face="Hemi Head 426" size="04" color="#0853A0">FleetView <br><font face="Hemi Head 426" size="01" color="#0853A0">Transworld Technologies Ltd.  </a>' , "tileOptions": {"crossOriginKeyword": null}});
            map.addLayer(newLayer);

            //layerMapnik = new OpenLayers.Layer.OSM.Mapnik("Mapnik");
            //map.addLayer(layerMapnik);
            var markers = new OpenLayers.Layer.Markers( "Markers" );
            map.addLayer(markers);
            var size = new OpenLayers.Size(12,20);
            var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
            var icon = new OpenLayers.Icon('images/mm_20_red.png',size,offset);
            markers.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		              map.getProjectionObject()),icon));

// This is the end of the layer
 
            //var switcherControl = new OpenLayers.Control.LayerSwitcher();
            //map.addControl(switcherControl);
            //switcherControl.maximizeControl();
 
            if( ! map.getCenter() ){
                var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
                map.setCenter (lonLat, zoom);
            }
        }
 
    </script>
</head>
 
<!-- body.onload is called once the page is loaded (call the 'init' function) -->
<body onload="init();">
<div style="width:100%; height:100%" id="map"></div>
</body>
 
</html>