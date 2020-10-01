<%@ include file="headernew.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<script src="elabel.js" type="text/javascript"></script>

</head>

<body>
<%
try{
	Connection conn1 = null;
	Statement st = null;
	Class.forName(MM_dbConn_DRIVER);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	st=conn1.createStatement();

String sql="", name="",Category="";
String label="";
String Boston ="-",MDO = "-",Total = "0",Cotton = "0",Cottonper="0";
double lat=0.0,lon=0.0;
%>
<form name="Eichermap">
<div align="center">
<br></br>
<table style="width: 80%;text-align: center;" border="0">
<tr>
<td valign="top">
<div align="left">
<input type="checkbox" name="extAll" id="extAll" value="yes"  onclick="allSelected();"></input><font size="2" face="Arial" color="black">Indore Way Point </font>
</div>
<div align="left">
<input type="checkbox" name="photo" id="photo" value="yes"  onclick="allSelected1();"></input><font size="2" face="Arial" color="black">Photos</font>
</div>
<div align="left">
<input type="checkbox" name="LCB" id="LCB" value="yes"  onclick="allSelected2(1);"></input><font size="2" face="Arial" color="black">Route No 1 LCB</font>
</div>
<div align="left">
<input type="checkbox" name="A" id="A" value="yes"  onclick="allSelected2(2);"></input><font size="2" face="Arial" color="black">Route No 1 A</font>
</div>
<div align="left">
<input type="checkbox" name="HCB" id="HCB" value="yes"  onclick="allSelected2(3);"></input><font size="2" face="Arial" color="black">Route No 3 HCB</font>
</div>
</td>
<td align="center">
<table  class="stats"  style="width: 800px;text-align: center;" border="0">
<tr align="center">
<td width="85%" align="center"><div id="map1" style="width: 800px; height: 470px" align="center"></div>
<input type="hidden" id="zoomlevel" name="zoomlevel" value="" />
</td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</form>
<script type="text/javascript">

function allSelected()
{
	if(document.Eichermap.extAll.checked) 
	{
		
 		  map1.addOverlay(gkml[1]);
	}
	else
	{
		 map1.removeOverlay(gkml[1]);
	}
}

function allSelected2(num)
{
	if(num == 1)
	{
		if(document.Eichermap.LCB.checked) 
	{
		
 		  map1.removeOverlay(gkml[0]);
 		 map1.addOverlay(gkml[6]);
 		map1.addOverlay(gkml[7]);
	}
	else
	{
		 map1.removeOverlay(gkml[6]);
		map1.removeOverlay(gkml[7]);
		if(document.Eichermap.A.checked == false && document.Eichermap.HCB.checked == false)
		{
				map1.addOverlay(gkml[0]);
		}
	}
	}
	else
		if(num == 2)
		{
			if(document.Eichermap.A.checked) 
			{
				map1.removeOverlay(gkml[0]);
		 		 map1.addOverlay(gkml[4]);
		 		map1.addOverlay(gkml[5]);
			}
			else
			{
				
				 map1.removeOverlay(gkml[4]);
					map1.removeOverlay(gkml[5]);
					if(document.Eichermap.LCB.checked == false && document.Eichermap.HCB.checked == false)
					{
						map1.addOverlay(gkml[0]);
					}
			}
		}
		else
			if(num == 3)
			{
				if(document.Eichermap.HCB.checked) 
				{
					map1.removeOverlay(gkml[0]);
			 		 map1.addOverlay(gkml[2]);
			 		map1.addOverlay(gkml[3]);
				}
				else
				{
					map1.removeOverlay(gkml[2]);
					map1.removeOverlay(gkml[3]);
					if(document.Eichermap.A.checked == false && document.Eichermap.LCB.checked == false)
					{
						map1.addOverlay(gkml[0]);
					}
				}
			}
}

function allSelected1()
{
	if(document.Eichermap.photo.checked) 
	{
		//alert(gmarkers.length);
		for(i = 0;i<=gmarkers.length;i++)
		{
 		  map1.addOverlay(gmarkers[i]);
		}
	}
	else
	{
		for(i = 0;i<=gmarkers.length;i++)
		{
 		  map1.removeOverlay(gmarkers[i]);
		}
	}
}

function createMarker(point,html,lat,lon)
{
	try{
		//alert(html);
 		var cIcon = new GIcon();
 		cIcon.image = 'images/mm_20_red.png';
 		cIcon.shadow = 'images/mm_20_shadow.png';
 		cIcon.iconSize = new GSize(8,13);
		cIcon.shadowSize = new GSize(16, 14);
		cIcon.iconAnchor = new GPoint(6, 20);
		cIcon.infoWindowAnchor = new GPoint(5, 1);
		markerOptions = { icon:cIcon};
		var marker = new GMarker(point, markerOptions);
		GEvent.addListener(marker, "mouseover", function() {
			try
			{
  			 marker.openInfoWindowHtml(html);
			}
			catch(e)
			{
				alert(e);
			}
   		});

   		GEvent.addListener(marker, "click", function() {
       		//map.setCenter(new GLatLng(lat,lon),12);
       		marker.openInfoWindowHtml(html);
       		        });	

    	return marker;
	}
	catch(e)
	{
    	//alert(" marker   "+e);
	}
}

if (GBrowserIsCompatible()) {

	try{
	var sidebarhtml="";
	var i=1;
	var j=1;
	var a=0;
	var map1;
	var gmarkers = [];
	var glables = [];   
	var gLabelIcons=[];
    var htmls = [];
    var lati=[];
    var langi=[];
    var names=[];
    var sales=[];
    var gkml=[];
    var k=1;
    var myzoom = 0;
    function loadmaphome(){                
    	//alert("hello...");
    		
        map1 = new GMap2(document.getElementById("map1"));
        map1.setCenter(new GLatLng(22.6777088,75.8496561),11);
    	map1.addControl(new GMapTypeControl(1));
    	map1.enableScrollWheelZoom();
    	map1.addControl(new GSmallMapControl());
    	map1.addControl(new GScaleControl());

    	 gkml[0] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/Indorefullroad.kmz");
    	 gkml[1]=new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/IndoreWayPoints.kmz");
    	 gkml[2]=new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/RouteNo3HCB.kml");
    	 gkml[3]=new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/RouteNo3HCBWP.kml");
    	 gkml[4]=new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/RouteNo1A.kml");
    	 gkml[5]=new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/RouteNo1AWP.kml");
    	 gkml[6]=new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/RouteNo1LCB.kml");
    	 gkml[7]=new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/RouteNo1LCBWP.kml");
    	
  		  map1.addOverlay(gkml[0]);
  	
    	    }
    loadmaphome();
   
<%

     sql = "select * from db_gps.t_eicherphotos";
    ResultSet rs = st.executeQuery(sql);
    while(rs.next())
    {
    	lat = rs.getDouble("Latitude");
    	lon = rs.getDouble("Longitude");
    	name = rs.getString("Photos");
    	
   
    label = "<div class='bodyText'><img src='http://myfleetview.com/FleetView/EicherIndoreJRMPhotos/"+name+"'></img></div>";
    %>
    var point =  new GLatLng(<%=lat%>,<%=lon%>);
    gmarkers[a] = createMarker(point,"<%=label%>",<%=lat%>,<%=lon%>);
    a++;

    <%
    }
    %>
	}

	catch(e){
		alert("^^^^^^^  load map    "+e);
	}
	}
</script>
<%
st.close();
conn1.close();
}
catch(Exception e)
{
	e.printStackTrace();
	//System.out.println("Exception---------->"+e);
}


%>
</body>
</html>
    	
		