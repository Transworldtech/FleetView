<%@ include file="header.jsp" %>
<title>Vehicle Tracking System </title>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
<table border="1" width="100%" bgcolor="white">
<tr>
<td width="20%">
<div id="side_bar"  style="overflow:auto;height:550px;" align="left" ></div></td>
<td valign="top">
<div id="map" style="width:840px; height:340px"></div>
<div id="discription" style="overflow:auto;height:210px"></div>
</td>
</tr>
</table>
<%!
Connection conn;
Statement st,st1,st2,stquery;
String sql,sql1;
%>
    <script type="text/javascript">
    //<![CDATA[
    function GetIncidentInfo(srno)
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
                    document.getElementById("discription").innerHTML=reslt;   
		     		 } 
         	}
      var queryString = "?srno=" +srno;
	   ajaxRequest.open("GET", "Ajaxgetincidentinfo.jsp" + queryString, true);
	   ajaxRequest.send(null); 
	}
    if (GBrowserIsCompatible()) 
    {
	      var side_bar_html = "";
			var gmarkers = [];
      	var htmls = [];
      	var i = 0;
      	var map = new GMap2(document.getElementById("map"));
			map.setCenter(new GLatLng(18.80,80.1),5);
			map.addControl(new GMapTypeControl(1));
			map.enableScrollWheelZoom();
			map.addControl(new GSmallMapControl());
			map.addControl(new GScaleControl());
	        
	        function createMarker(point,name,html1,lat,lon,srno,ff) 
	        {
	        		var html=name+"<br>"+html1;
					var cIcon = new GIcon();
					if(ff==0)
					{
						cIcon.image = 'images/t6.png';
					}
					else
					{
						cIcon.image = 'images/t5.png';
					}
					cIcon.shadow = 'images/mm_20_shadow.png';
					cIcon.iconSize = new GSize(12,20);
					cIcon.shadowSize = new GSize(22, 20);
					cIcon.iconAnchor = new GPoint(6,11);
					cIcon.infoWindowAnchor = new GPoint(5, 1);
					markerOptions = { icon:cIcon};
					var marker = new GMarker(point, markerOptions);
					GEvent.addListener(marker, "mouseover", function() {
					  marker.openInfoWindowHtml(html);
      			  });
					GEvent.addListener(marker, "click", function() {
					GetIncidentInfo(srno);
					map.setCenter(new GLatLng(lat,lon),9);
		         marker.openInfoWindowHtml(html);
      		  });
        			gmarkers[i] = marker;
        			htmls[i] = html;
        			side_bar_html += '<a href="javascript:myclick1(' + i + ','+lat+','+lon+','+srno+')" class="bodyText" onMouseOver="javascript:myclick(' + i + ','+lat+','+lon+')" >' + name + '</a><br>';
					i++;
        			return marker;
      			}
      			function myclick(i,lat, lon) 
      			{
						map.setCenter(new GLatLng(lat,lon));
        				gmarkers[i].openInfoWindowHtml(htmls[i]);
      			}
      			function myclick1(i,lat, lon,srno) 
      			{
      				GetIncidentInfo(srno);
						map.setCenter(new GLatLng(lat,lon));
        				gmarkers[i].openInfoWindowHtml(htmls[i]);
      			}
      			
          <%
				try
				{
					String latitude,longitude,html,vehregno,VehDetails,VehDetails1,vehid,showdatex,yearold,thisyear;
					int fatality;					
					Class.forName(MM_dbConn_DRIVER);
					conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
					st=conn.createStatement();
					st1=conn.createStatement();
					st2=conn.createStatement();
					stquery=conn.createStatement();
					sql="select * from yearlyinfo1 where latt <>'' and longg <>'' and latt <>'-' and longg <>'-' order by AccDate desc";
					ResultSet rst=st.executeQuery(sql);
					int x=1;
					yearold ="old"; 
					while(rst.next())
					{
							fatality=0;
							thisyear=""+(rst.getDate("AccDate").getYear()+1900);
							latitude=rst.getString("latt");
							longitude=rst.getString("longg");
							VehDetails="Incident "+x;
							vehid=rst.getString("SrNo");
							try{
								fatality=fatality+rst.getInt("WorkForceFacility");
							}
							catch(Exception ee)
							{
							}
							try{
								fatality=fatality+rst.getInt("ThirdPartyFacility");
							}
							catch(Exception ee)
							{
							}
							x++;
							VehDetails1=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("AccDate"))+" "+rst.getString("time")+"  "+rst.getString("TransporterNM");
							%>
							side_bar_html +='<% if(!thisyear.equals(yearold)) { out.print("<font color=red size=2 >"+thisyear+"</font><br>"); yearold=thisyear; }%>';
							var point1 = new GLatLng(<%= latitude%>,<%= longitude%>);
							var marker = createMarker(point1,"<%= VehDetails%>","<div class='bodyText'><%= VehDetails1%></div>",<%= latitude%>,<%= longitude%>,<%=vehid%>,<%=fatality%>);
      					map.addOverlay(marker);
								
				    <%      
					}          
				}catch(Exception e)
				{
					%>
					alert("hi there is error on page <%=e%>");					
					<%
					
				}
				finally
				{
					conn.close();
				}          
          %>
          // put the assembled side_bar_html contents into the side_bar div
          document.getElementById("side_bar").innerHTML = side_bar_html;
          
    }

    else {
      alert("Sorry, the Google Maps API is not compatible with this browser");
    }

     //]]>
    </script>

<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>