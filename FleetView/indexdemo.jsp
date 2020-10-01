<%@ include file="header.jsp" %>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxTTqMIRQ21fn-o-nkKg4U0LEGP8lhRIBOAyyGRyRnBcijckOQcuKa_Eqw" type="text/javascript"></script>

<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

<script src="elabel.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="common/genomics.css" rel="StyleSheet" type="text/css">
<style type="text/css">

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {color: #FFFFFF}
</style>



<script language="javaScript">
function ajaxFunction()
{
var ajaxRequest;  // The variable that makes Ajax possible!
	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
        catch (e)
        {
	        // Internet Explorer Browsers
	        try
                {
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
	        } 
                catch (e)
                {
			try
                        {
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
                        catch (e)
                        {
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
	        }
        }
	
// Create a function that will receive data sent from the server
ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
                {
                	var reslt=ajaxRequest.responseText;
			
			var result=reslt.split("$");
			for(j=0;j<=result.length;j++)
			{
			var result1=result[j];
			var result2=result1.split("#*");
			createMarker(result2[0],result2[1],result2[2],result2[3],result2[4],result2[5]);
			}
		}
	}

ajaxRequest.open("POST", "ajaxindexdemo.jsp", true);
ajaxRequest.send(null); 
}

function showDepots()
{
for(b=0;b<gmarkers1.lenght;b++)
{
alert("hi");
var mar1=gmarkers1[b];
map.removeOverlay(mar1); 
}
var ajaxRequest;  // The variable that makes Ajax possible!
	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
        catch (e)
        {
	        // Internet Explorer Browsers
	        try
                {
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
	        } 
                catch (e)
                {
			try
                        {
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
                        catch (e)
                        {
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
	        }
        }
	
// Create a function that will receive data sent from the server
ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
                {
                	var res1=ajaxRequest.responseText;
			var res2=res1.split("$");
			for(l=0;l<=res2.length;l++)
			{
			var res3=res2[l];
			var res4=res3.split("#*");
			createMarker1(res4[1],res4[0],res4[2]);
			}
			
		}
	}

ajaxRequest.open("POST", "showdepots.jsp", true);
ajaxRequest.send(null); 
}



function DrawRoute()
{
var ajaxRequest;  // The variable that makes Ajax possible!
	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
        catch (e)
        {
	        // Internet Explorer Browsers
	        try
                {
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
	        } 
                catch (e)
                {
			try
                        {
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
                        catch (e)
                        {
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
	        }
        }
	
// Create a function that will receive data sent from the server
ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
                {
                var res=ajaxRequest.responseText;
		var res1=res.split("$");
		for(l=0;l<=res1.length;l++)
			{
				var res2=res1[l];
				var res3=res2.split("#*");
				route(res3[0],res3[1],res3[2],res3[3],"cccc00");
			}	
			
		}
	}

ajaxRequest.open("POST", "drawroute.jsp", true);
ajaxRequest.send(null); 
}

function castrolDrawRoute(id)
{
var rid=id;
var ajaxRequest;  // The variable that makes Ajax possible!
	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
        catch (e)
        {
	        // Internet Explorer Browsers
	        try
                {
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
	        } 
                catch (e)
                {
			try
                        {
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
                        catch (e)
                        {
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
	        }
        }
	
// Create a function that will receive data sent from the server
ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
                {
                var res=ajaxRequest.responseText;
		var res1=res.split("$");
		for(l=0;l<=res1.length;l++)
			{
				var res2=res1[l];
				var res3=res2.split("#*");
				route(res3[0],res3[1],res3[2],res3[3],res3[4]);
			
			}	
			
		}
	}

ajaxRequest.open("POST", "castrolroute.jsp?rid="+id, true);
ajaxRequest.send(null); 
}

</script>  
<table border="1" bgcolor="white">
<form name="historyfrom" action="MainformMap2.jsp" method="get">
<input type="hidden" name="fromtime1" value="00">
<input type="hidden" name="fromtime2" value="00">
<input type="hidden" name="totime1" value="23">
<input type="hidden" name="totime2" value="59">
<input type="hidden" name="calender" value="2008-06-01">
<input type="hidden" name="calender1" value="2008-06-01">
<input type="hidden" name="mode" value="history">
<tr>	

<td colspan="1">
       <input type="button" name="Click" value="Refresh The Marker" onClick="javascript:refreshmarker();">
        </td>
<td colspan="1">

<% 
if(session.getAttribute("usertypevalue").toString().equals("IArmy"))
{
%>
<input type="checkbox" onclick="javascript:DrawRoute();">Draw Route
<%
}
%>
<input type="checkbox" onclick="javascript:chk();">Show/Hide Vehicles
<input type="checkbox" onclick="javascript:chk1();">Show/Hide Depots
<% if(session.getAttribute("usertypevalue").toString().equals("Castrol"))
{
%>
<input type="checkbox" onclick="javascript:castrolDrawRoute('5');">Draw Castrol Route
      <%
}
%> 
</td>
      </tr>
 <tr>	
<td width="15%">
<div id="side_bar"  style="overflow:auto;height:550px;" align="left" ></div>
</td>
<td>
       <div id="map" style="width: 850px; height: 550px"></div>
        </td>
      </tr>
</form>

<tr ><td bgcolor="white" class="copyright" colspan="2">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
      
</table>
    



    <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>


    <script type="text/javascript">
    //<![CDATA[
	var side_bar_html = "";
	var gmarkers = [];
	var htmls = [];
	var gmarkers1 = [];
	var htmls1 = [];
	var x = 0;
	var i = 0;
	lableshow=[];
        var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));
	map.addControl(new GLargeMapControl());
	map.addControl(new GScaleControl(250));
	new GKeyboardHandler(map);
	map.enableContinuousZoom();
	map.enableDoubleClickZoom();
	ajaxFunction();
	showDepots();
function createMarker(lat,lon,name,reg,dt,vehcode) {
	var point = new GLatLng(lat,lon);
	var cIcon = new GIcon();
	Christmas=new Date(dt);
	today = new Date();
	difference =  today - Christmas ;
	days = Math.round(difference/(1000*60*60*24));
	if(days >=7)
	{
	name="<div class='bodyText'><font color='red'>Device Disconnected</font></div>"+name;
	cIcon.image = 'images/t6.png';
	}
	else
	{
	cIcon.image = 'images/t5.png';
	}
	//cIcon.image = 'images/t5.png';
	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize(12,20);
	cIcon.shadowSize = new GSize(22, 20);
	cIcon.iconAnchor = new GPoint(6,11);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
	var marker = new GMarker(point, markerOptions);
	GEvent.addListener(marker, "mouseover", function() {
	marker.openInfoWindowHtml(name);
        });
	GEvent.addListener(marker, "click", function() {
	map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(name);
        });
	gmarkers[i] = marker;
        htmls[i] = name;
        side_bar_html +='<input type="radio" name="rvehid" value="+vehcode+" /><a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" onMouseOver="javascript:myclick(' + i + ','+lat+','+lon+')">' + reg + '</a><br>';
        map.addOverlay(marker);
	i++;
	document.getElementById("side_bar").innerHTML = side_bar_html;
	}
	function myclick(i,lat, lon) {
	map.setCenter(new GLatLng(lat,lon));
        gmarkers[i].openInfoWindowHtml(htmls[i]);
      }
function createMarker1(lat,lon,name) {
	var point1 = new GLatLng(lat,lon);
	var cIcon = new GIcon();
	cIcon.image = 'images/sym_20950.png';
	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize(12,20);
	cIcon.shadowSize = new GSize(22, 20);
	cIcon.iconAnchor = new GPoint(6,11);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
	var marker = new GMarker(point1, markerOptions);
	GEvent.addListener(marker, "mouseover", function() {
	marker.openInfoWindowHtml("<b>"+name+"</b>");
	});
	var label=new ELabel(point1,name,"elabelstyle", new GSize(5,20), 80);
	lableshow[x]=label;
	gmarkers1[x] = marker;
        htmls1[x] = name;
	x++;
	map.addOverlay(marker);
	map.addOverlay(label);
}

function chk()
{
      for (var k = 0; k < gmarkers.length; k++) {
        var marker = gmarkers[k];
        if (marker.isHidden()) {
          marker.show();
        } else {
          marker.hide();
        }
      } 
    }
function chk1()
{
      for (var y = 0; y < gmarkers1.length; y++) {
        var marker = gmarkers1[y];
	var marker1=lableshow[y];
        if (marker.isHidden()) {
          marker.show();
	  marker1.show();
        } else {
          marker.hide();
	  marker1.hide();	
        }
      } 

 }
function route(lat,lon,lat1,lon1,colorcode)
{

var polyline = new GPolyline([new GLatLng(lat,lon),new GLatLng(lat1,lon1)], "#"+colorcode,  6);
map.addOverlay(polyline);
}

function refreshmarker(){
var ajaxRequest;  // The variable that makes Ajax possible!
	try
	{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
        catch (e)
        {
	        // Internet Explorer Browsers
	        try
                {
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
	        } 
                catch (e)
                {
			try
                        {
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
                        catch (e)
                        {
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
	        }
        }
	
// Create a function that will receive data sent from the server
ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
                {
                	var reslt=ajaxRequest.responseText;
			
			var result=reslt.split("$");
			for(j=0;j<=result.length;j++)
			{
			
			var result1=result[j];
			var result2=result1.split("#*");
			var marker=gmarkers[j];
			var point = new GLatLng(result2[0],result2[1]);
			Christmas=new Date(result2[4]);
			var today = new Date();
			var difference =  today - Christmas ;
			var days = Math.round(difference/(1000*60*60*24));
			if(days >=7)
			{
			var name="<div class='bodyText'><font color='red'>Device Disconnected</font></div>"+result2[2];
				}
			else
			{
			name=result2[2];
			}
			htmls[j]=name;
			marker.setPoint(point)  
			gmarkers[j]=marker;
			}
		}
	}

ajaxRequest.open("POST", "ajaxindexdemo.jsp", true);
ajaxRequest.send(null); 
}

     //]]>
    </script>

</body>
</html>
