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
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript" language="JavaScript"></script>
<%@ include file="Connections/conn.jsp" %>
<%@ include file="Manu.html" %>
<table border="0" width="100%" align="center" bgcolor="white">
<tr>
<td>
<table border="0" width="100%" align="center" bgcolor="white">
<tr>
<td>

<!-- Modifications done in the following table -->
<!-- Table alignment is changed to centre -->
<!-- images/your_ad_here.jpg image is excluded -->
<table border="0" align="center">
<tr>
<td>
<!-- unit logo comes here --->
<a href="images/logo.jpg" >
<img src="images/logo.jpg"  border="0" width="75" height="70">
</a>
<!-- unit logo comes here --->

</td>
<td>
<!-- company logo comes here --->
<img src="images/ind11.jpg" width="300" height="70">
<!--company logo comes here --->
</td>
<td>
<!-- customer logo comes here --->
<%@ include file="imgrotate.html" %>
<!-- customer logo comes here --->

</td>
<td>
<!-- Advertisement comes here --->
<!-- <img src="images/your_ad_here.jpg" width="300" height="70"> -->
<!-- Advertisement comes here --->
</td>
</tr>
</table>
<!-- End of modifications done -->



</td>
</tr>
<tr>
<td>
<!-- menu comes here --->
<table border="0" align="right">
<tr><td>*</td>
<tr>
	<%
			String userID = "";
			userID = (String) session.getAttribute("user");
			if (null == userID || userID=="") 
			{
			%>
				<td><a href="http://www.twtech1.com/" title="About Us" ><img src="images/aboutus.jpeg" border="0"></a></td>
				<td><a href="http://www.mobile-eye.in/contact.html" title="Contact Us"><img src="images/contactus.jpeg" border="0"></a></td>
				<td><a href="http://www.blog.transworld-compressor.com" title="Blog"><img src="images/blog.jpeg" border="0"></a></td>
				<td><a href="index.jsp" title="Login"><img src="images/login.jpeg" border="0"></a></td>
			<%
			}
			else
			{
				%>
				<!-- 
				<td><a href="http://www.twtech1.com/" title="About Us" ><img src="images/aboutus.jpeg" border="0"></a></td>
				<td><a href="http://www.mobile-eye.in/contact.html" title="Contact Us"><img src="images/contactus.jpeg" border="0" ></a></td>
				--> 
				 <td> <a href="onlinedata.jsp" title="Home"><img src="images/home.jpg" border="0">  </a> </td>
				<td><a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu1, '150px')" onMouseout="delayhidemenu()" title="Reports"><img src="images/reports.jpeg" border="0"></a></td>
				<%
				
				if(session.getAttribute("usertypevaluemain").toString().equals("ALL") || (session.getValue("usertypevaluemain").toString().equals("Castrol") && session.getAttribute("TypeofUserMain").toString().equals("GROUP")) )
				{
				
				%>
 	 			<td>  <a href="selectuser.jsp" title="Select User"><img src="images/selectuser.jpeg" border="0"> </a> </td>
				<%
				}
				if(session.getAttribute("usertypevalue").toString().equals("Castrol")||session.getAttribute("usertypevalue").toString().equals("TWDEMO")||session.getAttribute("usertypevalue").toString().equals("Castrol-Tanker") || (session.getValue("usertypevaluemain").toString().equals("Castrol")))
				{
					if(session.getAttribute("TypeofUser").toString().equals("SUBUSER"))
					{
						%>
  						<td> <a href="location.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu4, '150px')" onMouseout="delayhidemenu()" title="Location"><img src="images/mylocation.jpeg" border="0"></a> </td>
						<td> <a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu2, '150px')" onMouseout="delayhidemenu()" title="Journey"><img src="images/journey.jpeg" border="0"></a></td>
						<%
					}
					else
					{
						%>
   					<td> <a href="location.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu3, '150px')" onMouseout="delayhidemenu()" title="Location"><img src="images/mylocation.jpeg" border="0"></a> </td>
						<td> <a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu2, '150px')" onMouseout="delayhidemenu()" title="Journey"><img src="images/journey.jpeg" border="0"></a></td>
						<%	
					}
				}
				if(session.getAttribute("usertypevalue").toString().equals("Foodland") || session.getAttribute("usertypevalue").toString().equals("Test"))
				{
					%>
					<td> <a href="foodlandreport.jsp" title="Temperature Report"><img src="images/tempreport.jpeg" border="0"></a> </td>
					<%
				}
				if(session.getAttribute("usertypevalue").toString().equals("futurelogistics"))
				{
					%>
					<td> <a href="demo1.html" title="Find Shortest Route"><img src="images/findroute.jpeg" border="0"> </a> </td>
					<%
				}
				if(session.getAttribute("usertypevalue").toString().equals("IBTEST"))
				{
					%>
					<td> <a href="demo1.html" title="Find Shortest Route"><img src="images/findroute.jpeg" border="0"> </a></a> </td>
					<td> <a href="getlatlong.jsp" title="Find Lat. & Long."><img src="images/getlatlong.jpeg" border="0"> </a></a> </td>
					<%
				}
				if(session.getAttribute("displaymenu").toString().equals("yes"))
				{
					%>
  	      		<td> <a href="location.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu5, '150px')" onMouseout="delayhidemenu()" title="Location"><img src="images/journey.jpeg" border="0"> </a> </td>
					<%
				}
				%>
				<td><a href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu8, '150px')" onMouseout="delayhidemenu()" title="Dash Board"><img src="images/dashboard.jpg" border="0"></a> </td>
				<td><img src="images/welcome.jpeg" border="0"></td>
				<td background="images/orangebarsmall.jpg" width="85" height="20" align="center"><font color="green" size="1"><%=session.getAttribute("dispalyname").toString() %></font></td>
		   	<td> <a href="changepass.jsp" title="Change Password"><img src="images/changepass.jpeg" border="0"></a> </td>
		  		<td> <a href="logout.jsp" title="Logout"><img src="images/logout.jpeg" border="0"> </a> </td>
		  		<td><a href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu6, '150px')" onMouseout="delayhidemenu()" title="Chat"><img src="images/chat.jpeg" border="0"></a></td>
			<%
			}
		%>
 </tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table> 
