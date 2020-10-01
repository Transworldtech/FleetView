<%@ include file="airtelheader.jsp" %>
 <%@ page import="kml.KML1" %>
<%
classes fleetview=new classes(); 
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

%>

<%@page import="com.fleetview.beans.classes"%>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    </head>
    
    <script src="http://maps.google.com/maps?file=api&amp;v=3&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<!--<script src="http://maps.google.com/maps?api/js?sensor=false" type="text/javascript"></script>-->
<!-- you can use tables or divs for the overall layout -->
<!-- changes 6th sep 2010-->
<%! 
Connection conn,conn1,con;
Statement st,st1,st2,st3,st4,st5,stAC,stDisconn;
String sql,sql1,sql2,sql3,sql4,sql5,sqlware,data1,data2,vehcode,location,Stamp,label1,html1,html2,html11,html22,d1,d2,t1,t2,time1,time2,fromtime,totime,ftime1,ftime2,ttime1,ttime2;
String thedate="",thedate1="",thetime="",thetime1="",vehregno="",ownername="",lastlocation="",startplace,endplace,enddate,sdate1,enddate1,stopdatetime, startdatetime,latStart="",longStart="",locationStart="",thedateStart="",thetimeStart="",firstlocation="-",location1="-";
String mydate1="",mydate2="";
double lat, lat1, lon, lon1,latw,longw,latw1,longw1,lat11,lon11;
int show,dist;
%>
<%
System.out.println("ok i am here---1");
vehcode=request.getParameter("vehcode");
String fromPage=request.getParameter("pg");

data1=request.getParameter("data");
data2=request.getParameter("data1");
System.out.println("data1--"+data1+" data2--"+data2);

try{
	data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
	data2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data2));
	System.out.println("data1-->"+data1+" data2-->"+data2);
	}catch(Exception e)
	{
		//System.out.println("inside catch");
		e.printStackTrace();
		/*data1=data1;
		data2=data2;*/
	}
	
	mydate1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1));

	mydate2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));

	session.setAttribute("hdate1",data1);
	session.setAttribute("hdate2",data2);
	session.setAttribute("hvid",vehcode);
	
	try
	{
	     con = fleetview.ReturnConnection();
		st=con.createStatement();
		
	}
	catch(Exception e)
	{
		System.out.println("====>error in connection");
		e.printStackTrace();
	}
	
	String vehreg="";
	String sqlvehreg="select * from t_vehicledetails where VehicleCode='"+vehcode+"'";
	ResultSet rstveh=st.executeQuery(sqlvehreg);
	if(rstveh.next())
	{
		vehreg=rstveh.getString("VehicleRegNumber");
		//System.out.println("VehicleRegNumber====>");
	}
	
	String n="null";
	%>
	
	<table border="1" bgcolor="white" align="center" width="100%">
<tr>
<td colspan="2">
<table width="100%" align="center" >
			<tr>
			<td align="center">
			<!-- <div align="left"><font size="3" >Report No: 1.10</font></div>-->
			<font  size="3" ><b>Journey On Map</b></font></td>
			</tr>
			<tr>
			<td align="center"><h2><b>The Report for Vehicle Reg. No.<%=vehreg %> From Date <%=mydate1 %> To <%=mydate2 %></b></h2></td>
			</tr>
			</table>
			</td>
			</tr>
			<tr>
	        <td width="20%" valign="top">
		    <table width="100%" border="1" class="stats" valign="top">
		    <tr><td class="hed" colspan="3"><img src="images/mm_20_green.png" align="left"> Last Location</td><!--<td colspan="2"><div id="lastloc11"></div></td>--></tr>
			<tr><td class="hed" colspan="3"><img src="images/mm_20_black.png" align="left"> Start Location </td><!--<td><div id="strtloc11"></div></td>--></tr>
			
			</table>
           <!-- =========== side_bar with scroll bar ================= -->
 
				<div id="side_bar"  style="overflow:auto; height:390px;" align="left" ></div>
           <!-- ===================================================== -->	
			</td>
	
<td>
<div id="map" style=" height:650px"></div>
       <!--<div id="map" style="width: 1150px; height: 650px"></div>-->
</td>
</tr>

</table>
    



    <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>
    
    <script type="text/javascript"><!--
    //<![CDATA[
    
    <%
try
{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=conn.createStatement();
	st2=conn.createStatement();
	st5=conn.createStatement();
	stDisconn=conn.createStatement();
	Class.forName(MM_dbConn_DRIVER); 
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	stAC=conn1.createStatement();

}catch(Exception e)
{
	out.print("Exception "+e);
}

String wareHouseCode="-",wareHouse="-",owner="-",html1=null,wtype="-",PolygonCoordinates="-";
String rfname=session.getAttribute("rfname").toString(); //user name  //.setAttribute("rfname",fnamelist);
String rlname=session.getAttribute("rlname").toString();
String getCordiantesSql="",getCordiantesSql1="";
ResultSet rs2=null,rs22=null; 
String vehRegNo="";
String strtplace="", endplace="", strtLat="",endLat="",strtLong="",endLong="",strtcode="",endcode="",stCodeList="(",endCodeList="(";
/*
String sqltrp="select * from t_startedjourney where TripID='"+tripid+"'";
ResultSet rstrp=st.executeQuery(sqltrp);
if(rstrp.next())*/

String fwUser = (String) session.getAttribute("user");
String savedCoordiantes = "";

%>

	var side_bar_html = "";
	var side_bar_html1 = "";
	var str;	
	var gmarkers = [];
	var gmarkerdis = [];
	var htmls = [];
	var htmldis = [];
	var i = 0;dis=0;

	var degreesPerRadian = 180.0 / Math.PI;
	var arrowIcon = new GIcon();
arrowIcon.iconSize = new GSize(12,12);
arrowIcon.shadowSize = new GSize(1,1);
arrowIcon.iconAnchor = new GPoint(6,6);
arrowIcon.infoWindowAnchor = new GPoint(0,0);
//var dir="/home/shweta/Desktop/11634188xyz.kml";
	var map = new GMap2(document.getElementById("map"));
	
	//var geoXml = new GGeoXml(dir); 

	      	
	
map.setCenter(new GLatLng(18.80,80.1),7);
map.addControl(new GMapTypeControl(1));
map.enableScrollWheelZoom();
map.addControl(new GSmallMapControl());
map.addControl(new GScaleControl());

function createMarker2(point,name,html,lat,lon){
	try{
	var cIcon = new GIcon();
//	alert("in create marker 2");
	//we have to insert black img  here..... coz it is overlapping
		cIcon.image = 'images/mm_20_black.png';
	
//	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize (20,25);
	cIcon.shadowSize = new GSize(22, 20);
	cIcon.iconAnchor = new GPoint(6, 20);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
//alert(lat);
//alert(lon);
	var marker = new GMarker(point, markerOptions);
	//var marker = new GMarker(point);
    GEvent.addListener(marker, "click", function() {
	map.setCenter(new GLatLng(lat,lon),9);
    marker.openInfoWindowHtml(html);
    });
  	GEvent.addListener(marker, "mouseover", function() {
	//map.setCenter(new GLatLng(lat,lon),9);
    marker.openInfoWindowHtml(html);
    });
  	gmarkers[i] = marker;
	htmls[i] = html;
	//side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
	i++;
		map.setCenter(new GLatLng(lat,lon));
	return marker;
	}catch(e)
	{
		alert(e);
	}
  }

function createMarker(point,name,html,lat,lon){
	try
	{
	var cIcon = new GIcon();
	//we have to insert black img  here..... coz it is overlapping
		cIcon.image = 'images/mm_20_green.png';
		cIcon.shadow = 'images/mm_20_shadow.png';
//	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize (20,25);
	cIcon.shadowSize = new GSize(22, 20);
	cIcon.iconAnchor = new GPoint(6, 20);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};

	var marker = new GMarker(point, markerOptions);
	//var marker = new GMarker(point);
    GEvent.addListener(marker, "click", function() {
	map.setCenter(new GLatLng(lat,lon),9);
    marker.openInfoWindowHtml(html);
    });
  	GEvent.addListener(marker, "mouseover", function() {
	//map.setCenter(new GLatLng(lat,lon),9);
    marker.openInfoWindowHtml(html);
    });
  	gmarkers[i] = marker;
	htmls[i] = html;
	//side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
	i++;
		map.setCenter(new GLatLng(lat,lon));
	return marker;
	}catch(e)
	{
		alert(e);
	}
  }

function zoomtoloc(i,lat,lon) 
{
   	
        	map.setCenter(new GLatLng(lat,lon),15);
       	//gmarkers[i].openInfoWindowHtml(htmls[i]);
	   
 }

<%
try
{ 

String stamp;

sql="select * from t_vehicledetails where VehicleCode='"+vehcode+"'";

ResultSet rstx=st.executeQuery(sql);
if(rstx.next())
{
	//System.out.println(sql);
	vehRegNo=rstx.getString("VehicleRegNumber");
Format NewFormatter3 = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
%>
side_bar_html +="<div class='bodyText'><b>Vehicle Reg.No.:<font color='red'> <%=rstx.getString("VehicleRegNumber")%></font> <br>Transporter : <font color='red'><%=rstx.getString("OwnerName")%></font><br>Journey Start date : <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> </font><br>Journey End date :  <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%> </font></b>";
	<%
	session.setAttribute("hvrno",rstx.getString("VehicleRegNumber"));
}

sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist from t_veh"+vehcode+" where TheFieldDataDateTime >='"+data1+" 00:00:00' and TheFieldDataDateTime <='"+data2+" 23:59:59'";

ResultSet rst2=st3.executeQuery(sql);
if(rst2.next())
{
	int startDist=0;
	int endDist=0;
	startDist=rst2.getInt("startdist");
	endDist=rst2.getInt("enddist");
	dist=endDist-startDist;
	
	if(dist > 0)
	{
	%>
		side_bar_html  "<div class='bodyText'><b>Total Distance Travelled: </b><font color='red' size='2'><%=dist%></font> km.</div>";
	<%
	}
	else
	{
	%>
	side_bar_html +="<div class='bodyText' size='3' align='center'><font color='red'>No Records.</font></div>";
	<%
	}
}

//code to draw the first loc
/*---------------------------------change:- TheFiledTextFileName IN('SI','OF') removed from query---------------------------*/
int OScount=0,ACcount=0,DCcount=0,STcount=0,DisconnCount=0;
String file="";
String color="ffFA8B0C"; //blue
HashMap<String, String> coordinateMap = null;
HashMap<String, String> coordinateMapStart = null;
HashMap<String, String> coordinateMapEnd = null;
List<HashMap<String, String>> coordinateList = null;
boolean flag1;
coordinateList=new ArrayList<HashMap<String, String>>();
String sql12="";
Double startdist=0.0,enddist=0.0;

sql12="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" 00:00:00' and TheFieldDataDateTime <='"+data2+" 23:59:59'  order by TheFieldDataDateTime asc";
			
System.out.println("sql start loc====>"+sql12);
ResultSet rst12=st.executeQuery(sql12);
if(rst12.next())
{
	System.out.println("Hii");
	try{
	startdist=rst12.getDouble("Distance");
    coordinateMapStart =  new java.util.HashMap<String, String>();
    coordinateMapStart.put("name",rst12.getString("TheFieldSubject"));
    coordinateMapStart.put("desc", rst12.getString("TheFieldSubject"));
    coordinateMapStart.put("lat",rst12.getString("LatinDec")); 
    coordinateMapStart.put("longi",rst12.getString("LonginDec"));  
//   	System.out.println("MapStart----------"+coordinateMapStart.get("lat")+","+coordinateMapStart.get("longi"));
	
	lat=rst12.getDouble("LatinDec");
	lon=rst12.getDouble("LonginDec");
	location=rst12.getString("TheFieldSubject");
	System.out.println(lat+","+lon);
	
	String dt1 = new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst12.getString("TheFieldDataDate")));
	html2="<b>Start location:</b><br>"+location+"<br><b>Date Time : </b>"+dt1+" " +rst12.getString("TheFieldDataTime");
%>
//document.getElementById("strtloc11").innerHTML=< %=location%>;
var marker1 = createMarker2(new GLatLng(<%= rst12.getString("LatinDec")%>,<%= rst12.getString("LonginDec")%>),"<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
map.addOverlay(marker1);
<%
	}catch(Exception e)
	{
	     System.out.println("Exception-------------" +e);	
	}
	}

//code to draw line
//int record=1;
/*---------------------------------change:-TheFiledTextFileName ='SI' removed from query---------------------------*/

sql1="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" 00:00:00' and TheFieldDataDateTime <='"+data2+" 23:59:59'  order by TheFieldDataDateTime asc";
System.out.println(sql);
ResultSet rst=st.executeQuery(sql1);
while(rst.next())
{ /**********record is added for- if no data then it will not come in while loop and willnot get ++ then not to show start point*************/
	System.out.println("Hii");
	 coordinateMap =  new java.util.HashMap<String, String>();
     coordinateMap.put("name",rst.getString("TheFieldSubject"));
     coordinateMap.put("desc", rst.getString("TheFieldSubject"));
     coordinateMap.put("lat",rst.getString("LatinDec")); 
     coordinateMap.put("longi",rst.getString("LonginDec"));                         
     coordinateList.add(coordinateMap);
//      System.out.println("Coordlist----------"+coordinateMap.get("lat")+","+coordinateMap.get("longi"));

%>
<%

}

/***********COde for find lasst location***************/

String sql11="";
sql11="select * from t_veh"+ vehcode +" where TheFieldDataDateTime>='"+data1+" 00:00:00' and TheFieldDataDateTime <='"+data2+" 23:59:59'  order by TheFieldDataDateTime desc";
System.out.println("sql last loc====>"+sql11);
ResultSet rst11=st.executeQuery(sql11);
if(rst11.next())
{
	//System.out.println("1038 Hii");
	enddist=rst11.getDouble("Distance");
    coordinateMapEnd =  new java.util.HashMap<String, String>();
    coordinateMapEnd.put("name",rst11.getString("TheFieldSubject"));
    coordinateMapEnd.put("desc", rst11.getString("TheFieldSubject"));
    coordinateMapEnd.put("lat",rst11.getString("LatinDec")); 
    coordinateMapEnd.put("longi",rst11.getString("LonginDec"));   
 //   System.out.println("MapEnd----------"+coordinateMapEnd.get("lat")+","+coordinateMapEnd.get("longi"));
	
	lat=rst11.getDouble("LatinDec");
	lon=rst11.getDouble("LonginDec");
	System.out.println(lat);
	System.out.println(lon);
	location=rst11.getString("TheFieldSubject");
	
	String dt = new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst11.getString("TheFieldDataDate")));
	html1="<b>Last location:</b><br>"+location+"<br><b>Date Time : </b>"+dt+" " +rst11.getString("TheFieldDataTime");
 
	//System.out.println("1055 Hii");
	%>
	var point1 = new GLatLng(<%= rst11.getString("LatinDec")%>,<%= rst11.getString("LonginDec")%>);
	var marker = createMarker(point1,"<div class='bodyText'><%= html1%></div>","<div class='bodyText'><%= html1%></div>", <%= rst11.getString("LatinDec")%>,<%= rst11.getString("LonginDec")%>);
	map.addOverlay(marker);
<%
}

////////////////////////////////////////////////////////////////////////////////////////

/*-----------------------------generate kml----------------------------*/
	String dir=request.getRealPath("/");
 System.out.println("KML path===========>");

 dir=dir+"KML/"+"kml_"+vehcode+".kml";		//for creating kml file on server
 
 KML1 kml=new KML1();
	System.out.println("438" +coordinateList);
	flag1=kml.generateKMLFORLINE(coordinateList,dir,coordinateMapStart,coordinateMapEnd,color);

	%>
		//GGeoXml caches KML files at Google's servers for some time. 
		//You can avoid that by applying some cache-busting dummy parameter to the URL you specify.
		//so the updated kml file loads on the map 
//	var geoXml = new GGeoXml("http://myfleetview.com/FleetView/KML/kml_"+tripid+".kml?date="+new Date().getTime());

	var filename="<%=vehcode%>";
	var frmPage="<%=fromPage%>";

/*	var gx = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/RTJohnDeeretoRamwadi.kml");
	map.addOverlay(gx);
	var gx2 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/RTPalaspetoJNPT.kml");
	map.addOverlay(gx2);
	var gx4 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/RTShedungAsudgaon.kml");
	map.addOverlay(gx4);	
	var gx6 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/RTSILVASSAToBhilad.kml");
	map.addOverlay(gx6);
	var gx7 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Kolkata-Guwahati.kml");
	map.addOverlay(gx7);
	var gx8 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Patalganga-Hydrabad.kml");
	map.addOverlay(gx8);
	var gx9 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Patalganga-Delhi.kml");
	map.addOverlay(gx9);
	var gx10 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Mumbai-Chennai.kml");
	map.addOverlay(gx10);
	var gx11 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Patalganga-Banglore.kml");
	map.addOverlay(gx11);
	var gx12 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/PatalgangaSilvasa1.kml");
	map.addOverlay(gx12);
	var gx13 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Baragora-Jamshedpur.kml");
	map.addOverlay(gx13);
	var gx14 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Paharpur-Jungalpur.kml");
	map.addOverlay(gx14);
	var gx15 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/BhivandiToJohndere.kml");
	map.addOverlay(gx15);
	var gx16 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Delhi-Rajpua.kml");
	map.addOverlay(gx16);
	var gx17 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Rajpua-Parwanoo.kml");
	map.addOverlay(gx17);
	var gx18 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Cahndigad-Rajpua.kml");
	map.addOverlay(gx18);
*/

	var url="http://myfleetview.com/FleetView-spring/KML/kml_"+filename+".kml?date="+new Date().getTime();
	var geoXml = new GGeoXml(url, function() {
   // alert("Loaded: " + geoXml.hasLoaded());
  	if (geoXml.loadedCorrectly()) {
  		geoXml.gotoDefaultViewport(map);
    }else {
      // alert("Not Load Properly");
    }
	});

	map.addOverlay(geoXml);
	//alert("map");	
	<%
}

catch(Exception ex)
{
	//System.out.println("Exception--"+ex);
	ex.printStackTrace();%>  <%
}
finally
{
	try
	{
		conn.close();	
	}catch(Exception e)
	{}
	try
	{
		conn1.close();	
	}catch(Exception e)
	{}
	try
	{
		con.close();	
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}


%>
document.getElementById("side_bar").innerHTML = side_bar_html;

     //]]>
    </script>
    
<%//fleetview.closeConnection();
%>
<%@ include file="footernew.jsp" %>
</html>
	



	


