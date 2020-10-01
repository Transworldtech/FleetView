<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
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
<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">

<%@ include file="Connections/conn.jsp" %>
<%
String useType11=session.getAttribute("TypeofUser").toString();
String targetvalue=session.getAttribute("usertypevaluemain").toString();
String userid=session.getAttribute("user").toString();
//System.out.println(userid);
String targetvalue1=session.getAttribute("usertypevalue").toString();
//System.out.println("Targetvalue1::>>>"+targetvalue1);
ArrayList<String> target=(ArrayList<String>)session.getAttribute("TargetList");
if(target.contains(targetvalue))
{
	%>
	<%@ include file="Menu.html" %>
	<%
}
else
	if(target.contains(targetvalue1))
	{
		%>
		<%@ include file="Menu.html" %>
		<%
	}
else
{
%>
	<%@ include file="Manu.html" %>
<%
}
%>
</head>
<body  onLoad="JavaScript:initRotator(),loadSearchHighlight();" id="mainbody" >


<table border="0" width="100%" align="center">
<tr>
<td>

<div id="header"><div id="logo"><img src="images/TW-MobileEyeLogo1.PNG" alt="Google Apps" height="70" width="100"></div>
<script src="js/dw_rotator.js" type="text/javascript"></script>
<script type="text/javascript">
function initRotator() {
    // arguments: image name, rotation speed, (optional) path to images
    var rotator1 = new dw_Rotator('img1', 1000, "images/");
    // add the images to rotate into that image object  
    rotator1.addImages("l1.jpg","l2.jpg", "l3.jpg", "l4.jpg", "l5.jpg", "l6.jpg", "l7.jpg","l8.jpg","demo.png","foodland.png","FirstFlight.bmp","ndtv.png","darcl.png","DHL.jpg","rpa.jpg","casby.jpg","safeNsecure.png");
    //rotator1.rotate(); // sometimes may want to call rotate here
    dw_Rotator.start();
}
</script>
<div id="logo1"><img name="img1" src="images/l1.jpg" width="100" height="70" alt="Customer Logo" ></div></div>
<div id="navigation"><ul><div id="navigationBlank" style="visibility: visible;">
	<%
			String userID = "";
			userID = session.getAttribute("user").toString();
			if (null == userID || userID=="") 
			{
			%>
				<li class=""><a href="http://www.twtech1.com/" title="About Us" >About us</a></li>
				<li class=""><a href="http://www.mobile-eye.in/contact.html" title="Contact Us">Contact us</a></li>
				<li class=""><a href="http://www.blog.transworld-compressor.com" title="Blog">Blog</a></li>
				<li class=""><a href="index.html" title="Login">Login</a></li>
			<%
			}
			else
			{
			
			if(target.contains(targetvalue) || session.getAttribute("usertypevalue").equals("Castrol EMP VEH"))
				{
					%>
<!--					<li class=""> <a href="onlinedataemp.jsp" title="Home">Home  </a> </li>-->
				<li class=""> <a href="home.jsp" title="Home">Home  </a> </li>	
					<%	
			}
				else
			{
					
				%>
				<!--					<li class=""> <a href="onlinedata.jsp" title="Home">Home  </a> </li>-->
				<li class=""> <a href="home.jsp" title="Home">Home  </a> </li>
				<%
			}
				
				
				
				
				if(session.getAttribute("usertypevaluemain").toString().equals("ALL"))
				{
					%>
					<li class=""><a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu10, '150px')" onMouseout="delayhidemenu()" title="Reports">Report</a></li>
					<%
				}
				else if(session.getAttribute("user").toString().equals("shanker.k@castrol.com") || session.getAttribute("user").toString().equals("santosh.shelke@bp.com"))
				{
					%>
					<li class=""><a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu11, '150px')" onMouseout="delayhidemenu()" title="Reports">Report</a></li>
					<%
				}
				
				
				else
				{
					%>
					<li class=""><a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu1, '150px')" onMouseout="delayhidemenu()" title="Reports">Report</a></li>
					<%
				}
				
				
				
				if(session.getAttribute("usertypevaluemain").toString().equals("ALL") || (session.getValue("usertypevaluemain").toString().equals("Castrol") && session.getAttribute("TypeofUserMain").toString().equals("GROUP")) || (session.getValue("usertypevaluemain").toString().equals("DSC") && session.getAttribute("TypeofUserMain").toString().equals("GROUP")) || session.getAttribute("usertypevaluemain").toString().equals("Castrol EMP VEH") || session.getAttribute("usertypevaluemain").toString().equals("DelEx All")||session.getAttribute("usertypevaluemain").toString().equals("Nawany All")|| session.getAttribute("usertypevaluemain").toString().equals("ACC") ||session.getAttribute("usertypevaluemain").toString().equals("Praxair All"))
				{
				
				%>
 	 			<li class="">  <a href="selectuser.jsp" title="Select User">Select User </a> </li>
				<%
				}
				
				
				//System.out.println(session.getAttribute("usertypevaluemain"));
				//System.out.println(session.getAttribute("TypeofUserMain"));
				if( session.getAttribute("usertypevaluemain").toString().equals("ALL") || session.getAttribute("usertypevalue").toString().equals("Castrol")||session.getAttribute("usertypevalue").toString().equals("TWDEMO")||session.getAttribute("usertypevalue").toString().equals("Castrol-Tanker") || (session.getValue("usertypevaluemain").toString().equals("Castrol")) || (session.getValue("usertypevaluemain").toString().equals("BS")))
				{
					if(session.getAttribute("TypeofUser").toString().equals("SUBUSER"))
					{
						%>
  						<li class=""> <a href="location.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu4, '150px')" onMouseout="delayhidemenu()" title="Location">MyLocation</a> </li>
						<li class=""> <a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu2, '150px')" onMouseout="delayhidemenu()" title="Journey">Journey</a></li>
						<%
					}
					else
					{
						if(useType11.equals("Transporter"))
						{
							%>
						<li class=""> <a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu5, '150px')" onMouseout="delayhidemenu()" title="Journey">Journey</a></li>
								<%
						}
						else
						{
						
						%>
   				    	<li class=""> <a href="location.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu3, '150px')" onMouseout="delayhidemenu()" title="Location">MyLocation</a> </li>
						<li class=""> <a href="report.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu2, '150px')" onMouseout="delayhidemenu()" title="Journey">Journey</a></li>
							
						<%
						}
					}
				}
				if(session.getAttribute("usertypevalue").toString().equals("Foodland") || session.getAttribute("usertypevalue").toString().equals("Test"))
				{
					%>
					<li class=""> <a href="foodlandreport.jsp" title="Temperature Report">Temp. Report</a> </li>
					
					<%
				}
				if(session.getAttribute("usertypevalue").toString().equals("futurelogistics"))
				{
					%>
					<li class=""> <a href="demo1.html" title="Find Shortest Route">Find Route </a> </li>
					<%
				}
				
				if(session.getAttribute("usertypevalue").toString().equals("FUELFLOW"))
				{
					%>
					<li class=""> <a href="fuelflow.jsp" title="Fuel Report">Fuel Report </a> </li>
					<%
				}
				if(session.getAttribute("usertypevalue").toString().equals("IBTEST"))
				{
					%>
					<li class=""> <a href="demo1.html" title="Find Shortest Route">Find Route</a> </li>
					<li class=""> <a href="getlatlong.jsp" title="Find Lat. & Long.">Get Lat.Long </a></li>
					<%
				}
				if(session.getAttribute("displaymenu").toString().equals("yes"))
				{
					%>
  	      		<li class=""> <a href="location.jsp" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu5, '150px')" onMouseout="delayhidemenu()" title="Location">Journey </a> </li>
					<%
				}
				%>
				<li class=""><a href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu8, '150px')" onMouseout="delayhidemenu()" title="Dash Board">Dashboard</a> </li>
				<li class=""><a href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu9, '150px')" onMouseout="delayhidemenu()" title="Entry Forms">Entryform</a> </li>
		  		<li class=""><a href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, menu6, '150px')" onMouseout="delayhidemenu()" title="Chat">Chat</a></li>
			<%
			}
				
		%>
</div>
<div id="navigationRight">
			<li class=""> <a href="logout.jsp" title="Logout">Log Out</a> </li>
		</div>
		</ul>
	</div>
</tr>
</table>


			<!-- header file -->
         
      

         
          <%
try{
	Class.forName(MM_dbConn_DRIVER);
	Connection sessionconn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement sessionst = sessionconn.createStatement();
	Statement stquery11 = sessionconn.createStatement();
	String sessionusername=session.getAttribute("user").toString().toUpperCase();
	String sessionsessionid=session.getId().toString();
	String sessionupdated=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String sessionsql="update t_sessions set Updated='"+sessionupdated+"' where SessionId='"+sessionsessionid+"'";
	
	/*Query to insert query in db_gps.t_sqlquery table*/
	/*String abcd=sessionsql.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery11.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");*/
	
/*****************************/
	sessionst.executeUpdate(sessionsql);
	String sessionlogout="select LoginStatus from t_sessions where Sessionid='"+sessionsessionid+"'";
	ResultSet logout=sessionst.executeQuery(sessionlogout);
	if(logout.next())
	{
		if(logout.getString("LoginStatus").equals("No"))
		{
			%>
			<form name="f1" action="serverMSG.jsp" method="get">
			</form>
			<script>
					document.f1.submit();
			</script>			
			<%
			
		}
	}

	//out.print(sessionsql);
}catch(Exception es)
{
	out.print("Session exception--->"+es);
}
%>
			<!-- body part come here -->
<br><br>