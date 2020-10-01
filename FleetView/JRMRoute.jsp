<%@ include file="headernew.jsp" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>OpenLayers MapGuide Layer Example</title>
    <link rel="stylesheet" href="../theme/default/style.css" type="text/css">
    <link rel="stylesheet" href="style.css" type="text/css">

    <style type="text/css">
        #map {
            width: 100%;
            height: 800px;
            border: 1px solid black;
            float:left;
        }
        #map2 {
            width: 400px;
            height: 400px;
            border: 1px solid black;
            float:left;
        }
    </style>
  <script src="OpenLayers-2.10/OpenLayers.js"></script>
    

<script src="elabel.js" type="text/javascript"></script>
  
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
    </head>
    
    
    <body>
    <%!
    Connection conn = null;
	Statement st1,st4,st2 = null;
	ResultSet rst1 = null;
	String smap="",smap1="";
	%>
	<%
	try {
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st4 = conn.createStatement();
		  } 
	catch (Exception e) 
	{
		System.out.println("*********    "+e);
	}
	%>
    <form name="addgrpform" method="get" action="">

<center><font color="maroon" size=3> JRM Route Name: </font> <!--  <select name="owner" id="owner" style="" onChange="GetUpdates1()">-->
<select name="owner" id="owner" style="" onChange="routedetails()">
	<option value="Select">Select</option>
	<option value="ALL">ALL</option>
	<%
		String sql33 = "SELECT distinct(routename) FROM t_jrmroutemaster ";
		
		rst1 = st1.executeQuery(sql33);
		while (rst1.next()) 
		{
	%>
	<option value="<%=rst1.getString("routename")%>"><%=rst1.getString("routename")%></option>
	<%
		}
	%>
 </select></center>
 <br>
<input type="hidden" name="myval" id="myval"></input>
<center>
<table border=0 style="text-align: center;">
	<tr>

<!--		<td valign="top">-->
<!---->
<!--		<div align="left">-->
<!--		<div id="side_bar" style="overflow: auto; width: 350px; height: 500px"></div>-->
<!--		</div>-->
<!---->
<!--		</td>-->

		<td valign="top" align="center">
		<table border="0" align="center">
		<tr align="center">
		<td align="center">
		<div style="text-align: center;">
		<div id=map style="width: 950px; height: 500px;position:relative"></div>
		<div align="right"><font face="Arial" color="black">Copyright &copy; Transworld 2012.All rights reserved</font></div>
		</div>
		</td>
		</tr>
		</table>
		</td>


	</tr>

</table>
</center>
</form>
<noscript><b>JavaScript must be enabled in order for you to use Transworld Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Transworld Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>
<script>
//<![CDATA[        
try
{

	function returnMarker(lat,lon,cnt,name1,waypt)
	{
		  var Image;
		  var size = new OpenLayers.Size(25,25);
			var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
		  if((name1=="Road") || (name1==" Road"))
		  	Image = 'JRMImages/Green.jpg';
		  else if((name1=="Bus Stop")||(name1==" Bus Stop"))
		  	Image = 'JRMImages/Bus1.JPG';
		  else if((name1=="Petrol Pump") || (name1==" Petrol Pump") || (name1=="Petrol"))
		  	Image = 'JRMImages/petrolpump.JPG';
		  else if((name1=="Parking")|| (name1==" Parking"))
		  	Image = 'JRMImages/Red.jpg';
		  else if((name1=="Bridge")|| (name1=="Bridge "))
		  	Image = 'JRMImages/Tops.jpg';
		  else if((name1=="Bank")|| (name1==" Bank"))
		  	Image = 'JRMImages/bank.JPG';
		  else if((name1=="Hospital")|| (name1==" Hospital"))
		  	Image = 'JRMImages/hospital.JPG';
		  
		  else if((name1=="Hotel") || (name1==" Hotel"))
		  	Image = 'JRMImages/Hotel.JPG';
		  
		  else if((name1=="Market") ||(name1==" Market"))
		  	Image = 'JRMImages/Mosq.JPG';
		  		
		  else if((name1=="Village") ||(name1==" Village"))
		  	Image = 'JRMImages/bank.JPG';
		  
		  else if((name1=="ATM") ||(name1==" ATM"))
		  	Image = 'JRMImages/Atm.JPG';

		  else if((name1=="Mile Stone") ||(name1==" Mile Stones"))
		  Image = 'JRMImages/Indistry.JPG';
		  

		  else if((name1=="Temple") ||(name1==" Temple"))
		  Image = 'JRMImages/temple.JPG';

		  else if((name1=="School") ||(name1==" School"))
		  Image = 'JRMImages/School.JPG';
		  else
		  	Image = 'JRMImages/untitled.JPG';

		  	
		  var cIcon= new OpenLayers.Icon(Image, size, offset);
		    var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat),cIcon);
		    mark.events.register('mousedown', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
		    		new OpenLayers.LonLat(lon,lat),
		      		new OpenLayers.Size(100,50),
		      		name1+"<br>"+waypt,
		      		true);
		    popup.closeOnMove = true; 
		      		 map1.addPopup(popup);
		          });
		    
		    markers1.addMarker(mark); 
	 
		  	    if(gmarkers[cnt])
		  	    {
		  	    	 try{
		   	  	  	markers1.removeMarker(gmarkers[cnt]);
		   	  	    }catch(ee){alert(ee);}
		  	    }
		  	    
		  		gmarkers[cnt] = mark;
		  		
		  	    htmls[cnt] = name1+"<br>"+waypt;
	}


	
function selectAll()
{
			var x=document.addgrpform.layer1.checked;
			if(x)
			{
				for (var i=0; i < document.addgrpform.layer.length; i++)
				 document.addgrpform.layer[i].checked=true;
				
				var routee=document.getElementById("owner").value;
			    
				var c_value="";
				for (var i=0; i < document.addgrpform.layer.length; i++)
				{
					if (document.addgrpform.layer[i].checked)
					   {
						c_value = c_value +"'"+ document.addgrpform.layer[i].value + "'"+",";
					   }
				}

				// The variable that makes Ajax possible!
						try{
								// Opera 8.0+, Firefox, Safari
								ajaxRequest = new XMLHttpRequest();
						    }  
					        catch (e)
					        {
							  	// Internet Explorer Browsers
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
								      			// Something went wrong
								      			alert("Your browser broke!");
								      			return false;
								   			}
							        }
					          }

					          ajaxRequest.onreadystatechange = function()
					          {
					    	  		if(ajaxRequest.readyState == 4)
					                {
					                	var reslt=ajaxRequest.responseText;

					                    var resnew=reslt.split("#");

					                    var strtlat=resnew[5];
					                    var strtlon=resnew[6];
					                    var strtlocs=resnew[7];
					                    var endlat=resnew[8];
					                    var endlon=resnew[9];
					                    var endlocs=resnew[10];
					                    var latcenter=resnew[11];
					                    var loncenter=resnew[12];
					                    var  zoom=resnew[13];

//RELOAD MAP  ***

					                    try{
						                   	 var num = map1.getNumLayers();
						                   	 for (var i = num -1; i >= 0; i--) {
						                   	        map1.removeLayer(map1.layers[i]);
						                   	        } 
												 map1.addLayer(layer1);
						                   	
					                   }catch(e){alert(e);}
					                   
										if(routee=="Castrol Northern Region")
									    	loadKML("KMLJRM/CastrolNorthernRegion1KmStreach.kml");
									     if((routee=="Delhi-Patalganga"))
									    	 loadKML("KMLJRM/Delhi-Patalganga1Zone.kml");
										if(routee=="Bhivandi-Patalganga-Banglore")
											loadKML("KMLJRM/Bhivandi-Patalganga-BangloreKmStreach.kml");
										if(routee=="Bhivandi-Patalganga-Banglore-Chennai")
											loadKML("KMLJRM/Bhivandi-Patalganga-Banglore-Chennai1Zone.kml");
		
										if(routee=="Bhivandi-Patalganga-Hydrabad")
											loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad1KmStreach.kml");
										if(routee=="Bhivandi-Patalganga-Hydrabad-Chennai")
											loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad-Chennai1Zone.kml");
										if(routee=="Chennai-Pallakad")
											loadKML("KMLJRM/Chennai-Pallakad1Zone.kml");
										if(routee=="Kolkata-Guwahati")
											loadKML("KMLJRM/Kolkata-Guwahati1KmStreach.kml");
										if(routee=="Kolkata-Kanpur-Lucknow")
											loadKML("KMLJRM/Kolkata-Kanpur-Lucknow1KmStreach.kml");
										if(routee=="Bhivandi-Dhule")
											loadKML("KMLJRM/Bhivandi-Dhule1KmStreach.kml");
										
										if(routee=="Bhivandi-Nagpur")
											loadKML("KMLJRM/Bhivandi-Nagpur1Zone.kml");
		
										if(routee=="TankerEast")
											loadKML("KMLJRM/tankerEast.kml");
		
										if(routee=="TankerWest")
											loadKML("KMLJRM/tankerWest.kml");
		
										 markers1 = new OpenLayers.Layer.Markers( "Markers");
										 map1.addLayer(markers1);

										 		var point3 = new OpenLayers.LonLat(strtlon,strtlat);
												createMarker3(point3,strtlocs);

												
												var point4 = new OpenLayers.LonLat(endlon,endlat);
												createMarker4(point4,endlocs);

												var countmarkerslistt=resnew[2];
												var markerslistt=resnew[3].split("$");

												var m=1;
												for(y=0;y<countmarkerslistt;y++)
							               	 	{
				   			                   	    var marval=markerslistt[y].split("*");
							                   		var latt=marval[0];
							                   		var lonn=marval[1];
							                   		var phnamee=marval[2];
							                   		var waypnt=marval[3];
							                   		
							                   		var point2 = new OpenLayers.LonLat(lonn,latt);
							                   		createMarker2(point2,waypnt,phnamee);
							               	 	}

												var countmarkerslistt1=resnew[0];
							                    var markerslistt1=resnew[1].split("$");
												
							                    for(z=0;z<countmarkerslistt1;z++)
							               	 	{
							                   	 var marvall1=markerslistt1[z].split("*");
							                   		var alatty1=marvall1[0];
							                   		var alonny1=marvall1[1];
							                   		var aphtnamee1=marvall1[2];
							                   		var awaypntt1=marvall1[3];
							                   		var pointtt1 = new OpenLayers.LonLat(alonny1,alatty1);
														createMarker1(pointtt1,aphtnamee1,awaypntt1);
														returnMarker(alatty1,alonny1,z,aphtnamee1,awaypntt1);
														document.getElementById("abc").innerHTML=document.getElementById("abc").innerHTML+"<br><a href='javascript:myclick1("+i+","+alatty1+","+alonny1+")'>"+awaypntt1;
							               	 	}

					   							  }
					         	}
					         	
				  
					       	var queryStringg = "?routee="+routee+"&type="+c_value;
					       	
					      	ajaxRequest.open("GET", "Ajaxjrmroute2.jsp"+queryStringg, true);
				      	 ajaxRequest.send(null);
			}
			else 
			{
				document.getElementById("abc").innerHTML="";
				for (var i=0; i < document.addgrpform.layer.length; i++)
					document.addgrpform.layer[i].checked=false;
				
				var routee=document.getElementById("owner").value;
				c_value="";
				
				if(c_value=="")
				{
					try{
							// Opera 8.0+, Firefox, Safari
							ajaxRequest = new XMLHttpRequest();
					    }  
				        catch (e)
				        {
						  	// Internet Explorer Browsers
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
				                    var resnew=reslt.split("#");

				                    var strtlat=resnew[5];
				                    var strtlon=resnew[6];
				                    var strtlocs=resnew[7];
				                    var endlat=resnew[8];
				                    var endlon=resnew[9];
				                    var endlocs=resnew[10];
				                    var latcenter=resnew[11];
				                    var loncenter=resnew[12];
				                    var  zoom=resnew[13];

				                    try{
					                   	 var num = map1.getNumLayers();
					                   	 for (var i = num -1; i >= 0; i--) {
					                   	        map1.removeLayer(map1.layers[i]);
					                   	        } 
											 map1.addLayer(layer1);
				                    
												if(routee=="Castrol Northern Region")
											    	loadKML("KMLJRM/CastrolNorthernRegion1KmStreach.kml");
											     if((routee=="Delhi-Patalganga"))
											    	 loadKML("KMLJRM/Delhi-Patalganga1Zone.kml");
												if(routee=="Bhivandi-Patalganga-Banglore")
													loadKML("KMLJRM/Bhivandi-Patalganga-BangloreKmStreach.kml");
												if(routee=="Bhivandi-Patalganga-Banglore-Chennai")
													loadKML("KMLJRM/Bhivandi-Patalganga-Banglore-Chennai1Zone.kml");
				
												if(routee=="Bhivandi-Patalganga-Hydrabad")
													loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad1KmStreach.kml");
												if(routee=="Bhivandi-Patalganga-Hydrabad-Chennai")
													loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad-Chennai1Zone.kml");
												if(routee=="Chennai-Pallakad")
													loadKML("KMLJRM/Chennai-Pallakad1Zone.kml");
												if(routee=="Kolkata-Guwahati")
													loadKML("KMLJRM/Kolkata-Guwahati1KmStreach.kml");
												if(routee=="Kolkata-Kanpur-Lucknow")
													loadKML("KMLJRM/Kolkata-Kanpur-Lucknow1KmStreach.kml");
												if(routee=="Bhivandi-Dhule")
													loadKML("KMLJRM/Bhivandi-Dhule1KmStreach.kml");
												
												if(routee=="Bhivandi-Nagpur")
													loadKML("KMLJRM/Bhivandi-Nagpur1Zone.kml");
				
												if(routee=="TankerEast")
													loadKML("KMLJRM/tankerEast.kml");
				
												if(routee=="TankerWest")
													loadKML("KMLJRM/tankerWest.kml");
			 
										markers1 = new OpenLayers.Layer.Markers( "Markers");
										 map1.addLayer(markers1);
									
											var point3 = new OpenLayers.LonLat(strtlon,strtlat);
											createMarker3(point3,strtlocs);
											
											var point4 = new OpenLayers.LonLat(endlon,endlat);
											createMarker4(point4,endlocs);

											var countmarkerslistt=resnew[2];
											var markerslistt=resnew[3].split("$");
											for(y=0;y<countmarkerslistt;y++)
						               	 	{
							                   	var marval=markerslistt[y].split("*");
						                   		var latt=marval[0];
						                   		var lonn=marval[1];
						                   		var phnamee=marval[2];
						                   		var waypnt=marval[3];
						                   		var point2 = new OpenLayers.LonLat(lonn,latt);
						                   		createMarker2(point2,waypnt,phnamee);
						               	 	}

											var countmarkerslistt1=resnew[0];
						                    var markerslistt1=resnew[1].split("$");
											
						                    for(z=0;z<countmarkerslistt1;z++)
						               	 	{
						                   	 	var marvall1=markerslistt1[z].split("*");
						                   		var alatty1=marvall1[0];
						                   		var alonny1=marvall1[1];
						                   		var aphtnamee1=marvall1[2];
						                   		var awaypntt1=marvall1[3];
						                   		var pointtt1 = new OpenLayers.LonLat(alonny1,alatty1);
												createMarker1(pointtt1,aphtnamee1,awaypntt1);
												map.addOverlay(markerphyhh1);
						               	 	}
		   							  }
		   							  catch(e)
		   							  {
			   							  alert(e);
		   							  }
				         	}
				               c_value="blank";
				       	var queryStringg = "?routee="+routee+"&type="+c_value;
				       	
				      	ajaxRequest.open("GET", "Ajaxjrmroute2.jsp"+queryStringg, true);
				  	 ajaxRequest.send(null);
				 }
			}

}	
}
function createMarker1(point,name1,typename) 
	{

var Image;
var size = new OpenLayers.Size(25,25);
var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
		var type=typename;

		if((name1=="Road") || (name1==" Road"))
			Image='JRMImages/Green.jpg';
		
		else if((name1=="Bus Stop")||(name1==" Bus Stop"))
			Image='JRMImages/Bus1.JPG';
		
		else if((name1=="Petrol Pump") || (name1==" Petrol Pump") || (name1=="Petrol"))
			Image='JRMImages/petrolpump.JPG';
		
		else if((name1=="Parking")|| (name1==" Parking"))
			Image='JRMImages/Red.jpg';
		
		else if((name1=="Bridge")|| (name1=="Bridge "))
			Image='JRMImages/Tops.jpg';
		
		else if((name1=="Bank")|| (name1==" Bank"))
			Image='JRMImages/bank.JPG';
		
		else if((name1=="Hospital")|| (name1==" Hospital"))
			Image='JRMImages/hospital.JPG';

		else if((name1=="Hotel") || (name1==" Hotel"))
			Image='JRMImages/Hotel.JPG';
		

		else if((name1=="Market") ||(name1==" Market"))
			Image='JRMImages/Mosq.JPG';
				
		else if((name1=="Village") ||(name1==" Village"))
			Image='JRMImages/bank.JPG';
		
		else if((name1=="ATM") ||(name1==" ATM"))
			Image='JRMImages/Atm.JPG';
		

		else if((name1=="Company") ||(name1==" Company"))
			Image='JRMImages/Indistry.JPG';
		
		else
			Image='JRMImages/untitled.JPG';


	var cIcon= new OpenLayers.Icon(Image,size, offset);
	
    var mark = new OpenLayers.Marker(point,cIcon);
    mark.events.register('mousedown', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
      		point,
      		new OpenLayers.Size(100,50),
      		name1+"  "+typename,
      		true);
    popup.closeOnMove = true; 
      		 map1.addPopup(popup);
          });

    markers1.addMarker(mark);
    
  }

function createMarker2(point,typename,phname) 
{
	var size = new OpenLayers.Size(25,25);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
    var cIcon= new OpenLayers.Icon('JRMImages/Cinema.JPG', size, offset);
    var mark = new OpenLayers.Marker(point,cIcon);
    mark.events.register('mousedown', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
      		point,
      		new OpenLayers.Size(320,270),
      		"<br><b>"+typename+"</b><br>"+"<br>"+phname,
      		true);
    popup.closeOnMove = true; 
      		 map1.addPopup(popup);
          });
    
    markers1.addMarker(mark); 

  }

function createMarker3(pointst,rname) 
{
try
{
	var size = new OpenLayers.Size(25,25);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
	//var poi=new OpenLayers.LonLat(lo,la);
	var cIcon= new OpenLayers.Icon('images/green-dot.png',size, offset);
    var mark = new OpenLayers.Marker(pointst,cIcon);
    mark.events.register('mousedown', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
    		pointst,
      		new OpenLayers.Size(75,50),
      		rname,
      		true);
    popup.closeOnMove = true; 
      		 map1.addPopup(popup);
          });
    
    markers1.addMarker(mark); 

}
catch(e)
{
	alert(e);
}
    
  }

function createMarker4(pointst1,rname1) 
{
	var size = new OpenLayers.Size(25,25);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
    var cIcon= new OpenLayers.Icon('images/red-dot.png',size, offset);
    var mark = new OpenLayers.Marker(pointst1,cIcon);
    mark.events.register('mousedown', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
    		pointst1,
      		new OpenLayers.Size(75,50),
      		rname1,
      		true);
    popup.closeOnMove = true; 
      		 map1.addPopup(popup);
          });
    markers1.addMarker(mark); 

  }

function returnMarker1(lat,lon,cnt,name1,waypt)
{
	var size = new OpenLayers.Size(25,25);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
    var cIcon= new OpenLayers.Icon('JRMImages/Cinema.JPG', size, offset);
    var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat),cIcon);
    mark.events.register('mousedown', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
    		new OpenLayers.LonLat(lon,lat),
      		new OpenLayers.Size(320,270),
      		"<br><b>"+name1+"</b><br><br>"+waypt,
      		true);
    popup.closeOnMove = true;  
      		 map1.addPopup(popup);
          });
    
    markers1.addMarker(mark); 
	 
  	    if(gmarkers[cnt])
  	    {
  	  	    try{
  	  	  	   // alert("remove marker");
  	  	  	markers1.removeMarker(gmarkers[cnt]);
  	  	    }catch(ee){alert(ee);}
  	    }
  	    
  		gmarkers[cnt] = mark;
  	    htmls[cnt] = name1+"<br>"+waypt;
			
}

function layersend()
{
	try{
				 
					var routee=document.getElementById("owner").value;
			
					var c_value="";
					for (var i=0; i < document.addgrpform.layer.length; i++)
					{
					
					if (document.addgrpform.layer[i].checked)
					   {
						c_value = c_value +"'"+ document.addgrpform.layer[i].value + "'"+",";
						  // alert(c_value);
					   }
					
					}
			
					 
					
			
		if(c_value=="")
		{
			    document.getElementById("abc").innerHTML="";
				  // The variable that makes Ajax possible!
				try{
						// Opera 8.0+, Firefox, Safari
						ajaxRequest = new XMLHttpRequest();
				    }  
			        catch (e)
			        {
					  	// Internet Explorer Browsers
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

                    var resnew=reslt.split("#");
                    var strtlat=resnew[5];
                    var strtlon=resnew[6];
                    var strtlocs=resnew[7];
                    var endlat=resnew[8];
                    var endlon=resnew[9];
                    var endlocs=resnew[10];
                    var latcenter=resnew[11];
                    var loncenter=resnew[12];
                    var  zoom=resnew[13];

//  RESER MAP *****
                    try{
	                   	 var num = map1.getNumLayers();
	                   	 for (var i = num -1; i >= 0; i--) {
	                   	        map1.removeLayer(map1.layers[i]);
	                   	        } 

	                   	map1.addLayer(layer1);
	                   	
                  }catch(e){alert(e);}

			
              	if(routee=="Castrol Northern Region")
			    	loadKML("KMLJRM/CastrolNorthernRegion1KmStreach.kml");
			     if((routee=="Delhi-Patalganga"))
			    	 loadKML("KMLJRM/Delhi-Patalganga1Zone.kml");
				if(routee=="Bhivandi-Patalganga-Banglore")
					loadKML("KMLJRM/Bhivandi-Patalganga-BangloreKmStreach.kml");
				if(routee=="Bhivandi-Patalganga-Banglore-Chennai")
					loadKML("KMLJRM/Bhivandi-Patalganga-Banglore-Chennai1Zone.kml");

				if(routee=="Bhivandi-Patalganga-Hydrabad")
					loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad1KmStreach.kml");
				if(routee=="Bhivandi-Patalganga-Hydrabad-Chennai")
					loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad-Chennai1Zone.kml");
				if(routee=="Chennai-Pallakad")
					loadKML("KMLJRM/Chennai-Pallakad1Zone.kml");
				if(routee=="Kolkata-Guwahati")
					loadKML("KMLJRM/Kolkata-Guwahati1KmStreach.kml");
				if(routee=="Kolkata-Kanpur-Lucknow")
					loadKML("KMLJRM/Kolkata-Kanpur-Lucknow1KmStreach.kml");
				if(routee=="Bhivandi-Dhule")
					loadKML("KMLJRM/Bhivandi-Dhule1KmStreach.kml");
				
				if(routee=="Bhivandi-Nagpur")
					loadKML("KMLJRM/Bhivandi-Nagpur1Zone.kml");

				if(routee=="TankerEast")
					loadKML("KMLJRM/tankerEast.kml");

				if(routee=="TankerWest")
					loadKML("KMLJRM/tankerWest.kml");

									//	 alert("  ##  **  "+strtlon+strtlat);

										 markers1 = new OpenLayers.Layer.Markers( "Markers");
										 map1.addLayer(markers1);
									  //new OpenLayers.LonLat(73.12433,19.34534)
							var point3 =new OpenLayers.LonLat(strtlon,strtlat);
							createMarker3(point3,strtlocs);
							
							var point4 = new OpenLayers.LonLat(endlon,endlat);
							createMarker4(point4,endlocs);

							var countmarkerslistt=resnew[2];
							var markerslistt=resnew[3].split("$");

							for(y=0;y<countmarkerslistt;y++)
		               	 	{
			                   	    var marval=markerslistt[y].split("*");
		                   		var latt=marval[0];
		                   		var lonn=marval[1];
		                   		var phnamee=marval[2];
		                   		var waypnt=marval[3];
		                   		var point2 = new OpenLayers.LonLat(lonn,latt);
		                   		createMarker2(point2,waypnt,phnamee);
		               	 	}

							
							var countmarkerslistt1=resnew[0];
		                    var markerslistt1=resnew[1].split("$");
							
		                    for(z=0;z<countmarkerslistt1;z++)
		               	 	{
		                   		var marvall1=markerslistt1[z].split("*");
		                   		var alatty1=marvall1[0];
		                   		var alonny1=marvall1[1];
		                   		var aphtnamee1=marvall1[2];
		                   		var awaypntt1=marvall1[3];
		                   		var pointtt1 = new OpenLayers.LonLat(alonny1,alatty1);
								createMarker1(pointtt1,aphtnamee1,awaypntt1);
		               	 	}

                	}
                }
               	
               c_value="blank";
       	var queryStringg = "?routee="+routee+"&type="+c_value;
       	
      	ajaxRequest.open("GET", "Ajaxjrmroute2.jsp"+queryStringg, true);
  	 ajaxRequest.send(null);
         	
   }

	document.getElementById("abc").innerHTML="";
		  // The variable that makes Ajax possible!
		try{
				// Opera 8.0+, Firefox, Safari
				ajaxRequest = new XMLHttpRequest();
		    }  
	        catch (e)
	        {
			  	// Internet Explorer Browsers
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

	                    //alert(reslt);
	                    var resnew=reslt.split("#");

	                    var strtlat=resnew[5];
	                    var strtlon=resnew[6];
	                    var strtlocs=resnew[7];
	                    var endlat=resnew[8];
	                    var endlon=resnew[9];
	                    var endlocs=resnew[10];
	                    var latcenter=resnew[11];
	                    var loncenter=resnew[12];
	                    var  zoom=resnew[13];
	                    
// RESET MAP ****

	                    try{
		                   	 var num = map1.getNumLayers();
		                   	 for (var i = num -1; i >= 0; i--) {
		                   	        map1.removeLayer(map1.layers[i]);
		                   	        } 

		                   	
		                   	 
		                   	 map1.addLayer(layer1);
		                  
	                   }catch(e){alert(e);}

	               	if(routee=="Castrol Northern Region")
				    	loadKML("KMLJRM/CastrolNorthernRegion1KmStreach.kml");
				     if((routee=="Delhi-Patalganga"))
				    	 loadKML("KMLJRM/Delhi-Patalganga1Zone.kml");
					if(routee=="Bhivandi-Patalganga-Banglore")
						loadKML("KMLJRM/Bhivandi-Patalganga-BangloreKmStreach.kml");
					if(routee=="Bhivandi-Patalganga-Banglore-Chennai")
						loadKML("KMLJRM/Bhivandi-Patalganga-Banglore-Chennai1Zone.kml");

					if(routee=="Bhivandi-Patalganga-Hydrabad")
						loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad1KmStreach.kml");
					if(routee=="Bhivandi-Patalganga-Hydrabad-Chennai")
						loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad-Chennai1Zone.kml");
					if(routee=="Chennai-Pallakad")
						loadKML("KMLJRM/Chennai-Pallakad1Zone.kml");
					if(routee=="Kolkata-Guwahati")
						loadKML("KMLJRM/Kolkata-Guwahati1KmStreach.kml");
					if(routee=="Kolkata-Kanpur-Lucknow")
						loadKML("KMLJRM/Kolkata-Kanpur-Lucknow1KmStreach.kml");
					if(routee=="Bhivandi-Dhule")
						loadKML("KMLJRM/Bhivandi-Dhule1KmStreach.kml");
					
					if(routee=="Bhivandi-Nagpur")
						loadKML("KMLJRM/Bhivandi-Nagpur1Zone.kml");

					if(routee=="TankerEast")
						loadKML("KMLJRM/tankerEast.kml");

					if(routee=="TankerWest")
						loadKML("KMLJRM/tankerWest.kml");

										 markers1 = new OpenLayers.Layer.Markers( "Markers");
									 	 map1.addLayer(markers1);
								 var point3 = new OpenLayers.LonLat(strtlon,strtlat);
								 createMarker3(point3,strtlocs);

								
								var point4 = new OpenLayers.LonLat(endlon,endlat);
								createMarker4(point4,endlocs);
								

								var countmarkerslistt=resnew[2];
								var markerslistt=resnew[3].split("$");
								var t=0;
								for(y=0;y<countmarkerslistt;y++)
			               	 	{
   			                   	    var marval=markerslistt[y].split("*");
			                   		var latt=marval[0];
			                   		var lonn=marval[1];
			                   		var phnamee=marval[2];
			                   		var waypnt=marval[3];
			                   		var point2 = new OpenLayers.LonLat(lonn,latt);
			                   		createMarker2(point2,waypnt,phnamee);
									returnMarker1(latt,lonn,y,phnamee,awaypntt1);
			               	 	}

								
								var countmarkerslistt1=resnew[0];
			                    var markerslistt1=resnew[1].split("$");
								var i=1;
								
			                    for(z=0;z<countmarkerslistt1;z++)
			               	 	{
				               	 	
			                   	 var marvall1=markerslistt1[z].split("*");
			                   		var alatty1=marvall1[0];
			                   		var alonny1=marvall1[1];
			                   		var aphtnamee1=marvall1[2];
			                   		var awaypntt1=marvall1[3];
			                   		var pointtt1 = new OpenLayers.LonLat(alonny1,alatty1);
									createMarker1(pointtt1,aphtnamee1,awaypntt1);
									
									document.getElementById("abc").innerHTML=document.getElementById("abc").innerHTML+"<br><a href='javascript:myclick1("+i+","+alatty1+","+alonny1+")'>"+awaypntt1;
									returnMarker(alatty1,alonny1,i,aphtnamee1,awaypntt1);
	 								i++;
			               	 	}
								
	   						 }
	                }
	       	var queryStringg = "?routee="+routee+"&type="+c_value;
	      	ajaxRequest.open("GET", "Ajaxjrmroute2.jsp"+queryStringg, true);
      	 ajaxRequest.send(null);
	}catch(e){alert(e);}
  	}

function myclick(lat, lon) 
{
	map1.setCenter(new OpenLayers.LonLat(lon,lat),
			10,
			false,
			true	);
	}

	 function loadKML(url){
	        try
	        {
		      //  alert("888888888");
	  	  map1.addLayer(new OpenLayers.Layer.GML("KML",url, 
	  	          {
	  	           format: OpenLayers.Format.KML, 
	  	           formatOptions: {
	  	             extractStyles: true 
	  	           }
	  	          }));
	        }
	        catch(e)
	        {
	            //alert("%%%%%%%%%%%%%%%"+e);
	        }
	    }

	 function routedetails()
	  	{
	  		GetUpdates1();  				
	  	} 

	 function GetUpdates1()
		{	

			var routee=document.getElementById("owner").value;
			
			if(!(routee=="Select") ||(routee=="ALL"))
	  		{
						try{
							// Opera 8.0+, Firefox, Safari
							ajaxRequest = new XMLHttpRequest();
					    }  
				        catch (e)
				        {
					  	// Internet Explorer Browsers
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
					                try
					                {
						                	var reslt=ajaxRequest.responseText;
					
						                    var resnew=reslt.split("#");
						                  //  document.getElementById("side_bar").innerHTML=resnew[4];
						                    var strtlat=resnew[5];
						                    var strtlon=resnew[6];
						                    var strtlocs=resnew[7];
						                    var endlat=resnew[8];
						                    var endlon=resnew[9];
						                    var endlocs=resnew[10];
						                    var latcenter=resnew[11];
						                    var loncenter=resnew[12];
						                    var  zoom=resnew[13];


							try{
							
							 
								 var num = map1.getNumLayers();
								 for (var i = num -1; i >= 0; i--) {
								        map1.removeLayer(map1.layers[i]);
								        } 
							
								
								 
								 map1.addLayer(layer1);
								
								  
							}catch(e){alert(e);}
								 			if(routee=="ALL")
								 			{
								 				map1.setCenter(new OpenLayers.LonLat(77.98972,23.45345).transform(
												        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
												        map1.getProjectionObject() // to Spherical Mercator Projection
												      ),5);
								 				
								 				/*map1.setCenter(new OpenLayers.LonLat(23.45345,77.98972),
								 						4,
								 						false,
								 						true	);*/
								 			}
								 			else
								 			{
								 				map1.setCenter(new OpenLayers.LonLat(loncenter,latcenter).transform(
												        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
												        map1.getProjectionObject() // to Spherical Mercator Projection
												      ),5);
								 				/*
								 				map1.setCenter(new OpenLayers.LonLat(loncenter,latcenter),
								 						zoom,
								 						false,
								 						true	);*/
								 			}      	          
							
											if(routee=="ALL")
											{
												//loadKML("KMLJRM/200.kml");
												
												loadKML("KMLJRM/CastrolNorthernRegion1KmStreach.kml");
												loadKML("KMLJRM/Delhi-Patalganga1Zone.kml");
												loadKML("KMLJRM/Bhivandi-Patalganga-BangloreKmStreach.kml");
												loadKML("KMLJRM/Bhivandi-Patalganga-Banglore-Chennai1Zone.kml");
												loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad1KmStreach.kml");
												loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad-Chennai1Zone.kml");
												loadKML("KMLJRM/Chennai-Pallakad1Zone.kml");
												loadKML("KMLJRM/Kolkata-Guwahati1KmStreach.kml");
												loadKML("KMLJRM/Kolkata-Kanpur-Lucknow1KmStreach.kml");
												loadKML("KMLJRM/Bhivandi-Dhule1KmStreach.kml");
												loadKML("KMLJRM/Bhivandi-Nagpur1Zone.kml");
												loadKML("KMLJRM/tankerEast.kml");	
												loadKML("KMLJRM/tankerWest.kml");	
												
											}
											if(routee=="Castrol Northern Region")
										    	loadKML("KMLJRM/CastrolNorthernRegion1KmStreach.kml");
										     if((routee=="Delhi-Patalganga"))
										    	 loadKML("KMLJRM/Delhi-Patalganga1Zone.kml");
											if(routee=="Bhivandi-Patalganga-Banglore")
												loadKML("KMLJRM/Bhivandi-Patalganga-BangloreKmStreach.kml");
											if(routee=="Bhivandi-Patalganga-Banglore-Chennai")
												loadKML("KMLJRM/Bhivandi-Patalganga-Banglore-Chennai1Zone.kml");		
											if(routee=="Bhivandi-Patalganga-Hydrabad")
												loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad1KmStreach.kml");
											if(routee=="Bhivandi-Patalganga-Hydrabad-Chennai")
												loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad-Chennai1Zone.kml");
											if(routee=="Chennai-Pallakad")
												loadKML("KMLJRM/Chennai-Pallakad1Zone.kml");
											if(routee=="Kolkata-Guwahati")
												loadKML("KMLJRM/Kolkata-Guwahati1KmStreach.kml");
											if(routee=="Kolkata-Kanpur-Lucknow")
												loadKML("KMLJRM/Kolkata-Kanpur-Lucknow1KmStreach.kml");
											if(routee=="Bhivandi-Dhule")
												loadKML("KMLJRM/Bhivandi-Dhule1KmStreach.kml");											
											if(routee=="Bhivandi-Nagpur")
												loadKML("KMLJRM/Bhivandi-Nagpur1Zone.kml");		
											if(routee=="TankerEast")
												loadKML("KMLJRM/tankerEast.kml");		
											if(routee=="TankerWest")
												loadKML("KMLJRM/tankerWest.kml");

											 markers1 = new OpenLayers.Layer.Markers( "Markers");
											 map1.addLayer(markers1);

											 
											if(routee!="ALL")
											{
												//           new OpenLayers.LonLat(lo,la)
												var point3 = new OpenLayers.LonLat(strtlon,strtlat);
											//	createMarker3(point3,strtlocs);
											}
			                                
			                                if(routee!="ALL")
											{
												var point4 = new OpenLayers.LonLat(endlon,endlat);
												//createMarker4(point4,endlocs);
											}
											var countmarkerslistt=resnew[2];
											var markerslistt=resnew[3].split("$");
											for(y=0;y<countmarkerslistt;y++)
						               	 	{
			   			                   	    var marval=markerslistt[y].split("*");
						                   		var latt=marval[0];
						                   		var lonn=marval[1];
						                   		var phnamee=marval[2];
						                   		var waypnt=marval[3];
						                   		var point2 = new OpenLayers.LonLat(lonn,latt);
						                   		//createMarker2(point2,waypnt,phnamee);
						               	 	}

					                }
					                catch(e)
					                {
						               // alert(e);
					                }
		   							  }//END oFF if(ajaxRequest.readyState == 4)
		                	}// EOF ajaxRequest.onreadystatechange = function()
		               	
		         	}
			
	      	var queryStringg = "?routee="+routee;
	      	ajaxRequest.open("GET", "Ajaxjrmroute1.jsp"+queryStringg, true);
	        ajaxRequest.send(null); 
	        
		 }


	 
	var url = "http://203.199.134.131:8008/mapguide/mapagent/mapagent.fcgi?USERNAME=Administrator&PASSWORD=admin";
	var metersPerUnit = 111319.4908;  //value returned from mapguide
	var inPerUnit = OpenLayers.INCHES_PER_UNIT.m * metersPerUnit;

	OpenLayers.INCHES_PER_UNIT["dd"] = inPerUnit;
	OpenLayers.INCHES_PER_UNIT["degrees"] = inPerUnit;
	OpenLayers.DOTS_PER_INCH = 72;

	var extent1 = new OpenLayers.Bounds(68.162834117480,6.7542559500000,97.41516105,37.06396505);
	var tempScales = [23659291,17074442,11322961,7588641,5059094,3372729,2248486,1498990,999327,666218,444145,296096,197397,131598,87732,58488,38992,25994,17329,11553,7702,5134,3423,2282,1521,1041,676,450,300,0];
	var mapOptions1 = {
	   maxExtent: extent1, 
	  scales:tempScales,
	        units: "dd"
	};
	map1 = new OpenLayers.Map( 'map', mapOptions1 );
	map1.addControl(new OpenLayers.Control.PanZoomBar());
	//map1.addControl(new OpenLayers.Control.MousePosition()); 
	map1.addControl(new OpenLayers.Control.OverviewMap());
	map1.addControl(new OpenLayers.Control.KeyboardDefaults());

	var params1 = {
		mapdefinition: 'Library://TranswoldNew/test.MapDefinition',

			 basemaplayergroupname: "Base Layer Group"
			  }
			  var options1 = 
				  {
			    
				  singleTile: true, isBaseLayer: true,
			    transitionEffect: "resize",
			    buffer: 1,
			    useOverlay: false,
			    useAsyncOverlay: false
			  };


			  //layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
			//layer1=new OpenLayers.Layer.OSM("Local Tiles","http://173.234.153.82/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19,'attribution': false, "tileOptions": {"crossOriginKeyword": null}},params1, options1);
			<%

//map integrate
String sqlmap="select * from t_defaultvals where OwnerName='"+session.getAttribute("usertypevalue")+"'";
//String sqlmap="select * from t_defaultvals where OwnerName='Castrol'";
ResultSet rsmap=st4.executeQuery(sqlmap);
System.out.println("started journey querry--------->"  +sqlmap);
if(rsmap.next())
{
	smap=rsmap.getString("Map");
	System.out.println("Map"  +smap);
}
%>
<%
if(smap.equals("OSM"))
{
	System.out.println("Hi1");
%>
layer1=new OpenLayers.Layer.OSM("Local Tiles","http://maps.myfleetview.com/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19, attribution : '<a href="http://myfleetview.com/" style="text-decoration:none"><font face="Hemi Head 426" size="03" color="#0853A0">FleetView <br><font face="Hemi Head 426" size="0.5" color="#0853A0">Transworld Technologies Ltd.  </a>', "tileOptions": {"crossOriginKeyword": null}},params1, options1);
	
	<%
	System.out.println("Hi2");
}

	else if(smap.equals("MPG"))
	{
	%>
	
	layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	<%
    }
	
	else if(smap.equals(""))
	{
		System.out.println("No Data");
		String sqlmap1="select * from t_defaultvals where OwnerName='Default'";
		//String sqlmap="select * from t_defaultvals where OwnerName='Castrol'";
		ResultSet rsmap1=st2.executeQuery(sqlmap1);
		System.out.println("started journey querry--------->"  +sqlmap1);
		if(rsmap1.next())
		{
			smap1=rsmap1.getString("Map");
			System.out.println("Map"  +smap1);
		}
		if(smap1.equals("OSM"))
				{
			
			System.out.println("Hi1");
    %>
    layer1=new OpenLayers.Layer.OSM("Local Tiles","http://maps.myfleetview.com/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19, attribution : '<a href="http://myfleetview.com/" style="text-decoration:none"><font face="Hemi Head 426" size="03" color="#0853A0">FleetView <br><font face="Hemi Head 426" size="0.5" color="#0853A0">Transworld Technologies Ltd.  </a>', "tileOptions": {"crossOriginKeyword": null}},params1, options1);
	
	<%
		}
		else if(smap1.equals("MPG"))
		{
	System.out.println("Data1");
	%>
	
	layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	<%
		}
	}
    %> 
			
			map1.addLayer(layer1);
			
			 map1.setCenter(new OpenLayers.LonLat(77.98972,23.45345).transform(
				        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
				        map1.getProjectionObject() // to Spherical Mercator Projection
				      ),4);

			 loadKML("KMLJRM/TWIndiaBoundry.kml");
			 
	
}
catch(e)
{
	
}
</script>
    </body>
    </html>
    <%@ include file="footernew.jsp" %>