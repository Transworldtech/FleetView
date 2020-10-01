<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="Connections/conndriver.jsp" %>
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
<script src="sorttable.js" type="text/javascript"></script>



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
<td></tr>

</tr>
</table>
</td></tr>
</table>

<!-- header end here-->



