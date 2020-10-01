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
String label="";
String Boston ="-",MDO = "-",Total = "0",Cotton = "0",Cottonper="0";
double lat=0.0,lon=0.0;
%>
<br></br>
<table align="center" border="0"  width="100%">
<tr>
<td align="left" valign="top">
<table width="100px" border="0">
<tr>
<td>
<div style="vertical-align: top;width: 120px;">
<table border="1"  class="sortable" style="width: 100px; display: none;" id="tbl">
<tr>
<th>KPI List</th>
</tr>
<tr>
<td>
<div align="left">
<input type="radio" value="Acreage" id="trk" class="" name="trk" onclick="showkml('Acreage')" checked="checked">Acreage
</div>
</td>
</tr>
<tr>
<td>
<div align="left">
<input type="radio" value="RainFall" id="trk" class="" name="trk" onclick="showkml('RainFall')">RainFall
</div>
</td>
</tr>
<tr>
<td>
<div align="left">
<input type="radio" value="Sales" id="trk" class="" name="trk" onclick="showkml('Sales')">Sales
</div>.
<input type="hidden" id="ip" name="ip" value="0"></input>
<input type="hidden" id="ip1" name="ip1" value="4"></input>
</td>
</tr>
</table>
</div>
</td>
<td align="left">
<div align="left">
<div id="div1" align="left"  style="vertical-align: top;width: 100px; display: none;">
<table class="sortable" border="2">
<tr>
<th>Acreage</th>
</tr>
<tr><td><div align="left">Dhule: 73%</div></td></tr>
<tr><td><div align="left">Nandurbar: 57%</div></td></tr>
<tr><td><div align="left">Dhar: 39%</div></td></tr>
<tr><td><div align="left">Jhabua: 37%</div></td></tr>
<tr><td><div align="left">Ratlam: 36%</div></td></tr>
</table>
</div>
<div id="div2" align="left"  style="vertical-align: top;width: 100px; display: none;">
<table class="sortable" border="1">
<tr>
<th>RainFall</th>
</tr>
<tr><td><div align="left">Dhule: 22%</div></td></tr>
<tr><td><div align="left">Nandurbar: 36%</div></td></tr>
<tr><td><div align="left">Dhar: 75%</div></td></tr>
<tr><td><div align="left">Jhabua: 75%</div></td></tr>
<tr><td><div align="left">Ratlam: 94%</div></td></tr>
</table>
</div>
<div id="div3" align="left"  style="vertical-align: top;width: 100px; display: none;">
<table class="sortable" border="1">
<tr>
<th>Sales</th>
</tr>
<tr><td><div align="left">Dhule: 104</div></td></tr>
<tr><td><div align="left">Nandurbar: 115</div></td></tr>
<tr><td><div align="left">Dhar: 14</div></td></tr>
<tr><td><div align="left">Jhabua: 24</div></td></tr>
<tr><td><div align="left">Ratlam: 105</div></td></tr>
</table>
</div>
</div>
</td>
</tr>
</table>
<div align="right" id="div4"  style="vertical-align: top;width: 170px; display: none;">
<br>
<table border="1" class="sortable" width="100px">
<tr>
<th>Baloon</th>
<th>Description</th>
</tr>
<tr>
<td><img src="images/mm_20_red.png"></img></td>
<td><div align="left">Cotton Acreage less than 30%</div></td>
</tr>
<tr>
<td><img src="images/mm_20_blue.png"></td>
<td><div align="left">Cotton Acreage  between 30% and 60%</div></td>
</tr>
<tr>
<td><img src="images/mm_20_green.png"></td>
<td><div align="left">Cotton Acreage greater than 60%</div></td>
</tr>
</table></div>
<br>
<div id="div5" align="right"  style="vertical-align: top;width: 170px; display: none;">
<table border="1" class="sortable" width="100px">
<tr>
<th colspan="2"> For Acreage</th>
</tr>
<tr>
<th>Color</th>
<th>Description</th>
</tr>
<tr>
<td><div style="background-color: #B40404;width: 1em;height: 1em;"></div></td>
<td><div align="left">Less than 40%</div></td>
</tr>
<tr>
<td><div style="background-color: #FFBF00;width: 1em;height: 1em;"></div></td>
<td><div align="left">Between 40% and 60%</div></td>
</tr>
<tr>
<td><div style="background-color: #9AFE2E;width: 1em;height: 1em;"></div></td>
<td><div align="left">Greater than 60%</div></td>
</tr>
</table></div>
<div align="right" id="div6"  style="vertical-align: top;width: 170px;display: none;">
<table border="1" class="sortable" width="100px">
<tr>
<th colspan="2"> For Rainfall</th>
</tr>
<tr>
<th>Color</th>
<th>Description</th>
</tr>
<tr>
<td><div style="background-color: #B40404;width: 1em;height: 1em;"></div></td>
<td><div align="left">Less than 40%</div></td>
</tr>
<tr>
<td><div style="background-color: #FFBF00;width: 1em;height: 1em;"></div></td>
<td><div align="left">Between 40% and 60%</div></td>
</tr>
<tr>
<td><div style="background-color: #9AFE2E;width: 1em;height: 1em;"></div></td>
<td><div align="left">Greater than 60%</div></td>
</tr>
</table></div>
<div align="right" id="div7"  style="vertical-align: top;width: 170px; display: none;">
<table border="1" class="sortable" width="100px">
<tr>
<th colspan="2"> For Sales </th>
</tr>
<tr>
<th>Color</th>
<th>Description</th>
</tr>
<tr>
<td><div style="background-color: #B40404;width: 1em;height: 1em;"></div></td>
<td><div align="left">Less than 50</div></td>
</tr>
<tr>
<td><div style="background-color: #FFBF00;width: 1em;height: 1em;"></div></td>
<td><div align="left">Between 50 and 100</div></td>
</tr>
<tr>
<td><div style="background-color: #9AFE2E;width: 1em;height: 1em;"></div></td>
<td><div align="left">Greater than 100</div></td>
</tr>
</table></div>
</td>
<td valign="top">
<div align="left" style="width: 800px;">
<table border="0" width="800px" align="center">

<tr align="center">
<td align="center">
<table border="0" width="100%" align="center" class="stats">
<tr align="center">
<td width="85%" align="center"><div id="map1" style="width: 800px; height: 470px" align="center"></div>
<input type="hidden" id="zoomlevel" name="zoomlevel" value="" />
</td>
</tr></table></td></tr></table></div>
</td>
</tr></table>
<script type="text/javascript">
//<![CDATA[
           
           function showkml(KPI)
           {
				var op;
				if(KPI=="Acreage")    
				{
					op = 0;
					document.getElementById("div2").style.display = "none";
				    document.getElementById("div3").style.display = "none";
					document.getElementById("div1").style.display = "";
					document.getElementById("div6").style.display = "none";
				    document.getElementById("div7").style.display = "none";
					document.getElementById("div5").style.display = "";
				}          
				else
					if(KPI=="RainFall")
					{
						op = 1;
						document.getElementById("div1").style.display = "none";
						document.getElementById("div3").style.display = "none";
						document.getElementById("div2").style.display = "";
						document.getElementById("div5").style.display = "none";
						document.getElementById("div7").style.display = "none";
						document.getElementById("div6").style.display = "";
					}
					else
						if(KPI=="Sales")
						{
							op = 2;
							document.getElementById("div1").style.display = "none";
							document.getElementById("div2").style.display = "none";
							document.getElementById("div3").style.display = "";
							document.getElementById("div5").style.display = "none";
							document.getElementById("div6").style.display = "none";
							document.getElementById("div7").style.display = "";
						}

				document.getElementById("ip").value = op;
				var zom = document.getElementById("zoomlevel").value;
				GetKML();
				
				if(zom >= 8)
				{
					GetMarker();
				}
           }
           
           
           function Getlabels()
           {
               
               try
               {
               a=0;
        	   var ajaxRequest;

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
   	            try
   	            {
   	   	            //alert("response Hii");
   	            var reslt = ajaxRequest.responseText;
   	            var list = reslt.split("$");

   	            for(var x=0;x<list.length-1;x++)
   	            {
   	   	            if(x==1)
   	   	            {
   	            	//alert("response Hii");
   	   	            }
   	            	var marval=list[x].split(",");
   	            	returnLables(marval[0],marval[1],marval[2],x);
   	            }
   	            j++;
   	            }catch(e)
   	            {
   	   	            //alert("#####    ajax response "+e);
   	            }
            }
         };

         
	     ajaxRequest.open("GET", "DistrictLabels.jsp", true);
         ajaxRequest.send(null); 
               }
               catch(e)
               {
                   //alert("!!!!!!!   Ajax "+e);
               }
           }

           function returnLables(latitude,longitude,name,index)
           {
               try
               {
                   //alert("#### j   "+j);
        	   var point = new GLatLng(latitude,longitude);
        	   var html="<font size='3' face='Arial' color='black'><b>"+name+"</b></font>"
        	   var label = new ELabel(point,html,"Utopia", new GSize(-10,10), 0);
        	 
             // alert("^^^^^^^   "+index+ "   *******    "+a);
        	  
             if(j>=2)
             {
                 try
                 {
                 map1.removeOverlay(glables[a]);
            	
         	 }catch(e)
                 {
                     //alert("$$$$$$$$     "+e)
                 }
             }

             glables[a]=label;
        	 a++;
        	   map1.addOverlay(label);
        	 
        	//   alert("map label ");
               }
               catch(e)
               {
                   if(index==0)
                   {
                       //alert(glabels[index]);
                  // alert("^^^^^^^   labels   "+e);
                   }
               }
           }

function removelabels()
{
	for(a=0;a<glables.length;a++)
	{
		map1.removeOverlay(glables[a]);
	}
}
           
           function createMarker(point,per,html,lat,lon)
     	{
            	try{
     		var cIcon = new GIcon();
             if(per < 30)
             {
            	 cIcon.image = 'images/mm_20_red.png';
             }

             if(per >30 && per <60)
             {
            	 cIcon.image = 'images/mm_20_blue.png';
             }

             if(per > 60)
             {
            	 cIcon.image = 'images/mm_20_green.png';
             }
     		
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
        	map1.setCenter(new GLatLng(lat,lon));
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
           

 function GetMarker()
 {
	 if(k>1)
		{
 	   for( i = 0;i<=gmarkers.length;i++)
        {
            try
            {
            map1.removeOverlay(gmarkers[i]);
 		   map1.addOverlay(gmarkers[i]);
            }
            catch(e)
            {
               // alert(e);
            }
        }
		}
		else
		{
			for( i = 0;i<=gmarkers.length;i++)
            {
                try
                {
     		   
     		   map1.addOverlay(gmarkers[i]);
                }
                catch(e)
                {
                   //alert(e);
                }
            }
		}
        k++;
 }

 function RemoveMarker()
 {
	 for( i = 0;i<=gmarkers.length;i++)
     {
         try
         {
      	   map1.removeOverlay(gmarkers[i]);
         }
         catch(e)
         {
            // alert(e);
         }
     }
 }

function GetKML()
{
	var op = document.getElementById("ip").value;
	//alert("op --->  "+op);
	try
	{
		try
		{
           try
           {
			map1.removeOverlay(gLabelIcons[0]);
			map1.removeOverlay(gLabelIcons[1]);
           }
           catch(e)
           {
               
           }
			if(k>1)
			{
				RemoveMarker();
			}
    		 for(i=0;i<=gkml.length;i++)
       			 {
        			map1.removeOverlay(gkml[i]);
        		 }
}
catch(e)
{
	
}
		if(op==0)
		{
			map1.addOverlay(gkml[0]);
			map1.addOverlay(gkml[1]);
			map1.addOverlay(gkml[2]);
			document.getElementById("div2").style.display = "none";
		    document.getElementById("div3").style.display = "none";
			document.getElementById("div1").style.display = "";
			document.getElementById("div6").style.display = "none";
		    document.getElementById("div7").style.display = "none";
			document.getElementById("div5").style.display = "";
		}
		else
			if(op==1)
			{
				map1.addOverlay(gkml[3]);
				map1.addOverlay(gkml[4]);
				document.getElementById("div1").style.display = "none";
			    document.getElementById("div3").style.display = "none";
				document.getElementById("div2").style.display = "";
				document.getElementById("div5").style.display = "none";
			    document.getElementById("div7").style.display = "none";
				document.getElementById("div6").style.display = "";
			}
			else
				if(op==2)
				{
					map1.addOverlay(gkml[5]);
					map1.addOverlay(gkml[6]);
					document.getElementById("div1").style.display = "none";
				    document.getElementById("div2").style.display = "none";
					document.getElementById("div3").style.display = "";
					document.getElementById("div5").style.display = "none";
				    document.getElementById("div6").style.display = "none";
					document.getElementById("div7").style.display = "";
				}
				
	}
	catch(e)
	{
		//alert(e);
	}
}

function RemoveKML()
{
	try
	{
		try
		{
           try
           {
			map1.removeOverlay(gLabelIcons[0]);
			map1.removeOverlay(gLabelIcons[1]);
           }
           catch(e)
           {
               
           }
			if(k>1)
			{
				RemoveMarker();
			}
    		 for(i=0;i<=gkml.length;i++)
       			 {
       			 try
       			 {
     				map1.removeOverlay(gkml[i]);
       			 }
       			 catch(e)
       			 {
           			 
       			 }
        		 }
  		 
}
catch(e)
{
	
}
    map1.addOverlay(gkml[7]);
	map1.addOverlay(gkml[8]);       
	map1.addOverlay(gLabelIcons[0]);
	map1.addOverlay(gLabelIcons[1]);
	 document.getElementById("div1").style.display = "none";
	 document.getElementById("div2").style.display = "none";
	 document.getElementById("div3").style.display = "none";
	 document.getElementById("div5").style.display = "none";
	    document.getElementById("div6").style.display = "none";
		document.getElementById("div7").style.display = "none";
	}
	catch(e)
	{
		
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
        map1.setCenter(new GLatLng(22.2118676,74.756336),6);
    	map1.addControl(new GMapTypeControl(1));
    	map1.enableScrollWheelZoom();
    	map1.addControl(new GSmallMapControl());
    	map1.addControl(new GScaleControl());

    	//var gx = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/D3.kml");
  		//map.addOverlay(gx);
  		//var gx1 = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/D2.kml");
  		//map.addOverlay(gx1);
    	 gkml[0] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/Acerage_green.kml");
  		 gkml[1] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/Acerage_red.kml");
  		 gkml[2] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/Acerage_yellow.kml");
  		 gkml[3] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/RainFall_green.kml");
  		 gkml[4] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/RainFall_red.kml");
  		 gkml[5] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/Sales_green.kml");
  		 gkml[6] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/Sales_red.kml");
  		 gkml[7] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/Region1.kml");
  		 gkml[8] = new GGeoXml("http://myfleetview.com/FleetViewTemp/KML/Region2.kml");

  		 try
  		 {
   		map1.addOverlay(gkml[7]);
  		map1.addOverlay(gkml[8]);
  		 
  	
  		

  		var pt = new GLatLng(19.378522756179393,75.3936767578125);
    	   var htm="<font size='2' face='Arial' color='white'><b>Region 2</b></font>"
   	   var lbl = new ELabel(pt,htm,"Utopia", new GSize(-10,10), 0);
    	   gLabelIcons[0] = lbl;

    		pt = new GLatLng(22.44149485938026,74.3994140625);
    		htm="<font size='2' face='Arial' color='white'><b>Narmada Region</b></font>"
    		lbl = new ELabel(pt,htm,"Utopia", new GSize(-5,15), 0);
    		gLabelIcons[1] = lbl;

    		map1.addOverlay(gLabelIcons[0]);
      		map1.addOverlay(gLabelIcons[1]);
  		}
  		 catch(e)
  		 {
  	  		// alert(e);
  		 }
    		
  		GEvent.addListener(map1,'zoomend',function()
  				{
  					var myzoomlevel = map1.getZoom();
  					document.getElementById("zoomlevel").value=myzoomlevel;
  					//alert(myzoomlevel);
  					if(myzoomlevel>=7)
  					{
						document.getElementById("tbl").style.display="";
				  		GetKML();
   	  				    Getlabels();	  
  					}
  					else if(myzoomlevel<7 && j>=2)
  					{
  						document.getElementById("tbl").style.display="none";
  	  					removelabels();
  	  				    RemoveKML();

  	  				    
  					}
  					else
  					{
  						document.getElementById("tbl").style.display="none";
  						RemoveKML();
  					}			
                   if(myzoomlevel >= 8)
                   {
                	   GetMarker();
                	   document.getElementById("div4").style.display="";
                   }
                   else
                       if(myzoomlevel <= 8 && k > 1)
                       {
                           RemoveMarker();  
                           document.getElementById("div4").style.display="none";     
                       }

 					
  				});
     	}

        loadmaphome();
      
       
<%
          
        sql="select * from db_gps.t_districtsales where Category = 'City'";
		ResultSet rs=st.executeQuery(sql);
		System.out.println("&&&&&&   "+sql);
		while(rs.next())
		{
			lat=rs.getDouble("Latitude");
			lon=rs.getDouble("Longitude");
			name=rs.getString("Name");
			
			Category=rs.getString("Category");
			Boston = rs.getString("Boston");
			MDO = rs.getString("MDO");
			Total = rs.getString("Total");
			Cotton = rs.getString("Cotton");
			Cottonper = rs.getString("Cottonper");
		//System.out.println("lat "+lat);
			//System.out.println("lon "+lon);
			//System.out.println("name "+name);
			if(Category=="City" || Category.equalsIgnoreCase("City"))
			{
        label="<b>"+name+"<br><br>Boston Classification: </b>"+Boston+" <br><b>Total Acreage: </b>"+Total+"<br><b>Cotton Acreage: </b>"+Cotton+"<br><b>Cotton Ac % of Total Ac.: </b>"+Cottonper+"%<br><b>MDO: </b>"+MDO+"";
        %>
     
       var point1 = new GLatLng(<%=lat%>,<%=lon%>);
      //  var label1= new ELabel(point1,'< %=name%>',"Utopia", new GSize(0,10), -7);
		var marker = createMarker(point1,<%=Cottonper%>,"<div class='bodyText' align='left'><%=label%></div>",<%=lat%>,<%=lon%>);
    // map1.addOverlay(marker);
   <%
     }
			else
			{
				
			}
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
    	
		