<%@ include file="headernew.jsp" %>

<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<script src="elabel.js" type="text/javascript"></script>
<script language="javaScript">
function ajaxFunction(xx)
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
                	//alert(reslt);
                	//documnet.getElementById("reportdiv").style.display="block";
                	document.getElementById("side_bar").innerHTML=reslt;
                	//document.getElementById("side_bar").style.display="none";
		}
	}
if(xx==1)
{
ajaxRequest.open("GET", "hos.jsp", true);
}
if(xx==2)
{
ajaxRequest.open("GET", "hra.jsp", true);
}
if(xx==3)
{
ajaxRequest.open("GET", "hrda.jsp", true);
}
if(xx==4)
{
ajaxRequest.open("GET", "hrst.jsp", true);
}
if(xx==5)
{
ajaxRequest.open("GET", "hrnd.jsp", true);
}
ajaxRequest.send(null); 
}
</script>
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
<style type="text/css">
.mydiv {

    cursor: w-resize;

}
</style>
<%
String userID1 = "";
if (! session.isNew()) 
userID1 = (String) session.getAttribute("user");
if (null == userID1) 
	{
		response.sendRedirect("index.html");
	}
else
	{

%>
<%! 
	Connection con,con1,conn00;
	double latx, latx1, lonx, lonx1;
	String fidDate1,fidDate2,fromtime1,fromtime2,totime1,totime2,fff,ttt;
	int i;
%>
<%
fromtime1=request.getParameter("fromtime1");
//System.out.println("Fromtime1::>>"+fromtime1);
fromtime2=request.getParameter("fromtime2");
//System.out.println("Fromtime2::>>"+fromtime2);
totime1=request.getParameter("totime1");
//System.out.println("Totime1::>>"+totime1);
totime2=request.getParameter("totime2");
//System.out.println("Totime2::>>"+totime2);
fidDate1=request.getParameter("calender");
//System.out.println("FidDate1::>>"+fidDate1);
fidDate2=request.getParameter("calender1");
//System.out.println("FidDate2::>>"+fidDate2);
session.setAttribute("fromtime1",fromtime1);
session.setAttribute("fromtime2",fromtime2);
session.setAttribute("totime1",totime1);
session.setAttribute("totime2",totime2);
fff=fromtime1+":"+fromtime2+":00";
ttt=totime1+":"+totime2+":00";
session.setAttribute("fff",fff);
session.setAttribute("ttt",ttt);
%>
<div id="hh"></div>

<!-- Code added by Atul date 11th may 2008 -->
<%
if(request.getParameter("mode").equals("history"))
{
%>
<form action="MainformMap2.jsp" method="post" name="form1">
<table border="1" width="100%">
<tr><td><table border="0" width="100%" bgcolor="white">
<tr>
<td class="bodyText">
<input type="hidden" name="mode" value='<%=request.getParameter("mode")%>'>
<input type="hidden" name="rvehid" value='<%=request.getParameter("rvehid")%>'>
From Date :  <input type="text" id="calender" name="calender" size="10" class="formElement" value="<%=fidDate1%>" readonly/>
HH :<select name="fromtime1" class="formElement">
<option value="00" <%if(fromtime1.equalsIgnoreCase("00")){ %> Selected <%} %>>00</option>
		<option value="01" <%if(fromtime1.equalsIgnoreCase("01")){ %> Selected <%} %>>01</option>
		<option value="02" <%if(fromtime1.equalsIgnoreCase("02")){ %> Selected <%} %>>02</option>
		<option value="03" <%if(fromtime1.equalsIgnoreCase("03")){ %> Selected <%} %>>03</option>
		<option value="04" <%if(fromtime1.equalsIgnoreCase("04")){ %> Selected <%} %>>04</option>
		<option value="05" <%if(fromtime1.equalsIgnoreCase("05")){ %> Selected <%} %>>05</option>
		<option value="06" <%if(fromtime1.equalsIgnoreCase("06")){ %> Selected <%} %>>06</option>
		<option value="07" <%if(fromtime1.equalsIgnoreCase("07")){ %> Selected <%} %>>07</option>
		<option value="08" <%if(fromtime1.equalsIgnoreCase("08")){ %> Selected <%} %>>08</option>
		<option value="09" <%if(fromtime1.equalsIgnoreCase("09")){ %> Selected <%} %>>09</option>
	<option value="10" <%if(fromtime1.equalsIgnoreCase("10")){ %> Selected <%} %>>10</option>
<option value="11" <%if(fromtime1.equalsIgnoreCase("11")){ %> Selected <%} %>>11</option>
<option value="12" <%if(fromtime1.equalsIgnoreCase("12")){ %> Selected <%} %>>12</option>
<option value="13" <%if(fromtime1.equalsIgnoreCase("13")){ %> Selected <%} %>>13</option>
<option value="14" <%if(fromtime1.equalsIgnoreCase("14")){ %> Selected <%} %>>14</option>
<option value="15" <%if(fromtime1.equalsIgnoreCase("15")){ %> Selected <%} %>>15</option>
<option value="16" <%if(fromtime1.equalsIgnoreCase("16")){ %> Selected <%} %>>16</option>
<option value="17" <%if(fromtime1.equalsIgnoreCase("17")){ %> Selected <%} %>>17</option>
<option value="18" <%if(fromtime1.equalsIgnoreCase("18")){ %> Selected <%} %>>18</option>
<option value="19" <%if(fromtime1.equalsIgnoreCase("19")){ %> Selected <%} %>>19</option>
<option value="20" <%if(fromtime1.equalsIgnoreCase("20")){ %> Selected <%} %>>20</option>
<option value="21" <%if(fromtime1.equalsIgnoreCase("21")){ %> Selected <%} %>>21</option>
<option value="22" <%if(fromtime1.equalsIgnoreCase("22")){ %> Selected <%} %>>22</option>
<option value="23" <%if(fromtime1.equalsIgnoreCase("23")){ %> Selected <%} %>>23</option>
</select> 
MM :<select name="fromtime2" class="formElement">
<option value="00" <%if(fromtime2.equalsIgnoreCase("00")){ %> Selected <%} %>>00</option>
<option value="01" <%if(fromtime2.equalsIgnoreCase("01")){ %> Selected <%} %>>01</option>
		<option value="02" <%if(fromtime2.equalsIgnoreCase("02")){ %> Selected <%} %>>02</option>
		<option value="03" <%if(fromtime2.equalsIgnoreCase("03")){ %> Selected <%} %>>03</option>
		<option value="04" <%if(fromtime2.equalsIgnoreCase("04")){ %> Selected <%} %>>04</option>
		<option value="05" <%if(fromtime2.equalsIgnoreCase("05")){ %> Selected <%} %>>05</option>
		<option value="06" <%if(fromtime2.equalsIgnoreCase("06")){ %> Selected <%} %>>06</option>
		<option value="07" <%if(fromtime2.equalsIgnoreCase("07")){ %> Selected <%} %>>07</option>
		<option value="08" <%if(fromtime2.equalsIgnoreCase("08")){ %> Selected <%} %>>08</option>
		<option value="09" <%if(fromtime2.equalsIgnoreCase("09")){ %> Selected <%} %>>09</option>
<%
int ftt1=Integer.parseInt(fromtime2);
for(i=10;i<60;i++)
{
%>
<option value='<%=i%>' <%if(ftt1==i){%> Selected <%} %>><%=i%></option>
<%
}
%>
</select>
<!--  <img src="images/calendar.png" id="trigger" >-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "calender",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "calender"       // ID of the button
    }
  );
</script>
</td>
<td class="bodyText">

To Date :  <input type="text" id="calender1" name="calender1" size="10" class="formElement" value="<%=fidDate2%>" readonly/>
HH :<select name="totime1" class="formElement">
<option value="01" <%if(totime1.equalsIgnoreCase("01")){ %> Selected <%} %>>01</option>
		<option value="02" <%if(totime1.equalsIgnoreCase("02")){ %> Selected <%} %>>02</option>
		<option value="03" <%if(totime1.equalsIgnoreCase("03")){ %> Selected <%} %>>03</option>
		<option value="04" <%if(totime1.equalsIgnoreCase("04")){ %> Selected <%} %>>04</option>
		<option value="05" <%if(totime1.equalsIgnoreCase("05")){ %> Selected <%} %>>05</option>
		<option value="06" <%if(totime1.equalsIgnoreCase("06")){ %> Selected <%} %>>06</option>
		<option value="07" <%if(totime1.equalsIgnoreCase("07")){ %> Selected <%} %>>07</option>
		<option value="08" <%if(totime1.equalsIgnoreCase("08")){ %> Selected <%} %>>08</option>
		<option value="09" <%if(totime1.equalsIgnoreCase("09")){ %> Selected <%} %>>09</option>
	<option value="10" <%if(totime1.equalsIgnoreCase("10")){ %> Selected <%} %>>10</option>
<option value="11" <%if(totime1.equalsIgnoreCase("11")){ %> Selected <%} %>>11</option>
<option value="12" <%if(totime1.equalsIgnoreCase("12")){ %> Selected <%} %>>12</option>
<option value="13" <%if(totime1.equalsIgnoreCase("13")){ %> Selected <%} %>>13</option>
<option value="14" <%if(totime1.equalsIgnoreCase("14")){ %> Selected <%} %>>14</option>
<option value="15" <%if(totime1.equalsIgnoreCase("15")){ %> Selected <%} %>>15</option>
<option value="16" <%if(totime1.equalsIgnoreCase("16")){ %> Selected <%} %>>16</option>
<option value="17" <%if(totime1.equalsIgnoreCase("17")){ %> Selected <%} %>>17</option>
<option value="18" <%if(totime1.equalsIgnoreCase("18")){ %> Selected <%} %>>18</option>
<option value="19" <%if(totime1.equalsIgnoreCase("19")){ %> Selected <%} %>>19</option>
<option value="20" <%if(totime1.equalsIgnoreCase("20")){ %> Selected <%} %>>20</option>
<option value="21" <%if(totime1.equalsIgnoreCase("21")){ %> Selected <%} %>>21</option>
<option value="22" <%if(totime1.equalsIgnoreCase("22")){ %> Selected <%} %>>22</option>
<option value="23" <%if(totime1.equalsIgnoreCase("23")){ %> Selected <%} %>>23</option>
</select>
 
MM :<select name="totime2" class="formElement">
<option value="00" <%if(totime2.equalsIgnoreCase("00")){ %> Selected <%} %>>00</option>
<option value="01" <%if(totime2.equalsIgnoreCase("01")){ %> Selected <%} %>>01</option>
<option value="02" <%if(totime2.equalsIgnoreCase("02")){ %> Selected <%} %>>02</option>
		<option value="03" <%if(totime2.equalsIgnoreCase("03")){ %> Selected <%} %>>03</option>
		<option value="04" <%if(totime2.equalsIgnoreCase("04")){ %> Selected <%} %>>04</option>
		<option value="05" <%if(totime2.equalsIgnoreCase("05")){ %> Selected <%} %>>05</option>
		<option value="06" <%if(totime2.equalsIgnoreCase("06")){ %> Selected <%} %>>06</option>
		<option value="07" <%if(totime2.equalsIgnoreCase("07")){ %> Selected <%} %>>07</option>
		<option value="08" <%if(totime2.equalsIgnoreCase("08")){ %> Selected <%} %>>08</option>
		<option value="09" <%if(totime2.equalsIgnoreCase("09")){ %> Selected <%} %>>09</option>
	
<%
int ftt2=Integer.parseInt(totime2);
for(i=10;i<60;i++)
{
%>
<option value='<%=i%>' <%if(ftt2==i){ %> Selected <%} %>><%=i%></option>
<%
}
%>

</select>
<!--<img src="images/calendar.png" id="trigger1" >-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "calender1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",    // the date format
      button      : "calender1"       // ID of the button
    }
  );
</script>
</td>
<td>
<input type="submit" name="submit" value="submit" class="formElement">
</td>
</tr>
</table>
</td></tr></table>
</form>
<%
}
%>
<!-- Code added by Atul date 11th may 2008 -->
<table border="1" width="100%" bgcolor="#F0F8FF" >
<tr>
<td id="img" width="25%" valign="top">
<%
if(request.getParameter("mode").equals("history"))
{
	//System.out.println("mode---->history");
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("calender"));
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("calender1"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);

session.setAttribute("HisShowDate",showdate);
session.setAttribute("HisShowDate1",showdate1);

%>

<table width="100%" border="1" class="stats" valign="top">
<tr><td colspan="2" class="bodyText"><font color="red">Journey From <%=session.getAttribute("HisShowDate").toString()%> <%=fromtime1%>:<%=fromtime2%> To <%=session.getAttribute("HisShowDate1").toString()%> <%=totime1%>:<%=totime2%></font></td></tr>
<!--  <tr><th colspan="2">Violations</th></tr>-->
<tr><td class="hed" colspan="2"><img src="images/mm_20_green.png" align="left"> Last Location</td></tr>
<tr><td class="hed" colspan="2"><img src="images/mm_20_black.png" align="left"> Start Location</td></tr>
<tr><td class="hed"><img src="images/mm_20_red.png" align="left"> Over Speed </td><td><a href='javascript:ajaxFunction(1);'><div id="os"></div></a></td></tr>
<tr><td class="hed"><img src="images/mm_20_blue.png" align="left"> Rapid Acceleration </td><td><a href='javascript:ajaxFunction(2);'><div id="ra"></div></a></td></tr>
<tr><td class="hed"><img src="images/mm_20_yellow.png" align="left"> Rapid Deceleration </td><td><a href='javascript:ajaxFunction(3);'><div id="rda"></div></a></td></tr>
<tr><td class="hed"><img src="images/mm_20_white.png" align="left"> Stop Location </td><td><a href='javascript:ajaxFunction(4);'><div id="st"></div></a></td></tr>
<tr><td class="hed"><img src="images/nightDriving.png" align="left"> Night Driving </td><td><a href='javascript:ajaxFunction(5);'><div id="nd">No</div></a></td></tr>
</table>
<%
}
%>

<div id="side_bar"  style="overflow:auto; height:500px;" align="left" ></div>
</td>

<td >




<div id="map" style=" height:800px"></div>


</td></tr></table>
    <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>


    <script type="text/javascript">
    //<![CDATA[

    if (GBrowserIsCompatible()) 
	{
    	var degreesPerRadian = 180.0 / Math.PI;
      	var arrowIcon = new GIcon();
        arrowIcon.iconSize = new GSize(12,12);
        arrowIcon.shadowSize = new GSize(1,1);
        arrowIcon.iconAnchor = new GPoint(6,6);
        arrowIcon.infoWindowAnchor = new GPoint(0,0);

      var side_bar_html = "";
      var side_bar_html1 = "";
      var str;	
      var gmarkers = [];
      var htmls = [];
      var i = 0;
	var map = new GMap2(document.getElementById("map"));
      map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());
      // A function to create the marker and set up the event window
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
	if(stamp=="START")
	{
	cIcon.image = 'images/mm_20_black.png';
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
        return marker;
      }


      function createMarker11(point,name,html,lat,lon) {
    		var cIcon = new GIcon();
    		
    		
    		cIcon.image = 'images/mm_20_black.png';
    		
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
    	        return marker;
    	      }

      
function createMarker1(point,name,html,imgname,lat,lon){
	
	var cIcon = new GIcon();
	cIcon.image = 'images/sym_20950.png';
	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize(20,20);
	cIcon.shadowSize = new GSize(10, 10);
	cIcon.iconAnchor = new GPoint(5,5);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
	var marker = new GMarker(point, markerOptions);
	//var marker = new GMarker(point);
         GEvent.addListener(marker, "click", function() {
	map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(html1);
        });
      GEvent.addListener(marker, "mouseover", function() {
	//map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(html);
        });
	return marker;
      }


function createMarker2(point,name,html,lat,lon)
{
	 	var cIcon1 = new GIcon();
		cIcon1.image = '../images/mm_20_blue.png';
		cIcon1.shadow = '../images/mm_20_shadow.png';
		cIcon1.iconSize = new GSize(12,20);
		cIcon1.shadowSize = new GSize(10, 10);
		cIcon1.iconAnchor = new GPoint(16,11);
		cIcon1.infoWindowAnchor = new GPoint(5,1);
		markerOptions = { icon:cIcon1};

		var marker1 = new GMarker(point, markerOptions);
		//var marker = new GMarker(point);
        GEvent.addListener(marker1, "click", function() {
		map.setCenter(new GLatLng(lat,lon),9);
        marker1.openInfoWindowHtml(html);
        });
      	GEvent.addListener(marker1, "mouseover", function() {
		//map.setCenter(new GLatLng(lat,lon),9);
        marker1.openInfoWindowHtml(html);
        });
      	gmarkers[i] = marker1;
        htmls[i] = html;
        side_bar_html += '<div class="bodyText">' + name + '</div></a><hr><br>';
        i++;
		return marker1;
}


function bearing( from, to ) {
	 
    // See T. Vincenty, Survey Review, 23, No 176, p 88-93,1975.
    // Convert to radians.
    var lat1 = from.latRadians();
    var lon1 = from.lngRadians();
    var lat2 = to.latRadians();
    var lon2 = to.lngRadians();

    // Compute the angle.
    var angle = - Math.atan2( Math.sin( lon1 - lon2 ) * Math.cos( lat2 ), Math.cos( lat1 ) * Math.sin( lat2 ) - Math.sin( lat1 ) * Math.cos( lat2 ) * Math.cos( lon1 - lon2 ) );
    if ( angle < 0.0 )
 	angle  += Math.PI * 2.0;
   
    // And convert result to degrees.
    angle = angle * degreesPerRadian;
    angle = angle.toFixed(1);

    return angle;
  }


function arrowHead(px1,px2) {
	  
	  var p1=px1;
    var p2=px2;
    //alert(p1);
    //alert(p2);
    var dir = bearing(p2,p1);
    // == round it to a multiple of 3 and cast out 120s
    var dir = Math.round(dir/8) * 8;
    
    while (dir >= 120) {dir -= 120;}
    // == use the corresponding triangle marker 
    
    arrowIcon.image = "http://www.google.com/intl/en_ALL/mapfiles/dir_"+dir+".png";
    map.addOverlay(new GMarker(p1, arrowIcon));
}


      function myclick(i,lat,lon) {
	map.setCenter(new GLatLng(lat,lon));
        gmarkers[i].openInfoWindowHtml(htmls[i]);
      }

<%
	String fromdate1 = request.getParameter("calender");
	String todate1 = request.getParameter("calender1");
	String CurorHist = request.getParameter("mode");
	String vehid1=request.getParameter("rvehid");
	
	
	
	//out.print(sdate1);
	
	try
	{
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement s = con.createStatement();
Statement s1 = con1.createStatement();
Statement st3=con1.createStatement();
Statement st1=con.createStatement();
Statement st2=con.createStatement();
Statement s11 = con.createStatement();
	//out.println(d);
	String lat="0.0";
	String lon="0.0";
	String lat100="0.0";
	String lon100="0.0";
	java.util.Date thedate100=null;
	String thetime100="";
	String location100="",location1="";
	String vehcode1 = "1";
	String vehid="0";
	String vehregno="0";
	String thedate="",thedate1="",thedate12="";
	String thetime="",thetime1="",thetime12="";
	String location="",location12="";
	String transporter="";
	String lat1="0.0",lat11="0.0",lat12="0.0";
	String lon1="0.0",lon11="0.0",lon12="0.0";
	String mode1="current";
	String fdate1="00-00-00";
	String tdate1="00-00-00";
	
	String tripid="", startdate="",startime="", status="",startplace="",endplace="",enddate="",endtime="";
	int i=0;
if (request.getParameter("rvehid") !=null){vehcode1 = (String)request.getParameter("rvehid");}
	vehid=vehcode1;
	if (request.getParameter("mode") !=null) {mode1 = (String)request.getParameter("mode");}
	if (request.getParameter("calender") !=null) {fdate1 = (String)request.getParameter("calender");}
	if (request.getParameter("calender1") !=null) {tdate1 = (String)request.getParameter("calender1");}


	
	java.util.Date sdate = new java.util.Date();
	long todaymils = sdate.getTime();
	long miliseconds = 60*60*1000*24*7;
	miliseconds = todaymils-miliseconds;
	sdate.setTime(miliseconds);
	Format formatter = new SimpleDateFormat("yyyy-MM-dd"); 
	
	java.util.Date sdate1 = new SimpleDateFormat("yyyy-MM-dd").parse(tdate1);
	long todaymils1 = sdate1.getTime();
	long miliseconds1 = 60*60*1000*24*7;
	miliseconds1 = todaymils1-miliseconds1;
	
	long miliseconds2 = miliseconds-60*60*1000*24*7;
	long miliseconds3 = miliseconds2-60*60*1000*24*7;
	String sql3 = "SELECT VehicleCode,VehicleRegNo,TheDate,TheTime,Location,Transporter,LatitudePosition,LatitudePosition+0.0001 as lat1,LongitudePosition,LongitudePosition+0.0001 as lon1  FROM t_onlinedata where vehiclecode ='" + vehcode1 + "'" ;
	
	ResultSet rs3 = s.executeQuery(sql3);
	while(rs3.next())
	{
	vehid= vehcode1;
	vehregno = rs3.getString("VehicleRegNo"); 
	thedate= rs3.getString("TheDate");
	thetime = rs3.getString("TheTime"); 
	location= rs3.getString("Location"); 
	transporter = rs3.getString("Transporter"); 
	lat = rs3.getString("LatitudePosition"); 
	lon = rs3.getString("LongitudePosition"); 
	lat1 = rs3.getString("lat1"); 
	lon1 = rs3.getString("lon1"); 
	
	}
	rs3.close();


if (mode1.equals("current"))
	{
%>
      
      map.setCenter(new GLatLng(<%= lat%>,<%= lon%>),9);
      var point1 = new GLatLng(<%= lat%>,<%= lon%>);
      side_bar_html +='<br><font size="2" face="arial" color="red" ><b>Reg. No        :</b></font> <font size="2" face="arial" color="#B22222" ><b><%= vehregno%> </b></font>';
      side_bar_html +='<br><font size="2" face="arial" color="red" ><b>Transporter    :</b></font> <font size="2" face="arial" color="#B22222" ><b><%= transporter%></b></font><br><br> ';

      var marker = createMarker(point1,"<div class='bodyText'>Last Location  <%= location%></div>","<div class='bodyText'><%= vehregno%><br><%= thedate%><%= thetime%><br>Last Location  <%= location%></div>","SI",<%= lat%>,<%= lon%>);
      map.addOverlay(marker);
	document.getElementById("side_bar").innerHTML = side_bar_html;		


<%

}
else
{
if(true)
{

	
	session.setAttribute("hdate1",fromdate1);
	session.setAttribute("hdate2",todate1);
	session.setAttribute("mode",CurorHist);
	session.setAttribute("hvid",vehcode1);
	session.setAttribute("hvrno",vehregno);

	String sql10 = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode1+" where concat(TheFieldDataDate,TheFieldDataTime)>='"+ fdate1+fff+"' and  concat(TheFieldDataDate,TheFieldDataTime)<='"+ tdate1+ttt+"' and LatinDec>0 order by TheFieldDataDate desc,TheFieldDataTime desc";
	ResultSet rs10 = s.executeQuery(sql10);
	//System.out.println(sql10);

	i = -1;
	
	 lat="19";
	 lon="80";
	 location="No Data";
	 thedate="0000-00-00";
	 thetime="00:00:00";
if(rs10.next())
{
        lat = rs10.getString("LatinDec"); 
	lon = rs10.getString("LonginDec"); 
	location= rs10.getString("TheFieldSubject");
	thedate= rs10.getString("TheFieldDataDate");
	thetime = rs10.getString("TheFieldDataTime"); 

}


%>
var map = new GMap2(document.getElementById("map"));
      map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());
map.setCenter(new GLatLng(<%= lat%>,<%= lon%>),9);

      var point1 = new GLatLng(<%= lat%>,<%= lon%>);

side_bar_html +='<font size="2" face="arial" color="red" ><b>Reg. No        :</b></font> <font size="2" face="arial" color="#B22222" ><b><%= vehregno%> </b></font>';
side_bar_html +='<font size="2" face="arial" color="red" ><b>Transporter         :</b></font><font size="2" face="arial" color="#B22222" ><b><%= transporter%></b></font><br>';


	var marker = createMarker(point1,"<div class='bodyText'>Last Location  <%= thedate%> <%= thetime%> <%= location%></div>","<div class='bodyText'><%= vehregno%><br><%= thedate%> <%= thetime%><br> <%= location%></div>","SI",<%= lat%>,<%= lon%>);



	
	<%
	String sql="SELECT * FROM t_startedjourney where startdate<='"+todate1 +"' and vehregno='"+vehregno+"' order by startdate desc limit 1 ";
	ResultSet rst1=st1.executeQuery(sql);
	if(rst1.next())
	{
		
		 tripid=rst1.getString("Tripid");
		 startdate=rst1.getString("Startdate");
		 startime=rst1.getString("StartTime");
		 status=rst1.getString("Jstatus");
		 startplace=rst1.getString("StartPlace");
		 endplace=rst1.getString("Endplace");
		 if(!status.equals("Completed"))
 		{
			
 		%>	side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Tripid  :</b></font><font size="1" face="arial" color="#B22222" ><b><%= tripid%> </b></font>';
 			side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Starplace  :<font size="1" face="arial" color="#B22222" ><b><%= startplace%> </b></font>';
 			
 			/*String sqpos= "SELECT LatinDec,LonginDec,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode1+" where TheFieldDataDate>='"+startdate+" and TheFieldDataTime>= "+startime+"' and TheFiledTextFileName='SI'";
				ResultSet rstpos=s.executeQuery(sqpos);
				if(rstpos.next())
				{
					lat12 = rstpos.getString("LatinDec"); 
					lon12 = rstpos.getString("LonginDec"); 
					location12= rstpos.getString("TheFieldSubject");
					thedate12= rstpos.getString("TheFieldDataDate");
					thetime12 = rstpos.getString("TheFieldDataTime");
				}*/
				
				//var marker1 = createMarker(point1,"<div class='bodyText'>Start Place < %= thedate12%> < %= thetime12%> < %= location12%></div>","<div class='bodyText'>< %= vehregno%><br>< %= thedate12%> < %= thetime12%><br> < %= location12%></div>","SI",< %= lat12%>,< %= lon12%>);
				
            side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Startdate  :<font size="1" face="arial" color="#B22222" ><b><%= startdate%> </b></font>';
 			side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Endplace  :<font size="1" face="arial" color="#B22222" ><b><%= endplace%> </b></font>';
 	
 			/*String sqpos1= "SELECT LatinDec,LonginDec,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode1+" where TheFieldDataDate<='"+enddate+" and TheFieldDataTime<= "+endtime+"' and TheFiledTextFileName='SI' ";
				ResultSet rstpos1=s11.executeQuery(sqpos);
				if(rstpos.next())
				{
					 lat11 = rstpos1.getString("LatinDec"); 
					 lon11 = rstpos1.getString("LonginDec"); 
					 location1= rstpos1.getString("TheFieldSubject");
					 thedate1= rstpos1.getString("TheFieldDataDate");
					 thetime1 = rstpos1.getString("TheFieldDataTime");
				}*/
				
				//var marker11 = createMarkerend(point1,"<div class='bodyText'>EndPlace Location  < %= location1%></div>","<div class='bodyText'>< %= vehregno%><br>< %= thedate1%> < %= thetime1%><br> < %= location1%></div>","SI",< %= lat11%>,< %= lon11 %>);
				//map.addOverlay(marker11);
 			side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Status: In Trip</b></font><br>';
 		<%	
 		}
		 
 		else
 		{
 			String sql1="SELECT * FROM t_completedjourney where startdate<='"+todate1 +"'and vehregno='"+vehregno+"' order by startdate desc limit 1";
			ResultSet rst2=st2.executeQuery(sql1);
			if(rst2.next())
			{
				tripid=rst2.getString("Tripid");
				startdate=rst2.getString("Startdate");
				startime=rst2.getString("StartTime");
				startplace=rst2.getString("StartPlace");
				endplace=rst2.getString("Endplace");
				enddate=rst2.getString("Enddate");
				endtime=rst2.getString("Endtime");
				 %>  
 				side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Tripid  :<font size="1" face="arial" color="#B22222" ><b><%= tripid%> </b></font>';
 				side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Starplace  :<font size="1" face="arial" color="#B22222" ><b><%= startplace%> </b></font>';
 				/*
				String sqpos= "SELECT LatinDec,LonginDec,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode1+" where TheFieldDataDate>='"+startdate+" and TheFieldDataTime>= "+startime+"' and TheFiledTextFileName='SI' limit 1";
				ResultSet rstpos=s.executeQuery(sqpos);
				if(rstpos.next())
				{
					lat12 = rstpos.getString("LatinDec"); 
					lon12 = rstpos.getString("LonginDec"); 
					location12= rstpos.getString("TheFieldSubject");
					thedate12= rstpos.getString("TheFieldDataDate");
					thetime12 = rstpos.getString("TheFieldDataTime");
				}
				*/
				//var marker1 = createMarker(point1,"<div class='bodyText'>Start Place < %= thedate12%> < %= thetime12%> < %= location12%></div>","<div class='bodyText'>< %= vehregno%><br>< %= thedate12%> < %= thetime12%><br> < %= location12%></div>","SI",< %= lat12%>,< %= lon12%>);
				//map.addOverlay(marker1);
 				side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Startdate  :<font size="1" face="arial" color="#B22222" ><b><%= startdate%> </b></font>';
 				side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Endplace  :<font size="1" face="arial" color="#B22222" ><b><%= endplace%> </b></font>';
				/*
 				String sqpos1= "SELECT LatinDec,LonginDec,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode1+" where TheFieldDataDate<='"+enddate+" and TheFieldDataTime>= "+endtime+"' and TheFiledTextFileName=SI' and speed=0 limit 1";
				ResultSet rstpos1=s11.executeQuery(sqpos);
				if(rstpos.next())
				{
					 lat11 = rstpos1.getString("LatinDec"); 
					 lon11 = rstpos1.getString("LonginDec"); 
					 location1= rstpos1.getString("TheFieldSubject");
					 thedate1= rstpos1.getString("TheFieldDataDate");
					 thetime1 = rstpos1.getString("TheFieldDataTime");
				}
				*/
				//var marker11 = createMarker(point1,"<div class='bodyText'>EndPlace  < %= thedate1%> < %= thetime1%> < %= location1%></div>","<div class='bodyText'>< %= vehregno%><br>< %= thedate1%> < %= thetime1%><br> < %= location1%></div>","SI",< %= lat11%>,< %= lon11 %>);
				//map.addOverlay(marker11);
 				side_bar_html +='<br><font size="1" color="Black" face="arial"><b>Enddate	:<font size="1" face="arial" color="#B22222" ><b><%= enddate%> </b></font>';
				<%
 		 	}
 		}
	}			
       
	%>

    
  	side_bar_html +='<br><font size="2" color="red" face="arial"><b>Summary</b></font><br>';
    //
    map.addOverlay(marker);


    <%
	while(rs10.next())
	{
	i=i+1;
	lat1 = rs10.getString("lat1"); 
	lon1 = rs10.getString("lon1");
	thedate100= rs10.getDate("TheFieldDataDate");
	thetime100 = rs10.getString("TheFieldDataTime");
	long tdate = thedate100.getTime();
	location100= rs10.getString("TheFieldSubject");
	if(i==0)
	{
	lat100=lat1;
	lon100=lon1;
	
	}
	
	
	
if(Double.parseDouble(lat)-Double.parseDouble(lat1) >0.00005 || Double.parseDouble(lon)-Double.parseDouble(lon1) >0.00005 ||Double.parseDouble(lat1)-Double.parseDouble(lat) >0.00005 || Double.parseDouble(lon1)-Double.parseDouble(lon) >0.00005  ){
	    
if(tdate > miliseconds1)
{
%>

var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);
map.addOverlay(polyline);
arrowHead(new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>));
<%
}
else if(tdate > miliseconds2 || tdate == miliseconds1)
{
	%>

	var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#FF0000",  10);
	map.addOverlay(polyline);
	arrowHead(new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>));
	<%
}
else if(tdate > miliseconds3 || tdate == miliseconds2)
{
	%>

	var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#BEC02D",  10);
	map.addOverlay(polyline);
	arrowHead(new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>));
	<%
}
else
{
	%>

	var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#685622",  10);
	map.addOverlay(polyline);
	arrowHead(new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>));
	<%
}

}
lat=lat1;
lon=lon1;

}
  %>
    var marker1 = createMarker11(new GLatLng(<%= lat%>,<%= lon%>),"<div class='bodyText'>Start Location  <%= thedate100%> <%= thetime100%> <%= location100%></div>","<div class='bodyText'><%= vehregno%><br><%= thedate100%> <%= thetime100%><br> <%= location100%></div>",<%= lat%>,<%= lon%>);
    map.addOverlay(marker1);
  <%
    
rs10.close();

String sql6 = "SELECT Min(Distance) as startdist,Max(Distance) as enddist   FROM t_veh"+ vehcode1 +" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+ fdate1+" "+fff+"'  and  concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+ tdate1+" "+ttt+"' and LatinDec >0 and TheFiledTextFileName in('SI')";
ResultSet rs6 = s.executeQuery(sql6);

if(rs6.next())
{

int Startdist=rs6.getInt("startdist");
int Enddist=rs6.getInt("enddist");
int Totdist=Enddist-Startdist;


%>


side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Distance Travelled  :</b></font>  <font color="#B22222" face="arial" size="1"><b><%= Totdist%>  kms</b></font>';


<%


}
rs6.close();

String sql7 = "SELECT count(*) as oscount  FROM t_veh"+vehcode1+"_overspeed where concat(FromDate,' ',FromTime)>='"+ fdate1+" "+fff+"' and  concat(ToDate,' ',ToTime)<='"+ tdate1+" "+ttt+"' ";
	ResultSet rs7 = s1.executeQuery(sql7);
int OSCount=0;	
if(rs7.next())
{

OSCount=rs7.getInt("oscount");
session.setAttribute("oscount",""+OSCount);



}
rs7.close();
%>

document.getElementById("os").innerHTML=<%= OSCount%>;
<%


String sql8 = "SELECT count(*) as account  FROM t_veh"+vehcode1+"_ra where concat(TheDate,' ',TheTime)>='"+ fdate1+" "+fff+"' and  concat(TheDate,' ',TheTime)<='"+ tdate1+" "+ttt+"' ";
//System.out.println("Map Count::>>"+sql8);
ResultSet rs8 = s1.executeQuery(sql8);
int ACCount=0;	
if(rs8.next())
{

ACCount=rs8.getInt("account");

session.setAttribute("account",""+ACCount);


}
rs8.close();
%>
document.getElementById("ra").innerHTML=<%= ACCount%>;
<%

String sql9 = "SELECT count(*) as dccount  FROM t_veh"+ vehcode1 +"_rd where concat(TheDate,' ',TheTime)>='"+ fdate1+" "+fff+"' and  concat(TheDate,' ',TheTime)<='"+ tdate1+" "+ttt+"' ";
	ResultSet rs9 = s1.executeQuery(sql9);
int DCCount=0;	
if(rs9.next())
{

DCCount=rs9.getInt("dccount");
session.setAttribute("dccount",""+DCCount);
}
rs9.close();

String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString()+"&fromtime1="+session.getAttribute("fromtime1").toString()+"&fromtime2="+session.getAttribute("fromtime2").toString()+"&totime1="+session.getAttribute("totime1").toString()+"&totime2="+session.getAttribute("totime2").toString();

%>
document.getElementById("rda").innerHTML=<%= DCCount%>;

var hh="<table border='1' width='100%'><tr><td><table border='0' width='100%' background='images/background1.bmp'><tr><td align='center'><a href='MainformMap2.jsp<%=ll %>'>Map</a></td><td align='center'><a href='historypiechart.jsp'>Pie Chart</a></td><td align='center'><a href='historybarchart.jsp'>Bar Chart</a></td><td align='center'><a href='tempraturereport.jsp'>Detail Report</a></td></tr></table></td></tr></table>";

 document.getElementById("hh").innerHTML = hh;


/*****Code to Show the Stops*****/
<%! 
String sql100, sql200,label1;
ResultSet rst100, rst200,rst00;
Statement st00,st100;
int stcount2;
String stopdatetime="-",startdatetime="-";
%>
<%
stcount2=0;
try{
Class.forName(MM_dbConn_DRIVER);
conn00 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st00=conn00.createStatement();
st100=conn00.createStatement();

String sql00="select * from t_veh"+vehcode1+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+fdate1+" "+fff+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+tdate1+" "+ttt+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
ResultSet rst00=st00.executeQuery(sql00);
//System.out.println(sql100);

boolean flag=true;
int j=1;

//String sql00="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode1+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,TheFieldDataTime) >='"+fdate1+fff+"' and concat(TheFieldDataDate,TheFieldDataTime) <='"+tdate1+ttt+"' order by TheFieldDataDate, TheFieldDataTime asc";
//rst00= st00.executeQuery(sql00);
while(rst00.next())
{

	if(rst00.getInt("Speed")==0)
	{
		if(flag)
		{
			stopdatetime=rst00.getString("TheFieldDataDate")+" "+rst00.getString("TheFieldDataTime");
			flag=false;
		}
	}
	else
	{
		flag=true;
		startdatetime=rst00.getString("TheFieldDataDate")+" "+rst00.getString("TheFieldDataTime");
		if(!(stopdatetime.equals("-")))
		{
			java.util.Date spdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stopdatetime);
			java.util.Date stdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdatetime);
			
			long mils=(stdate.getTime()-spdate.getTime());
			long mins=mils/1000/60;
			if(mins >= Integer.parseInt(session.getAttribute("stop11").toString()))
			{
				String hrs=""+mins/60;
				String min="00";
				try{
				 min=""+mins%60;
				}catch(Exception ee)
				{
					min="00";
				}
				label1="ST "+new SimpleDateFormat("dd-MMM-yyyy").format(rst00.getDate("TheFieldDataDate"))+"  "+rst00.getString("TheFieldDataTime")+"<br> "+hrs+"hrs "+min+"min  "+rst00.getString("TheFieldSubject");
				stcount2++;
				%> 

				var point1 = new GLatLng(<%=rst00.getDouble("LatinDec")%>,<%=rst00.getDouble("LonginDec")%>);
				var marker = createMarker(point1,"<div class='bodyText' align='left'><%= label1%></div>","<div class='bodyText' align='left'><%=label1%></div>",'ST','<%=rst00.getDouble("LatinDec")%>','<%=rst00.getDouble("LonginDec")%>');
			    map.addOverlay(marker);

			<%
			
			}
			
			stopdatetime="-";
		}
	}
}

%> 

document.getElementById("st").innerHTML= <%=stcount2%>



<%


}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn00.close();
}
%>

/*****Code to Show the Stops*****/

<%

String sql5 = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFiledTextFileName,TheFieldDataDate,TheFieldDataTime,Speed,Distance  FROM t_veh"+ vehcode1 +" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+ fdate1+" "+fff+"' and  concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+ tdate1+" "+ttt+"' and LatinDec>0 and TheFiledTextFileName  in ('AC','DC','OS') order by TheFieldDataDate desc,TheFieldDataTime desc";
	ResultSet rs5 = s.executeQuery(sql5);
	i = 0;
	
	while(rs5.next())
	{
	lat = rs5.getString("LatinDec"); 
	lon = rs5.getString("LonginDec"); 
	location= rs5.getString("TheFieldSubject");
	String Stamp=rs5.getString("TheFiledTextFileName");
	String label1="aa";
	String html1="-";
	int show=1;
	if (Stamp.equals("OS"))
	{

	label1="OS "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+  " Speed " +rs5.getString("Speed")+" Duration " + rs5.getString("Distance") + " Sec. Location:-"+location ;
	}
	if (Stamp.equals("AC"))
	{
	if (rs5.getInt("Distance")>5)
	{
	label1="AC "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+  " Speed from " +rs5.getString("Distance")+" To " + rs5.getString("Speed")+"Location:-"+location  ;
	}
	else
	{
	show=0;
	}
	}
	
if (Stamp.equals("DC"))
	{
	if (rs5.getInt("Distance")<120)
	{
	label1="DC "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+  " Speed from " +rs5.getString("Distance")+" To " + rs5.getString("Speed")+"Location:-"+location  ;
	}
	else
	{
	show=0;
	}
	}
if (Stamp.equals("ST"))
	{
	label1="Start at "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime") +"Location:-"+location;
	}
	
if (Stamp.equals("SP"))
	{
	label1="Stop at "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+"Location:-"+location  ;
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
}
rs5.close();


}


}
/*********************************************************************/
	String LatitudePosition1,LongitudePosition1, name1, discription1,imgname1;
	String user1=session.getAttribute("usertypevalue").toString();
	String sql13="select * from t_waypoints where OwnerName='"+user1+"'";
	ResultSet rst13=s.executeQuery(sql13);
	while(rst13.next())
	{
	LatitudePosition1=rst13.getString("Lon");
	LongitudePosition1=rst13.getString("Lat");
	name1=rst13.getString("Name");
	discription1=rst13.getString("Discription");
	imgname1=rst13.getString("Category");

	%>
	var point1 = new GLatLng(<%= LongitudePosition1%>,<%= LatitudePosition1%>);
	var label=new ELabel(point1,"<div class='bodyText'><%=name1%></div>","elabelstyle", new GSize(-5,20), 80);
	map.addOverlay(label);
var marker = createMarker1(point1,"<div class='bodyText'><%= name1%></div>","<div class='bodyText'><%= discription1%></div>","<%=imgname1%>",<%= LongitudePosition1%>,<%= LatitudePosition1%>);
	map.addOverlay(marker);
	
	<%
	}


/*********************************************************************/
 
/*************************code to drow the route for army************/
if(session.getAttribute("usertypevalue").toString().equals("IArmy"))
{
String sql55="select * from way where OwnerName='iarmy' and RouteId='1'";

ResultSet rst55=s.executeQuery(sql55);
if(rst55.next())
{
        latx = rst55.getDouble("Lat"); 
	lonx = rst55.getDouble("Lon"); 
}
while(rst55.next())
{	latx1 = rst55.getDouble("Lat"); 
	lonx1 = rst55.getDouble("Lon"); 
	%> 
var polyline = new GPolyline([new GLatLng(<%= latx%>,<%= lonx%>),new GLatLng(<%= latx1%>,<%= lonx1%>)], "#cccc00",  10);
map.addOverlay(polyline);

<%
latx=latx1;
lonx=lonx1;
}

}
/***************************end of the code*************************/
	

/*****************************Start code for night driving ****************/
try{
double latnd=0.00,latnd1=0.00,lonnd=0.00,lonnd1=0.00;
String ndsql="select * from t_veh"+vehcode1+"_nd where concat(FromDate,' ',FromTime)>='"+fdate1+" "+fff+"' and concat(ToDate,' ',ToTime)<='"+tdate1+" "+ttt+"'";

//System.out.println(ndsql);
ResultSet ndrst=st3.executeQuery(ndsql);
while(ndrst.next())
{
String ndsql1="select LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1 from t_veh"+vehcode1+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+ndrst.getString("FromDate")+" "+ndrst.getString("FromTime")+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+ndrst.getString("ToDate")+" "+ndrst.getString("ToTime")+"' and TheFiledTextFileName='SI'";

ResultSet ndrst1=s.executeQuery(ndsql1);
if(ndrst1.next())
{
        latnd = ndrst1.getDouble("LatinDec"); 
	lonnd = ndrst1.getDouble("LonginDec"); 
}
while(ndrst1.next())
{	latnd1 = ndrst1.getDouble("LatinDec"); 
	lonnd1 = ndrst1.getDouble("LonginDec"); 
	%> 
var polyline = new GPolyline([new GLatLng(<%= latnd%>,<%= lonnd%>),new GLatLng(<%= latnd1%>,<%= lonnd1%>)], "#ffff",  10);
map.addOverlay(polyline);
document.getElementById("nd").innerHTML="Yes";
<%
latnd=latnd1;
lonnd=lonnd1;
}



}
}catch(Exception e)
{
%>
alert("Exception <%=e%>");
<%
}
/*****************************End of code for Night Driving *********/
s.close();
	}catch(Exception e)
	{
	%>
	alert("Exception <%=e%>");
	<%
	}
	finally
	{
		
		con.close();
		con1.close();
		
	}

%>
              // put the assembled side_bar_html contents into the side_bar div
          document.getElementById("side_bar").innerHTML = side_bar_html;
         }

    else {
      alert("Sorry, the Google Maps API is not compatible with this browser");
    }

    // This Javascript is based on code provided by the
    // Blackpool Community Church Javascript Team
    // http://www.commchurch.freeserve.co.uk/   
    // http://econym.googlepages.com/index.htm
    //]]>
    </script>
<% 
}
 %>

<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>