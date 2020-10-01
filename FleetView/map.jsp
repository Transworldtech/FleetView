<%@ include file="headernew.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>

</head>
<table><tr><td align="center">
<font size="3"><B>All Vehicles on Map</B></font></td></tr></table>


<table border="0" width="800px" align="center">

<tr>
<td align="left">
		
		<% int i=1; %>
</td>
</tr>
<tr><td align="center" colspan="2">
<table border="0" width="100%" align="center" class="stats">
<tr>
<td width="85%"><div id=map style="width: 700px; height: 470px"></div></td>

<td width="15%">
<div id="sidebar" style="overflow:auto;width: 300px;height: 470px"></div>
</td>
</tr>
</table>
</td></tr>
</table>
<script type="text/javascript">
//<![CDATA[
if (GBrowserIsCompatible()) {

	try{
	var sidebarhtml="";
	var i=1;
	var map;
	var gmarkers = [];
	var glables=[];
	var gLabelIcons=[];
    var htmls = [];

    function myclick(i,lat, lon) 
	{
		map.setCenter(new GLatLng(lat,lon),17);
	    gmarkers[i].openInfoWindowHtml(htmls[i]);
	}


	

	function returnMarker(latitude,longitude,discription,vehregno,speed,datetime,location,distanceTraveledToday)
	{
		try{
		var cIcon = new GIcon();
		var currentTime = new Date();
		var day = currentTime.getDate();

		cIcon.image = 'images/t5.png';
		cIcon.iconSize = new GSize(12,20);
		
		
	/*	if(diff<=1800000 && diff>=-1800000 && speed>0)
			cIcon.image = 'images/bus1.png';
		 
		else
			cIcon.image = 'images/bus.png';

		if(stampType>0)
			cIcon.image = 'images/bus2.png';*/
		cIcon.shadow = 'images/mm_20_shadow.png';
		cIcon.iconSize = new GSize(12,13);
		cIcon.iconAnchor = new GPoint(6,11);
		cIcon.infoWindowAnchor = new GPoint(15, 1);
		markerOptions = { icon:cIcon};
		var point = new GLatLng(latitude,longitude);
		var marker = new GMarker(point, markerOptions);
		var html="<font size='1' face='Arial'><br><b>Vehicle No.: </b>"+vehregno+"<br><b>Speed: </b>"+speed+" (KM/Hr)<br><b>DateTime: </b>"+datetime+"<br><b>Distance Traveled today :</b>"+distanceTraveledToday+"<br><b>Location: </b>"+location+"</font>"
		GEvent.addListener(marker, "mouseover", function() {
	    marker.openInfoWindowHtml(html);
	    });
	    if(gmarkers[discription])
	    {
	       map.removeOverlay(gmarkers[discription]);
	    }
		gmarkers[discription] = marker;
		htmls[discription] = html;
		map.addOverlay(marker);
		}
		catch(e){
		//	alert(e);
		}

	}

	
	function GetUpdates1()
	{
		var ajaxRequest;  // The variable that makes Ajax possible!
		//alert("get updates ");
		try{
				ajaxRequest = new XMLHttpRequest();
		    }  
	        catch (e)
	        {
			    try{
				   		ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			        } 
	                catch (e)
	                {
				   		try{
				       			ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				   			} 
	                        catch (e)
	                        {
				      			alert("Your browser broke!");
				      			return false;
				   			}
			        }
	          }
	          ajaxRequest.onreadystatechange = function()
	          {
	    	  		if(ajaxRequest.readyState == 4)
	                {
		                try{
	                	var reslt=ajaxRequest.responseText;
	                    var resnew=reslt.split("@");
	                    document.getElementById("sidebar").innerHTML=resnew[0];
	               	 	var markerslist=resnew[1].split("$");
	               	 //	alert(resnew[0]);

						for(x=0;x<resnew[2]-1;x++)
	               	 	{
	                   	 var marval=markerslist[x].split(",");
	                   	 returnMarker(marval[0],marval[1],marval[2],marval[3],marval[4],marval[5],marval[6],marval[7]);
	               	 	}
		                }
		                catch(e)
		                {
			               // alert(e);
		                }
	                }
	         	}

	        //   queryStringg = "?division="+division1+"&ward="+ward1+"&VehicleregNo="+vehicle1+"&status="+status1;
		    ajaxRequest.open("GET", "mapUpdate.jsp", true);
	      ajaxRequest.send(null); 
	}
	
	 function setToRed ( )
		{
			GetUpdates1();
		/*	if(map.getZoom()>16)
			{
				GetLables();		
			}
			else{

					for(x=1;x<glables.length;x++)
					{
						map.removeOverlay(glables[x]);
						map.removeOverlay(gLabelIcons[x]);
					}
				}*/
			
			
		  //	setTimeout ( "setToRed()", 2000 );

		}
    
    function loadmaphome(){
	//	alert("hello...");
		
    map = new GMap2(document.getElementById("map"));
	map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());

	setToRed ();
		
 	}
    
    loadmaphome();
 

	
}
catch(e){
	alert(e);
}
}
//]]>
</script>
<!--<body onLoad="javascript:loadmaphome();">-->

<!--</body>-->
</html>