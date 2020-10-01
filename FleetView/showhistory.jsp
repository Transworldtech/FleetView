<%@ include file="Connections/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
<head>
<title>Vehicle Tracking System </title>
<link href="common/genomics.css" rel="StyleSheet" type="text/css">
<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>

<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
</head>
<body onunload="GUnload()"  bgcolor="#FFE4E1">
<p></p>

  <!-- you can use tables or divs for the overall layout -->
<table border="1" bgcolor="white" align="center">
<tr><td colspan="2"><a href='detail_report.jsp?vehcode=<%=request.getParameter("vehcode")%>'>Detail Report</a></td></tr>
    <tr>
        
        
<td width="20%" valign="top">
	
           <!-- =========== side_bar with scroll bar ================= -->
 
<div id="side_bar"  style="overflow:auto; height:550px;" align="left" ></div>
           <!-- ===================================================== -->	
	
</td>
	
<td  valign="top">
       <div id="map" style="width: 600px; height: 550px"></div>
</td>
      </tr>
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
<%! 
Connection conn;
Statement st,st1,st2,st3,st4;
String sql,sql1,sql2,sql3,sql4,data1,data2,vehcode,location,Stamp,label1,html1,d1,d2,t1,t2;
double lat, lat1, lon, lon1;
int show,dist;
%>
<%
try
{
	vehcode=request.getParameter("vehcode");
	java.util.Date NewDate =new java.util.Date();
	Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Format NewFormatter2 = new SimpleDateFormat("yyyy-MM-dd");
	data2 = NewFormatter1.format(NewDate);
	d2=NewFormatter2.format(NewDate);
	long dateMillis = NewDate.getTime();
	long dayInMillis = 1000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);

	data1 = NewFormatter1.format(NewDate);
	d1=NewFormatter2.format(NewDate);
	session.setAttribute("hvid",vehcode);
	session.setAttribute("fff",data1);
	session.setAttribute("ttt",data2);
	session.setAttribute("hdate1",d1);
	session.setAttribute("hdate2",d2);
	
	//out.print(data1+"<br>"+data2);
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=conn.createStatement();

}catch(Exception e)
{
	out.print("Exception -->"+e);
}

%>
   	var side_bar_html = "";
     	var side_bar_html1 = "";
      	var str;	
      	var gmarkers = [];
      	var htmls = [];
      	var i = 0;
      	var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(18.80,80.1),8);
	map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());
function createMarker(point,name,html,stamp,lat,lon) {
	var cIcon = new GIcon();
	if(stamp=="OS")
	{
	cIcon.image = 'images/mm_20_red.png';
	}
	if(stamp=="ST")
	{
	cIcon.image = 'images/mm_20_white.png';
	}
	if(stamp=="AC")
	{
	cIcon.image = 'images/mm_20_blue.png';
	}
	if(stamp=="DC")
	{
	cIcon.image = 'images/mm_20_yellow.png';
	}
	if(stamp=="SI")
	{
	cIcon.image = 'images/mm_20_green.png';
	}
	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize(12,20);
	cIcon.shadowSize = new GSize(22, 20);
	cIcon.iconAnchor = new GPoint(6, 20);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
	
	
        var marker = new GMarker(point, markerOptions);
        GEvent.addListener(marker, "mouseover", function() {
        marker.openInfoWindowHtml(html);
        });
	gmarkers[i] = marker;
        htmls[i] = html;
        side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
        i++;
     map.setCenter(new GLatLng(lat,lon));
        return marker;
      }

      function myclick(i,lat,lon) {
	map.setCenter(new GLatLng(lat,lon));
        gmarkers[i].openInfoWindowHtml(htmls[i]);
      }

<%
try
{
	sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist from t_veh"+vehcode+" where TheFieldDataDateTime >='"+data1+"' and TheFieldDataDateTime <='"+data2+"' and TheFiledTextFileName ='SI'";
	ResultSet rst2=st3.executeQuery(sql);
	if(rst2.next())
	{
		dist=rst2.getInt("enddist")-rst2.getInt("startdist");
		if(dist > 0)
		{
		%>
			side_bar_html +="<div class='bodyText'><b>Total Distance Travelled: </b><font color='red' size='2'><%=dist%></font> km.</div>";
		<%
		}
		else
		{
		%>
		side_bar_html +="<div class='bodyText' size='3' align='center'><font color='red'>NO DATA.</font></div>";
		<%
		}
	}
	sql="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+"' and TheFieldDataDateTime <='"+data2+"' and TheFiledTextFileName ='SI' order by TheFieldDataDateTime desc";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		lat=rst.getDouble("LatinDec");
		lon=rst.getDouble("LonginDec");
		location=rst.getString("TheFieldSubject");
		html1="<b>Last location:</b><br>"+location;
		%>
	var point1 = new GLatLng(<%= lat%>,<%= lon%>);
	var marker = createMarker(point1,"<div class='bodyText'><%= html1%></div>","<div class='bodyText'><%= html1%></div>","SI",<%= lat%>,<%= lon%>);
     	 map.addOverlay(marker);


		<%
	}
	while(rst.next())
	{
		lat1=rst.getDouble("LatinDec");
		lon1=rst.getDouble("LonginDec");
		
	//code to drow the line.
	if(lat-lat1 >0.00005 || lon-lon1 >0.00005 ||lat1-lat >0.00005 || lon1-lon >0.00005  )
	{
	%> 
	var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);
	map.addOverlay(polyline);

	<%
	}
	lat=lat1;
	lon=lon1;
	}//while to drow the line.
//code for OS, RA, RD.
sql1="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+"' and TheFieldDataDateTime <='"+data2+"' and TheFiledTextFileName in ('OS','AC','DC') order by TheFieldDataDateTime asc";
ResultSet rst1=st1.executeQuery(sql1);
while(rst1.next())
{
	lat = rst1.getDouble("LatinDec"); 
	lon = rst1.getDouble("LonginDec"); 
	location= rst1.getString("TheFieldSubject");
	Stamp=rst1.getString("TheFiledTextFileName");
	show=1;
	if (Stamp.equals("OS"))
	{

	label1="<b>OS</b><br> "+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")+  " Speed " +rst1.getString("Speed")+" Duration " + rst1.getString("Distance") + " Sec." ;
	}
	if (Stamp.equals("AC"))
	{
	if (rst1.getInt("Distance")>5)
	{
	label1="<b>AC </b><br>"+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")+  " Speed from " +rst1.getString("Distance")+" To " + rst1.getString("Speed")  ;
	}
	else
	{
	show=0;
	}
	}
	
if (Stamp.equals("DC"))
	{
	if (rst1.getInt("Distance")<120)
	{
	label1="<b>DC</b><br> "+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")+  " Speed from " +rst1.getString("Distance")+" To " + rst1.getString("Speed")  ;
	}
	else
	{
	show=0;
	}
	}
if (Stamp.equals("ST"))
	{
	label1="Start at "+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")  ;
	}
	
if (Stamp.equals("SP"))
	{
	label1="Stop at "+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")  ;
	}
html1=label1;
	if (show==1)
	{
	
	   
%> 
      	var point1 = new GLatLng(<%= lat%>,<%= lon%>);
	var marker = createMarker(point1,"<div class='bodyText'><%= html1%></div>","<div class='bodyText'><%= html1%></div>","<%=Stamp%>",<%= lat%>,<%= lon%>);
     	 map.addOverlay(marker);

	<%
	}

}//code to put markers on map
}catch(Exception ex)
{
	%> alert("Exception --><%=ex%>"); <%
}
finally
{
	conn.close();
}
%>
 document.getElementById("side_bar").innerHTML = side_bar_html;

     //]]>
    </script>

</body>
</html>
