<%@ include file="header.jsp" %>
<head>
<title>Vehicle Tracking System </title>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxQDcrUiT1n2wGtp80NHz-KNPlY2iRSm07rlwKEMyQBZsjTK0mnedLODCQ" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
<script language="javascript">
function validate()
{
var val=document.form1.vehregno.value;
if(val=="Select")
{
alert("Please Select The Vehicle To Show The Report");
return false;
}
return true;
}
	
</script>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<!-- main body table-->
<%!
Connection conn;
Statement st,st1,st2;
ResultSet rst, rst1,rst2;
String sql,sql1,sql2;
String user,vehregno,vehcode,showdate,showdate1,showtime1,qdata,tbname;
int h1,m1,os,ac,dc,st;
String lat,lon,lat1,lon1;

 %>
<%
user=session.getAttribute("user").toString();
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();

%>
<form name="form1" action="" method="get" onSubmit="return validate();">
<table class="stats">
<tr><td>
<table class="stats">
<tr><td class="hed">Vehicle Reg. Number: </td>
<td class="hed">
<select name="vehregno" class="formElement">
<option value="Select">Select</option>
<%
if(session.getAttribute("TypeofUser").toString().equals("GROUP"))
{
sql="select transporter as vehregno, VehCode as vehcode from t_group where GPName='"+user+"'";

}
else
{
sql="select VehicleRegNumber as vehregno, VehicleCode as vehcode from t_vehicledetails where OwnerName='"+user+"'";
}

rst=st.executeQuery(sql);
while(rst.next())
{
%>
<option value="<%=rst.getString("vehregno") %>,<%=rst.getString("vehcode") %>"><%=rst.getString("vehregno") %></option>
<%
}
%>
</select>
</td>
<td class="hed"><input type="submit" name="submit" value="Submit" class="formElement"></td>

</tr>
</table>
</td><td width="50%" class="hed"><font size="4" color="green" >Report For Last 24 Hours </font>
</td>

</tr>
</table>
</form>

<table class="stats">
<tr><td width="50%">
<div id="map" style="width:500px; height:440px"></div>
</td>
<td width="50%">

</td>

</tr>
<script type="text/javascript">
    //<![CDATA[


    if (GBrowserIsCompatible()) {

var side_bar_html = "";
	var side_bar_html1 = "";	
      var gmarkers = [];
      var htmls = [];
      var i = 0;
	var map = new GMap2(document.getElementById("map"));
      map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));
	map.addControl(new GLargeMapControl());;
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
        
        i++;
        return marker;
      }



	var map = new GMap2(document.getElementById("map"));
	map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));
	map.addControl(new GLargeMapControl());


<%
if(request.getQueryString()!=null)
{
qdata=request.getParameter("vehregno");
StringTokenizer s= new StringTokenizer(qdata,",");
vehregno=s.nextElement().toString();
vehcode=s.nextElement().toString();
java.util.Date d1= new java.util.Date();
h1=d1.getHours();
m1=d1.getMinutes();
showtime1=h1+":"+m1+":00";
Format formatter = new SimpleDateFormat("yyyy-MM-dd");
showdate = formatter.format(d1);
long dateMillis = d1.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
d1.setTime(dateMillis);
showdate1 = formatter.format(d1);
tbname="t_veh"+vehcode;

if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
sql1="select LatitudeDir as lat,LatitudeDir+0.0001 as lat1,LongitudeDir as  lon, LongitudeDir+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime,TheFiledTextFileName,Distance,Speed from "+tbname+" where concat(TheFieldDataDate,TheFieldDataTime) >='"+showdate1+showtime1+"' and  concat(TheFieldDataDate,TheFieldDataTime) <='"+showdate+showtime1+"' and LatitudeDir>0 order by TheFieldDataDate desc,TheFieldDataTime desc";
}
else
{
sql1="select LatinDec as lat,LatinDec+0.0001 as lat1,LonginDec as  lon, LonginDec+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime,TheFiledTextFileName,Distance,Speed from "+tbname+" where concat(TheFieldDataDate,TheFieldDataTime) >='"+showdate1+showtime1+"' and  concat(TheFieldDataDate,TheFieldDataTime) <='"+showdate+showtime1+"' and LatinDec>0 order by TheFieldDataDate desc,TheFieldDataTime desc";
}

rst1=st.executeQuery(sql1);
if(rst1.next())
{
lat=rst1.getString("lat");
lon=rst1.getString("lon");
%>
var point1 = new GLatLng(<%= lat%>,<%= lon%>);

var marker = createMarker(point1,"<div class='bodyText'>Last Location  <%=rst1.getString("TheFieldDataDate")%> <%=rst1.getString("TheFieldDataTime")%> <%=rst1.getString("TheFieldSubject")%></div>","<div class='bodyText'><%= vehregno%><br><%=rst1.getString("TheFieldDataDate")%> <%=rst1.getString("TheFieldDataTime")%><br> <%=rst1.getString("TheFieldSubject")%></div>","SI",<%= lat%>,<%= lon%>);
 map.addOverlay(marker);
<%
}
while(rst1.next())
{

lat1=rst1.getString("lat1");
lon1=rst1.getString("lon1");
String Stamp=rst1.getString("TheFiledTextFileName");
String label1="";
	String html1="-";
	int show=0;
	if (Stamp.equals("OS"))
	{

	label1="OS "+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")+  " Speed " +rst1.getString("Speed")+" Duration " + rst1.getString("Distance") + " Sec." ;
	show=1;
	}
	if (Stamp.equals("AC"))
	{
	if (rst1.getInt("Distance")>5)
	{
	label1="AC "+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")+  " Speed from " +rst1.getString("Distance")+" To " + rst1.getString("Speed")  ;
	show=1;
	}
	
	}
	
if (Stamp.equals("DC"))
	{
	if (rst1.getInt("Distance")<120)
	{
	label1="DC "+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")+  " Speed from " +rst1.getString("Distance")+" To " + rst1.getString("Speed")  ;
	show=1;
	}
	}

	html1=label1;


	

	if (show==1)
	{
	
	   
%> 
      	var point1 = new GLatLng(<%= lat1%>,<%= lon1%>);
	var marker = createMarker(point1,"<div class='bodyText'><%= html1%></div>","<div class='bodyText'><%= html1%></div>","<%=Stamp%>",<%= lat1%>,<%= lon1%>);
     	 map.addOverlay(marker);

	<%
	}
%> 
var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);

map.addOverlay(polyline);

<%
lat=lat1;
lon=lon1;
}//end of while

}//end of main if.
%>
	

}//end of browser validate function

//]]>
    </script>
</table>

<%
}
catch(Exception e)
{
	%> alert('<%=e%>'); <%
}
finally
{
conn.close();
}

%>
<!--End of main body table-->
</td></tr></table>
<!-- Footer Start Here -->
<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2007 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
