
<%@ include file="headernew.jsp" %>
<%
response.setHeader("Cache-Control", "no-cache");
%>
<html>
<head>

</head>
<script
	src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ"
	type="text/javascript">
	
	</script>

<script type="text/javascript">


window.onload=function()
{

	loadmap();
	
}

if (GBrowserIsCompatible()) 
{
	var map;
	var ajaxRequest;
	//alert("hi");
	var gmarkers = [];
    var htmls = [];
    
	function loadmap()
	{
		
		 map = new GMap2(document.getElementById("map"),{draggableCursor:'default',draggingCursor:'pointer'});
		
		map.addControl(new GMapTypeControl(1));
	   map.enableScrollWheelZoom();
		map.addControl(new GSmallMapControl());
		map.addControl(new GScaleControl());
	   
	   map.setCenter(new GLatLng(18.68137,74.11815),5);
		
		
	}
	

<%!Connection conn = null;
	Statement st = null;
	Statement st1 = null;
	Statement st2 = null;
	Statement st4 = null;
	Statement st5 = null;
	Statement stnew = null;
	Statement stnew1 = null;
	Statement st3 = null;
	ResultSet rst = null;
	ResultSet rst1 = null;
	ResultSet rst2 = null;
	ResultSet rst3 = null;

	String routename = "";
	String type = "";
	double lat = 0.0, lon = 0.0;
	double latst = 0.0, lonst = 0.0;
	String routest = "";
	double latst1 = 0.0, lonst1 = 0.0;
	String routest1 = "", end = "";%>
<%try {
				Class.forName(MM_dbConn_DRIVER);
				conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
				//Class.forName("org.gjt.mm.mysql.Driver");
				//conn= DriverManager.getConnection("jdbc:mysql://localhost/db_gps","ujjain","u@1jn");
				//conn= DriverManager.getConnection("jdbc:mysql://203.199.134.130/db_gps","ujjain","u@1jn");
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st5 = conn.createStatement();

				stnew = conn.createStatement();
				stnew1 = conn.createStatement();
				st4 = conn.createStatement();

			} catch (Exception e) {%>
	//alert("error 1");
	
	<%//System.out.println("hi");
			}%>
			
function selectAll()
{
	//alert("select all called");
	//var cntr=document.addgrpform.hide.value;
	//alert(cntr);
var x=document.addgrpform.layer1.checked;
	
if(x)
{
	//alert("in else");
	for (var i=0; i < document.addgrpform.layer.length; i++)
 	 {
	 	 
	 document.addgrpform.layer[i].checked=true;
	
    }
	
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

	
	//alert(c_value);

		
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

		                    
		                    //document.getElementById("side_bar").innerHTML=resnew[4];
		                    var strtlat=resnew[5];
		                    var strtlon=resnew[6];
		                    var strtlocs=resnew[7];
		                    var endlat=resnew[8];
		                    var endlon=resnew[9];
		                    var endlocs=resnew[10];
		                    var latcenter=resnew[11];
		                    var loncenter=resnew[12];
		                    var  zoom=resnew[13];
		                    
		                   

	//alert(strtlat);
	//alert(strtlon);
	//alert(strtlocs);
	//alert(endlat);
	//alert(endlon);
	//alert(endlocs);
		               	 						
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//loadmap();
		               	 

		                      map = new GMap2(document.getElementById("map"));
		                     // map.setCenter(new GLatLng(17.73889, 75.78258),5);
								//var gmarkers = [];
	   							//var htmls = [];
						//		var map = new GMap2(document.getElementById("map"));
	 			map.addControl(new GMapTypeControl(1));
	 			map.enableScrollWheelZoom();
	 			map.addControl(new GSmallMapControl());
	 			map.addControl(new GScaleControl());
	 			map.setCenter(new GLatLng(latcenter, loncenter),parseInt(zoom));
	 			
	 			 if(routee=="JohndereToPune")
					{
						//alert("KML load JohndereToPune");
					var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
					map.addOverlay(gx);
			     	}
					if((routee=="PalaspeToJNPT") ||(routee==" PalaspeToJNPT"))
							{
						//alert("KML load PalaspeToJNPT");
					var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
					map.addOverlay(gx2);
				 	}
					if(routee=="ShedToAsud")
					{
						//alert("KML LOad shed-asud");
					var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
					map.addOverlay(gx4);
					
					}
					if(routee=="SilvasaToBhilad")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
					map.addOverlay(gx6);
					}
					if(routee=="KolkataToGuwahati")
					{
						//alert("KML LOad shed-asud");
					var gx7 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Kolkata-Guwahati.kml");
					map.addOverlay(gx7);
					
					}
					if(routee=="PatalgangaToHyderabad")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx8 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Hydrabad.kml");
					map.addOverlay(gx8);
					}

					if(routee=="DelhiToPatalganga")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
					map.addOverlay(gx9);
					}

					
					if(routee=="MumbaiToChennai")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx10 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Mumbai-Chennai.kml");
					map.addOverlay(gx10);
					}

					if(routee=="PatalgangaToBanglore")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx11 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Banglore.kml");
					map.addOverlay(gx11);
					}

					if(routee=="PatalgangaToSilvasa")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx12 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/PatalgangaSilvasa1.kml");
					map.addOverlay(gx12);
					}
					
					if(routee=="BaragoraToJamshedpur")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx13 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Baragora-Jamshedpur.kml");
					map.addOverlay(gx13);
					}

					if(routee=="PaharpurToJungalpur")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx14 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Paharpur-Jungalpur.kml");
					map.addOverlay(gx14);
					}
					
	 


					
							
								//alert("In load map of"+routee);
								    
									var point3 = new GLatLng(strtlat,strtlon);

									//alert("point3--->"+point3);
									var markerst=createMarker3(point3,strtlocs);
									map.addOverlay(markerst);

									
									var point4 = new GLatLng(endlat,endlon);
									var markerst1=createMarker4(point4,endlocs);
									map.addOverlay(markerst1);


									var countmarkerslistt=resnew[2];
									var markerslistt=resnew[3].split("$");
									//alert("countmarkerslistt-----"+countmarkerslistt);
									//alert("markerslistt--->"+markerslistt);
									var m=1;
									for(y=0;y<countmarkerslistt;y++)
				               	 	{
									//alert("in marklistt");
									//alert("y--->"+y);
	   			                   	    var marval=markerslistt[y].split("*");
				                   		//alert("marval-->"+marval);
				                   		var latt=marval[0];
				                   		var lonn=marval[1];
				                   		var phnamee=marval[2];
				                   		var waypnt=marval[3];
				                   		
				                   		var point2 = new GLatLng(latt,lonn);
				                   		var markerph=createMarker2(point2,waypnt,phnamee);
										map.addOverlay(markerph);
										//returnMarker(latt,lonn,y,aphtnamee1,awaypntt1);
										//returnMarker1(latt,lonn,m,phnamee,waypnt);
										//m++;
				                   	 //returnMarker();
				               	 	}

									
									//alert("out and in into another");
									var countmarkerslistt1=resnew[0];
				                    var markerslistt1=resnew[1].split("$");
				                    //alert("countmarkerslistt1-----"+countmarkerslistt1);
									//alert("markerslistt1--->"+markerslistt1);
									
				                    for(z=0;z<countmarkerslistt1;z++)
				               	 	{
					               	 	//alert("z is---"+z);
					               	 //alert("then-------"+resnew[2]-1);
				                   	 var marvall1=markerslistt1[z].split("*");
				                   		//alert("marvall1-->"+marvall1);
				                   		var alatty1=marvall1[0];
				                   		var alonny1=marvall1[1];
				                   		var aphtnamee1=marvall1[2];
				                   		var awaypntt1=marvall1[3];
				                   		//alert("alatty1"+alatty1);
				                   		//alert("alonny1"+alonny1);
				                   		//alert("aph1"+aphtnamee1);
				                   		//alert("awaypt"+awaypntt1);
				                   		var pointtt1 = new GLatLng(alatty1,alonny1);
										var markerphyhh1=createMarker1(pointtt1,aphtnamee1,awaypntt1);
										map.addOverlay(markerphyhh1);
										returnMarker(alatty1,alonny1,z,aphtnamee1,awaypntt1);
										document.getElementById("abc").innerHTML=document.getElementById("abc").innerHTML+"<br><a href='javascript:myclick1("+i+","+alatty1+","+alonny1+")'>"+awaypntt1;
										
				                   	// returnMarker();
				               	 	}

									
										//alert("y"+y);
				               	 	
				                    
									
									//var point2 = new GLatLng < %= lat2%>,< %=lon2%>);
									
								//	var markerph=createMarker2(point2,"< %=waypt2%>","< %= phname%>");
									//map.addOverlay(markerph);
		   							  }
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//*****************************************************************************************************************
		                
		               	
		         	}

		         	
	  
		       	var queryStringg = "?routee="+routee+"&type="+c_value;
		      
		       	
		      	ajaxRequest.open("GET", "Ajaxjrmroute2.jsp"+queryStringg, true);
		      //	alert("query string"+queryStringg);
	      	 ajaxRequest.send(null);
		         	
		         	        	
			         	 
	
	
}
else 

{
//alert("in uncheck");
document.getElementById("abc").innerHTML="";
	for (var i=0; i < document.addgrpform.layer.length; i++)
	{
		
		document.addgrpform.layer[i].checked=false;
		//document.addgrpform.layer1.checked=true;
		
	  }
	var routee=document.getElementById("owner").value;
	c_value="";
	
	if(c_value=="")
	{
		//window.onload();

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

	                    
	                    //document.getElementById("side_bar").innerHTML=resnew[4];
	                    var strtlat=resnew[5];
	                    var strtlon=resnew[6];
	                    var strtlocs=resnew[7];
	                    var endlat=resnew[8];
	                    var endlon=resnew[9];
	                    var endlocs=resnew[10];
	                    var latcenter=resnew[11];
	                    var loncenter=resnew[12];
	                    var  zoom=resnew[13];
	                    
	                   

	//alert(strtlat);
	//alert(strtlon);
	//alert(strtlocs);
	//alert(endlat);
	//alert(endlon);
	//alert(endlocs);
	               	 						
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//loadmap();
	               	

	                      map = new GMap2(document.getElementById("map"),{draggableCursor:'default',draggingCursor:'pointer'});
	                     // map.setCenter(new GLatLng(17.73889, 75.78258),5);
							//var gmarkers = [];
								//var htmls = [];
					//		var map = new GMap2(document.getElementById("map"));
				map.addControl(new GMapTypeControl(1));
				map.enableScrollWheelZoom();
				map.addControl(new GSmallMapControl());
				map.addControl(new GScaleControl());
				map.setCenter(new GLatLng(latcenter, loncenter),parseInt(zoom));
				
				 if(routee=="JohndereToPune")
				{
					//alert("KML load JohndereToPune");
				var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
				map.addOverlay(gx);
		     	}
				if((routee=="PalaspeToJNPT") ||(routee==" PalaspeToJNPT"))
						{
					//alert("KML load PalaspeToJNPT");
				var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
				map.addOverlay(gx2);
			 	}
				if(routee=="ShedToAsud")
				{
					//alert("KML LOad shed-asud");
				var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
				map.addOverlay(gx4);
				
				}
				if(routee=="SilvasaToBhilad")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
				map.addOverlay(gx6);
				}
				if(routee=="KolKataToGuwahati")
				{
					//alert("KML LOad shed-asud");
				var gx7 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Kolkata-Guwahati.kml");
				map.addOverlay(gx7);
				
				}
				if(routee=="PatalgangaToHyderabad")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx8 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Hydrabad.kml");
				map.addOverlay(gx8);
				}

				if(routee=="DelhiToPatalganga")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
				map.addOverlay(gx9);
				}

				
				if(routee=="MumbaiToChennai")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx10 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Mumbai-Chennai.kml");
				map.addOverlay(gx10);
				}

				if(routee=="PatalgangaToBanglore")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx11 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Banglore.kml");
				map.addOverlay(gx11);
				}

				if(routee=="PatalgangaToSilvasa")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx12 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/PatalgangaSilvasa1.kml");
				map.addOverlay(gx12);
				}
				
				if(routee=="BaragoraToJamshedpur")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx13 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Baragora-Jamshedpur.kml");
				map.addOverlay(gx13);
				}

				if(routee=="PaharpurToJungalpur")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx14 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Paharpur-Jungalpur.kml");
				map.addOverlay(gx14);
				}
				
				
						
							//alert("In load map of"+routee);
							    
								var point3 = new GLatLng(strtlat,strtlon);

								//alert("point3--->"+point3);
								var markerst=createMarker3(point3,strtlocs);
								map.addOverlay(markerst);

								
								var point4 = new GLatLng(endlat,endlon);
								var markerst1=createMarker4(point4,endlocs);
								map.addOverlay(markerst1);


								var countmarkerslistt=resnew[2];
								var markerslistt=resnew[3].split("$");
								//alert("countmarkerslistt-----"+countmarkerslistt);
								//alert("markerslistt--->"+markerslistt);
								for(y=0;y<countmarkerslistt;y++)
			               	 	{
								//	alert("in marklistt");
									//alert("y--->"+y);
				                   	    var marval=markerslistt[y].split("*");
			                   		//alert("marval-->"+marval);
			                   		var latt=marval[0];
			                   		var lonn=marval[1];
			                   		var phnamee=marval[2];
			                   		var waypnt=marval[3];
			                   		var point2 = new GLatLng(latt,lonn);
			                   		var markerph=createMarker2(point2,waypnt,phnamee);
									map.addOverlay(markerph);
									
									
			                   	 //returnMarker();
			               	 	}

								
								//alert("out and in into another");
								var countmarkerslistt1=resnew[0];
			                    var markerslistt1=resnew[1].split("$");
			                    //alert("countmarkerslistt1-----"+countmarkerslistt1);
								//alert("markerslistt1--->"+markerslistt1);
								
			                    for(z=0;z<countmarkerslistt1;z++)
			               	 	{
				               	 	//alert("z is---"+z);
				               	 //alert("then-------"+resnew[2]-1);
			                   	 var marvall1=markerslistt1[z].split("*");
			                   		//alert("marvall1-->"+marvall1);
			                   		var alatty1=marvall1[0];
			                   		var alonny1=marvall1[1];
			                   		var aphtnamee1=marvall1[2];
			                   		var awaypntt1=marvall1[3];
			                   		//alert("alatty1"+alatty1);
			                   		//alert("alonny1"+alonny1);
			                   		//alert("aph1"+aphtnamee1);
			                   		//alert("awaypt"+awaypntt1);
			                   		var pointtt1 = new GLatLng(alatty1,alonny1);
									var markerphyhh1=createMarker1(pointtt1,aphtnamee1,awaypntt1);
									map.addOverlay(markerphyhh1);
									//returnMarker(alatty1,alonny1,aphtnamee1,awaypntt1);
									
									//document.getElementById("abc").innerHTML="";
									
									
			                   	// returnMarker();
			               	 	}

								
									//alert("y"+y);
			               	 	
			                    
								
								//var point2 = new GLatLng < %= lat2%>,< %=lon2%>);
								
							//	var markerph=createMarker2(point2,"< %=waypt2%>","< %= phname%>");
								//map.addOverlay(markerph);
	   							  }
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
	                
	               	
	         	}

	         	
	               c_value="blank";
	       	var queryStringg = "?routee="+routee+"&type="+c_value;
	      
	       	
	      	ajaxRequest.open("GET", "Ajaxjrmroute2.jsp"+queryStringg, true);
	      //alert("query string"+queryStringg);
	  	 ajaxRequest.send(null);
	         
	         	
	         	
	 }
		
}

}
function routedata()
{
	//alert("inrouyedate");
	var routee=document.getElementById("owner").value;
    

	var c_value="";
	for (var i=0; i < document.addgrpform.layer.length; i++)
	{
	if (document.addgrpform.layer[i].checked)
	   {
		c_value = c_value +"'"+ document.addgrpform.layer[i].value + "'"+",";
	  //  alert(c_value);
	   }

	}
	
	//alert(c_value);

		
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

		                    
		                    document.getElementById("side_bar").innerHTML=resnew[4];
		                   
		                    
		                    var strtlat=resnew[5];
		                    var strtlon=resnew[6];
		                    var strtlocs=resnew[7];
		                    var endlat=resnew[8];
		                    var endlon=resnew[9];
		                    var endlocs=resnew[10];
		                    var latcenter=resnew[11];
		                    var loncenter=resnew[12];
		                    var  zoom=resnew[13];

		                    
		                   

	//alert(strtlat);
	//alert(strtlon);
	//alert(strtlocs);
	//alert(endlat);
	//alert(endlon);
	//alert(endlocs);
		               	 						
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//loadmap();
		               	  

		                      map = new GMap2(document.getElementById("map"),{draggableCursor:'default',draggingCursor:'pointer'});
		                     // map.setCenter(new GLatLng(17.73889, 75.78258),5);
								//var gmarkers = [];
	   							//var htmls = [];
						//		var map = new GMap2(document.getElementById("map"));
	 			map.addControl(new GMapTypeControl(1));
	 			map.enableScrollWheelZoom();
	 			map.addControl(new GSmallMapControl());
	 			map.addControl(new GScaleControl());
	 			map.setCenter(new GLatLng(latcenter, loncenter),parseInt(zoom));
	 			
	 			 if(routee=="JohndereToPune")
					{
						//alert("KML load JohndereToPune");
					var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
					map.addOverlay(gx);
			     	}
					if((routee=="PalaspeToJNPT") ||(routee=="PalaspeToJNPT "))
							{
						//alert("KML load PalaspeToJNPT");
					var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
					map.addOverlay(gx2);
				 	}
					if(routee=="ShedToAsud")
					{
						//alert("KML LOad shed-asud");
					var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
					map.addOverlay(gx4);
					
					}
					if(routee=="SilvasaToBhilad")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
					map.addOverlay(gx6);
					}
					if(routee=="KolkataToGuwahati")
					{
						//alert("KML LOad shed-asud");
					var gx7 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Kolkata-Guwahati.kml");
					map.addOverlay(gx7);
					
					}
					if(routee=="PatalgangaToHyderabad")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx8 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Hydrabad.kml");
					map.addOverlay(gx8);
					}

					if(routee=="DelhiToPatalganga")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
					map.addOverlay(gx9);
					}

					
					if(routee=="MumbaiToChennai")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx10 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Mumbai-Chennai.kml");
					map.addOverlay(gx10);
					}

					if(routee=="PatalgangaToBanglore")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx11 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Banglore.kml");
					map.addOverlay(gx11);
					}

					if(routee=="PatalgangaToSilvasa")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx12 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/PatalgangaSilvasa1.kml");
					map.addOverlay(gx12);
					}
					
					if(routee=="BaragoraToJamshedpur")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx13 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Baragora-Jamshedpur.kml");
					map.addOverlay(gx13);
					}

					if(routee=="PaharpurToJungalpur")
					{
						//alert("Kml Load SilvasaToBhilad");
					var gx14 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Paharpur-Jungalpur.kml");
					map.addOverlay(gx14);
					}
					
	 


					
							
								//alert("In load map of"+routee);
								    
									var point3 = new GLatLng(strtlat,strtlon);

									//alert("point3--->"+point3);
									var markerst=createMarker3(point3,strtlocs);
									map.addOverlay(markerst);

									
									var point4 = new GLatLng(endlat,endlon);
									var markerst1=createMarker4(point4,endlocs);
									map.addOverlay(markerst1);


									var countmarkerslistt=resnew[2];
									var markerslistt=resnew[3].split("$");
									//alert("countmarkerslistt-----"+countmarkerslistt);
									//alert("markerslistt--->"+markerslistt);
									for(y=0;y<countmarkerslistt;y++)
				               	 	{
									//	alert("in marklistt");
										//alert("y--->"+y);
	   			                   	    var marval=markerslistt[y].split("*");
				                   		//alert("marval-->"+marval);
				                   		var latt=marval[0];
				                   		var lonn=marval[1];
				                   		var phnamee=marval[2];
				                   		var waypnt=marval[3];
				                   		var point2 = new GLatLng(latt,lonn);
				                   		var markerph=createMarker2(point2,waypnt,phnamee);
										map.addOverlay(markerph);
										
										
				                   	 //returnMarker();
				               	 	}

									
									//alert("out and in into another");
									var countmarkerslistt1=resnew[0];
				                    var markerslistt1=resnew[1].split("$");
				                    //alert("countmarkerslistt1-----"+countmarkerslistt1);
									//alert("markerslistt1--->"+markerslistt1);
									
				                    for(z=0;z<countmarkerslistt1;z++)
				               	 	{
					               	 	//alert("z is---"+z);
					               	 //alert("then-------"+resnew[2]-1);
				                   	 var marvall1=markerslistt1[z].split("*");
				                   		//alert("marvall1-->"+marvall1);
				                   		var alatty1=marvall1[0];
				                   		var alonny1=marvall1[1];
				                   		var aphtnamee1=marvall1[2];
				                   		var awaypntt1=marvall1[3];
				                   		//alert("alatty1"+alatty1);
				                   		//alert("alonny1"+alonny1);
				                   		//alert("aph1"+aphtnamee1);
				                   		//alert("awaypt"+awaypntt1);
				                   		var pointtt1 = new GLatLng(alatty1,alonny1);
										var markerphyhh1=createMarker1(pointtt1,aphtnamee1,awaypntt1);
										map.addOverlay(markerphyhh1);

										
										
				                   	// returnMarker();
				               	 	}

									
										//alert("y"+y);
				               	 	
				                    
									
									//var point2 = new GLatLng < %= lat2%>,< %=lon2%>);
									
								//	var markerph=createMarker2(point2,"< %=waypt2%>","< %= phname%>");
									//map.addOverlay(markerph);
		   							  }
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//*****************************************************************************************************************
							//*****************************************************************************************************************
		                
		               	
		         	}

		         	
	  
		       	var queryStringg = "?routee="+routee+"&type="+c_value;
		      
		       	
		      	ajaxRequest.open("GET", "Ajaxjrmroute2.jsp"+queryStringg, true);
		      //	alert("query string"+queryStringg);
	      	 ajaxRequest.send(null);
		         	

}	
	function myclick(lat, lon) {
		//alert("myclick");
  		map.setCenter(new GLatLng(lat,lon),15);
  		
  		//alert("hi");
  	}


	function myclick1(i,lat, lon) {

	//	var gmarkers = [];
		//var htmls = [];
  		map.setCenter(new GLatLng(lat,lon),14);
  		gmarkers[i].openInfoWindowHtml(htmls[i]);

  		
  		
  		 

  	}

	

	
  	function routedetails()
  	{
  		
  		
  	  	//alert("rt");
  	 //var param="only";
  	//GetUpdates1(param);
  	GetUpdates1();
  				
  	}
  	
		
  	
  	//Code added for layer 
	function layersend()
  	{

	//alert("Check");
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
	//window.onload();
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
					//alert(resnew[1]);
                    
                    //document.getElementById("side_bar").innerHTML=resnew[4];
                    var strtlat=resnew[5];
                    var strtlon=resnew[6];
                    var strtlocs=resnew[7];
                    var endlat=resnew[8];
                    var endlon=resnew[9];
                    var endlocs=resnew[10];
                    var latcenter=resnew[11];
                    var loncenter=resnew[12];
                    var  zoom=resnew[13];
                    
                   

//alert(strtlat);
//alert(strtlon);
//alert(strtlocs);
//alert(endlat);
//alert(endlon);
//alert(endlocs);
               	 						
					//*****************************************************************************************************************
					//*****************************************************************************************************************
					//*****************************************************************************************************************
					//*****************************************************************************************************************
					//loadmap();
               	 

                      map = new GMap2(document.getElementById("map"),{draggableCursor:'default',draggingCursor:'pointer'});
                     // map.setCenter(new GLatLng(17.73889, 75.78258),5);
						//var gmarkers = [];
							//var htmls = [];
				//		var map = new GMap2(document.getElementById("map"));
			map.addControl(new GMapTypeControl(1));
			map.enableScrollWheelZoom();
			map.addControl(new GSmallMapControl());
			map.addControl(new GScaleControl());
			map.setCenter(new GLatLng(latcenter, loncenter),parseInt(zoom));
			
			 if(routee=="JohndereToPune")
			{
				//alert("KML load JohndereToPune");
			var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
			map.addOverlay(gx);
	     	}
			if((routee=="PalaspeToJNPT") ||(routee==" PalaspeToJNPT"))
					{
				//alert("KML load PalaspeToJNPT");
			var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
			map.addOverlay(gx2);
		 	}
			if(routee=="ShedToAsud")
			{
				//alert("KML LOad shed-asud");
			var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
			map.addOverlay(gx4);
			
			}
			if(routee=="SilvasaToBhilad")
			{
				//alert("Kml Load SilvasaToBhilad");
			var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
			map.addOverlay(gx6);
			}
			if(routee=="KolkataToGuwahati")
			{
				//alert("KML LOad shed-asud");
			var gx7 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Kolkata-Guwahati.kml");
			map.addOverlay(gx7);
			
			}
			if(routee=="PatalgangaToHyderabad")
			{
				//alert("Kml Load SilvasaToBhilad");
			var gx8 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Hydrabad.kml");
			map.addOverlay(gx8);
			}

			if(routee=="DelhiToPatalganga")
			{
				//alert("Kml Load SilvasaToBhilad");
			var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
			map.addOverlay(gx9);
			}

			
			if(routee=="MumbaiToChennai")
			{
				//alert("Kml Load SilvasaToBhilad");
			var gx10 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Mumbai-Chennai.kml");
			map.addOverlay(gx10);
			}

			if(routee=="PatalgangaToBanglore")
			{
				//alert("Kml Load SilvasaToBhilad");
			var gx11 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Banglore.kml");
			map.addOverlay(gx11);
			}

			if(routee=="PatalgangaToSilvasa")
			{
				//alert("Kml Load SilvasaToBhilad");
			var gx12 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/PatalgangaSilvasa1.kml");
			map.addOverlay(gx12);
			}
			
			if(routee=="BaragoraToJamshedpur")
			{
				//alert("Kml Load SilvasaToBhilad");
			var gx13 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Baragora-Jamshedpur.kml");
			map.addOverlay(gx13);
			}

			if(routee=="PaharpurToJungalpur")
			{
				//alert("Kml Load SilvasaToBhilad");
			var gx14 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Paharpur-Jungalpur.kml");
			map.addOverlay(gx14);
			}
			


			
			
					
						//alert("In load map of"+routee);
						    
							var point3 = new GLatLng(strtlat,strtlon);

							//alert("point3--->"+point3);
							var markerst=createMarker3(point3,strtlocs);
							map.addOverlay(markerst);

							
							var point4 = new GLatLng(endlat,endlon);
							var markerst1=createMarker4(point4,endlocs);
							map.addOverlay(markerst1);


							var countmarkerslistt=resnew[2];
							var markerslistt=resnew[3].split("$");
							//alert("countmarkerslistt-----"+countmarkerslistt);
							//alert("markerslistt--->"+markerslistt);
							for(y=0;y<countmarkerslistt;y++)
		               	 	{
							//	alert("in marklistt");
								//alert("y--->"+y);
			                   	    var marval=markerslistt[y].split("*");
		                   		//alert("marval-->"+marval);
		                   		var latt=marval[0];
		                   		var lonn=marval[1];
		                   		var phnamee=marval[2];
		                   		var waypnt=marval[3];
		                   		var point2 = new GLatLng(latt,lonn);
		                   		var markerph=createMarker2(point2,waypnt,phnamee);
								map.addOverlay(markerph);
															
		                   	 //returnMarker();
		               	 	}

							
							//alert("out and in into another");
							var countmarkerslistt1=resnew[0];
							//alert("countmarkerslistt1--->"+countmarkerslistt1);
		                    var markerslistt1=resnew[1].split("$");
		                    //alert("countmarkerslistt1-----"+countmarkerslistt1);
							//alert("markerslistt1--->"+markerslistt1);
							
		                    for(z=0;z<countmarkerslistt1;z++)
		               	 	{
			               	 	//alert("z is---"+z);
			               	 //alert("then-------"+resnew[2]-1);
		                   	 var marvall1=markerslistt1[z].split("*");
		                   		//alert("marvall1-->"+marvall1);
		                   		var alatty1=marvall1[0];
		                   		var alonny1=marvall1[1];
		                   		var aphtnamee1=marvall1[2];
		                   		var awaypntt1=marvall1[3];
		                   		//alert("alatty1"+alatty1);
		                   		//alert("alonny1"+alonny1);
		                   		//alert("aph1"+aphtnamee1);
		                   		//alert("awaypt"+awaypntt1);
		                   		var pointtt1 = new GLatLng(alatty1,alonny1);
								var markerphyhh1=createMarker1(pointtt1,aphtnamee1,awaypntt1);
								map.addOverlay(markerphyhh1);
								//alert("waypoint--->"+awaypntt1);
								
								
								
								
		                   	// returnMarker();
		               	 	}

							
								//alert("y"+y);
		               	 	
		                    
							
							//var point2 = new GLatLng < %= lat2%>,< %=lon2%>);
							
						//	var markerph=createMarker2(point2,"< %=waypt2%>","< %= phname%>");
							//map.addOverlay(markerph);
   							  }
					//*****************************************************************************************************************
					//*****************************************************************************************************************
					//*****************************************************************************************************************
					//*****************************************************************************************************************
                }
               	
         	

         	
               c_value="blank";
       	var queryStringg = "?routee="+routee+"&type="+c_value;
      
       	
      	ajaxRequest.open("GET", "Ajaxjrmroute2.jsp"+queryStringg, true);
      //alert("query string"+queryStringg);
  	 ajaxRequest.send(null);
         	
         	
         	
 }
//alert(c_value);

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

	                    
	                    //document.getElementById("side_bar").innerHTML=resnew[4];
	                    var strtlat=resnew[5];
	                    var strtlon=resnew[6];
	                    var strtlocs=resnew[7];
	                    var endlat=resnew[8];
	                    var endlon=resnew[9];
	                    var endlocs=resnew[10];
	                    var latcenter=resnew[11];
	                    var loncenter=resnew[12];
	                    var  zoom=resnew[13];
	                    
	                   

//alert(strtlat);
//alert(strtlon);
//alert(strtlocs);
//alert(endlat);
//alert(endlon);
//alert(endlocs);
	               	 						
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//loadmap();
	               	 

	                      map = new GMap2(document.getElementById("map"),{draggableCursor:'default',draggingCursor:'pointer'});
	                     // map.setCenter(new GLatLng(17.73889, 75.78258),5);
							//var gmarkers = [];
   							//var htmls = [];
					//		var map = new GMap2(document.getElementById("map"));
 			map.addControl(new GMapTypeControl(1));
 			map.enableScrollWheelZoom();
 			map.addControl(new GSmallMapControl());
 			map.addControl(new GScaleControl());
 			map.setCenter(new GLatLng(latcenter, loncenter),parseInt(zoom));
 			
 			 if(routee=="JohndereToPune")
				{
					//alert("KML load JohndereToPune");
				var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
				map.addOverlay(gx);
		     	}
				if((routee=="PalaspeToJNPT") ||(routee==" PalaspeToJNPT"))
						{
					//alert("KML load PalaspeToJNPT");
				var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
				map.addOverlay(gx2);
			 	}
				if(routee=="ShedToAsud")
				{
					//alert("KML LOad shed-asud");
				var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
				map.addOverlay(gx4);
				
				}
				if(routee=="SilvasaToBhilad")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
				map.addOverlay(gx6);
				}
				if(routee=="KolkataToGuwahati")
				{
					//alert("KML LOad shed-asud");
				var gx7 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Kolkata-Guwahati.kml");
				map.addOverlay(gx7);
				
				}
				if(routee=="PatalgangaToHyderabad")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx8 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Hydrabad.kml");
				map.addOverlay(gx8);
				}

				if(routee=="DelhiToPatalganga")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
				map.addOverlay(gx9);
				}

				
				if(routee=="MumbaiToChennai")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx10 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Mumbai-Chennai.kml");
				map.addOverlay(gx10);
				}

				if(routee=="PatalgangaToBanglore")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx11 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Banglore.kml");
				map.addOverlay(gx11);
				}

				if(routee=="PatalgangaToSilvasa")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx12 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/PatalgangaSilvasa1.kml");
				map.addOverlay(gx12);
				}
				
				if(routee=="BaragoraToJamshedpur")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx13 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Baragora-Jamshedpur.kml");
				map.addOverlay(gx13);
				}

				if(routee=="PaharpurToJungalpur")
				{
					//alert("Kml Load SilvasaToBhilad");
				var gx14 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Paharpur-Jungalpur.kml");
				map.addOverlay(gx14);
				}
				
 


				
						
							//alert("In load map of"+routee);
							    
								var point3 = new GLatLng(strtlat,strtlon);

								//alert("point3--->"+point3);
								var markerst=createMarker3(point3,strtlocs);
								map.addOverlay(markerst);
								//returnMarker(strtlat,strtlon,strtlocs,strtlocs);

								
								var point4 = new GLatLng(endlat,endlon);
								var markerst1=createMarker4(point4,endlocs);
								map.addOverlay(markerst1);
								//returnMarker(endlat,endlat,endlocs,endlocs);
								

								var countmarkerslistt=resnew[2];
								var markerslistt=resnew[3].split("$");
								//alert("countmarkerslistt-----"+countmarkerslistt);
								//hi
								//alert("markerslistt--->"+markerslistt);
								var t=0;
								for(y=0;y<countmarkerslistt;y++)
			               	 	{
									//alert("in marklistt");
								//alert("y--->"+y);
   			                   	    var marval=markerslistt[y].split("*");
			                   		//alert("marval-->"+marval);
			                   		var latt=marval[0];
			                   		var lonn=marval[1];
			                   		var phnamee=marval[2];
			                   		var waypnt=marval[3];
			                   		var point2 = new GLatLng(latt,lonn);
			                   		var markerph=createMarker2(point2,waypnt,phnamee);
									map.addOverlay(markerph);
									returnMarker1(latt,lonn,y,phnamee,awaypntt1);
									
									
			                   	 //returnMarker();
			               	 	}

								
								//alert("out and in into another");
								var countmarkerslistt1=resnew[0];
			                    var markerslistt1=resnew[1].split("$");
			                    //alert("countmarkerslistt1-----"+countmarkerslistt1);
								//alert("markerslistt1--->"+markerslistt1);
								var i=1;
			                    for(z=0;z<countmarkerslistt1;z++)
			               	 	{
				               	 	
				               	 	//alert("z is---"+z);
				               	 //alert("then-------"+resnew[2]-1);
			                   	 var marvall1=markerslistt1[z].split("*");
			                   		//alert("marvall1-->"+marvall1);
			                   		var alatty1=marvall1[0];
			                   		var alonny1=marvall1[1];
			                   		var aphtnamee1=marvall1[2];
			                   		var awaypntt1=marvall1[3];
			                   		//alert("alatty1"+alatty1);
			                   		//alert("alonny1"+alonny1);
			                   		//alert("aph1"+aphtnamee1);
			                   		//alert("awaypt"+awaypntt1);
			                   		var pointtt1 = new GLatLng(alatty1,alonny1);
									var markerphyhh1=createMarker1(pointtt1,aphtnamee1,awaypntt1);
									map.addOverlay(markerphyhh1);
									
									document.getElementById("abc").innerHTML=document.getElementById("abc").innerHTML+"<br><a href='javascript:myclick1("+i+","+alatty1+","+alonny1+")'>"+awaypntt1;
									returnMarker(alatty1,alonny1,i,aphtnamee1,awaypntt1);
									
	 								i++;
									
			                   	// returnMarker();
			               	 	}

								
									//alert("y"+y);
			               	 	
			                    
								
								//var point2 = new GLatLng < %= lat2%>,< %=lon2%>);
								
							//	var markerph=createMarker2(point2,"< %=waypt2%>","< %= phname%>");
								//map.addOverlay(markerph);
	   							  }
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
	                }
	               	
	         	

	         	
  
	       	var queryStringg = "?routee="+routee+"&type="+c_value;
	      
	       	
	      	ajaxRequest.open("GET", "Ajaxjrmroute22.jsp"+queryStringg, true);
	      //	alert("query string"+queryStringg);
      	 ajaxRequest.send(null);
	         	
	         	
	         	
		         	 
	         
  	}
	
	

	function layer()
  	{
	  	alert("layer");
	  	
		 
  	}

	function returnMarker1(lat,lon,cnt,name1,waypt)
	{
		
			
		
		var cIcon = new GIcon();


		//alert(" Road");
			cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Cinema.JPG';
			//cIcon.image = '/home/mahesh/Desktop/Symbol/green-dot.png';
				
			cIcon.iconSize = new GSize(20,30);
	  		cIcon.iconAnchor = new GPoint(6, 20);
	  		cIcon.infoWindowAnchor = new GPoint(5, 1);
	  		markerOptions = { icon:cIcon};
	  		
	  		var point = new GLatLng(lat,lon);
	  		var marker = new GMarker(point, markerOptions);
	  		GEvent.addListener(marker, "mouseover", function() {
	  	    marker.openInfoWindowHtml(name1+"<br>"+waypt);
	  	    });
	  	    
	  	    if(gmarkers[cnt])
	  	    {
	  	       map.removeOverlay(gmarkers[cnt]);
	  	    }
	  	    
	  	    
	  		gmarkers[cnt] = marker;
	  		
	  	    htmls[cnt] = name1+"<br>"+waypt;
	  		map.addOverlay(marker);

				
	}
	  function returnMarker(lat,lon,cnt,name1,waypt)
	  {
//alert("cnt"+cnt);
		 
		  var cIcon = new GIcon();
		

		  if((name1=="Road") || (name1==" Road"))
		  {
		  	//alert(" Road");
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Green.jpg';
		  }

		  else if((name1=="Bus Stop")||(name1==" Bus Stop"))
		  {
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Bus1.JPG';
		  }
		  else if((name1=="Petrol Pump") || (name1==" Petrol Pump") || (name1=="Petrol"))
		  {
		  	//alert("In pet pump");
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/petrolpump.JPG';
		  }
		  else if((name1=="Parking")|| (name1==" Parking"))
		  {
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Red.jpg';
		  }
		  else if((name1=="Bridge")|| (name1=="Bridge "))
		  {
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Tops.jpg';
		  }
		  else if((name1=="Bank")|| (name1==" Bank"))
		  {
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/bank.JPG';
		  }
		  else if((name1=="Hospital")|| (name1==" Hospital"))
		  {
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/hospital.JPG';
		  }


		  else if((name1=="Hotel") || (name1==" Hotel"))
		  {
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Hotel.JPG';
		  }

		  else if((name1=="Market") ||(name1==" Market"))
		  		{
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Mosq.JPG';
		  		}
		  else if((name1=="Village") ||(name1==" Village"))
		  {
		  cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/bank.JPG';
		  }
		  else if((name1=="ATM") ||(name1==" ATM"))
		  {
		  cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Atm.JPG';
		  }


		  else if((name1=="Mile Stone") ||(name1==" Mile Stones"))
		  {
		  cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Indistry.JPG';
		  }

		  else if((name1=="Temple") ||(name1==" Temple"))
		  {
		  cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/temple.JPG';
		  }

		  else if((name1=="School") ||(name1==" School"))
		  {
		  cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/School.JPG';
		  }
		  else
		  {
		  	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/untitled.JPG';
		  }
		  		
		  		cIcon.iconSize = new GSize(20,30);
		  		cIcon.iconAnchor = new GPoint(6, 20);
		  		cIcon.infoWindowAnchor = new GPoint(5, 1);
		  		markerOptions = { icon:cIcon};
		  		
		  		var point = new GLatLng(lat,lon);
		  		var marker = new GMarker(point, markerOptions);
		  		GEvent.addListener(marker, "mouseover", function() {
		  	    marker.openInfoWindowHtml(name1+"<br>"+waypt);
		  	    });
		  	    
		  	    if(gmarkers[cnt])
		  	    {
		  	       map.removeOverlay(gmarkers[cnt]);
		  	    }
		  	    
		  	    
		  		gmarkers[cnt] = marker;
		  		
		  	    htmls[cnt] = name1+"<br>"+waypt;
		  		map.addOverlay(marker);
			
		 // alert(name1);
	  }



	 

	function GetUpdates()
	{	
		//alert("updates");
		//alert("initial");
		//alert("get"+get);
		var c_value="";
		
		var routee=document.getElementById("owner").value;
	    

		
		if(!(c_value==""))
		{
		for (var i=0; i < document.addgrpform.layer.length; i++)
		{
		if (document.addgrpform.layer[i].checked)
		   {
			c_value = c_value +"'"+ document.addgrpform.layer[i].value + "'"+",";
		  //  alert(c_value);
		   }

		}
		}
		
		//	alert("It will take few seconds to load...");
		
		
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
	                	
	                    //alert(reslt);
	                    var resnew=reslt.split("#");
	                    
	                  //  var latlon=rsnew[1];
	                    //alert("latlon"+latlon);
	                    document.getElementById("side_bar").innerHTML=resnew[2];
	               	 	var lat=resnew[0];
	               	 	var lon=resnew[1];
	               	 	
	               	 var latcenter=resnew[5];
	                    var loncenter=resnew[6];
	                    var  zoom=resnew[7];
	                  
	               	 	
	               	 	//alert("lat"+lat);
	               	//alert("lon"+lon);
	               	 	
	               	
	               	

	                      map = new GMap2(document.getElementById("map"),{draggableCursor:'default',draggingCursor:'pointer'});
	                     // map.setCenter(new GLatLng(17.73889, 75.78258),5);
							//var gmarkers = [];
  							//var htmls = [];
					//		var map = new GMap2(document.getElementById("map"));
			map.addControl(new GMapTypeControl(1));
			map.enableScrollWheelZoom();
			map.addControl(new GSmallMapControl());
			map.addControl(new GScaleControl());
			
			map.setCenter(new GLatLng(latcenter,loncenter),parseInt(zoom));
						
							//alert("In load map of"+routee);
							     if(routee=="JohndereToPune")
								{
									//alert("KML load JohndereToPune");
								var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
								map.addOverlay(gx);
						     	}
								if((routee==" PalaspeToJNPT") || (routee=="PalaspeToJNPT"))
										{
									//alert("KML load PalaspeToJNPT");
								var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
								map.addOverlay(gx2);
							 	}
								if(routee=="ShedToAsud")
								{
									//alert("KML LOad shed-asud");
								var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
								map.addOverlay(gx4);
								
								}
								if(routee=="SilvasaToBhilad")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
								map.addOverlay(gx6);
								}
								if(routee=="KolkataToGuwahati")
								{
									//alert("KML LOad shed-asud");
								var gx7 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Kolkata-Guwahati.kml");
								map.addOverlay(gx7);
								
								}
								if(routee=="PatalgangaToHyderabad")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx8 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Hydrabad.kml");
								map.addOverlay(gx8);
								}

								if(routee=="DelhiToPatalganga")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
								map.addOverlay(gx9);
								}

								
								if(routee=="MumbaiToChennai")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx10 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Mumbai-Chennai.kml");
								map.addOverlay(gx10);
								}

								if(routee=="PatalgangaToBanglore")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx11 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Banglore.kml");
								map.addOverlay(gx11);
								}

								if(routee=="PatalgangaToSilvasa")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx12 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/PatalgangaSilvasa1.kml");
								map.addOverlay(gx12);
								}
	               	 }
	               	// map1.setCenter(new GLatLng(18.68137,74.11815),12);
						
	               	 	
	               
	               	
	         	}
	          
	       	var queryStringg = "?routee="+routee;
	      	ajaxRequest.open("GET", "Ajaxjrmroute.jsp"+queryStringg, true);
	      	//alert("query string"+queryStringg);
      	 ajaxRequest.send(null); 
      	 
	 }

	function GetUpdates1()
	{	
		//alert("get1");
		//alert("Map");
	//	alert("It will take few seconds to load...");
		var routee=document.getElementById("owner").value;
		
		if(!(routee=="Select") ||(routee=="ALL"))
  				{
		//alert("routee-->>"+routee);
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

	                    //(reslt);
	                    var resnew=reslt.split("#");
	                    document.getElementById("side_bar").innerHTML=resnew[4];
	                    var strtlat=resnew[5];
	                    var strtlon=resnew[6];
	                    var strtlocs=resnew[7];
	                    var endlat=resnew[8];
	                    var endlon=resnew[9];
	                    var endlocs=resnew[10];
	                    var latcenter=resnew[11];
	                    var loncenter=resnew[12];
	                    var  zoom=resnew[13];
	                    


//alert(endlat);
//alert(endlon);
//alert(endlocs);
	               	 						
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//loadmap();
	               	
	               	         
//alert("hi");                   
	                       map = new GMap2(document.getElementById("map"),{draggableCursor:'default',draggingCursor:'pointer'});
	                     // map.setCenter(new GLatLng(17.73889, 75.78258),5);
							
					//		var map = new GMap2(document.getElementById("map"));
 			map.addControl(new GMapTypeControl(1));
 			map.enableScrollWheelZoom();
 			map.addControl(new GSmallMapControl());
 			map.addControl(new GScaleControl());
 			
 			if(routee=="ALL")
 			{
 	 			//alert("all");
 				 map.setCenter(new GLatLng(18.68137,74.11815),5);
 			}
 			else
 			{
 	 			//alert("other");
 			map.setCenter(new GLatLng(latcenter, loncenter),parseInt(zoom));
 			}      	          
						
							//alert("In load map of"+routee);
							
							if(routee=="ALL")
							{
								//alert("all");
								var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
								map.addOverlay(gx);
								var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
								map.addOverlay(gx2);
								var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
								map.addOverlay(gx4);	
								var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
								map.addOverlay(gx6);
								var gx7 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Kolkata-Guwahati.kml");
								map.addOverlay(gx7);
								var gx8 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Hydrabad.kml");
								map.addOverlay(gx8);
								var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
								map.addOverlay(gx9);
								var gx10 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Mumbai-Chennai.kml");
								map.addOverlay(gx10);
								var gx11 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Banglore.kml");
								map.addOverlay(gx11);
								var gx12 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/PatalgangaSilvasa1.kml");
								map.addOverlay(gx12);
								var gx13 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Baragora-Jamshedpur.kml");
								map.addOverlay(gx13);
								var gx14 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Paharpur-Jungalpur.kml");
								map.addOverlay(gx14);
								
							}
							    if(routee=="JohndereToPune")
								{
									//alert("KML load JohndereToPune");
								var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
								map.addOverlay(gx);
						     	}
							     if((routee=="PalaspeToJNPT") ||(routee==" PalaspeToJNPT"))
										{
									//alert("KML load PalaspeToJNPT");
								var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
								map.addOverlay(gx2);
							 	}
								if(routee=="ShedToAsud")
								{
									//alert("KML LOad shed-asud");
								var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
								map.addOverlay(gx4);
								
								}
								if(routee=="SilvasaToBhilad")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
								map.addOverlay(gx6);
								}

								if(routee=="KolkataToGuwahati")
								{
									//alert("KML LOad shed-asud");
								var gx7 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Kolkata-Guwahati.kml");
								map.addOverlay(gx7);
								
								}
								if(routee=="PatalgangaToHyderabad")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx8 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Hydrabad.kml");
								map.addOverlay(gx8);
								}
								if(routee=="DelhiToPatalganga")
								{
									
								var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
								map.addOverlay(gx9);
								
								}

								
								if(routee=="MumbaiToChennai")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx10 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Mumbai-Chennai.kml");
								map.addOverlay(gx10);
								}

								if(routee=="PatalgangaToBanglore")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx11 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Banglore.kml");
								map.addOverlay(gx11);
								}

								if(routee=="PatalgangaToSilvasa")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx12 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/PatalgangaSilvasa1.kml");
								map.addOverlay(gx12);
								//alert("Kml Load PatalgangaToDelhi");
								}

								
								if(routee=="BaragoraToJamshedpur")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx13 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Baragora-Jamshedpur.kml");
								map.addOverlay(gx13);
								}

								if(routee=="PaharpurToJungalpur")
								{
									//alert("Kml Load SilvasaToBhilad");
								var gx14 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Paharpur-Jungalpur.kml");
								map.addOverlay(gx14);
								}

								if(routee!="ALL")
								{
								var point3 = new GLatLng(strtlat,strtlon);

								//alert("point3--->"+point3);
								
								
								var markerst=createMarker3(point3,strtlocs);
								map.addOverlay(markerst);
								}
								//returnMarker(startlat,startlon,strtlocs);
                                
                                
                                if(routee!="ALL")
								{
								var point4 = new GLatLng(endlat,endlon);
								
								var markerst1=createMarker4(point4,endlocs);
								
								map.addOverlay(markerst1);
								}

								var countmarkerslistt=resnew[2];
								var markerslistt=resnew[3].split("$");
								//alert("countmarkerslistt-----"+countmarkerslistt);
								//alert("markerslistt--->"+markerslistt);
								for(y=0;y<countmarkerslistt;y++)
			               	 	{
								//	alert("in marklistt");
									//alert("y--->"+y);
   			                   	    var marval=markerslistt[y].split("*");
			                   		//alert("marval-->"+marval);
			                   		var latt=marval[0];
			                   		var lonn=marval[1];
			                   		var phnamee=marval[2];
			                   		var waypnt=marval[3];
			                   		var point2 = new GLatLng(latt,lonn);
			                   		var markerph=createMarker2(point2,waypnt,phnamee);
									map.addOverlay(markerph);
									//returnMarker(latt,lonn,waypnt,waypnt);
									
			                   	 //returnMarker();
			               	 	}

								//alert("out and in into another");
								/*var countmarkerslistt1=resnew[0];
			                    var markerslistt1=resnew[1].split("$");
			                    //alert("countmarkerslistt1-----"+countmarkerslistt1);
								//alert("markerslistt1--->"+markerslistt1);
								
			                    for(z=0;z<countmarkerslistt1;z++)
			               	 	{
				               	 	//alert("z is---"+z);
				               	 //alert("then-------"+resnew[2]-1);
			                   	 var marvall1=markerslistt1[z].split("*");
			                   		//alert("marvall1-->"+marvall1);
			                   		var alatty1=marvall1[0];
			                   		var alonny1=marvall1[1];
			                   		var aphtnamee1=marvall1[2];
			                   		var awaypntt1=marvall1[3];
			                   		//alert("alatty1"+alatty1);
			                   		//alert("alonny1"+alonny1);
			                   		//alert("aph1"+aphtnamee1);
			                   		//alert("awaypt"+awaypntt1);
			                   		var pointtt1 = new GLatLng(alatty1,alonny1);
									var markerphyhh1=createMarker1(pointtt1,aphtnamee1,awaypntt1);
									map.addOverlay(markerphyhh1);
									
			                   	// returnMarker();
			               	 	}

								*/
									//alert("y"+y);
			               	 	
			                    
								
								//var point2 = new GLatLng < %= lat2%>,< %=lon2%>);
								
							//	var markerph=createMarker2(point2,"< %=waypt2%>","< %= phname%>");
								//map.addOverlay(markerph);
							
	   							  }
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
						//*****************************************************************************************************************
	                }
	               	
	         	}
		
      	var queryStringg = "?routee="+routee;
      	ajaxRequest.open("GET", "Ajaxjrmroute1.jsp"+queryStringg, true);
      	//alert(queryStringg);
        ajaxRequest.send(null); 
	 }
	


	function createMarker1(point,name1,typename) 
	{
		
		
		var cIcon = new GIcon();
var type=typename;

if((name1=="Road") || (name1==" Road"))
{
	//alert(" Road");
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Green.jpg';
}

else if((name1=="Bus Stop")||(name1==" Bus Stop"))
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Bus1.JPG';
}
else if((name1=="Petrol Pump") || (name1==" Petrol Pump") || (name1=="Petrol"))
{
	//alert("In pet pump");
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/petrolpump.JPG';
}
else if((name1=="Parking")|| (name1==" Parking"))
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Red.jpg';
}
else if((name1=="Bridge")|| (name1=="Bridge "))
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Tops.jpg';
}
else if((name1=="Bank")|| (name1==" Bank"))
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/bank.JPG';
}
else if((name1=="Hospital")|| (name1==" Hospital"))
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/hospital.JPG';
}


else if((name1=="Hotel") || (name1==" Hotel"))
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Hotel.JPG';
}

else if((name1=="Market") ||(name1==" Market"))
		{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Mosq.JPG';
		}
else if((name1=="Village") ||(name1==" Village"))
{
cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/bank.JPG';
}
else if((name1=="ATM") ||(name1==" ATM"))
{
cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Atm.JPG';
}


else if((name1=="Company") ||(name1==" Company"))
{
cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Indistry.JPG';
}
else
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/untitled.JPG';
}
		
		cIcon.iconSize = new GSize(20,30);
		cIcon.iconAnchor = new GPoint(6, 20);
		cIcon.infoWindowAnchor = new GPoint(5, 1);
		markerOptions = { icon:cIcon};
		//side_bar_html+='<tr><td><b>'+typname+'</b></td></tr>';
		var marker = new GMarker(point, markerOptions);
		//alert(marker);
		//var marker = new GMarker(point, markerOptions);
		GEvent.addListener(marker, "click", function() {
			 marker.openInfoWindowHtml(name1+"  "+typename);
			 
			});
		
		//gmarkers[typename] = marker;
		//htmls[typename]=name1+" "+typename;
		return marker
		
	  }


	
	  
	function createMarker2(point,typename,phname) 
	{
		//alert("point="+point+"lat="+lat+"lon="+lon+"typename="+typename+"theid="+theid);
		//alert("In create marker2--->pointst="+point);
		//alert("In create marker2--->typename="+typename);
		//alert("In create marker2--->phname="+phname);
		var cIcon = new GIcon();


//alert(" Road");
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Cinema.JPG';
	//cIcon.image = '/home/mahesh/Desktop/Symbol/green-dot.png';
		
		cIcon.iconSize = new GSize(20,30);
		cIcon.iconAnchor = new GPoint(6, 20);
		cIcon.infoWindowAnchor = new GPoint(5, 1);
		markerOptions = { icon:cIcon};
		var marker = new GMarker(point, markerOptions);
		//var marker = new GMarker(point, markerOptions);
		GEvent.addListener(marker, "click", function() {
			 marker.openInfoWindowHtml(typename+phname);
			 
			});
		return marker
		
	  }
	  
	function createMarker3(pointst,rname) 
	{
		//alert("point="+point+"lat="+lat+"lon="+lon+"typename="+typename+"theid="+theid);
	// alert("In create marker3--->pointst="+pointst);
	// alert("In create marker3--->rname="+rname);
		var cIcon = new GIcon();


//alert(" Road");
	cIcon.image = 'http://myfleetview.com/FleetView/images/green-dot.png';
//cIcon.image = '/home/mahesh/Desktop/Symbol/green-dot.png';
		
		cIcon.iconSize = new GSize(20,30);
		cIcon.iconAnchor = new GPoint(6, 20);
		cIcon.infoWindowAnchor = new GPoint(5, 1);
		markerOptions = { icon:cIcon};
		var marker3 = new GMarker(pointst, markerOptions);
		//var marker = new GMarker(point, markerOptions);
		GEvent.addListener(marker3, "click", function() {
			 marker3.openInfoWindowHtml(rname);
			 
			});
		return marker3
		
	  }
	function createMarker4(pointst1,rname1) 
	{
		//alert("point="+point+"lat="+lat+"lon="+lon+"typename="+typename+"theid="+theid);
	 //alert("In create marker4--->pointst="+pointst1);
	// alert("In create marker4--->rname="+rname1);
		
		var cIcon = new GIcon();


//alert(" Road");
	cIcon.image = 'http://myfleetview.com/FleetView/images/red-dot.png';
	//cIcon.image = '/home/mahesh/Desktop/Symbol/red-dot.png';
		
		cIcon.iconSize = new GSize(20,30);
		cIcon.iconAnchor = new GPoint(6, 20);
		cIcon.infoWindowAnchor = new GPoint(5, 1);
		markerOptions = { icon:cIcon};
		var marker4 = new GMarker(pointst1, markerOptions);
		//var marker = new GMarker(point, markerOptions);
		GEvent.addListener(marker4, "click", function() {
			 marker4.openInfoWindowHtml(rname1);
			 
			});
		return marker4
		
	  }
}
	</script>



<body onload="loadmap()">


<form name="addgrpform" method="get" action="">

<center><font color="maroon" size=3> JRM Route Name: </font> <!--  <select name="owner" id="owner" style="" onChange="GetUpdates1()">-->
<select name="owner" id="owner" style="" onChange="routedetails()">
	<%
		//System.out.println("routename--->"+routename);
		//if(!(null==routename))
		//{
	%>

	<!--<option value="< =routename%>" selected="selected">< %=routename%> </option>-->
	<%
		//}
		//else
		//{
	%>
	<option value="Select">Select</option>
	<option value="ALL">ALL</option>
	
	<%
		//}
	%>
	<%
		String sql33 = "SELECT distinct(routename)FROM `jrmroutemaster`";
		// out.print(sql3); 
		rst1 = st1.executeQuery(sql33);
		while (rst1.next()) 
		{
	%>
	<option value="<%=rst1.getString("routename")%>"><%=rst1.getString("routename")%></option>
	
	<%
		}
		
	%>
	
	
 <!--<input type="button" name="Submit"  value="Submit" onclick="loadmap();"></input>--></center>

<option value="<%=rst1.getString("routename")%>"><%=rst1.getString("routename")%></option></select>


<input type="hidden" name="myval" id="myval"></input>
<table border=0>
	<tr>

		<td>

		<div align="left">
		<div id="side_bar" style="overflow: auto; width: 350px; height: 500px"></div>
		</div>

		</td>

		<td>

		<div id=map style="width: 950px; height: 500px"></div>
		</td>


	</tr>

</table>
</form>
</body>
</html>
