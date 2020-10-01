<%@ include file="headernew.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<script src="elabel.js" type="text/javascript"></script>

</head>
<%
try{
	Connection conn1 = null;
	Statement st = null;
	Class.forName(MM_dbConn_DRIVER);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	st=conn1.createStatement();

String sql="", name="",Category="";
String label="",phname="";
String sale="";
double lat=0.0,lon=0.0;
%>
<table border="0" width="800px" align="center" style="margin-left: 20%">

<tr align="center">
<td align="center">
<table border="0" width="100%" align="center" class="stats">
<tr align="center">
<td width="85%" align="center"><div id=map style="width: 800px; height: 470px" align="center"></div>
<input type="hidden" id="zoomlevel" name="zoomlevel" value="" />
</td>

</tr></table></td></tr></table>

<script type="text/javascript">
//<![CDATA[
           
                      
           function createMarker(point,name,html,lat,lon)
     	{
            	try{
     		var cIcon = new GIcon();
     		cIcon.image = 'images/mm_20_purple.png';
     		cIcon.shadow = 'images/mm_20_shadow.png';
     		cIcon.iconSize = new GSize(8,13);
			cIcon.shadowSize = new GSize(16, 14);
			cIcon.iconAnchor = new GPoint(6, 20);
			cIcon.infoWindowAnchor = new GPoint(5, 1);
			markerOptions = { icon:cIcon};
			var marker = new GMarker(point, markerOptions);
    		GEvent.addListener(marker, "mouseover", function() {
   			 marker.openInfoWindowHtml(html);
    		});

    		GEvent.addListener(marker, "click", function() {
        		//map.setCenter(new GLatLng(lat,lon),12);
        		marker.openInfoWindowHtml(html);
        		        });	

    		gmarkers[i] = marker;
        	htmls[i] = html;
			i++;
        	map.setCenter(new GLatLng(lat,lon));
        	return marker;
            	}
            	catch(e)
            	{
                	//alert(" marker   "+e);
            	}
     	}
        	
           
        	  // var html="<font size='3' face='Arial' color='black'><b>"+name+"<br>"+sale+"</b></font>"
        	 //  var label1= new ELabel(new GLatLng(lat,lon),html,"Utopia", new GSize(-10,10), 0);
             // map.addOverlay(label1);
          	 //alert("********** ");
           

 
               
if (GBrowserIsCompatible()) {

	try{
	var sidebarhtml="";
	var i=1;
	var j=1;
	var a=0;
	var map;
	var gmarkers = [];
	var glables = [];   
	var gLabelIcons=[];
    var htmls = [];
    var lati=[];
    var langi=[];
    var names=[];
    var sales=[];
    var k=0;
    var myzoom = 0;
    function loadmaphome(){                
    	//alert("hello...");
    		
        map = new GMap2(document.getElementById("map"));
    	map.setCenter(new GLatLng(22.2389156,76.954612),6);
    	map.addControl(new GMapTypeControl(1));
    	map.enableScrollWheelZoom();
    	map.addControl(new GSmallMapControl());
    	map.addControl(new GScaleControl());

    	//var gx = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/D3.kml");
  		//map.addOverlay(gx);
  		//var gx1 = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/D2.kml");
  		//map.addOverlay(gx1);
    	  //var gx = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/Shape_24_1.kmz");
  		// map.addOverlay(gx);

  		GEvent.addListener(map,'zoomend',function()
  				{
  					var myzoomlevel = map.getZoom();
  					document.getElementById("zoomlevel").value=myzoomlevel;
  					//alert(myzoomlevel);
  					if(myzoomlevel>=8)
  					{
  	  				 //  Getlabels();	  
  					}
  					else if(myzoomlevel<8 && j>=2)
  					{
  	  					//removelabels();
  					}
  					
  				});
     	}

        loadmaphome();
      
       
<%
          
        sql="select * from db_gps.t_cityandphoto where Category = 'City' limit 10";
		ResultSet rs=st.executeQuery(sql);
		
		while(rs.next())
		{
			lat=rs.getDouble("Latitude");
			lon=rs.getDouble("Longitude");
			name=rs.getString("Name");
			sale=rs.getString("Sales");
		//	Category=rs.getString("Category");
		//System.out.println("lat "+lat);
			//System.out.println("lon "+lon);
			//System.out.println("name "+name);
			
        
        phname="<img src='http://myfleetview.com/FleetView/images/"+sale+".JPG'></img>";
        label="<b>"+name+"<br></b>"+phname;
        %>
       var point1 = new GLatLng(<%=lat%>,<%=lon%>);
      //  var label1= new ELabel(point1,'< %=name%>',"Utopia", new GSize(0,10), -7);
		var marker = createMarker(point1,"<div class='bodyText'><%= label%></div>","<div class='bodyText' align='left'><%=label%></div>",<%=lat%>,<%=lon%>);
     map.addOverlay(marker);
   <%
     
		}
       %>

       
      

     
     
	}
	catch(e){
		//alert("^^^^^^^  load map    "+e);
	}
	
	
	}


//]]>
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
</html>
    	
		