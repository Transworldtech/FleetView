 <%@ include file="headernew.jsp" %>
 <%@page import="com.fleetview.beans.classes"%>
 <%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader ("Expires", 0);
%>
<%!
		Connection conn;
		Statement st,st1,st2,st3;
%>
<%
classes fleetview= new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//Class.forName("org.gjt.mm.mysql.Driver");
	String wareHouseCode="-",wareHouse="-",owner="-",html1=null,wtype="-",PolygonCoordinates="-";
conn = fleetview.ReturnConnection();;
 st = conn.createStatement();
 st1 = conn.createStatement();
 st2 = conn.createStatement();
 st3 = conn.createStatement();
 Statement stquery=conn.createStatement();
%>

<%
String rfname=session.getAttribute("rfname").toString(); //user name  //.setAttribute("rfname",fnamelist);
String rlname=session.getAttribute("rlname").toString();

	//System.out.println("rfname---->"+rfname);
	//System.out.println("rlname---->"+rlname);
	String fwUser = (String) session.getAttribute("user");
	//System.out.println("fwUser----->"+fwUser);
	String savedCoordiantes = "";
	String getCordiantesSql = "Select * from t_warehousedata where Owner='"+ fwUser+"' ";
	//System.out.println("getCordiantesSql-->"+getCordiantesSql);
	ResultSet rs2 = st2.executeQuery(getCordiantesSql);
%>

<%
    String polygonCordinate = (String) request.getParameter("cordonatestoasave");
if(polygonCordinate !=null && !polygonCordinate.equals(""))
{
	 StringTokenizer tokenizer = new StringTokenizer(polygonCordinate,",");
     StringBuffer polygonSql = new StringBuffer("insert into t_warehousedata (WareHouseCode,WareHouse,Owner,Transporter,Latitude,SLatitude,ELatitude,Longitude,SLongitude,ELongitude,WType,Location,EntBy,UpdatedDate,g) values (,,,,,,,,,,,,,,PolygonFromText('POLYGON((" );        
     
     
     int cntr=1;
     int tokens = tokenizer.countTokens();
     while (tokenizer.hasMoreElements()) 
     {
         String object = (String) tokenizer.nextElement();            
         if(cntr%2 == 0)
         {            
             polygonSql.append(object +" ");
             if(cntr != tokens)
                 polygonSql.append(",");
         }
         else
             polygonSql.append(object +" ");
         cntr++;
     }            
     polygonSql.append("))')");  
     
%>
<%=polygonSql%>
<% }%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
<head>
<!-- script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script -->
 <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAxjYame-JZRGh_FJuRBWlpBTlmEuEpA44GFjXbE_lz5qAkNbkwRTH_hHi4lHI7l-DNA8SyPlaWk0dhw" type="text/javascript"></script>
<script src="PolylineEncoder.js" type="text/javascript"></script>
<script type="text/javascript">
onload=function()
{
	<%
	//if(fwUser.equalsIgnoreCase("shramik"))
	//{
		
	%>
	 initialize();
	 <%//} %>
}
	var map;
	var toolID = 2;
	var codeID = 1;
	var shapeID = 1;
	var polyShape;
	var holeShape = new Array();
	//var hn = 0; // hole number in one and same polygon
	var ph = 0; // total number of holes on map
	var polygonMode = false;
	var markerMode = false;
	var circlemode = false;
	var rectanglemode = false;
	var holemode = false;
	//var headfoot = true;
	var mylistener;
	var editlistener = null;
	var holelistener = new Array();
	var editing = false;
	var holeediting = false;
	var notext = false;
	var polygonDepth = "0";
	var polyPoints = new Array();
	var holePoints = new Array();
	var holesarray = new Array();
	var encpoints = new Array();
	var encarray = new Array();
	var holecoords = new Array();
	var holebuilding;
	var tinymarker;
	var geocoder = null;

	var mousemovepoint;
	var editingstyles = 0;
	var header = "";
	//var lineColor2 = "#000000"; // black line
	var cur = 0;
	var plmcur = 0;
	var polygonstyles = new Array();
	var polylinestyles = new Array();
	var placemarks = new Array();
	var polygonholes = new Array();
	var centerMarker = null;
	var radiusMarker = null;
	var markerissaved = true;
	var lookatsaved = false;

	var tinyIcon = new GIcon();
	tinyIcon.image = "http://labs.google.com/ridefinder/images/mm_20_red.png";
	tinyIcon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
	tinyIcon.iconSize = new GSize(12,20);
	tinyIcon.shadowSize = new GSize(22,20);
	tinyIcon.iconAnchor = new GPoint(6,20);
	tinyIcon.infoWindowAnchor = new GPoint(5,1);
	// Set up our GMarkerOptions object literal
	var markerOptions = {icon:tinyIcon};

	var holeguide = 'Create polygon with one or more holes.\n' +
	'Draw a closed shape in Polyline draw mode first, if you have not done that already.' +
	'Then click "Draw hole"';
	var circleguide = "Ready for circle\n" +
	            "Use Polygon mode to draw a filled circle\n" +
	            "Click the map where you want the center of the circle to be\n" +
	            "Click at radius distance\n" +
	            "and the circle is drawn";
	var rectangleguide = "Ready for rectangle\n" +
	            "Use Polygon mode to draw a filled rectangle\n" +
	            "Click where you want the upper right corner placed";
	var presentationguide = 'Click the "Document, Placemark" button to edit "name" and "description" elements.\n'
	+'Click on the map. Create marker, polyline, polygon freehand or circle-shaped or rectangle. '
	+'You may change draw mode at any time while drawing polyline and polygon. '
	+'Use the Close Polyshape button to let start and end meet (not needed if you draw circle or rectangle).\n'
	+'The "Edit lines" button is a toggle button - click to start editing, and click to stop editing.\n'
	+'To draw more than one shape: When finished with a shape, click "Next shape". No need to copy and save first. The "KML" button will give you all the KML code you have created.\n'
	+'A finished shape on the map may be edited. Click on it. If you '
	+'inspect or edit finished markers, always click on "Next shape" before '
	+'you click on next marker, else infoWindow content will not swap.\n'
	+'To draw polygon with hole(-s): Click "Holes" and follow the instructions.'
	+'If you draw outer shape counterclockwise, draw inner shape clockwise and viceversa, else it will not work in all browsers.\n'
	+'Uncheck "Live code presentation" for greater speed when you draw shapes with large amount of points.\n'
	+'Check it when you want to see the code.';

	var docuname = "KML file with polygon for bird species range";
	var docudesc = "Source various books and websites";

	var markerOptions = {icon:tinyIcon};



    function initialize() {
      if (GBrowserIsCompatible()) {

        map = new GMap2(document.getElementById("map"), {draggableCursor:'default',draggingCursor:'pointer'});
        map.setCenter(new GLatLng(17.73889, 75.78258),5);
        //map.setCenter(new GLatLng(18.80,80.1),5);
        <%
        StringBuffer polygonSql = new StringBuffer("");

        while(rs2.next())
        {
                    savedCoordiantes =(String)rs2.getString("PolygonCoordinates");
                    if(savedCoordiantes !=null && !savedCoordiantes.equals(""))
                    {
                                StringTokenizer tokenizer = new StringTokenizer(savedCoordiantes,",");
                                polygonSql.append(" \n");
                                polygonSql.append("GEvent.addListener(map, 'tilesloaded', function(overlay,latlng) {");
                                polygonSql.append("var lonOffset = 0.01;");
                                polygonSql.append("var polygon = new GPolygon([new GLatLng(");
                                int cntr=1;
                                int tokens = tokenizer.countTokens();
                                while (tokenizer.hasMoreElements())
                                {
                                    String object = (String) tokenizer.nextElement();
                                    if(cntr%2 == 0)
                                    {
                                        //System.out.println("CNTR:::"+cntr);
                                        polygonSql.append(object +")");
                                        if(cntr != tokens)
                                            polygonSql.append(", new GLatLng(");
                                    }
                                    else
                                        polygonSql.append(object +",");
                                    cntr++;
                                }
                                polygonSql.append("], '#f33f00', 5, 0, '#ff0000', 0.2)");
                                polygonSql.append(" \n map.addOverlay(polygon);});");
                                polygonSql.append(" \n");
                }
        }
    %>
    <%=polygonSql%>
		        var customUI = map.getDefaultUI();
		        customUI.controls.maptypecontrol = false;
		        customUI.controls.menumaptypecontrol = true;
		        map.setUI(customUI);


		        /// pratiiiiiiii
		        <%
	if(fwUser.equalsIgnoreCase("Shramik")){
		%>
		        mylistener = GEvent.addListener(map,'click',mapClick);
		        geocoder = new GClientGeocoder();
		        GEvent.addListener(map,"mousemove",function(point){
		            mousemovepoint = point;
		            var LnglatStr6 = point.lng().toFixed(6) + ', ' + point.lat().toFixed(6);
		            var latLngStr6 = point.lat().toFixed(6) + ', ' + point.lng().toFixed(6);
		            gob("over").options[0].text = LnglatStr6;
		            gob("over").options[1].text = latLngStr6;
		            });
		        GEvent.addListener(map,"zoomend",mapzoom);
		        <%}%>
		        createstyleobjects();
		        createplacemarkobject();
       			createholeobject();
       			//alert('Calling setTool');
        		setTool(toolID);
        		tastFun();
      }
    }

function gob(e){if(typeof(e)=='object')return(e);if(document.getElementById)return(document.getElementById(e));return(eval(e))}

var map;
var toolID = 2;
var codeID = 1;
var shapeID = 1;
var polyShape;
var holeShape = new Array();
//var hn = 0; // hole number in one and same polygon
var ph = 0; // total number of holes on map
var polygonMode = false;
var markerMode = false;
var circlemode = false;
var rectanglemode = false;
var holemode = false;
//var headfoot = true;
var mylistener;
var editlistener = null;
var holelistener = new Array();
var editing = false;
var holeediting = false;
var notext = false;
var polygonDepth = "0";
var polyPoints = new Array();
var holePoints = new Array();
var holesarray = new Array();
var encpoints = new Array();
var encarray = new Array();
var holecoords = new Array();
var holebuilding;
var tinymarker;
var geocoder = null;

var mousemovepoint;
var editingstyles = 0;
var header = "";
//var lineColor2 = "#000000"; // black line
var cur = 0;
var plmcur = 0;
var polygonstyles = new Array();
var polylinestyles = new Array();
var placemarks = new Array();
var polygonholes = new Array();
var centerMarker = null;
var radiusMarker = null;
var markerissaved = true;
var lookatsaved = false;

var tinyIcon = new GIcon();
tinyIcon.image = "http://labs.google.com/ridefinder/images/mm_20_red.png";
tinyIcon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
tinyIcon.iconSize = new GSize(12,20);
tinyIcon.shadowSize = new GSize(22,20);
tinyIcon.iconAnchor = new GPoint(6,20);
tinyIcon.infoWindowAnchor = new GPoint(5,1);
// Set up our GMarkerOptions object literal
var markerOptions = {icon:tinyIcon};

var holeguide = 'Create polygon with one or more holes.\n' +
'Draw a closed shape in Polyline draw mode first, if you have not done that already.' +
'Then click "Draw hole"';
var circleguide = "Ready for circle\n" +
            "Use Polygon mode to draw a filled circle\n" +
            "Click the map where you want the center of the circle to be\n" +
            "Click at radius distance\n" +
            "and the circle is drawn";
var rectangleguide = "Ready for rectangle\n" +
            "Use Polygon mode to draw a filled rectangle\n" +
            "Click where you want the upper right corner placed";
var presentationguide = 'Click the "Document, Placemark" button to edit "name" and "description" elements.\n'
+'Click on the map. Create marker, polyline, polygon freehand or circle-shaped or rectangle. '
+'You may change draw mode at any time while drawing polyline and polygon. '
+'Use the Close Polyshape button to let start and end meet (not needed if you draw circle or rectangle).\n'
+'The "Edit lines" button is a toggle button - click to start editing, and click to stop editing.\n'
+'To draw more than one shape: When finished with a shape, click "Next shape". No need to copy and save first. The "KML" button will give you all the KML code you have created.\n'
+'A finished shape on the map may be edited. Click on it. If you '
+'inspect or edit finished markers, always click on "Next shape" before '
+'you click on next marker, else infoWindow content will not swap.\n'
+'To draw polygon with hole(-s): Click "Holes" and follow the instructions.'
+'If you draw outer shape counterclockwise, draw inner shape clockwise and viceversa, else it will not work in all browsers.\n'
+'Uncheck "Live code presentation" for greater speed when you draw shapes with large amount of points.\n'
+'Check it when you want to see the code.';

var docuname = "KML file with polygon for bird species range";
var docudesc = "Source various books and websites";

function polystyle() {
	//alert('polystyle');
    this.name = "rangecolour";
    this.kmlcolor = "660000FF";
    this.kmlfill = "660000FF";
    this.color = "#FF0000";
    this.fill = "#FF0000";
    this.width = 0.1;
    this.lineopac = .4;
    this.fillopac = .4;
    this.fillonoff = 1;
    this.lineonoff = 1;
}
function linestyle() {
	//alert('linestyle');
    this.name = "linecolour";
    this.kmlcolor = "660000FF";
    this.color = "#FF0000";
    this.width = 3;
    this.lineopac = .4;
}
function placemarkobject() {
//alert('placemarkobject');
    this.name = "distribution/range";
    this.desc = "";
    this.polygonstyle = "rangecolour";
    this.linestyle = "linecolour";
    this.curstyle = 0;
    this.tess = 1;
    this.alt = "clampToGround";
    this.plmtext = "";
    this.jstext = "";
    this.toolID = 2;
    this.hole = 0;
    this.ID = 0;
}
function holeobject() {
//alert('holeobject');
    this.points = "";
    this.plm = 0;
}
function createholeobject() {
//alert('createholeobject');
    var newhole = new holeobject();
    polygonholes.push(newhole);
}
function createstyleobjects() {
//alert('createstyleobjects');
    var polygonstyle = new polystyle();
    polygonstyles.push(polygonstyle);
    var polylinestyle = new linestyle();
    polylinestyles.push(polylinestyle);
}
function createplacemarkobject() {
//alert('createplacemarkobject');
    var thisplacemark = new placemarkobject();
    placemarks.push(thisplacemark);
}
function load() {
//alert('load');
    if(GBrowserIsCompatible()) {
        map = new GMap2(document.getElementById("map"), {draggableCursor:'default',draggingCursor:'pointer'});
      //  map.setCenter(new GLatLng(45.0,7.0),5);
      map.setCenter(new GLatLng(18.80,80.1),5);
        var customUI = map.getDefaultUI();
        customUI.controls.maptypecontrol = false;
        customUI.controls.menumaptypecontrol = true;
        map.setUI(customUI);
        mylistener = GEvent.addListener(map,'click',mapClick);
        geocoder = new GClientGeocoder();
        GEvent.addListener(map,"mousemove",function(point){
            mousemovepoint = point;
            var LnglatStr6 = point.lng().toFixed(6) + ', ' + point.lat().toFixed(6);
            var latLngStr6 = point.lat().toFixed(6) + ', ' + point.lng().toFixed(6);
            gob("over").options[0].text = LnglatStr6;
            gob("over").options[1].text = latLngStr6;
            });
        GEvent.addListener(map,"zoomend",mapzoom);
        createstyleobjects();
        createplacemarkobject();
        createholeobject();
    }
}

// mapClick - Handles the event of a user clicking anywhere on the map. activated by listener
// Adds a new point to the map and draws either a new line from the last point
// or a new polygon section depending on the drawing mode.
// A click on a shape reactivates it.
function mapClick(section, clickedPoint){
//alert('mapClick');
    if(editing == true) stopediting();
    // a drawn shape has been clicked, get ready to reactivate it
    if(polyPoints.length == 0 && section != null) {
        // polylines and polygons will give error message for .getTitle
        // markers will give error message for .getVertex
        // solution is to use try...catch
        try {
            var idforclickedsection = section.getTitle(); // markers have been saved with this as an ID
        }catch(err){
            var idforclickedsection = section.getVertex(0).lng().toFixed(3); // polylines and polygons have been saved with this as an ID
        }
        newlook(idforclickedsection, section); // find this shape in the saved placemarks array and print its saved information in text area
    }else{ // a click on a free space on the map
        if(polygonMode){
            pushpoint(mousemovepoint); // do not remember why not clicked point, maybe a Firefox problem?
        }else{
            if(markerMode) {
                createmarker(clickedPoint);
                logCoordinates();
            }else{
                if(section == null) pushpoint(clickedPoint);
            }
        }
    }
}

function createmarker(point) {
	<%
	if(fwUser.equalsIgnoreCase("Shramik"))
	{
	%>
//alert('createmarker');
    if(polyPoints.length > 0) {
        polyPoints = [];
        if(polyShape) map.removeOverlay(polyShape);
        if(holeShape.length > 0) {
            for(var i = 0; i < holeShape.length; i++) {
                map.removeOverlay(holeShape[i]);
            }
        }
        if(tinymarker) map.removeOverlay(tinymarker);
    }
    polyPoints[0] = point;
    placemarks[plmcur].ID = polyPoints[0];
    var realmarker = new GMarker(point, {title:placemarks[plmcur].ID});
    map.addOverlay(realmarker);
    markerissaved = false;
    GEvent.removeListener(mylistener);
    GEvent.addListener(realmarker, "click", function() {
        realmarker.openInfoWindowHtml(placemarks[plmcur].name+"<br />"+placemarks[plmcur].desc);
    });
    GEvent.addListener(realmarker, "infowindowclose", function() {
        if (markerissaved == false) alert('Click "Next shape" and try again');
    });
    <%}%>
}

function pushpoint(point){
//alert('pushpoint');
    if(circlemode==false && rectanglemode==false){
        if(holemode){
            // Push onto polypoints of existing poly, building inner boundary
            holePoints.push(point);
        }else{
            polyPoints.push(point);
        }
        drawCoordinates();
    }else{
        if(circlemode) clickforCircle(point);
        if(rectanglemode) collectrectanglepoints(point);
    }
}

function newlook(id,shape) {
alert('newlook');
    // step through saved placemark objects until the one clicked on is found
    for (var i = 0; i < placemarks.length; i++) {
        if (placemarks[i].ID == id) break;
    }
    plmcur = i;
    cur = placemarks[plmcur].curstyle;
    toolID = gob("toolchoice").value = placemarks[plmcur].toolID;
   // alert('toolID---after geting toolID---->'+toolID)
    
   setTool();
    // its a marker. remove mapclicklistener else close infoWindow could elicit a mapclick
    if(toolID == 3) {
        GEvent.removeListener(mylistener);
        polyPoints[0] = placemarks[plmcur].ID;
        tinymarker = new GMarker(polyPoints[0], markerOptions);
        map.addOverlay(tinymarker);
    }else{
        // if polyline or polygon, fill pointsarray(-s). print marker at startpoint
        var j = shape.getVertexCount(); // get the amount of points
        for (i=0; i<j; i++){
            polyPoints[i] = shape.getVertex(i); // update polyPoints array
        }
        tinymarker = new GMarker(polyPoints[0], markerOptions); // marker always at startpoint
        map.addOverlay(tinymarker);
        if (placemarks[plmcur].hole != 0) { // if hole(-s), get holepoints
            var thesepoints = [];
            for(i=0; i<polygonholes.length; i++) {
                if(polygonholes[i].plm == placemarks[plmcur].ID) {
                    thesepoints.push(polygonholes[i].points);
                }
            }
            for(i=0; i<thesepoints.length; i++) {
                if(i == thesepoints.length-1) {
                    holePoints = thesepoints[i];
                }else{
                    holesarray.push(thesepoints[i]);
                }
            }
            var thesepoints = [];
            holemode = true;
        }
    }
    polyShape = shape;
    lookatsaved = true;
    if(codeID == 1) coo.value = header + placemarks[plmcur].plmtext + '</Document>\n</kml>';
    if(codeID == 2) logCoordinates();
}

function setTool(toolID){
    if (markerMode && markerissaved == false) {
        nextshape();
    }
    if(editing == true) stopediting();
   // alert('After returnig stopediting()');
    
   // gob('EditButton').disabled = '';
   // alert('---1---');
  //  gob('CloseButton').disabled = '';
  //  alert('---2---');
   // gob('dlpButton').disabled = '';
  //  alert('---3---');
   // gob('dlpButton').value = 'Delete Last Point';
   //// alert('---3---');
    //alert("toolID-->"+toolID);
    if(toolID == 1){
        polygonMode = false;
        markerMode = false;
        if(polyPoints.length > 1) drawCoordinates();
    }
    if(toolID == 2){
        polygonMode = true;
        markerMode = false;
        if(polyPoints.length > 1) drawCoordinates();
    }
    if(toolID == 3){
        polygonMode = false;
        markerMode = true;
        gob('EditButton').disabled = 'disabled';
        gob('CloseButton').disabled = 'disabled';
        gob('dlpButton').value = 'Delete Marker';
        holemode = false;
        circlemode = false;
        rectanglemode = false;
        if(codeID == 3) showCode();
    }
}

function setCode(){
//alert('setCode');
    if(codeID == 1 || codeID == 2){ //KML
        if(polyPoints.length > 0){
            logCoordinates();
        }else{
            if(circlemode) coo.value = circleguide;
            if(rectanglemode) coo.value = rectangleguide;
            if(circlemode == false && rectanglemode == false) coo.value = presentationguide;
        }
    }
    if(codeID == 3){ // Javascript
        showCode();
    }
}

function setShape(){
//alert('setShape');
    if(shapeID == 1){ // Freehand
        circlemode = false;
        rectanglemode = false;
        coo.value = presentationguide;
    }
    if(shapeID == 2){ // Circle
        circlemode = true;
        rectanglemode = false;
        if(!polyPoints.length) coo.value = circleguide;
    }
    if(shapeID == 3){ // Rectangle
        rectanglemode = true;
        circlemode = false;
        if(!polyPoints.length) coo.value = rectangleguide;
        showthis("rectangle");
    }
}
// Holes button has been pressed
function holeshape() {
//alert('holeshape');
    if(holePoints.length == 0) {
        coo.value = holeguide;
        showthis("holes");
    }
}
function createhole() {
//alert('createhole');
    if(holePoints.length == 0) {
        if(polyPoints.length > 0) {
            gob('nextshapebutton').disabled = 'disabled';
            gob('holesbutton').disabled = 'disabled';
            if(polygonMode) {
                toolID = gob('toolchoice').value = 1; // polyline draw mode
                setTool();
            }
            map.removeOverlay(tinymarker);
            holemode = true;
        }
    }
}
function nexthole() {
//alert('nexthole');
    if(holePoints.length > 0) {
        map.removeOverlay(tinymarker);
        GEvent.removeListener(mylistener);
        mylistener = GEvent.addListener(map,'click',mapClick);
        holesarray.push(holePoints);
        holecoords.push(holebuilding);
        gob('holeok').value = holesarray.length + ". hole saved";
        gob('holeok').disabled = 'disabled';
        holePoints = [];
        ph++;
        createholeobject();
    }
}
function enablebutton() {
//alert('enablebutton');
    gob('nextshapebutton').disabled = '';
    gob('holesbutton').disabled = '';
    gob('holeok').disabled = '';
    gob('holeok').value = "Draw hole";
    closethis('holes');
}
// First and second stop for circle
function clickforCircle(point){
//alert('clickforCircle');
    if(!centerMarker){
        centerMarker = new GMarker(point,{title:"Start"});
        map.addOverlay(centerMarker);
    }
    else if(!radiusMarker){
        radiusMarker = point;
        collectcirclepoints(); // fill the polyPoints array with all the points needed to draw a circle
        map.removeOverlay(centerMarker);
        centerMarker = null;
        radiusMarker = null;
        drawCoordinates();
    }
}
function collectcirclepoints(){
//alert('collectcirclepoints');
    var zoom = map.getZoom();
    var normalProj = G_NORMAL_MAP.getProjection();
  	var centerPt = normalProj.fromLatLngToPixel(centerMarker.getPoint(),zoom);
  	var radiusPt = normalProj.fromLatLngToPixel(radiusMarker,zoom);
    with (Math){
	    var radius = floor(sqrt(pow((centerPt.x-radiusPt.x),2) + pow((centerPt.y-radiusPt.y),2)));
        for (var a = 0 ; a < 361 ; a+=10 ){
        	var aRad = a*(PI/180);
        	y = centerPt.y + radius * sin(aRad)
        	x = centerPt.x + radius * cos(aRad)
        	var p = new GPoint(x,y);
            if(holemode){
        	    holePoints.push(normalProj.fromPixelToLatLng(p, zoom));
            }else{
                polyPoints.push(normalProj.fromPixelToLatLng(p, zoom));
            }
	    }
        if(holemode){
            var helper = [];
            var k = 0;
            var j = holePoints.length;
            for (var i = j-1; i>-1; i--) {
                helper[k] = holePoints[i];
                k++;
            }
            holePoints = helper;
        }
    }
}
function collectrectanglepoints(latlng){
//alert('collectrectanglepoints');
    var lat = latlng.lat();
    var lon = latlng.lng();
    var latOffset = gob("recheight").value;
    var lonOffset = gob("recwidth").value;
    var firstPoint = new GLatLng(parseFloat(lat - latOffset),parseFloat(lon - lonOffset));
    var secondPoint = new GLatLng(parseFloat(lat + latOffset),parseFloat(lon - lonOffset));
    var thirdPoint = new GLatLng(parseFloat(lat + latOffset),parseFloat(lon + lonOffset));
    var fourthPoint = new GLatLng(parseFloat(lat - latOffset),parseFloat(lon + lonOffset));
    document.getElementById("recok").value = "Use entered values";
    if(holemode){
        holePoints.push(firstPoint);
        holePoints.push(fourthPoint);
        holePoints.push(thirdPoint);
        holePoints.push(secondPoint);
        holePoints.push(firstPoint);
    }else{
        polyPoints.push(firstPoint);
        polyPoints.push(secondPoint);
        polyPoints.push(thirdPoint);
        polyPoints.push(fourthPoint);
        polyPoints.push(firstPoint);
    }
    drawCoordinates();
}
// let start and end meet, a button has been clicked
function closePoly(){
//alert('closePoly');
    if(!circlemode && !rectanglemode){ // in circlemode this has been done in function collectcirclepoints
        // Push onto polypoints of existing polyline
        if(holemode){
            if(holePoints.length > 2){
                holePoints.push(holePoints[0]);
            }
        }else{
            // Push onto polypoints of existing polyline/polygon
            if(polyPoints.length > 2) polyPoints.push(polyPoints[0]);
        }
        drawCoordinates();
    }
}
function stopediting(){
//alert('stopediting');
    GEvent.removeListener(editlistener);
    polyShape.disableEditing();
    editing = false;
    if(holeShape[0] != []){
        for(var i=0; i<holeShape.length; i++) {
            GEvent.removeListener(holelistener[i]);
            holeShape[i].disableEditing();
        }
        holeediting = false;
    }
}
// the "Edit lines" button has been pressed
function editlines(){
//alert('editlines');
    if(editing == true){
        stopediting();
        //drawCoordinates();
    }else{
        if(polyPoints.length > 0){
            toolID = gob('toolchoice').value = 1; // editing is set to be possible only in polyline draw mode
            setTool();
            polyShape.enableEditing();
            editlistener = GEvent.addListener(polyShape,'lineupdated',updateCoordinates);
            editing = true;
            if(holeShape[0] != []){
                for(var i=0; i<holeShape.length; i++) {
                    holeShape[i].enableEditing();
                    holelistener[i] = GEvent.addListener(holeShape[i],'lineupdated',updateCoordinates);
                }
                holeediting = true;
                holecoords = [];
                holesarray = [];
            }
            coo.value = "Drag a point. When finished editing, click the edit-button again or continue drawing.";
        }
    }
}
// when editing lines, the points arrays are updated with this function. activated by listener
function updateCoordinates(){
//alert('updateCoordinates');
    var j = polyShape.getVertexCount(); // get the amount of points
    for (var i = 0; i<j; i++){
        polyPoints[i] = polyShape.getVertex(i); // update polyPoints array
    }
    if(holeShape[0] != []){
        var text = "";
        var points = [];
        for(var i=0; i<holeShape.length-1; i++) {
            j = holeShape[i].getVertexCount(); // get the amount of points
            for (var m = 0; m<j; m++){
                points[m] = holeShape[i].getVertex(m);
                var lat = points[m].lat();
                alert(lat);
                var longi = points[m].lng();
                alert(longi);
                text += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
            }
            holecoords[i] = text;
            holesarray[i] = points;
            alert(holesarray[i]);
            text = "";
            points = [];
        }
        i = holeShape.length-1;
        j = holeShape[i].getVertexCount();
        for (var n=0; n<j; n++){
            holePoints[n] = holeShape[i].getVertex(n); // update holePoints array
        }
    }
    logCoordinates();
}
// draw on the map
function drawCoordinates(){
//alert('drawCoordinates');
    // Recreate shapes
    if(polyPoints.length > 0){
        if(polyShape) map.removeOverlay(polyShape);
        if(holeShape.length > 0) {
            for(var i = 0; i < holeShape.length; i++) {
                map.removeOverlay(holeShape[i]);
            }
        }
        if(tinymarker) map.removeOverlay(tinymarker);
        if(polygonstyles[cur].lineonoff == 0) polygonstyles[cur].color = polygonstyles[cur].fill;
        if(polygonMode){ // polygon
            if(holePoints.length > 0){ // let's create a polygon with a hole
                encpoints = [];
                var verySmall = 0.00001;
        		var myZoomFactor = 2;
        		var myNumLevels = 18;
        		var polylineEncoder = new PolylineEncoder(myNumLevels,myZoomFactor,verySmall,true);
        		encpoints.push(polylineEncoder.dpEncode(polyPoints));
                for(var i = 0; i < holesarray.length; i++) {
                    encpoints.push(polylineEncoder.dpEncode(holesarray[i]));
                }
                if(holePoints.length > 0) {
                    encpoints.push(polylineEncoder.dpEncode(holePoints));
                }
                encarray = [];
                for (i=0; i<encpoints.length; i++) {
                    encarray[i] ={
                    points: encpoints[i].encodedPoints,
                    levels: encpoints[i].encodedLevels,
                    color: polygonstyles[cur].color,
                    opacity: polygonstyles[cur].lineopac,
                    weight: polygonstyles[cur].width,
                    numLevels: 18,
                    zoomFactor: 2};
                }
                polyShape = new GPolygon.fromEncoded({
                    polylines: encarray,
                    fill: true,
                    color: polygonstyles[cur].fill,
                    opacity: polygonstyles[cur].fillopac,
                    outline: true
                });
                placemarks[plmcur].jstext = jscopy(); // save a printable version of the javascript
                placemarks[plmcur].hole = 1; // remember that this polygon has hole(-s)
                if(lookatsaved == false) {
                    createholeobject();
                    ph++;
                }
                GEvent.removeListener(mylistener);
            }else{ // normal polygon
                if(polyPoints.length == 2){ // line between the 2 first points must be drawn as Polyline for Firefox to understand
                    polyShape = new GPolyline(polyPoints,polygonstyles[cur].color,polygonstyles[cur].width,polygonstyles[cur].lineopac);
                }else{
                    polyShape = new GPolygon(polyPoints,polygonstyles[cur].color,polygonstyles[cur].width,polygonstyles[cur].lineopac,polygonstyles[cur].fill,polygonstyles[cur].fillopac);
                }
                //addshapelistener(polyShape);
            }
        }else{ // polyline
            polyShape = new GPolyline(polyPoints,polylinestyles[cur].color,polylinestyles[cur].width,polylinestyles[cur].lineopac);
            // polyline, intended to be the hole border
            if(holePoints.length > 0) {
                var i = 0;
                if(holesarray.length > 0) { // re-draw already completed holes
                    for(i = 0; i < holesarray.length; i++) {
                    holeShape[i] = new GPolyline(holesarray[i],polygonstyles[cur].color,polylinestyles[cur].width,polylinestyles[cur].lineopac);
                    }
                }
                holeShape[i] = new GPolyline(holePoints,polygonstyles[cur].color,polylinestyles[cur].width,polylinestyles[cur].lineopac);
                // two properties to be remembered for the hole object
                polygonholes[ph].points = holePoints;
                polygonholes[ph].plm = polyPoints[0].lng().toFixed(3);
            }
        }
        if(holePoints.length > 0){
            tinymarker = new GMarker(holePoints[0], markerOptions); // marker always at startpoint
            map.addOverlay(tinymarker);
        }else{
            tinymarker = new GMarker(polyPoints[0], markerOptions); // marker always at startpoint
            map.addOverlay(tinymarker);
        }
        // add the updated shape(s), drawn as polylines
        if(holePoints.length > 0 && !polygonMode) {
            for(var i = 0; i < holeShape.length; i++) {
                map.addOverlay(holeShape[i]);
            }
        }
        map.addOverlay(polyShape);
        logCoordinates();
    }
}

// not used. an option to open infoWindow when a polygon is clicked
function addshapelistener(pol) {
//alert('addshapelistener');
    GEvent.addListener(pol, "click", function(clickedpoint) {
        map.openInfoWindowHtml(clickedpoint,placemarks[plmcur].name);
        });
}

// logCoordinates - prints out coordinates of global polyPoints (and holePoints) array
// saves placemark object properties not already saved
function logCoordinates()
{ //prati
	//alert('logCoordinates');
	<%
	if(fwUser.equalsIgnoreCase("Shramik")){
		%>
    var j = polyPoints.length; // get the amount of points
    var plmtext = "";
    var coordiantesList = "";
    if((j>=3))
    { 
    	//alert('0---b4 for ----');
        for (var i=0; i<j; i++)
        {
        	// alert('--in side for---');
             var lat = polyPoints[i].lat();
             var longi = polyPoints[i].lng();
             coordiantesList += lat + "," + longi +",";
         }
         document.getElementById("cordonatestoasave").value = coordiantesList;
         document.getElementById("cordisubmit").disabled=false;
    }
    var coords1 = coords2 = "";
    
   if(j>=5)
    {
    if (notext == false && (j > 0)){
       // alert('inside if');
        if(codeID == 3){
            showCode();
        }else{
            if(holePoints.length > 0){
                var k = holePoints.length; // get the amount of points
                var hn = holecoords.length;
            }
            if(codeID == 1) {
                if(polygonMode || holemode){
                    var polygonheader = '<Placemark><name>'+placemarks[plmcur].name+'</name>\n' +
                    '<description>'+placemarks[plmcur].desc+'</description>\n' +
                    '<styleUrl>#'+placemarks[plmcur].polygonstyle+'</styleUrl>\n' +
                    '<Polygon>\n<tessellate>'+placemarks[plmcur].tess+'</tessellate><altitudeMode>'+placemarks[plmcur].alt+'</altitudeMode>\n' +
                    '<outerBoundaryIs><LinearRing><coordinates>\n';
                    var polygoncoordsend = "</coordinates></LinearRing></outerBoundaryIs>\n";
                    var innercoordsstart = "<innerBoundaryIs><LinearRing><coordinates>\n";
                    var innercoordsend = "</coordinates></LinearRing></innerBoundaryIs>\n";
                    var polygonfooter = '</Polygon>\n</Placemark>\n';
                }
                if (!polygonMode && !holemode && !markerMode) {
                    var lineheader = '<Placemark><name>'+placemarks[plmcur].name+'</name>\n' +
                    '<description>'+placemarks[plmcur].desc+'</description>\n' +
                    '<styleUrl>#'+placemarks[plmcur].linestyle+'</styleUrl>\n' +
                    '<LineString>\n<tessellate>'+placemarks[plmcur].tess+'</tessellate><altitudeMode>'+placemarks[plmcur].alt+'</altitudeMode>\n<coordinates>\n';
                    var linefooter = '</coordinates>\n</LineString>\n</Placemark>\n';
                }
                if (markerMode) {
                    var markerheader = '<Placemark><name>'+placemarks[plmcur].name+'</name>\n' +
                    '<description>'+placemarks[plmcur].desc+'</description>\n<Point>\n<coordinates>';
                    var markerfooter = '</coordinates>\n</Point>\n</Placemark>\n';
                }
            }
            // this is the upper part of the KML code, document header and styles
            if(codeID == 1) header = '<?xml version="1.0" encoding="UTF-8"?>\n' +
            '<kml xmlns="http://www.opengis.net/kml/2.2">\n' +
            '<Document><name>'+docuname+'</name>\n' +
            '<description>'+docudesc+'</description>\n';
            var last = "";
            var length = polygonstyles.length;
            if (length > 1) {
                for (var i=0; i<length; i++) {
                    if (polygonstyles[i].name != last) {
                        header += '<Style id="'+polygonstyles[i].name+'">\n' +
                        '<LineStyle><color>'+polygonstyles[i].kmlcolor+'</color><width>'+polygonstyles[i].width+'</width></LineStyle>\n' +
                        '<PolyStyle>\n<color>'+polygonstyles[i].kmlfill+'</color>' +
                        '<fill>'+polygonstyles[i].fillonoff+'</fill><outline>'+polygonstyles[i].lineonoff+'</outline>\n</PolyStyle>\n' +
                        '</Style>\n';
                        last = polygonstyles[i].name;
                    }
                }
                for (var i=0; i<length; i++) {
                    if (polylinestyles[i].name != last) {
                        header += '<Style id="'+polylinestyles[i].name+'">\n' +
                        '<LineStyle><color>'+polylinestyles[i].kmlcolor+'</color><width>'+polylinestyles[i].width+'</width></LineStyle>\n' +
                        '</Style>\n';
                        last = polylinestyles[i].name;
                    }
                }
            }else{ // only 1 polygonstyle and 1 polylinestyle
                header += '<Style id="'+polygonstyles[cur].name+'">\n' +
                '<LineStyle><color>'+polygonstyles[cur].kmlcolor+'</color><width>'+polygonstyles[cur].width+'</width></LineStyle>\n' +
                '<PolyStyle>\n<color>'+polygonstyles[cur].kmlfill+'</color>' +
                '<fill>'+polygonstyles[cur].fillonoff+'</fill><outline>'+polygonstyles[cur].lineonoff+'</outline>\n</PolyStyle>\n' +
                '</Style>\n' +
                '<Style id="'+polylinestyles[cur].name+'">\n' +
                '<LineStyle><color>'+polylinestyles[cur].kmlcolor+'</color><width>'+polylinestyles[cur].width+'</width></LineStyle>\n' +
                '</Style>\n';
            }
            // check mode, start placemark printing and placemark saving
            if(polygonMode){ // print polygon
                placemarks[plmcur].toolID = 2;
                // print coords header
                plmtext = polygonheader;
                // loop to print coords within the outerBoundaryIs code
                // coordinates are printed with a maximum of 6 decimal places, function roundVal takes care of this
                for (var i=0; i<j; i++){
                    var lat = polyPoints[i].lat();
                    var longi = polyPoints[i].lng();
                    coords1 += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
                    plmtext += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
                }
                placemarks[plmcur].ID = polyPoints[0].lng().toFixed(3); // remember this polygon
                plmtext += polygoncoordsend;
                if(holemode){
                    // check if there are already one or more saved holes
                    if(hn > 0){
                        for(var i=0; i<hn; i++){
                            plmtext += innercoordsstart;
                            plmtext += holecoords[i];
                            plmtext += innercoordsend;
                        }
                    }
                    if(holePoints.length > 0){
                        plmtext += innercoordsstart;
                        // loop to print inner boundary coords
                        for(var i=0; i<k; i++){
                            var lat = holePoints[i].lat();
                            var longi = holePoints[i].lng();
                            //coords2 += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
                            plmtext += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
                        }
                        plmtext += innercoordsend;
                    }
                }
                plmtext += polygonfooter;
            }
            if(markerMode) {
                placemarks[plmcur].toolID = 3;
                plmtext = markerheader;
                var lat = polyPoints[0].lat();
                var longi = polyPoints[0].lng();
                coords1 = roundVal(longi) + "," + roundVal(lat);
                plmtext += roundVal(longi) + "," + roundVal(lat);
                plmtext += markerfooter;
            }
            if(!polygonMode && !markerMode) { // print polyline(s)
                if(holemode){ // print a polygon with hole, on the map the shapes are shown as lines, but
                    // the kml will be printed as a polygon with a hole, outerBoundaryIs with coordinates
                    // and innerBoundaryIs with coordinates
                    plmtext = polygonheader;
                    // loop to print outer boundary coords
                    for (var i=0; i<j; i++){
                        var lat = polyPoints[i].lat();
                        var longi = polyPoints[i].lng();
                        coords1 += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
                        plmtext += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
                    }
                    plmtext += polygoncoordsend;
                    if(hn > 0){
                        for(var i=0; i<hn; i++){
                            plmtext += innercoordsstart;
                            plmtext += holecoords[i];
                            plmtext += innercoordsend;
                        }
                    }
                    // loop to print inner boundary coords
                    if(holePoints.length > 0){
                        holebuilding = "";
                        plmtext += innercoordsstart;
                        for (var i=0; i<k; i++){
                            var lat = holePoints[i].lat();
                            var longi = holePoints[i].lng();
                            coords2 += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
                            plmtext += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
                            // holebuilding will be saved to array holecoords when hole is finished. used when more than one hole
                            holebuilding += roundVal(longi) + "," + roundVal(lat) + "," + polygonDepth + " \n";
                        }
                        plmtext += innercoordsend;
                    }
                    plmtext += polygonfooter;
                    
                }else{ // print single polyline
                    placemarks[plmcur].toolID = 1;
                    plmtext = lineheader;
                    for (var i=0; i<j; i++){
                        var lat = polyPoints[i].lat();
                        var longi = polyPoints[i].lng();
                        coords1 += roundVal(longi) + "," + roundVal(lat) + ",0 \n";
                        plmtext += roundVal(longi) + "," + roundVal(lat) + ",0 \n";
                    }
                    placemarks[plmcur].ID = polyPoints[0].lng().toFixed(3); // remember this polyline
                    plmtext += linefooter;
                }
            }
            if(codeID == 1) coo.value = header + plmtext + '</Document>\n</kml>';
            if(codeID == 2) coo.value = coords1 + coords2;
            if(lookatsaved == false || (lookatsaved == true && editing == true)) {
                placemarks[plmcur].plmtext = plmtext;
            }
           
            alert(plmtext);
            plmtext = "";
    
            coords1 = coords2 = "";
        }
    }
}
   <%}%>
}
function mapzoom(){
//alert('mapzoom');
    var mapZoom = map.getZoom();
    gob("myzoom").value = mapZoom;
}
function mapcenter(){
//alert('mapcenter');
    var mapCenter = map.getCenter();
    var latLngStr6 = mapCenter.lat().toFixed(6) + ', ' + mapCenter.lng().toFixed(6);
    gob("centerofmap").value = latLngStr6;
}
function showCodeintextarea(){
//alert('showCodeintextarea');
    if (notext == false){
        gob("presentcode").checked = false;
        notext = true;
    }else{
        gob("presentcode").checked = true;
        notext = false;
        if(polyPoints.length > 0){
            logCoordinates();
        }
    }
}
// make a copy of jscode for polygon with hole(-s)
function jscopy() {
//alert('jscopy');
    var jscode = 'var polyShape = new GPolygon.fromEncoded({\npolylines: [\n';
        for(i = 0; i < encarray.length; i++) {
            jscode += '{points: '+encpoints[i].encodedPoints+',\n'+
                         'levels: '+encpoints[i].encodedLevels+',\n'+
                         'color: '+polygonstyles[cur].color+',\n'+
                         'opacity: '+polygonstyles[cur].lineopac+',\n'+
                         'weight: '+polygonstyles[cur].width+',\n'+
                         'numLevels: 18,\n';
            if(i == encarray.length-1) {
                jscode += 'zoomFactor: 2}],\n';
            }else{
                jscode += 'zoomFactor: 2},\n';
            }
        }
        jscode += 'fill: true,\n'+
                      'color: '+polygonstyles[cur].fill+',\n'+
                      'opacity: '+polygonstyles[cur].fillopac+',\n'+
                      'outline: true\n'+
                    '});\n';
        jscode +="map.addOverlay(polyShape);";
        return jscode;
}
function showCode(){ //Javascript, not KML
    if(placemarks[plmcur].jstext != "") { // show code for polygon with hole
        coo.value = placemarks[plmcur].jstext;
        return;
    }
    if(polygonMode && holemode) { // show code for polygon with hole
        coo.value = jscopy();
        return;
    }
    var j = polyPoints.length;
    var k = holePoints.length;
    var pweight = polygonstyles[cur].width;
    var lweight = polylinestyles[cur].width;
    coo.value = "var points =\n[\n";
    if (markerMode) {
        if(polyPoints.length > 1) createmarker(polyPoints[0]);
        var lat = polyPoints[0].lat();
        var longi = polyPoints[0].lng();
        coo.value += "new GLatLng(" + roundVal(lat) + "," + roundVal(longi) + ")";
    }else{
        for(var i=0; i<j; i++){
            var lat = polyPoints[i].lat();
            var longi = polyPoints[i].lng();
            coo.value += "new GLatLng(" + roundVal(lat) + "," + roundVal(longi) + ")";
            if(i < (j-1)) coo.value += ",\n";
        }
        if(k>0){
            coo.value += ",\n";
            pweight = 0;
            for (var i=0; i<k; i++){
                var lat = holePoints[i].lat();
                var longi = holePoints[i].lng();
                coo.value += "new GLatLng(" + roundVal(lat) + "," + roundVal(longi) + ")";
                if(i < (k-1)) coo.value += ",\n";
            }
        }
    }
    coo.value +="\n];\n";
    if (markerMode) {
        coo.value +="var marker = new GMarker(points);\n";
        coo.value +="map.addOverlay(marker);\n";
        coo.value += 'GEvent.addListener(marker, "click", function() {\n'
        +'marker.openInfoWindowHtml('+placemarks[plmcur].name+"<br />"+placemarks[plmcur].desc+');\n'
        +'})';
    }else{
        if(polygonMode){
            coo.value +="var polygon = new GPolygon(points,'" + polygonstyles[cur].color + "'," + pweight + "," + polygonstyles[cur].lineopac + ",'" + polygonstyles[cur].fill + "'," + polygonstyles[cur].fillopac + ");\n";
            coo.value +="map.addOverlay(polygon);";
        }else{
            coo.value +="var polyline = new GPolyline(points,'" + polylinestyles[cur].color + "'," + lweight + "," + polylinestyles[cur].lineopac + ");\n";
            coo.value +="map.addOverlay(polyline);";
        }
        if(gob('holes').style.visibility == 'visible') coo.value += '\n\nBuilding. The code will change to new GPolygon.fromEncoded'
    }
}
function showKML() {
//alert('showKML');
    if (polyPoints.length > 0 || plmcur > 0) {
        if(codeID != 1) {
            codeID = gob('codechoice').value = 1; // complete KML
            setCode();
        }
        coo.value = header;
        for (var i = 0; i < placemarks.length; i++) {
            coo.value += placemarks[i].plmtext;
        }
        coo.value += '</Document>\n</kml>';
    }
}
// not used
function popback(){
//alert('popback');
    var obj = gob("newcontent");
    obj.style.visibility = "hidden";
}
function removeshape(){
//alert('removeshape');
    map.removeOverlay(polyShape);
    nooverlayvariables();
}
function nextshape(){
//alert('nextshape');
    //button has been pressed
    if(tinymarker) map.removeOverlay(tinymarker);
    markerissaved = true;
    lookatsaved = false;
    GEvent.removeListener(mylistener);
    mylistener = GEvent.addListener(map,'click',mapClick);
    if(polyPoints.length > 0){
        if(editing == true) stopediting();
        plmcur = placemarks.length - 1;
        if(placemarks[plmcur].ID != 0) {
            createplacemarkobject();
            plmcur = placemarks.length -1;
            stylesforthisplacemark();
        }
        cur = placemarks[plmcur].curstyle;
        nooverlayvariables();
        removesomemodes();
    }
}
function subclean(){
//alert('subclean');
    nooverlayvariables();
    removesomemodes();
    toolID = gob('toolchoice').value = 1; // polyline draw mode
    setTool();
    codeID = gob('codechoice').value = 1; // complete KML
    setCode();
    shapeID = gob('shapechoice').value = 1; // freehand
    setShape();
    coo.value = presentationguide;
}
function nooverlayvariables(){
//alert('nooverlayvariables');
    polyShape = null;
    /*for(var i = 0; i < holesarray.length; i++) {
        holeShape[i] = [];
    }*/
    //while(holeShape.length>0) {holeShape.pop};
    holeShape = [];
    polyPoints = [];
    holePoints = [];
    holesarray = [];
}
function removesomemodes(){
//alert('removesomemodes');
    holemode = false;
    circlemode = false;
    rectanglemode = false;
}
// Clear current Map
function clearMap(){
//alert('clearMap');
    if(editing == true) stopediting();
    if(gob("rectangle").style.visibility == "visible") {
        map.clearOverlays();
        nooverlayvariables();
        toolID = gob('toolchoice').value = 1; // polyline draw mode
        setTool();
        coo.value = rectangleguide;
        return;
    }
    if(gob("holes").style.visibility == "visible") {
        map.clearOverlays();
        nooverlayvariables();
        toolID = gob('toolchoice').value = 1; // polyline draw mode
        setTool();
        coo.value = holeguide;
        holemode = false;
        gob('nextshapebutton').disabled = '';
        gob('holesbutton').disabled = '';
        gob('holeok').disabled = '';
        gob('holeok').value = "Draw hole";
        //hn = 0;
        ph = 0;
        return;
    }
    subclean();
    map.clearOverlays();
    gob('EditButton').disabled = '';
    gob('CloseButton').disabled = '';
    gob('nextshapebutton').disabled = '';
    gob('dlpButton').value = 'Delete Last Point';
    lookatsaved = false;
    markerissaved = true;
    ph = 0;
    cur = 0;
    plmcur = 0;
    placemarks = [];
    createplacemarkobject();
    GEvent.removeListener(mylistener);
    mylistener = GEvent.addListener(map,'click',mapClick);
}
// Delete last Point
// This function removes the last point from the Polyline/Polygon and redraws
// map. It also removes a current marker.
function deleteLastPoint(){
//alert('deleteLastPoint');
    if(editing == true) stopediting();
    if (markerMode && markerissaved == true) {
        var j = placemarks.length;
        if (j > 1) {
            map.removeOverlay(polyShape);
            // this is how to remove one element from an array and re-index it.
            // plmcur is the key number for the element to be removed
            var newplacemarks = new Array;
            for (var i = 0; i < j; i++) {
                if (i != plmcur) {
                    newplacemarks.push(placemarks[i]);
                }
            }
            placemarks = newplacemarks;
            // j-2 is 0 when the last marker has been removed. the remaining placemark object should be
            // a created object not in use. this may be unneccessary
            if (placemarks[j-2].plmtext != "") {
                createplacemarkobject();
            }
        }
        if(tinymarker) map.removeOverlay(tinymarker);
        markerissaved = false;
    }else{
        if(!circlemode && !rectanglemode){ // do not allow delete last point in a circle or rectangle
            if(polyPoints || holePoints){
                if(!holemode){
                    // pop last element of polyPoints array
                    polyPoints.pop();
                    drawCoordinates();
                }else{
                    // pop last element of holePoints array
                    holePoints.pop();
                    drawCoordinates();
                }
            }
        }
    }
}
function showAddress(address){
//alert('showAddress');
  if(geocoder){
   geocoder.getLatLng(address,
     function(point){
       if(!point){
         alert(address + " not found");
       }else{
         var mapZoom = map.getZoom();
         map.setCenter(point, mapZoom);
         // Create our "tiny" marker icon
         var tinyIcon = new GIcon();
         tinyIcon.image = "http://labs.google.com/ridefinder/images/mm_20_red.png";
         tinyIcon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
         tinyIcon.iconSize = new GSize(12,20);
         tinyIcon.shadowSize = new GSize(22,20);
         tinyIcon.iconAnchor = new GPoint(6,20);
         tinyIcon.infoWindowAnchor = new GPoint(5,1);
         // Set up our GMarkerOptions object literal
         markerOptions = {icon:tinyIcon};
         var centerpoint = new GMarker(point, markerOptions);
         map.addOverlay(centerpoint);
       }
     }
    );
  }
}
function docudetails(){
alert('docudetails');
    if (lookatsaved == false) {
        docuname = gob("doc1").value;
        docudesc = gob("doc2").value;
        placemarks[plmcur].name = gob("plm1").value;
        placemarks[plmcur].desc = gob("plm2").value;
        stylesforthisplacemark();
    }else{
        gob("plm1").value = placemarks[plmcur].name;
        gob("plm2").value = placemarks[plmcur].desc;
        gob("plm3").value = placemarks[plmcur].tess;
        gob("plm4").value = placemarks[plmcur].alt;
        gob("doc1").value = docuname;
        gob("doc2").value = docudesc;
        lookatsaved = false;
    }
    logCoordinates();
}
function savestyles() {
alert('savestyles');
    var newpolystyle = new polystyle();
    var newlinestyle = new linestyle();
    newpolystyle.name = gob("st1").value;
    newpolystyle.width = gob("st3").value;
    newpolystyle.color = gob("st3a").value;
    newpolystyle.lineopac = gob("st3b").value;
    var newlinecolor = getopacityhex(newpolystyle.lineopac) + color_html2kml(""+newpolystyle.color);
    gob("st2").innerHTML = newlinecolor;
    newpolystyle.kmlcolor = newlinecolor;
    newpolystyle.fill = gob("st4a").value;
    newpolystyle.fillopac = gob("st4b").value;
    var newfill = getopacityhex(newpolystyle.fillopac) + color_html2kml(""+newpolystyle.fill);
    gob("st4").innerHTML = newfill;
    newpolystyle.kmlfill = newfill;
    newpolystyle.fillonoff = gob("st4c").value;
    newpolystyle.lineonoff = gob("st4d").value;
    newlinestyle.name = gob("st5").value;
    newlinestyle.width = gob("st7").value;
    newlinestyle.color = gob("st7a").value;
    newlinestyle.lineopac = gob("st7b").value;
    newlinecolor = getopacityhex(newlinestyle.lineopac) + color_html2kml(""+newlinestyle.color);
    gob("st6").innerHTML = newlinecolor;
    newlinestyle.kmlcolor = newlinecolor;
    if (editingstyles == 1) {
        polygonstyles.splice(cur,1,newpolystyle); // replace an existing style object with this new style object
        polylinestyles.splice(cur,1,newlinestyle); // replace an existing style object with this new style object
        editingstyles = 0;
        gob("sty").value = "Save as new style";
        gob("edits").value = "If you want to edit, click here first";
    }else{
        polygonstyles.push(newpolystyle);
        polylinestyles.push(newlinestyle);
        cur = polygonstyles.length - 1;
    }
    gob("stylenumber").innerHTML = (cur+1)+' ';
    placemarks[plmcur].polygonstyle = newpolystyle.name;
    placemarks[plmcur].linestyle = newlinestyle.name;
    placemarks[plmcur].curstyle = cur;
    if(!markerMode) drawCoordinates();
}
function printstyles() {
//alert('printstyles');
    gob("st1").value = polygonstyles[cur].name;
    gob("st2").innerHTML = polygonstyles[cur].kmlcolor; // use innerHTML for span tag
    gob("st3").value = polygonstyles[cur].width;
    gob("st3a").value = polygonstyles[cur].color;
    gob("st3b").value = polygonstyles[cur].lineopac;
    gob("st4").innerHTML = polygonstyles[cur].kmlfill;
    gob("st4a").value = polygonstyles[cur].fill;
    gob("st4b").value = polygonstyles[cur].fillopac;
    gob("st4c").value = polygonstyles[cur].fillonoff;
    gob("st4d").value = polygonstyles[cur].lineonoff;
    gob("st5").value = polylinestyles[cur].name;
    gob("st6").innerHTML = polylinestyles[cur].kmlcolor;
    gob("st7").value = polylinestyles[cur].width;
    gob("st7a").value = polylinestyles[cur].color;
    gob("st7b").value = polylinestyles[cur].lineopac;
    gob("stylenumber").innerHTML = (cur+1)+' ';
}
function stylesforthisplacemark() {
//alert('stylesforthisplacemark');
    placemarks[plmcur].polygonstyle = polygonstyles[cur].name;
    placemarks[plmcur].linestyle = polylinestyles[cur].name;
    placemarks[plmcur].curstyle = cur;
}
function stepstyles(a) {
//alert('stepstyles');
    if (a == -1) {
        if (cur > 0) {
            cur--;
            printstyles();
            if (!markerMode) drawCoordinates();
        }
    }
    if (a == 1) {
        if (cur < polygonstyles.length - 1) {
            cur++;
            printstyles();
            if (!markerMode) drawCoordinates();
        }
    }
}
function editstyles () {
//alert('editstyles');
    editingstyles = 1;
    gob("edits").value = "Ready for edit. Press Save when done";
    gob("sty").value = "Save";
}
function closethis(name){
//alert('closethis');
    gob(name).style.visibility = 'hidden';
}
function showthis(name){
//alert('showthis');
    gob(name).style.visibility = 'visible';
}
// the copy part may not work with all web browsers
function copyTextarea(){
//alert('copyTextarea');
    coo.focus();
    coo.select();
    copiedTxt = document.selection.createRange();
    copiedTxt.execCommand("Copy");
}
function roundVal(val){
//alert('roundVal');
    if(val.toString().length < 9){
        return val;
    }else{
    	var dec = 6;
    	var result = Math.round(val*Math.pow(10,dec))/Math.pow(10,dec);
    	return result;
    }
}
function color_html2kml(color){
//alert('color_html2kml');
    var newcolor ="FFFFFF";
    if(color.length == 7) newcolor = color.substring(5,7)+color.substring(3,5)+color.substring(1,3);
    return newcolor;
}
function getopacityhex(opa){
//alert('getopacityhex');
    var hexopa = "66";
    if(opa == 0) hexopa = "00";
    if(opa == .0) hexopa = "00";
    if(opa >= .1) hexopa = "1A";
    if(opa >= .2) hexopa = "33";
    if(opa >= .3) hexopa = "4D";
    if(opa >= .4) hexopa = "66";
    if(opa >= .5) hexopa = "80";
    if(opa >= .6) hexopa = "9A";
    if(opa >= .7) hexopa = "B3";
    if(opa >= .8) hexopa = "CD";
    if(opa >= .9) hexopa = "E6";
    if(opa == 1.0) hexopa = "FF";
    if(opa == 1) hexopa = "FF";
    return hexopa;
}

    </script>


<script type="text/javascript">

function savePolygonLatLong()
{
       document.polygonForm.action="getalllatlong1.jsp";
       geoAdd();
       document.polygonForm.submit();

}

var myname;
function callfun()
{
	//alert("aleast i am here");
	var aa=document.getlatlong.owner.value;
	//var owner1=document.getElementById("owner").value;	
	alert ("i got value of owner----" +aa);
	if(!(aa=="Select"))
	{	
		document.getlatlong.submit();
	}
}
</script>

<script>
function get_radio_value(radioobject,warecode,wtype)
{
	//alert('hi');
//	alert(PolygonCoordinates);
//we are chaking dynamically values
	if(!radioobject)
		return "";
	var radiolength=radioobject.lenght;
	
	if(radiolength==undefined)
	{
		if(radioobject.checked)
		{
			myname=radioobject.value;
			document.getElementById("geo").value=myname;
			document.getElementById("geo1").value=warecode;
			document.getElementById("oldgeo").value=myname;
			document.getElementById("oldgeo1").value=warecode;
			document.getElementById("WType").value=wtype;
			document.getElementById("oldwtype").value=wtype;
			//alert(alertdocument.getElementById("PolygonCoordinates").value);
			
		}
	else{
         return false;
         }
			//alert('bbye');
	}
}

function update()
{
	//alert('in side update ');
	var loc=document.getElementById("geo").value;
	var loc1=document.getElementById("geo1").value;
	var oldloc=document.getElementById("oldgeo").value;
	var oldloc1=document.getElementById("oldgeo1").value;
	var wtype=document.getElementById("WType").value;
	var oldwtype=document.getElementById("oldwtype").value;
	
	//alert(wtype);
	if((loc==null)||(loc=="")||(loc1==null)||(loc1==""))
	{
		alert("Please select the location to be Update..!!!");	
		return 0;
	}
	document.form1.action="getGeoLocUpdate.jsp?loc="+loc+"&loc1="+loc1+"&oldloc="+oldloc+"&oldloc1="+oldloc1+"&wtype="+wtype+"&oldwtype="+oldwtype; //+"&wtype="+wtype;
	document.form1.submit();	
}
function del()
{
	//alert('del fun is called');
	
	var loc=document.getElementById("geo").value;
	var loc1=document.getElementById("geo1").value;
	var oldloc=document.getElementById("oldgeo").value;
	var oldloc1=document.getElementById("oldgeo1").value;
	if((loc==null)||(loc=="")||(loc1==null)||(loc1==""))
	{
		alert("Please select the location to be Delete..!!!");	
		return 0;
	}
	document.form1.action="getGeoLocDel.jsp?loc="+loc+"&loc1="+loc1+"&oldloc="+oldloc+"&oldloc1="+oldloc1;
	document.form1.submit();
}

function geoAdd()
{
	//alert('add fun is called');
	var lati=document.getElementById("lati").value;
	var langi=document.getElementById("langi").value;
	var warehouse=document.getElementById("add").value;
	var warehousecode=document.getElementById("addcode").value;
	var WType1=document.getElementById("WType1").value;


	var polygonCoords = document.getElementById("cordonatestoasave").value;
//alert(polygonCoords);
	//alert(var polygonCoords);
	if((lati==null)||(lati=="") || (langi==null)||(langi==""))
	{
		lati="-";
		langi="-";
		//alert("Please Single click on the map then fill the details..!!!");
	//	return 0;
	}
	if((warehouse=="")||(warehouse==null))
	{
		alert("Please enter new Geofence Location..!!!");
		return 0;
	}
	if((warehousecode=="")||(warehousecode==null))
	{
		alert("Please enter new Geofence Location Code..!!!");
		return 0;
	}
	 
	if(WType1=="Select")
	{
		alert("Please Select Location Type..!!!");
		return 0;
	}
	//document.form1.action="getGeoLocAdd.jsp?lati="+lati+"&langi="+langi+"&warehouse="+warehouse+"&warehousecode="+warehousecode+"&WType="+WType;
	document.form1.action="getGeoLocAdd.jsp?lati="+lati+"&langi="+langi+"&warehouse="+warehouse+"&warehousecode="+warehousecode+"&WType="+WType1+"&polygonCoordinates="+polygonCoords;
	document.form1.submit();
}
</script>
<!-- script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script -->
 <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAxjYame-JZRGh_FJuRBWlpBTlmEuEpA44GFjXbE_lz5qAkNbkwRTH_hHi4lHI7l-DNA8SyPlaWk0dhw" type="text/javascript"></script>
<body>

<body  onunload="GUnload()">
<!-- you can use tables or divs for the overall layout -->
<table border="1" bgcolor="white" align="center" ">
<tr>
<td colspan="2">
<table width="100%" align="center" >
			<tr>
			<td align="center">
			<font  size="3" ><b>All Geofence Locations on Map</b></font></td>
			</tr>
</table>
<%
String OwnerName = "";
fwUser = (String) session.getAttribute("user");
//System.out.println("--user---->>"+fwUser);

if (! session.isNew()) 
	OwnerName = (String) session.getAttribute("usertypevalue");
if (null == OwnerName) 
	{
		response.sendRedirect("index.jsp");
		return;
	}

//String =request.getParameter("owner");
String sql=null;
String lat="18.80",lon="80.1";
%>
</td>
</tr>
<tr>
<td width="20%" valign="top">
<table width="100%" border="1" valign="topo">
<%
if(OwnerName!=null)
{
%>
<tr><th colspan="1">All Loacations for <%=OwnerName %></th></tr>
<% }else{ %>
<tr><th colspan="1">All Loacations</th></tr>
<% }%>
</table>
           <!-- =========== side_bar with scroll bar ================= -->
 
<div id="side_bar"  style="overflow:auto; height:390px;" align="left" ></div>
           <!-- ===================================================== -->	
	
</td>
<td  valign="top">
       <div id="map" style="width: 800px; height: 400px"></div>
</td>
      </tr>  
</table>

<!--// Code for edit and  delete an update -->
<% 
if(fwUser.equalsIgnoreCase("shramik"))
{%>
<table  border="1" bgcolor="white" >
<tr><td ><div id="map" style="width: 980px; height: 6px"></div></td></tr><tr>
<td valign="top">
<table class="stats" >
<form action="addwaypoint.jsp" name="form1" method="post" >
<tr>
	<td colspan="2" class="hed">Update Or Delete Geofence Locations<br>(Select location to Update or Delete)</td>
	<td colspan="2" class="hed">Add New Geofence Location<br>(Click on map then fill the details)</td>
</tr>
<tr>
	<td >Location Name :</td>
	<td ><input type="text" name="geo" id="geo" ></td>
	<td>New Geofence Location :</td>
	<td><input type="text" name="add" id="add" ></td>
</tr>
<tr>
	<td >Location Code :</td>
	<td ><input type="text" name="geo1" id="geo1"  ><input type="hidden" name="oldgeo" id="oldgeo" ><input type="hidden" name="oldgeo1" id="oldgeo1" >
	</td>
	<td>Geofence Location Code :</td>
	<td><input type="text" name="addcode" id="addcode" ></td>
</tr>
<tr>
		<td >Location Type :</td>
		<td><select name="WType" id="WType" >
		<option value="-">-</option>
		<option value="WH">WH</option>
		<option value="Zone">Zone</option>
		<option value="BusinessUnit">BusinessUnit</option>
		<option value="Office">Office</option>
		<option value="HUB">HUB</option>
		<option value="Plant">Plant</option>
		<option value="Depot"> Depot</option>
		</select> <input type="hidden" name="oldwtype" id="oldwtype"></td>
	
	<td>Location Type </td>
	<td><select name="WType1" id="WType1">
		<option value="Select" selected="selected">Select</option>
		<option value="WH">-</option>
		<option value="WH">WH</option>
		<option value="Zone">Zone</option>
		<option value="BusinessUnit">BusinessUnit</option>
		<option value="Office">Office</option>
		<option value="HUB">HUB</option>
		<option value="Plant">Plant</option>
		<option value="Depot">Depot</option>
	</select></td>
</tr>
<tr><td><td ><input type="button" name="btn1" id="btn1" value="Update" onclick="update();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btn2" id="btn2" value="Delete" onclick="del();"></td></td><td></td><td><input type="button" name="btn3" id="btn3" value="Add Geofence Location" onclick="geoAdd();"><input type="hidden" name="lati" id="lati" class="formElement" readonly><input type="hidden" name="langi" id="langi" class="formElement" readonly>
	</td>		
</tr>
<% } //end of shramik condition%>
    <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>
    <script type="text/javascript">
    //<![CDATA[
   		if (GBrowserIsCompatible()) 
 		{
	      	var side_bar_html = "";
	 		var combo="<select name='select1' id='select1' class='bodyText'>";
	 		var combo1="</select>";
	 		var side_bar_html1 = "";
	 		var gmarkers = [];
	 	   var htmls = [];
	 	    var i = 0;
	 	    var lastvehcode=200;	
	 		var days = 0;
	 		var difference = 0;
	 		var markertoshow=[];
	 		var j = 0;
	 		var lableshow=[];
	 		var k=0;
	 		var lineshow=[];
	 		var l=0;
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

			lstner = GEvent.addListener(map, 'click', function(overlay, point){
			document.form1.lati.value=point.y;
			document.form1.langi.value=point.x;
				
			   	});
			 
		    function myclick(i,lat, lon) {
			     	//alert("in myclick");
		  		map.setCenter(new GLatLng(lat,lon));
		  		//map.setCenter(new GLatLng(18.80,80.1),5);
		  	      gmarkers[i].openInfoWindowHtml(htmls[i]);
		  	}
		 	function createMarker(point,name,html1,lat,lon) {
		 		//alert('in side create marker');
				var cIcon = new GIcon();
				cIcon.image = 'images/mm_20_green.png';
				cIcon.shadow = 'images/mm_20_shadow.png';
				cIcon.iconSize = new GSize(12,20);
				cIcon.shadowSize = new GSize(22, 20);
				cIcon.iconAnchor = new GPoint(6, 20);
				cIcon.infoWindowAnchor = new GPoint(5, 1);
				markerOptions = { icon:cIcon};
				var marker = new GMarker(point,markerOptions);
		        GEvent.addListener(marker, "click", function() { 
				map.setCenter(new GLatLng(lat,lon),9);
		        marker.openInfoWindowHtml(html1);
		        }); 
		      	//GEvent.addListener(marker, "mouseover", function() { 
				//map.setCenter(new GLatLng(lat,lon),9);
		      //  marker.openInfoWindowHtml(html1);
		       // }); 
		     	gmarkers[i] = marker;
		        htmls[i] = html1;
		       side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" title="">'+name+'</a><br>';
		    	//combo +='<option value="+i+" onClick="javascript:myclick(' + i + ','+lat+','+lon+')" >'+name+'</option>';
		    	i++;
		        return marker;
		 }
		 	function tastFun(){
<%
try
{
	//********************Veriable from getGetLocUpdate*******************//
	String flag=request.getParameter("flag");
	//System.out.println("-- flag --"+flag);
	if(flag!=null && flag.equalsIgnoreCase("true"))
    {
		%>
		alert("Record Successfully Updated.");
		<%
    }
	else if(flag!=null && flag.equalsIgnoreCase("false"))
	{	
		%>
		alert("Please do some changes in fields...!");
		<%
	}
	
	//****************variable from delete page************//
	String flag1=request.getParameter("flag1");
	//System.out.println("-- flag1 --"+flag1);
	if(flag1!=null && flag1.equalsIgnoreCase("true"))
    {
		%>
		alert("Record Successfully Deleted.");
		<%
    }
	else if(flag1!=null && flag1.equalsIgnoreCase("false"))
	{	
		%>
		alert("Please select the record to be deleted...");
		<%
	}
	
	//****************variable from delete page************//
	String flag2=request.getParameter("flag2");
	//System.out.println("-- flag2 --"+flag2);
	if(flag2!=null && flag2.equalsIgnoreCase("true"))
    {
		%>
		alert("Record is successfully Added.");
		<%
    }
	else if(flag2!=null && flag2.equalsIgnoreCase("false"))
	{	
		%>
		alert("Same record is already present.Please enter diffrent values." );
		<%
	}
	//******************//	
	String otherflag=request.getParameter("otherflag");
	if(otherflag!=null && otherflag.equalsIgnoreCase("true"))
    {
	%>
		alert("Record is already Present.");
	<%
    }
	 StringBuffer polygonSql1 = new StringBuffer();
	 String dbLatitude ="17";
	 String dbLongitude="80";
	 int index = 0;
	if(OwnerName != null)
	{
	sql="select WareHouseCode,WareHouse,Owner,Latitude,Longitude,WType,PolygonCoordinates from t_warehousedata where Owner like '"+ OwnerName +"' order by WareHouse ";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		wareHouseCode=rst.getString("WareHouseCode");
		wareHouse=rst.getString("WareHouse");
		owner=rst.getString("Owner");
		lat=rst.getString("Latitude");
		lon=rst.getString("Longitude");
		wtype=rst.getString("WType");
		PolygonCoordinates=rst.getString("PolygonCoordinates");
		//System.out.println("wareHouseCode : "+wareHouseCode +" Lat : "+lat + " Long :"+lon + " PolygonCoordinates:::"+PolygonCoordinates );
		if(PolygonCoordinates == null)
		{
		dbLatitude = lat;
		dbLongitude= lon;
		}
				
		  if(PolygonCoordinates !=null && !PolygonCoordinates.equals(""))
                   {
                 StringTokenizer tokenizer = new StringTokenizer(PolygonCoordinates,",");                        
                 int cntr=1;
                 int tokens = tokenizer.countTokens();
                 while (tokenizer.hasMoreElements()) 
                  {
                     dbLatitude = (String) tokenizer.nextElement();                                                      
	 	    		 dbLongitude= (String) tokenizer.nextElement();
	 	    		 
	 	    	//	 System.out.println("dbLatitude : "+dbLatitude);
	 	    		 
	 	    	//	 System.out.println("dbLongitude : "+dbLongitude);
	 	    		break;
              	 }  
               }
		
		html1="<b>GeoFence</b><br>wareHouse-"+wareHouse+" owner-"+owner;
%>
		side_bar_html += '<input type="radio" id="pra" name="pra" value="<%=wareHouse%>" onclick="get_radio_value(this,\'<%=wareHouseCode%>\',\'<%=wtype%>\')">';
		var point<%=index+""%>  = new GLatLng(<%=dbLatitude%>,<%=dbLongitude%>);
 		var marker<%=index+""%> = createMarker(point<%=index%>,"<%=wareHouse%>","<div class='bodyText'><%=html1%></div>",<%=dbLatitude%>,<%=dbLongitude%>);
		map.addOverlay(marker<%=index+""%>);

<%
	}  index++;
//	}}
%>
		document.getElementById("side_bar").innerHTML = side_bar_html;
<%
}//end of if
}catch(Exception ex)
{
	%> alert("Exception --><%=ex%>"); <%
}
finally
{
	//conn.close();
}
%>
 }
     //]]>
 		}//functionend  function tastFun(){
    </script>
    </form>
<!-- <form action="getalllatlong1.jsp" name="polygonForm" method="post" >
       <input type="text" name="cordonatestoasave" id="cordonatestoasave" value=""/>
      <input type="button" value="Submit Coordiantes" disabled="true" id="cordisubmit" onclick="savePolygonLatLong()"/>
</form> -->
 <input type="hidden" name="cordonatestoasave" id="cordonatestoasave" value=""/>

</table>
</body>
<% fleetview.closeConnection(); %>
			
<%@ include file="footernew.jsp" %>
</html>
