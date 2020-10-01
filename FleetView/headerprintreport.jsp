<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<link href="css/erratic.css" rel="StyleSheet" type="text/css">
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
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<script src="js/searchhi.js" type="text/javascript" language="JavaScript"></script>
<%@ include file="Manu.html" %>
<table border="0" width="100%" align="center" bgcolor="white">
<tr>
<td>
<table border="0" align="left" width="100%">
<tr>
<td>
<!-- unit logo comes here --->
<img src="images/Transworld.jpeg"  border="0">
<!-- unit logo comes here --->
</td>
<td>
<div align="right"><a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;</a>
Date: <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div></td>
</tr>
</table>
</td>
</tr>
</table> 