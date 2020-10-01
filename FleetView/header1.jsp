<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="Connections/conn.jsp" %>
<%@ include file="Manu.html" %>
<html>
<head>
<title>Vehicle Tracking System </title>

<link href="css/css.css" rel="StyleSheet" type="text/css">
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-19595446-2']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
<script type="text/javascript">
var plstart = new Date();
window.onload=function() {
var plend = new Date();
var plload = plend.getTime() - plstart.getTime();

// determine the thresholds

if(plload<2000)
lc = "Very Fast";
else if (plload<5000)
lc = "Fast";
else if (plload<10000)
lc = "Medium";
else if (plload<30000)
lc = "Sluggish";
else if (plload<45000)
lc = "Slow";
else
lc="Very Slow";
var fn = document.location.pathname;
if( document.location.search)
fn += document.location.search;

try
{
pageTracker._trackEvent("Page Load",lc +
" Loading Pages", fn, Math.round(plload/1000));
}
catch(err)
{

}
}
</script>
<script src="elabel.js" type="text/javascript"></script>


<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript" language="JavaScript"></script>

</head>
<body bgcolor="#FFE4E1" onLoad="JavaScript:initRotator(),loadSearchHighlight();" id="mainbody" >

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
<img src="images/foodlandveh.png" border="0"  width="15%" >
<!-- <img src="images/Img6.gif" width="10%" height="30%"> -->
<%@ include file="imgrotate.html" %>
<img src="images/your_ad_here.jpg" width="30%" height="100%">
</td>
</tr>

<tr><td colspan="2">
  <table border="0" width="96%" align="right" >
    <tr>
       <td background="images/orangebarsmall.jpeg" width="111" align="center"> <a href="onlinedata.jsp" title="Home"> HOME </a> </td>
       <td background="images/orangebarsmall.jpeg" width="110" align="center"> <a href="http://www.twtech1.com/" title="About Us" >ABOUT US</a></td>
       <td background="images/orangebarsmall.jpeg" width="109" align="center"><a href="http://www.mobile-eye.in/contact.html" title="Contact Us">CONTACT US</a></td>
<%

String userID = "";
if (! session.isNew()) 
userID = (String) session.getAttribute("user");
if (null == userID || userID=="") 
	{
		%>
		<td align="center">
<a href="index.html">LOGIN</a></td>
		<%
	}
else
	{
		%>
      <td background="images/orangebarsmall.jpeg" width="109" align="center">  <a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu1, '150px')" onMouseout="delayhidemenu()" title="Reports"> REPORTS </a>
</a><!-- <a href="report.jsp">REPORTS</a> --></td>
<%
if(session.getAttribute("usertypevaluemain").toString().equals("ALL"))
{
%>
  <td background="images/orangebarsmall.jpeg" width="131" align="center">  <a href="selectuser.jsp" title="Select User">SELECT USER </a> </td>
<%
}
if(session.getAttribute("usertypevalue").toString().equals("Castrol")||session.getAttribute("usertypevalue").toString().equals("TWDEMO"))
{
if(session.getAttribute("TypeofUser").toString().equals("SUBUSER"))
{
%>
  <td background="images/orangebarsmall.jpeg" width="111" align="center"> <a href="location.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu4, '150px')" onMouseout="delayhidemenu()" title="Location">LOCATIONS</a> </td>

	<td background="images/orangebarsmall.jpeg" width="111" align="center"> <a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu2, '150px')" onMouseout="delayhidemenu()" title="Journey">JOURNEY</a>
</a></td>
	<%

}
else
{
	%>
   <td background="images/orangebarsmall.jpeg" width="111" align="center"> <a href="location.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu3, '150px')" onMouseout="delayhidemenu()" title="Location">LOCATIONS</a> </td>

	<td background="images/orangebarsmall.jpeg" width="111" align="center"> <a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu2, '150px')" onMouseout="delayhidemenu()" title="Journey">JOURNEY</a>
</a></td>
	<%
}
}
if(session.getAttribute("usertypevalue").toString().equals("BS"))
{
	%>
<!--	<td background="images/orangebarsmall.jpeg" width="111" align="center"> <a href="journeydetails.jsp" title="Add Journey Details">ADD JOURNEY </a> </td> -->

<td background="images/orangebarsmall.jpeg" width="111" align="center"> <a href="tripentry.jsp" title="Add Journey Details">ADD JOURNEY </a> </td>

	<%
}
if(session.getAttribute("usertypevalue").toString().equals("Penzoil"))
{
	%>
	<td background="images/orangebarsmall.jpeg" width="109" align="center"> <a href="journeydetails.jsp" title="Add Journey Details">ADD JOURNEY </a> </td>
	<%
}
if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
{
	%>
	<td background="images/orangebarsmall.jpeg" width="110" align="center"> <a href="foodlandreport.jsp" title="Temperature Report">TEMP. REPORT </a> </td>
	<%
}

if(session.getAttribute("usertypevalue").toString().equals("futurelogistics"))
{
	%>
	<td background="images/orangebarsmall.jpeg" width="110" align="center"> <a href="demo1.html" title="Find Shortest Route">FIND ROUTE </a> </td>
	<%
}
if(session.getAttribute("usertypevalue").toString().equals("IBTEST"))
{
	%>
	<td background="images/orangebar.jpeg" width="149" align="center"> <a href="demo1.html" title="Find Shortest Route">FIND ROUTE </a> </td>
	<td background="images/orangebar.jpeg" width="149" align="center"> <a href="getlatlong.jsp" title="Find Lat. & Long.">FIND LAT. & LONG.</a> </td>
	<%
}
if(session.getAttribute("displaymenu").toString().equals("yes"))
{
	%>
        <td background="images/orangebarsmall.jpeg" width="111" align="center"> <a href="location.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu5, '150px')" onMouseout="delayhidemenu()" title="Location">JOURNEY </a> </td>
	<%

}
%>
		<td background="images/orangebar.jpeg" width="157" align="center"> <font COLOR="#696969" face="Tahoma"> <b> WELCOME : </font> <font color="green"><%=session.getAttribute("dispalyname").toString() %> </b> </font> </b></td> 
                <td background="images/orangebarsmall.jpeg" width="111" align="center"> <a href="logout.jsp" title="Logout"> LOGOUT </a> </td>
		<%
	}
%>


</tr>


</table></td><tr>
</table>

</td></tr>
</table>

<!-- header end here-->



