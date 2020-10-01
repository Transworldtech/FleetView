<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
<head>
<title>Vehicle Tracking System </title>
<link href="common/genomics.css" rel="StyleSheet" type="text/css">
<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>

<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxQDcrUiT1n2wGtp80NHz-KNPlY2iRSm07rlwKEMyQBZsjTK0mnedLODCQ" type="text/javascript"></script>

<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>


</head>
<body onunload="GUnload()"  bgcolor="#FFE4E1">
<P></P>
<table border="1" width="100%" align="center" bgcolor="#FFFAFA" class="solid">
<tr >
<td valign="top">
<table border="0" width="100%" bgcolor="#F8F8FF">
<tr>
<td rowspan="2" align="center" width="13%">
<a href="images/logo.jpg" >
<img src="images/logo.jpg"  border="0">
</a>
</td>
<td  align="left">
<img src="images/ind11.jpg" width="30%" height="100%">
<img src="images/move.gif" border="0"  width="15%" >
<img src="images/Img6.gif" width="10%" height="30%">
<%@ include file="imgrotate.html" %>
</td>
</tr>
<tr>
<td colspan="2">
<table border="0" width="100%" align="right" background="images/background1.bmp">
<tr>
<td align="center" >
<a href="onlinedata.jsp">HOME</a>
</td>
<td align="center">
<a href="http://www.twtech1.com/">ABOUT US</a>
</td>
<td align="center">
<a href="http://www.mobile-eye.in/contact.html">CONTACT US</a>
</td>
<%

String userID = "";
if (! session.isNew()) 
userID = (String) session.getAttribute("user");
if (null == userID || userID=="") 
	{
		%>
		<td align="center">
<a href="index.jsp">LOGIN</a></td>
		<%
	}
else
	{
		%>
<td align="center"><a href="report.jsp">REPORTS</a></td>
		<td align="center"><font COLOR="#696969" face="Tahoma"><b>WELCOME :</b></font><font color="red"><%=userID %></b></font></td><td align="center"><a href="logout.jsp">LOGOUT</a></td>
		<%
	}
%>


</tr>


</table></td><tr>
</table>
</td></tr>
</table>
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
function validate()
{
	if(document.loginform.user.value=="")
	{
		alert("Please Enter User Name");
		return false;
	}
	if(document.loginform.Password.value=="")
	{
		alert("Please Enter Password");
		return false;
	}
	return true;
}
</script>
  <body onunload="GUnload()">
  
	


  <!-- you can use tables or divs for the overall layout --><table border="1" class="groove">
    <tr>
        
        <td width ="350px" valign="top" border=1 bgcolor="#F0FFF0">
	
           <!-- =========== side_bar with scroll bar ================= -->
     
<form name="loginform" action="validateuser.jsp"  onSubmit="return validate();">
<table border="0" bgcolor="#87CEFA" width="100%" class="f12">
<tr><td colspan="2">
<%
String err=request.getParameter("err");
if(null==err)
{
}
else
{
out.print("<center><font color='red' size='1'>Please Enter Currect User Name And Password</font>");
}
%>

</td></tr>
<tr> 
            <td align="left" valign="middle"> UserName:</td> 
            <td><input name="user" type="text" class="formElement" size="15"></td> 
          </tr> 
          <tr> 
            <td align="left" valign="middle" > Password:</td> 
            <td><input name="Password" type="Password" class="formElement" size="15"></td> 
          </tr> 
		  
          <tr> 
            
            <td colspan="2" align="center"><input type="submit" name="submit"  value="submit" class="formElement"></td> 
          </tr> 

</table>
</form>
<p>&nbsp;</p>
<font size="4" color="darkred" class="f10"><b>Welcome to FleetView </b></font><font size="2" class="f11"><p>Feel free to play with Map</p></font><font size="4"><i> <p>To view your Vehicle please login</p></i></p><p><b><a href=a.pdf>click to download Product Brocher</a></b></p></font>
<p>&nbsp;</p>
<table border="0">
<%@ include file="Connections/helpconn.jsp" %>
<%
try{
String sql="select * from t_helpline";
ResultSet rst=getStatement.executeQuery(sql);
if(rst.next()){
%>
<th colspan="2">Helpline</th>
<tr><td class="bodyText">Phone :</td><td class="bodyText"><%=rst.getString("PhoneNumber") %></td></tr>
<tr><td class="bodyText">Mobile :</td><td class="bodyText"><%=rst.getString("MobileNumber") %></td></tr>
<tr><td class="bodyText">Contact :</td><td class="bodyText"><%=rst.getString("ContactName") %></td></tr>
<tr><td class="bodyText"> Email:</td><td class="bodyText"><a href="mailto:<%=rst.getString("Email") %>"><%=rst.getString("Email") %></a></td></tr>
<tr><td class="bodyText">Contact Time:</td><td class="bodyText"><%=rst.getString("ContactTime") %></td></tr>
<%
}
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	getStatement.close();
	getDattabase.close();
}
%>
</table>

           <!-- ===================================================== -->	
	
</td>
	
<td>
           <div id="map" style="width: 700px; height: 550px"></div>
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
      var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));
map.addControl(new GLargeMapControl());
map.addControl(new GScaleControl(250));
new GKeyboardHandler(map);
map.enableContinuousZoom();
map.enableDoubleClickZoom();

////overview map

var ovSize=new GSize(200, 150)
var ovMap=new GOverviewMapControl(ovSize);
map.addControl(ovMap);
var mini=ovMap.getOverviewMap();
//setTimeout("mini.setZoom(14),mini.clearOverlays(),mini.setMapType(G_SATELLITE_MAP);",1);

/////I discovered 'load' event accidentally
GEvent.addListener(mini,"load",function(){
mini.setZoom(14);
mini.clearOverlays();
mini.setMapType(G_SATELLITE_MAP);
});

function zoomMini(){mini.setZoom(map.getZoom()-document.getElementById("zoffset").value);}
GEvent.addListener(map,"move",zoomMini);
GEvent.addListener(map,"moveend",zoomMini);

function omap(){mini.setMapType(G_NORMAL_MAP);}
function osat(){mini.setMapType(G_SATELLITE_MAP);}
function ohyb(){mini.setMapType(G_HYBRID_MAP);}

/////////////////////// Ruler code by Esa


function add()
{
var marker1;
var marker2;
var label1;
var label2;
var button=0;
var dist=0;
var line;
var poly;

function measure(){
if(marker1&&marker2)
line = [marker1.getPoint(),marker2.getPoint()];
dist=marker1.getPoint().distanceFrom(marker2.getPoint());
dist=dist.toFixed(0)+"m";
if(parseInt(dist)>10000){dist=(parseInt(dist)/1000).toFixed(1)+"km";}
label1.setContents(dist);label2.setContents(dist);
label1.setPoint(marker1.getPoint());
label1.setContents(dist);
label2.setPoint(marker2.getPoint());
if(poly)map.removeOverlay(poly);
poly = new GPolyline(line,'#FFFF00', 8, 1)
map.addOverlay(poly);
}

document.getElementById("add").value="click on map";

GEvent.addListener(map, 'click', function(overlay,pnt) 
{
if(pnt&&button==0)
{
marker1 = new GMarker(pnt,{draggable: true});
map.addOverlay(marker1);
marker1.enableDragging();
label1=new ELabel(pnt, dist,"labelstyle",new GSize(2,20),60);
map.addOverlay(label1);
marker2 = new GMarker(pnt,{draggable: true});
map.addOverlay(marker2);
marker2.enableDragging();
label2=new ELabel(pnt, dist,"labelstyle",new GSize(2,20),60);
map.addOverlay(label2);
}
GEvent.addListener(marker1,"drag",function(){measure();});
GEvent.addListener(marker1,"dblclick",function(){clr();});
GEvent.addListener(marker2,"drag",function(){measure();});
GEvent.addListener(marker2,"dblclick",function(){clr();});
document.getElementById("add").value="You Have a Ruler";
button++;
});
}
     //]]>
    </script>

<%

//java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse("2008-02-29");
//Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
//String s = formatter.format(date);
//out.print(s);
%>
</body>
</html>
